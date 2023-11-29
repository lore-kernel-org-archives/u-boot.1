Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E717EC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 09:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7CD87026;
	Wed, 29 Nov 2023 10:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qEAF3HHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A68A86F1F; Wed, 29 Nov 2023 10:24:50 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8204B86DB1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso52432615e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 01:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701249888; x=1701854688; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=9jBoLieBWO4Cmq5oacEZP9CsSourHgNCXpsnSigxOmY=;
 b=qEAF3HHNGNMzr/QPmXuWDPBw1Jrz1VMj3dyS3O4DClv7cZ5f7J2YeBU0oHFWUjKS/a
 ktoglv/sjgEphy4oU/bKZLKLvJFwAgWqpymKzvcIYbuKLM3Ag3YKwxKfSpuXYAKns/8T
 YQyB1bJ+KHplGN+zhonchCtotCJ1bEN+p/IBASGEo9ODQqMYvT7AbtHdW+NxRCe2jR6C
 khqBpdmVK2oLfEYYE2aYfVJ/fygAgERavfMjbDPoy8dlGgV0T7Nh0BUsf8y6dMoE/oG2
 NPvzPfjmAgEnvSF/bR8fVPuJoI11Qy/cohKTtQK84VX7MrXC4o5uPEAewOFnj6z5Zsy/
 XvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701249888; x=1701854688;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9jBoLieBWO4Cmq5oacEZP9CsSourHgNCXpsnSigxOmY=;
 b=Pa7kb6WeYiaOcqfpiODrxzJ2AOL+qyMNY7Vh2b0+/WjjLz8ZJQ14tK5aEqen4ZvhwW
 nic2i9FkhzNwZ1E9INnf+MTrYWhSZOWn99UYty+gYwv13QQpLtrfd0dZDl3U/Dg8W8uL
 9W8ID1cB8gjF7d8ufIMDIbKa0ECIzjAuc7WbmYzG4Pin6hLz61jP635AnIDaRDmYiW7J
 Fwhi2LDZM+c/MdR4VpdX2NwMGk4EoCR4Ftd6vH/bOsLJEBx3A+zPU5Ppa0gmSRhat1pb
 2J+j1YwpnIFAc2a5So9DhcVs3V0dJOp0AoIRzziiPR8uxyWeLVvLHXUKZlmZSmjC0PMV
 XCiw==
X-Gm-Message-State: AOJu0Yyqzw7myyLAhKED2R9roSXMjYWEQKk7WWhwQxoaWwTDX7nOFa6y
 pdXB8s2AmieQgJBqRxXKdVm0UQ==
X-Google-Smtp-Source: AGHT+IEaOMtpiN5twx1YxyCYlulZzfsH6sphEPFQy4lBF4F0WyUzD7cY4wCsdWpLZQZE+18Hx5pLyg==
X-Received: by 2002:a5d:42c6:0:b0:32f:8248:e00 with SMTP id
 t6-20020a5d42c6000000b0032f82480e00mr11885211wrr.51.1701249887780; 
 Wed, 29 Nov 2023 01:24:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c?
 ([2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c])
 by smtp.gmail.com with ESMTPSA id
 t10-20020adff60a000000b003316db2d48dsm3971371wrp.34.2023.11.29.01.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 01:24:47 -0800 (PST)
Message-ID: <20a60c18-5e25-42b3-882d-9c27a0b39604@linaro.org>
Date: Wed, 29 Nov 2023 10:24:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATHv11 06/43] net/lwip: implement tftp cmd
Content-Language: en-US, fr
To: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-7-maxim.uvarov@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231127125726.3735-7-maxim.uvarov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 27/11/2023 13:56, Maxim Uvarov wrote:
> U-Boot recently got support for an alternative network stack using LWIP.
> Replace tftp command with the LWIP variant while keeping the output and
> error messages identical.
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>   include/net/lwip.h             |  13 ++++
>   net/lwip/Makefile              |   1 +
>   net/lwip/apps/tftp/Makefile    |   7 ++
>   net/lwip/apps/tftp/lwip-tftp.c | 132 +++++++++++++++++++++++++++++++++
>   4 files changed, 153 insertions(+)
>   create mode 100644 net/lwip/apps/tftp/Makefile
>   create mode 100644 net/lwip/apps/tftp/lwip-tftp.c
> 
> diff --git a/include/net/lwip.h b/include/net/lwip.h
> index 9941845f8c..f025384c26 100644
> --- a/include/net/lwip.h
> +++ b/include/net/lwip.h
> @@ -29,3 +29,16 @@ int ulwip_dns(char *name, char *varname);
>    *         Other value < 0, if error
>    **/
>   int ulwip_dhcp(void);
> +
> +/**
> + * ulwip_tftp() - load file with tftp
> + *
> + * Load file with tftp to specific address
> + *
> + * @addr: Address to store downloaded file
> + * @filename: File name on remote tftp server to download
> + *
> + *
> + * Returns:  0 if success, !0 if error
> + */
> +int ulwip_tftp(ulong addr, const char *filename);
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index a3a33b7f71..b348e5ca31 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -65,3 +65,4 @@ obj-$(CONFIG_NET) += port/sys-arch.o
>   
>   obj-y += apps/dhcp/lwip-dhcp.o
>   obj-y += apps/dns/lwip-dns.o
> +obj-y += apps/tftp/
> diff --git a/net/lwip/apps/tftp/Makefile b/net/lwip/apps/tftp/Makefile
> new file mode 100644
> index 0000000000..c3ad3c6353
> --- /dev/null
> +++ b/net/lwip/apps/tftp/Makefile
> @@ -0,0 +1,7 @@
> +ccflags-y += -I$(srctree)/net/lwip/port/include
> +ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
> +ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include/lwip/apps
> +ccflags-y += -I$(srctree)/net/lwip/lwip-external/contrib/examples/tftp/
> +
> +obj-y += ../../lwip-external/src/apps/tftp/tftp.o
> +obj-y += lwip-tftp.o
> diff --git a/net/lwip/apps/tftp/lwip-tftp.c b/net/lwip/apps/tftp/lwip-tftp.c
> new file mode 100644
> index 0000000000..7b384cecf8
> --- /dev/null
> +++ b/net/lwip/apps/tftp/lwip-tftp.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
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
> +static unsigned int progress_print;
> +#define PROGRESS_PRINT 700 /* about one # per Megabyte */
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

Current tftp code uses map_sysmem() in order to write to physical memory,
you may need to switch to that for tftp & wget in order to make sure you
write at the right virtual address on all platforms:

-		memcpy((void *)daddr, q->payload, q->len);
+		void *ptr = map_sysmem(daddr, q->len);
+		memcpy(ptr, q->payload, q->len);
+		unmap_sysmem(ptr);

See 55d5fd9a84 net: Access mapped physmem in net functions

Neil

> +		daddr += q->len;
> +		size += q->len;
> +		if (!(progress_print++ % PROGRESS_PRINT))
> +			log_info("#");
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

