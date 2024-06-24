Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8BEC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6178882B7;
	Mon, 24 Jun 2024 14:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8245B88360; Mon, 24 Jun 2024 08:21:20 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5173882B7
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 08:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jhumphreysti@gmail.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45O6L8WC081007;
 Mon, 24 Jun 2024 01:21:08 -0500
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45O6L8FZ030033
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 24 Jun 2024 01:21:08 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jun 2024 01:21:07 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Mon, 24 Jun
 2024 01:21:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jun 2024 01:21:07 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45O6L7hZ092458;
 Mon, 24 Jun 2024 01:21:07 -0500
From: Jon Humphreys <jhumphreysti@gmail.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia
 <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 "AKASHI Takahiro" <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, Peter Robinson
 <pbrobinson@gmail.com>
Subject: Re: [PATCH v4 10/14] net-lwip: add wget command
In-Reply-To: <ba84782cebf8a151ae7bd5d9abc4b313fb4334e8.1718638104.git.jerome.forissier@linaro.org>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <ba84782cebf8a151ae7bd5d9abc4b313fb4334e8.1718638104.git.jerome.forissier@linaro.org>
Date: Mon, 24 Jun 2024 01:21:07 -0500
Message-ID: <86frt2vp2k.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 24 Jun 2024 14:52:21 +0200
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

Jerome Forissier <jerome.forissier@linaro.org> writes:

> Add support for the wget command with NET_LWIP.
>
> Based on code initially developed by Maxim U.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
> Cc: Maxim Uvarov <muvarov@gmail.com>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/Kconfig        |   7 ++
>  cmd/net-lwip.c     |   8 ++
>  include/net-lwip.h |  18 +++
>  net-lwip/Makefile  |   1 +
>  net-lwip/wget.c    | 269 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 303 insertions(+)
>  create mode 100644 net-lwip/wget.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 6ef0b52cd34..d9a86540be6 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2117,6 +2117,13 @@ config CMD_TFTPBOOT
>  	help
>  	  tftpboot - load file via network using TFTP protocol
>  
> +config CMD_WGET
> +	bool "wget"
> +	select PROT_TCP_LWIP
> +	help
> +	  wget is a simple command to download kernel, or other files,
> +	  from a http server over TCP.
> +
>  endif
>  
>  endif
> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> index c021da6a674..42f8bd6b259 100644
> --- a/cmd/net-lwip.c
> +++ b/cmd/net-lwip.c
> @@ -35,3 +35,11 @@ U_BOOT_CMD(
>  	"hostname [envvar]"
>  );
>  #endif
> +
> +#if defined(CONFIG_CMD_WGET)
> +U_BOOT_CMD(
> +	wget,   3,      1,      do_wget,
> +	"boot image via network using HTTP protocol",
> +	"[loadAddress] URL"
> +);
> +#endif
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index 4d41b0208a3..ddf25e61417 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -11,8 +11,26 @@ struct netif *net_lwip_new_netif_noip(void);
>  void net_lwip_remove_netif(struct netif *netif);
>  struct netif *net_lwip_get_netif(void);
>  
> +/**
> + * wget_with_dns() - runs dns host IP address resulution before wget
> + *
> + * @dst_addr:	destination address to download the file
> + * @uri:	uri string of target file of wget
> + * Return:	downloaded file size, negative if failed
> + */
> +
> +int wget_with_dns(ulong dst_addr, char *uri);
> +/**
> + * wget_validate_uri() - varidate the uri
> + *
> + * @uri:	uri string of target file of wget
> + * Return:	true if uri is valid, false if uri is invalid
> + */
> +bool wget_validate_uri(char *uri);
> +
>  int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
> +int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
>  
>  #endif /* __NET_LWIP_H__ */
> diff --git a/net-lwip/Makefile b/net-lwip/Makefile
> index aa247859483..bc011bb0e32 100644
> --- a/net-lwip/Makefile
> +++ b/net-lwip/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_CMD_DHCP) += dhcp.o
>  obj-$(CONFIG_CMD_DNS) += dns.o
>  obj-$(CONFIG_CMD_PING) += ping.o
>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
> +obj-$(CONFIG_CMD_WGET) += wget.o
>  
>  # Disable this warning as it is triggered by:
>  # sprintf(buf, index ? "foo%d" : "foo", index)
> diff --git a/net-lwip/wget.c b/net-lwip/wget.c
> new file mode 100644
> index 00000000000..069299bd469
> --- /dev/null
> +++ b/net-lwip/wget.c
> @@ -0,0 +1,269 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2024 Linaro Ltd. */
> +
> +#include <command.h>
> +#include <console.h>
> +#include <display_options.h>
> +#include <image.h>
> +#include <lwip/apps/http_client.h>
> +#include <lwip/timeouts.h>
> +#include <net.h>
> +#include <time.h>
> +
> +#define SERVER_NAME_SIZE 200
> +#define HTTP_PORT_DEFAULT 80
> +#define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
> +
> +enum done_state {
> +        NOT_DONE = 0,
> +        SUCCESS = 1,
> +        FAILURE = 2
> +};
> +
> +struct wget_ctx {
> +	ulong daddr;
> +	ulong saved_daddr;
> +	ulong size;
> +	ulong prevsize;
> +	ulong start_time;
> +	enum done_state done;
> +};
> +
> +static int parse_url(char *url, char *host, u16 *port, char **path)
> +{
> +	char *p, *pp;
> +	long lport;
> +
> +	p = strstr(url, "http://");
> +	if (!p)
> +		return -EINVAL;
> +
> +	p += strlen("http://");
> +
> +	/* Parse hostname */
> +	pp = strchr(p, ':');
> +	if (!pp)
> +		pp = strchr(p, '/');
> +	if (!pp)
> +		return -EINVAL;
> +
> +	if (p + SERVER_NAME_SIZE <= pp)
> +		return -EINVAL;
> +
> +	memcpy(host, p, pp - p);
> +	host[pp - p + 1] = '\0';
> +
> +	if (*pp == ':') {
> +		/* Parse port number */
> +		p = pp + 1;
> +		lport = simple_strtol(p, &pp, 10);
> +		if (pp && *pp != '/')
> +			return -EINVAL;
> +		if (lport > 65535)
> +			return -EINVAL;
> +		*port = (u16)lport;
> +	} else {
> +		*port = HTTP_PORT_DEFAULT;
> +	}
> +	if (*pp != '/')
> +		return -EINVAL;
> +	*path = pp;
> +
> +	return 0;
> +}
> +
> +static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
> +			   err_t err)
> +{
> +	struct wget_ctx *ctx = arg;
> +	struct pbuf *buf;
> +
> +	if (!pbuf)
> +		return ERR_BUF;
> +
> +	for (buf = pbuf; buf; buf = buf->next) {
> +		memcpy((void *)ctx->daddr, buf->payload, buf->len);
> +		ctx->daddr += buf->len;
> +		ctx->size += buf->len;
> +		if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
> +			printf("#");
> +			ctx->prevsize = ctx->size;
> +		}
> +	}
> +
> +	altcp_recved(pcb, pbuf->tot_len);
> +	pbuf_free(pbuf);
> +	return ERR_OK;
> +}
> +
> +static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
> +			    u32_t rx_content_len, u32_t srv_res, err_t err)
> +{
> +	struct wget_ctx *ctx = arg;
> +	ulong elapsed;
> +
> +	if (httpc_result != HTTPC_RESULT_OK) {
> +		log_err("\nHTTP client error %d\n", httpc_result);
> +		ctx->done = FAILURE;
> +		return;
> +	}
> +
> +	elapsed = get_timer(ctx->start_time);
> +	if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
> +		printf("\n");
> +        printf("%u bytes transferred in %lu ms (", rx_content_len,
> +	       get_timer(ctx->start_time));
> +        print_size(rx_content_len / elapsed * 1000, "/s)\n");
> +
> +	if (env_set_hex("filesize", rx_content_len) ||
> +	    env_set_hex("fileaddr", ctx->saved_daddr)) {
> +		log_err("Could not set filesize or fileaddr\n");
> +		ctx->done = FAILURE;
> +		return;
> +	}
> +
> +	ctx->done = SUCCESS;
> +}
> +
> +int wget_with_dns(ulong dst_addr, char *uri)
> +{
> +	char server_name[SERVER_NAME_SIZE];
> +	httpc_connection_t conn;
> +	httpc_state_t *state;
> +	struct netif *netif;
> +	struct wget_ctx ctx;
> +	char *path;
> +	u16 port;
> +
> +	ctx.daddr = dst_addr;
> +	ctx.saved_daddr = dst_addr;
> +	ctx.done = NOT_DONE;
> +	ctx.size = 0;
> +	ctx.prevsize = 0;
> +
> +	if (parse_url(uri, server_name, &port, &path))
> +		return CMD_RET_USAGE;
> +
> +	netif = net_lwip_new_netif();
> +	if (!netif)
> +		return -1;
> +
> +	memset(&conn, 0, sizeof(conn));
> +	conn.result_fn = httpc_result_cb;
> +	ctx.start_time = get_timer(0);
> +	if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
> +			       &ctx, &state)) {
> +		net_lwip_remove_netif(netif);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	while (!ctx.done) {
> +		eth_rx();
> +		sys_check_timeouts();
> +		if (ctrlc())
> +			break;
> +	}
> +
> +	net_lwip_remove_netif(netif);
> +
> +	if (ctx.done == SUCCESS)
> +		return 0;
> +
> +	return -1;
> +}
> +
> +int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
> +{
> +	char *end;
> +	char *url;
> +	ulong dst_addr;
> +
> +	if (argc < 2 || argc > 3)
> +		return CMD_RET_USAGE;
> +
> +	dst_addr = hextoul(argv[1], &end);
> +        if (end == (argv[1] + strlen(argv[1]))) {
> +		if (argc < 3)
> +			return CMD_RET_USAGE;
> +		url = argv[2];
> +	} else {
> +		dst_addr = image_load_addr;
> +		url = argv[1];
> +	}
> +
> +	if (wget_with_dns(dst_addr, url))
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +/**
> + * wget_validate_uri() - validate the uri for wget
> + *
> + * @uri:	uri string
> + *
> + * This function follows the current U-Boot wget implementation.
> + * scheme: only "http:" is supported
> + * authority:
> + *   - user information: not supported
> + *   - host: supported
> + *   - port: not supported(always use the default port)
> + *
> + * Uri is expected to be correctly percent encoded.
> + * This is the minimum check, control codes(0x1-0x19, 0x7F, except '\0')
> + * and space character(0x20) are not allowed.
> + *
> + * TODO: stricter uri conformance check
> + *
> + * Return:	true on success, false on failure
> + */
> +bool wget_validate_uri(char *uri)
> +{
> +	char c;
> +	bool ret = true;
> +	char *str_copy, *s, *authority;
> +
> +	for (c = 0x1; c < 0x21; c++) {
> +		if (strchr(uri, c)) {
> +			log_err("invalid character is used\n");
> +			return false;
> +		}
> +	}
> +	if (strchr(uri, 0x7f)) {
> +		log_err("invalid character is used\n");
> +		return false;
> +	}
> +
> +	if (strncmp(uri, "http://", 7)) {
> +		log_err("only http:// is supported\n");
> +		return false;
> +	}
> +	str_copy = strdup(uri);
> +	if (!str_copy)
> +		return false;
> +
> +	s = str_copy + strlen("http://");
> +	authority = strsep(&s, "/");
> +	if (!s) {
> +		log_err("invalid uri, no file path\n");
> +		ret = false;
> +		goto out;
> +	}
> +	s = strchr(authority, '@');
> +	if (s) {
> +		log_err("user information is not supported\n");
> +		ret = false;
> +		goto out;
> +	}
> +	s = strchr(authority, ':');
> +	if (s) {
> +		log_err("user defined port is not supported\n");
> +		ret = false;
> +		goto out;
> +	}
> +
> +out:
> +	free(str_copy);
> +
> +	return ret;
> +}
> -- 
> 2.40.1

Hi Jerome, I am trying out the lwIP stack on TI boards.

For wget, I noticed a bug and a user experience improvement. The bug is an
off-by-one array access when parsing the url. The improvement emits a
message if the url isn't an http://, since that is all we are supporting,
and without the message, the wget command silently fails, which is
confusing to the user.

I will post the 2 patches as a reply to this email. LMK if you want to use
another method to collaborate. I can already see that efi http boot support
will not work. wget_validate_uri() looks to be copied vertabim from the
current implementation, and IMO we should completely remove it.

Jon
