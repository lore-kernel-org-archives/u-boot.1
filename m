Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F93C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 06:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 867B888D5D;
	Tue, 20 Aug 2024 08:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WBSWDP14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88A5188D65; Tue, 20 Aug 2024 08:48:49 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7534888D38
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 08:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3718e416297so2364062f8f.2
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724136526; x=1724741326;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ygiNC6a/g5PfV0tlYvtds9OokNaGSqKLl8wTOCe3LYA=;
 b=WBSWDP14jb/nxh/q9rsWDyZ5yjtjNNQY7SoZM9Caq+1s0PdO1iLaLvNnt+I8eA7o9O
 +B9DKGRuAAsPnDtex5g6D+RjcTsuzmBT/FmyUU+new0kq4NUSMPyJKn1ayk7+9zkdbyp
 XdfCduHflUNHdV9IPlX6eBjVVjLQFXcGMzTKDaCFrYZCPerUJpAHodb+C95upCW4I4wf
 I3c/lEZFgYbCbF14VnT+x+ia3hLIyQTg4N4JHq/q49qJHIWH+LpVQmdDvlSKYgsI5aJC
 pSdSw7j76Ir7X0hviWBTK/cb8QXfixcG3iaIlFB0eBT8tgrVtUci1YENarSXf7exSwDG
 qXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724136526; x=1724741326;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ygiNC6a/g5PfV0tlYvtds9OokNaGSqKLl8wTOCe3LYA=;
 b=Ipida/PLnS8OH2bC7qgInr9KqDjTt55qxH7tdhSo8CIlPFQIU6sauh6brkJIvKRzlD
 idXe6n/9urSMkiT1XqT4PmVInqTOpkqV9tSl3duSuJuJe69QkRurqY9blWRf0jrBO3Pd
 bxwh26+m8vM7cVtdgU86VGkqYAs/lFyGYwyFLafXVsVD1APEvNPsk+LxfT6/TUPQsYZR
 JiBYwwCA6O73p4K4DKuuHaaAZezkvTrvTilEVGh/WclVRjDY9zQ6O9JOgPIPFR0Q/fqJ
 WfyQiSz7Y7HdQNpEvDxhCZclxLVfVHf2cLOH4tLXzb0Bzdh5HkRZOgMJRjQDXlqgaxwO
 EYxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQAhg2kPTxW1kExCfr6SbOTJsK1yAAdLY4j9uTKpdRu4k/v8qFPEwWjsLAFW+5ejPvuWanYca2VmNyNwyocSRYKz5ijQ==
X-Gm-Message-State: AOJu0YygBz/3432iwH6bYILp7EEeRyWeMJzzZHHEckmfkh6KMNtsnYp9
 CHymeCVgsJ4qHeABwAnGB0VEVFe86ntvDQ6LOcHcVfowe0us6IUgMyfxMyAnJPA=
X-Google-Smtp-Source: AGHT+IH4YurhN9Udh76hXkWqDDJtndTRZoGr5QoxVonr3eAmib3BDdasDWMd1OOG+llebSsfQ3OunA==
X-Received: by 2002:a5d:4e42:0:b0:371:88a1:3e49 with SMTP id
 ffacd0b85a97d-371946a03d8mr8210795f8f.53.1724136525102; 
 Mon, 19 Aug 2024 23:48:45 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898ab855sm12316703f8f.105.2024.08.19.23.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 23:48:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, AKASHI
 Takahiro <akashi.tkhro@gmail.com>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Alexander Gendin <agendin@matrox.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Johan Jonker <jbx6244@gmail.com>, Kever
 Yang <kever.yang@rock-chips.com>, Linus Walleij
 <linus.walleij@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimiliano Minella <massimiliano.minella@se.com>, Raymond Mao
 <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>, Stephen
 Carlson <stcarlso@linux.microsoft.com>, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH 05/21] test: Rename UTF_CONSOLE_REC to UTF_CONSOLE
In-Reply-To: <20240810205205.3403177-6-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-6-sjg@chromium.org>
Date: Tue, 20 Aug 2024 08:48:43 +0200
Message-ID: <878qwrwuyc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

Thank you for the patch.

On sam., ao=C3=BBt 10, 2024 at 14:51, Simon Glass <sjg@chromium.org> wrote:

> The _REC suffix doesn't add much. Really what we want to know is whether
> the test uses the console, so rename this flag.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

On next: commit 158cf0270cb6 ("Merge tag 'v2024.10-rc3' into next"),
this does not build:

$ ./test/py/test.py --bd sandbox --build -k test_ut

../test/env/cmd_ut_env.c:37:28: error: =E2=80=98UT_TESTF_CONSOLE_REC=E2=80=
=99 undeclared here (not in a function)
   37 | ENV_TEST(env_test_env_cmd, UT_TESTF_CONSOLE_REC);
      |                            ^~~~~~~~~~~~~~~~~~~~


Since next has:
https://source.denx.de/u-boot/u-boot/-/commit/2a521d01e62c012f627d426a4c430=
82b6402928d

We also need to update:
test/env/cmd_ut_env.c

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  doc/develop/tests_writing.rst |  4 ++--
>  include/dm/test.h             |  2 +-
>  include/test/test.h           |  2 +-
>  test/boot/bootflow.c          |  4 ++--
>  test/boot/upl.c               |  6 +++---
>  test/cmd/addrmap.c            |  2 +-
>  test/cmd/armffa.c             |  2 +-
>  test/cmd/bdinfo.c             |  8 ++++----
>  test/cmd/exit.c               |  2 +-
>  test/cmd/fdt.c                | 38 +++++++++++++++++------------------
>  test/cmd/font.c               |  2 +-
>  test/cmd/history.c            |  2 +-
>  test/cmd/loadm.c              |  4 ++--
>  test/cmd/mbr.c                |  4 ++--
>  test/cmd/mem_search.c         | 18 ++++++++---------
>  test/cmd/pci_mps.c            |  2 +-
>  test/cmd/pwm.c                |  2 +-
>  test/cmd/rw.c                 |  2 +-
>  test/cmd/seama.c              |  6 +++---
>  test/cmd/setexpr.c            | 22 ++++++++++----------
>  test/cmd/temperature.c        |  2 +-
>  test/dm/ffa.c                 |  4 ++--
>  test/dm/nvmxip.c              |  2 +-
>  test/dm/rkmtd.c               |  2 +-
>  test/dm/rng.c                 |  2 +-
>  test/log/log_filter.c         |  4 ++--
>  test/log/log_test.c           | 32 ++++++++++++++---------------
>  test/print_ut.c               |  6 +++---
>  test/test-main.c              |  2 +-
>  29 files changed, 95 insertions(+), 95 deletions(-)
>
> diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
> index c277c8dd44f..404d158ec40 100644
> --- a/doc/develop/tests_writing.rst
> +++ b/doc/develop/tests_writing.rst
> @@ -167,7 +167,7 @@ There is no exactly equivalent C test, but here is a =
similar one that tests 'ms'
>=20=20
>        return 0;
>     }
> -   MEM_TEST(mem_test_ms_b, UTF_CONSOLE_REC);
> +   MEM_TEST(mem_test_ms_b, UTF_CONSOLE);
>=20=20
>  This runs the command directly in U-Boot, then checks the console output=
, also
>  directly in U-Boot. If run by itself this takes 100ms. For 1000 runs it =
takes
> @@ -266,7 +266,7 @@ with the suite. For example, to add a new mem_search =
test::
>=20=20
>           return 0;
>     }
> -   MEM_TEST(mem_test_ms_new_thing, UTF_CONSOLE_REC);
> +   MEM_TEST(mem_test_ms_new_thing, UTF_CONSOLE);
>=20=20
>  Note that the MEM_TEST() macros is defined at the top of the file.
>=20=20
> diff --git a/include/dm/test.h b/include/dm/test.h
> index 61776c8dda1..3cbf2c740d4 100644
> --- a/include/dm/test.h
> +++ b/include/dm/test.h
> @@ -143,7 +143,7 @@ extern struct unit_test_state global_dm_test_state;
>=20=20
>  /* Declare a new driver model test */
>  #define DM_TEST(_name, _flags) \
> -	UNIT_TEST(_name, UTF_DM | UTF_CONSOLE_REC | (_flags), dm_test)
> +	UNIT_TEST(_name, UTF_DM | UTF_CONSOLE | (_flags), dm_test)
>=20=20
>  /*
>   * struct sandbox_sdl_plat - Platform data for the SDL video driver
> diff --git a/include/test/test.h b/include/test/test.h
> index 9ad73daf7f8..92eec2eb6f9 100644
> --- a/include/test/test.h
> +++ b/include/test/test.h
> @@ -61,7 +61,7 @@ enum ut_flags {
>  	UTF_SCAN_FDT	=3D BIT(2),	/* scan device tree */
>  	UTF_FLAT_TREE	=3D BIT(3),	/* test needs flat DT */
>  	UTF_LIVE_TREE	=3D BIT(4),	/* needs live device tree */
> -	UTF_CONSOLE_REC	=3D BIT(5),	/* needs console recording */
> +	UTF_CONSOLE	=3D BIT(5),	/* needs console recording */
>  	/* do extra driver model init and uninit */
>  	UTF_DM		=3D BIT(6),
>  	UTF_OTHER_FDT	=3D BIT(7),	/* read in other device tree */
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index a97f4f877e9..f53e20e4c86 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -721,7 +721,7 @@ static int bootflow_scan_menu(struct unit_test_state =
*uts)
>=20=20
>  	return 0;
>  }
> -BOOTSTD_TEST(bootflow_scan_menu, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE_REC=
);
> +BOOTSTD_TEST(bootflow_scan_menu, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
>=20=20
>  /* Check 'bootflow scan -mb' to select and boot a bootflow using a menu =
*/
>  static int bootflow_scan_menu_boot(struct unit_test_state *uts)
> @@ -767,7 +767,7 @@ static int bootflow_scan_menu_boot(struct unit_test_s=
tate *uts)
>=20=20
>  	return 0;
>  }
> -BOOTSTD_TEST(bootflow_scan_menu_boot, UTF_DM | UTF_SCAN_FDT | UTF_CONSOL=
E_REC);
> +BOOTSTD_TEST(bootflow_scan_menu_boot, UTF_DM | UTF_SCAN_FDT | UTF_CONSOL=
E);
>=20=20
>  /* Check searching for a single bootdev using the hunters */
>  static int bootflow_cmd_hunt_single(struct unit_test_state *uts)
> diff --git a/test/boot/upl.c b/test/boot/upl.c
> index 6ef29a98f05..99f02b7951b 100644
> --- a/test/boot/upl.c
> +++ b/test/boot/upl.c
> @@ -374,7 +374,7 @@ static int upl_test_info(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -UPL_TEST(upl_test_info, UTF_CONSOLE_REC);
> +UPL_TEST(upl_test_info, UTF_CONSOLE);
>=20=20
>  /* Test 'upl read' and 'upl_write' commands */
>  static int upl_test_read_write(struct unit_test_state *uts)
> @@ -396,7 +396,7 @@ static int upl_test_read_write(struct unit_test_state=
 *uts)
>=20=20
>  	return 0;
>  }
> -UPL_TEST(upl_test_read_write, UTF_CONSOLE_REC);
> +UPL_TEST(upl_test_read_write, UTF_CONSOLE);
>=20=20
>  /* Test UPL passthrough */
>  static int upl_test_info_norun(struct unit_test_state *uts)
> @@ -425,7 +425,7 @@ static int upl_test_info_norun(struct unit_test_state=
 *uts)
>=20=20
>  	return 0;
>  }
> -UPL_TEST(upl_test_info_norun, UTF_CONSOLE_REC | UTF_MANUAL);
> +UPL_TEST(upl_test_info_norun, UTF_CONSOLE | UTF_MANUAL);
>=20=20
>  int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const arg=
v[])
>  {
> diff --git a/test/cmd/addrmap.c b/test/cmd/addrmap.c
> index fb4ec316781..abeb467aede 100644
> --- a/test/cmd/addrmap.c
> +++ b/test/cmd/addrmap.c
> @@ -24,7 +24,7 @@ static int addrmap_test_basic(struct unit_test_state *u=
ts)
>=20=20
>  	return 0;
>  }
> -ADDRMAP_TEST(addrmap_test_basic, UTF_CONSOLE_REC);
> +ADDRMAP_TEST(addrmap_test_basic, UTF_CONSOLE);
>=20=20
>  int do_ut_addrmap(struct cmd_tbl *cmdtp, int flag, int argc, char *const=
 argv[])
>  {
> diff --git a/test/cmd/armffa.c b/test/cmd/armffa.c
> index d7b076cfe7c..fd578f3087f 100644
> --- a/test/cmd/armffa.c
> +++ b/test/cmd/armffa.c
> @@ -28,4 +28,4 @@ static int dm_test_armffa_cmd(struct unit_test_state *u=
ts)
>=20=20
>  	return 0;
>  }
> -DM_TEST(dm_test_armffa_cmd, UTF_SCAN_FDT | UTF_CONSOLE_REC);
> +DM_TEST(dm_test_armffa_cmd, UTF_SCAN_FDT | UTF_CONSOLE);
> diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> index cb88d2ee11b..1d038bec29c 100644
> --- a/test/cmd/bdinfo.c
> +++ b/test/cmd/bdinfo.c
> @@ -244,7 +244,7 @@ static int bdinfo_test_full(struct unit_test_state *u=
ts)
>=20=20
>  	return 0;
>  }
> -BDINFO_TEST(bdinfo_test_full, UTF_CONSOLE_REC);
> +BDINFO_TEST(bdinfo_test_full, UTF_CONSOLE);
>=20=20
>  static int bdinfo_test_help(struct unit_test_state *uts)
>  {
> @@ -265,7 +265,7 @@ static int bdinfo_test_help(struct unit_test_state *u=
ts)
>=20=20
>  	return 0;
>  }
> -BDINFO_TEST(bdinfo_test_help, UTF_CONSOLE_REC);
> +BDINFO_TEST(bdinfo_test_help, UTF_CONSOLE);
>=20=20
>  static int bdinfo_test_memory(struct unit_test_state *uts)
>  {
> @@ -280,7 +280,7 @@ static int bdinfo_test_memory(struct unit_test_state =
*uts)
>=20=20
>  	return 0;
>  }
> -BDINFO_TEST(bdinfo_test_memory, UTF_CONSOLE_REC);
> +BDINFO_TEST(bdinfo_test_memory, UTF_CONSOLE);
>=20=20
>  static int bdinfo_test_eth(struct unit_test_state *uts)
>  {
> @@ -295,7 +295,7 @@ static int bdinfo_test_eth(struct unit_test_state *ut=
s)
>=20=20
>  	return 0;
>  }
> -BDINFO_TEST(bdinfo_test_eth, UTF_CONSOLE_REC);
> +BDINFO_TEST(bdinfo_test_eth, UTF_CONSOLE);
>=20=20
>  int do_ut_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const =
argv[])
>  {
> diff --git a/test/cmd/exit.c b/test/cmd/exit.c
> index e7e454c7631..d416607d610 100644
> --- a/test/cmd/exit.c
> +++ b/test/cmd/exit.c
> @@ -121,7 +121,7 @@ static int cmd_exit_test(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -EXIT_TEST(cmd_exit_test, UTF_CONSOLE_REC);
> +EXIT_TEST(cmd_exit_test, UTF_CONSOLE);
>=20=20
>  int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const ar=
gv[])
>  {
> diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> index 4f935d053c6..721345f0288 100644
> --- a/test/cmd/fdt.c
> +++ b/test/cmd/fdt.c
> @@ -213,7 +213,7 @@ static int fdt_test_addr(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_addr, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_addr, UTF_CONSOLE);
>=20=20
>  /* Test 'fdt addr' resizing an fdt */
>  static int fdt_test_addr_resize(struct unit_test_state *uts)
> @@ -247,7 +247,7 @@ static int fdt_test_addr_resize(struct unit_test_stat=
e *uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_addr_resize, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_addr_resize, UTF_CONSOLE);
>=20=20
>  static int fdt_test_move(struct unit_test_state *uts)
>  {
> @@ -281,7 +281,7 @@ static int fdt_test_move(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_move, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_move, UTF_CONSOLE);
>=20=20
>  static int fdt_test_resize(struct unit_test_state *uts)
>  {
> @@ -305,7 +305,7 @@ static int fdt_test_resize(struct unit_test_state *ut=
s)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_resize, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_resize, UTF_CONSOLE);
>=20=20
>  static int fdt_test_print_list_common(struct unit_test_state *uts,
>  				      const char *opc, const char *node)
> @@ -442,13 +442,13 @@ static int fdt_test_print(struct unit_test_state *u=
ts)
>  {
>  	return fdt_test_print_list(uts, true);
>  }
> -FDT_TEST(fdt_test_print, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_print, UTF_CONSOLE);
>=20=20
>  static int fdt_test_list(struct unit_test_state *uts)
>  {
>  	return fdt_test_print_list(uts, false);
>  }
> -FDT_TEST(fdt_test_list, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_list, UTF_CONSOLE);
>=20=20
>  /* Test 'fdt get value' reading an fdt */
>  static int fdt_test_get_value_string(struct unit_test_state *uts,
> @@ -554,7 +554,7 @@ static int fdt_test_get_value(struct unit_test_state =
*uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_get_value, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_get_value, UTF_CONSOLE);
>=20=20
>  static int fdt_test_get_name(struct unit_test_state *uts)
>  {
> @@ -633,7 +633,7 @@ static int fdt_test_get_name(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_get_name, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_get_name, UTF_CONSOLE);
>=20=20
>  static int fdt_test_get_addr_common(struct unit_test_state *uts, char *f=
dt,
>  				    const char *path, const char *prop)
> @@ -700,7 +700,7 @@ static int fdt_test_get_addr(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_get_addr, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_get_addr, UTF_CONSOLE);
>=20=20
>  static int fdt_test_get_size_common(struct unit_test_state *uts,
>  				     const char *path, const char *prop,
> @@ -787,7 +787,7 @@ static int fdt_test_get_size(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_get_size, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_get_size, UTF_CONSOLE);
>=20=20
>  static int fdt_test_set_single(struct unit_test_state *uts,
>  			       const char *path, const char *prop,
> @@ -929,7 +929,7 @@ static int fdt_test_set(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_set, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_set, UTF_CONSOLE);
>=20=20
>  static int fdt_test_mknode(struct unit_test_state *uts)
>  {
> @@ -997,7 +997,7 @@ static int fdt_test_mknode(struct unit_test_state *ut=
s)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_mknode, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_mknode, UTF_CONSOLE);
>=20=20
>  static int fdt_test_rm(struct unit_test_state *uts)
>  {
> @@ -1081,7 +1081,7 @@ static int fdt_test_rm(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_rm, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_rm, UTF_CONSOLE);
>=20=20
>  static int fdt_test_bootcpu(struct unit_test_state *uts)
>  {
> @@ -1114,7 +1114,7 @@ static int fdt_test_bootcpu(struct unit_test_state =
*uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_bootcpu, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_bootcpu, UTF_CONSOLE);
>=20=20
>  static int fdt_test_header_get(struct unit_test_state *uts,
>  			       const char *field, const unsigned long val)
> @@ -1173,7 +1173,7 @@ static int fdt_test_header(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_header, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_header, UTF_CONSOLE);
>=20=20
>  static int fdt_test_memory_cells(struct unit_test_state *uts,
>  				 const unsigned int cells)
> @@ -1256,7 +1256,7 @@ static int fdt_test_memory(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_memory, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_memory, UTF_CONSOLE);
>=20=20
>  static int fdt_test_rsvmem(struct unit_test_state *uts)
>  {
> @@ -1319,7 +1319,7 @@ static int fdt_test_rsvmem(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_rsvmem, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_rsvmem, UTF_CONSOLE);
>=20=20
>  static int fdt_test_chosen(struct unit_test_state *uts)
>  {
> @@ -1375,7 +1375,7 @@ static int fdt_test_chosen(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_chosen, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_chosen, UTF_CONSOLE);
>=20=20
>  static int fdt_test_apply(struct unit_test_state *uts)
>  {
> @@ -1527,7 +1527,7 @@ static int fdt_test_apply(struct unit_test_state *u=
ts)
>=20=20
>  	return 0;
>  }
> -FDT_TEST(fdt_test_apply, UTF_CONSOLE_REC);
> +FDT_TEST(fdt_test_apply, UTF_CONSOLE);
>=20=20
>  int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const arg=
v[])
>  {
> diff --git a/test/cmd/font.c b/test/cmd/font.c
> index 3ea262bb703..08600dfe2eb 100644
> --- a/test/cmd/font.c
> +++ b/test/cmd/font.c
> @@ -69,7 +69,7 @@ static int font_test_base(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -FONT_TEST(font_test_base, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE_RE=
C |
> +FONT_TEST(font_test_base, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE |
>  	  UTF_DM);
>=20=20
>  int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const ar=
gv[])
> diff --git a/test/cmd/history.c b/test/cmd/history.c
> index 9fec4a811f4..6d9d2288483 100644
> --- a/test/cmd/history.c
> +++ b/test/cmd/history.c
> @@ -45,4 +45,4 @@ static int lib_test_history(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -LIB_TEST(lib_test_history, UTF_CONSOLE_REC);
> +LIB_TEST(lib_test_history, UTF_CONSOLE);
> diff --git a/test/cmd/loadm.c b/test/cmd/loadm.c
> index 0b6390ebc53..29ae8339183 100644
> --- a/test/cmd/loadm.c
> +++ b/test/cmd/loadm.c
> @@ -41,7 +41,7 @@ static int loadm_test_params(struct unit_test_state *ut=
s)
>=20=20
>  	return 0;
>  }
> -LOADM_TEST(loadm_test_params, UTF_CONSOLE_REC);
> +LOADM_TEST(loadm_test_params, UTF_CONSOLE);
>=20=20
>  static int loadm_test_load (struct unit_test_state *uts)
>  {
> @@ -59,7 +59,7 @@ static int loadm_test_load (struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -LOADM_TEST(loadm_test_load, UTF_CONSOLE_REC);
> +LOADM_TEST(loadm_test_load, UTF_CONSOLE);
>=20=20
>  int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const a=
rgv[])
>  {
> diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
> index e4b694b728f..0c3698afb0b 100644
> --- a/test/cmd/mbr.c
> +++ b/test/cmd/mbr.c
> @@ -465,7 +465,7 @@ static int mbr_test_run(struct unit_test_state *uts)
>  }
>=20=20
>  /* Declare mbr test */
> -UNIT_TEST(mbr_test_run, UTF_CONSOLE_REC, mbr_test);
> +UNIT_TEST(mbr_test_run, UTF_CONSOLE, mbr_test);
>=20=20
>  int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const arg=
v[])
>  {
> @@ -479,4 +479,4 @@ static int dm_test_cmd_mbr(struct unit_test_state *ut=
s)
>  {
>  	return mbr_test_run(uts);
>  }
> -DM_TEST(dm_test_cmd_mbr, UTF_SCAN_FDT | UTF_CONSOLE_REC);
> +DM_TEST(dm_test_cmd_mbr, UTF_SCAN_FDT | UTF_CONSOLE);
> diff --git a/test/cmd/mem_search.c b/test/cmd/mem_search.c
> index 9ad0c18152f..1387baea032 100644
> --- a/test/cmd/mem_search.c
> +++ b/test/cmd/mem_search.c
> @@ -43,7 +43,7 @@ static int mem_test_ms_b(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -MEM_TEST(mem_test_ms_b, UTF_CONSOLE_REC);
> +MEM_TEST(mem_test_ms_b, UTF_CONSOLE);
>=20=20
>  /* Test 'ms' command with 16-bit values */
>  static int mem_test_ms_w(struct unit_test_state *uts)
> @@ -68,7 +68,7 @@ static int mem_test_ms_w(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -MEM_TEST(mem_test_ms_w, UTF_CONSOLE_REC);
> +MEM_TEST(mem_test_ms_w, UTF_CONSOLE);
>=20=20
>  /* Test 'ms' command with 32-bit values */
>  static int mem_test_ms_l(struct unit_test_state *uts)
> @@ -102,7 +102,7 @@ static int mem_test_ms_l(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -MEM_TEST(mem_test_ms_l, UTF_CONSOLE_REC);
> +MEM_TEST(mem_test_ms_l, UTF_CONSOLE);
>=20=20
>  /* Test 'ms' command with continuation */
>  static int mem_test_ms_cont(struct unit_test_state *uts)
> @@ -152,7 +152,7 @@ static int mem_test_ms_cont(struct unit_test_state *u=
ts)
>=20=20
>  	return 0;
>  }
> -MEM_TEST(mem_test_ms_cont, UTF_CONSOLE_REC);
> +MEM_TEST(mem_test_ms_cont, UTF_CONSOLE);
>=20=20
>  /* Test that an 'ms' command with continuation stops at the end of the r=
ange */
>  static int mem_test_ms_cont_end(struct unit_test_state *uts)
> @@ -196,7 +196,7 @@ static int mem_test_ms_cont_end(struct unit_test_stat=
e *uts)
>=20=20
>  	return 0;
>  }
> -MEM_TEST(mem_test_ms_cont_end, UTF_CONSOLE_REC);
> +MEM_TEST(mem_test_ms_cont_end, UTF_CONSOLE);
>=20=20
>  /* Test 'ms' command with multiple values */
>  static int mem_test_ms_mult(struct unit_test_state *uts)
> @@ -225,7 +225,7 @@ static int mem_test_ms_mult(struct unit_test_state *u=
ts)
>=20=20
>  	return 0;
>  }
> -MEM_TEST(mem_test_ms_mult, UTF_CONSOLE_REC);
> +MEM_TEST(mem_test_ms_mult, UTF_CONSOLE);
>=20=20
>  /* Test 'ms' command with string */
>  static int mem_test_ms_s(struct unit_test_state *uts)
> @@ -268,7 +268,7 @@ static int mem_test_ms_s(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -MEM_TEST(mem_test_ms_s, UTF_CONSOLE_REC);
> +MEM_TEST(mem_test_ms_s, UTF_CONSOLE);
>=20=20
>  /* Test 'ms' command with limit */
>  static int mem_test_ms_limit(struct unit_test_state *uts)
> @@ -297,7 +297,7 @@ static int mem_test_ms_limit(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -MEM_TEST(mem_test_ms_limit, UTF_CONSOLE_REC);
> +MEM_TEST(mem_test_ms_limit, UTF_CONSOLE);
>=20=20
>  /* Test 'ms' command in quiet mode */
>  static int mem_test_ms_quiet(struct unit_test_state *uts)
> @@ -321,4 +321,4 @@ static int mem_test_ms_quiet(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -MEM_TEST(mem_test_ms_quiet, UTF_CONSOLE_REC);
> +MEM_TEST(mem_test_ms_quiet, UTF_CONSOLE);
> diff --git a/test/cmd/pci_mps.c b/test/cmd/pci_mps.c
> index 755a0649770..a265105600c 100644
> --- a/test/cmd/pci_mps.c
> +++ b/test/cmd/pci_mps.c
> @@ -27,7 +27,7 @@ static int test_pci_mps_safe(struct unit_test_state *ut=
s)
>=20=20
>  	return 0;
>  }
> -PCI_MPS_TEST(test_pci_mps_safe, UTF_CONSOLE_REC);
> +PCI_MPS_TEST(test_pci_mps_safe, UTF_CONSOLE);
>=20=20
>  int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
>  		  char * const argv[])
> diff --git a/test/cmd/pwm.c b/test/cmd/pwm.c
> index 44f52e15cbb..f8de03fd6d1 100644
> --- a/test/cmd/pwm.c
> +++ b/test/cmd/pwm.c
> @@ -71,4 +71,4 @@ static int dm_test_pwm_cmd(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -DM_TEST(dm_test_pwm_cmd, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE_REC=
);
> +DM_TEST(dm_test_pwm_cmd, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
> diff --git a/test/cmd/rw.c b/test/cmd/rw.c
> index eeda87b53ed..1086dcd2914 100644
> --- a/test/cmd/rw.c
> +++ b/test/cmd/rw.c
> @@ -99,4 +99,4 @@ static int dm_test_read_write(struct unit_test_state *u=
ts)
>=20=20
>  	return 0;
>  }
> -DM_TEST(dm_test_read_write, UTF_SCAN_FDT | UTF_CONSOLE_REC);
> +DM_TEST(dm_test_read_write, UTF_SCAN_FDT | UTF_CONSOLE);
> diff --git a/test/cmd/seama.c b/test/cmd/seama.c
> index 235135118cf..802563e4f71 100644
> --- a/test/cmd/seama.c
> +++ b/test/cmd/seama.c
> @@ -26,7 +26,7 @@ static int seama_test_noargs(struct unit_test_state *ut=
s)
>  	ut_assert_console_end();
>  	return 0;
>  }
> -SEAMA_TEST(seama_test_noargs, UTF_CONSOLE_REC);
> +SEAMA_TEST(seama_test_noargs, UTF_CONSOLE);
>=20=20
>  static int seama_test_addr(struct unit_test_state *uts)
>  {
> @@ -42,7 +42,7 @@ static int seama_test_addr(struct unit_test_state *uts)
>  	ut_assert_console_end();
>  	return 0;
>  }
> -SEAMA_TEST(seama_test_addr, UTF_CONSOLE_REC);
> +SEAMA_TEST(seama_test_addr, UTF_CONSOLE);
>=20=20
>  static int seama_test_index(struct unit_test_state *uts)
>  {
> @@ -58,7 +58,7 @@ static int seama_test_index(struct unit_test_state *uts)
>  	ut_assert_console_end();
>  	return 0;
>  }
> -SEAMA_TEST(seama_test_index, UTF_CONSOLE_REC);
> +SEAMA_TEST(seama_test_index, UTF_CONSOLE);
>=20=20
>  int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const a=
rgv[])
>  {
> diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
> index a4086c9451c..dcd0e3726e4 100644
> --- a/test/cmd/setexpr.c
> +++ b/test/cmd/setexpr.c
> @@ -63,7 +63,7 @@ static int setexpr_test_int(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -SETEXPR_TEST(setexpr_test_int, UTF_CONSOLE_REC);
> +SETEXPR_TEST(setexpr_test_int, UTF_CONSOLE);
>=20=20
>  /* Test 'setexpr' command with + operator */
>  static int setexpr_test_plus(struct unit_test_state *uts)
> @@ -105,7 +105,7 @@ static int setexpr_test_plus(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -SETEXPR_TEST(setexpr_test_plus, UTF_CONSOLE_REC);
> +SETEXPR_TEST(setexpr_test_plus, UTF_CONSOLE);
>=20=20
>  /* Test 'setexpr' command with other operators */
>  static int setexpr_test_oper(struct unit_test_state *uts)
> @@ -148,7 +148,7 @@ static int setexpr_test_oper(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -SETEXPR_TEST(setexpr_test_oper, UTF_CONSOLE_REC);
> +SETEXPR_TEST(setexpr_test_oper, UTF_CONSOLE);
>=20=20
>  /* Test 'setexpr' command with regex */
>  static int setexpr_test_regex(struct unit_test_state *uts)
> @@ -192,7 +192,7 @@ static int setexpr_test_regex(struct unit_test_state =
*uts)
>=20=20
>  	return 0;
>  }
> -SETEXPR_TEST(setexpr_test_regex, UTF_CONSOLE_REC);
> +SETEXPR_TEST(setexpr_test_regex, UTF_CONSOLE);
>=20=20
>  /* Test 'setexpr' command with regex replacement that expands the string=
 */
>  static int setexpr_test_regex_inc(struct unit_test_state *uts)
> @@ -209,7 +209,7 @@ static int setexpr_test_regex_inc(struct unit_test_st=
ate *uts)
>=20=20
>  	return 0;
>  }
> -SETEXPR_TEST(setexpr_test_regex_inc, UTF_CONSOLE_REC);
> +SETEXPR_TEST(setexpr_test_regex_inc, UTF_CONSOLE);
>=20=20
>  /* Test setexpr_regex_sub() directly to check buffer usage */
>  static int setexpr_test_sub(struct unit_test_state *uts)
> @@ -249,7 +249,7 @@ static int setexpr_test_sub(struct unit_test_state *u=
ts)
>=20=20
>  	return 0;
>  }
> -SETEXPR_TEST(setexpr_test_sub, UTF_CONSOLE_REC);
> +SETEXPR_TEST(setexpr_test_sub, UTF_CONSOLE);
>=20=20
>  /* Test setexpr_regex_sub() with back references */
>  static int setexpr_test_backref(struct unit_test_state *uts)
> @@ -292,7 +292,7 @@ static int setexpr_test_backref(struct unit_test_stat=
e *uts)
>=20=20
>  	return 0;
>  }
> -SETEXPR_TEST(setexpr_test_backref, UTF_CONSOLE_REC);
> +SETEXPR_TEST(setexpr_test_backref, UTF_CONSOLE);
>=20=20
>  /* Test 'setexpr' command with setting strings */
>  static int setexpr_test_str(struct unit_test_state *uts)
> @@ -327,7 +327,7 @@ static int setexpr_test_str(struct unit_test_state *u=
ts)
>=20=20
>  	return 0;
>  }
> -SETEXPR_TEST(setexpr_test_str, UTF_CONSOLE_REC);
> +SETEXPR_TEST(setexpr_test_str, UTF_CONSOLE);
>=20=20
>  /* Test 'setexpr' command with concatenating strings */
>  static int setexpr_test_str_oper(struct unit_test_state *uts)
> @@ -376,7 +376,7 @@ static int setexpr_test_str_oper(struct unit_test_sta=
te *uts)
>=20=20
>  	return 0;
>  }
> -SETEXPR_TEST(setexpr_test_str_oper, UTF_CONSOLE_REC);
> +SETEXPR_TEST(setexpr_test_str_oper, UTF_CONSOLE);
>=20=20
>  /* Test 'setexpr' command with a string that is too long */
>  static int setexpr_test_str_long(struct unit_test_state *uts)
> @@ -396,7 +396,7 @@ static int setexpr_test_str_long(struct unit_test_sta=
te *uts)
>=20=20
>  	return 0;
>  }
> -SETEXPR_TEST(setexpr_test_str_long, UTF_CONSOLE_REC);
> +SETEXPR_TEST(setexpr_test_str_long, UTF_CONSOLE);
>=20=20
>  #ifdef CONFIG_CMD_SETEXPR_FMT
>  /* Test 'setexpr' command with simply setting integers */
> @@ -478,7 +478,7 @@ static int setexpr_test_fmt(struct unit_test_state *u=
ts)
>=20=20
>  	return 0;
>  }
> -SETEXPR_TEST(setexpr_test_fmt, UTF_CONSOLE_REC);
> +SETEXPR_TEST(setexpr_test_fmt, UTF_CONSOLE);
>  #endif
>=20=20
>  int do_ut_setexpr(struct cmd_tbl *cmdtp, int flag, int argc, char *const=
 argv[])
> diff --git a/test/cmd/temperature.c b/test/cmd/temperature.c
> index b86c7d44b33..193fa6324ea 100644
> --- a/test/cmd/temperature.c
> +++ b/test/cmd/temperature.c
> @@ -34,4 +34,4 @@ static int dm_test_cmd_temperature(struct unit_test_sta=
te *uts)
>=20=20
>  	return 0;
>  }
> -DM_TEST(dm_test_cmd_temperature, UTF_SCAN_FDT | UTF_CONSOLE_REC);
> +DM_TEST(dm_test_cmd_temperature, UTF_SCAN_FDT | UTF_CONSOLE);
> diff --git a/test/dm/ffa.c b/test/dm/ffa.c
> index 1937d0eecb0..593b7177fce 100644
> --- a/test/dm/ffa.c
> +++ b/test/dm/ffa.c
> @@ -197,7 +197,7 @@ static int dm_test_ffa_ack(struct unit_test_state *ut=
s)
>=20=20
>  	return 0;
>  }
> -DM_TEST(dm_test_ffa_ack, UTF_SCAN_FDT | UTF_CONSOLE_REC);
> +DM_TEST(dm_test_ffa_ack, UTF_SCAN_FDT | UTF_CONSOLE);
>=20=20
>  static int dm_test_ffa_nack(struct unit_test_state *uts)
>  {
> @@ -255,4 +255,4 @@ static int dm_test_ffa_nack(struct unit_test_state *u=
ts)
>=20=20
>  	return 0;
>  }
> -DM_TEST(dm_test_ffa_nack, UTF_SCAN_FDT | UTF_CONSOLE_REC);
> +DM_TEST(dm_test_ffa_nack, UTF_SCAN_FDT | UTF_CONSOLE);
> diff --git a/test/dm/nvmxip.c b/test/dm/nvmxip.c
> index 5c455ddbf04..a702d0aec3f 100644
> --- a/test/dm/nvmxip.c
> +++ b/test/dm/nvmxip.c
> @@ -142,4 +142,4 @@ static int dm_test_nvmxip(struct unit_test_state *uts)
>=20=20
>  	return CMD_RET_SUCCESS;
>  }
> -DM_TEST(dm_test_nvmxip, UTF_SCAN_FDT | UTF_CONSOLE_REC);
> +DM_TEST(dm_test_nvmxip, UTF_SCAN_FDT | UTF_CONSOLE);
> diff --git a/test/dm/rkmtd.c b/test/dm/rkmtd.c
> index e77c43b247a..d1ca5d1acac 100644
> --- a/test/dm/rkmtd.c
> +++ b/test/dm/rkmtd.c
> @@ -196,4 +196,4 @@ static int dm_test_rkmtd_cmd(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -DM_TEST(dm_test_rkmtd_cmd, UTF_SCAN_FDT | UTF_CONSOLE_REC);
> +DM_TEST(dm_test_rkmtd_cmd, UTF_SCAN_FDT | UTF_CONSOLE);
> diff --git a/test/dm/rng.c b/test/dm/rng.c
> index d249e0218fe..8ed4e1373ea 100644
> --- a/test/dm/rng.c
> +++ b/test/dm/rng.c
> @@ -52,4 +52,4 @@ static int dm_test_rng_cmd(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -DM_TEST(dm_test_rng_cmd, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE_REC=
);
> +DM_TEST(dm_test_rng_cmd, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
> diff --git a/test/log/log_filter.c b/test/log/log_filter.c
> index 149eef05426..e175f409c9b 100644
> --- a/test/log/log_filter.c
> +++ b/test/log/log_filter.c
> @@ -24,7 +24,7 @@ static int log_test_filter_invalid(struct unit_test_sta=
te *uts)
>=20=20
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_filter_invalid, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_filter_invalid, UTF_CONSOLE);
>=20=20
>  /* Test adding and removing filters */
>  static int log_test_filter(struct unit_test_state *uts)
> @@ -105,4 +105,4 @@ static int log_test_filter(struct unit_test_state *ut=
s)
>=20=20
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_filter, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_filter, UTF_CONSOLE);
> diff --git a/test/log/log_test.c b/test/log/log_test.c
> index d2c062e1323..357a3b57feb 100644
> --- a/test/log/log_test.c
> +++ b/test/log/log_test.c
> @@ -121,7 +121,7 @@ int log_test_cat_allow(struct unit_test_state *uts)
>  	ut_assertok(log_remove_filter("console", filt));
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_cat_allow, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_cat_allow, UTF_CONSOLE);
>=20=20
>  /* Check a category filter that should block log entries */
>  int log_test_cat_deny_implicit(struct unit_test_state *uts)
> @@ -141,7 +141,7 @@ int log_test_cat_deny_implicit(struct unit_test_state=
 *uts)
>  	ut_assertok(log_remove_filter("console", filt));
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_cat_deny_implicit, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_cat_deny_implicit, UTF_CONSOLE);
>=20=20
>  /* Check passing and failing file filters */
>  int log_test_file(struct unit_test_state *uts)
> @@ -162,7 +162,7 @@ int log_test_file(struct unit_test_state *uts)
>  	ut_assertok(log_remove_filter("console", filt));
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_file, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_file, UTF_CONSOLE);
>=20=20
>  /* Check a passing file filter (second in list) */
>  int log_test_file_second(struct unit_test_state *uts)
> @@ -179,7 +179,7 @@ int log_test_file_second(struct unit_test_state *uts)
>  	ut_assertok(log_remove_filter("console", filt));
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_file_second, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_file_second, UTF_CONSOLE);
>=20=20
>  /* Check a passing file filter (middle of list) */
>  int log_test_file_mid(struct unit_test_state *uts)
> @@ -197,7 +197,7 @@ int log_test_file_mid(struct unit_test_state *uts)
>  	ut_assertok(log_remove_filter("console", filt));
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_file_mid, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_file_mid, UTF_CONSOLE);
>=20=20
>  /* Check a log level filter */
>  int log_test_level(struct unit_test_state *uts)
> @@ -215,7 +215,7 @@ int log_test_level(struct unit_test_state *uts)
>  	ut_assertok(log_remove_filter("console", filt));
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_level, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_level, UTF_CONSOLE);
>=20=20
>  /* Check two filters, one of which passes everything */
>  int log_test_double(struct unit_test_state *uts)
> @@ -235,7 +235,7 @@ int log_test_double(struct unit_test_state *uts)
>  	ut_assertok(log_remove_filter("console", filt2));
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_double, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_double, UTF_CONSOLE);
>=20=20
>  /* Check three filters, which together pass everything */
>  int log_test_triple(struct unit_test_state *uts)
> @@ -258,7 +258,7 @@ int log_test_triple(struct unit_test_state *uts)
>  	ut_assertok(log_remove_filter("console", filt3));
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_triple, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_triple, UTF_CONSOLE);
>=20=20
>  int do_log_test_helpers(struct unit_test_state *uts)
>  {
> @@ -292,7 +292,7 @@ int log_test_helpers(struct unit_test_state *uts)
>  	gd->log_fmt =3D log_get_default_format();
>  	return ret;
>  }
> -LOG_TEST_FLAGS(log_test_helpers, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_helpers, UTF_CONSOLE);
>=20=20
>  int do_log_test_disable(struct unit_test_state *uts)
>  {
> @@ -319,7 +319,7 @@ int log_test_disable(struct unit_test_state *uts)
>  	gd->log_fmt =3D log_get_default_format();
>  	return ret;
>  }
> -LOG_TEST_FLAGS(log_test_disable, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_disable, UTF_CONSOLE);
>=20=20
>  /* Check denying based on category */
>  int log_test_cat_deny(struct unit_test_state *uts)
> @@ -343,7 +343,7 @@ int log_test_cat_deny(struct unit_test_state *uts)
>  	ut_assertok(log_remove_filter("console", filt2));
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_cat_deny, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_cat_deny, UTF_CONSOLE);
>=20=20
>  /* Check denying based on file */
>  int log_test_file_deny(struct unit_test_state *uts)
> @@ -364,7 +364,7 @@ int log_test_file_deny(struct unit_test_state *uts)
>  	ut_assertok(log_remove_filter("console", filt2));
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_file_deny, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_file_deny, UTF_CONSOLE);
>=20=20
>  /* Check denying based on level */
>  int log_test_level_deny(struct unit_test_state *uts)
> @@ -387,7 +387,7 @@ int log_test_level_deny(struct unit_test_state *uts)
>  	ut_assertok(log_remove_filter("console", filt2));
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_level_deny, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_level_deny, UTF_CONSOLE);
>=20=20
>  /* Check matching based on minimum level */
>  int log_test_min(struct unit_test_state *uts)
> @@ -410,7 +410,7 @@ int log_test_min(struct unit_test_state *uts)
>  	ut_assertok(log_remove_filter("console", filt2));
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_min, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_min, UTF_CONSOLE);
>=20=20
>  /* Check dropped traces */
>  int log_test_dropped(struct unit_test_state *uts)
> @@ -432,7 +432,7 @@ int log_test_dropped(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_dropped, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_dropped, UTF_CONSOLE);
>=20=20
>  /* Check log_buffer() */
>  int log_test_buffer(struct unit_test_state *uts)
> @@ -459,4 +459,4 @@ int log_test_buffer(struct unit_test_state *uts)
>=20=20
>  	return 0;
>  }
> -LOG_TEST_FLAGS(log_test_buffer, UTF_CONSOLE_REC);
> +LOG_TEST_FLAGS(log_test_buffer, UTF_CONSOLE);
> diff --git a/test/print_ut.c b/test/print_ut.c
> index eef85d16218..cf0d5929508 100644
> --- a/test/print_ut.c
> +++ b/test/print_ut.c
> @@ -246,7 +246,7 @@ static int print_display_buffer(struct unit_test_stat=
e *uts)
>=20=20
>  	return 0;
>  }
> -PRINT_TEST(print_display_buffer, UTF_CONSOLE_REC);
> +PRINT_TEST(print_display_buffer, UTF_CONSOLE);
>=20=20
>  static int print_hexdump_line(struct unit_test_state *uts)
>  {
> @@ -272,7 +272,7 @@ static int print_hexdump_line(struct unit_test_state =
*uts)
>=20=20
>  	return 0;
>  }
> -PRINT_TEST(print_hexdump_line, UTF_CONSOLE_REC);
> +PRINT_TEST(print_hexdump_line, UTF_CONSOLE);
>=20=20
>  static int print_do_hex_dump(struct unit_test_state *uts)
>  {
> @@ -365,7 +365,7 @@ static int print_do_hex_dump(struct unit_test_state *=
uts)
>=20=20
>  	return 0;
>  }
> -PRINT_TEST(print_do_hex_dump, UTF_CONSOLE_REC);
> +PRINT_TEST(print_do_hex_dump, UTF_CONSOLE);
>=20=20
>  static int snprint(struct unit_test_state *uts)
>  {
> diff --git a/test/test-main.c b/test/test-main.c
> index 2ee703ef5a8..63e8be0ccd1 100644
> --- a/test/test-main.c
> +++ b/test/test-main.c
> @@ -333,7 +333,7 @@ static int test_pre_run(struct unit_test_state *uts, =
struct unit_test *test)
>  		}
>  	}
>=20=20
> -	if (test->flags & UTF_CONSOLE_REC) {
> +	if (test->flags & UTF_CONSOLE) {
>  		int ret =3D console_record_reset_enable();
>=20=20
>  		if (ret) {
> --=20
> 2.34.1
