Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F6606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MWnbFTsS;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=oetNInbC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C92E98111A;
	Tue,  3 Nov 2026 13:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gzk7ZEGxdcWy; Tue,  3 Nov 2026 13:04:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 03C8281118
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793711099;
	b=OQY2I9CtTYE5YiusmMXjGbrGHTH/dnY+8hMsc2XCnPVN0QcPzahOvB/4X1alTak1ddi0
	 8fGcIoQ3RJ+lQNORwz4mxu8Qvl0H/Je4FZuk1MWj01T3OecSxa7qf2D2OVYTRbsIAuONg
	 Kp77eMdk20lUs+qPxB4Ut/29Fne9EGb9Nl7fVtiU2rk/UGhrxl0hkfNFUE9aPvSl46bfZ
	 uF0YGCvMfgvclR3NQVhQqDUezB8M34ETCKHoAWxOYRPhC6ht6KNVv21WMUClY6j731RUm
	 VJPJADd4/rqIQrhG4ItkNYXzOLnm1MgPhY/z773w9mga2mAdeUjVUne0yjf129LAL3g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711099;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QP/exwt39pZ5d1kibZ6WnOqMe7QpEWhkLAGSA5enOe8=;
	b=KMX/6/+vd2d4CxvLaB1rP4vJMH1z4M9j9oK3T/fCt43YtBSqAVeBRi/912UxfLc7Cvul
	 YLZkRZSwhu+uiV+hVo3LWYwF0bXzKj36HPgn2EXDrwzZg4wE9mWrwEy6X7vxUcDInGVut
	 F/aHtkZGXeOsg5NFU1P0U4lD5d8Q+9XyHPx4ftH5CvF4u66SCo7Sn8hT8/G/hpiCiHv0D
	 IOgkQNshRMcY6/1dnze28cRnvLYz2FhbINVBl5UJe6B16+tletEfxlTS2oJfHDzhsRlcG
	 mbNbNMerokRVCOujGAF/yt77eD27yMxAJ7Hhez4lgKegPD6WKY1OjatGe91SgerBiEw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711099;
	bh=QP/exwt39pZ5d1kibZ6WnOqMe7QpEWhkLAGSA5enOe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MWnbFTsSYSUSobVg2eePA5eTtd5U493g/aQzhJlIUtg57Cgif3ms+BlpLbipe1Dws
	 VJBpWvUK7I7MHzAA6HskGFyKSNxAqsb6dhjCqLaQJHrE/tDvobZCRHye7GQIC+dxKu
	 tFlm+2981zsmBMe50NZaS5os8ZBmtUxoaWzO5qdcU9OzZF2Wb0Pz7Kcft226ZYyRFu
	 VpiWSFdMPDghGsZeUZBoofB5M9k8itIdr95UWWgscgroHrh4q2h8rFuwWUnCA4Ipmj
	 Hwxul7wyrP+w7tLVKiNZQ6ekGrCzAv/A97JdMQLqRM/VXZjNpdUXY+4+nubbLVS3aa
	 cXmVGb4mILghw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03C8281118;
	Tue,  3 Nov 2026 13:04:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91F08356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F61D605DB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0L-A6iFlEY3A for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:33:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ACB23605CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793698437;
 b=rUqjfFtAld/J7eD55p1mOOyuSaevFOLgF6+44BhtvSOuy6Hrm6O0z8qobaHSD0IKIkhC
 jVzf4G/ixyCoy+WAdbkFdKs2lPjmo3fpOQPNQHtAUV0sq1IunaK3PAy1wWelAWRIcZcBA
 Z75e1mG8kWV6rerKOAkotLUGBBwftRM5ZXv1JSLgMZWOQsWpMwf+p+Z+JMrIQ0jNgraJ6
 5T7PYoZqluDBiXUBmPVIB8uE/MR9rdCma1Tyvvh4aqIwsWqCEBCVcCLulwS6vMEYzADS3
 aiZ3gu5w6Cr2KBq96MWD7FOu+EOYFHALb8XubSUZAd9Mzg13LXuMZ44MElQIQO4l8CQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793698437;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=QP/exwt39pZ5d1kibZ6WnOqMe7QpEWhkLAGSA5enOe8=;
 b=Z9ne0tftWcn5K+nabuCvqQ+thr0Q3Z7sXo9GYFIonP0Xb6FBd5UEUEr+Gz0w8U0fDJpt
 yC+T2liYi8YyeZ/V2XSX9y4+rqeKiyh0Hn3HPDBbBDItHm/NpYwBQWWmSLb/2HHvJ5Jbc
 f1AGEAEPsi8vfZ7MhHOel2NDdw7br29DBhQNHMd6yMtwfEji7Kvi6rdryti+bcnGSscKm
 NUET6DELD+MSnflGwN8HgvDwJos2edKZPcuAcv/ytDX6SBR6Dj8c1qMTo32uKAMi1q+Qc
 YfKFDPkd4Lb+IPDc9rT6pOBxTk7l0XCdQ/s4JuojdHj+/HwYYgEe4ZEPt0wruJvcyHg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=oetNInbC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=oetNInbC
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACB23605CC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:33:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7uFk1hxo160/GKCqk4EPYBrPea5gVLH4nz60QEsI3c8yPv+punkrtUS05orxq9cVJZJxOwp1lpN7YGmHNnRB4839JVFTOm/jvk/tjm7QfroMih6/Ep+us2DOYQSfjUoalSNsIJprLpFzd//gge77GB+CtWiaNs2uZtFzY1JSHfA9lFBATXabFUEn+2gUqikBiY/fvtG951U0GyN3/WVOPWS8mlLzptEeiKIwRHvasVkge2jSovoskyOZOvahycsYjwYFM65qG2MX13G3ngw0tVOrW9YYCZXSxBrZ72y+ux7uitihVk03ZQBa/x1JuiQ/mnSdPBh99jplbXfR5yzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP/exwt39pZ5d1kibZ6WnOqMe7QpEWhkLAGSA5enOe8=;
 b=IbGz2Unx8bDP/Ef06AtFIjdE2t10BgRgiobYqf0U1Q8dwS7LCA9utAs6lceQO6QFKrhBrE5JxE+QVurtcZIzg5FF27WJE1y+ae7PWWN+ZnJpnduNN9P4iqRhK6gWkvfan7aZAQvu5cLjN2PpkDiLjurtkbNRkmrhqCWl/n6CLqqe6H//nRAo1FlItWxJdTyVI0ZfdxxqXoUgsB+gG67DvKeYrqlM754DBO6b1KLyOwjt5RidoQbimWolGkI4YlAFx5Du2ul769i7LBgOtvvRnVK1KLB+oIY82rwF+2F1zfYhdjt/GO6JHLhFxtUZ2abvSMAWDkMm9B0d/msBul2xMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP/exwt39pZ5d1kibZ6WnOqMe7QpEWhkLAGSA5enOe8=;
 b=oetNInbCLof4BdVFXTIpu4sxV3/WfszdkbPXsdT2RnnkRfwbG3HbXPIePBVrz8wrXBSlnwIb3p32Q5nkYHaHOnUvPOPioC6XWdZSSaRY56di+2GZt9PmEb4vKTCTSc235OWRo0UDAYLV+aaU6dl2tMlQwEpkTOfhPwAcsrObrwAWwd05IjgFymchLzbZEm3W4eUEY2bXU0O8OQWgSEx4RgimDYnzAPHUa2kFESGR67n+0F2HBQIoVQjHBcalOJ74vYjo3ErX6xZ+Em1YP2odRRpOzm331waG+pmOOxlAGWykZlzMtlz5nI7vvjw7wgJa251D8MSvjPk1Zjq6j0TlJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by AS1PR10MB5165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ad::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 09:33:48 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 09:33:48 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 sjg@chromium.org, Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v2 3/3] doc: uefi: describe EFI_TIMESTAMP_PROTOCOL
Date: Tue,  3 Nov 2026 10:33:38 +0100
Message-ID: <20261103093338.963328-4-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103093338.963328-1-felix.moessbauer@siemens.com>
References: <20261103093338.963328-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|AS1PR10MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 785dae9f-4574-4961-a6dc-08df398d8fe6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|18002099003|22082099003|55112099003|3023799007|56012099006|11063799006|261022075727099003|261021135927099003|261102123227099003|261021121427099003|261026121527099003|261009223027099003|261022115727099003;
X-Microsoft-Antispam-Message-Info: +KaSPEvmSb089WtYuHP7WA5oSguouak24rhBUAicefwnTqylI8IcY/EK/S8CAAaiVPAo7hHX07W6b9BaeU11EmIlB41oznx+gKboPqxnRq4xqcF2BmHoLiXCoUDpiHc7xR3swIBO6Eg97Cw9MHn6TOIBpu3Sb8wz+qVkio5ntnpmCDhQBfOPZSFxrkAfU+mWtVrQFHq0yspECrblWnh7Q6LOshG6XTRA7+WgR7bY2ro/AwuSCaR2w2HCUghQC1o/VfBNIEVxCMt1ZV+JWe6Aicz94QPxkq4hU1RoiFdCUykFlPZ3pTaUV8b4u0N11xuj+eLt1nYwqoHTrjI/5Fk4Gk5BDQIhg/xuFJErxToPBNJFAvBJ/T7y0TYX8n3jr58GzOiMRhxQSbicapuDD6+vTYC4lfKpsL9XzE/d3RUuAud1N4O8woC2ACJ65qMH7quAAE2bCkdrgvOXH1sI1bRipk0AbkuegyXunoT07uTs4QGVKPhtG8D+T9rEmjOTknsiX1jVcvA/AdW3TP+BZlc9oS2AcRvcLQmdHu8ceumJD8juXzy/nDdXGjnNxyD+iBJ+zosMD/VGbi+FmpGM/mVx3Xzq25C4aZJSipxvFtY9HALOrl2jXVvkmBRjCh5o6oA8FfqjfTxYwnI0mW381kV/r8+fOp0uDAJa4g73TzN1ryA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(18002099003)(22082099003)(55112099003)(3023799007)(56012099006)(11063799006)(261022075727099003)(261021135927099003)(261102123227099003)(261021121427099003)(261026121527099003)(261009223027099003)(261022115727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8V4TasNeAsJfi4KPOSrVF0buswh3U/GEzWmTOWkfgEsm76l0oFbcFXoQt5gN?=
 =?us-ascii?Q?8lzcDvQJ8o2m/NUopObhOj7J8pxb4JYm1KTNe6iS3LXK4Tw7rJyi24Dgu93A?=
 =?us-ascii?Q?AcPwvt1+f+JxL7H6sDkGn2cWzv/ysHdfbdTQZNuNLBfpNwwj+v/T5+zkcgU9?=
 =?us-ascii?Q?v9TWggQQ2j06upYOMS0oVAZcyrWJ2UaTq+z9J4p7fyncFQdlgAt9/vMMWx/l?=
 =?us-ascii?Q?XoxVE1FeQwHxZjutBXIwsnSTmHskTgBWTpLgOCLR8YfmrLRV4qhYp97FUS6X?=
 =?us-ascii?Q?E+QlWynr57BGVPzIAG/pId3oV0EXSMruhdJHWelSEbMhJ5+Gj+Z3hsy6M9Eg?=
 =?us-ascii?Q?8zAl5ZDDBJIkKevX389pgJmeo9v7/MSminosDBH160zgfIdo6IA1Od6RwsUA?=
 =?us-ascii?Q?4l+bl+Ke5PklbwJ6MaYE50HUvljs1vngXJvQTZt6GEWo0ld7zGh60HBK1jbs?=
 =?us-ascii?Q?MPWQoKepeV+Cql61+wtV95DavgDQA9j+f0RYaY4Y6oYSTYlif2Y6IJQnkHiX?=
 =?us-ascii?Q?0puuuKTrsCQaKczhtXLS/FkLvKLxQSjeN/6/U8vyvrtTtukOgpUjH7Wb/Lc9?=
 =?us-ascii?Q?vhliZEubpY7UyMZQipSC2hfsVRqaMr7yeDMcpSc3rTNtx7DncrdaVzMAQdWj?=
 =?us-ascii?Q?Cuhq+syAn/p4pxlQmKI7CavA+8cTu/wzvoCyZ5piEFnpIdzQLy/CJmx+WIAW?=
 =?us-ascii?Q?rKkqOF9JmDt3In26NYmrBSLCPQzzVxBzgIsULnaIlISH1pqDuu1/SCVIdrVC?=
 =?us-ascii?Q?EGuN2h2fYNfHJOq0zu7dWl0anjS9WpCx+doq1OEoLs8C7xc5zMrE5yD/h6Dm?=
 =?us-ascii?Q?IkPD9pKuxRw4z7DEM1LxsOeoKQo2mK7pJtPvMI7BjhV3S54TBH1V216ThqZ0?=
 =?us-ascii?Q?/GiyvgEVfSFz0ai92gf3UCIomRDToixM1Pbc9a0DBtNq4b1n0H2RfQ7j7xaM?=
 =?us-ascii?Q?XXCguI6uOtikfdRw+vBt3pQXNOXs7eJG+wAHHbQ1T8naNzOTgWyjTFEN5tTB?=
 =?us-ascii?Q?r2P6ZEI+pEdUEcB97BuvE9P3T5VedtmSIoui+ei7o1dXbiR0XiMwXRqAj7Am?=
 =?us-ascii?Q?HXPviJiTqvTzYnZKxQ5cRwKjsk8mHA/2BjJ96OgRljKxZIYthDcmKis2QO7n?=
 =?us-ascii?Q?CRfSeDpvdXvOQvKbT12sFalH+GaQFVH0TiH4Kl2R4Jbvi6mxuIUVKXhFxTM8?=
 =?us-ascii?Q?cKmrMjlQypUkuNH0KAS2dAud6XYgCT0h1M3HgwjOpLBFvH5QJUI3VHie09C5?=
 =?us-ascii?Q?H0EH0K6gKc2wACgSPB5/gfemZxTnJsXjMDqH5+WORQXe6h/odqrey7REKz9F?=
 =?us-ascii?Q?gnem4yMt5WyZfnf/wNEHP9ZD9dRgt3MXiyJVIq23ja3w9IRdti6nl2kbvRfJ?=
 =?us-ascii?Q?QhqVxeXNvSvO/LUVnLBYsY1o23O97Dk6f+cNZowZBb4HZ7jqYmUcKM7T4ZLK?=
 =?us-ascii?Q?Uos+uiht4JklPPa2zc0zdZ45rdfrzhpm0h+aXJyLr2x0x79VyEZwffCt3quc?=
 =?us-ascii?Q?7kQCSqRHkQSYszpkkQ9wSR5xlywxVTak8RNAdmIPw6iL88YoyRPdw/AH5O4z?=
 =?us-ascii?Q?kXq/atyz5vYSeHBFhS3f0rdS5bVJvdXNuMicqVnqNOL6nysTyrEZNZrlkthN?=
 =?us-ascii?Q?uaHvY8RBr7s9vvwWt89XVFiFk9pCx66LEQIK2qVb/1CUpi/1cg2lS2OdIrQ7?=
 =?us-ascii?Q?ZrvD1Qbna7j6gMkqc7OVqon3cDUjM47/EgtYvwjd3PD0V7o1bUhkYaiwboD/?=
 =?us-ascii?Q?2hvhd3WtcPrKtHoobD/e80hwdc+N6XQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785dae9f-4574-4961-a6dc-08df398d8fe6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:33:47.8322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibhRZ4pzaPUnWrI+++yeLkng2sKK/yjmOAgKiJWb8OsBk5ShvqT5VR2IgrGLsjfxadR6CJ6BR3xiaUfBJm8z6YPCnuF08bzVkA3ip8Hiim8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5165
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Let users know that the protocol exists and how to disable it.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 doc/develop/uefi/uefi.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 94ddf690440..40d9d0287ff 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -1015,6 +1015,34 @@ So our final format of the FilePathList[] is::
 
     Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
 
+Timestamp protocol
+~~~~~~~~~~~~~~~~~~
+
+The EFI_TIMESTAMP_PROTOCOL gives UEFI applications access to a monotonic
+timestamp counter, e.g. for performance measurements. It is enabled by
+default and can be disabled with::
+
+    CONFIG_EFI_TIMESTAMP_PROTOCOL=n
+
+GetTimestamp() returns U-Boot's tick counter (get_ticks()). GetProperties()
+reports the tick frequency (get_tbclk()) and an end value of
+0xffffffffffffffff.
+
+The return value of GetTimestamp() is guaranteed to be 64 bits wide, but the
+range of values it covers depends on the board's timer implementation:
+
+* With a 64-bit hardware counter all 64 bits are used and the value never
+  wraps in practice.
+* Some drivers only fill the lower 32 bits with the value of a 32-bit
+  hardware counter and leave the upper bits zero. The timestamp then wraps
+  at 2^32 instead of at the reported end value.
+* Other drivers extend a 32-bit hardware counter to the full 64 bits in
+  software. A wrap of the hardware counter is only detected if it is read at
+  least once per wrap period. While an EFI application runs, this only
+  happens when it calls into the firmware. If it does not for longer than
+  one period (about three minutes at 24 MHz), the measured interval will be
+  wrong.
+
 Links
 -----
 
-- 
2.55.0

