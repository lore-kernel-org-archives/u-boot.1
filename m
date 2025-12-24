Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FF7E776F0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 16:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A0D58429E;
	Wed, 24 Dec 2025 17:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="aCzfxCzv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB71B84295; Wed, 24 Dec 2025 16:45:02 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5E884261
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 16:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAzo0BA519Y86RxoDjohA6dFZFjw/qxjjXkXQ3KoQNrKTIbAltbfpqdyIvVLSqVPS65DOf8O8FlDfBiOZIFxOk6bXQT3YoaUPwTY1wga49kGFyWCThfOI8oA0jm+wNgQdfmYQjlC7HKFdSE6qmja7FYySwzHaIKRf20zhIoaJsEMeu/fgxT9lksG/L6dUl5NfcKeBjLe8BNV1ibDqXNEyYWoWrXLiiRvYbVvuQZ7WWu/IIuQn9yCVfkxTrDJRREVgU1qRBz4KMmb5x9d9/LAUTLivEFaUKDUqHPBuz+IwnO7eZZVPUs2fi5dKUZc/Ac0vBqoU6fbfxfGYpmD12v7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVehHgQmIiG+OmOIQ+X7R3ka0tr68ytTiRL/5EILkEo=;
 b=tsGi3WIA5GWR3Qq9Kpqk7mVvMNAd6W6Lq02UpEIqQz3V1usegD+acB17d7eubVoqVslOoxsGd16E6J1VaFngPraA6tqtbIs6PaDXyzCO4FgqfWWjfdtmVKbQ50zvVyjfvhtEJ0A2I7BY+J+eiHbeiaHAUhVaHpNA+zIjhaKadnkdwfRPQZ86VUgoVFktiyvLHXh9tkNTPJrnB7kaPUyYv/UypFha/qdby3xpCwzL4x6ecLC7KIUzjbBVK0YAa6/iRs1W5a+wpqyEt7+XFQQP2JacAVEn4hON3jef+A3kkarJ8IxaYtKe8QaHVAkCTCmL9EzbWno1tnogtAjOUZNOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVehHgQmIiG+OmOIQ+X7R3ka0tr68ytTiRL/5EILkEo=;
 b=aCzfxCzvXt5H7LbfibK8JrIlTlJLWjDI5E7JajuCUAqGLaV5xB7FJL4aIsw4kTbdJJ0CFoZjJhxY9vnv4uX8fUfgFs7ZClDIUD52v+J4Qkm6eE8Tj2Kv4aAgckYjR6TLIz/bi2t2TYuxW2m6cevmecidY0VDduCIcOoyGr7URzVq25Di8JTTaFSxz+TxCWMPqQo4h/4NPiqfpwJprJ19rVJgJrzTzQkV1D7dOL3W3S3nRp/nCUAVJXjlO0KvjecMgMrzmbMLZVjw2/zqAjb8lFkoEA+lSC22PaEun2HCsOkW7z3b4z8KUlMm+yXA1rAzcv0wR7t6RJenR4BFBxBQ6g==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by PA3PR09MB8195.eurprd09.prod.outlook.com (2603:10a6:102:4ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Wed, 24 Dec
 2025 15:44:58 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 15:44:58 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Uros Stajic
 <uros.stajic@htecgroup.com>
Subject: [PATCH v5 0/8] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v5 0/8] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHcdOxByNuNp/IdPkeJUHa3pOhWGA==
Date: Wed, 24 Dec 2025 15:44:57 +0000
Message-ID: <20251224154449.946780-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|PA3PR09MB8195:EE_
x-ms-office365-filtering-correlation-id: 35d6ed1b-4625-481a-0d38-08de4303644f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rI1BXk29ComfIHRpMoq7wseID4B02EB7k0SvCFTATvOYllYI4q830slrNF?=
 =?iso-8859-1?Q?t0bpMjmVbO4VwT0RF6MfR6qVirrWspk5g3qYZTZQi6Bw4fttbJPojfyRBj?=
 =?iso-8859-1?Q?KuDb/L5PAHFNaNDLzOcNbPHIRS6WMbiK/lCleeXofP4yf7K97ZAuA57MfM?=
 =?iso-8859-1?Q?+mnO44VrjtUm16IdZgs/K+nuQHUMyRmP4MJvuuNPXqJf9wLfI5j6SwUOe0?=
 =?iso-8859-1?Q?swVTRUt1sdOb2AmjcRJLOOOz7c/m1SFUDbsmOu4EjImbc3aZvJtKgERYej?=
 =?iso-8859-1?Q?Q8Rl17w3O0lC535ct5wRoNnIRRmOhXaOeNLMlg00ZCcx4LLHnBjR3xe1Za?=
 =?iso-8859-1?Q?Fy/R9HE9jOQSPbS/cMm4DCjoEk6jFhEepdRmnSfP0Y83sR5V2JD+MzDZxI?=
 =?iso-8859-1?Q?Wj1DsR2YFtX9gdPRnpgYVAD7g9Il/OAPc22T2NnIsLSlwX9bw5wggeTNsD?=
 =?iso-8859-1?Q?CCsf9Y0vIVbiGQrEYMWZ+VIemSSYyXERdpGgxWA8Sd1WKYIwZ2s3qn5Na2?=
 =?iso-8859-1?Q?sCdqbS97/yChMxZf3wGohlQTUsjX9bHRHYN1nH1x+TeEE5rjJbyypQdWp+?=
 =?iso-8859-1?Q?FeB7zfGz0tRZSnwOA3ki6VjFG6NdwTwmM2vLLaZ+bz3vbMjunCOx06Q6V3?=
 =?iso-8859-1?Q?ZCk9g7zLa8l+OSgF2M81F0IfqeL8W0rCzPXOd3ykbZtoV36OJnEEYccNMx?=
 =?iso-8859-1?Q?4iF2jyrjfC1ONoxSqx9zgNbkjdzjyxnBuTZJAqvyHdR1Vlfrp6A/i5VtxT?=
 =?iso-8859-1?Q?H4I9gDDSoYp4TrbEc8lOHI/qfJQ6SpaFRPfZ3D55nktabCVBWmidoPyTDK?=
 =?iso-8859-1?Q?df0hWjpQW3hsOs4UWv+Ga1BFELoQdrk1snBzATs5RDA0lreDq0a9I/zUvZ?=
 =?iso-8859-1?Q?i8DKDeC4hqRQN5UVdZTTz014bdjYndPIo9jQ6KNZDnN3IEBN6R4UnB1Yog?=
 =?iso-8859-1?Q?GG2IRv/X8jrj7F7NqvMDmQ1lL/Lnue8j2CZxCAAckdBMkitKjGLuVwHkkP?=
 =?iso-8859-1?Q?jgMt8pb5HaNoLcWmPzmzMKuqYudHX4VEwpVJBWCkqR7eo/GoHzdICWWEv3?=
 =?iso-8859-1?Q?sQpRRf2TlQTER+YL84uHoA+qGWRrSWXWmJpVy3WuZAPpE2lQRxjlahlDUn?=
 =?iso-8859-1?Q?Ajzsh3a2HZM5QE2RF6Wwhhgznxs7aRNOIR1PD+1dDCHCA2Uxi1DPoTgxlo?=
 =?iso-8859-1?Q?YA3m7YimG68s4pguWJ4TGkbv58ACSQHZADWLR9ypjf0i19reFJUWW4RUJ1?=
 =?iso-8859-1?Q?oqAY2CLgeoj3oZzomdHh4/QLEJqkW6BhW4VdoHJMB03OINqMAxNyjdCQaD?=
 =?iso-8859-1?Q?1eRVJPNGywQyHWPNiSCD3Tus5E53dKT6qmWdyDaZdo7RfWMGuFQZCx2EhR?=
 =?iso-8859-1?Q?OB5wObGzZ8ntO4cOLOrvB6CVe3W65kHFYlx5LA0OGE1McWiKvMTYoS1vUO?=
 =?iso-8859-1?Q?IwFpynzI3hI+FehM94F7ZWrh4R5OkmgpSi0XKhp51FWOiND0uCKRFZtL6N?=
 =?iso-8859-1?Q?33z0hqqvsRzvKzV+y/InqZ5Vwm+DvxjpoE7NAuVea7OPacN2pWEcP4kwkN?=
 =?iso-8859-1?Q?1TuEJq9p/KnKm47IQDu/laOgYRBT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?91hcu9m7xfK4KGEY9PiM/tOTU1qLGwW4gjjXv6TMNqRHLUkGTkV4sqkYOI?=
 =?iso-8859-1?Q?Nfh+0KOhYKT/2n7Qb1SuDHajgVDo+Qv84fsDulP4PyQlpxH0jSiBA25P/V?=
 =?iso-8859-1?Q?3ST7syB5I3QXc/YYfOg4GVnalaNBm5TWvlBurK1nsxyUJQM5qbgQIQFl6c?=
 =?iso-8859-1?Q?rvw0M6DCGBjjYNQgb3mjPAU8C9/KUQvvyBl2lP+K+TUGiiKDN/Nc9AkiJ3?=
 =?iso-8859-1?Q?KDUiDiqur5bNp0jlp3Okwa+OzZ0yn42izPTvcoQrcBI9Pkr/XNxWeVmUWP?=
 =?iso-8859-1?Q?fRtp8nnKthHUMO34cw3vR/kHTUK99I3xuN85s1qZVIs9Ejo6kNV8VQLOwd?=
 =?iso-8859-1?Q?i7S/J86JX8jUyzWFcTIU2945hHuX18h+uBIaiwno+NH1VYNNxfVeIO4ax+?=
 =?iso-8859-1?Q?HjbMTv6+KNeU3AFicYnKOafRZFDzw+GErPHqyN+ZnUfoVm3zQjWXDuKvJk?=
 =?iso-8859-1?Q?UW8OPLzJj4x1QzZ8Vw+Ois70J84l7zfK4u9dZYAtIYXFleWLqltIfpakA9?=
 =?iso-8859-1?Q?TaHXovbJFZWRefj6ens7HlRgLda2HtRa5MLkcD14mScccR4Xob+IajoNKc?=
 =?iso-8859-1?Q?tvb0qPsuuWJqc4mTa/0q4WQRpxUfokThPlqfQllFmbvJO8Lzj+XT0r1ef5?=
 =?iso-8859-1?Q?DQtLqtyYMI5oQqpUbhdpqOf3u/o6mVktA8kAIbBHoLgHAmeR7DyrAavvBe?=
 =?iso-8859-1?Q?lP9fUQ/OZ973E4PivqZVhac4BdVwJsIJwZpzw6IYHtYjYSGLlS86xt4ZKU?=
 =?iso-8859-1?Q?rGE578Dj65aHBY0bdyvXEvJzVeR3awebFFSxwqTYBjMEwhHDlET6pMwY1+?=
 =?iso-8859-1?Q?Wazez6KqTEmiO0vklxWUsvoAbJ4C0duolHm12+ENPycOvT+XtYWBGhcq0m?=
 =?iso-8859-1?Q?5xR9IDZnhJXZMejzsrpYrqQwMJZDbPsPud1HbEaC7c1pwnczXeZEnh5ZGO?=
 =?iso-8859-1?Q?BGdkhcMGoktPsevzT4Qb5DslTo7QAvZ3Y2VPP+GbHn/KCAe8MYIYKqok43?=
 =?iso-8859-1?Q?1L5XoqKaF/yiArIJoh323FuvznInuAWarfujtnE1lOvhCNfi41yUHizeLz?=
 =?iso-8859-1?Q?rIVlf7bv1IDJxXK762L+Hrf7p7kFkucLxIkYMSTOmNPQp8kRVZ4wy3QuLX?=
 =?iso-8859-1?Q?9QmvAjrIIwUa1n0siGw57mVOCJK3oNua1o5D7fBRA4aooeK4m+wniPSW8Y?=
 =?iso-8859-1?Q?xW1twc8xAu2u40gX0O3lgEmwnPo06c1PtgsG9ORPTY6FDTwh6v31t3JCBp?=
 =?iso-8859-1?Q?HyG4Iww8rSErD4haj/xtkbjN4MEUBlitLz+rIvpnJYMOWdKVxGDkDsNr/M?=
 =?iso-8859-1?Q?2HPylPboAbizZvNOelV0LvSmRrE9mzFVvdzf4sEGM9AIjkYbMPZx6aNkT8?=
 =?iso-8859-1?Q?on3YoUZYEMB1jixyWzApIzU+G1VMPczv6r1DiH71l/Fv9+8k8IXVxyQR8b?=
 =?iso-8859-1?Q?0xziub/BQd7xndtxSL0WduiObPSzSksAiPM7U988LyIzdMTTKqVrBM53u8?=
 =?iso-8859-1?Q?yJpAuX8KCQ8JHz1/ODNIWu96Mx+nqLYOzdbIKWV1eD9dZXrAcOLS5eG4/8?=
 =?iso-8859-1?Q?vB/51Sr/6hBeycbN2s05Y7lS7dcFhtlsuVTfITb6k+nvgRzUV0XlwxhWPr?=
 =?iso-8859-1?Q?aWuVbSwGQXFeR/DZHfaiwyHoP/X2Cv8RmpBYyO5aBvIVu1Stwm/zJR84cR?=
 =?iso-8859-1?Q?oTeojS2FwkdkH0GvunBXEIq5MkDZpqunq03hI4m4sFkTS52dzmtymYD9pG?=
 =?iso-8859-1?Q?VRXWJYqMheM396ABfKKy1JgDGhRf0hPRS+qo5/oNNfKGF8EYiBDgMo4BWA?=
 =?iso-8859-1?Q?mx1yrvGgFUP+horq2sWjqRFDA/amt9U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d6ed1b-4625-481a-0d38-08de4303644f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 15:44:57.9502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rba4SKeidfJ0sqksQBzjN6ACMu6O6JOjdXkohouWW5NbYO8kf1B2geJqENI0dh9ECKvdGPR/5PZ/aX81wObgtoqVikCMqap5qhAeHC3SYJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8195
X-Mailman-Approved-At: Wed, 24 Dec 2025 17:41:15 +0100
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

----
Changes in v5:
- 01/08 - Drop p8700_platform_setup.S; move the early init logic to
          harts_early_init()
- 02/08 - Add board_early_init_r() for Boston RISC-V.
- 02/08 - Defconfig/DT: set timebase-frequency to 25MHz, enable PCIe2 node,
          and move bootargs to CONFIG_BOOTARGS
- 02/08 - Set CONFIG_PCI_BRIDGE_MEM_ALIGNMENT to avoid PCI BAR allocation
          failures seen on Boston/P8700
- 02/08 - Drop GD_FLG_COHERENT_DMA; use a platform DMA-coherency check
          instead
- 03/08 - Update eg20t-gpio driver to use the PCI API
- 05/08 - Refine the commit subject/body for the MIPS GIC syscon change
- 08/08 - Add p8700_dma_is_coherent() helper to determine whether DMA
          is coherent
- Drop 'display' command patch
- Drop the 'startharts' command patch.

Changes in v4:
- 02/10 - Use riscv_aclint_timer and update CPU timer settings
- 03/10 - Fixed inconsistent empty line usage in gpio-eg20t driver
- 08/10 - Replaced inline assembly accessors with generic macros
- Dropped AMO instructions emulation patch
- Dropped P8700-specific timer patch

Changes in v3:
- 01/12 - Split original patch into CPU/Board parts
- 02/12 - New patch: extracted board-specific logic from original 01/12
- 01/12 - Relocated object rule for p8700 into p8700-specific Makefile
- 01/12 - Explained .word usage for mcache instruction and replaced it
          with symbolic macro
- 01/12 - Replaced inline assembly lw instruction with readl()
- 01/12 - Removed p8700 code from start.S, moved to harts_early_init()
- 02/12 - Fixed operand spacing in assembly
- 02/12 - Replaced hardcoded address with properly macros
- 02/12 - Switched from riscv,isa to riscv,isa-extensions
- 02/12 - Sorted DT properties properly
=20
Changes in v2:
- 03/11 - Remove redundant pcie_xilinx_probe() and update commit
	  message accordingly.
----

Chao-ying Fu (8):
  riscv: Add initial support for P8700 SoC
  board: boston-riscv: Add initial support for P8700 Boston board
  gpio: Add GPIO driver for Intel EG20T
  pci: xilinx: Avoid writing memory base/limit for root bridge
  riscv: Add syscon driver for MIPS GIC block
  net: pch_gbe: Add PHY reset and MAC address fallback for RISC-V
  libfdt: Allow non-64b aligned memreserve entries
  riscv: p8700: Add Coherence Manager (CM) and IOCU support

 arch/riscv/Kconfig                        |  23 ++
 arch/riscv/cpu/p8700/Kconfig              |  14 ++
 arch/riscv/cpu/p8700/Makefile             |  10 +
 arch/riscv/cpu/p8700/cache.c              |  99 ++++++++
 arch/riscv/cpu/p8700/cm-iocu.c            |  75 ++++++
 arch/riscv/cpu/p8700/cm.c                 |  92 ++++++++
 arch/riscv/cpu/p8700/cpu.c                | 111 +++++++++
 arch/riscv/cpu/p8700/dram.c               |  37 +++
 arch/riscv/cpu/p8700/p8700.c              |  21 ++
 arch/riscv/dts/Makefile                   |   1 +
 arch/riscv/dts/boston-p8700.dts           | 264 ++++++++++++++++++++++
 arch/riscv/include/asm/arch-p8700/cm.h    |  61 +++++
 arch/riscv/include/asm/arch-p8700/p8700.h | 145 ++++++++++++
 arch/riscv/include/asm/global_data.h      |   4 +
 arch/riscv/lib/Makefile                   |   1 +
 arch/riscv/lib/mips_gic.c                 |  47 ++++
 board/mips/boston-riscv/Kconfig           |  47 ++++
 board/mips/boston-riscv/MAINTAINERS       |  11 +
 board/mips/boston-riscv/Makefile          |   9 +
 board/mips/boston-riscv/boston-lcd.h      |  20 ++
 board/mips/boston-riscv/boston-regs.h     |  38 ++++
 board/mips/boston-riscv/boston-riscv.c    |  30 +++
 board/mips/boston-riscv/checkboard.c      |  43 ++++
 board/mips/boston-riscv/config.mk         |  15 ++
 board/mips/boston-riscv/iocu.c            | 102 +++++++++
 board/mips/boston-riscv/lowlevel_init.S   |  18 ++
 board/mips/boston-riscv/reset.c           |  15 ++
 configs/boston-p8700_defconfig            |  98 ++++++++
 drivers/clk/Kconfig                       |   2 +-
 drivers/gpio/Kconfig                      |   7 +
 drivers/gpio/Makefile                     |   1 +
 drivers/gpio/eg20t-gpio.c                 | 141 ++++++++++++
 drivers/net/pch_gbe.c                     |  37 ++-
 drivers/net/pch_gbe.h                     |   1 +
 drivers/pci/pcie_xilinx.c                 |   9 +
 include/configs/boston-riscv.h            |   9 +
 scripts/dtc/libfdt/fdt_ro.c               |  11 +-
 37 files changed, 1663 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/cpu/p8700/Kconfig
 create mode 100644 arch/riscv/cpu/p8700/Makefile
 create mode 100644 arch/riscv/cpu/p8700/cache.c
 create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
 create mode 100644 arch/riscv/cpu/p8700/cm.c
 create mode 100644 arch/riscv/cpu/p8700/cpu.c
 create mode 100644 arch/riscv/cpu/p8700/dram.c
 create mode 100644 arch/riscv/cpu/p8700/p8700.c
 create mode 100644 arch/riscv/dts/boston-p8700.dts
 create mode 100644 arch/riscv/include/asm/arch-p8700/cm.h
 create mode 100644 arch/riscv/include/asm/arch-p8700/p8700.h
 create mode 100644 arch/riscv/lib/mips_gic.c
 create mode 100644 board/mips/boston-riscv/Kconfig
 create mode 100644 board/mips/boston-riscv/MAINTAINERS
 create mode 100644 board/mips/boston-riscv/Makefile
 create mode 100644 board/mips/boston-riscv/boston-lcd.h
 create mode 100644 board/mips/boston-riscv/boston-regs.h
 create mode 100644 board/mips/boston-riscv/boston-riscv.c
 create mode 100644 board/mips/boston-riscv/checkboard.c
 create mode 100644 board/mips/boston-riscv/config.mk
 create mode 100644 board/mips/boston-riscv/iocu.c
 create mode 100644 board/mips/boston-riscv/lowlevel_init.S
 create mode 100644 board/mips/boston-riscv/reset.c
 create mode 100644 configs/boston-p8700_defconfig
 create mode 100644 drivers/gpio/eg20t-gpio.c
 create mode 100644 include/configs/boston-riscv.h

--=20
2.34.1
