Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003ED606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 04:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TuI9w10X;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=RGaIP99g
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE3AC4057A;
	Wed, 28 Oct 2026 04:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YuoYwaTyrB3z; Wed, 28 Oct 2026 04:39:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C1C204058A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793162367;
	b=hbOxaQRt9MIuUYA6Dqc4MLicrCJk+aP3ak41uUSWqgVBkqnpO/U05apjC+vZYJU31q+h
	 n1/3MmHdmRy9blR5RLVyaRKr4tL2rErpypDof3Y3WlGzBaRtqwLwCtU94JJWc03b4OWn1
	 MD8FlzJpPKEdmsqxkp6ZDyaYWE5Evhn7xrBhJN8QOw15Ht2zcYnHVqbnFeGBRiWHTaozz
	 qaZK+VcyAV5D+wShSo0Wu5zafdHUc3TrIFfGt0olbIgsKkhcZ2X8bmg9ym451tDcidq/3
	 CHQ7vyICQk57ebgkP5Pake2IGjByFaWhJS9JleocN4OFm5AmvuHBGI2wNtiR/rDbUGA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793162367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=Jr/yOG4MNDZ0LBrwl6dlO8huNwfilsziotk3bnDgQm0=;
	b=ieMuEMBcp/11UiWh/XmZGckXdX5pUvfMY97Hwg5wfX13GsJXIqfD5JaEvInBqXy1s9oG
	 85RSfyIRMSgFQLOY3LGeqKaer60e3uWVEiwzy8UeWOZH7sXylpPha6Reyjch6B2o8YJXk
	 7O4QtLaKlFO0oKYi1JZkemrxVg7cNTGtc/9NSSzUei+NYY9SCIODwdxlAE71Rp0+N5R1N
	 9umzgQPqCXMaWsHY90NrXfZTOtw4GbDkA42SvDFGK6n+RMAJl8LN+xsHIvig98Oh5wu5t
	 qlbRkBIIvdfY0jBXvbJvlkLSFH+QNSA2BRghS3HgceGmDB3F1uoWDjjl5NqyRPxP/Zw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=processmission.com;
	dkim=pass header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=RGaIP99g;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793162367;
	bh=Jr/yOG4MNDZ0LBrwl6dlO8huNwfilsziotk3bnDgQm0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TuI9w10XDJMM8AqOtAenZkMFGJtMoTpCB7otiDQBRmBWryynrIOsVU9eNbBRUMBbP
	 B4OiJ5Mi0w5oitXjgI+FoqtSiG9jGXcGaLgyecUsXjuVD1/FZfht819AdxoJGZi0sU
	 P8nipyQ9Qv3qDVD2jkoNcZJbzkKP8aRr9g47SnXGdBTu4OdBDnJhObcandnE4mqxva
	 OrSsSn3isRJ/DRBVfwFikb9VofyRH5GeDS8EegZR9euonQz5qRGHPtUdphbhxUzy4U
	 Iefzix0eguO938gJ7cHAEJnKIn3P+keyaI9apb9gWWHv2KeBziaT34ta4uZB9EHLok
	 yKsPgUr0fy+Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1C204058A;
	Wed, 28 Oct 2026 04:39:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE7012E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C01AE40576
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oiVXJVCe_FgM for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 03:51:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7DA2F40574
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c405::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793159495;
 b=EYahp2CpWGjY7CkV+MgxI/LsSbZ4luvlHY/urF79CIKpBBUXO9Qtc4ZCGO7z4yFK2p1l
 DiCUVrYwSArBLBh68ZnLOtTZ+6YfW56E5ja+maOikslD3gX1ZgUxkSSvpbtZTtaf/VOyF
 O+qDMpWq95wXtC6UgLkIbPE/5LDiDpljO+ZhX4yyc8Z2+fATKy+aMrVLc9qSstLLjfiJD
 bZZj2FGcI+EMvVcO1TT2n+7AH2wiyf1GW2xw+hJD2i66R1mVDH5v2H2PeSHA9h9DtZmYv
 5JEz9MnVUqXvjZgWK+jDbTbXnhOc+FaGsaZSCpMpI6yYSinB9KitXi4cImAd6/5qFxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793159495;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=Jr/yOG4MNDZ0LBrwl6dlO8huNwfilsziotk3bnDgQm0=;
 b=ktFk43cxVvX8VRXU6at+C33PavFyF12MOWB2Rp4WeYn9GUmOkLNrwXWPNtxuS948Nd89
 8szD1hHVkb+ViINFLYjH76FGoq2wv2rB98/kIbiZ/VuF8mWK3kQoa2AoRnqAZS9moLlNJ
 3vIAbifUZihz73R+HHD79C8WZOQ2F+sCrpo1M7/ZDB9cj4ckmHLXYqhywYPGHM/oQSPwX
 h5tqqWFqHBu1eVom6ZR7yzaMEl0xp+37Lne5r9X7et3zcT9/ooFeq/xCWbRFk6d58rMAn
 SNeolkjT5JtJ0x1fNCICOviowxSZI5MXjzGkF0PTGz5UxOwDC9uwF+R153W2KJai9lQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=RGaIP99g; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c405::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c405::7;
 helo=tydpr03cu002.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=RGaIP99g
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7DA2F40574
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoAOvDGhrAy4uB/jYR98TYjidt0fZJv+lJf9o/CrN35w66kRfpdiltsBqJkhY7Zq8AQXIbnP1ZL1BEYMW3DjE80NpsUd5Xv8AsoGyu3O1Naj4WSabwhC6xRIyr68HgRLmA64QFkSULuL1bUi65I9KNsw58iWQd+4CNlWRv073bFL2h72AsrhuFbMz0DADikMi5LEX9akZcotoB0aXTaNLeoldV1qh7Rp1VS+tVPJHzuvd8EZJI7Wt/CWvelNCOV2oBjYcs0K0rsute1M+t8g6GKFuoxo+KyhoShMvc00pU+IJgew/77C6mGOZSPsul3CpMNECWUSgTzHRGsiryU4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jr/yOG4MNDZ0LBrwl6dlO8huNwfilsziotk3bnDgQm0=;
 b=DgLgC5de7WM1iGnxoL4QpVQ9wZsCeGtbBEhj8cc+qV8v3DRM4G0qEQhJa72HI73Evk+JcWidtSbgv3RcowsQ/DZX+XR6N5cuhhdPWXNsA54lNWgTevRyaQ2r8InUUSFksTCTZY4YaxMyTjN4y885hty2UuHmcIM+aNWeUuKvvsI2hwm0sNL2iOQikheM3kB7XjTmOzOsmrD+TnwDrtUyjYYdB3vKSAvcqkr8mgx0KrNdtbSxp38fLCqNuGYFmANV8kHGb4eEEr5fAVIDaoWUnHxoHnNqXhpOoXHgGla0JJg7up9quM9n+YMAjmLuvMje4QRvmkUadCAh3DR/363BjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jr/yOG4MNDZ0LBrwl6dlO8huNwfilsziotk3bnDgQm0=;
 b=RGaIP99gggDqnGiUs71P8x5JlUUBGaOSYVKB8U2M8oekjQwpOluQfKtH8iUtI2x/IBGp+BnGLxB7E2IP9+H3gtgNlLMsEBaX/lCuiXyIi9HAyhM3LJd9Q4Z6HwaKE2KrknRvIXvB7d2hGyU9bZ1RWcuO9ERekW58sA+fwscPDlkseAjhBdELZOPom3FV3RRSlpG8zUn+LvHla4DRm1vnSBjOlzV8jtCWiV4xhhneCAZUgN33Hn0ULjQK7dqUhDYnr4vnASSQ8Oj/3DjLaq1qudb7Y8hUgfQrrIVrvmBUJURMqRuiy7+eJK5KSV7L0zoRSIfl0geD3DtkaQw0PTRMXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SEZPR02MB7470.apcprd02.prod.outlook.com (2603:1096:101:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 03:51:27 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 03:51:27 +0000
From: Bin Meng <bin.meng@processmission.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [u-boot-test-hooks PATCH v2 1/2] bin: Fix the broken symbolic link of
 qemu_arm64 config file
Date: Wed, 28 Oct 2026 11:51:06 +0800
Message-ID: <20261028035108.2910329-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::10) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SEZPR02MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 9119fa97-bc86-455f-506b-08df34a6bdf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261026140227099003|261009223027099003|261022105027099003|261021121427099003|10067099003|261021123027099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: cdkDs/L1yCfjPjYghv5qLtf02wF+QwYcW0RpP+eUfZAsTJxMeOsT22FcqUjmaT4Cg7FHi4i6mfjmn9wTYLNQmXV9hU+LjQQ82uoAGC6r5XKjyz/GAEKFUPVDICESJMYbEvcbWMLAg769GSErsI1Nm4CVM16oHY1jgXg8rYe1/EgenwCgj2fH0Hmpa1mi8/2byh1i7Sa0NnvGviZ2F2VYHiV2b5ApQdlurqCFEXuF+SAtWs1bGcDTmLhhtAHn4ot7Zn02vBgFy9kvP2TTb6G0bR7W5+FuPBdkGlY6zKG2tJo2tiNC9wWaC/e0Oh5JD5oIGPOxmhcmWWHAf8aoQWy5Swe5IHmByNvmLxqzq+dQGa9xWp5hNfnWDsBYsNs28Y865L0OmTRUtLZbTIH0H/udCEuWUPx4wv0J1Hj736rkneMtI+mhgUcSzZuNtTqrt4h/kqTODEfWXNYK9ybZk7QslfRH05LfDQ90RmxNzlXu/s4R07PP8Sj5dvAXEU8Nch84h6pG8HdWE5cirIKC3/iy/pquexhlitd6kvrAeFL7YCLigYc9T3ijDd5Tgj7z1HUz8h48XNhxExzEPhwPoAQ70EgWztoya7jhCybCeOMEtCLRgiNHNCzPhgnHTAfWGW9SWL2yrkAP4se6j1BgnSGLhNRn9i1BUV7idfs+dzhXEVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261026140227099003)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(261021123027099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2glTTtMaOU9CPS2M5XZtj9kj9OHB8vZ7vgW8s2BBrDfn56Q3J1DMkpnpycKa?=
 =?us-ascii?Q?ITqvMo2ykGda3LEAhw/vZa2oZuS+QAjSC06VTQAhJXmb2jJuFUuF0Jp1y7jq?=
 =?us-ascii?Q?xUXv6DnvrAWp1xChT94fklEymbZX5/PdxdqN+RTdix6RSUInK+MXIuQEj3+d?=
 =?us-ascii?Q?aRsPmtjB/zWZHuWwAshQTgUsifKh2Od1nmkgrVJBfrXMi46mPWNLCIQCOFHD?=
 =?us-ascii?Q?ynLZ5ANF+tZzdW3zRyURgPkCZUerTfQPQcPDk0aBN/vJcJOX7907H72QS5Bb?=
 =?us-ascii?Q?+xmAkbOhDQda/0FVXK9Q4f+9TC0TRUEnQLZOVwMiQCtIDXg1LfyXvjZMJOAm?=
 =?us-ascii?Q?ujHBBdzts0nhEQaD+0Us9ksZh+Lb/9wsRxxGQA9qM4G7IubJTsgs9ma1b+WX?=
 =?us-ascii?Q?S7BgavXxLO7vG/Z8pYSjn2mPEkcy4vs+MA05Msjy3m2XMoO+1pjTDfl5xmyu?=
 =?us-ascii?Q?EAiGjZM/X5Sw4xPeTrzFuVhkqb/XRCesTv0NriylJKSwCp8xXeztcLcL/7fT?=
 =?us-ascii?Q?F+nOhZVxhnofa8q36WFQJMZIeQVRHi5RooQNrq6il0WYFYEFVPdxMZVubH0H?=
 =?us-ascii?Q?/zTNR1lWeM4QLpqejkw250GXb9MpsulJKd0q5rFjdyFRKB1nlWIFOvOgqL/r?=
 =?us-ascii?Q?jhN/9A6R6kM8B4SAn7o1CW5CWCHTAFTIaGSZRLhnG3+0SKgQvGNuUYniITC9?=
 =?us-ascii?Q?hHxWIhGUDxNhxWwMGwaA084U66y0+B0dFoRiQyDLOjICyo6jr9etMr7Lnb/j?=
 =?us-ascii?Q?oSCG7DStx61mUspf5Sm0zL+ZT+DCIyvmLfLHBuNkrD0VZ08v48ybxvSdPiaq?=
 =?us-ascii?Q?rP4/VdT2acxXR882DQryQl+1cRpD3wwD5kumQYhXnUZNSIAnSO9FuPuIJ2u4?=
 =?us-ascii?Q?LQ7BW5NkMjXEHc4gGpf+GAq7i6PvW8yH3kRZmaGhkb7BooY0gIzDkbRBbC+Y?=
 =?us-ascii?Q?+x1l7skozi4sqQ53AO8Fo5tEW3sTJlKEcXzo6hgHFNlgBUZw5Tjoimv/hWHg?=
 =?us-ascii?Q?XVeFESC/Lz5C5MCTTavgiNvD4CVkKBJeXdlc5NOXoSLJeptEJm64ekkRuHmU?=
 =?us-ascii?Q?XzL9JRafXuL9lWpqH1Ie/YAtXjsH5ORJ274O9OQGIXn80Nipk2Mhn5VqgGQj?=
 =?us-ascii?Q?BSXDzhrDZD1yD6yNbeybVSOFpK4Ou+mglye2OR3D8F9pzLgvIhzjiU7gXv84?=
 =?us-ascii?Q?71R/Uw8nrYmHZePwKvKNyXlrVZP4/D+jaq7g7nWreuCkWPUUi6n17Z6swYex?=
 =?us-ascii?Q?I7S2ptT/T7YC1VYyyRiwd4IIkyxovF3sacJ3zOEImzHC+K2ymFqqlS33cbXw?=
 =?us-ascii?Q?KZ8EyFTQ9EbStr8wSwFbJ9YhVNJIFeFS0HW/SCUuLkSEXeeI+bfH+lkewKTU?=
 =?us-ascii?Q?I8ezCMVUhN6MnO/2r+0axTWw1ULvYCxHDEO69y1bMC4jSmMMuAUNmSV5k0fS?=
 =?us-ascii?Q?WKwU8Gd7+IT/lvT2nyWDAXEFFeRgkFR3UI4e95D07hJ/TTBz2uoc8L5yzVqT?=
 =?us-ascii?Q?Sa5frhcZ4mGqOyV3J395i6wILzKHpZmHUFQuyquxQvG+xbrEpyKR9eLQbaIH?=
 =?us-ascii?Q?rM0uvZCzH7Br1Kab50/x3uIfqh+lrz+5xx8ju/mws7awJ2Ho1s86P6+l0sqi?=
 =?us-ascii?Q?1nycL8VFaPV6D3Ur5K2bEuRyTVN5aUh/8cuzjIZCM7ysQp9SobtgpHrZ+2Pr?=
 =?us-ascii?Q?feChpbB2Rs1hjZkB4j/8JJ2ouNQuXl/bX3b+uwgnfUGNUmnBx2qy/qKdmZSs?=
 =?us-ascii?Q?7EOwaXyTZvwz3eG3scCJXzJJBCUP9qM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9119fa97-bc86-455f-506b-08df34a6bdf7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 03:51:26.9737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ktkB3u357CHQbnIvsXVIoEirL0/fLfOHwU+yPv12lqg2c/IJrxlSJdQxCBfnr64H+Q9QisZWPSwicHH4aQE5eKB2m6iSHacJpcrUs8aAiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7470
X-Mailman-Approved-At: Wed, 28 Oct 2026 04:39:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bin Meng <bmeng.cn@gmail.com>

Commit 48a0f7fa9619 renamed the conf.qemu_arm64_na to conf.qemu_arm64
but it forgot to update the symbolic link in the bin/ellesmere dir.

Fixes: 48a0f7fa9619 ("bin: Run the conf without board_ident as default")
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 bin/ellesmere/conf.qemu_arm64    | 1 +
 bin/ellesmere/conf.qemu_arm64_na | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 create mode 120000 bin/ellesmere/conf.qemu_arm64
 delete mode 120000 bin/ellesmere/conf.qemu_arm64_na

diff --git a/bin/ellesmere/conf.qemu_arm64 b/bin/ellesmere/conf.qemu_arm64
new file mode 120000
index 0000000..dee6855
--- /dev/null
+++ b/bin/ellesmere/conf.qemu_arm64
@@ -0,0 +1 @@
+../travis-ci/conf.qemu_arm64
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm64_na b/bin/ellesmere/conf.qemu_arm64_na
deleted file mode 120000
index cf56db1..0000000
--- a/bin/ellesmere/conf.qemu_arm64_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm64_na
\ No newline at end of file
---
base-commit: 59437fd1c7a6a84da05efe5cefde47264f78dcbe
branch: qemu-arm

-- 
2.53.0

