Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1910AC61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 13:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED65C82C7F;
	Thu, 12 Jun 2025 15:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=tplant.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93D9382C49; Thu, 12 Jun 2025 13:42:10 +0200 (CEST)
Received: from SY5PR01CU010.outbound.protection.outlook.com
 (mail-australiaeastazolkn190120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d40d::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62CB482B7C
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 13:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=tplant.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tplant.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbCpXSJ1YIPPmpUMHuZUU+//xpejC+thgj8Q6hRjXC0SydSoTHRM2TbAYdnNcghIJiF156z+uoLTIlOUFHXQI/Bvpqt4T4c5U6TVcq6Tfuu7G5I2Tq0/ylgUYgCS7vRRB4e6jL6/LAf3EePlfj9sDrrDLUmhuga7SYm3H3O46YAsAWS2NLTVEhil8q/ydf4dmDsY98CC+htSLH/XSSVHmsY4FeISjmzqoJDw8WC73NfHXVi859HSQuaB/7UJgMTsi7EgDtigk+zBWCam5nY/1iwPGtZjeakizE7ESl+v21orf0xMcKxypigs65XtQOlz/JVyF8e/G9N/ty+6lGjvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owr9IWD5zwdk/Tw7YtoEjMhLVvXNl6wVCQmc28VmAjg=;
 b=HlN+NhCKiaiJ7W0sDrR/paI4dsYDVw/6fjQQpsr+nxHcBVvNunTZiGZjlKfpoVjXpc9Zu2JT0srGzHE+FFtUIVmBnEBVOCxcYrkE5MQ5bu2LZx0yO8TjkiGc7kPpL/VmntlKrVT5I9t72px8+Q3gB3KeTsDRjS1j5hYTRXkmHK596ynnzsazmPJqzRX0kHEASWPTFNZFvVwwMsIdl/MzuhCu5QG1v/ge2F7uCD0TPaBATYy6TWWG6HknUgWIrm2WUB5HvjqmCqENW8yju0lX6MS4vxY1pPs/9NGinuyg7QOclfXHt5rC9cJ3sIbGTyO18Hwsga84jCKFAs+VLd/0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SY9P300MB1532.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d5::22)
 by MEUP300MB0301.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:21c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Thu, 12 Jun
 2025 11:42:01 +0000
Received: from SY9P300MB1532.AUSP300.PROD.OUTLOOK.COM
 ([fe80::acbc:6cee:7871:d69b]) by SY9P300MB1532.AUSP300.PROD.OUTLOOK.COM
 ([fe80::acbc:6cee:7871:d69b%5]) with mapi id 15.20.8835.023; Thu, 12 Jun 2025
 11:42:01 +0000
From: Tom Plant <tom@tplant.com.au>
To: Yao Zi <ziyao@disroot.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Han Gao
 <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, Tom Rini
 <trini@konsulko.com>, Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Maksim Kiselev
 <bigunclemax@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jerome
 Forissier <jerome.forissier@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 0/5] Convert Lichee Pi 4A to use S-Mode proper U-Boot
Thread-Topic: [PATCH 0/5] Convert Lichee Pi 4A to use S-Mode proper U-Boot
Thread-Index: AQHb24tr8pjij+bybEmSGD0JoP0qo7P/ZgK/
Date: Thu, 12 Jun 2025 11:42:01 +0000
Message-ID: <SY9P300MB153212CB4CD7A54CCBE7F017EA74A@SY9P300MB1532.AUSP300.PROD.OUTLOOK.COM>
References: <20250530094851.57198-1-ziyao@disroot.org>
In-Reply-To: <20250530094851.57198-1-ziyao@disroot.org>
Accept-Language: en-AU, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY9P300MB1532:EE_|MEUP300MB0301:EE_
x-ms-office365-filtering-correlation-id: e5337db3-177e-4823-92e7-08dda9a625a7
x-ms-exchange-slblob-mailprops: qdrM8TqeFBviODO9VQS4PMxfRvnVHWnwON0yAyRlEXBfbXx0VO6q2F9Qpe0Xa9sTJfxyvlTIkyMTOcnBO8TQCnfgaywt/p+cYUDI7mD3T0XP0P3k02r7Nwp1tNubAVtJ3SuBJ93r2YNGkhzr4RI5gCCCBo7HKC4mDxbdc74OvvDbNUCTRJx1QFUWLerz4XXeQkyRXhop/zKtWkqbavrP9vmNfIodNJJ1/OGSP4Ii3Em0q8HrikhyFjG3L2eka7rtDux6ZHnKNBBd6fYKNKSfpbENzphrB/pW/UoV/eSwggfONodWGn9uL8kTDAJSEM+A4+xr57gUWScNOocWIFO3mvepHieWEkLBqhHZj8nRTToXobf5ArZRYNgnJby6nZyNBTH/3ijk6WJ59y3baqbv824T9OwSso6gQUVl7t5I6OcxCmoXsigZIx5AMLwsYaWvPyPbBU6gkCcAkuyBu2c1NxZfvwxI+XNKH7BaSb5NVHYXNqfaDiQAEgl8PzDtVpNAwYKMOL8aXIg7rvYmT1J2AhIg67KKEiFFGRVfIytK/QY4u7/DTf0sHgWeNZ90eLdNjSyDOKBzKf1pF3O9polNMD96jlUQEZK3o05tR846dWBSbNKtvUCvLc3JSXktbKFmdYPxAprp98IVmaktrr9kDkDyYYAOGZ1ndrBKoP/MVR5RwaDykqwwRtDmSH+9+cAl2omU3T3b5vNbLQXsAc3L5Qi5Le+5vx3JE4T5sdyKXhJtKEQ6UevjN/Tg9AO3jvN42ZX3sMn5R9m9zOgWcxPZdBiaxR8Ae5uQ
x-microsoft-antispam: BCL:0;
 ARA:14566002|15030799003|461199028|7092599006|7071999006|19110799006|15080799009|8060799009|8062599006|41105399003|40105399003|51005399003|39105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vtBj4GCZZHBE7PI3UcJYBCURbPVbORAD8Sok51e3gbbuJ9D8KnJu+nNc9Z?=
 =?iso-8859-1?Q?y0/o1p1z3WmXGvVC9MywWfs2A1WpfU0ED38CCYA6s/Flu1jePZIOZ2Jwln?=
 =?iso-8859-1?Q?uMQgcJn6QFP9y0L72KMX1L8llUA5W7W4b+xn7PSbwKJP4LVCoGCb50HzaZ?=
 =?iso-8859-1?Q?Ve3reAhp0+Pq/fUfQVq87qq4ezAtjg3flOrwkbOnk6DqozHZIkEUa6z1Mz?=
 =?iso-8859-1?Q?YFjbJ9q1nes0gVIFBQM7al25yxd6ql3jN+N98SEEQt6zeX9SAtIyRgXs34?=
 =?iso-8859-1?Q?K3OzCX9i/Fp7MldAE3mgRcOeFtBNHvFNJAvJdcOkxbPwmPU3VwwocmeaD4?=
 =?iso-8859-1?Q?iMlRbZo6MRbaYjzKY3ZQ7RlAQT/OWMiqhnTZ3P0c/A63vygHqsdClbSUyd?=
 =?iso-8859-1?Q?a8sR/Yc8Xr9BPobSnedg9upjibf5Q/nodlPVv/qQAUBcl0s/mg/nEcEoOt?=
 =?iso-8859-1?Q?YSH2LBJkp+7PgGhS5OHo9htIKzbQP9xlvRsEWH+YtuCOttcP5FsS3VdzaF?=
 =?iso-8859-1?Q?KPuhbwAJgZb7OIwX2QOCYR3zm1uYTI5eYK2YNm36M440Gyxn2FttEL1kk8?=
 =?iso-8859-1?Q?8F3V6I0SU+3WG0n1Cdtycz5cp2wdd/PZw8213SkXiTg7YRTa+bLdXR9iAo?=
 =?iso-8859-1?Q?c8nImlxwojE2PjRk3nFZ8E/9XTv/9MM2ne2+nsZ4jhmXPunST+rD/n8XrD?=
 =?iso-8859-1?Q?3jDlU3pYH75dWes6b29Rjgo7Ayzr3uFo/MXIyPHxfGN/kvS1wVQIkzbBVo?=
 =?iso-8859-1?Q?LN9FSGQwASg4UwK8VoIwIXLLoeMKvF59+Ig5/Q4Q+m43JSZsQKk9yRh6Oh?=
 =?iso-8859-1?Q?tLiQ/7CfpbieowhoDCXXcnrF6jLGn4FB+0QRDjc1CxMpQUpAWimpos+RlV?=
 =?iso-8859-1?Q?vn4Jl5AUGcKzoexs4WCpR7qhSLOYlx10Iuoh4sz81zYiqfCXK2nk3wA8Dg?=
 =?iso-8859-1?Q?EIm2Tieg3csPBNThSG3+3lQIFdJBYVIIJ4bGhI4IWyY5BddtfxhPdsJlUT?=
 =?iso-8859-1?Q?Xry1yJMI9nNJ1GNtkhhArjhvg6HxdbYWVbakqo5TvwWDIhX+po0FPyqtUk?=
 =?iso-8859-1?Q?6R5sdBoOUwziVzOaQNBxnjyyQvipLjfF3igIdOfJqdPt+nReGtc6A9cRQN?=
 =?iso-8859-1?Q?eucNvFINc6wwIgiM+JpMNWMulRAN+Df2+cniqWUCqoJL0lNCSyeamNxrtU?=
 =?iso-8859-1?Q?DmSh4/A67xwFastK6KlcbE8mQpnnd5hw+e57ZbnmPaHdiWk+0yPi9lZnJM?=
 =?iso-8859-1?Q?DzI6sP8GIyK1W9GCF/9zntuZx6enYD8H+S/O75ZsaIgm2WpTt1Yn98xouC?=
 =?iso-8859-1?Q?V8kMxeroImtXtCur9ppwGrQjaiHah/UHmCMqvk30noB8naQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E3hlllG8tc5/SEb5lIrPROyc1mFEGDO4gnyvbfE0BSG94GjN/RdI/23BMh?=
 =?iso-8859-1?Q?B+KZkWoLQ/UktD25CmkH/TemoqTSNAwSF/sAUAL3CSY6SNHrBPTC1EPT4G?=
 =?iso-8859-1?Q?wEJJmBO+TBbuijOaka24x7qUVz+C6SfMGrgapag5CcYvxq/CEZv9EUOKKs?=
 =?iso-8859-1?Q?PmGtCgvqCbe7nr7YtXyALPIZS/hCYMwEKpTpRzcH/2ntNid3jtePh5OjTd?=
 =?iso-8859-1?Q?HfQ/NLX0rPJTJAIjE0yX4KOEaPc9eYX7SZY4AwrrOe/GkKEN1bvngoNVlr?=
 =?iso-8859-1?Q?d59pDaKH9+6+gcY+fr4C6ncz5NdCMEXQhI3RBhAiOKVv+Gupz3TMlPonZA?=
 =?iso-8859-1?Q?jKBfnJGDNPu1P7iV5e1bvUY6NkPxB7RzSNnC0Kq1iY+sl6YiDPp/xd737g?=
 =?iso-8859-1?Q?l8L9LNIqhv0BAFeqasnt59PcaJAf9inIaAnjM4OyFpoLiU2Hq23s+HCV6v?=
 =?iso-8859-1?Q?5ujkWUy3leHZzMvwWms6/6Atu3cFYPaxEy3I8BztZJ4GPpPNHT77qm3aA/?=
 =?iso-8859-1?Q?esaWCYNGT36qCNs1wALNpLkThjxdsIcvPr9Fp+vi2cUqiuewP0/mVgvdpC?=
 =?iso-8859-1?Q?hZYrmjtz4497G5oE2AyHbS4KMGhyyFFTCiozVtgMFr2nPGwxBzYUlvMFef?=
 =?iso-8859-1?Q?RDRF65KwEp58KI90EUa061xWqDXPgKWdM2U4gnySecFPtmzGH5snOMf/z7?=
 =?iso-8859-1?Q?M8mQnlV+hvNQ1tDvDKqkiGrIceiRYnhZazrA3bb2wP0QfTm2505dTTiqdr?=
 =?iso-8859-1?Q?MRCd/0n5EpkLpVx+4tL6Iq8JBrn9jjAuohGoeybmFJ4lZLiwsHkmYg+HS+?=
 =?iso-8859-1?Q?m+nMFIzJw+aCfI55vo4/atbwj9VWZFe7kOr/YZ6zuHTXTSTzCm0d35pLgY?=
 =?iso-8859-1?Q?i1Yx0w9nUJrPm5H9cGsE1xjcBLtuYa7wCza7Sbqkho87LmQBhcFyNOsJwQ?=
 =?iso-8859-1?Q?zQkU+MbWGJijJAxfL73fxOnQNw6DlfX3l+T4wc3SuT2+HwJKbPWXl2qBio?=
 =?iso-8859-1?Q?1ntPKkq3nAfCePzVNdSPZAerTozjpAWi8gjSO/kV/yQynz1XFMWNNlxIQP?=
 =?iso-8859-1?Q?KlLiQXs9SG8t3hx+hrbaISbJ86Tv53lWwhYLjg7wUsOyxhVu9OFwB8Xv6c?=
 =?iso-8859-1?Q?H7gsv0nR5oE2lsvDxGE2Bm49WJLf1eV1zNf07rKJct16cguids0Ild3tGW?=
 =?iso-8859-1?Q?lQN3vQWGp3yq4+d6kVSs1/i5G2BnMWuprxejm6rpDJojRu+Z16nb68luZb?=
 =?iso-8859-1?Q?l7jUN05yhRjBAt3nfpwW3bbihLyV+lgUicls/odh7yq8GIfEMm4t2AXt9S?=
 =?iso-8859-1?Q?1fuSACUaJSBCEAfOXtjaFsJp+g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-fb8bf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY9P300MB1532.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e5337db3-177e-4823-92e7-08dda9a625a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 11:42:01.7867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEUP300MB0301
X-Mailman-Approved-At: Thu, 12 Jun 2025 15:07:04 +0200
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

For what it's worth, tested with OpenSBI 1.6 on a Lichee Pi 4A 8GB.=0A=
Tested-by: Tom Plant <tom@tplant.com.au>=
