Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9BED3C54C
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 07:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1E789286;
	Fri, 18 Oct 2024 09:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="WlHyzwnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB94E892A2; Fri, 18 Oct 2024 09:05:23 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6102589103
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 09:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs07YjnmnxVNqy2W0Au5d647LAUXe0GLV4ovg88hQStGvKUxsknsstYqt4whNDeFpu5/g04ETOywGxI5A93XFZrAPHHfV95pW0+U00xAQIesjx1PdlgvGOTERhtkb6Yyhz3+rwC5mCwsAX/CAoahesk+zqGiIgqtzK+flE3Jx6N1ALnlZKt+v1XIxhrbkwE6KRwk3bF5KyfTdqGSZ4IdgZMvHIw71fXCjBLfn+7++ahB1/6l4brLF+/EIrwgIS/t7kiEPfDVmeC9UITkXButuo3Uhry89+UzXhu+0z6UA6hygwZQHMokB3o1l00dZX6eaRSU3WfTvM3xZaKb03DJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHtB0RLeQxyN4Z65xElwolOiTAaybpsnfNNM7yuaB2E=;
 b=eUPbNb8WOvLtFIpAV+II+eN/wGjDJgPpGcsGDerWENGV050pjjQsWAqfqKf39gCsoIeoNszOg1snmfvVLKj9sdjQAxqQS+8Z3A4ncK4Z/42aDwdJWQeYr/auFc1VmDpohSzJAIlgaToqr35pBRW8wWltAYOGHaks9BE1jSa7P3yrRZ1WEp2cuQBVi+eP5q7wM8UddXDQHT7qg3K7J83NIVuzhMZm+UqmdeiB2fvlypNkI6TsqhntksoEbq2N18bLcNFEKcPcIcCpw9iO/sALRK9dd1mv5nmDAkJBlIPnnx33GC/sHb796D9n7f5t2IP51+Su3//qxVRzLcWjpe4yPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHtB0RLeQxyN4Z65xElwolOiTAaybpsnfNNM7yuaB2E=;
 b=WlHyzwntD22uizUwIAr8MNqKVr1alZUnfclf+wmeWmHYno5wPqMmc84/IflvK0uVveKeoNt+hxjZq+Am/quAGYxWS/k0N9ttHfHWwKVK0DChwzesvwMBwyRj2vR+Vf7wKFHIPNuokxKtFLAL4FtbezajxneLqRsnMQUj9pNFhvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAVPR10MB7187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:313::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.7; Fri, 18 Oct
 2024 07:05:19 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8093.008; Fri, 18 Oct 2024
 07:05:19 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,  Alexander Sverdlin
 <alexander.sverdlin@siemens.com>,  Caleb Connolly
 <caleb.connolly@linaro.org>,  Francis Laniel
 <francis.laniel@amarulasolutions.com>,  Heinrich Schuchardt
 <xypron.glpk@gmx.de>,  Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,  Jerome Forissier
 <jerome.forissier@linaro.org>,  Marek Vasut <marex@denx.de>,  Martyn Welch
 <martyn.welch@collabora.com>,  Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,  Patrice Chotard
 <patrice.chotard@foss.st.com>,  Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,  Raymond Mao
 <raymond.mao@linaro.org>,  Robert Marko <robert.marko@sartura.hr>,  Sam
 Protsenko <semen.protsenko@linaro.org>,  Sughosh Ganu
 <sughosh.ganu@linaro.org>,  Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/8] membuff: Add tests and update to support a flag for
 empty/full
In-Reply-To: <20241018030027.842749-1-sjg@chromium.org> (Simon Glass's message
 of "Thu, 17 Oct 2024 21:00:19 -0600")
References: <20241018030027.842749-1-sjg@chromium.org>
Date: Fri, 18 Oct 2024 09:05:21 +0200
Message-ID: <87jze5ao26.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0076.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::18) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAVPR10MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fa211f-e5d6-46c1-0e54-08dcef4339c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AYYYedseR0x++D1+eyWf3DBdoY5/OPb+kG9QiNeuhS7/36smuJ0e4gf2bywJ?=
 =?us-ascii?Q?dxIVM1XRq6ry38rfp83vGblXkjP9zFcQghMeqQklyGdBSFu6sdZi4JD9n4im?=
 =?us-ascii?Q?LkYNLjMx3gJTwFbNh3c76wrR+EMIuOjWgofOF58js9mcaepDO7D+k5Oqrzpg?=
 =?us-ascii?Q?v4/vW2gPDWnYFkrFIW74FAEVj4c82+k1UKDeyNUOjj/+v03SvFBbsdF7Fjhj?=
 =?us-ascii?Q?tLvytIIZ37Rg+Qu5Vnzm8lyt+xKNTuCZAUZ1MuULyT4K1UvXRR75BQQU3EAC?=
 =?us-ascii?Q?EEWcp+gaOlk1R6hbe2DIlMnlrn9YjXmxD80nKI8EBTDKWjI1ALZBrLcOeVk8?=
 =?us-ascii?Q?pVuix/L0soQ6CQLS4Aj+dtlGtNbRO7HcyQvTOCvDFpRyRD1NcXCep0mB4ntp?=
 =?us-ascii?Q?+G3NWe+wD3Mqc7wamCnX9w+Gf3EVo1O6l0cIE9B+6cCccFRrM2zA9U6W46f6?=
 =?us-ascii?Q?k28WzpqgDDk3QVdzAWSH0K5xAvlvW9yHcSiXUIxEH70B1Ucgb4RmNJv1HohN?=
 =?us-ascii?Q?dG476XizmVlxuxjjBJQBgmnioQYt4YbU3paynXvTx+VcrEReYeVqT0hVmGxt?=
 =?us-ascii?Q?HZBK6BVDTWzhOMvTirTo6TPVwLP40Ipa7kt0uei6UcZMi7ZSr2VAxvL1iG3Z?=
 =?us-ascii?Q?MpKwWKqgIwjbdcRRg7oFFTajZuPMAF+iQqRd20DW7HIHq2YJ47TyKCYFT7G9?=
 =?us-ascii?Q?4r7DmzAWl/3KvM/simHL/FbVzAtS0ewrNImsSFvmBpSp7YaaI1XKcDPWKIWk?=
 =?us-ascii?Q?uJGgImV/Ercz9iVpZmjCGmx7TGN16ybQIBJJBdFkh61hqe9VNoJAvvjOfkWV?=
 =?us-ascii?Q?EjNMSKO+ny5OI/whmNZuUvcvUGpQzr2SFg6EUpkIPnKJqglJdRpq+l29E2l6?=
 =?us-ascii?Q?ThIpepzkjkgZ7CFhd8XtowhLcd23jMYkiYMnbsQmP/PLAbdSjMauEvR1xR5i?=
 =?us-ascii?Q?iG4QqMoSlV5QmA4xc44Y893xlgBZ1OcJkhL+vI8bv+AW2JB5Ga5peVut9Re4?=
 =?us-ascii?Q?zXxvzkAhQO8OC7iOhW/zEkga8fDAf7zxOH8wEwlCtuxOq7D98XsSZMVL6APn?=
 =?us-ascii?Q?uiEUtQIBB7HYUO2t45Jyu6FJZ7ycsGwVHbwyZyPlR0v0QSD7d4NeiaEYdZxb?=
 =?us-ascii?Q?e8rv/AiFiNLrGJkP5/2D/ZfC/AFhMrZS++Moa/p9BfcH5z4XZ6Evvp57Ife1?=
 =?us-ascii?Q?Y4q7eHSiV2SX+LhIHSaenVrbXpDwsAHJaz2gnZXm8ysm6Cc9YFeR9jUV3tzZ?=
 =?us-ascii?Q?yre3WtTsaU46yknTNmN/74RkH+GLgzYIjGYOaZXA4/t/tGoYkxL+uJMLQbVE?=
 =?us-ascii?Q?rZlIgaQppYDHOXqSa6G8FN4G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nd8Bq0tnZFig3fgVQHBs4rO2emODSjfMtOSJgD2chzbLHqxKP5KSqTg+9/bS?=
 =?us-ascii?Q?z5/pCw6Tg5QhY7Vrn7IGA7Pz73CDgD7cLsIfJM42kkmxrpBMZbzNviAFCNZo?=
 =?us-ascii?Q?B6wy8MnNJyOh1EszLz4ZZxswZH9w1rK+mzNQtlcmXqaPhFigNg4dc0YHpY08?=
 =?us-ascii?Q?fVHgv1zvIfqX/VhAyyoNTfU3PV98HhjIMr9XvxcyQQBYh0ffbJvPBrurWIcE?=
 =?us-ascii?Q?UWN5iVQQgeP/SELc1Tn++fDi7lYSUlvWXz/f4fbmEpYSPgBZYJdQlUsR4aYh?=
 =?us-ascii?Q?md5nLQiS/qCquya87tNYzNAoAyy+hRJxzaGr4AgVD3/uM8m+DZRfgDknmfVt?=
 =?us-ascii?Q?6apGliaVzDPXyBJaFOLZUUOhfDOg2CxZK7+udBREmtSlpWLfdwIvnC+QAMiU?=
 =?us-ascii?Q?+QPIrcGkPYAqFJ4peYOf46krQfB+WxFb6Chv9FRUrJMZpxLx9XjrtpfkP7vr?=
 =?us-ascii?Q?56GaFX3vuE5kaDGooVLdNR0UlBtt5/blnbdz8J0dKVdERGsCFachxjQz4wL/?=
 =?us-ascii?Q?n1wp7r4hNEu8HYN5k1H/4g1lxXr++IwzqbBm0ppGwnu8VfNOQQc4yik+iJ2U?=
 =?us-ascii?Q?h4u/a6DIEF2S95oV+/FzRKH6+YcArpvEDzqXqPBIdHyZhMqbnwHdSTRTq2W/?=
 =?us-ascii?Q?SlBTsNqFUzMXttdCQJTQRIBNIcTZtb2bCB6lv2pI26X99/tM6gYuhklszczl?=
 =?us-ascii?Q?5lCiJ6oP6qEPVKrO5R7ri2mrI0SBkoo5Z8Inb5U6NjzgKQZIV+t/n9lossUc?=
 =?us-ascii?Q?gtiKulPw4MWVWwOBEtX9JLp6nfFJWIb4ey7uKXhei4BknU5owjG+BHVGZZZO?=
 =?us-ascii?Q?4J4nhmCAiE6f/RDAV4kChRY5yukuZwFHkEMPcR7uXAfLsy7J+gxAMNaNPgLB?=
 =?us-ascii?Q?F56fg1ERZ53vQzRPSYMOd7d+kZC84EwynYqhxMiDAccQBPvpWYQPy3zGKjcc?=
 =?us-ascii?Q?eQe+/5t6vlhzQ3i+az8OJgTM4JyNzFJAXjGCO8eL6H8dHj72FiMY2E3SvBaR?=
 =?us-ascii?Q?lKwzzqKv0sCO+3L7La0zP0zlh76pmuAWIE/5G+tJBA4p1kX9W2Go/ToNpKAN?=
 =?us-ascii?Q?2hHEE0qer2gvrCB4Jq1f/pG0rszftOmiQ28DJy+4BSIf/LvxZKi9d2vG8dbD?=
 =?us-ascii?Q?oQxqzVEQELQHKKjw9Vq3c49Uh89rhFwCGsB2cOReu1RVr0zp94Y2w8IhE9HM?=
 =?us-ascii?Q?vexBYRRxoaw48kR1z7JnbHtRpOUEGtkudYulSBDjhyv7eBK54G4ku5H7O1OV?=
 =?us-ascii?Q?1ebjSZrUPpm1zhmN7+J85wTgkPx51u7lqT50t8EfxhFKpCrR4OWCbNDdJARh?=
 =?us-ascii?Q?eMhN4/GaztPVic3tyrhmsVZ8R3rMMnCTFnFhF/Urch25qJo1GPaiZiDgCimC?=
 =?us-ascii?Q?Mx/g1xrcvcAux5Z/T+j4CeJ+iI5I8frQqmRMM37Sr/5w8KX8v5p2eW58rAwd?=
 =?us-ascii?Q?QC4GTURGR0fpH2SYb0qFs/41ZcKZZU5R7W5lC63ZHp8V10tB6Bz9ZTV61MNY?=
 =?us-ascii?Q?/oUwRLdCqFcdbjIF54Ulpdh4/hAGOuJEL+alCnXf8aCnLCM18B9z11wtuwoH?=
 =?us-ascii?Q?KC8ujgh0ztBLX5uOnMpF5Xg3S8n+m6XPEBF1wOYv3kSP10PO3cBhbsmvPgvy?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fa211f-e5d6-46c1-0e54-08dcef4339c1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 07:05:19.2269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mknu6sw7+aCNFIDNKvFvSCxyoW2O4KP3CYrMhwD65eAKnyoWX49BTaM1OOqjTM9AT2xwBbLK1TCj3gOuAs3AVluoyjty0IzPIppovxbol5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7187
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

On tor, okt 17 2024, Simon Glass <sjg@chromium.org> wrote:

>
>   membuf: Support a flag for being full
>

No, that is the worst of all worlds, especially with it being a
build-time flag. The right implementation is the one where the head and
tail indices are free-running, where you get such a "flag" for
free, because you're not wasting the top bits of the indices.

https://www.snellman.net/blog/archive/2016-12-13-ring-buffers/

If you want to do the churn of renaming anyway, I suggest doing it by
adding an implementation using the proper scheme under the new name,
switch users over, and dropping the old. IMO, this series as-is brings
no value (except for the tests, of course).

Rasmus
