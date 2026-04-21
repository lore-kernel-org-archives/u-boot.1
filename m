Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF287F327B9
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 08:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 310778431E;
	Tue, 21 Apr 2026 10:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="T7NtOYWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B5A8433B; Tue, 21 Apr 2026 10:06:41 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D58D683FFA
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4VpdRScGfSy8V3BUsVda27ASxm/40dzwcw8+hkfa9wvocwFrMRjxGEOpegpE+vHUNcuV2wjE67Ir4W0NJeytqPdLvdInFLR//2nf56tvpk6bsiUP8o1+ujgUNZT9mTjONgHq3g/nr7T9jmxW/gJ4MUeSwMZtcn04h44c43I70zZQZxAc1KwOtmh1jx+qIEAZXN7KC2++zgOUTy7y5zOIsYTUvcSvOBCjzLAqTtrodP01wM5VV3h3Bywg3wGJpnJKlPzVAGRvco4FKaAkX7i+QcCeeaImxXuk41snmihtx9UUH1nQKGoMLmy3dkOGoaFMFrjzbmPWo1IRrm9GZVAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOHS3mFsi0a4dJAzP0vCH0Q3OgeVKfzkbP9z1GW0WD4=;
 b=kpQo1FKSaY4i9ef3LwgDamQGj6SdRZVSUBv5/OZH6QcHgfrZf7YkTV3TkO4xFg3XSgJLRGqqyKJm4XjlJeNQAO/s/C4jaFE08JAi1+fk8xSsiVyuE0NVIrIG9YWi4TDfgQ1PIXHafRCIRfEMCSnTvxduodRwq9j7P2ZjjQQ/iTik8dxA2XnqUBh8iYptjsgk1cKV/3PX/VitKE0ax9IHbeBENqY9nLXEOX4x6kx/0njrgeppd4TT4/P9O4rRq3cbCJ6F9YtIW8LWVr+5ESM8cL6vYC3UtwfGnuP/EP67lxOalFG28wmHrk5sY3J5igRSJJGLeuJix442zE1OWnIjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOHS3mFsi0a4dJAzP0vCH0Q3OgeVKfzkbP9z1GW0WD4=;
 b=T7NtOYWYRR9yJPWtNxS7b4klnABbG+Mw2Vf5l9+Vx/96KEr9r4x8N28Slbgse0mdMw9+bChzRRxL/fppfZ6t0j2h6cqjoduUPc4TOsnJZiVXbJHyqC+1bZPtySUKnDZiL4poEiw91ve4lRAlCcl068yYgMajddHQiCm7OrTWvP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB5221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 08:06:35 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:06:35 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
Cc: u-boot@lists.denx.de,  Ngo Luong Thanh Tra
 <S4210155@student.rmit.edu.au>,  Alexander Sverdlin
 <alexander.sverdlin@siemens.com>,  Casey Connolly
 <casey.connolly@linaro.org>,  Patrice Chotard
 <patrice.chotard@foss.st.com>,  Peng Fan <peng.fan@nxp.com>,  Simon Glass
 <sjg@chromium.org>,  Tom Rini <trini@konsulko.com>,  Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] common: cli_hush: fix console_buffer overflow on boot
 retry
In-Reply-To: <20260421053511.84312-1-S4210155@student.rmit.edu.au> (Ngo Luong
 Thanh Tra's message of "Tue, 21 Apr 2026 12:35:08 +0700")
References: <20260421053511.84312-1-S4210155@student.rmit.edu.au>
Date: Tue, 21 Apr 2026 10:06:34 +0200
Message-ID: <87a4uwn3ed.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::8) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: e3937780-3850-4445-4b6d-08de9f7ce86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: nl6pCWhgu3n+p7v8stg+JF4Cl8+hzxoSHl8C/W20rHIwusz85k7rzuYX4k5ZI2xK+Fz/NxaO5k9RV++58gtnYkLNRAoIUbMwRzAvB1QMJYopjlZcEdLAJZ4K9u/77BVN4ZWGMU6yCO+FWRCtL6x1lrjIyxNVcLbubqF0jy2You+We5YsP0Pq+vrtRCGrxMt4NONfx6waLnfm1yf1PpoGhG2Vhu1Gb9dHiUGMVMrymAlvKyHhzn9GaWaoRDp30hLJQ2EyXJyn/BTS+MGX2tRIH7iAGH7B+FVrJWjwdlfK1951tb/Ovs7GJY7qb0akx7LOhLb5BJ0/W+TBWJPfE537lOp61qoWO3BHXm0HSkl1dIBUQQUs64BAqY0wX/UqwA6CNHi0trq7gcXf7zBe1vCXzOuG7k8DfVbWtiBkE7o3MIezvIGERDFGA0DG9fspX/7dLG9UphxqX9IhvBTPy0vJ2VcrMOymswtw+N3tnynzeMz9nhb1a1SlsObfYZaWXJfzRWgGG6xFr2nom5qliCaotMAiQytpEBA1D0441x5LmqV2cpxTOmDxxN6PwU0fWVleH4XRyv4PnaW8ww9qNaiRNDOtTBijeJ9nCelxIvi+TeytI1PH6UiVJ6pJRtDYKe6jJbB0YfnxzTBW8JWS4pDSav1QStkU/SYBMRJR+k4kzTy125j1+jKGfEwliyMfSaPGUQpE2G3WE9NlSTfhNmeJvFZVF+NKYgARD3neHuFhm8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?REVc1Ma34TLyoWDXWlp/IGn4sbRXFZ5YyS4pnBt1UcrNb3S8HDbSLc94urVj?=
 =?us-ascii?Q?CD0Xtm0/I32VyMjjzPaLOK5T884QZZHUhHya0UAF/XwzRyPZ//gVNJhHOCGF?=
 =?us-ascii?Q?mnnpft6vFy0mYlhL5C+tRxJ9yFrmQF+jRj7uqR4mhYps4Ehg8Mb2uHhaT0Mc?=
 =?us-ascii?Q?wfG+GxtAVcyzfo6VREWk5P1w/ZPFfPBzT30u5GNf3ZkgtdwYvDtiQMy30sY7?=
 =?us-ascii?Q?2CcXXJkJ6S8quI08y4oQFUCo2XGMxDj+8UhfpZ12SrfTQyoDLKRgz3lEIpVR?=
 =?us-ascii?Q?fj0plJUBKI2zelfbi7MQl8IAt/gGs+7yfM0ghVAhdcEbe2Q6HnoWtnq6oKP9?=
 =?us-ascii?Q?tk8kJ/DvfAChDQFxGXJf9qS75ZGUB1x8SJKQTRVVP0x5C/ISo5HRc1PJ9Aky?=
 =?us-ascii?Q?J2jgY3cxw9cu8CftWpoJO4QzT00NToabPbpr1F3Vgmhr0qnJMJCgjQ9L0GIo?=
 =?us-ascii?Q?j1dfNvTUKWIUBJuiX0XAYdPY50hmt0NkUap8VrRF9GW5EWno8xl4viidxTW9?=
 =?us-ascii?Q?c7cxBxQXxnFUQ471e+H7I1zecoaGFBw1pU+kpAowzyzKHoG2Nwm3m/ZXEVbq?=
 =?us-ascii?Q?Dls1k2IbWHiZz0BqvMGm6b2cRjlJpeM8RWELF/Ebd7XbHvdErKPrKBejhlxp?=
 =?us-ascii?Q?3W/9wRw4XTj8rJ05xs84rsaha9j7VY6DjVtldxVsrCzxwjDTC7Pcb0i15gkG?=
 =?us-ascii?Q?M03rOOzG4p84k4Qm/sD37LvzTgzXUSoOekKTjx9931ljJpIYl72s/jpMDXuS?=
 =?us-ascii?Q?FtHWLmmerXLhYHFIcht19U5impv3tNJ+Fh31JuXH8ET2z8b076CpHHC2m+b5?=
 =?us-ascii?Q?I7+YVpljntwwec4Qr7Px3FIIRe0hui5u3DQjhlIILJkGHGt3nk7FF2RJAkWM?=
 =?us-ascii?Q?oPtQqYrrmNf4/EXmyJYwfWTJ4W/kfODfxs/HoZlB6DyQSks5FQHsqQqnUik9?=
 =?us-ascii?Q?+wtWH5l0msMvm+QNXNhz+Xf7oV38niTLjf5h9dyKEvYzQ/MdR2nmJWMUMEyI?=
 =?us-ascii?Q?afZZhIKklvTT06pdj/4/5N53TbT7HHg0WKAeREwS2xZRRbGLS2QIHLFYvdJ0?=
 =?us-ascii?Q?enpkQvmGLLyrqgOPGOt8nTOSnwhVtB7+bH/dyMWOrwq7RZWD0rycgi3usHvS?=
 =?us-ascii?Q?XOU95cFlkQVFrbfc6FKuuNrSe1xUt+cia5dhDpuFhAKbB4g79ezRzTfgiGGH?=
 =?us-ascii?Q?WiLJggGcBBg5v5W615JflV2dFlo+dx54s6EJZz143uOdqvvGL1hxSaIIuFSg?=
 =?us-ascii?Q?amFppQB8+VR2tzQ6SG5WfxZkKGL4mwVKQqP2f4sBOpkVrMqTib0C1AhyJUf6?=
 =?us-ascii?Q?DZkAVFVJGV0XYSE51r21Td+iETJaHzv66Jyv2V4LeZrdJmO7EZ9y65m8gIcX?=
 =?us-ascii?Q?FcR5YZiL2Do8TTcNq0SFVxfsrHd4tYSm1UycBgVpQNIgl2/0RVoPzwv7oz/9?=
 =?us-ascii?Q?q03RJqD4EZ870lyBsphKP5QfGBqWNY5DOAtzIJynCCccl3iB/TXanzifMHlo?=
 =?us-ascii?Q?v9h1/lBc+/mSTRMBoedtkfFXRmEA8bLZ6+8ArDT7cWh04IrGb0gumw4F3dRA?=
 =?us-ascii?Q?++PD0yMIIJh8c3IdUlFb48+j/W551n8z8SEHj+cFgJS6g3g9pXjUzkNJtVBT?=
 =?us-ascii?Q?Dg0v9YNucN6Fh3m68PWIXkeszgVuZEgpnUVOsq8qcIKrlRnsq8c8OX/08Q74?=
 =?us-ascii?Q?tS4Pi+WGOABXObO7d2FR6ouXe3NOG8k5ooan/O8AjMHI/uthj/dPKJGCgjJy?=
 =?us-ascii?Q?+tYOt+ZfwoFKjmOSRM31oXqaFnjhvtw=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e3937780-3850-4445-4b6d-08de9f7ce86e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:06:35.8624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9yDV8tDRYR1EA1/wh3I1/MVvzfQG4WTBS8dxlv+FAwUa/izs9xuN6YZxrxOeuFy0i8bD4jmY7Gr3yGJmgxVGg8l6hLi9ba6pzIWBywcDJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5221
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

On Tue, Apr 21 2026, Ngo Luong Thanh Tra <ngotra27101996@gmail.com> wrote:

> Add const_strcpy() macro to linux/build_bug.h that enforces at
> compile time that the destination is a writable char array (not char *
> or const char *), the source is a string literal, and the source fits
> in the destination including the NUL terminator.
>
> Fix the console_buffer extern declaration in console.h to include the
> array size so sizeof(console_buffer) is valid at call sites.
>
> Replace unbounded strcpy() in cli_hush.c with const_strcpy().
>
> Fixes: 657e19f8f2dd ("cli_hush: support running bootcmd on boot retry")
>
> Changes in v4:
> - Rebased on top of current master (as requested by Tom Rini)
>
> Changes in v3:
> - Reject const char * destinations in const_strcpy() (Simon Glass)
>
> Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
> ---


Hi Ngo

Please address the feedback I gave in
https://lore.kernel.org/u-boot/87zf3co6pz.fsf@prevas.dk/.

Also, two things on creating patches:

When you create a new version of a patch (or patch series), please use
"git format-patch -vX" where X is the version number. For the next one
that would be "-v5". Then git will use the subject prefix "[PATCH v5]"
instead of merely "[PATCH]", making it easier to distinguish the
different ones in one's inbox or on lore.kernel.org/u-boot.

Second, the informative "Changes in vX:" stuff should go below the ---,
as it is not part of the commit message and should not be part of the
permanent git history once the patch is accepted.

Rasmus
