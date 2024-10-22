Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC29D1CDB8
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 08:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 960F688EC9;
	Tue, 22 Oct 2024 10:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XqR+z7ok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B327988ECD; Tue, 22 Oct 2024 10:44:50 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA75188CFB
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so40692695e9.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729586688; x=1730191488;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OY2BBrhPS7Lyes5L929fFvZVBrzvvw8q2g7ywA8nw5o=;
 b=XqR+z7okPHi1/zSzFNJqVtp29jEtty1kyNPsZX2s/NIgpdAAlbfJXZw9rOXAacb1b0
 aOCEJFhZOBZkJtsiJx2SnbdezSL9AIDrFGz19CLgBTrhdC9HREt2bVv9WeErgza5pzjc
 Hk9KqmQB3hBvsGyyohjX2Sakpqf6zhVkbZL1LOimEJmMsucTA4RzYWy9V3VNyQsOfPRc
 /mitXFtDUFzlm5877Mx3cPmDdu8sCKAS7tYelLnC8PDMlwhIxEFAEuM2V/uNmNTrEiJ2
 d9zuygtLtJ/iCRcEEtNBX2DSYhAUrHUBlKX6oEImBChnYfPc12yydQokhOhJJlPG7hCm
 4D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586688; x=1730191488;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OY2BBrhPS7Lyes5L929fFvZVBrzvvw8q2g7ywA8nw5o=;
 b=FW8FtusLjgRiiyeU6Xr+8pTaZ81UzivQU0WhVzL3S7ZapNKt9flkME7yg2uMNhxTLZ
 6rWrjaD/Zd4vIQ8RFBLID59a5gJEXCRl6Mqp6EyPsskGE3Tc/nZv5l0I1rZlprC0X6uY
 y+lDVW6LTBGgR/Rwdy+V4GuM7wnsHq2gogQjHfQQUUQX15aI/PNocNR/EggzA3BqoOZI
 lo/SNNFDfVG5ewqgU1eCgR41W16dweGHbU08Mm1tpIis7GOk9wtHc96Et+F2SBKLNqjf
 BHDhUFpGGb3Woz6IXYDdRgYEZM60VSloQ0N2xSPVdoshZTjkGafc4csbpKKEZXtFCkCj
 pI6A==
X-Gm-Message-State: AOJu0Yz3CTM0j8pW1EiwCfWHgAaC46EWg1t0XXyAKjrCCFuG0rxTChqS
 3VgTVrkMIRJlcvQ9j8rlC+RVHjTTb+Yx+VDmM5cZAoMqbR6N37GAK/CYachZzWc=
X-Google-Smtp-Source: AGHT+IFjAjzEOXFBtjzru9ZFaTTTyQvW5xDOqWW2S9ic4tGdQ6mxh012eHNWi0X9zZeL5vGEX4YKOw==
X-Received: by 2002:a05:600c:1c9f:b0:42c:b80e:5e50 with SMTP id
 5b1f17b1804b1-4317b68c9e6mr23442735e9.0.1729586688020; 
 Tue, 22 Oct 2024 01:44:48 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f58af90sm83076505e9.21.2024.10.22.01.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 01:44:46 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
 <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com,
 kernel@salutedevices.com, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v5 2/6] cmd: bcb: rework the command to U_BOOT_LONGHELP
 approach
In-Reply-To: <20241017-android_ab_master-v5-2-43bfcc096d95@salutedevices.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-2-43bfcc096d95@salutedevices.com>
Date: Tue, 22 Oct 2024 10:44:43 +0200
Message-ID: <87r088wmpw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Dmitry,

Thank you for the patch.

On jeu., oct. 17, 2024 at 17:12, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> U_BOOT_LONGHELP and U_BOOT_CMD_WITH_SUBCMDS offer numerous advantages,
> including:
> - common argument restrictions checking
> - automatic subcommand matching
> - improved usage and help handling
>
> By utilizing the U_BOOT_LONGHELP approach, we can reduce the amount of
> command management code and describe commands more succinctly.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  cmd/bcb.c | 151 ++++++++++++++++++--------------------------------------------
>  1 file changed, 43 insertions(+), 108 deletions(-)

Nice diffstat, always great to see code removed!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> diff --git a/cmd/bcb.c b/cmd/bcb.c
> index 97a96c009641cc094645607ef833575f3c03fe4b..98b2a71087a27b1721f4bed4160095d65ec75402 100644
> --- a/cmd/bcb.c
> +++ b/cmd/bcb.c
> @@ -16,15 +16,6 @@
>  #include <vsprintf.h>
>  #include <linux/err.h>
>  
> -enum bcb_cmd {
> -	BCB_CMD_LOAD,
> -	BCB_CMD_FIELD_SET,
> -	BCB_CMD_FIELD_CLEAR,
> -	BCB_CMD_FIELD_TEST,
> -	BCB_CMD_FIELD_DUMP,
> -	BCB_CMD_STORE,
> -};
> -
>  static const char * const fields[] = {
>  	"command",
>  	"status",
> @@ -38,67 +29,9 @@ static struct disk_partition partition_data;
>  static struct blk_desc *block;
>  static struct disk_partition *partition = &partition_data;
>  
> -static int bcb_cmd_get(char *cmd)
> -{
> -	if (!strcmp(cmd, "load"))
> -		return BCB_CMD_LOAD;
> -	if (!strcmp(cmd, "set"))
> -		return BCB_CMD_FIELD_SET;
> -	if (!strcmp(cmd, "clear"))
> -		return BCB_CMD_FIELD_CLEAR;
> -	if (!strcmp(cmd, "test"))
> -		return BCB_CMD_FIELD_TEST;
> -	if (!strcmp(cmd, "store"))
> -		return BCB_CMD_STORE;
> -	if (!strcmp(cmd, "dump"))
> -		return BCB_CMD_FIELD_DUMP;
> -	else
> -		return -1;
> -}
> -
> -static int bcb_is_misused(int argc, char *const argv[])
> +static int bcb_not_loaded(void)
>  {
> -	int cmd = bcb_cmd_get(argv[0]);
> -
> -	switch (cmd) {
> -	case BCB_CMD_LOAD:
> -		if (argc != 3 && argc != 4)
> -			goto err;
> -		break;
> -	case BCB_CMD_FIELD_SET:
> -		if (argc != 3)
> -			goto err;
> -		break;
> -	case BCB_CMD_FIELD_TEST:
> -		if (argc != 4)
> -			goto err;
> -		break;
> -	case BCB_CMD_FIELD_CLEAR:
> -		if (argc != 1 && argc != 2)
> -			goto err;
> -		break;
> -	case BCB_CMD_STORE:
> -		if (argc != 1)
> -			goto err;
> -		break;
> -	case BCB_CMD_FIELD_DUMP:
> -		if (argc != 2)
> -			goto err;
> -		break;
> -	default:
> -		printf("Error: 'bcb %s' not supported\n", argv[0]);
> -		return -1;
> -	}
> -
> -	if (cmd != BCB_CMD_LOAD && !block) {
> -		printf("Error: Please, load BCB first!\n");
> -		return -1;
> -	}
> -
> -	return 0;
> -err:
> -	printf("Error: Bad usage of 'bcb %s'\n", argv[0]);
> -
> +	printf("Error: Please, load BCB first!\n");
>  	return -1;
>  }
>  
> @@ -216,6 +149,9 @@ static int do_bcb_load(struct cmd_tbl *cmdtp, int flag, int argc,
>  	char *endp;
>  	char *iface = "mmc";
>  
> +	if (argc < 3)
> +		return CMD_RET_USAGE;
> +
>  	if (argc == 4) {
>  		iface = argv[1];
>  		argc--;
> @@ -270,6 +206,12 @@ static int __bcb_set(const char *fieldp, const char *valp)
>  static int do_bcb_set(struct cmd_tbl *cmdtp, int flag, int argc,
>  		      char * const argv[])
>  {
> +	if (argc < 3)
> +		return CMD_RET_USAGE;
> +
> +	if (!block)
> +		return bcb_not_loaded();
> +
>  	return __bcb_set(argv[1], argv[2]);
>  }
>  
> @@ -279,6 +221,9 @@ static int do_bcb_clear(struct cmd_tbl *cmdtp, int flag, int argc,
>  	int size;
>  	char *field;
>  
> +	if (!block)
> +		return bcb_not_loaded();
> +
>  	if (argc == 1) {
>  		memset(&bcb, 0, sizeof(bcb));
>  		return CMD_RET_SUCCESS;
> @@ -297,7 +242,15 @@ static int do_bcb_test(struct cmd_tbl *cmdtp, int flag, int argc,
>  {
>  	int size;
>  	char *field;
> -	char *op = argv[2];
> +	char *op;
> +
> +	if (argc < 4)
> +		return CMD_RET_USAGE;
> +
> +	if (!block)
> +		return bcb_not_loaded();
> +
> +	op = argv[2];
>  
>  	if (bcb_field_get(argv[1], &field, &size))
>  		return CMD_RET_FAILURE;
> @@ -325,6 +278,12 @@ static int do_bcb_dump(struct cmd_tbl *cmdtp, int flag, int argc,
>  	int size;
>  	char *field;
>  
> +	if (argc < 2)
> +		return CMD_RET_USAGE;
> +
> +	if (!block)
> +		return bcb_not_loaded();
> +
>  	if (bcb_field_get(argv[1], &field, &size))
>  		return CMD_RET_FAILURE;
>  
> @@ -356,6 +315,9 @@ err:
>  static int do_bcb_store(struct cmd_tbl *cmdtp, int flag, int argc,
>  			char * const argv[])
>  {
> +	if (!block)
> +		return bcb_not_loaded();
> +
>  	return __bcb_store();
>  }
>  
> @@ -414,44 +376,7 @@ void bcb_reset(void)
>  	__bcb_reset();
>  }
>  
> -static struct cmd_tbl cmd_bcb_sub[] = {
> -	U_BOOT_CMD_MKENT(load, CONFIG_SYS_MAXARGS, 1, do_bcb_load, "", ""),
> -	U_BOOT_CMD_MKENT(set, CONFIG_SYS_MAXARGS, 1, do_bcb_set, "", ""),
> -	U_BOOT_CMD_MKENT(clear, CONFIG_SYS_MAXARGS, 1, do_bcb_clear, "", ""),
> -	U_BOOT_CMD_MKENT(test, CONFIG_SYS_MAXARGS, 1, do_bcb_test, "", ""),
> -	U_BOOT_CMD_MKENT(dump, CONFIG_SYS_MAXARGS, 1, do_bcb_dump, "", ""),
> -	U_BOOT_CMD_MKENT(store, CONFIG_SYS_MAXARGS, 1, do_bcb_store, "", ""),
> -};
> -
> -static int do_bcb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> -{
> -	struct cmd_tbl *c;
> -
> -	if (argc < 2)
> -		return CMD_RET_USAGE;
> -
> -	argc--;
> -	argv++;
> -
> -	c = find_cmd_tbl(argv[0], cmd_bcb_sub, ARRAY_SIZE(cmd_bcb_sub));
> -	if (!c)
> -		return CMD_RET_USAGE;
> -
> -	if (bcb_is_misused(argc, argv)) {
> -		/*
> -		 * We try to improve the user experience by reporting the
> -		 * root-cause of misusage, so don't return CMD_RET_USAGE,
> -		 * since the latter prints out the full-blown help text
> -		 */
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	return c->cmd(cmdtp, flag, argc, argv);
> -}
> -
> -U_BOOT_CMD(
> -	bcb, CONFIG_SYS_MAXARGS, 1, do_bcb,
> -	"Load/set/clear/test/dump/store Android BCB fields",
> +U_BOOT_LONGHELP(bcb,
>  	"load <interface> <dev> <part>  - load  BCB from <interface> <dev>:<part>\n"
>  	"load <dev> <part>              - load  BCB from mmc <dev>:<part>\n"
>  	"bcb set   <field> <val>        - set   BCB <field> to <val>\n"
> @@ -472,3 +397,13 @@ U_BOOT_CMD(
>  	"              NOTE: any ':' character in <val> will be replaced by line feed\n"
>  	"              during 'bcb set' and used as separator by upper layers\n"
>  );
> +
> +U_BOOT_CMD_WITH_SUBCMDS(bcb,
> +	"Load/set/clear/test/dump/store Android BCB fields", bcb_help_text,
> +	U_BOOT_SUBCMD_MKENT(load, 4, 1, do_bcb_load),
> +	U_BOOT_SUBCMD_MKENT(set, 3, 1, do_bcb_set),
> +	U_BOOT_SUBCMD_MKENT(clear, 2, 1, do_bcb_clear),
> +	U_BOOT_SUBCMD_MKENT(test, 4, 1, do_bcb_test),
> +	U_BOOT_SUBCMD_MKENT(dump, 2, 1, do_bcb_dump),
> +	U_BOOT_SUBCMD_MKENT(store, 1, 1, do_bcb_store),
> +);
>
> -- 
> 2.43.0
