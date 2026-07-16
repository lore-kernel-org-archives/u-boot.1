Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671B1C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 08:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DB3A84D70;
	Thu, 16 Jul 2026 10:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="FOTMa2g/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FOTMa2g/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71ED684D76; Thu, 16 Jul 2026 10:10:42 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6123F84D13
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 10:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Mt3ebcwaXRJaccezb7HlfxSbsXipfNYqZUKPCqcBPTOolRsb6QDT8/hOQ7qP3jraVj34o6Znd/mOxV503mKYGEXuNH/Omhp6hJO3WjkDzjs7zmKGVPum6DEJQWJf9A34qS0CNSzvJ+mtyS3eiA9VmnPcfxIUUu/+eulusflKzb0CaWwhW6w8xdUZzAcsbzr0YPbvoO54bI3s9ySBPixv5H3LeWteT04k3twRXsEGIFPVGQIFvp+S1gq20RdC018hoemBvD1GMpI+6IucSkrIP+uqUI2LAl/PHzmBZo7NpqOB3em2qfSiTa3pr4bUzCtzCaRiTwHo0c50mu6XktP7sA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF9bubiEeQJR8LeUXah/UsbdGymUfmea3QR+5mFssII=;
 b=EKABfj4aOKvoYjBXiugg7KQqrAiuZzxF+uSTTigSB/dqTl92MQBhJvR6m1+aquy0zaMFWeFPg3gN+ofF77+MkxzqoGypuEIoX24Xd6+khNyPv/gSjZZaIdh5Kvt1cvrAxmeLI8No4qZbK+ROHyiUkZIbaE8XzT9XhLznaxpANngZLkFpskBKcAw15ctApDKln/hiC2tY8VxSyZAAH3foh8JOxEZl0HM6fD2WJx9EbRyai4+aqFo8uwlrvZ00wAUh0TpWmcRx8fRnkvN/eS2MgT6IQU5jwVVp5N3eaHSbeUx2XeYMDXRCZMeycjzNNEam+zy272mtLaOgTn3kO0UsBA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF9bubiEeQJR8LeUXah/UsbdGymUfmea3QR+5mFssII=;
 b=FOTMa2g/llVzfy5PcvtmVsRFxCnCh4m8YiPMex3sTbk/REY446O0FtShojhz/Q4YRtj6FEnyX7LBXtoc2z98dMdbw+IauFbOmn9+46jagYI+jPuFsLHF7XI75a69eDBrkWZRsIV7tZUsjH8fxG9xwoFyDp+IX1w2XJJPOf6knIk=
Received: from DUZPR01CA0212.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::18) by GV2PR08MB8169.eurprd08.prod.outlook.com
 (2603:10a6:150:78::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 08:10:33 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::c) by DUZPR01CA0212.outlook.office365.com
 (2603:10a6:10:4b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 08:10:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Thu, 16 Jul 2026 08:10:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxxUjLE2g0hMBuDg6eqVspxrxehFrDiBiPOr1h4ILpbgZHdqVFJJ2X8RK6E095o3Nra9bWHWTFeQkXbZZ4PP32+SjQQFv/RCi1iI1XSVh4gVaP2bxd8V28TQXBWySji12VVSuXdWc9/ASP9mWhtgRRkHIIZ+UpDi3BEypMvRpv6mhhiS05Ll7m0+dXXXuInjcrpTCWbtw5UC18C1w7BqqeefpidVVtQWkdV6am/njgcKvyfbv2bWvvo6oAuOASYJt/+Fr5ca/OdKPg4dMNg37ZhkmxrXXDDR8rux6LI+6YYxN/L0L6G0NiThdxBdNwHRJFoujuvYZKOUeG39Nj6Wig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF9bubiEeQJR8LeUXah/UsbdGymUfmea3QR+5mFssII=;
 b=V7pFWinKYO9oMIF8uJ8tRCxSvxbP0dfWnlUCslEOJOG2cj+cIFpGhVteGhYL4QMjiwxBP+/31DXwQfwksC2WlqThBQjcDN5vGgQHULfA/LxT0+LdOyANteggYaR0qFbOu4EB6J/Mj2fQx3qIHVMMzVu8im+ZIhtx5WRWIg8FBp5BZF6fCu2BnBX7y4hGdUwzN5S46JshgypLF0VtAXDAIplGFTsYVGgm93fGtLHploNb+NxIbNdm3LOTDra0EFyl90/h1fXlHbFE4FaWoZrP8OmyId2seAfNN0Pp0NAWeXsYv/yKZQAMYAO6y0esyQsiKvN/uDTB1s1UO5JqLD270Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF9bubiEeQJR8LeUXah/UsbdGymUfmea3QR+5mFssII=;
 b=FOTMa2g/llVzfy5PcvtmVsRFxCnCh4m8YiPMex3sTbk/REY446O0FtShojhz/Q4YRtj6FEnyX7LBXtoc2z98dMdbw+IauFbOmn9+46jagYI+jPuFsLHF7XI75a69eDBrkWZRsIV7tZUsjH8fxG9xwoFyDp+IX1w2XJJPOf6knIk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB9954.eurprd08.prod.outlook.com
 (2603:10a6:20b:638::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Thu, 16 Jul
 2026 08:09:28 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0181.016; Thu, 16 Jul 2026
 08:09:28 +0000
Message-ID: <d680235e-750c-4f4a-89d1-fbe8930d4404@arm.com>
Date: Thu, 16 Jul 2026 10:09:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: lwip: wget: free mbedtls x509 cert context to avoid
 memory leak
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <pqy43tgj6qomfmqneq7e7xl6ifopleolqtmiduhwlo4yt3dufo@pwzqjjjdajdn>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <pqy43tgj6qomfmqneq7e7xl6ifopleolqtmiduhwlo4yt3dufo@pwzqjjjdajdn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0278.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB9954:EE_|DB3PEPF0000885F:EE_|GV2PR08MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: b99a4bff-cbc3-45a5-19ad-08dee311b58e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: QPf4ChijcB5sydKLQLMjCYFINmptnap29/2Y/AfRsBwwmbbN+vZUmaGY466ALiE3v+zpDLk6cslPf41+91urzUpWM9W36N9dQzwqxVJX83bKn2NEkJHs6Aj5ezKSj4/m6cbGQVDq0aTTO2BiPLH4FJxQ1+VlD3k1FKDvzA5U7aUeBLF4jfoTk9JOVT5GA5XIOr/Tisnit9FwpSw8T7ZNbkmAlIqTWeALDlKzVfvCkEHqCx9E46Oh2ZPHGmVukiuRnh65L5FgcPQvb/941KQEgh0ks+Gl/gqpWTajxvMrTn8Lp5Or4tGGbLywpnSKevQThkfs8iHSZGsIpkb//MVp0FUd5jSON123gk0UEVQQ/EVvGWxiyInKTfSqg5axBYB73hcQx8g0U3WIqaLn5arR7xOga9F6VN2RHZUZAcTGwjBvHouMLqeVxukKfeQwRf6cafU4x2bLKOaZJaIO/+ILAkKhr5XrftLZkmb0FH0oLtJ3SbKIOgFeZZze/A0nnSksk7HZCrr0cK+5X8FsiMKr6z5a2nGJESgthUq4dk+NuCBg0lssNQtpbIGDF6To0RWcThDwjDw9NzPAxxT+FubL6i7zcizrNJpvvt/f4cAiHKBhZT1cO1Eb0eIouXnWracJ8XmaVnlED+V2wqGpBTe06uwiXfwpMXlOL8R5BUXzmFY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: jwcDazjO4oo3GXzIVwE8WieB/Bjkh6cun8sBvCdQ/nRDethzSEc1hCQaeJG0Skg3VV1gFAW1ueqWEwECiXs7OooMU3dNebzwCWYsmSE6U7vCc6/iv4gF6KViHrzVtvmpZryJfx/0JEPXd9KVIOqmcEJuS1wMNR66PtPEu/MtDbfFP/LIqziNk6oXEaDx24M4meXol8VIQ9h6WT5A8PtzQMRn9jMRcBkrWO+Kgv9Lzo+ZxRsCJzYcStrVJNayei7rPKX+ewEYNjxDx37nO+YhiZR3W1c45xhuqON9Ak9KdLbHqyVrAyFavGjv7AgL8Y17ZD8bS52xRaBC3kJTSNl29g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9954
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c41a3831-044d-4339-23f3-08dee3118eaa
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|35042699022|14060799003|376014|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Oc8ISq8gkOx2f2q5iC5Cw3QOfTDwrcvunXmIJ0iePykPw2Ox+rEf2HowuJs1PAjgLBCo1JoP7DIZ47b3+eg99wtgeFe7j1gH9CQ4fmlVhcmzSNu/iH3Gz2Ei41/astHzeu5BGhWTFvmcywwI5h/oWA5BQqaEAclX/Qzx4SUad+PJR1ASN7T2M02eP1+jG6i8++1rglpT/fAxqT/Tr4DNpBwXMv1hg3m5BSCIRgHnGvAhSW6cujytkMKVu9CdOcgcfMl/FEq/BcEHjvO3f2MzSJzjQX2FC9nAF/Sm9Pv31s/K7/qKJ1KQ70zaYaAbWrhzBvuu4xl5j8+/8F1gTjC4WIc+UyIWbQBcttxatUIqjgMNq+cKQqAhLdaACMwNfTWd8Y3lhLgzJ3m1vCm9Nchshk7NJOiyiltDSZ2fMrIK2MUl94dbkEFRxsKzDkchuehb7nVLfrtnGaXjiN8WjYliJX7K9tko4+NgfXQO36NOGBJOw3AQNojge8rMINpTXtziExVbxkODPtViQ/uAhIFPlPKZcq+2huAIV57O8fbSt+NUo2Vqz+Vt9RZaeiztRRqUg0dISDD1ti++hvW48SA8Xs16pYTGWrves1qEDwjdMbaSg/zHI1oCDDtHQyApvOvDgsCZpCuEuO2P+vdPTs0UN7ZkgZI/KXuBBiOIoq2oIUgtUGDTyo9NJRvhA3+yA9cem0mhb/1KNm44cKE35Aw0mw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(35042699022)(14060799003)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4Qpu9cxb0bIvSB+ELz3YHDbF77tOXKxJnoRI/jGoPrG0gDLSPD8vHRddfFpTw5BCbj3Iygd6CLilRGPpbhc9tuaBrZxDrKNctPj/2zJqz2k9voMZkUngncZdxXKjsuOyMOBN6gBq5RLhpQzk/OkHPx+gWD/vml4c+tPjcXAnbrcRdKh2HMBZxcipDYU3JLB/v/RZO497iT3TwZjXL2XC5M3zF0QMbwnjrI6hJZ7Mk4xJ2NgWfxyBLuaSOQJZMYD+mur9Yp3CH6zJGkeTwDmr91TYts/oQRFpBWAOM4W86f5RTJcVihEegRc6UsVe4FXmIdj4i1EEZ2XPbOD/XoBj5CMgKAj9Ucm5hM4q57adLn+PpTKoRARsNZRryBj36sgli3moryAiOn9p3xtvnVXLPCgJxP0MOwQ+rII6sfTb744R6xwqTSqUXNOqUDtEyApt
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:10:33.2157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b99a4bff-cbc3-45a5-19ad-08dee311b58e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8169
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

On 10/07/2026 17:21, Naveen Kumar Chaudhary wrote:
> _set_cacert() calls mbedtls_x509_crt_init(&crt) followed by
> mbedtls_x509_crt_parse(), which allocates internal storage (parsed
> cert fields, chain links, raw buffers) inside the crt object. The
> function then returns on both the error and success paths without
> calling mbedtls_x509_crt_free(&crt), so all of that internal state
> is leaked when the stack-allocated crt goes out of scope. Every
> invocation of "wget cacert ..." leaks memory.
>
> Free the cert object on both return paths.
>
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> ---
>  cmd/lwip/wget.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/cmd/lwip/wget.c b/cmd/lwip/wget.c
> index 4883ad61bce..531e886e986 100644
> --- a/cmd/lwip/wget.c
> +++ b/cmd/lwip/wget.c
> @@ -67,12 +67,15 @@ static int _set_cacert(const void *addr, size_t sz)
>       if (ret) {
>               if (!wget_info->silent)
>                       printf("Could not parse certificates (%d)\n", ret);
> +             mbedtls_x509_crt_free(&crt);
>               free(cacert);
>               cacert =3D NULL;
>               cacert_size =3D 0;
>               return CMD_RET_FAILURE;
>       }
>
> +     mbedtls_x509_crt_free(&crt);
> +
>  #if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>       cacert_initialized =3D true;
>  #endif

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Applied to u-boot-net/for-master, thanks.

--
Jerome
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
