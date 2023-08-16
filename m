Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20F9C001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 09:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 470DA86954;
	Wed, 16 Aug 2023 11:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MnfgN3MG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59E5F869BF; Wed, 16 Aug 2023 11:12:46 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 982A2867E2
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 11:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3159d5e409dso4385408f8f.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692177163; x=1692781963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aEUQA5OUtxhOt+haKL64YAyHiGErmVHKmE5WGpOUGeU=;
 b=MnfgN3MGpUv5RdbjzbGZSmo+UYEVnAvaSbtO39UCle6wXQ6d+T9QIQ2C35ejBxoK04
 LLQajnokx9wNt92ujna85zDG+/L1xhPbZJhE2mr6Kz+GIZ0bgYrSq5SROTZmSkQ+HYms
 3zs/8RasUf+5njwdxx9xhr4Eali4L6g6B9Ao5x1epCMjeUBsSXrRXkgV2lqi3yVko9bo
 lotgguJNDYlkb74DRfcQSzwgVwAOwy62eVGK4RMYS7acd1leCR2WCpOxPVsWK07YuUUt
 N5kPdFRbQHUfD33EtopZxGl2thsMTOwRtsoGc+FHDWw5GLk9Sqai+qihOHWTVLZacisZ
 YkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692177163; x=1692781963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEUQA5OUtxhOt+haKL64YAyHiGErmVHKmE5WGpOUGeU=;
 b=ULa4N+ECJgrOTJjpyQ6hU6046MqnQEs4c29ICyQQjx8j47RvsRnDN6Hhb1RM13VOtx
 4To+tBH3nWqyFW2P5VW2W/UtEjoFAeNeVPAiWaHfRv6PgLEx9XPIVAWMMyDPhTnPUM9w
 eB8dseUctHVzj+68acqucG0Njpvi/mFae1QqOmGv09T6sqCI3wkVTuNlA3iE4mUFYMCq
 ljvUKmuHRnQXBEedhAROz9IoLWvWIc4EcMpuWUiyicz8AS2uG47ISwRaQ1M1cORVjw9Y
 ZWSmz5N2+ck5L3D/qtO5d2mDbfckly6VCiOCJUuBz8uV8Pv8ut5hrFsNHqj1t0fxWXRI
 C3bg==
X-Gm-Message-State: AOJu0YypndLrlbMA9OsAooNPZyaKnxAUCrva2fkV8D5j6rZnMmG0us4n
 9kwaD6ZY59gqn0EtN/Dxeiw9Gg==
X-Google-Smtp-Source: AGHT+IE5UJACdaFLsMDw0Z82nDlqiKjU9AwfpM/npjA76zMkIjpvWvHStIJmd4DlRRub1yMHqbBP4w==
X-Received: by 2002:a5d:6108:0:b0:313:e2e3:d431 with SMTP id
 v8-20020a5d6108000000b00313e2e3d431mr3317486wrt.12.1692177163021; 
 Wed, 16 Aug 2023 02:12:43 -0700 (PDT)
Received: from hades (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a5d6147000000b00317e77106dbsm20561777wrt.48.2023.08.16.02.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 02:12:42 -0700 (PDT)
Date: Wed, 16 Aug 2023 12:12:40 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 lwip-devel@nongnu.org
Subject: Re: [PATCHv6 11/14] net/lwip: connection between cmd and lwip apps
Message-ID: <ZNyTCPvgxbNn3+ir@hades>
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-12-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814133253.4150-12-maxim.uvarov@linaro.org>
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

On Mon, Aug 14, 2023 at 07:32:50PM +0600, Maxim Uvarov wrote:

Commit message missing again

> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  cmd/Makefile   |   1 +
>  cmd/net-lwip.c | 306 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 307 insertions(+)
>  create mode 100644 cmd/net-lwip.c
> +static int do_lwip_init(struct cmd_tbl *cmdtp, int flag, int argc,
> +		      char *const argv[])
> +{
> +	if (!ulwip_init())
> +		return CMD_RET_SUCCESS;
> +	return CMD_RET_FAILURE;
> +}
> +
> +static int lwip_empty_tmo(void) { return 0; };
> +int (*ulwip_tmo)(void) = lwip_empty_tmo;
> +void ulwip_set_tmo(int (*tmo)(void))
> +{
> +	ulwip_tmo = tmo;
> +}
> +
> +static void ulwip_clear_tmo(void)
> +{
> +	ulwip_tmo = lwip_empty_tmo;
> +}
> +
> +static void ulwip_timeout_handler(void)

We discussed this in the previous patchset but I am not convinced this is
the best approach.  Instead of setting the callback function on the dhcp
and ping commands and calling a function pointer here,  just define
discrete function and set them during net_set_timeout_handler()
if there is common code like eth_halt() etc just create a function with
them

> +{
> +	eth_halt();
> +	ulwip_tmo();
> +	net_set_state(NETLOOP_FAIL);	/* we did not get the reply */
> +	ulwip_loop_set(0);
> +}
> +
> +int ulwip_loop(void)
> +{
> +	int ret = CMD_RET_FAILURE;
> +
> +	ulwip_loop_set(1);
> +	if (!net_loop(LWIP))
> +		ret = CMD_RET_SUCCESS;
> +	ulwip_loop_set(0);
> +	return ret;
> +}
> +
> +#if defined(CONFIG_CMD_PING)
> +int do_lwip_ping(struct cmd_tbl *cmdtp, int flag, int argc,
> +		 char *const argv[])
> +{
> +	int ret;
> +
> +	if (argc < 2) {
> +		printf("argc = %d, error\n", argc);
> +		return CMD_RET_USAGE;
> +	}
> +
> +	ret = ulwip_init();
> +	if (ret) {
> +		log_err("ulwip_init err %d\n", ret);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	printf("Using %s device\n", eth_get_name());
> +	printf("pinging addr: %s\n", argv[1]);
> +
> +	net_set_timeout_handler(1000UL, ulwip_timeout_handler);
> +
> +	if (ulwip_ping(argv[1])) {
> +		printf("ping init fail\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	return ulwip_loop();
> +}
> +#endif /* CONFIG_CMD_PING */
> +
> +#if defined(CONFIG_CMD_WGET)
> +int do_lwip_wget(struct cmd_tbl *cmdtp, int flag, int argc,
> +		 char *const argv[])
> +{
> +	char *url;
> +	int ret;
> +
> +	if (argc < 2)
> +		return CMD_RET_USAGE;
> +
> +	url = argv[1];
> +
> +	ret = ulwip_init();
> +	if (ret) {
> +		log_err("ulwip_init err %d\n", ret);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret = ulwip_wget(image_load_addr, url);
> +	if (ret) {
> +		log_err("lwip_wget err %d\n", ret);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +
> +	return ulwip_loop();
> +}
> +#endif
> +
> +#if defined(CONFIG_CMD_TFTPBOOT)
> +int do_lwip_tftp(struct cmd_tbl *cmdtp, int flag, int argc,
> +		 char *const argv[])
> +{
> +	char *filename;
> +	ulong addr;
> +	char *end;
> +	int ret;
> +
> +	switch (argc) {
> +	case 1:
> +		filename = env_get("bootfile");
> +		break;
> +	case 2:
> +		/*
> +		 * Only one arg - accept two forms:
> +		 * Just load address, or just boot file name. The latter
> +		 * form must be written in a format which can not be
> +		 * mis-interpreted as a valid number.
> +		 */
> +		addr = hextoul(argv[1], &end);
> +		if (end == (argv[1] + strlen(argv[1]))) {
> +			image_load_addr = addr;
> +			filename = env_get("bootfile");
> +		} else {
> +			filename = argv[1];
> +		}
> +		break;
> +	case 3:
> +		image_load_addr = hextoul(argv[1], NULL);
> +		filename = argv[2];
> +		break;
> +	default:
> +		return CMD_RET_USAGE;
> +	}
> +
> +	ret = ulwip_init();
> +	if (ret) {
> +		log_err("ulwip_init err %d\n", ret);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret = ulwip_tftp(image_load_addr, filename);

filename can be NULL.  We went through this on v4 as well.  Go through all
the comments and fix them before v6. 

> +	if (ret)
> +		return ret;
> +
> +	return ulwip_loop();
> +}
> +#endif /* CONFIG_CMD_TFTPBOOT */
> +
> +#if defined(CONFIG_CMD_DHCP)
> +int do_lwip_dhcp(void)
> +{
> +	int ret;
> +	char *filename;
> +
> +	ret = ulwip_init();
> +	if (ret) {
> +		log_err("ulwip_init err %d\n", ret);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret = ulwip_dhcp();
> +
> +	net_set_timeout_handler(2000UL, ulwip_timeout_handler);
> +
> +	ulwip_loop();
> +	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
> +		ulwip_clear_tmo();
> +
> +		filename = env_get("bootfile");
> +		if (!filename) {
> +			log_notice("no bootfile\n");
> +			return CMD_RET_SUCCESS;
> +		}
> +
> +		ret = ulwip_init();
> +		if (ret) {
> +			log_err("ulwip_init err %d\n", ret);
> +			return CMD_RET_FAILURE;
> +		}
> +
> +		net_set_timeout_handler(20000UL, ulwip_timeout_handler);
> +		ulwip_tftp(image_load_addr, filename);
> +
> +		ret =  ulwip_loop();
> +	}
> +
> +	return ret;
> +}
> +
> +static int _do_lwip_dhcp(struct cmd_tbl *cmdtp, int flag, int argc,
> +		char *const argv[])
> +{
> +	return do_lwip_dhcp();
> +}
> +#endif /* CONFIG_CMD_DHCP */
> +
> +#if defined(CONFIG_CMD_DNS)
> +int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
> +		char *const argv[])
> +{
> +	int ret;
> +	char *name;
> +	char *varname;
> +	int LWIP_ERR_INPROGRESS = -5; /* lwip/err.h */
> +
> +	if (argc == 1)
> +		return CMD_RET_USAGE;
> +
> +	name = argv[1];
> +
> +	if (argc == 3)
> +		varname = argv[2];
> +	else
> +		varname = NULL;
> +
> +	ret = ulwip_init();
> +	if (ret) {
> +		log_err("ulwip_init err %d\n", ret);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret = ulwip_dns(name, varname);
> +	if (ret == 0)
> +		return CMD_RET_SUCCESS;
> +	if (ret != LWIP_ERR_INPROGRESS)
> +		return CMD_RET_FAILURE;
> +
> +	net_set_timeout_handler(1000UL, ulwip_timeout_handler);
> +
> +	return ulwip_loop();
> +}
> +#endif /* CONFIG_CMD_DNS */
> +
> +static struct cmd_tbl cmds[] = {
> +	U_BOOT_CMD_MKENT(init, 1, 0, do_lwip_init,
> +			 "initialize lwip stack", ""),
> +#if defined(CONFIG_CMD_PING)
> +	U_BOOT_CMD_MKENT(ping, 2, 0, do_lwip_ping,
> +			 "send ICMP ECHO_REQUEST to network host",
> +			 "pingAddress"),
> +#endif
> +#if defined(CONFIG_CMD_WGET)
> +	U_BOOT_CMD_MKENT(wget, 2, 0, do_lwip_wget, "", ""),
> +#endif
> +#if defined(CONFIG_CMD_TFTPBOOT)
> +	U_BOOT_CMD_MKENT(tftp, 3, 0, do_lwip_tftp,
> +			"boot image via network using TFTP protocol\n",
> +			"[loadAddress] [[hostIPaddr:]bootfilename]"),
> +#endif
> +#if defined(CONFIG_CMD_DHCP)
> +	U_BOOT_CMD_MKENT(dhcp, 1, 0, _do_lwip_dhcp,
> +			"boot image via network using DHCP/TFTP protocol",
> +			""),
> +#endif
> +#if defined(CONFIG_CMD_DNS)
> +	U_BOOT_CMD_MKENT(dns, 3, 0, do_lwip_dns,
> +			 "lookup dns name [and store address at variable]",
> +			 ""),
> +#endif
> +};
> +
> +static int do_ops(struct cmd_tbl *cmdtp, int flag, int argc,
> +		     char *const argv[])
> +{
> +	struct cmd_tbl *cp;
> +
> +	cp = find_cmd_tbl(argv[1], cmds, ARRAY_SIZE(cmds));
> +
> +	argc--;
> +	argv++;
> +
> +	if (cp == NULL || argc > cp->maxargs)
> +		return CMD_RET_USAGE;
> +	if (flag == CMD_FLAG_REPEAT && !cmd_is_repeatable(cp))
> +		return CMD_RET_SUCCESS;
> +
> +	return cp->cmd(cmdtp, flag, argc, argv);
> +}
> +
> +U_BOOT_CMD(
> +	lwip, 4, 1, do_ops,
> +	"LWIP sub system",
> +	"init - init LWIP\n"
> +	"ping addr - pingAddress\n"
> +	"wget http://IPadress/url/\n"
> +	"tftp [loadAddress] [[hostIPaddr:]bootfilename]\n"
> +	"dhcp - boot image via network using DHCP/TFTP protocol\n"
> +	);
> -- 
> 2.30.2
> 

Thanks
/Ilias
