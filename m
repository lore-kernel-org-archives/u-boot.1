Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A3DC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 11:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E65048824C;
	Tue, 18 Jun 2024 13:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pfU1JBQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A0538824C; Tue, 18 Jun 2024 13:46:28 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C36F881DB
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 13:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718711166; x=1719315966; i=xypron.glpk@gmx.de;
 bh=JbT2NKevonwyWN6QIOXJotVUn6N8YmgxgiIHDVLNKKg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pfU1JBQqzoZoeqC4GOPcsklnT2dc78e4LvhX4w6QT29xHprzyzisACAaAhk34HPY
 t8WK1P8+68GtF1R330OVdHiHnIwHOyAfM3pOHNH5/tt0u7NI50AChy4nHvXwK/TWm
 IQ1+Y73EC1/RhhrswAzeZuqFLKhIlfKw8C4I4hqLVBYxke/4wpFt1bd1RTC1YASql
 AnyUt5oA5bJmQjMabMvYEQFGIFUtb4A7Pj+R49WY65oHa2hkATrmtwW5HaX0YqFHM
 iWKrAbdQkk9Lm7Psir41i/uebH1CpTKJ9YNSSeZ2HZZNW2EtuUdq0BZrolYvdB8vI
 6H9ywTR0xv5/Y2I3Kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1sUqlK2PRD-00zdhP; Tue, 18
 Jun 2024 13:46:05 +0200
Message-ID: <626fe70e-ff61-46f6-84de-e9b8486ac5ed@gmx.de>
Date: Tue, 18 Jun 2024 13:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] test: cmd: fdt: fix chosen test for DM_RNG
To: Tim Harvey <tharvey@gateworks.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>,
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240617191416.1351790-1-tharvey@gateworks.com>
 <20240617191416.1351790-5-tharvey@gateworks.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240617191416.1351790-5-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aoPRxIBhOvFJ5ICsgOphLgCZsK9Phujs9Gl4SJ0j29eA6BxgmiK
 jcPTeok34AQWu15UsforzU3q1TvXuq3odCneBRSKy4TV1QHWwHs6fpO2a43WAQLzCc2c8rc
 2yljgs1OskawbYEltNzJjoeqJ7+w5VVgn+wcQ8gzs26erjKP/Jf36R6Ai7b7V9bBIhvtj8Q
 nAIlcUjgNurn7F7lAzIRQ==
UI-OutboundReport: notjunk:1;M01:P0:bZesKtYuJsw=;sgZeaCfB1VYy7FMNPT5jGgpDrg/
 E6vXjlG2BqTIJsj9xOQoh5M26IZUi7AMdIoh0c40XwiEQdo33tEvYuYEmPErNTrYKb+jG1JrR
 /msn1p/WU+jcjrxLAq+SwQdzXsnz2j9WEXioqQYVt1t+0uitRu9pfDLJ1HnGDA3V5zFKDYl7e
 JzOXFjZRUKb6F0ZB3CgjWn0TjloBOV/vuBbtRZJ9a1fJYJhZd2mxK2JPOgKpZC9JBzYkN921y
 y/P0m6IVF7EeqHwasoFJ6iVIirtJg2huJ4fVIJosjmpU7ZdEpYJE05BVGeGt61Kni/D6dG+s1
 2hpoTHLZs8e5X0c0eXkAf7+r+HTtTireyH0HeXPD240eX9zM6N3U/iVaOqWzHgoBQtirmC4SU
 VpMsYc2EYSLn5mNnLeSW/cCR1kbFo7cG2dHwU4CWiqg7fQ1UbkZ577MiO9w33QJZO7aQU5V8i
 hl9nER9Iovppy8tTnhu1A4QpDu113h3ruP7/JJvl6Ve2CLPIGNNYsdo+0EomSbK+ckZ+dmaQu
 WDlWhX2ynQQjIHlZx2iT4eG7n3/aiHiOA85EYucnP05FnrjcSPAYtbLQs9greWOjeOj2wmb22
 8C+5vaBA5vISGOjLmhhXZ7T5FeV7u/8KDMlUmMCqZtzOngP485ovMcVnw5pk01HxcfF1sm5fo
 CYqEk+aMkIsX7qCnMxb77HiIuMZCTuoqBObqYNDTMZg9C1sGsGiCVO7g13bdNDp5nYVjjARVs
 PTC7M9AVXsFYpKmJuSS7vAs6vaaJqFLrAZlZvIvR9sz5DYzYVTAdN5GtRQWBEtY7EaXIb0D4t
 clemEIFgIYaNuBm2riJz/tAa7asH+MVT1GHhMXnx7p/RE=
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

On 17.06.24 21:14, Tim Harvey wrote:
> Now that kaslr-seed is automatically added to the chosen node if DM_RNG
> is enabled, adjust the test to expect this.

We need to check that if CONFIG_EFI_TCG2_PROTOCOL=3Dy no kaslr-seed node
is passed to EFI binaries.

The right location for such a test is lib/efi_selftest/efi_selftest_tcg2.c=
.

We need as similar check for CONFIG_MEASURED_BOOT=3Dy.

Best regards

Heinrich

>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Akash Gajjar <gajjar04akash@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Devarsh Thakkar <devarsht@ti.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Chris Morgan <macromorgan@hotmail.com>
> ---
> v6: new patch
> ---
>   test/cmd/fdt.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> index 547085521758..537d8a338bbf 100644
> --- a/test/cmd/fdt.c
> +++ b/test/cmd/fdt.c
> @@ -1347,6 +1347,8 @@ static int fdt_test_chosen(struct unit_test_state =
*uts)
>   	ut_assert_nextlinen("\tu-boot,version =3D "); /* Ignore the version s=
tring */
>   	if (env_bootargs)
>   		ut_assert_nextline("\tbootargs =3D \"%s\";", env_bootargs);
> +	if (CONFIG_IS_ENABLED(DM_RNG))
> +		ut_assert_nextlinen("\tkaslr-seed =3D ");
>   	ut_assert_nextline("};");
>   	ut_assertok(ut_check_console_end(uts));
>
> @@ -1363,6 +1365,8 @@ static int fdt_test_chosen(struct unit_test_state =
*uts)
>   	ut_assert_nextlinen("\tu-boot,version =3D "); /* Ignore the version s=
tring */
>   	if (env_bootargs)
>   		ut_assert_nextline("\tbootargs =3D \"%s\";", env_bootargs);
> +	if (CONFIG_IS_ENABLED(DM_RNG))
> +		ut_assert_nextlinen("\tkaslr-seed =3D ");
>   	ut_assert_nextline("};");
>   	ut_assertok(ut_check_console_end(uts));
>

