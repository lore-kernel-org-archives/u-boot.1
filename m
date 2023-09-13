Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4AAEEB597
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 06:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0802A86CC4;
	Wed, 13 Sep 2023 08:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VONyOSls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89196868D7; Wed, 13 Sep 2023 08:15:15 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E674786D31
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 08:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c5a2e8501so6307177f8f.0
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694585712; x=1695190512; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5kh6Sc7AFuC5rV0KuYZiSFVJH8ZeKWpUlAIH1lpRLEM=;
 b=VONyOSlsHUgi7E+GSbsABx6Y8YgdoZrN8tdJjJxRC8XaEn6YS5M6O5XPw1StDpjcA4
 SL9MOK4HkZa4gqE5xyWCvvFEfPErslkR7/e+5b/joRT6N3rA2dML0otQ75b0vDoMcXWS
 P9ET9bz52t6MIiaXHj4XlY4EoK7RfcXKCMD1/Dzy0bmvLvAQFsAuwAMdPUgahIBWaWW5
 S0X88JKqO9dq8ujzME4ZjXl6qgAJCybYVth15f3+NNa8I3aZkdOak6r5gKmo9aFsShfN
 XAhHIR9wsV4SnfDg6dQD7Wwy4Grr2dtNLPd2z9m1PL8zN0cmcxAoWJ6GdM+xf+U5zycW
 VAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694585712; x=1695190512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kh6Sc7AFuC5rV0KuYZiSFVJH8ZeKWpUlAIH1lpRLEM=;
 b=kjtVpFVMHeJ0N2JeoHz3iX/G14fJyCxe2qZ+CBtidoBKMS0UBp3lPp8/FTWKXZtAEl
 YGfxFQkcvX20H0l/HEWYIx03/O+lgEVu92z9+idd48hnB6PsxMMSWm89muI6XlRK2wdH
 Qfi/LVxlZRXDupMKJtXz7EktINmH0s4bTf0lraP29+KxZhafFMtQkmAaucgfJ22n8GTJ
 imOBd76P74HR0d6j1xeKJqWBpXAdZG8/EKI025N6JnaYj3NKRuLzVRYEyHCc8gZd+yzI
 Qyj76mfHj7IefjpNe9gI9bZp5UihcdhdHaRWu6GaRTPoYZl8CTXxwkjOg9iFGkIvCGlK
 ph8w==
X-Gm-Message-State: AOJu0YycyfSgsxws/XXxLW8IQk0EGNCa0Bpq6oddOconTIN+nAOAZvhh
 f+EJNSnt5qzeDn9UDz6ruxcPvw==
X-Google-Smtp-Source: AGHT+IEmmvjabuvQ6MGmu96js/mhQlc8ySeD8akTXwekW+8ZDfrrgGqLaKGXldQ8QfSMMxKeaXbG8Q==
X-Received: by 2002:adf:e50b:0:b0:319:6ec3:79c7 with SMTP id
 j11-20020adfe50b000000b003196ec379c7mr1110388wrm.36.1694585712300; 
 Tue, 12 Sep 2023 23:15:12 -0700 (PDT)
Received: from hera (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d484d000000b0031f3b04e7cdsm14508877wrs.109.2023.09.12.23.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 23:15:11 -0700 (PDT)
Date: Wed, 13 Sep 2023 09:15:09 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de
Subject: Re: [PATCHv8 05/15] net/lwip: implement tftp cmd
Message-ID: <ZQFTbcuLihQm2qoI@hera>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135320.7066-6-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908135320.7066-6-maxim.uvarov@linaro.org>
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

> +
> +/*
> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> + */
> +
> +#include <common.h>
> +#include <command.h>
> +#include <console.h>
> +#include <bootstage.h>
> +
> +#include "tftp_client.h"
> +#include "tftp_server.h"
> +#include <tftp_example.h>
> +
> +#include <string.h>
> +
> +#include <net/ulwip.h>
> +
> +static ulong daddr;
> +static ulong size;
> +
> +static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
> +{
> +	return NULL;
> +}
> +
> +static void tftp_close(void *handle)
> +{
> +	log_info("\ndone\n");
> +	log_info("Bytes transferred = %ld (0x%lx hex)\n", size, size);
> +
> +	bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
> +	if (env_set_hex("filesize", size)) {
> +		log_err("filesize not updated\n");
> +		ulwip_exit(-1);
> +		return;
> +	}
> +	ulwip_exit(0);
> +}
> +
> +static int tftp_read(void *handle, void *buf, int bytes)
> +{
> +	return 0;
> +}
> +
> +static int tftp_write(void *handle, struct pbuf *p)
> +{
> +	struct pbuf *q;
> +
> +	for (q = p; q != NULL; q = q->next) {
> +		memcpy((void *)daddr, q->payload, q->len);
> +		daddr += q->len;
> +		size += q->len;
> +		log_info("#");
> +	}
> +
> +	return 0;
> +}
> +
> +static void tftp_error(void *handle, int err, const char *msg, int size)
> +{
> +	char message[100];
> +
> +	memset(message, 0, sizeof(message));
> +	memcpy(message, msg, LWIP_MIN(sizeof(message) - 1, (size_t)size));
> +
> +	log_info("TFTP error: %d (%s)", err, message);
> +}
> +
> +static const struct tftp_context tftp = {
> +	tftp_open,
> +	tftp_close,
> +	tftp_read,
> +	tftp_write,
> +	tftp_error
> +};
> +
> +int ulwip_tftp(ulong addr, char *fname)
> +{
> +	void *f = (void *)0x1; /* unused fake file handle*/

I haven't dug into lwip details yet, but I am not sure this is safe to use.
Simon, since you maintain the lwip part can you elaborate a bit more?

> +	err_t err;
> +	ip_addr_t srv;
> +	int ret;
> +	char *server_ip;
> +
> +	if (!fname || addr == 0)
> +		return CMD_RET_FAILURE;
> +
> +	size = 0;
> +	daddr = addr;
> +	server_ip = env_get("serverip");
> +	if (!server_ip) {
> +		log_err("error: serverip variable has to be set\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	ret = ipaddr_aton(server_ip, &srv);
> +	if (!ret) {
> +		log_err("error: ipaddr_aton\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	log_info("TFTP from server %s; our IP address is %s\n",
> +		 server_ip, env_get("ipaddr"));
> +	log_info("Filename '%s'.\n", fname);
> +	log_info("Load address: 0x%lx\n", daddr);
> +	log_info("Loading:");
> +
> +	bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start");
> +
> +	err = tftp_init_client(&tftp);
> +	if (!(err == ERR_OK || err == ERR_USE))
> +		log_err("tftp_init_client err: %d\n", err);
> +
> +	err = tftp_get(f, &srv, TFTP_PORT, fname, TFTP_MODE_OCTET);
> +	/* might return different errors, like routing problems */
> +	if (err != ERR_OK) {
> +		log_err("tftp_get err=%d\n", err);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (env_set_hex("fileaddr", addr)) {
> +		log_err("fileaddr not updated\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> --
> 2.30.2
>

Thanks
/Ilias
