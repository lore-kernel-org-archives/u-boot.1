Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD58ACD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F65D846A7;
	Tue, 19 May 2026 11:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="j6qWJxQx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="j6qWJxQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04B0B846AC; Tue, 19 May 2026 11:33:04 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B02CC843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pwZ4iwSyBDPdOZIzcqR0b2HuDBMuxXn79Tzrrww0dF8WlpWcIeo44y5wz2mqrRnds7he7ZVrMGc0gaDQ5Yob0891YZlJmNZXhX65NnPOmdZiEMu5EGPE2qPNwOrSbycTm64EqJ5USvL8k2zLryrlbrq91LGfAFe6UmnolAny/c1eSJTDBW8BFuPvRtUAT6+TwpJW4OXnb7vfXcRE6YyOXOWcEPmgOxdwDS8x+lp8uwLSnFojaI/qYSaUL6z6MH+PgbdSrIe6O7UfIwjoGqPLDPmRjXLMBdpRVzgQI+oi10fHDC9eqbXkaD772/8HDnSgwGjnrV6q3bbrayQqS/U/Uw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7UFEh5drb6qy74e3BBaI1ZAuWabz410sRlDpsNC5tA=;
 b=AQmfvZDC0EeYfaQvdQPqR3UviWCJP5Ip63M2jb/USOPcz2c2QiVNakaLVg9725mlz4CxVFisrNQnnMcyJUkQTDDkGHYZneowceCaoGdInmCOW6RV0SuYzg8yxKvI86KTtFyngEqziFYo5FJj0o3g5pUkCdJLs1F6chogtFx9ymN8VP0G11szaRoeuXpm+yEJP4mxHZ68S54u0SIQ+MeSMOiSqopOccn3CEqb0/SGTL4dV6snxhC8Dp+TC+XW+5g6CIu/CcYR/Zit0cWShVkaLyVGqKTDIvjPxalPO7zx/qysba0XK4f/jorzWPxoovbgWVjg+zL38v77Cg8SaRMDGQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=outlook.fr smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7UFEh5drb6qy74e3BBaI1ZAuWabz410sRlDpsNC5tA=;
 b=j6qWJxQxtfYv3YX9Im/J7dSD5ZP89eses5gweIagm2T82Gekj/lQNKZoJnOWuegdpiqzwedjtlDFT2+/GWCqCC6yvDUER9KR5woRQYQPd1+9Mx3Z+K3/tkTjBC7Br2bgXT/9tvfu83E8W8OEhgpq0fXXOp2er4VRwypUwfDMCps=
Received: from DB8PR04CA0026.eurprd04.prod.outlook.com (2603:10a6:10:110::36)
 by PA6PR08MB10663.eurprd08.prod.outlook.com (2603:10a6:102:3c9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:32:55 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::8a) by DB8PR04CA0026.outlook.office365.com
 (2603:10a6:10:110::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 19 May 2026 09:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Tue, 19 May 2026 09:32:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IawXEewN7fZPl18wWg2eZGme1HWu1kxI9DyRqw1/S7IHsIhE5H+Bk+rioAFTB38+oGZOOTWvq9dkQpG70XWBCNEeRs3BMrr7tDR46GqgSsR0dT+oWpjlb6uFMccaeIGR0Qaqk6KibHgSxJ+D7mzECjDQBjkf4q1+xiwggrCtgjM+mE4Y55nJpBxeJOYHEC3Dxdfv90wwew9hjfQ+nmP1r6zlP/TNGhC+DHJ9q9NsQNJUoU8QsFMFyxZUshLpukIDNphgM77iW+GG1AduxDoX0xwhmY59ev9PzZmeCNC95pZqROA9exbwi+aAiyeBfMXliKzsMLm9Yz7M6uB1MGfLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7UFEh5drb6qy74e3BBaI1ZAuWabz410sRlDpsNC5tA=;
 b=dqgF26YIxr63OZMXGjgpt4v3ovTOXBy4udKi2Zox6O2vMeY1gaBmpwiX+f1dyAiYa14D3sdqON7MA/tDwqfuuqjfNK/SLBP3qBUS0RXk2MldC3an9QgbWzP+KLN1PWVoStyLPZEqtl5kp+z1m523UcqmdomfFf3JoHs9mG+d+ASA3Pj31o35ihtnhTAsI9tcOpZprQb6QKuBAcmKN9qq+Ykk3vAkU8WcD2n4T+xkWJ8nFq5qoJ23GgJ4C5VmP6CIwXWy0VXSDqgiBS2AGbCpkAaEDlSyS5TmeABGaip5XKa9kAooe+QtQ42N6W9W+7REQzI2ectDTE8KqOx0xPl69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7UFEh5drb6qy74e3BBaI1ZAuWabz410sRlDpsNC5tA=;
 b=j6qWJxQxtfYv3YX9Im/J7dSD5ZP89eses5gweIagm2T82Gekj/lQNKZoJnOWuegdpiqzwedjtlDFT2+/GWCqCC6yvDUER9KR5woRQYQPd1+9Mx3Z+K3/tkTjBC7Br2bgXT/9tvfu83E8W8OEhgpq0fXXOp2er4VRwypUwfDMCps=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PA6PR08MB10623.eurprd08.prod.outlook.com
 (2603:10a6:102:3d1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:31:52 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 09:31:52 +0000
Message-ID: <91e8768a-99d7-4563-a466-1eff161aefaf@arm.com>
Date: Tue, 19 May 2026 11:31:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: pxe_utils: Fix potential initrd_filesize buffer
 overflow
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, nd@arm.com
References: <BESP194MB28054DAF4BE907B3744B9919DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <BESP194MB28054DAF4BE907B3744B9919DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0190.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::20) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PA6PR08MB10623:EE_|DB1PEPF000509E5:EE_|PA6PR08MB10663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c09465e-3a70-4d66-6028-08deb5899aff
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original: pQP5v/MlAXz/s/4oBHGU2iLNsZKNMiIsAk9mvInjUIsY0/xPoczI2INYsHtqBKYyB4/OhQGYQpMS0iWmKND11zGQb4oGke+uv5Szb8sCco8+8vTKgsO2rk4e4gbUqukKQcrOT/QY/7vhSrQtEZSiKxHIKDiUUmNPcPHsVkKylLOzbq8CcnaSxqEI3wvzgH3T1iGkmICVSG/RnZF5K7uLTxcHfbbXx9MuQKIfOnSUzvDG8KGG9+sP6mvT9eA5wvYBFeiWDFAXEqvz1Iy5bXRrYcwS2IYlWOYiJ/DeyDowFYfA4VPwyRewcCRY0EBJKhDT78XjCggPNhZ0zfs33a1VHlwEXq7Mvj63MGMMAfkc0LK6wekRRqtuJvas0DbA3FnNRZEB/O7xRQPE4NzAAMeiyNZPh5GsIJI8LcOWtMD6k8kb4yDG+DoXQjD2nhggKN1Kmg43TuYVhotd+N0QgAlujil+BSb0+1C0TZqU9DuhUss/JTebD5G/osXGPVwlCiuykqRXarhpizZ4SWT6suKe2rnC218LS5KrI8tVJIM+fjPhl0/EkjUVDOOlFixI/FrwpCBCuUJaX9FWKfTZOBVYmzYB6om3+Dks+QJwwvNFjZIe5m/Y2SCYvPOLgHa6XSrUkADW5SQ2sIG5s1GI5yNTYSzYrRNQOP15tp0cPm1WQEjf/36gtQPAgDz5F47qeGHr
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: VWuXu5RuEEs6UZK02mqLemj6WUPbt4tQR31BkPcHcVLm8V+ZvqNBLJd/itF7U2czzTi5BEStSBBN4AsPzj8YCq3iwr6yJgXPc2JmKGV0mlNUEBVUcmLc6DqHr1cl3RLuoFV8DkomZjXO/Ak6aDnDm4yzuM6GhJUemW0hwhvOOFbIU7ptaUBpBAJVaMz/XTLiOK44wGIbYw7Ckw5XdkNSxGRUjAn5hBftsV0eq4oQ/xjWdl8mkuR7S/DEt0PAXpNjiPfXoOf/Mwu3GVF/bv7xcLFMdT5BIxWLQVSJArwcfuTEKbc22aZjyKuof3AlVWNGX4G4gs1jRlP70uKzfuwTVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10623
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6957aec2-9ffb-47d6-8a9a-08deb58975e1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|32650700020|14060799003|82310400026|36860700016|1800799024|376014|35042699022|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: sS1zDZghEuXNfLstrh6M5zVMdGMtbuJNQpipZuHxp+6uJeGUIoeOzIxYYy5hhGpJUPHsKaMS15FgYRWgtnl6h3u53NUs+4+hj1HJtgtxzavzNbMBAAQdRMuJAo7WU8HZj/yXfJXupQ9OFmPzbuVp1QIIxv4ZiO5OUUSSx7EcvMWGCizieSE8xKsURws3mkUaAo0VIvkOXaRVLyAB9YRdqZIQrKeHIr1MR0pExSfNsroGTKkU7laf+rCe/UPC3h+WMX6i9VBaJk66O89l0OD3n6pyvganOTDSjZh4oERIXq1m5ndfuEspudatLpPNMAB7tBeFiA/H2BchbUlmALDnfC+gATt+j12zGeQ1PvKn54+Nnv8E1C/t2L7K92sQoAVHgfLRvfLhjn7XCTvTx1mxBf/bmfKo7+jpDwe7sHy86L43LseQYId+b8dPkFKT8EWcQv6cJiONGy/SZxILQtlCOY4rhBDU37TBUhSZqIup3C/XXv7u7DJ4CA7d16MoEbEbL5U8RqjQfdb2syOU684EtGjBbPyRcwFExyrmh3yq+zv5DaLT0w7NLUxUdJ/xQZRa9/su5F7WxIzoZxfER4kwQsBeGrSXw7Wk7t+zWaGR37llsLftaTKGVAM0F4p7al08eh5CDJni0ewbII37wuS1CSdxYV3F97dGsH+hZLmJnJCUUmeSiAMG3cENbDpSQPzazwS8u2+Vn4FpUDOHYguQwOL/V/+ApsUSPE3PZSCZDJY=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(32650700020)(14060799003)(82310400026)(36860700016)(1800799024)(376014)(35042699022)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bvrgAJy9N5bgQOAm/FVYX4KIkWhGqYk2Ed5UnbaMmCz++dBT/99lAeR+CpnSLdsDErgGF+KXiQCbsc+no5u36U+wNmB+aUTHylwDI+Bo6tCJ8g5ZBQMZJyb/GPeL0YQhmxtruHXqEX8Oxyo9e0aWSQsR37KrXhTmst+W2f/XEqFldxOPMs3Ohf3Jgw5lsTQXrB5kwFMjBw04hAH6gJULu4wyGmZM7bDJale7AXpsbGRRuSInvp3KtR6K3+yjQQqU5cT8yGZxM81AgcLv41ANooAijSAh8wHanvHfQM7uPVcVMjwIYl8Q6FIeUiIkUA1/7jAyu9+rjFf4gr2H6GWwV2kgKODh5C/neVO1Q8VH41szz/8O/+OQmIZsrvRaaHOwk8CEegvWRcIWAtKgXEvO89xMRgH3Eu1H3ifsnSPV6zVIA5MbwToSpq07s79i0mmx
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:32:54.7783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c09465e-3a70-4d66-6028-08deb5899aff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10663
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

On 15/05/2026 22:35, Francois Berder wrote:
> ulong is 64 bits on 64-bit platforms. Hence, simple_xtoa can
> produce up to 16 hex characters + NULL byte. The initrd_filesize
> buffer is only 10 bytes which can cause a buffer overflow on
> every PXE boot that loads an initrd on an address greater than
> 4GB.
> 
> Increase buffer size to 17 bytes to hold the maximum hex
> representation of a 64-bit address.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  boot/pxe_utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 419ab1f1b0e..8c1310dabeb 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -546,7 +546,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
>  	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
>  	char *kernel_addr = NULL;
>  	char *initrd_addr_str = NULL;
> -	char initrd_filesize[10];
> +	char initrd_filesize[17];
>  	char initrd_str[28];
>  	char mac_str[29] = "";
>  	char ip_str[68] = "";

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

...and added to the net queue. Thanks!

-- 
Jerome
