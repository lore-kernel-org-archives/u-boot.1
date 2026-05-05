Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EAAFF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 14:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B398848FC;
	Tue,  5 May 2026 16:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ThcOwnRY";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ThcOwnRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A490884948; Tue,  5 May 2026 16:51:20 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07BE848DA
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=v/9iL0XxNUqQrO55B52OXohGcq78/nl6UxFKCKjZvrjFzpgE/Tjq1Vra83b6mx6zVHBTla5q8IaXzDPPJ0qSL58QrZqUc4DmEPreGgH8Jy/h+nyCeN9ZnbuG+mM9w36Exo/cwa9fpGGoKSUrhGYVI5WVs0eBGEU4DU9b4R0vyeLx/uGbuijlIUNrAzeZz3XG/ePDQo0uPmgn1omcIy0HyodPWJYnL1gaKoVC7eNN+7Dfp+VyMQC7TNR+wnIzg44ean8mnA9wSgoSQ5c575fDsywgny7Q6lJ435R6bYV6CG1t0QlXR7SshW/Mj69V6AobBvffA1ErasVECvULdgGD/g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9BHF/OZs3l8XVTicGw12SphUdqchdsA3PuTgPudeak=;
 b=K8ZmWhm0CeZHKTxlPwZS3YHZ/Juadvj1UeAg3IN/WKdA487EM3z92rem9nYHqYXndSOvQ0mHiGCpC6lKav0+GW9hBlo20rAo76qyiVUN2W2qAeM/WZtQBVeaHt0UV8drWsDmXx0Xyi+7lQzUL2RANaUEXg5Z5KqQdrOJ4cuvUWy4s12ZxjyUA/H7sG3W2ZsfXlWe4hFBlL74JhkA2ZSRfte69gNc57lOiz+BDeFHH1/KwXE7ViZut4L0th6gwMo05HTYop3q7wRVoVE2rtNETRSJ/Pqa42pBg/oFf7HlI8br91Bd5jjPHeXIXpv3Ws1k47jODjj+js8Q3XVRdntEtg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=canonical.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9BHF/OZs3l8XVTicGw12SphUdqchdsA3PuTgPudeak=;
 b=ThcOwnRYIna+pPx/qN38XqxWteliJhsO9dtzQuVqndH6c0NYTwlYeI7xuFDrLn8ciGXQgopTKN1zCOQyLw9Nw2Hma9cf6OtQaofspX6vIPcyFbEW51xfjiOD7pHY832bA6JAOj7iz/+2mo4vjAEAnJqFemkZxCIeaMW5HqtKTG0=
Received: from DUZP191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::28)
 by GV1PR08MB8571.eurprd08.prod.outlook.com (2603:10a6:150:83::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 14:51:13 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::2a) by DUZP191CA0051.outlook.office365.com
 (2603:10a6:10:4fa::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 14:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.22
 via Frontend Transport; Tue, 5 May 2026 14:51:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzisSKUbHVR0amfXYfRAwftYJzwrZNMM0y3jJE3eMOe8mwSYVrmei0WUJJkFTXYguXvokTjYTi+xUv01zj94V1BBBL0bQZNQC/lWWe31grUqVgGJniSCNC2mXv8iIBYWoL7tst4eer/wffDTWFDsSz/c2cNF+kVnYDB8K46rvyw+3snhRzP1DczJMxZ8seb2TPMOIJeqQbzL2tEBroh/OgyAs8ueexuKkBz4gAUJRBnxgzyb6Si9JQO8h6R7nNaSTjauVhVZ2KTMqdVT/uQLQ7XWljZW++uZwVx7GuHLDWRdVH5wKWz1i2+ElLBEDrkK0Ci0r73r8Zw1v1vlmP8aLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9BHF/OZs3l8XVTicGw12SphUdqchdsA3PuTgPudeak=;
 b=wplytmx2ZAc0y+jMHcsJRSbMsrN2BfMhJqUZHLw7B3K2dIG/3uTtNQ9bbTNWnO54QwMXMT/uIZJRQZ8Y6vIbSArjn3+xw4LMy7jtJgFS3J+qZ5M1KgDC489j47BTcXYD2v4eWS3ifMkyi+0g984WvfhFaQM48qYhiO0xnh7Rs0ngZSZcAdWd/sC1U04WxeP4nieiepHUGCUCqvC0o8sxLhxsLszuBCVSXK7PkZnlp/+N+3F6n4Vcx3cJxlxwFitXhefMDo7lJ+o14tMvuDexSvZ3v1jpaChkLoy0iWaz962sTUDOPOHnD+EBUHUMsrxitRfa2bDbTBlMBHqwNp3tWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9BHF/OZs3l8XVTicGw12SphUdqchdsA3PuTgPudeak=;
 b=ThcOwnRYIna+pPx/qN38XqxWteliJhsO9dtzQuVqndH6c0NYTwlYeI7xuFDrLn8ciGXQgopTKN1zCOQyLw9Nw2Hma9cf6OtQaofspX6vIPcyFbEW51xfjiOD7pHY832bA6JAOj7iz/+2mo4vjAEAnJqFemkZxCIeaMW5HqtKTG0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AMCPR08MB11993.eurprd08.prod.outlook.com
 (2603:10a6:20b:770::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 14:50:11 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 14:50:11 +0000
Message-ID: <77a63e45-d798-409d-b578-8979c7c809bd@arm.com>
Date: Tue, 5 May 2026 16:50:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net: lwip/wget: correct diagnostic output
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 nd@arm.com
References: <20260428181434.179888-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260428181434.179888-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0360.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AMCPR08MB11993:EE_|DU2PEPF00028D01:EE_|GV1PR08MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ca358e-3cf4-46c5-18d5-08deaab5c0b9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: GsffSvnr29/hjE4PFtb31J4nkQM31eaEnaAEAEZABiWTqKvgL/ScFsMZ5BYipYeoFS+gtIbTJgl6pij9k9CRCg6EMwZxe91MkWECGVsHxhdEvMeMZixrSUtOtkSjYpvlkvk+XFntXMBLQ2/A+n/Byb/zoyRSDFgRl+39lpUu96WGLl2rLBq1quM9BYoAXw1iDOcSN1qJfrONjyu9a9VWJO0Xr4FggB5OnlEM2fvmyeAgNiraGVjnxzPbSqA+gT2L29NqerwUGvIoJV3nvxmx3nyQQ30gO08WonwE98vHhHDycBRPCa1yKcBQQf1VTdpHfDux1e9LEW3cRF8/SDJILk6Xcv4twjEGovX3aFtKboCvWMpYQZKIYn2Gy7ImSBW9HKoqUH0RtTI8stxpbm9yZVHQMyfJdEmJgMvcTq6MKK7XaUiXVK4CurYRZ5oVdB5HefWqwIa98Cgc3f/Zj4lDljbet+sxKPKAOzD/KhQo5aiGhNKbL5RzGjNR4aXZnZPB7rm5bWBg9Hy98NRcYPn5Da8DId7g2MwMCDTvgHA6KP56kCcQenxywkqVDN5CqYYwLnWPMxoh2Dw5xyPLBT37h0gM/n1/6YkJyJ/oRd2Yuo7jdHwVnE80ObEl4pUxs81KSNdLRTphJMoXOSUeiaYrQz9v0jK4eFxsd2r1jhXMocf+MsfDA1mRkEC39ww4QOb+
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: P3uOtRi69mVZYPINWUFgH3D2e33Dm82cX9v2s/1SK5gNlFeC8LyFUeILUXbZwc6Nn4oCwkBeehf0mWGj+I9NM1daKKoRzq5eDDASV9eXz7sx7k2Oy+x/ZgW89yT8TyRpnLpqF9oFVMxewHTFeDRNavVZLAPUUdOz9qQkVE3wX7UbUTZ68FpxWYsX+1oazTsVTRuYGRhH/7Kwnst92rp0mQ9EGBOkS7dL141jdicD7q2AziNfPABTPlVHSYbq5h/Bdh3x/+vaIOI/+3XacmvThQeUTjhiuQik+iiFCBC7kFiBmO3gLpUbG5wEm4sfcyzaK61pjfB+YkDCVQsV0pJr0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR08MB11993
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 36365e5c-a0f7-4005-a642-08deaab59bc5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|82310400026|35042699022|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5ZuKIqhFRFlkgOiliZrQPfFnQ852F5bvQxNYia+7vc/X5jgrte1PW1hXLnbLbQo9/lU6BRcc56MD9IaQtKOOsgBO7fmEECXgpVRZ3r//Ix66Qc1++g6M0t3URPWETaXu7OeYlaiuqGsgJ/BKro10BMBVo2Hpb26ZhzYUT1NnSMLCxelsRQeFnhM/lcjFSIcE373aqABw5OsZvoGJLC/5WKxsixwhIjySU6yaSo4KXiNctTwl1N+Ccdg881yRL8Uz6pBZ7TglDdbAC6IsuPJZYl5KY3nmU3D/NZ9yoWGKjUOlhEsgdnNuExS0pvxn8FGSAPaqJ5U/RMQf4VZINA/7vwUYW/PSFyeEL5mzyMkSkb8vaQd+vcFVkW9f1TzydvHMTeRYzO+5ZEpHXJirdnWytMctsy9XNzOKocqajjFQSSRWzullPfVzrwqKtumbzGfG0uJCcL92RYxaOfW7eX6lGI7+wms7a6ebZLkQgwV6sXFqCiDfJFFhGwUxX9V7PL/jGNGp+QOOs17K6duHj5vBOwbu3b3OLRXSDgM87BQdVDAL/o6HqqL8blVreQ87egILlzaGujn3ahhuHsSifoi6Qo4ussiRMi5Pj6rWiAmY1K6UhsFRPUH35uHmhe9ytwSAKjetP6hqu1AYWaoNOlu0JXhHdGx2+sLuTbkeFv8OoSrhgkMLTbeHfsoJ3mvTygHCl235UyyEL7l1czH9xywcRXXwfli6taYw0cOK96uSd7E=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(82310400026)(35042699022)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 20+03znoyQIhuicoyQaDxC8UNWQHikM03OiGg9xhBWDndUs2RZ//n6545BL3InBSfdtg0XsouqsP6NMB5hGvWJ0ZwRlqIUmPX7FsfruOZlvWNknDIn0sRJfT8u/FOIi3xzMcLll9WOilkwTkn1IonkCDeJT1dwTcvMSnB0vAncesN2K9DHgixvi2ACZBtyI0devvnUrhRx4ltxmQL7Mu/l+/vqsaV/e74tHqTK+PEZHQVD0EZF5f4rfPI3I/piL8aQJqI+sOACnr08j0UATeuTav9qbIIGmBwbAK5J9gTDCXsFniXxz/PkCYH22kKfZLP4Fut9n0yPxZ828NC0lYoVMs2sfgSa32abT5ewvf5mD1OoIfE7uywIW4fJ3JuElv636HGTKQfgVNR7yxBIVTY2bSk3cwBQxxUWNIxt8Eqw5Jo7DVMt32mIjCf3bpyF7x
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 14:51:13.1366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ca358e-3cf4-46c5-18d5-08deaab5c0b9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8571
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
> * Add a missing linefeed
> * Don't print content size twice
> * Don't print progress bar when silent
> 
> Heinrich Schuchardt (3):
>   net: lwip/wget: missing linefeed in diagnostic output
>   net: lwip/wget: don't print content size twice
>   net: lwip/wget: don't print progress bar when silent
> 
>  net/lwip/wget.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

Series added to the net queue, thanks!

-- 
Jerome
