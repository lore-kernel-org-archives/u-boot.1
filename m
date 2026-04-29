Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC7CFF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 07:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B58F846E2;
	Wed, 29 Apr 2026 09:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="NtBGTyFk";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NtBGTyFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 015AC846EB; Wed, 29 Apr 2026 09:25:57 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F1F6846DF
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 09:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=i0qvSjuUTHuiaU99yCGggNvoh+GefB0sE7EkWQl/UDOksyZg77w/iiDVzHwehF/NMe5a0k8x0eIPB8hJ4UpOH8Av8e69i77wOJsDI6JsWlBFSTgzRckxLOy10pjELalm1MKWwKnvTvNQhkGjZkxxU1m4M8Ze8L71CxCS31LgdDKhYJ5QSxPzAqWDQoFhgxtRHyYhMgn/vhBCMvtlaH89ejkujSAiCHOYCei5eZsstqXa2kSGkmuF5QSFkkKN4SENYFyXTNjMKw+E1QRvTmYkbVsm5NJ8lZxcxlpRaaFwl6i84PNbOIjj9kA62xa0vOUP24ON9C0Qis8LQ/Yk8vY5Qg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULaF5JmoHIipZ8nLqKHGnSCcGOV5Fhgy14QrzMunbDc=;
 b=lYHEdRPwC0xnYPsXIMGjL8uzGDlV5ELpvcKT8RQ3xo9kP0vzKEagBviHF7dxgWnOVlMv3FpSG1JvBI8lAUiVKiTZIygkhHULlNI0GnAmgfhlMwMI4DXD76lvkKBrXkeGCASVMKTzAT2q6B1tpw4lt6JwGsNApYoG4qbWeJXAr84EY5EEPoVUkKufPJFZa+SgGiMwswJUJjyvP1ABGZd02X1IZL5JJqhRgaQ0WMolIybFPRmTYqF9u9gxjDEgNSjzBBqB+uOWkSOdMshCk6ay6X6d5Wx7o/1/ekWbIKkU6Lqm2pvis1KcGMeM8oOTPzdB1UorJrSrXpnJh8mQEBbGAA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=canonical.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULaF5JmoHIipZ8nLqKHGnSCcGOV5Fhgy14QrzMunbDc=;
 b=NtBGTyFkgqBnK48veJTaBeQ0a3XbnA3h0odDln6OsSHZCDJ9SHadoDL2joDgTPGQqVBEc0SOPwwsm3hsDwai35z1kHZBtB16p284Vzx6AeIEn5JGjVigOIMtmYaYQWy3W/Sm0zHpQLIicZej+V/pWIOfQlPQeijY3HsZ8xnHhAc=
Received: from AM8P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::33)
 by AS8PR08MB6199.eurprd08.prod.outlook.com (2603:10a6:20b:296::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 07:25:51 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:20b:219:cafe::8a) by AM8P190CA0028.outlook.office365.com
 (2603:10a6:20b:219::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 07:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Wed, 29 Apr 2026 07:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGiIDaRpJ42WxF4RfPH5ZIlmZrOtzBOVUs5QnvlTDx8/t3ZUeA+wWPUzqzHwiMCksphfU/KX16AhlVcqJSiMJIBUy++GQJzDlpNaHkFMn9pAOvloZPIIt85hLZNDSjxih3fHFR50dyDAwU0OJ2I9wVCRRWuG4GFdOiEn5eL0ucgvwsyzBhJOCkwcuqPUYcXEwXNVRtG6LmoCWIWuK5UNE1K1mNCYnrKEtovFLXksWo5Kb4wv8s2Zvuw/hXQEiFslJynpqI+rkloJ+lMP1SPyPgU4yxvL48BENpA3yhbj/ZUlbnI1Km80Pg2l/A/P6kybZjl7YlTGzCdZOjqqLkhJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULaF5JmoHIipZ8nLqKHGnSCcGOV5Fhgy14QrzMunbDc=;
 b=m/Rv/iYK0pyM4+TOMMpM03x4GkC+ri0TEZltq+Cv3hjg7H1nj92f2yejCXLKrJV+kuEGYrYZQkcpntnpzCN5jWOsC+Ps+E7LoMX0WE4UXbCoqcVdCMy6IxueErK4gYnctAw3xp+z2LJXK/iQwH3C/v6YpaIWQorKTzDJPthUATLXhy4vL+Jh+kyP4Cp+RfhtV6Ms9mfHgjBZrzaZBsMvIc+fvjYNUvB1zRJQI/8anItyp30WBsu72AtKvGSXBPvP6benUiNh+D/8QZWL2D9ra0F7xq6Xq7q+2nVTnuk0Dcu7TWcg5/qHIDf6aMZtCX9MjTwnutUK7Q6mHE4I9ZMWrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULaF5JmoHIipZ8nLqKHGnSCcGOV5Fhgy14QrzMunbDc=;
 b=NtBGTyFkgqBnK48veJTaBeQ0a3XbnA3h0odDln6OsSHZCDJ9SHadoDL2joDgTPGQqVBEc0SOPwwsm3hsDwai35z1kHZBtB16p284Vzx6AeIEn5JGjVigOIMtmYaYQWy3W/Sm0zHpQLIicZej+V/pWIOfQlPQeijY3HsZ8xnHhAc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB9558.eurprd08.prod.outlook.com
 (2603:10a6:10:44d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 07:24:44 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 07:24:44 +0000
Message-ID: <603b3add-978d-4b42-b406-2b346294d047@arm.com>
Date: Wed, 29 Apr 2026 09:24:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: lwip/wget: missing linefeed in diagnostic output
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 nd@arm.com
References: <20260428181434.179888-1-heinrich.schuchardt@canonical.com>
 <20260428181434.179888-2-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260428181434.179888-2-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3PR09CA0023.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::28) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB9558:EE_|DB5PEPF00014B8E:EE_|AS8PR08MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a808a9-61d3-4931-472b-08dea5c08a44
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: SLfBTjGao8pFw8lYwx8WWVr3y+kI/MnEncM039QA+8jszomwn9yxEgQpA1jVdkvWZX0LdPibN7jtU7aaTwv4hcnmkLRJ4cEIwiPfLaWkwfxJHKwSvD7lrY5NT9NdR1NH+cD2dB+ngsloeU9WPn66ANnRy6KxPcSg4t48gykElFgJXH20kjlmWs1WW7t0Cqn3kEYN7Fz/RR3Tzwd9MHPwulBFYo4gGyHydYGL2BJljfzCVG5kkEbWAHjDY2/gfby7tNJuXZrJcFSmCwDWRVFX29p+oQNzKJigaBzD8UTZ+0Tt7Vw+4qzR6thSVl7DeaJdTy3djO7gCK0UECncmY/HXBFWKlhqUCrvGcFaiiowkdYQQ0AZujF6eaM82Zo9YqrLAba8SbIi2uEUWIi5+imEckDmXTGByFAzk4mU616E2B5N83t6so7IRHZRYkeGMeV9j53y7fvnOqszlO0CahrbuC3HjXeF7l44Kb1I6pftgj/pUZJguELGl/510DtbU7sygwU46ghyMVJW1C6V6ap8cAMfLkHYTyXE87jdpu/xedIOacoEprPi/3Ibm07SmDkRTLHAwE0MMSJQtMoj+ryG39ID5kxfhWZH+vmRnvFQihiCMPBW7L0IS92SCFfde0pAOSQpLybm7hyueSK4tAzqEXLZKf21p9a71G3xRaWZfoixrKDUEVCgH3vZPlx6PBpz
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: BVCeKU72qFcUvVuVbdiIJ0PK1HsOveDJpC6yn7NZ/nMTDAwlY+0dA/8k46Q1Fk8Al4KL/dxdZ6gzgMQm5by/PVbkPvDDVpp/PyWRvhPolUMe9XBFGKKpsEubG1YaHVpuOdVVo5x8KzzPWwC+zEVBUb8q5HySfFkmC/s3Q/a7Q6hXGms8W2Ist1tyWLjySFXQjEug07kkJzi6/5KDzUmwwTzuMcRtBvgD6naArlz5E6JH9nRfTpOxMc+JVASgXV0IdurmniWirBb3BdqW2tJxRcanaXTkd8pzOe3ebJ4LjkdD2XYiUF6h3B37Tev6CS5TZrpYDTllQVxxYHjlftmC+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9558
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4d2025ee-d589-4f87-9a3c-08dea5c06305
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|14060799003|1800799024|35042699022|82310400026|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: +aOd6gt+aOjFCWvcGYiY+o1U+WDosn09UEDCOH4BggvTg4XvEorfAk54BOQhn1PCmf4XA/MZZzK7NcmLUEN/9OHVh/uEOt6qI5OiRKuS4bNTnXboJd5lsyhXSii1lhMYb7wNsvQVl8dXDNb1nNvM9ihPcR/fbC3NFxuDUZWj47tTAJTIuAjwIGNfp5yZU8aisdnmh7LNobsYGgqKgM/MW60dQAbLqxTEuSRdzHBLlZ2OM3FgqvLnDGxHO+WPpW8GGvN2NLhJoQJs9fzQbX/fhMWaZf3ka55Sd5T2aqryDp08aJ+/yfkZteNbbRFhkMcm35bpuq9qVQuQmkE4VyqJT2epfQiLtq9VzX2bv4dVNEQ4Bn76t6fEW5t0FiSR6aJsBtS78GU5yxLfLZRlGsy9iAnBF1er/6gLY12sp3x0423DOz2D3jSePBmL8ciDfKDg3Bv4sR+5R5pL7hJYZnbkFE1tgLPZWBzXV/kt7m7k/Y4pK+yXgHknyQEMhthpvlobOTdj7lYFIB5JrJkMK1E0MCtCvrq1dhex8Q1bRnPNfEiX2rToEuI4DQeGq3WmKEYvajAoWfMJE3iktV2nMJiXjwFqfM4M005R4sbZy69m1zZ/GVkL4aFQJMeuewGqPUSu9M0AirUrVuwzbAJhps4GFfMrg44aZhRT1oULotBWcymstQJzLvuqS5zgfSWDMr7J3PTn4KoEXRiSnFvptkX+vA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(14060799003)(1800799024)(35042699022)(82310400026)(56012099003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jfkg1ilR7xYQMgzV+rM7EdxRmrsrZiG/3ei77yiElPH19RvGMISB+wdR6QaM4fZo5f/gItyfWgTpyZ+b49zjXyaRtNLe+WFImlsFZ+d05p0BXfvSWhz6rVJ687LtDPnmd5cLk+5BF9zQ69W4qNG6zQP2HW+29XgSLIrO15BKkye45SGxTJSqM7+zCEh0bUmn7282E7IeVVdFLTToNUpSKqiuuapRYKKLGklUPv90EKP9bgiLyR5FPekMMFx96P+VaGIe1WXgNFkXqe6h78zyaKE7zAHOFo4AuLWam2fSR//P9tYjnarEdbgi9NOyGOtD12hOEdNipSQEvcDoHVaAw62HIQfDFGE64/oUPnb7ypB3p97ytuJ7HbeAOjntfPlws7qz+yjBhQJpj07zMfFCpZ/Gxas6Ok+pvmYmVPhRZOz2DkIRaoEpfeNGIL4AJq9B
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:25:50.4246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a808a9-61d3-4931-472b-08dea5c08a44
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6199
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



On 28/04/2026 20:14, Heinrich Schuchardt wrote:
> With NET_LWIP wget produces this output with an overlong line
> and missing white space:
> 
>     => wget $kernel_addr_r http://example.com/
>     #################################################  4 GiB540 bytes transferred in 2 ms (263.7 KiB/s)
>     Bytes transferred = 540 (21c hex)
> 
> Removing the condition on inserting a line feed yields:
> 
>     => wget $kernel_addr_r http://example.com/
>     #################################################  4 GiB
>     540 bytes transferred in 2 ms (263.7 KiB/s)
>     Bytes transferred = 540 (21c hex)
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  net/lwip/wget.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 008f3b395e7..b6c25be6115 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -20,7 +20,6 @@
>  #define SERVER_NAME_SIZE 254
>  #define HTTP_PORT_DEFAULT 80
>  #define HTTPS_PORT_DEFAULT 443
> -#define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
>  
>  enum done_state {
>  	NOT_DONE = 0,
> @@ -251,9 +250,7 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  	if (!elapsed)
>  		elapsed = 1;
>  	if (!wget_info->silent) {
> -		if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
> -			printf("\n");
> -		printf("%u bytes transferred in %lu ms (", rx_content_len,
> +		printf("\n%u bytes transferred in %lu ms (", rx_content_len,
>  		       elapsed);
>  		print_size(rx_content_len / elapsed * 1000, "/s)\n");
>  		printf("Bytes transferred = %lu (%lx hex)\n", ctx->size,

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
