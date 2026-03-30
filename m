Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B731061B03
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 14:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F67683DBF;
	Mon, 30 Mar 2026 16:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rlEOdVbL";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rlEOdVbL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8017783E7A; Mon, 30 Mar 2026 16:32:51 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 610E283D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=eeqedpyf+TZrSWd4bDhNP45/cXNCftimFcsDhlnTTiiyO3xVJcagwEA7cgyIJZMewv2gNJeqjjB+In41nDXK3tmzjlbUHUx7D39i8Pa8ylhdm0+A1AtwrLbZmGo4Yw7g3/Ne0AklBzYvwrfS3n2hmfjs7ybj3Hx4QoOHUmFmfFRVZUUlub9e22mg7uL5yGsl/QHItR8jDVxqgrP3nVLHsxKnJ83b3NIqb8Qq7WaLcEKsyID2jDKepMlvqaxPLbXwI7snH+Nvk+2FrF6pj7g8jtDSdi+Cm7hqBXoE2oyjWu3BZjE60DTEz19fvsjwS8UMFHX3iUXxFBUqjVV41tVlhg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOEBv06zZaQcJt9rzBIBjfakPwsuDj+ZPckv1zLSAoE=;
 b=hVFrC4etBoZFWqUoRSew8RhErpuTDYt6xBBxqNcW1a9el6mPhZ03+OLYMvRNcD/FQVYmi+JgVVgyN+vyxLGk7ahyVmKgZ44lMyUyeZdZmSSZK0j3yphcXWhULVyzRl4sNpWLAD/A7Smr6HNeytpiqiz0j7V7pOXq6T7Q7QLVYuWtqBedjiZKRV2WVEmxpOohUVAMiYFFmq8mOBYW4RscyobGnLcMhkKnnumubsVcIqiF7kP6vsPiTJBGh7bv9i6WganUNqWcg0RLrY73ktdlc3sIbPNqB8OzOpmLGX7Vu6b2xR1OSoDSOR5SLw+BD81s6FucdhkV05B1OhYzgZUSYw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=mailbox.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOEBv06zZaQcJt9rzBIBjfakPwsuDj+ZPckv1zLSAoE=;
 b=rlEOdVbL8WepOUbUP7t76ox762Jjn6TrPwMk+UpDkFXT1n4c16ytbFISG2tqDPnfL9LraEcKuGBf3JKP6dV4uS4mocNcT2z+dv4t+TUF8xxaIeazMWuCCQX3+p/biYKwJlCqTvnTf4QJ1B7oyDPcY4e8WmXnQTz/e/ND+DJKztU=
Received: from DU2P250CA0028.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::33)
 by DU0PR08MB7763.eurprd08.prod.outlook.com (2603:10a6:10:3b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:32:46 +0000
Received: from DU2PEPF0001E9C6.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::1a) by DU2P250CA0028.outlook.office365.com
 (2603:10a6:10:231::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C6.mail.protection.outlook.com (10.167.8.75) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via
 Frontend Transport; Mon, 30 Mar 2026 14:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+bW4e9uGtdCcm2fiAo4RzCIdERmO3ffMyX9IltmXebwR4uMVNQ89+60WZ48d8bXg/f4Gbp8A/goeZho2xnKjtQg0PXWEbKIamMU38zVDZgR8/8mHbnt+2XKzhI6A2KoU7fMcw89QSAuTWH0N0kk758rEoDc1gd/KyH1gDMpmZdaae47fhC9SzqStQs4C4URBSTTMz2pugyPUi/Dg/BBST8R0PcmynB3osMT+NYhlC0wP2uMoMz+U+q2bcyeZvBRgNcnSUF+a/A+9EZ57rsXkbU1xyAK80XqscpgkwJHQg/wvvctws4uSiX9jeELNae1eHE6eioSQRfgg0k8+6mTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOEBv06zZaQcJt9rzBIBjfakPwsuDj+ZPckv1zLSAoE=;
 b=KodbMrotlWdVUNUHwdrpc6C2fbmyg70e+H9JQi3WfLevuNzRn37q667p4pr2d6vV5haH/EaV9juXG0nEtPnTaQhomh6rDV4+BSBZPrNmW2lZqsu2cGasZQYCq6Tl0HIpvcd8xGQiq4EU4UGV+OMkMx8gjIm80ryGbcUolv71gi8hAm6QqgF08q0vA1NeDA8iapwrvbuIXrqG/jGIiOq0bk4DG/nictbAOpawJDEDRxDvIcdBPSfF89tPJR6kuWg65FQztH/u6hw0gkmNDlAgc035HZzx4Fcol8wddiNFZsjnfnzgNvqPTyWwdxdAegH8jgsMkg/qz1FlPNBdh2/7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOEBv06zZaQcJt9rzBIBjfakPwsuDj+ZPckv1zLSAoE=;
 b=rlEOdVbL8WepOUbUP7t76ox762Jjn6TrPwMk+UpDkFXT1n4c16ytbFISG2tqDPnfL9LraEcKuGBf3JKP6dV4uS4mocNcT2z+dv4t+TUF8xxaIeazMWuCCQX3+p/biYKwJlCqTvnTf4QJ1B7oyDPcY4e8WmXnQTz/e/ND+DJKztU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB7306.eurprd08.prod.outlook.com
 (2603:10a6:20b:441::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:31:41 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 14:31:41 +0000
Message-ID: <35491f3b-9b59-495b-bb49-5fb11d83c266@arm.com>
Date: Mon, 30 Mar 2026 16:31:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: rswitch: Avoid NULL pointer dereference during PHY
 access
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Phong Hoang <phong.hoang.wz@renesas.com>,
 Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Thanh Quan <thanh.quan.xn@renesas.com>, Tom Rini <trini@konsulko.com>,
 nd@arm.com
References: <20260325010922.280141-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260325010922.280141-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::8) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB7306:EE_|DU2PEPF0001E9C6:EE_|DU0PR08MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd96fac-0b7f-4f0e-9ed1-08de8e6935cf
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: v+DWaB8K9UOqQz4oljBVbPb3Y+YuR1uVTniv/Uj1PZVllhJSwiG0y7CiYcIfWQM132nJQItQqqSI9dFaVFth7Y5LMCp6OXUZn3lYq5irC4nipKIwtcO0Mc8pPe4MJpfL7VRmBlkEgaXaUdkUEgGy8lH1GVoIVgYMYdcXqlJ+FWj7YXsHHcS2wsIByhBXhGuPmVhbRaKHqyjXknWFL+czoDcj6tuNVEEZ8dMUpJpsdjmywUyTyDN5mM5QpZf72B/ew6hv+t3WHU4kDUFWUATrpySlngaM7dnnMkAK2Rus0MSuIpk4PspsSpIqZP9Yeyo9gV8X5BFTjnNS4vjtnZ61OBwFXCZZle9F+RNj9RyDnY8IusF4HVvQ/kr1QQDOCQkO6bvvJMoiDHpiKULrI00BxwZD9Y3r3h9KwMiBsPAFFMSe3a9f27oOMIF9wdI/az+n6X5vs2Z9leG3VlqEmUdXoB00XjNLjEP6A8Bmbl5qEdw1+oXReXh77pEaJUJxMW36zwaTVBEZ2M2NsAibqg9DyLl/cehRRBuqVOo9HS5yVTXnTzgXSOifYpCUuqluJtPz9sTndYxGR2QXyvIU9ON04i7jGxnwnvQFtnrMeXYAej+xkdkXrhkgL+2KSN5fa8/PAkj0V/Vyk4TiG/hEHrUVJ5FGnliDOx2+IPktD8ux4J1rrObj8xuMdcv5MMifIfGJlsNxR863OhCLf6c7Ad8VE1J59G2zXtTiC3fSBdRh0UA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: oqcDzQBssS8m1IwealB/0Fka0mxhHeytWwafStQQIeJN/DPt5ZbJ09/jsxeEBOTqeMZBlUUND/B5cvNbcbWkD1CxT4yFfWcAZjtyCAQnTp9vqb0dbr3hXir1EUH/ZAbChn/LKjwR/Ykok8Pu6KDqEnViCGzB7EzfeSyr/p7/0XqDaQzqImWotvGppSOzFvSkzhHq3AYNjFMvtDkCzxnZY52ycENO15qtgqNsjGgnSbNoA+AGqHt7Ut84NP9bdj8xk8Icrv15uE5Tix5yeugT1oEI3fuGpAucJUdNyTP5/1V9PA+Qx9nvQBO5qleaSfjmRMCNZKpIKRpmglfAGCTxSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7306
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3ab538bb-6316-49bc-f3ec-08de8e690f9e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|30052699003|35042699022|376014|14060799003|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: FZiC3BcfXb68atktZJqhTK5xl6cNJU6u/GC6xXf6nFdBw3TCfPccmy/dFvarBsWc9zErWvDZcjCBch6554zjuvNP2fZzj4qNlBncFXXM/aDKuOq6WSViMgyc77Ec248FiWLyFmfVON9NXgqhGzW3rIl7igk5WtIVyY4nC+ShrJxZZbojAdoZuwCBPdyj0ObDA0zKvrfmqFBrUNECFCxfPdyv9w46/DFwfrayeOREB0rFL/YiY8GKi8q2PoAWuuXvXIklLqa2BM2VltqA56DAbwDaRKyGbZ918VLA6bOWuh8LNT/xaKDo3JArCr0Pjk/JKGJaOv4zr0wplqHfsRnzP1u8iVI0Y2ychfBnoZ+mdahb9L24zO6quGhXVfbdR9TI/m8DFqxqqiAqFUS0ZhzoyV/nRKauJpd3+XjTpNH0IfDjxAmyXO9Gz1JhjKcz8W15Zo9zAzisXQooS6lWevckFW7v+ihMwAWYz67JqSW75R9BOeuW8fvFBf1S97+q6aTHdXX7X99wFdVc469wyhsstTpKbwsh0la7nDcJkIP6Or8XjtTSChHhhiFgTp1j+LSs6KMR8uy5Xv8zZTOffHH8Wokfqfj8lNNig/sDKc833Aazy8SRPHKgMzf8VMByLmAFIaATWXoGcYqyk6X+Q5aFW0k6M4iZa7zgk/uN5YyXyz/ShAZP8Nhtal0lDt32o51R32dOaSt9hj5H+NiBSvQOOzPl/BP4QInGr44UREgDOtCufXXFpl5cqbQSGo9FGranPKY0SYt1RJOKs+bsxdEAkg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(30052699003)(35042699022)(376014)(14060799003)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2mp5FVhf1m61Hz02nH+74hVTvvTweOFX2unCm0d4B1zL86c7BlUeD6ozJ4A5o51XpbcJo8NUS2ThdWo8IPEuM6vQ6iSu4nAFT2rrmU83mp36qP6A/t87GcbQiaVKPNlNEONehycwsAyalBsgjWXtH7UKFdpi64LeHqlgqZyO2Rok6c1CcFyPoZBceSca7gQiAqjjWoUeSiEQV8MF+XwASTBrDZykwYn5aQAq7IRKF3ajYoHNuxXuKdvpRJbyjLfcwYMjDxrpteVQi2urfi4QDZWPuU2mMKkKfmO/vtOHvJlYCzFqUUtm+bqRThvuzFGRYb7S9P9SaenTcjSo1L9mqYORkfUohhgYC7HDMK2bYZydJTbTEpG7X5AJ5u4XNtRwUjLvAXJkHXqKEx/wFyRguIW1sd6x0ubXzTJFOhWH6BhkBpaHcM6xmRTxQasNsrm8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:32:45.7623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd96fac-0b7f-4f0e-9ed1-08de8e6935cf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7763
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 25/03/2026 02:09, Marek Vasut wrote:
> At the very early stage when PHY ID is being auto-detected, the
> PHY device is not yet instantiated and rswitch_etha .phydev is
> still NULL. Add missing check for this condition and perform C22
> fallback access in this PHY ID auto-detection case.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Phong Hoang <phong.hoang.wz@renesas.com>
> Cc: Tam Nguyen <tam.nguyen.xa@renesas.com>
> Cc: Thanh Quan <thanh.quan.xn@renesas.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/net/rswitch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Added to net-next, thanks!

-- 
Jerome

> diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
> index 801c22bbdc7..c51908ed8f3 100644
> --- a/drivers/net/rswitch.c
> +++ b/drivers/net/rswitch.c
> @@ -482,7 +482,7 @@ static int rswitch_mii_read_c45(struct mii_dev *miidev, int phyad, int devad, in
>  	/* Access PHY register */
>  	if (devad != MDIO_DEVAD_NONE)	/* Definitelly C45 */
>  		val = rswitch_mii_access_c45(etha_mii, true, phyad, devad, regad, 0);
> -	else if (etha->phydev->is_c45)	/* C22 access to C45 PHY */
> +	else if (etha->phydev && etha->phydev->is_c45)	/* C22 access to C45 PHY */
>  		val = rswitch_mii_access_c45(etha_mii, true, phyad, 1, regad, 0);
>  	else
>  		val = rswitch_mii_access_c22(etha_mii, true, phyad, regad, 0);
> @@ -516,7 +516,7 @@ int rswitch_mii_write_c45(struct mii_dev *miidev, int phyad, int devad, int rega
>  	/* Access PHY register */
>  	if (devad != MDIO_DEVAD_NONE)	/* Definitelly C45 */
>  		rswitch_mii_access_c45(etha_mii, false, phyad, devad, regad, data);
> -	else if (etha->phydev->is_c45)	/* C22 access to C45 PHY */
> +	else if (etha->phydev && etha->phydev->is_c45)	/* C22 access to C45 PHY */
>  		rswitch_mii_access_c45(etha_mii, false, phyad, 1, regad, data);
>  	else
>  		rswitch_mii_access_c22(etha_mii, false, phyad, regad, data);

