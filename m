Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058C3C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 09:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FBB988258;
	Thu,  6 Jun 2024 11:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UbT1CI93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF37188266; Thu,  6 Jun 2024 11:38:37 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AEA8823C
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 11:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6266ffdba8so61655366b.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717666715; x=1718271515; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F7mfaX+eDkNUGi9MZnybXojchaSr7hsyZgDzqzZbO7Y=;
 b=UbT1CI93IvQfO+TAqjx2GQaxTtYfc/ZGAm3Rg7ep65CQWw1z/rAi5XvmBACE+wzyGP
 a+s2Ysmuwg4/52k6oCjmlDRQlsWcxswkzjKCeVWnQoWtHxomQEO+ExPOdea7NWt7s5hr
 PgiwIZXvrqtVqWbZt4q+mFwQVQuhPYLqeYMjFyEVgZpTG1KPZPzG/5Z9tT1nq4TQrs/7
 FNjSqc+Wca7fx6XXJW9z7wJTne9qLjVqfRgmvFbMdF3PIAdCeXEBfVfyeMJ3MdGtTPrB
 QH/6tWIJ433BAzDu96V8ahhPk74JIfoAUSSsgS43Hebcd6nhk+Ls2+KXa4IRXGmXZmpa
 g2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717666715; x=1718271515;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7mfaX+eDkNUGi9MZnybXojchaSr7hsyZgDzqzZbO7Y=;
 b=M8S/ed2XEp2KrQ+83TyDpe+xObZv6DRf0FBW2I/E8sfDmaB7Ru8jvpS8YBvQ6jKYqm
 ifF4DdSXMLvoF/jocE6/inSTdI8c3NOuQUza1IDRhtm6p7hL8eS0DoLXLzm3cmCcD4Js
 03j1JBvYEdsAJg2lwYWc7Dpf5gi6L4pK3dWbwO5g5LMbGSimJIiVovxBJktDn6l7wdBP
 KgKwahhlwjbCEkHjdLmV2IJ0uHbNbZdhF1FxBOncD3k1yi2m5mlADwAE3B+XaewWCB59
 PnRUDeDTHlC2jBKZU1MSchKxNp9QmbNHJIhDq/E8ood98qpXFixskaCEvZiyrOfVsKHP
 t2Qw==
X-Gm-Message-State: AOJu0YziBcVCWS/uIOf1qdvkVgvaRWcz/9KYJ7+XI0do3Y3MnMDGhUR4
 O4WjCaQgfdnB/JaLb48lXTW1gdfZMifqZE+WsqLKs2+R73c7/xW/x9hO+lpoGnY=
X-Google-Smtp-Source: AGHT+IFgupgGF8g3yHTGxN55tCaSBRwtKo4dfVgrN/xIeYzop2l6LnPFwgUPeJNuX0KzNmZpwxciRA==
X-Received: by 2002:a17:906:f28f:b0:a68:dff5:b153 with SMTP id
 a640c23a62f3a-a699f67ecddmr330314266b.33.1717666714931; 
 Thu, 06 Jun 2024 02:38:34 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80582949sm71413366b.31.2024.06.06.02.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:38:34 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:38:30 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v2 08/14] net-lwip: add wget command
Message-ID: <ZmGDliTx_DKVaU-V@hera>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <98a1de5f01dad1ad55b68ebadcbad1f6357246a6.1716566960.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98a1de5f01dad1ad55b68ebadcbad1f6357246a6.1716566960.git.jerome.forissier@linaro.org>
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

Hi Jerome

>  	if (!label)
>  		return CMD_RET_FAILURE;
>
> -	if (!wget_validate_uri(argv[3])) {
> -		printf("ERROR: invalid URI\n");
> -		return CMD_RET_FAILURE;
> +	if (IS_ENABLED(CONFIG_CMD_WGET)) {

efi_boot_add_uri() is only called if CONFIG_EFI_HTTP_BOOT which selectes
WGET

> +		if (!wget_validate_uri(argv[3])) {
> +			printf("ERROR: invalid URI\n");
> +			return CMD_RET_FAILURE;
> +		}
>  	}
>
>  	efi_create_indexed_name(var_name16, var_name16_size, "Boot", id);
> diff --git a/cmd/net-common.c b/cmd/net-common.c
> new file mode 100644
> index 00000000000..b5dfd2c8866
> --- /dev/null
> +++ b/cmd/net-common.c
> @@ -0,0 +1,112 @@

[...]

> +
> +static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
> +			    u32_t rx_content_len, u32_t srv_res, err_t err)
> +{
> +	ulong elapsed;
> +
> +	if (httpc_result != HTTPC_RESULT_OK) {
> +		log_err("\nHTTP client error %d\n", httpc_result);
> +		done = FAILURE;
> +		return;
> +	}
> +
> +	elapsed = get_timer(start_time);
> +        log_info("\n%u bytes transferred in %lu ms (", rx_content_len,
> +                 get_timer(start_time));
> +        print_size(rx_content_len / elapsed * 1000, "/s)\n");
> +
> +	if (env_set_hex("filesize", rx_content_len) ||
> +	    env_set_hex("fileaddr", saved_daddr)) {
> +		log_err("Could not set filesize or fileaddr\n");
> +		done = FAILURE;
> +		return;
> +	}
> +
> +	done = SUCCESS;
> +}
> +
> +int wget_with_dns(ulong dst_addr, char *uri)
> +{
> +	char server_name[SERVER_NAME_SIZE];
> +	httpc_connection_t conn;
> +	httpc_state_t *state;
> +	char *path;
> +	u16 port;
> +
> +	daddr = dst_addr;
> +	saved_daddr = dst_addr;
> +	done = NOT_DONE;
> +	size = 0;
> +	prevsize = 0;
> +
> +	if (parse_url(uri, server_name, &port, &path))
> +		return CMD_RET_USAGE;
> +
> +	memset(&conn, 0, sizeof(conn));
> +	conn.result_fn = httpc_result_cb;
> +	start_time = get_timer(0);
> +	if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
> +			       NULL, &state))
> +		return CMD_RET_FAILURE;
> +
> +	while (!done) {
> +		eth_rx();
> +		sys_check_timeouts();
> +		if (ctrlc())
> +			break;
> +	}

You probably don't need the 'done' enum here. There's a state->rx_status,
which if I am reading tlwip correctly should be filled in with the results
of httpc_result_t

> +
> +	if (done == SUCCESS)
> +		return 0;
> +
> +	return -1;
> +}
> +
> +int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
> +{
> +	char *url;
> +	ulong dst_addr;
> +
> +	if (argc < 2 || argc > 3)
> +		return CMD_RET_USAGE;
> +
> +	dst_addr = image_load_addr;
> +
> +	if (!strncmp(argv[1], "0x", 2)) {
> +		if (argc < 3)
> +			return CMD_RET_USAGE;
> +		dst_addr = hextoul(argv[1], NULL);
> +		url = argv[2];
> +	} else {
> +		url = argv[1];
> +	}
> +
> +	if (wget_with_dns(dst_addr, url))
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> --
> 2.40.1
>

Cheers
/Ilias
