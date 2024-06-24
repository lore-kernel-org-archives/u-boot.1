Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0E6C2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D8887F3B;
	Mon, 24 Jun 2024 10:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RnS8i/eh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE7F187CFE; Mon, 24 Jun 2024 10:49:22 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9596E87E30
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 10:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4217d451f69so34501565e9.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719218960; x=1719823760; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vha7xRjbmseLvXidaJVRxerB3+0NOUBPsfVif0MWYvA=;
 b=RnS8i/ehmI6q5Y7v6pkUFrn8GO0xd0XieNypbiiB04hF0AVroE9xqEmYGgOBEm0/J/
 DTRoovZvUYtc5XTRXxUw9vrwcmKHt1DCRhpDXYpRIeRiMuE0EDU0Ao3LIbnmVViXAex7
 hQmUs4X8dR8KIICQuzOg1sSz+u+A+5RLM/kHlazvv8KkvAv76MtCCYa1SvbeD18VwpET
 L4dchhvEKZkEB1h70alKQoCTUeL3T92cykHxj5RnjgzLU6cyWd0S/SUdBoMdcHTTcj2W
 zHpIJdbY3449CLtA28dJYWY6cXnDGsSifgMI0t6tQkyZ9s+8CPZ1OW7nATj1AdE1asi9
 tOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719218960; x=1719823760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vha7xRjbmseLvXidaJVRxerB3+0NOUBPsfVif0MWYvA=;
 b=my6s2uFc/+T6az8En1VdGlu6yjEiOc7Qu85TU57E3oKf0jc+04Cg1t7CEMSO+lPoUt
 pjboCPtXq4gk5pbhfLbv7xdqm8nONvB5cOC/VCkfBSbNtfrL6cD2/ehMDhjyI0f92mN6
 XEmBQ9OCzP1zE3SZaNNMgU22CP86agkaD9cR+8xjzdOR5Nl7e9PAONxoL4ZjZeXw5zRK
 CJBq8gfROsBzbjGGe6JG1CAuqDbQj1QZKXb688p+XU8g9DLlUvjpDRypx9JyIrwY7JpI
 nlgUXIwKx9uocWVyFslgq/6UfqRVV2kOO7qweWs8/LH/BpqD0IEu9ozPdDapczaFFKRZ
 BPGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0Rq9ZIxpPAJqws5jI8v+6ks5lZJOnWSInq96fs5ejIrX51Rg0Wks0LPK/99bl+FGW1XEQkCxxvOEorJqCEn1MQ5yBiw==
X-Gm-Message-State: AOJu0YzzJtLrperete4+TO+C+5Q3CbWdDGbHWs8E1TmrqgES6TmmzybX
 s91+IV0iYLufaz+uyF3rdKJvzHW/UWznQ1yyNcnBbCWO/Y43f3I/W4B7exV8q58=
X-Google-Smtp-Source: AGHT+IGAeBaoq066y+6zDGdF1F6A+Q+MDv/TMiVVzC57EOPr+IcUYTQzNbvASBG/hRQB3jgsfaPp4A==
X-Received: by 2002:a05:600c:3b0d:b0:424:97f1:6b2d with SMTP id
 5b1f17b1804b1-424985cce83mr985705e9.3.1719218959857; 
 Mon, 24 Jun 2024 01:49:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:4500:90e2:c2d5:54ab?
 ([2a01:e0a:3cb:7bb0:4500:90e2:c2d5:54ab])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424817b4ad8sm126713545e9.21.2024.06.24.01.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 01:49:19 -0700 (PDT)
Message-ID: <33cdfc51-178a-4c4b-90e2-683dc7f8ac51@linaro.org>
Date: Mon, 24 Jun 2024 10:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/14] net-lwip: add wget command
To: Jon Humphreys <jhumphreysti@gmail.com>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Peter Robinson <pbrobinson@gmail.com>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <ba84782cebf8a151ae7bd5d9abc4b313fb4334e8.1718638104.git.jerome.forissier@linaro.org>
 <86frt2vp2k.fsf@udb0321960.dhcp.ti.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <86frt2vp2k.fsf@udb0321960.dhcp.ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/24/24 08:21, Jon Humphreys wrote:
> Jerome Forissier <jerome.forissier@linaro.org> writes:
> 
>> Add support for the wget command with NET_LWIP.
>>
>> Based on code initially developed by Maxim U.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
>> Cc: Maxim Uvarov <muvarov@gmail.com>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  cmd/Kconfig        |   7 ++
>>  cmd/net-lwip.c     |   8 ++
>>  include/net-lwip.h |  18 +++
>>  net-lwip/Makefile  |   1 +
>>  net-lwip/wget.c    | 269 +++++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 303 insertions(+)
>>  create mode 100644 net-lwip/wget.c
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 6ef0b52cd34..d9a86540be6 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -2117,6 +2117,13 @@ config CMD_TFTPBOOT
>>  	help
>>  	  tftpboot - load file via network using TFTP protocol
>>  
>> +config CMD_WGET
>> +	bool "wget"
>> +	select PROT_TCP_LWIP
>> +	help
>> +	  wget is a simple command to download kernel, or other files,
>> +	  from a http server over TCP.
>> +
>>  endif
>>  
>>  endif
>> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
>> index c021da6a674..42f8bd6b259 100644
>> --- a/cmd/net-lwip.c
>> +++ b/cmd/net-lwip.c
>> @@ -35,3 +35,11 @@ U_BOOT_CMD(
>>  	"hostname [envvar]"
>>  );
>>  #endif
>> +
>> +#if defined(CONFIG_CMD_WGET)
>> +U_BOOT_CMD(
>> +	wget,   3,      1,      do_wget,
>> +	"boot image via network using HTTP protocol",
>> +	"[loadAddress] URL"
>> +);
>> +#endif
>> diff --git a/include/net-lwip.h b/include/net-lwip.h
>> index 4d41b0208a3..ddf25e61417 100644
>> --- a/include/net-lwip.h
>> +++ b/include/net-lwip.h
>> @@ -11,8 +11,26 @@ struct netif *net_lwip_new_netif_noip(void);
>>  void net_lwip_remove_netif(struct netif *netif);
>>  struct netif *net_lwip_get_netif(void);
>>  
>> +/**
>> + * wget_with_dns() - runs dns host IP address resulution before wget
>> + *
>> + * @dst_addr:	destination address to download the file
>> + * @uri:	uri string of target file of wget
>> + * Return:	downloaded file size, negative if failed
>> + */
>> +
>> +int wget_with_dns(ulong dst_addr, char *uri);
>> +/**
>> + * wget_validate_uri() - varidate the uri
>> + *
>> + * @uri:	uri string of target file of wget
>> + * Return:	true if uri is valid, false if uri is invalid
>> + */
>> +bool wget_validate_uri(char *uri);
>> +
>>  int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>>  int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>>  int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>> +int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
>>  
>>  #endif /* __NET_LWIP_H__ */
>> diff --git a/net-lwip/Makefile b/net-lwip/Makefile
>> index aa247859483..bc011bb0e32 100644
>> --- a/net-lwip/Makefile
>> +++ b/net-lwip/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_CMD_DHCP) += dhcp.o
>>  obj-$(CONFIG_CMD_DNS) += dns.o
>>  obj-$(CONFIG_CMD_PING) += ping.o
>>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
>> +obj-$(CONFIG_CMD_WGET) += wget.o
>>  
>>  # Disable this warning as it is triggered by:
>>  # sprintf(buf, index ? "foo%d" : "foo", index)
>> diff --git a/net-lwip/wget.c b/net-lwip/wget.c
>> new file mode 100644
>> index 00000000000..069299bd469
>> --- /dev/null
>> +++ b/net-lwip/wget.c
>> @@ -0,0 +1,269 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/* Copyright (C) 2024 Linaro Ltd. */
>> +
>> +#include <command.h>
>> +#include <console.h>
>> +#include <display_options.h>
>> +#include <image.h>
>> +#include <lwip/apps/http_client.h>
>> +#include <lwip/timeouts.h>
>> +#include <net.h>
>> +#include <time.h>
>> +
>> +#define SERVER_NAME_SIZE 200
>> +#define HTTP_PORT_DEFAULT 80
>> +#define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
>> +
>> +enum done_state {
>> +        NOT_DONE = 0,
>> +        SUCCESS = 1,
>> +        FAILURE = 2
>> +};
>> +
>> +struct wget_ctx {
>> +	ulong daddr;
>> +	ulong saved_daddr;
>> +	ulong size;
>> +	ulong prevsize;
>> +	ulong start_time;
>> +	enum done_state done;
>> +};
>> +
>> +static int parse_url(char *url, char *host, u16 *port, char **path)
>> +{
>> +	char *p, *pp;
>> +	long lport;
>> +
>> +	p = strstr(url, "http://");
>> +	if (!p)
>> +		return -EINVAL;
>> +
>> +	p += strlen("http://");
>> +
>> +	/* Parse hostname */
>> +	pp = strchr(p, ':');
>> +	if (!pp)
>> +		pp = strchr(p, '/');
>> +	if (!pp)
>> +		return -EINVAL;
>> +
>> +	if (p + SERVER_NAME_SIZE <= pp)
>> +		return -EINVAL;
>> +
>> +	memcpy(host, p, pp - p);
>> +	host[pp - p + 1] = '\0';
>> +
>> +	if (*pp == ':') {
>> +		/* Parse port number */
>> +		p = pp + 1;
>> +		lport = simple_strtol(p, &pp, 10);
>> +		if (pp && *pp != '/')
>> +			return -EINVAL;
>> +		if (lport > 65535)
>> +			return -EINVAL;
>> +		*port = (u16)lport;
>> +	} else {
>> +		*port = HTTP_PORT_DEFAULT;
>> +	}
>> +	if (*pp != '/')
>> +		return -EINVAL;
>> +	*path = pp;
>> +
>> +	return 0;
>> +}
>> +
>> +static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
>> +			   err_t err)
>> +{
>> +	struct wget_ctx *ctx = arg;
>> +	struct pbuf *buf;
>> +
>> +	if (!pbuf)
>> +		return ERR_BUF;
>> +
>> +	for (buf = pbuf; buf; buf = buf->next) {
>> +		memcpy((void *)ctx->daddr, buf->payload, buf->len);
>> +		ctx->daddr += buf->len;
>> +		ctx->size += buf->len;
>> +		if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
>> +			printf("#");
>> +			ctx->prevsize = ctx->size;
>> +		}
>> +	}
>> +
>> +	altcp_recved(pcb, pbuf->tot_len);
>> +	pbuf_free(pbuf);
>> +	return ERR_OK;
>> +}
>> +
>> +static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>> +			    u32_t rx_content_len, u32_t srv_res, err_t err)
>> +{
>> +	struct wget_ctx *ctx = arg;
>> +	ulong elapsed;
>> +
>> +	if (httpc_result != HTTPC_RESULT_OK) {
>> +		log_err("\nHTTP client error %d\n", httpc_result);
>> +		ctx->done = FAILURE;
>> +		return;
>> +	}
>> +
>> +	elapsed = get_timer(ctx->start_time);
>> +	if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
>> +		printf("\n");
>> +        printf("%u bytes transferred in %lu ms (", rx_content_len,
>> +	       get_timer(ctx->start_time));
>> +        print_size(rx_content_len / elapsed * 1000, "/s)\n");
>> +
>> +	if (env_set_hex("filesize", rx_content_len) ||
>> +	    env_set_hex("fileaddr", ctx->saved_daddr)) {
>> +		log_err("Could not set filesize or fileaddr\n");
>> +		ctx->done = FAILURE;
>> +		return;
>> +	}
>> +
>> +	ctx->done = SUCCESS;
>> +}
>> +
>> +int wget_with_dns(ulong dst_addr, char *uri)
>> +{
>> +	char server_name[SERVER_NAME_SIZE];
>> +	httpc_connection_t conn;
>> +	httpc_state_t *state;
>> +	struct netif *netif;
>> +	struct wget_ctx ctx;
>> +	char *path;
>> +	u16 port;
>> +
>> +	ctx.daddr = dst_addr;
>> +	ctx.saved_daddr = dst_addr;
>> +	ctx.done = NOT_DONE;
>> +	ctx.size = 0;
>> +	ctx.prevsize = 0;
>> +
>> +	if (parse_url(uri, server_name, &port, &path))
>> +		return CMD_RET_USAGE;
>> +
>> +	netif = net_lwip_new_netif();
>> +	if (!netif)
>> +		return -1;
>> +
>> +	memset(&conn, 0, sizeof(conn));
>> +	conn.result_fn = httpc_result_cb;
>> +	ctx.start_time = get_timer(0);
>> +	if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
>> +			       &ctx, &state)) {
>> +		net_lwip_remove_netif(netif);
>> +		return CMD_RET_FAILURE;
>> +	}
>> +
>> +	while (!ctx.done) {
>> +		eth_rx();
>> +		sys_check_timeouts();
>> +		if (ctrlc())
>> +			break;
>> +	}
>> +
>> +	net_lwip_remove_netif(netif);
>> +
>> +	if (ctx.done == SUCCESS)
>> +		return 0;
>> +
>> +	return -1;
>> +}
>> +
>> +int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>> +{
>> +	char *end;
>> +	char *url;
>> +	ulong dst_addr;
>> +
>> +	if (argc < 2 || argc > 3)
>> +		return CMD_RET_USAGE;
>> +
>> +	dst_addr = hextoul(argv[1], &end);
>> +        if (end == (argv[1] + strlen(argv[1]))) {
>> +		if (argc < 3)
>> +			return CMD_RET_USAGE;
>> +		url = argv[2];
>> +	} else {
>> +		dst_addr = image_load_addr;
>> +		url = argv[1];
>> +	}
>> +
>> +	if (wget_with_dns(dst_addr, url))
>> +		return CMD_RET_FAILURE;
>> +
>> +	return CMD_RET_SUCCESS;
>> +}
>> +
>> +/**
>> + * wget_validate_uri() - validate the uri for wget
>> + *
>> + * @uri:	uri string
>> + *
>> + * This function follows the current U-Boot wget implementation.
>> + * scheme: only "http:" is supported
>> + * authority:
>> + *   - user information: not supported
>> + *   - host: supported
>> + *   - port: not supported(always use the default port)
>> + *
>> + * Uri is expected to be correctly percent encoded.
>> + * This is the minimum check, control codes(0x1-0x19, 0x7F, except '\0')
>> + * and space character(0x20) are not allowed.
>> + *
>> + * TODO: stricter uri conformance check
>> + *
>> + * Return:	true on success, false on failure
>> + */
>> +bool wget_validate_uri(char *uri)
>> +{
>> +	char c;
>> +	bool ret = true;
>> +	char *str_copy, *s, *authority;
>> +
>> +	for (c = 0x1; c < 0x21; c++) {
>> +		if (strchr(uri, c)) {
>> +			log_err("invalid character is used\n");
>> +			return false;
>> +		}
>> +	}
>> +	if (strchr(uri, 0x7f)) {
>> +		log_err("invalid character is used\n");
>> +		return false;
>> +	}
>> +
>> +	if (strncmp(uri, "http://", 7)) {
>> +		log_err("only http:// is supported\n");
>> +		return false;
>> +	}
>> +	str_copy = strdup(uri);
>> +	if (!str_copy)
>> +		return false;
>> +
>> +	s = str_copy + strlen("http://");
>> +	authority = strsep(&s, "/");
>> +	if (!s) {
>> +		log_err("invalid uri, no file path\n");
>> +		ret = false;
>> +		goto out;
>> +	}
>> +	s = strchr(authority, '@');
>> +	if (s) {
>> +		log_err("user information is not supported\n");
>> +		ret = false;
>> +		goto out;
>> +	}
>> +	s = strchr(authority, ':');
>> +	if (s) {
>> +		log_err("user defined port is not supported\n");
>> +		ret = false;
>> +		goto out;
>> +	}
>> +
>> +out:
>> +	free(str_copy);
>> +
>> +	return ret;
>> +}
>> -- 
>> 2.40.1

Hi Jon,

> Hi Jerome, I am trying out the lwIP stack on TI boards.
> 
> For wget, I noticed a bug and a user experience improvement. The bug is an
> off-by-one array access when parsing the url.

Indeed, someone reported this bug to me off-list and it's already fixed in
my WIP branch.

> The improvement emits a
> message if the url isn't an http://, since that is all we are supporting,
> and without the message, the wget command silently fails, which is
> confusing to the user.

I agree.

> I will post the 2 patches as a reply to this email. LMK if you want to use
> another method to collaborate. I can already see that efi http boot support
> will not work. wget_validate_uri() looks to be copied vertabim from the
> current implementation, and IMO we should completely remove it.

It is indeed copied. It is needed to avoid an unresolved symbol but I
understand more work may be needed for EFI HTTP boot support (not tested by
me).

If you are willing to help with this then you are welcome to post patches as
replies and I will integrate them in the series.

Thanks,
-- 
Jerome
