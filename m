Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1121C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 10:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B7D381F32;
	Wed,  7 May 2025 12:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="FGF3ooSo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7479F82163; Wed,  7 May 2025 12:58:56 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03B68059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 12:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/6/I2xsVvwnLDVjIuEwoKjs+NtM6tlB+cuUgDo0EH4irMt9eEltQxKpKySZFgRFyaLAge1DkeQ9+Bb1U6Ej7YCQpRbNUsbIc1lAnYy5iZe2NgPvwYqc3vcaygpM1UICLjB+5hE/nMaHO0U1T2crdwvHNrp5ffmA3cotDece9UmV6RxBcwMKrn8LrPE+QKammIYFDQriYvlH0p3JiER18bZPAQcj0RHNNbxWX+rBXekftlZKkL2HrqLltI4K7GUfwKUz4DtUAP9BQwFWhF7y0hFd5vpSEWi1fSmq+Rdg1yA6sz1qSFTY5SuBEr49UanedtY3Or7KJCynT+2ZiLUU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k235SZUDY5Ajb/cigWLoToXbFynbNzsSmOOLDym7UKI=;
 b=jLXpn4+055Sbi0Ci8PHBsq2rnXIzPL+ZV3Tbgax8IJoddjKrqF0E8edQGGmXWdbBmz0T5WwLqvmmWd7wzQuBQ/gSXNsD7QzQcQcUwn4Fqv8vtaKbAwhXb9YHSCeqK0rJHaPs08hNsIUCPypHvSk8iT3nsLl59f7HG0jGVFn4NLuIVCxegWYstftPpLbl8xUKIUrkH1YFsFVO4GSdDPz64A/CZy4i/ldiM8gsQWq6omJeAKAsfMtF1HTyRhhYCJ+UVeGEntFEhUIgMc+M6xj0xrz+Rles27mQBFkw9xKDvNJR60VNtN4LTt+6l3FcVs5k84stNF4Uc+MQYx9dFyEzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k235SZUDY5Ajb/cigWLoToXbFynbNzsSmOOLDym7UKI=;
 b=FGF3ooSoLGM+qRdHAOYVuZn5rB6BGfVzhrpQlqyzoxoE6LRVhBotfk+GFL8EIOb1iiGdI0SmnVBeTIzN4uxfmWkpv/aQ53VD+EYfUncHHwlBl3bCkFaHufg967/VBKFociF9UiqYFeAhfMKSE1T16wLGnLIyLpXMG98xh4a8Af4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB8807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 10:58:48 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 10:58:48 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/3] make cyclic_(un)register idempotent
Date: Wed,  7 May 2025 12:58:18 +0200
Message-ID: <20250507105821.484442-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::19) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bebef35-5a79-47f2-3cb6-08dd8d5624f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h1r8Q6JcHS8OX1KbNxYHIsKS9gOKRRC+53kROu2mDKXuhCq9VY2lTYKakLUu?=
 =?us-ascii?Q?whUOAlWl+y7FYMITWbSUKtTpDTQifo56Xrgg/u/0i+xLKrfdPybxhRx6K1Bx?=
 =?us-ascii?Q?IS4WyHXU6ga/ZXOOr1qWXYCl8stJUF0LbO5jJ8KnAqcAK+Zy7sUXAxW56Fxl?=
 =?us-ascii?Q?+v3AURuYSDLhSTGg0xCVG768gRZt7HH035OgL+8nu8+B7fBQRuxeLz4F2m9M?=
 =?us-ascii?Q?eHujXHpjsP/0h1F8z8qHB0kRgeZynMUOfDtad+GM08SwElFYl1yqpvYqxw+0?=
 =?us-ascii?Q?sLl/Q6elNJmvPfqOdZYKYrUJKPUbdnRvE+DCQLtlFvuvY80oMQxWcKYV0xSx?=
 =?us-ascii?Q?A02T8j9ld00lc7ImmN94EXZJ8LG/gv4v9EViD4xBBBE1liC2domDNGjITLpY?=
 =?us-ascii?Q?+MpPLxmHqjRpj6X6U4xMy+TvMVsnObYP+1cWxUimCXA86l51Umry500vA530?=
 =?us-ascii?Q?KPFOGKR0bmiUExElFGrPONgf24UoY7EbBPVx8FMGOkucQ0kfKyWeJb6tnbKF?=
 =?us-ascii?Q?46qGy/j1I7UrMYiIiY10F7Qw2hqv/2VFBWEADMU59goowanEvqHKh/HXgikk?=
 =?us-ascii?Q?5w9GlwUCV06WRHBPO7EwG0HM16ToUFiIJZpYEbLYJ6pNb/Y84v5TSQ05wD0h?=
 =?us-ascii?Q?8oy+dkZn2bicnCmxN5dgI4BDV/oBMVs5B7z0ef+9LS9CxEdWp5bl17WonjNh?=
 =?us-ascii?Q?BvhBETlryFNqiJnOe7srQXQp6nz+GVGDM0CTTlFRx3H9DSQQly1xMS/6DLbs?=
 =?us-ascii?Q?Be8g22KHLcxsBd+23KRobl+59pw8NXeApTSMxNBICYAdWH+5jrW1DgmqDl6e?=
 =?us-ascii?Q?+ippQn1c7ZFsaVX9HGF1XJfTurIpm9ker041nbRIt2PrSbphacI8Jg5OPRqv?=
 =?us-ascii?Q?RxTdxyIvAFjoGMm+68YGBtUTS8NMAbdCCu7W8wXwlBE9fY93JDPaadhqqUrW?=
 =?us-ascii?Q?WJGt1NmCGJkIrwba/XFPXHvX34ITBh7RnZ7Qa7+rcs/73cuphf5/pidbnIy+?=
 =?us-ascii?Q?nrbpJzf6aEGxJYrhBYNHV1htZX8HxyUwIrr6/EZP9r+nDuCnaasZxBvCWdkw?=
 =?us-ascii?Q?5NdyKfd6OYQXktv0HhmRTJzG5TDqg+U7v9EvzNUjtBkv5fC1s7F5cFxINwyZ?=
 =?us-ascii?Q?F1L1RuyuBEtuYLpw/rOIzaWruaJ2Gogp/jWsu9RzxB4Ph0I2fNCXDZ5jZkzw?=
 =?us-ascii?Q?Fou/97cR0IVmrODNUGilVv/QcYuXrDuTMC1+n1YpVPA4qzsv/m7SBVrBUwrI?=
 =?us-ascii?Q?GOI8BzgY4EFmlfBD5ev7XfbgbPap6nspvzycamZshVgH36K4TmDIRDwQOfly?=
 =?us-ascii?Q?ujdnW9H2oVjwDKItskledxalFM2ZhdWV+MSKDEdA0c6hN9tZrLP0AYI/gZRO?=
 =?us-ascii?Q?xoeh4ZeDteAZ9BbOC+TfgplHKyapGEPCl2664qGMZcSUIbJW7YYpIAFOy5PK?=
 =?us-ascii?Q?dk8WS9WwFEuBhngcNhZz4JjFD6qwBgbmpoqEEqM6F1tpIkkMRkJ3ug=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aq/NwTEX5onvx6sVGAWOmyIee4+f5LGj8e6eSLfC53ph5hbhP40tF0y5WhcW?=
 =?us-ascii?Q?CXN0rBEBd4Vd1OT/i0rXVFlYqvBKBTLS98FFfqecqQs2JRnrfz9JEbGL5N+R?=
 =?us-ascii?Q?uRxzLZuU4rtayfc/aAeCr+wSTJTg9pCjhLi66V+YRC6sf4egls1cqhXZfr4Y?=
 =?us-ascii?Q?RIs7q3M9yOtkrHkHYPCw9ekqeb7eydMG6NVEw5wILKL8kN/nAAAd7C4trVs1?=
 =?us-ascii?Q?CyyaPW2TtMsKqAI/88f238cPRkui6WOhB1rUT5k4ZrzN+aimItIFe0pSyC9V?=
 =?us-ascii?Q?XudodteiS/+2wSdZAeVHg/psIrBJ73LwgWsD2xIft3lSBQXYjsN45GU2ktXL?=
 =?us-ascii?Q?xJpqbPzVGGDt6sJABT6GOxOtT40NcxAAmCp/KsGnmFyr3PZTrS5VNRhXRyFl?=
 =?us-ascii?Q?PtKcuoIe2JJspKpVhFsz+WOZz3JNQ8gtq6oeczaYmj50KMoDfP8S+BVGGzfr?=
 =?us-ascii?Q?Onbo5IDEe8rlTr+R+CnZzyfpHmewuSx3IQtlnSXflVG4WF3Au+EyecouxhKh?=
 =?us-ascii?Q?cwzFi4Xk7UbBa51BYW2bdl95PQRSqx0WIHpu1qiM5T9xp0peuVFbOMohgVa8?=
 =?us-ascii?Q?mbSl+fFnGnZb/QjMgEV1xx3RvUxwrbNXFRHvfyJ8L3B+GDxHNlXlqiFm/K7u?=
 =?us-ascii?Q?UsEz12xrMHYm6i3UFGw/RYROtvKJh1Ola7u1ZJRiU65juZ7dh1xGQg18fVf3?=
 =?us-ascii?Q?f3DJhioAZalHV23OYOcDOQlt+C+RLB4xAIlVjj7uzX79Q1fLkiV7QSmJXXRK?=
 =?us-ascii?Q?jpHmCytQdq6UgT63x5H2nq8hKNZOIJQvDgafHRxPaOlpPEITZJ1NAPYRrBO0?=
 =?us-ascii?Q?lMo5Zib5s0QQV4csumJOidByMdYqfkLxmHVEA8h7XrOi1Yz8NEgTOF/4C0WY?=
 =?us-ascii?Q?1pkRL++ISvwhrru4uXZ7qiVJN3HCmemvG5WPHIgs3HVKB8scRwpkeDbqzaQC?=
 =?us-ascii?Q?v+Z7saDUBwq99iI6uGiTHu8Bka2DhVXQaG6Gqtws/bv9OPo8Yjso9d3YnZLV?=
 =?us-ascii?Q?4uidC0b+Mi0B7uVlGxJYdqIb1fuK3A49hypgxIPlJzoa25dIjodzrEJl7MmH?=
 =?us-ascii?Q?ntCEDYThw88n6ppNGiYI4L0anX5pbNFK9hDGzJMNS2GTm2p/vTAg1DPXU/Fy?=
 =?us-ascii?Q?bdwAaGLsRsjoWLkMi2FPjT7VaXoHdP8EYBHnXA/J6T3DLIRcNa2R+BQ6UaLS?=
 =?us-ascii?Q?Bx4KdWvE21/ejy2oj2ayOMNy7BpExIr2O98CAPNArjAg4gWnXqI66wQq3Wtv?=
 =?us-ascii?Q?c6ihn78a+VAYY5qsv70Trs31E4elWgri0NpXbYor+at2skhxRzd80mt0stwD?=
 =?us-ascii?Q?1J2WmbRy4mxpcVSzXHyA9e2YYFbVLd757lfqSnXp2onHxkYVsU7wqBVZrof9?=
 =?us-ascii?Q?pIgJ8XTM8cZhljtgGghq90V4NsAibgGSkg7pY1boTuw2Ol0ZfT5TmC3O1nuR?=
 =?us-ascii?Q?xyFpzdpWs3/M+l+G9xKexX/ELi388+/bKyT8G6e+FPn+KQJAprDjfkVAA6VY?=
 =?us-ascii?Q?AamYouNdVeXW1+vI72p+V9Eul+q90xiWW4NAQ/T1QjWSqD66PmzsR2BsJXcZ?=
 =?us-ascii?Q?NYL2MINoSmod+aF7m1UTQEQYQJKXqhd6ZVN+cdj9uDcaS1o06QUxJ5R7QMJk?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bebef35-5a79-47f2-3cb6-08dd8d5624f3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 10:58:48.4770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfMMGJgsbrLG3a/Yu8Kkv7v2pjyGHQYK+crAFrzflUOMHtH04GaVgSf1jELIeFpKlHFatzLbwax2Q+NzvGG+nk1jRfcBhppQKmAt8mj8chs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8807
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

Three small patches I've been meaning to send for a while; I really
believe (as I now learnt Thomas Gleixner also does) this is the way
timer frameworks should behave.

Rasmus Villemoes (3):
  cyclic: make cyclic_unregister() idempotent
  cyclic: make cyclic_register safe to call on already-registered info
  cyclic: document new guarantees for cyclic_(un)register

 common/cyclic.c        | 17 +++++++++++++++++
 doc/develop/cyclic.rst | 13 +++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.49.0

