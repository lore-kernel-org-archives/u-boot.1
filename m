Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB75109B46F
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 14:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA95183DA6;
	Tue, 31 Mar 2026 16:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="EG22io1t";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EG22io1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BCF184010; Tue, 31 Mar 2026 16:42:21 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FC7083A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 16:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=B8Pbs1I7ibIvT/XaC3z8SxQ58DpU8A4yN4qeEbAmxNEQnU74ZDTrFDzLv9LPqZzCUNvz1LtQfwOKVcZPZQlKdTcx38PhLMLNWvawz/TdIMLAXGhViE+tBUTRgjQK2CIanfSxSXFNDpm4L3MNnVYZMwqwdlzDs4Oi/SbGBN1UdgXH5dGcqnXSk5Ahlf6U2wuCpMjOszgYrhExZ+ntZ9/bwWj1ZVHt56ILfmHHWI9lbr7utXFRLkhBf2VhZD3arcoJ3hC0DOOKBv5Wg1jvaZzeMVAc4yePNwEXAiinJ8EmgJ/E1JnBm4pNq9+daWHpAHMw3NOj5Su26GMjQ0IQLZCFIg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Yktqj67Jin4NgpJuVjFAQLEW5XYucNCQTjfXPmR768=;
 b=VW0bHAkhoHij0wtG/METfydVtdDtoEvaGrRGE54TB70igcbkgo/vewhqQw4mETiTDdfRxfYZFu2YihP0hN0SKySPsDagL13GeSHxDb+yxg0DJs7kYRJCJwF08UMqiQGAHhOxBZTQSgF3IOdmyKy6mgy3aOCWhBuljNoWgV+me5mY/tB1s5JYxHLXH2KFv2173CAPzBpif7amxwjdyt5F9OWbC4h6tbKOy6LFcMpA1hnFUxvd18VEsjx+YGnpBbE+HC/uAmTDL7goZpOlDa87GkXaEyR+MlqU2nvjI3Ldw5oqdFCM+CQ8ITDcG/cl9l/xL3kh6CzPCDiR9Fxr2NjIvA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=mailbox.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Yktqj67Jin4NgpJuVjFAQLEW5XYucNCQTjfXPmR768=;
 b=EG22io1t21DTS19wewOjNWs59jBN1nYgQan3g7ofAcadDKLMm18cxSI9uZXTsSulzGcwjvy131XQ5hIcK4rkyKvV293fUwdZHS8foqaXYsESNr0kiVMnBLOTietDsp55UgdQh5qGNQygnvcZC28h2j2wGSy10klc82/3i662qv8=
Received: from AS4P192CA0026.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::10)
 by AM8PR08MB5668.eurprd08.prod.outlook.com (2603:10a6:20b:1d0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 14:42:13 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::6a) by AS4P192CA0026.outlook.office365.com
 (2603:10a6:20b:5e1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 14:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 14:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7cQKBhik/NVbtrIDmb+qmnA+t6EJnFPZSM3m/GircR/a22RRb8Q7PVAqtcT5wsG4SVqV0klaiCinBI2/hRPM0louGblBbwqc1f0Jpmg+Ly0BbNukvnDTPW9eSXi78P9usJKP12pPTTruvcC0KXIgjjbWVomdCDBxj/54GlJiPC3xkh9bSwqblH7O4CFk+cImhciMlCsY5i2rGHNQQsVbqBfvHOz7ecGIM3xz3bkNRvt3Fx2wh6XF3HyWt1E0vHAgm4AADAdP4qJRjE2P7pSbRCBKUh8+le1ED+81SbDXSxzE00BcsyoBJc0dUqC2ZI9kJq5HSFjZp2MW4M3cl1WPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Yktqj67Jin4NgpJuVjFAQLEW5XYucNCQTjfXPmR768=;
 b=PVNZD32N3kZRc/nHNv3JlIAS5j0O4Mv62/UM0Y9Ubd1wsCSMkO2XWO9qSIiV4joG8Dt8IN5/hCN9yRqs1Qjh9Xlkc7X34tYViLveKKfoJ0rxof5isJcVyUYBNoQQKeMGrEVMpQlh2PEKpghiz348N5LECelYFJ2JqoV55EjMCoLUIQ0U5LYkCFiXsKhoUMD+Xuf1qxsEPLQAxoBb/uag4Z1UnRpdnmBny216m/cRWO2MzbWknjc9tJ5OFcKXddVFguS2W3apL6jLYeg1y/DVub0Dybwcj1VZ0YbZaXQchNH1Nc82fND/xLmTJTfS2F+ihN4GGo0o01d1dwFtOZO4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Yktqj67Jin4NgpJuVjFAQLEW5XYucNCQTjfXPmR768=;
 b=EG22io1t21DTS19wewOjNWs59jBN1nYgQan3g7ofAcadDKLMm18cxSI9uZXTsSulzGcwjvy131XQ5hIcK4rkyKvV293fUwdZHS8foqaXYsESNr0kiVMnBLOTietDsp55UgdQh5qGNQygnvcZC28h2j2wGSy10klc82/3i662qv8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI0PR08MB10710.eurprd08.prod.outlook.com
 (2603:10a6:800:207::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Tue, 31 Mar
 2026 14:41:10 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 14:41:10 +0000
Message-ID: <d12092c4-8b10-46f0-8131-a9318edc9287@arm.com>
Date: Tue, 31 Mar 2026 16:41:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: rswitch: Remap CPU to bus addresses using
 dev_phys_to_bus()
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Phong Hoang <phong.hoang.wz@renesas.com>,
 Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Thanh Quan <thanh.quan.xn@renesas.com>, Tom Rini <trini@konsulko.com>,
 nd@arm.com
References: <20260325011119.287660-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260325011119.287660-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0009.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI0PR08MB10710:EE_|AM4PEPF00027A69:EE_|AM8PR08MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b29eb5a-e461-42d7-139a-08de8f33b23b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: peV2tK7z7tna6m+W4ERggFKWdi/zh6KHvpM+ExX+Kk4+nJ3TkCyOg9UzkUwZxUxUF39pOjww2HASnd/1eMMH/5+DGu9g2v05Yqh8WL4F1hb0f+JP/bCxtDaeV5wRMjWj6iQar+SiohALNhcz+MwMND541b06pkTfbgjRFhtIGIIWaCD137feUnEmgTejlq2csroEEM+DAHtxvKVgDODcIVguJjL6kjphFslGvuT/hrEUuZ+68XucGbFpg2baNYnSyKdOdPy4AeD1T+U37upjAyV+fLNe0LFZpNpD+YCvDRFPT7q4VPeYUQ63/DfAh95EkX0VI1ht42kWkjSImgQdCXQEXfXfyW6l6hqx8jvcjaqnC2XF/y5q+cWWCg3gyzgjn7AsXlZiHAPUaPGAHXo3y/BpHrrkRPidUW64UkASBXPhnWDMPTv8ZhL+1zxo0wo1c+cvz2dwLOZWsQGP6uZYfWTiFsZUKRMu5IT6fIRcNfXmfR6z0v8eb8xHYiGkGAfTkR3dWZxytmQnu+8VrWpWMOO45fCgR7UyzSf1tVmFKAQGa9Nlrhp97HV8X376ZC0lNccLY8N18N8nhO/2FN13fH539VZ0MqJkw51K5DCt2h+VQ0jjlQTeLh21mAive6goFTjsbffu44ubF4a1v+FSvh3UZFIkEjElTEPdxUiE7MNzpSNXb4Z/t8pjQmQSh5ReireH9VBtNFYrCTkDJt2LmJVJbgO1daRdFv9uOG2CAg0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: RJ9jusH9T8vzicOvGxnZXp4LGwEi1wMqqsWOtOxxuZ86/HfAPAsPSDtRowm3jRJCid/BKVcyIPf8h28IbDbDBJL++P5sYtNONac7xh5vd7Olb+138QNzg8iDh7a00V/ZswJPIis87ho9kx6HfvqQcRHlU0wPBqgz8jY0jAnCujdrrfVhrG8ufX21OHqKrD/xsVcrrIs9CgVNON/DKDZjIpRbSHGkFbAKNb3d3KB5kqi18fm8Z1+XWNC/yzA+r8BjmtGHRSJ/XMD0psRQD1qlzw1ArRejdpYCJUh822h4hsJ8dgpM6U3YpkJSvpGRoee9X+1Pm9AwHZBnNkQ5LHNtqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10710
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c8434245-2434-4e8b-7b5d-08de8f338caa
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|14060799003|35042699022|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6JwG9tWcepEbRgDALqq+rL321oembVtIYeIjDnQPpd7rrp51/IoVWaA3huZ8Mdu4vlve4ItrU7S5eO3nRyFlRNaV84KblAyoJUFY5OQqkcQbuEe6+V7ETpt6U74yWnlBx8MjbLXVwjFna8xe8yTbpohlLkB1VpfFILKA36IqgzXrLV55cLgfKt7/WWH+6vREPgeQe9OAK0jyN4rSP9aUQ/gCg83JGaRFk8pcxpvZE51NzPV/maxN55xv/b8jeie/35VxsTsWW/ZHhgQm7+uMjLRAI48cNORiRJ9vN/ZBbQOYrTO2jr/7uwg972Q5v0BIFUPwpk1B7bTXGLqepnfeunei2xmPC62u536qeaRN97O92HVTMFjsdR0D/lv6gCWXk0jyCTDvwuK66DWCJumOijD8jWDsCeCrA6c+ikFVdJJWcMfRxmdhE7cFj1/F6XraFLO15zBSlbSZk55gIOvXqgk2qtmWyyqWhYAP4q+c+vYlUOCXcbHA79LE87fdNnuepmODT3KbiTLMbVhS1EUXRVodE+3NpeeNL6zcMBrX//OuHJBALCbQfiXfTnySQUXdS2XoKEnCOLm2dszQxUmEzaPcGuqbEQL51n0KQHM8srqprpoMbWzdW01U8/Z8k7BWblP/7Se3BSo/zKnqO4+rJ4HuxRPVjksZUxg/kTxRDBPS+CVSZhkua058IDMq5CgRyB+kjB2jq22pwMsCKZBJi6QbRVT9CC6dmRurdVqFc02yUU4H2OFQgJr0xvkeGMJefK/4CKkt01ygDyz6sat15w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(14060799003)(35042699022)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XcSb+rHhGnlzqtnYztTrYBZocnAC7qGhu7OU4F5CeO7C7OT9opVfYRjyPaIe8kAYiKxE26TfmETgqiwdWrRoifjTx4Km2WT1Sqbq6cvGsa0jCErtJoZzHNa9rK2E9KIOiWc1s9C49WJUsO2oLAK+sa5QL1dGjJiTmnmZn5Qk5WyW3B56F7dxYH+NVk3EsSNl4M1lmtRuXzNRcTI5ulniUMWpvD+gp7cWMrSb29RDCMcstrYidyXfXVfREv8Q+mzqAM7o7HtCBF+CR4JJFWXsXCiI+vObT4H/YV9GC35XaSwpKNjyriv1fJ2tvNxlNHtO67OkvZiP9CjraIoUyJby8oPfSRWFS4e6nBykqGCF0WNDfNCVLCHGjakp7KlA+g+fOtdMF1TYV08TqGlzRD4ER0Jts7OIFg18h2nKe2q/kNfqUNA1OOPy0USkCL/Drp9q
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:42:12.8475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b29eb5a-e461-42d7-139a-08de8f33b23b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5668
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

On 25/03/2026 02:10, Marek Vasut wrote:
> Use dev_phys_to_bus() to convert CPU addresses of DMA descriptors
> into bus addresses of DMA descriptors. This is necessary on hardware
> which does not have 1:1 mapping between CPU and memory addressed by
> the DMA. This has no impact on other hardware which does not need
> this conversion.
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
>  drivers/net/rswitch.c | 80 ++++++++++++++++++++++++-------------------
>  1 file changed, 44 insertions(+), 36 deletions(-)

Added to net-next, thanks!

-- 
Jerome

> diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
> index c51908ed8f3..52fc3edd4e0 100644
> --- a/drivers/net/rswitch.c
> +++ b/drivers/net/rswitch.c
> @@ -9,6 +9,7 @@
>  
>  #include <asm/io.h>
>  #include <clk.h>
> +#include <cpu_func.h>
>  #include <dm.h>
>  #include <dm/device-internal.h>
>  #include <dm/device_compat.h>
> @@ -23,6 +24,7 @@
>  #include <log.h>
>  #include <malloc.h>
>  #include <miiphy.h>
> +#include <phys2bus.h>
>  
>  #define RSWITCH_SLEEP_US	1000
>  #define RSWITCH_TIMEOUT_US	1000000
> @@ -587,9 +589,11 @@ static void rswitch_bat_desc_init(struct rswitch_port_priv *priv)
>  	rswitch_flush_dcache((uintptr_t)priv->bat_desc, desc_size);
>  }
>  
> -static void rswitch_tx_desc_init(struct rswitch_port_priv *priv)
> +static void rswitch_tx_desc_init(struct udevice *dev)
>  {
> +	struct rswitch_port_priv *priv = dev_get_priv(dev);
>  	const u32 desc_size = RSWITCH_NUM_TX_DESC * sizeof(struct rswitch_desc);
> +	dma_addr_t tx_desc_ba;
>  	u64 tx_desc_addr;
>  	int i;
>  
> @@ -603,21 +607,25 @@ static void rswitch_tx_desc_init(struct rswitch_port_priv *priv)
>  	/* Mark the end of the descriptors */
>  	priv->tx_desc[RSWITCH_NUM_TX_DESC - 1].die_dt = DT_LINKFIX;
>  	tx_desc_addr = (uintptr_t)priv->tx_desc;
> -	priv->tx_desc[RSWITCH_NUM_TX_DESC - 1].dptrl = lower_32_bits(tx_desc_addr);
> -	priv->tx_desc[RSWITCH_NUM_TX_DESC - 1].dptrh = upper_32_bits(tx_desc_addr);
> +	tx_desc_ba = dev_phys_to_bus(dev, (phys_addr_t)tx_desc_addr);
> +
> +	priv->tx_desc[RSWITCH_NUM_TX_DESC - 1].dptrl = lower_32_bits(tx_desc_ba);
> +	priv->tx_desc[RSWITCH_NUM_TX_DESC - 1].dptrh = upper_32_bits(tx_desc_ba);
>  	rswitch_flush_dcache(tx_desc_addr, desc_size);
>  
>  	/* Point the controller to the TX descriptor list */
>  	priv->bat_desc[RSWITCH_TX_CHAIN_INDEX].die_dt = DT_LINKFIX;
> -	priv->bat_desc[RSWITCH_TX_CHAIN_INDEX].dptrl = lower_32_bits(tx_desc_addr);
> -	priv->bat_desc[RSWITCH_TX_CHAIN_INDEX].dptrh = upper_32_bits(tx_desc_addr);
> +	priv->bat_desc[RSWITCH_TX_CHAIN_INDEX].dptrl = lower_32_bits(tx_desc_ba);
> +	priv->bat_desc[RSWITCH_TX_CHAIN_INDEX].dptrh = upper_32_bits(tx_desc_ba);
>  	rswitch_flush_dcache((uintptr_t)&priv->bat_desc[RSWITCH_TX_CHAIN_INDEX],
>  			     sizeof(struct rswitch_desc));
>  }
>  
> -static void rswitch_rx_desc_init(struct rswitch_port_priv *priv)
> +static void rswitch_rx_desc_init(struct udevice *dev)
>  {
> +	struct rswitch_port_priv *priv = dev_get_priv(dev);
>  	const u32 desc_size = RSWITCH_NUM_RX_DESC * sizeof(struct rswitch_rxdesc);
> +	dma_addr_t packet_ba, next_rx_desc_ba, rx_desc_ba;
>  	int i;
>  	u64 packet_addr;
>  	u64 next_rx_desc_addr;
> @@ -631,26 +639,29 @@ static void rswitch_rx_desc_init(struct rswitch_port_priv *priv)
>  		priv->rx_desc[i].data.die_dt = DT_FEMPTY;
>  		priv->rx_desc[i].data.info_ds = PKTSIZE_ALIGN;
>  		packet_addr = (uintptr_t)priv->rx_desc[i].packet;
> -		priv->rx_desc[i].data.dptrl = lower_32_bits(packet_addr);
> -		priv->rx_desc[i].data.dptrh = upper_32_bits(packet_addr);
> +		packet_ba = dev_phys_to_bus(dev, (phys_addr_t)packet_addr);
> +		priv->rx_desc[i].data.dptrl = lower_32_bits(packet_ba);
> +		priv->rx_desc[i].data.dptrh = upper_32_bits(packet_ba);
>  
>  		priv->rx_desc[i].link.die_dt = DT_LINKFIX;
>  		next_rx_desc_addr = (uintptr_t)&priv->rx_desc[i + 1];
> -		priv->rx_desc[i].link.dptrl = lower_32_bits(next_rx_desc_addr);
> -		priv->rx_desc[i].link.dptrh = upper_32_bits(next_rx_desc_addr);
> +		next_rx_desc_ba = dev_phys_to_bus(dev, (phys_addr_t)next_rx_desc_addr);
> +		priv->rx_desc[i].link.dptrl = lower_32_bits(next_rx_desc_ba);
> +		priv->rx_desc[i].link.dptrh = upper_32_bits(next_rx_desc_ba);
>  	}
>  
>  	/* Mark the end of the descriptors */
>  	priv->rx_desc[RSWITCH_NUM_RX_DESC - 1].link.die_dt = DT_LINKFIX;
>  	rx_desc_addr = (uintptr_t)priv->rx_desc;
> -	priv->rx_desc[RSWITCH_NUM_RX_DESC - 1].link.dptrl = lower_32_bits(rx_desc_addr);
> -	priv->rx_desc[RSWITCH_NUM_RX_DESC - 1].link.dptrh = upper_32_bits(rx_desc_addr);
> +	rx_desc_ba = dev_phys_to_bus(dev, (phys_addr_t)rx_desc_addr);
> +	priv->rx_desc[RSWITCH_NUM_RX_DESC - 1].link.dptrl = lower_32_bits(rx_desc_ba);
> +	priv->rx_desc[RSWITCH_NUM_RX_DESC - 1].link.dptrh = upper_32_bits(rx_desc_ba);
>  	rswitch_flush_dcache(rx_desc_addr, desc_size);
>  
>  	/* Point the controller to the rx descriptor list */
>  	priv->bat_desc[RSWITCH_RX_CHAIN_INDEX].die_dt = DT_LINKFIX;
> -	priv->bat_desc[RSWITCH_RX_CHAIN_INDEX].dptrl = lower_32_bits(rx_desc_addr);
> -	priv->bat_desc[RSWITCH_RX_CHAIN_INDEX].dptrh = upper_32_bits(rx_desc_addr);
> +	priv->bat_desc[RSWITCH_RX_CHAIN_INDEX].dptrl = lower_32_bits(rx_desc_ba);
> +	priv->bat_desc[RSWITCH_RX_CHAIN_INDEX].dptrh = upper_32_bits(rx_desc_ba);
>  	rswitch_flush_dcache((uintptr_t)&priv->bat_desc[RSWITCH_RX_CHAIN_INDEX],
>  			     sizeof(struct rswitch_desc));
>  }
> @@ -741,9 +752,11 @@ static int rswitch_gwca_axi_ram_reset(struct rswitch_gwca *gwca)
>  					RSWITCH_SLEEP_US, RSWITCH_TIMEOUT_US);
>  }
>  
> -static int rswitch_gwca_init(struct rswitch_port_priv *priv)
> +static int rswitch_gwca_init(struct udevice *dev)
>  {
> +	struct rswitch_port_priv *priv = dev_get_priv(dev);
>  	struct rswitch_gwca *gwca = &priv->gwca;
> +	dma_addr_t bat_desc_ba;
>  	int ret;
>  
>  	ret = rswitch_gwca_change_mode(priv, GWMC_OPC_DISABLE);
> @@ -765,9 +778,11 @@ static int rswitch_gwca_init(struct rswitch_port_priv *priv)
>  	/* Setting flow */
>  	writel(GWVCC_VEM_SC_TAG, gwca->addr + GWVCC);
>  	writel(0, gwca->addr + GWTTFC);
> -	writel(upper_32_bits((uintptr_t)priv->bat_desc) & GWDCBAC0_DCBAUP,
> +
> +	bat_desc_ba = dev_phys_to_bus(dev, (phys_addr_t)(priv->bat_desc));
> +	writel(upper_32_bits(bat_desc_ba) & GWDCBAC0_DCBAUP,
>  	       gwca->addr + GWDCBAC0 + priv->drv_data->gwdcbac_offset);
> -	writel(lower_32_bits((uintptr_t)priv->bat_desc),
> +	writel(lower_32_bits(bat_desc_ba),
>  	       gwca->addr + GWDCBAC1 + priv->drv_data->gwdcbac_offset);
>  	writel(GWDCC_DQT | GWDCC_BALR, gwca->addr + GWDCC(RSWITCH_TX_CHAIN_INDEX));
>  	writel(GWDCC_BALR, gwca->addr + GWDCC(RSWITCH_RX_CHAIN_INDEX));
> @@ -844,8 +859,9 @@ static int rswitch_etha_init(struct rswitch_port_priv *priv)
>  	return 0;
>  }
>  
> -static int rswitch_init(struct rswitch_port_priv *priv)
> +static int rswitch_start(struct udevice *dev)
>  {
> +	struct rswitch_port_priv *priv = dev_get_priv(dev);
>  	struct rswitch_etha *etha = &priv->etha;
>  	int ret;
>  
> @@ -875,8 +891,8 @@ static int rswitch_init(struct rswitch_port_priv *priv)
>  		return ret;
>  
>  	rswitch_bat_desc_init(priv);
> -	rswitch_tx_desc_init(priv);
> -	rswitch_rx_desc_init(priv);
> +	rswitch_tx_desc_init(dev);
> +	rswitch_rx_desc_init(dev);
>  
>  	rswitch_clock_enable(priv);
>  
> @@ -886,7 +902,7 @@ static int rswitch_init(struct rswitch_port_priv *priv)
>  
>  	rswitch_mfwd_init(priv);
>  
> -	ret = rswitch_gwca_init(priv);
> +	ret = rswitch_gwca_init(dev);
>  	if (ret)
>  		return ret;
>  
> @@ -897,23 +913,12 @@ static int rswitch_init(struct rswitch_port_priv *priv)
>  	return 0;
>  }
>  
> -static int rswitch_start(struct udevice *dev)
> -{
> -	struct rswitch_port_priv *priv = dev_get_priv(dev);
> -	int ret;
> -
> -	ret = rswitch_init(priv);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
>  #define RSWITCH_TX_TIMEOUT_MS	1000
>  static int rswitch_send(struct udevice *dev, void *packet, int len)
>  {
>  	struct rswitch_port_priv *priv = dev_get_priv(dev);
>  	struct rswitch_desc *desc = &priv->tx_desc[priv->tx_desc_index];
> +	dma_addr_t bpacket = dev_phys_to_bus(dev, (phys_addr_t)packet);
>  	struct rswitch_gwca *gwca = &priv->gwca;
>  	u32 gwtrc_index, start;
>  
> @@ -923,8 +928,8 @@ static int rswitch_send(struct udevice *dev, void *packet, int len)
>  	memset(desc, 0x0, sizeof(*desc));
>  	desc->die_dt = DT_FSINGLE;
>  	desc->info_ds = len;
> -	desc->dptrl = lower_32_bits((uintptr_t)packet);
> -	desc->dptrh = upper_32_bits((uintptr_t)packet);
> +	desc->dptrl = lower_32_bits(bpacket);
> +	desc->dptrh = upper_32_bits(bpacket);
>  	rswitch_flush_dcache((uintptr_t)desc, sizeof(*desc));
>  
>  	/* Start transmission */
> @@ -954,6 +959,7 @@ static int rswitch_recv(struct udevice *dev, int flags, uchar **packetp)
>  {
>  	struct rswitch_port_priv *priv = dev_get_priv(dev);
>  	struct rswitch_rxdesc *desc = &priv->rx_desc[priv->rx_desc_index];
> +	dma_addr_t dpacket;
>  	u8 *packet;
>  	int len;
>  
> @@ -963,7 +969,9 @@ static int rswitch_recv(struct udevice *dev, int flags, uchar **packetp)
>  		return -EAGAIN;
>  
>  	len = desc->data.info_ds & RX_DS;
> -	packet = (u8 *)(((uintptr_t)(desc->data.dptrh) << 32) | (uintptr_t)desc->data.dptrl);
> +	dpacket = ((u64)(desc->data.dptrh) << 32) | (u64)(desc->data.dptrl);
> +	packet = (u8 *)(uintptr_t)dev_bus_to_phys(dev, dpacket);
> +
>  	rswitch_invalidate_dcache((uintptr_t)packet, len);
>  
>  	*packetp = packet;

