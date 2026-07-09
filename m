Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAFBC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B82CD84ABE;
	Fri, 10 Jul 2026 14:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="BuW+WJEb";
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="HsYk54ba";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="od49p59h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D2BF84BEF; Thu,  9 Jul 2026 20:19:52 +0200 (CEST)
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E5284B73
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Thinh.Nguyen@synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
 by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HnB7F2532305; Thu, 9 Jul 2026 11:19:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfptdkimsnps;
 bh=FYU60nVQm0lhB1+8UtwmYeabs5m6FjVYUzWc26wy4bE=; b=BuW+WJEbSgHq
 QAmuxSjUg2DOaAulKVrucTIVdSu62xBujZncW9ktFvIm2RAD8KZiv9cBMoR4h74w
 72ZSw8AANbxg6fE7wzLf4R6Y/jdX44I+1F8RydH+ve3HFeF8ZiHSpZHP5kIfIszb
 xMfoTAjMOyeTmHvIiZcQYoZRd3bYJ/X9HqISTitDIlPJ8rBDfoVnQGseAGNgkq4Q
 fcZTwICP5+0lFcoapMJVMlC3fW3wHpCZPFyYloudbE4XGzdXFQgu8vc6DqRdQDcU
 dy/vHiUrKsJ83LrwfD5qShSuy3+AsOTQwaC5LkPrjTTpPAU/oqkdU1w4PEyi18Q1
 jHlw8CrqQA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.73.133])
 by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4fagcfg705-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 11:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1783621175; bh=69aKEa85AaZ9gb4TkIu0Uq68LphwrSX5tEj4dAAN/PI=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=HsYk54baoKXVU4a7gAc8/CovPEFF/gVHGqpOm51+d7jHbVYnx9b0kvrJ/s1okOXMJ
 EA3nLDlYEj9/GDdycOQ9oSIa2+UNkaXOgJG27cjh76Z/E3+tDl+olwXeRq3kHJhOJa
 hICyXnVN+kEjoQIOtG+3332Rfq9iRIRogtS8xMt5lO/jp/3B+cEe95PXE/EDF79BPc
 oCCsIRXxIEvvMqaM7RJ5yTXIV1VPNedMqi927c5JPKk4r9ySzv1BwrvS0+G9sLxGl5
 OWpHC+8+3HntXbq2rZE4d6udZcBN9dSvDSft6OYV2w1Abg/hy69nFgeRX8NRvSI66B
 sxw2xA2EXarTA==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com
 [10.205.2.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A52DB4011A;
 Thu,  9 Jul 2026 18:19:35 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com
 [10.202.1.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 9300AA04FD;
 Thu,  9 Jul 2026 18:19:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=od49p59h; 
 dkim-atps=neutral
Received: from BN1PR07CU003.outbound.protection.outlook.com
 (mail-bn1pr07cu00307.outbound.protection.outlook.com [40.93.12.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert Cloud Services CA-1" (verified OK))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6400240124;
 Thu,  9 Jul 2026 18:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSJxQ18cBN73MVEbjkSq//2ToR2zgYwlZa/KirbbaWAn99ZVoX5dT2UXhUTazZDuYTVg/KmqcpJK4F5HHI8bm73rm5W8ei8CLwumjMHxxXyGDcdTJdegsvzSDoWSmO4JKaTatLQX4G4212oo41yZ0RGQVSaNdn4qIrdCElg9fzGa8TMIbLY+ZVoZXZ/0xSDAWDZhdFeANBm4WsTHqhQ8TgwTAHICg/6Rgv0ligeL4D2OYktz9D2zVvgi6Ih+QaZrZM7jvvfCgCK04ulSaG+9egLoBtjhb8EBGkIoW044WkxhtHk/ar883hlNwa1Ov7VXIWp8jBVz+kat3sU33/2sDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYU60nVQm0lhB1+8UtwmYeabs5m6FjVYUzWc26wy4bE=;
 b=Y7D6Ai+Nol4nhxfheOd4hd0R6S6eUsM5rll3ddBTnJyWeXDOrGqgCE40Cah/+u+LP1V1SmpmMmro+wPFyJX1nbwPKSnIdjtB5q7RB+mLZZmwSH7YIS349P1aOwTrvXF2BDgnuC8wf3vobyLU67LMHqE4H93AdgBxmuKbWKysLQTJEcK++7QxtkIzXtIpZmWdy0wlJyt332uwWF/+xYdYmrQYlvDXlfZmGhut8VZZnHvaI7ghi4QG5tsmNjTlOFAq42FyrM3pDDu10cTvXBn7GhmVbMHsCuA5/t2EZbmkdU+Ei29rBMxvhrDenGX8y2Ls5+zc3gd3sjB71sl9I/h7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYU60nVQm0lhB1+8UtwmYeabs5m6FjVYUzWc26wy4bE=;
 b=od49p59hVQHHdTJDu21gTn64M6r2DW7R5r+EDmM7WO9vBaGdu5Rl7sFAYbJV9mtSJwQG9XYi9PjqWHl4OEszVP3IQbkKIwdsgZGmEnt4dzezS/8qmloRmkrOYPHuw8RyrTjMp9A/kKenPiySGVjcLfed6S/mKNPufP4qEFHr/TY=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 18:19:30 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 18:19:30 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Dan Tran <Dan.Tran1@synopsys.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH v2 1/2] usb: gadget: mass_storage: add SuperSpeed descriptor
 support
Thread-Topic: [PATCH v2 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
Thread-Index: AQHdD898FKL42/ZQgU2wYMxfQiq8dg==
Date: Thu, 9 Jul 2026 18:19:30 +0000
Message-ID: <3f9ff728be6806066dd5d5e69d4e177666b46252.1783620779.git.Thinh.Nguyen@synopsys.com>
References: <cover.1783620779.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1783620779.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DM6PR12MB4418:EE_
x-ms-office365-filtering-correlation-id: 536c9132-aea9-4b9e-72e3-08dedde69e9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: biPFIzMpZF8q2liPe6w7+cMPcHvjkdflgMCRswiGwrchY5/uMKaf1N9/QGGivkDX2hMeyx2GCBHmdb5zQhcZN7x5AocLM1ZHHf+Uw5D7nrCv6eYBc6E/MnAoJjO/xYW3rOKy16otd6Lx+95zMIXFlvQ7qIRPwPfGnlfEO/zeqJEAY46lNcvla2aVgcUBl4OIdMSu0kLX/Uc0G+94bgGgntdahDgRbXC9hAUXaU4UR6nlWpZ3OyduLp7DKHcDpBpcYcYAI5udk7lzDYfldS2sxvvW+4MrUlJCoESJ0UfxZvgu8hU3RBKodtD3Ogb3Uf/Z0gE/T2RqjQdM7U707W1/itWvslqrODw/WgQEZhjaEKEdvWmaqHcgptWJZq4DrrwifK3SJvIKaRIEYBz71lQNKkHkwTjmQjcCEHeGGmFFaU27Zp7LyThKBrJ2XosqHkQ/XIuhxpObnRWYHKVsNuN0GALVpDCzpW0WJv8LETAFYe3aVljTAG7mHyZ1u83YTiDaH3SpyCT2LtBC5iFeOvBFEdtncf70GzF61gqBUqzumwa0tszy3BfoJ8KywbuQ1QxIT9Ufx8mgND/SEm8vLnSC8pF3Oh6x72EiPT8oSkhmXEN1Ptem64spLcaZnTw4aIrk5gu/TqhyByPEPuQqg+RGucHWhz5FyRgAKEKmdV/yebV6T42pnzRjU97bOL4C6w7UbCXrgmWyFf5psAmg4sNdgoW9ajSfYqxYA7WNEu3Bnso=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VsdBQ0CSMgMZWcu5nh/4Mq+Blu3zkPW8IlFPQGmkfrw5CLVCrX5TIePSkG?=
 =?iso-8859-1?Q?R9tIxp6kVkhaLd1PrjnHCcvJUlQ855HahEj09yUg4XusbQ5ucTOQj64KbN?=
 =?iso-8859-1?Q?Ph197LDyD342SAcWazz8m9qpMq1GRLgBW15PGCyqpjy5pw1W/XSj0TcWg/?=
 =?iso-8859-1?Q?cJrUNSpy2RnIqHZqp5R9HQbzgncJUZ1jY79BmcoJxaDHm1leBHWadjl22l?=
 =?iso-8859-1?Q?/SXDw/zrl1qWEAX/xanQTlPS5nCbdjECDaBNGIqYe5EgNnwGyy7KomN1Qm?=
 =?iso-8859-1?Q?lHgv/Er08hsiVT4T1W/YSsqLNbzehVkIRQSPrpBHmutTXONQWAR65FP1IC?=
 =?iso-8859-1?Q?mQrUvqwuvsj5+vwZ46Q5gKYF3n38qMDEyeLQYWayceS/IY+eqlmEL40us/?=
 =?iso-8859-1?Q?1VD1Eb0/5jkL6VwiXpSm6gtgfa6OOtqIjn7/KudQv+xNNK2+QiuPqgArL7?=
 =?iso-8859-1?Q?VaSwS8nvhV/3CqufiJc5OctEQZUiYsS/y5RwpepqHZjR8dR649KfFM4KBu?=
 =?iso-8859-1?Q?PnE5/z3CcwTDJ+I2KexkYkpy9zg0P9tzXg6dG3LqVop960jekalWcmhY0y?=
 =?iso-8859-1?Q?h2GOpPoQtUwVyHZ4fkGLci35Q02QzS7CqAizpJYKsDxwmQBwY4UhRCG6gx?=
 =?iso-8859-1?Q?R9jWaWKyN0sfanvBBsVOoCgQ1BdmRtzTcuEARcdTH4KVKyQK+idmOjX/nM?=
 =?iso-8859-1?Q?AdMin7px3fN23KLeqjw3zrz4SvXWW+EtqQXYgtlrg1dQcCi/xNaKKBxBNu?=
 =?iso-8859-1?Q?MITEwWXdwm814vqj+0wqQHz1Mv+MnYcpPUERoaeNiiMLc17ibP43vL+0TD?=
 =?iso-8859-1?Q?Sebq0cAKfxW+fe+4U0+/EnohsCxikehma1EWzXpKHvs1g7E7ZSoaUrlBZ2?=
 =?iso-8859-1?Q?59hiTtPeaZLEiwCkj5wvUnWuyrsbTGBTgmDnppgOLlnYZyCUCUUsTaWwmz?=
 =?iso-8859-1?Q?KIehwbIX3dJmbYcyWwyS6RtELD/2PNiSOQUhE9M/xa9hj+lIioRilYfJR9?=
 =?iso-8859-1?Q?CONx0EgHGjuCJLOXEObF1w+YJ5eRywt12ED1/2CmLiBO56M4yHMrOGcm2/?=
 =?iso-8859-1?Q?xMGvfHUO8j2jivywk++ZZiJSsjCKE/SPMwSLA8tUxWiwRggg+ni0r2zBXV?=
 =?iso-8859-1?Q?EGtXSbzdTKn7CTwb2DdaRWN7ZFEDxhztvJtthpCgNYLhoYfVqq7woNJUtg?=
 =?iso-8859-1?Q?tHZmn7v7WYGkn5ImT1GJtkRDtWuz97qrfeRSLjg98iwfOxYGUZHRkZUnhl?=
 =?iso-8859-1?Q?M4n3kUYJo93JW4afdQE50SZ0LIpCVBqohDY7HE1xXDUev5TFnydznzXW0R?=
 =?iso-8859-1?Q?8Sslq76au3mBI8FX7j03Wg/UVerFdHlImMQqLmLGSSmFtsMyGyBBH9Qp0+?=
 =?iso-8859-1?Q?zHq+SacCsF0sTTLUT7OT02oUnMc6OHssiu3E8dZpg3sS1YngHAZc5JFbYa?=
 =?iso-8859-1?Q?mUnZvxFEwpLaIEP7ojHQ9Om/bfu42LZDNupivS143Mls78EhkzYmEGklPx?=
 =?iso-8859-1?Q?H7U5kp8hy/NNJPIX6B35/SgbseB5HpL5DDEsI3rizBqz2/XtAO5hM4yVve?=
 =?iso-8859-1?Q?0xyd1X1BwPfxUoeO9tWDgOwZvTHN9e9xMLh6WgFgtBPsOnOjfAcNK1BWPO?=
 =?iso-8859-1?Q?ZmoDWa2Dy1wCSPtI4Y4WDWpB42UAv6kf30Qn7GC0fubAz8L6Qydx9qfkep?=
 =?iso-8859-1?Q?HqxFeNyC8d4b7J0sINTFujlqB/fFBRyAdcO9BWDx7lhqarrca0Q2tgZu+8?=
 =?iso-8859-1?Q?LbpZNUnusj6e/VbRYNcw7e2d7GVhc+UxbmJIt6brQzl6YS7ZNtFRZbNGqn?=
 =?iso-8859-1?Q?ebTjEbH80A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kiwTVEQ4Piclkd+110xKtDFjMI3NwJU2+S2lQeRWQcKDRLTXiQEC5ZEYQKJWEZJVkzU0Vqy/Tyn/fi0i8KDZlbrgt5iSbeLfzUBBpS7EiAta08W7wIewyOOejNRFlzgz0UvAwIsJq8028BR0yd1JspIzbubw27Vnm63TY0TLDxuWyI3WGs4K7NRoxQ4DHl5pKhKK2ZggeIoO8sSRvujalBENV9iWdcyv3meOzmABVtI+Ckg9CG4+0fY5WI6DbLvW6v/AVucwXYRXoko6KR4S1AMFxApTXBFHecXAf7Zw/8Qk+p1Awv+NkwkSHgYnX6quNrrEet5hl4JEeivw4/HSlg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: usKW3bHbRM7GjAHMUHFxUNQUvQ/crS+A0ah9zoOGesMMmFS9LbP2BWK0nxCykUzsp4XJmayvc7ATG6GyjQV6HZcZGj8Z9a7+uXJGcyqdDlAuZPJRrKEhf56quBrbASYzOK0buf5vtfwgBxWGEvhDMJxCD0iOPIOvVWMGqEBZz+nFtjs00PxRlV0K/LDlqVNab0F19novIWWoHvoqvPhMy90GD6TWBaOULvOfRn9cbOdLLTbHvEed3ykk/JyFkWKwHmzGpFYb1BNwws70wWtpC5PuLL0rSdcrtfNJrOzpJ+BFL3ZZtW9j9K3AB5gva/6QyhGgtvSajBEcClwWKRG9VP6aiR1BO/DuQSZSgDxFy6HZSg2txu9zleoowJR4EohLynfOO7HgjRm0zgG+VxTUY5QB9I9CeSfrRI2hBmxM3hAWna/p+4HWmXGX3TFk3di+1TLteNajkRXMoUiLB39fabyZqxkGDMZ016eWHz3Qub//VBz3EQL+jOX8MEGZ7pNexAtcnUTghSTKuzB0RfD86eMt8JaGjU7PMSxsafUljrgD/ug+I1ORczLYUYk6UOVx946H5o5AnfuOzoyHTKtvAN3dRH8XsN8KtS8iENPJQZAEliNRAhJLaKWp2M95+/kHHUFGJLlWiGo0vpJ9aJ2oJQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536c9132-aea9-4b9e-72e3-08dedde69e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 18:19:30.6246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T62IyZVXIR7tlCvO0sac2zyxE1D7Mfgm0B9FgcnB3wY6MqC68OtqQniPHtsSks74zUeIxqn5cyBBODvy/ka/MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
X-Authority-Analysis: v=2.4 cv=NcnWEWD4 c=1 sm=1 tr=0 ts=6a4fe638 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=jIQo8A4GAAAA:8 a=UoMAnIRK8_7dL5_KUCQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: YqkuGhGS_M73HvSLjg8I84F4oKpW7Csq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4MSBTYWx0ZWRfX6kq5cOFcSzym
 EEDgrXZHI0/ztcJT8HLWX+6VhpUGe1UkQhTxYgIrhNo/g/w1H7DiI7qqM48MSxBnAFXYWQswDUj
 hZ2nlCDApsUtB+YKjdJTmcn7UtzDsqs=
X-Proofpoint-GUID: YqkuGhGS_M73HvSLjg8I84F4oKpW7Csq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4MSBTYWx0ZWRfX0kzaYPetw16E
 UgbagpNGQhcBlEVo8n9VDGfgEG/agD8yCVhRtidUHZU/+RK7SsQFFv7+FfLtYpZbBM/PY+2xdWN
 hEO93Y9e2rzGPfmPWjSrZL+ovx43JBs82fn/XCobXrEgXL8pvh2O1sZw9h1Lnuy8Uhyi7FsRE3A
 EUoy2pgruWu6+zg3owTR+HGw2QECrsKvsqp84j4UdQFQWXeiAmOzxJMa+B5moEmIQ4arlN59zXp
 S4fWYVOsZSQEQNqwAHJp5WDbmIDhVqhtR6F+JJ2CDxryVBK8f5QwMYuVQX4jaMXU5VjKyaQYxUV
 NFXp2nC9KVut+iW+5KJhVON5OST1v9rrq0NaBeGrzZTzVazaY8GDTHtCmygFjj0h8SfqBeUAdWC
 GgNm3VzBN9HfRX5dbdIWb2DsVPCJC/QKbP/UOJ1IHrrfwpBKIzn3BT4BagrgWziGaeH0EErHIR/
 zU/1DEoQJqVhGsAryeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607090181
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

From: Dan Tran <trandan@synopsys.com>

Add SS bulk endpoint descriptors (1024-byte MPS, bMaxBurst=3D15) to
storage_common.c to support SuperSpeed connections. Extend fsg_ep_desc()
to select them when operating at SuperSpeed, and wire up ss_descriptors
in fsg_bind(). Free ss_descriptors in fsg_unbind() to match.

Signed-off-by: Dan Tran <trandan@synopsys.com>
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - Removed internal Reviewed-by tags


 drivers/usb/gadget/f_mass_storage.c | 25 ++++++++++++--
 drivers/usb/gadget/storage_common.c | 52 ++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mas=
s_storage.c
index 87ed25e8bb3a..a2f34c100482 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2225,14 +2225,16 @@ reset:
=20
 	/* Enable the endpoints */
 	d =3D fsg_ep_desc(common->gadget,
-			&fsg_fs_bulk_in_desc, &fsg_hs_bulk_in_desc);
+			&fsg_fs_bulk_in_desc, &fsg_hs_bulk_in_desc,
+			&fsg_ss_bulk_in_desc);
 	rc =3D enable_endpoint(common, fsg->bulk_in, d);
 	if (rc)
 		goto reset;
 	fsg->bulk_in_enabled =3D 1;
=20
 	d =3D fsg_ep_desc(common->gadget,
-			&fsg_fs_bulk_out_desc, &fsg_hs_bulk_out_desc);
+			&fsg_fs_bulk_out_desc, &fsg_hs_bulk_out_desc,
+			&fsg_ss_bulk_out_desc);
 	rc =3D enable_endpoint(common, fsg->bulk_out, d);
 	if (rc)
 		goto reset;
@@ -2653,6 +2655,7 @@ static void fsg_unbind(struct usb_configuration *c, s=
truct usb_function *f)
 	fsg_common_release(fsg->common);
 	free(fsg->function.descriptors);
 	free(fsg->function.hs_descriptors);
+	free(fsg->function.ss_descriptors);
 	kfree(fsg);
 }
=20
@@ -2701,6 +2704,24 @@ static int fsg_bind(struct usb_configuration *c, str=
uct usb_function *f)
 			return -ENOMEM;
 		}
 	}
+
+	if (gadget_is_superspeed(gadget)) {
+		unsigned int max_burst =3D min_t(unsigned int, FSG_BUFLEN / 1024, 15);
+
+		fsg_ss_bulk_in_desc.bEndpointAddress =3D
+			fsg_fs_bulk_in_desc.bEndpointAddress;
+		fsg_ss_bulk_in_comp_desc.bMaxBurst =3D max_burst;
+		fsg_ss_bulk_out_desc.bEndpointAddress =3D
+			fsg_fs_bulk_out_desc.bEndpointAddress;
+		fsg_ss_bulk_out_comp_desc.bMaxBurst =3D max_burst;
+		f->ss_descriptors =3D usb_copy_descriptors(fsg_ss_function);
+		if (unlikely(!f->ss_descriptors)) {
+			free(f->hs_descriptors);
+			free(f->descriptors);
+			return -ENOMEM;
+		}
+	}
+
 	return 0;
=20
 autoconf_fail:
diff --git a/drivers/usb/gadget/storage_common.c b/drivers/usb/gadget/stora=
ge_common.c
index 7e4b542f7ce5..d745649eadb7 100644
--- a/drivers/usb/gadget/storage_common.c
+++ b/drivers/usb/gadget/storage_common.c
@@ -531,11 +531,61 @@ static struct usb_descriptor_header *fsg_hs_function[=
] =3D {
 	NULL,
 };
=20
+/*
+ * USB 3.0 requires SuperSpeed descriptors
+ */
+static struct usb_endpoint_descriptor
+fsg_ss_bulk_in_desc =3D {
+	.bLength =3D		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =3D	USB_DT_ENDPOINT,
+
+	/* bEndpointAddress copied from fs_bulk_in_desc during fsg_bind() */
+	.bmAttributes =3D		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =3D	cpu_to_le16(1024),
+};
+
+static struct usb_ss_ep_comp_descriptor fsg_ss_bulk_in_comp_desc =3D {
+	.bLength =3D		sizeof(fsg_ss_bulk_in_comp_desc),
+	.bDescriptorType =3D	USB_DT_SS_ENDPOINT_COMP,
+	/* bMaxBurst set during fsg_bind() */
+};
+
+static struct usb_endpoint_descriptor
+fsg_ss_bulk_out_desc =3D {
+	.bLength =3D		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =3D	USB_DT_ENDPOINT,
+
+	/* bEndpointAddress copied from fs_bulk_out_desc during fsg_bind() */
+	.bmAttributes =3D		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =3D	cpu_to_le16(1024),
+};
+
+static struct usb_ss_ep_comp_descriptor fsg_ss_bulk_out_comp_desc =3D {
+	.bLength =3D		sizeof(fsg_ss_bulk_out_comp_desc),
+	.bDescriptorType =3D	USB_DT_SS_ENDPOINT_COMP,
+	/* bMaxBurst set during fsg_bind() */
+};
+
+static struct usb_descriptor_header *fsg_ss_function[] =3D {
+#ifndef FSG_NO_OTG
+	(struct usb_descriptor_header *)&fsg_otg_desc,
+#endif
+	(struct usb_descriptor_header *)&fsg_intf_desc,
+	(struct usb_descriptor_header *)&fsg_ss_bulk_in_desc,
+	(struct usb_descriptor_header *)&fsg_ss_bulk_in_comp_desc,
+	(struct usb_descriptor_header *)&fsg_ss_bulk_out_desc,
+	(struct usb_descriptor_header *)&fsg_ss_bulk_out_comp_desc,
+	NULL,
+};
+
 /* Maxpacket and other transfer characteristics vary by speed. */
 static struct usb_endpoint_descriptor *
 fsg_ep_desc(struct usb_gadget *g, struct usb_endpoint_descriptor *fs,
-		struct usb_endpoint_descriptor *hs)
+		struct usb_endpoint_descriptor *hs,
+		struct usb_endpoint_descriptor *ss)
 {
+	if (g->speed >=3D USB_SPEED_SUPER)
+		return ss;
 	if (gadget_is_dualspeed(g) && g->speed =3D=3D USB_SPEED_HIGH)
 		return hs;
 	return fs;
--=20
2.53.0
