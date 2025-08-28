Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB5EC8303F
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 14:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8433A833E1;
	Thu, 28 Aug 2025 16:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="C7YHs2oc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C7YHs2oc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7EDF83335; Thu, 28 Aug 2025 15:08:04 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 753178328F
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 15:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Said.Nasibov@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wwvhFa39hsjU38ElrxlUjCc2KyNu5w8c3Wz5VXQmwA6uDc8R4DjNnIDJWqINgtBSR3MZmBiDffjJoQV5oNaAPCDWQ5hs0Fps5lh2tMpRrfHMxofMiNGtTc99N62WF0skxutSMe/TXMtSYXoxrljPxw9/NpkmLbxMY7JZF8gJodGtgrTthcOvTtfxJ1USDx2vBnqGKkD56uvGTD6AsYBMiXRALNDSibgzDhkhcHUqSdEAzZu9smlL5Yh+mqkp5bPCk02eqh/P6zO9dM3HRB/r/4MQZ1kGhOz5JWvgffDW279gAltyNJrWuBDEC9s27BRPDhHt0ZLAuJvTgdSiu8TgNw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dF5R2W09MARV7fh14b6UHru3O3upHe39wDhQw+4CWk=;
 b=eKOaFg13waoPMd4SFzT/0CGOPe8Zd5C8z8J0+TRpHCH3+3Kl0JeJYpX2+nxTJ6MC8HQUXFKaGR9+m3EBDsZwVF7JhbJ5foGZQnnPuacqU5QwRWhWS9jWuaDofC41zscUYIkGHK+WW+Vxm7+sqjOLPzawxWGaCNwDwdFUr3rcYWANrQ4F3hbODbt0cdH5yCG4WU+HuIz53zBcBEDb3CRjGQhkKbM22FxsIz0mHJWBdzy9clf691Qcw18M72r7NqusX5S3qG3PFmb/E6WRYIVBBmIrcJ0ZUc2o1Qzb6FF7wRl6a25zIXYyZ/XsBlDBgk5NXAke2OkX+Ek/Dv1b05VDKw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dF5R2W09MARV7fh14b6UHru3O3upHe39wDhQw+4CWk=;
 b=C7YHs2oc9EAhlEqnAzWkHNvZo9GqpkNqGfO4ay1x3MKPzP0f1e6aw4TATeKVGMAkPwMD2PCpKrsZhoW1ekFOlABC5USaQ0HeVzzGSynn1kns2Riwoaoi5dDu/nGFVVamumBwvx3UXJqgu6ZE4oI1OuI3i0ACWMR9NEmVQKPzOtU=
Received: from AM0PR02CA0212.eurprd02.prod.outlook.com (2603:10a6:20b:28f::19)
 by DU0PR08MB8255.eurprd08.prod.outlook.com (2603:10a6:10:411::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 28 Aug
 2025 13:07:58 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::51) by AM0PR02CA0212.outlook.office365.com
 (2603:10a6:20b:28f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Thu,
 28 Aug 2025 13:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Thu, 28 Aug 2025 13:07:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIrhDjAklSYnI0RiR0pZFKH7rTA8iwGIm8bvoX9bNCpcJvldZp9Z5QhVBKl7ndbfljNs23VTZFeV8fLg5VX5USZzKzXFhvnARrLP+Tg4SzMd7VBSbxnQC89rwYhgGpJX3o09KwDsMDcGNGKrifM47ZLX1y0ovrV/JReyd1T4zzwYEFfR7rfxyUqX5gBb/hw6xWJSE4J7aynVGNVZfHx/8cOLJI33Z+HdUSoAxZdsBeyu1k5H2eYdZwiK1+S0V2MgcODXTp16kGxdJUxGxtciMM1qi/GAQfn/TUSSJxzpmwMDeMcBq8eVoCytu5FMZmdbDfac7eeplEncERJJ78eeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dF5R2W09MARV7fh14b6UHru3O3upHe39wDhQw+4CWk=;
 b=pA37MRzeotD6bNUtFE5jkiDClXsBGD4Apa9RQD+VQhzS+3DG9tZSbyBk6aGJb+5og1VywkqWy71R6wywPmNHAKGf1H0ctNiQ6IaPRZrt3DeUfOLZeTOZf2/wuKah6zidVTe5Psq88SAiNrCpWZ7VBszQOTuPCS6uwM/KfaSsG2h2vvZQ/xCWvFneDkrOq7jkS2dwJ3TgJPCB/OyEz6FZMmJ3Q8cvK4M5353Vps1wt+IEemhbebWzxrdhEPd27Cx/5HEucpLq2CAglEOOtNfb31sxkJqHnzsfST4bQjIxK2ggDZTLiCE+aCqapx7q8EqC9gWv6AZVM7UPv4Cqe0O6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dF5R2W09MARV7fh14b6UHru3O3upHe39wDhQw+4CWk=;
 b=C7YHs2oc9EAhlEqnAzWkHNvZo9GqpkNqGfO4ay1x3MKPzP0f1e6aw4TATeKVGMAkPwMD2PCpKrsZhoW1ekFOlABC5USaQ0HeVzzGSynn1kns2Riwoaoi5dDu/nGFVVamumBwvx3UXJqgu6ZE4oI1OuI3i0ACWMR9NEmVQKPzOtU=
Received: from DB8PR06CA0043.eurprd06.prod.outlook.com (2603:10a6:10:120::17)
 by DBBPR08MB5963.eurprd08.prod.outlook.com (2603:10a6:10:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 13:07:24 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::15) by DB8PR06CA0043.outlook.office365.com
 (2603:10a6:10:120::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Thu,
 28 Aug 2025 13:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 13:07:24 +0000
Received: from AZ-NEU-EXJ01.Arm.com (10.240.25.132) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 13:07:23 +0000
Received: from e121818.cambridge.arm.com (10.1.199.38) by AZ-NEU-EXJ01.Arm.com
 (10.240.25.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 13:07:22 +0000
From: Said Nasibov <said.nasibov@arm.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <andre.przywara@arm.com>,
 <peter.hoyes@arm.com>, <david.hu2@arm.com>, <michael.zhao2@arm.com>,
 <marek.vasut+renesas@mailbox.org>, <mkorpershoek@kernel.org>,
 <pbrobinson@gmail.com>, <ilias.apalodimas@linaro.org>, <m.schwan@phytec.de>,
 <quentin.schulz@cherry.de>, <rayagonda.kokatanur@broadcom.com>,
 <tien.fong.chee@altera.com>, <casey.connolly@linaro.org>,
 <patrick.rudolph@9elements.com>, <alif.zakuan.yuslaimi@intel.com>,
 <boyan.karatotev@arm.com>, <Oliver.Gaskell@analog.com>,
 <duje@dujemihanovic.xyz>, <1425075683@qq.com>, Said Nasibov
 <said.nasibov@arm.com>
Subject: [RFC PATCH 0/2] VExpress64: Migrate to Standard Boot
Date: Thu, 28 Aug 2025 14:06:55 +0100
Message-ID: <20250828130657.249153-1-said.nasibov@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.1.199.38]
X-ClientProxiedBy: AZ-NEU-EX05.Arm.com (10.240.25.133) To AZ-NEU-EXJ01.Arm.com
 (10.240.25.132)
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885D:EE_|DBBPR08MB5963:EE_|AM2PEPF0001C716:EE_|DU0PR08MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 06893783-740b-4514-433f-08dde633e83c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?N8ip6pwODuspDUZmLHh3PCjrVEq8nIZtp0FZlwTQZq1sdG3Ye74IXPKVG9BB?=
 =?us-ascii?Q?+np1H4WmKRGrVZ1F5M7AHfp/kpPLBG4ybUKlZwKb2xrs4jsOJo/udtd5W6FQ?=
 =?us-ascii?Q?13KEQI+62c8u47SzMG11PDCElnPNbJha0TL2q78cwVRtmcmFNqy1dfxA9vfY?=
 =?us-ascii?Q?CVqtcuU/j1k469uq8hGuoUe34qoVNF2CJkOrf13KyY0W9VUgqltaos+fCgeX?=
 =?us-ascii?Q?UsRy/R2tq/hkwuAPXD3xy0On2ZFc6r0Co7au+mcZ+hrK0BZPWvYczeayakhk?=
 =?us-ascii?Q?qGf/dYdGOr55srHY/PyKOGiqC117hI1liETmAs6z3lm71aNnm50v2vjpta0Z?=
 =?us-ascii?Q?S0xJ3eYUAzJ4IKB4fnk+g7HEKt+AKjC0T8nmH0bCsElYcGkyJL4sMtzYpOU9?=
 =?us-ascii?Q?otOR7BXlPNveo/ge9vSBef+t3hTdxuoVYkycm47HEPJQ7Yl/zlLhUbVK9fCv?=
 =?us-ascii?Q?SYg6APAw7jn9LyiDVdUMP+7sV3u+yBMrUbJpOJeFCAJTf/Z79rGX1HlLgIkW?=
 =?us-ascii?Q?9caVSS5OTKwah7ta2oC6d9bklNnEjcb/qPwqxlqq0ILBTtb7SnEGdRTV5Ep2?=
 =?us-ascii?Q?1FjrKDO6MC3L3HRPzS2UNF1Tlwpf4CczuuIAkpFSW3dt8g+k1D12nfz6yVDT?=
 =?us-ascii?Q?vZYwSRZtpEL/Or6WGCzNj99xRqj/PZGu9NXzTU9S+wMHAbzMzw5jJeD39bY9?=
 =?us-ascii?Q?qMbdET3CUV297T2uJEMPS+rr98HvSSPRS2ywKcjpghvlXa9zlxd7laTTH1ed?=
 =?us-ascii?Q?sVBfLOE8gf3fP0aYA7NDU9Nuw/gtZ1E44ANtae/t+FvTuQZc2B+3C0ufqatA?=
 =?us-ascii?Q?Ezu9CjLE4X1NywFl2ffe2gQsjc5FVBAnA/gIIPCxyKtQmrCgjKXsA90kuXlD?=
 =?us-ascii?Q?lC1IMpLa8gqpgv9ChWo9LXmmnzQnMZySxaYulPUsL2DLWn7yCH7cTaTPKuax?=
 =?us-ascii?Q?U56UfeUeV9sE/gAdyIW1JAB7H3Y95VU2guhiyUTVT/hA300m10GVPg9+BwkS?=
 =?us-ascii?Q?+Iek/imET768TXvYEYstJ23sOMPD7WrjAJ37cwOI9ZMi+MANW2xDgcutF6mJ?=
 =?us-ascii?Q?1Z19VQwAihCm84BN8aSoDZVjS1Bpb1ThGKuQgEbwdaozPpQRgDvfszTb5j7X?=
 =?us-ascii?Q?ar0auXjxkP5dMwY3g3Ee52VLvvjrxziUKV9paL2xXRBcrEHnk5ELJL8XSd/e?=
 =?us-ascii?Q?ld1yo1sg+1YbzBbZwu/qmvmR7+nuHRUpjNBSQ4fhZNPdkjHJyCIKozFhy6p+?=
 =?us-ascii?Q?TaEYMyMqf+g3mh6w/86lBWDpvGRvZm9n0wx6cA3f32wCbNiGDOJvVuqJsgq9?=
 =?us-ascii?Q?jbMxSdU7dW6lujvt301sG4NxGKA5uOXUkgaBvPPC5rRapnhTu0FNCNU8Qj5z?=
 =?us-ascii?Q?eIz9JmYQbNlh2jtHQHkAq86VixUaItOG1l0yRhSMrlbByfAmmKhwc9OcodRN?=
 =?us-ascii?Q?Lb5b5IXIWNR7rVI1Oo6PGhh6ufY6oYIyXWrUlgO+92jZ2aK2JKONzDRf/6Qg?=
 =?us-ascii?Q?zOtzd9/yGKYBtF34aZ/AtqOPgAmTI/MVYIfH?=
X-Forefront-Antispam-Report-Untrusted: CIP:172.205.89.229; CTRY:IE; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:nebula.arm.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5963
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e9f7f1ea-1b29-4a55-4b2d-08dde633d492
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700013|376014|14060799003|1800799024|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U8bUEPu6SNItW/kOqEJNZd4sjLi0Mp2ooxTpekX74klCzLZPMI2QUBbiY3QU?=
 =?us-ascii?Q?xK8AILWMy3yGMRrisLAupYb0PGtwCRgd0jZhOtAnu79vP7jaN53wP7FSeHfW?=
 =?us-ascii?Q?+36H60O7vOlYYYFfZr1OpXrEKuB+oKc5U4IvzDM5lBpIquw9IadLDPqq0D1p?=
 =?us-ascii?Q?AVUW9mPM3ndApTtn/LcSdPu8xdVC08DgjHA7WbRbpcGLQxrw2tkhsZScMr44?=
 =?us-ascii?Q?vIpzxyJsELoIQlhnnPy6zZBmMINkYPuL/HXvAhrLwmZ+wNcK6TWZuoPhmnmn?=
 =?us-ascii?Q?MdVjbRDnmq4AWebSp2yABIj99T7PDRMC8dmH5NGo5/e927Nxkb+oa1Wz7wox?=
 =?us-ascii?Q?GwaoG4EhnHZ+vNb2SPwfrpFtsYwd9VqdutvMGS+J/5WdDszjDG0GHl+2QcqS?=
 =?us-ascii?Q?1UV9P7pYhTUY+gE+c0DIfiECy8M05gxw+9usokDWvjeSsU+o0U91mjP5mBIu?=
 =?us-ascii?Q?tqZXjjVxICH5rndTAxdnAA5cU05ph4RAaJge8UoTkvh1heWH0EgWSt1Tvu1Z?=
 =?us-ascii?Q?EIJawdvPKoxGjpMbLlxH2kFuOYCnnfXeqgLuOo/ek+/Jt//wEfwHFUHVDoRN?=
 =?us-ascii?Q?ZTWdFpAKsi9/hakqBnMpZlEi/Z/K7SvUdm3UmtFD/JNw8PWhcT3tiOxCMgtP?=
 =?us-ascii?Q?D/DQ6uoz3ym9CKNiwHxLHCK4kulWqgk0LqYWJjwnVAJTAGpnW6ApNRHaf1PS?=
 =?us-ascii?Q?6xNu18fFXbHZ3HatPKRKcGptTb5niJbztx8810a/d58ooUOUz5qQt9Zw2oJ1?=
 =?us-ascii?Q?tZC1qZbpGi53A3zO7Pfwb43Sj88Iw+2Q4V2jhZSM/zeloNVKo6sVPpZvSnfK?=
 =?us-ascii?Q?xU44yZ2kiFs7GbmNfTPX9o/XXKhS219rK+lgaGIZ5d3spRIKgsRrVnMehg+e?=
 =?us-ascii?Q?x+ER1a750MnxJlOiy9y0djr9GdLXh+U0czi15KOfXQIoNEphSe4K5/zwu8jE?=
 =?us-ascii?Q?H0VAQynFxfp4UPBUVPmPdEKTYys7WjnncuMcOH13YYKk0nZSEagz9DgP1Ug3?=
 =?us-ascii?Q?0aPZwjfLgS0HDM1fMfvgUdC4C1VLXyMWDHl2cAn90Q9eM6/OZIPESWyiUHBT?=
 =?us-ascii?Q?T+m1R9eeh5CAmUkZ8mjLD4Cm10kEvbqnleHCobNbuN7uBnxgMtnHGqDujJmk?=
 =?us-ascii?Q?XpuvqTmCWO+8ZtvwMtwHsoeZvZ5hC8g6OCDsmd06amkULIsA6utYyO+4L2Z4?=
 =?us-ascii?Q?KVpuTcGZ4UsXmlZg8/T9yWqfE9QfzYYACH6Mvw7UiGUxXAlFvTDdXv227LMi?=
 =?us-ascii?Q?ZVHv55a8ROHeLPPeHe9n4RQcae5qsn4nsJHBLnWh/DkG6Km4qW0WgOjdpsbq?=
 =?us-ascii?Q?zaU3HnDccpl2BYKBqmyYefTasJ9JJPigFqf1blF0hQo91HXpOOGcxHsvHM6b?=
 =?us-ascii?Q?KHpQkxa2FyKfmgArd3t6dbqZiYjFgVBmwI+NWRQ9JhZe/CqQ/MAvqkWfoGpM?=
 =?us-ascii?Q?zU8mm5yv6lU0pCacajXi1cKVE5AvJyPZt8tidNk0JK7dCrlfBpBIc6e5sxMH?=
 =?us-ascii?Q?J46k3HAjLmPNchgyXwuz18wwJMG4kK6OPKYr?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(36860700013)(376014)(14060799003)(1800799024)(35042699022)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:07:56.9509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06893783-740b-4514-433f-08dde633e83c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8255
X-Mailman-Approved-At: Thu, 28 Aug 2025 16:03:14 +0200
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

This patch series migrates the vexpress64 platform to use the standard
boot framework (bootstd), moving away from legacy distro boot logic. As
part of this migration, a new semihosting boot method (bootmeth_smh) is
introduced.

Patch 1 adds the new `bootmeth_smh` implementation.
Patch 2 enables `bootstd` by default on vexpress64 and selects the
semihosting bootmeth when bootstd is active.

Tested on FVP_Base_RevC with a Linux kernel.

Said Nasibov (2):
  bootmeth: implement semihosting (smh) boot method
  vexpress64: replace distro boot with standard boot

 arch/arm/Kconfig    |   3 +-
 boot/Kconfig        |  10 ++++
 boot/Makefile       |   1 +
 boot/bootmeth_smh.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 boot/bootmeth_smh.c

--
2.34.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
