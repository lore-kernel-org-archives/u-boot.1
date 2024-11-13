Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04175D42BBF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F64B8916C;
	Wed, 13 Nov 2024 14:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yb7ABK7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE3C89198; Wed, 13 Nov 2024 14:33:01 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ADA2890D9
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 14:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so85958435e9.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 05:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731504778; x=1732109578; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Y8gmbiKhDs3Z3Qg2PGVgwvkCqaoysRy66Ovd3bV0gP0=;
 b=yb7ABK7VJfWUeqt8Go0/pMpgWBy1zmDGRLYMB5Cx/liAQ2WrAyVTK2AgdUjuReXaUF
 6oLzbvrNWgnU/+N4u6cAqY9+T941wXjCQhRVx+1SzmT4bCucad43LyARfjN3/sk5W9JM
 miHpDj1Afi4lXOAmxVBMV1/A6TSPSrs6irh76HBR727oDfRAfvC7xvJVvbQzfW9Def9D
 b8y3ootlQ3M/osgQuCMKmfvtrX9RKRfiQ95H3XaPdqPlOPTS6Sp4RGMlQ+mQwNJK2MBR
 s7prlgRry+6/jk1K+ypsX/uGwfkEfaD6ZhB5xIXYxjBKhi6X01hHTLKxwIcT+Mj+wwIR
 ymUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731504778; x=1732109578;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Y8gmbiKhDs3Z3Qg2PGVgwvkCqaoysRy66Ovd3bV0gP0=;
 b=HVB+HXl7jL1SqOyngUM05rjPoq3pSrgmUp0zfTOuS2xrGceL+9QT84aG1GN2A7zcCU
 kgz6+Kq5CCf74tFTVhRnuCXRWjXCEL+CRyZXYbGvtlYie1xF8X9cQNywqV7JfwaELA81
 0s9ktch9xjAWfJUyW1YpKY0ShOL9KvaqXN2x4UGlediTjfl5n6LUh7N7fW64eBLeMCim
 nPTeSx7+lTh6sh3kXexGr4u6C5/NaptDKgTLBQbt6Ft6MBL9bpdsRHFs9Brun4s4wvur
 Wnc0vcNwxJrfkvvpHBgVA82ylxBEu2PjHpiKwjLpvn5jYNbDuG3MBblteVOLaVez45O7
 ffKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaSB0bnEgfmU2JszsEmrmQu+vrJ7oR6MykjLgzYJOc+B7IzFVD7wXxu87pkApU7xJDxhcHoYA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1uCSvKjda5x/SeZrfCP19cUkm67tQSVOg1MUaX+brYrYfbAe7
 oWkPnaeb7XmWUmwMjP+UFIK6bStAterlQGmq0/QSEC3vg5L/dlhFpnMOOg6Q4Hc=
X-Google-Smtp-Source: AGHT+IHFnIk+O0IxcmR6kYqhKtG6gdFHlLoq4n8lE89abVe3Yl3y2CgsUwEatAZi87JtSDM97VIwrw==
X-Received: by 2002:a5d:47aa:0:b0:382:6d2:d86c with SMTP id
 ffacd0b85a97d-38206d2d8bcmr7499038f8f.37.1731504778449; 
 Wed, 13 Nov 2024 05:32:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:e35e:22ff:8c36:1a4a?
 ([2a01:e0a:982:cbb0:e35e:22ff:8c36:1a4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97fe9bsm18242013f8f.35.2024.11.13.05.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 05:32:58 -0800 (PST)
Message-ID: <4dc079b8-4087-4c50-919b-dc676d38191d@linaro.org>
Date: Wed, 13 Nov 2024 14:32:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] cmd: add a fetch utility
To: Caleb Connolly <caleb.connolly@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, u-boot@lists.denx.de
References: <20241113042536.1792150-2-caleb.connolly@linaro.org>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <20241113042536.1792150-2-caleb.connolly@linaro.org>
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

On 13/11/2024 05:22, Caleb Connolly wrote:
> Add a small utility for displaying some information about U-Boot and the
> hardware it's running on in a similar fashion to the popular neofetch
> tool for Linux [1].
> 
> While the output is meant to be useful, it should also be pleasing to
> look at and perhaps entertaining. The ufetch command aims to bring this
> to U-Boot, featuring a colorful ASCII art version of the U-Boot logo.
> 
> [1]: https://en.wikipedia.org/wiki/Neofetch
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Ephemeral screenshot: https://0x0.st/XkQU.png
> 
> Changes since v1:
>   * Rework storage info to be more dynamic
>   * use print_size() helper everywhere
>   * manually walk RAM banks to report memory size correctly
>   * minor formatting changes and fixes
>   * MAINTAINERS entry
>   * V1: https://lore.kernel.org/u-boot/20240808163153.2069650-1-caleb.connolly@linaro.org
> ---
>   MAINTAINERS  |   5 ++
>   cmd/Kconfig  |   7 ++
>   cmd/Makefile |   1 +
>   cmd/ufetch.c | 224 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 237 insertions(+)
>   create mode 100644 cmd/ufetch.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38c714cf46a6..d1eb164ad590 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1724,8 +1724,13 @@ M:	Heiko Schocher <hs@denx.de>
>   S:	Maintained
>   T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
>   F:	drivers/mtd/ubi/
>   
> +UFETCH
> +M:	Caleb Connolly <caleb.connolly@linaro.org>
> +S:	Maintained
> +F:	cmd/ufetch.c
> +
>   UFS
>   M:	Neil Armstrong <neil.armstrong@linaro.org>
>   M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
>   M:	Neha Malcom Francis <n-francis@ti.com>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 4fba9fe67034..da736249a3cf 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -175,8 +175,15 @@ config CMD_CPU
>   	  number of CPUs, type (e.g. manufacturer, architecture, product or
>   	  internal name) and clock frequency. Other information may be
>   	  available depending on the CPU driver.
>   
> +config CMD_UFETCH
> +	bool "U-Boot fetch"
> +	depends on BLK
> +	help
> +	  Fetch utility for U-Boot (akin to neofetch). Prints information
> +	  about U-Boot and the board it is running on in a pleasing format.
> +
>   config CMD_FWU_METADATA
>   	bool "fwu metadata read"
>   	depends on FWU_MULTI_BANK_UPDATE
>   	help
> diff --git a/cmd/Makefile b/cmd/Makefile
> index d1f369deec0a..1e6d3128c8ca 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -52,8 +52,9 @@ obj-$(CONFIG_CMD_CONSOLE) += console.o
>   obj-$(CONFIG_CMD_CPU) += cpu.o
>   obj-$(CONFIG_CMD_DATE) += date.o
>   obj-$(CONFIG_CMD_DEMO) += demo.o
>   obj-$(CONFIG_CMD_DM) += dm.o
> +obj-$(CONFIG_CMD_UFETCH) += ufetch.o
>   obj-$(CONFIG_CMD_SOUND) += sound.o
>   ifdef CONFIG_POST
>   obj-$(CONFIG_CMD_DIAG) += diag.o
>   endif
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> new file mode 100644
> index 000000000000..1bd0565b9f08
> --- /dev/null
> +++ b/cmd/ufetch.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Small "fetch" utility for U-Boot */
> +
> +#ifdef CONFIG_ARM
> +#include <asm/system.h>
> +#endif
> +#include <dm/device.h>
> +#include <dm/uclass-internal.h>
> +#include <display_options.h>
> +#include <mmc.h>
> +#include <time.h>
> +#include <asm/global_data.h>
> +#include <cli.h>
> +#include <command.h>
> +#include <dm/ofnode.h>
> +#include <env.h>
> +#include <rand.h>
> +#include <vsprintf.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <version.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define LINE_WIDTH 40
> +#define BLUE "\033[38;5;4m"
> +#define YELLOW "\033[38;5;11m"
> +#define BOLD "\033[1m"
> +#define RESET "\033[0m"
> +static const char * const logo_lines[] = {
> +	BLUE BOLD "                  ......::......                   ",
> +	BLUE BOLD "             ...::::::::::::::::::...              ",
> +	BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
> +	BLUE BOLD "        .::::.:::::::::::::::...::::.::::.         ",
> +	BLUE BOLD "      .::::::::::::::::::::..::::::::::::::.       ",
> +	BLUE BOLD "    .::.:::::::::::::::::::" YELLOW "=*%#*" BLUE "::::::::::.::.     ",
> +	BLUE BOLD "   .:::::::::::::::::....." YELLOW "*%%*-" BLUE ":....::::::::::.    ",
> +	BLUE BOLD "  .:.:::...:::::::::.:-" YELLOW "===##*---==-" BLUE "::::::::::.:.   ",
> +	BLUE BOLD " .::::..::::........" YELLOW "-***#****###****-" BLUE "...::::::.:.  ",
> +	BLUE BOLD " ::.:.-" YELLOW "+***+=" BLUE "::-" YELLOW "=+**#%%%%%%%%%%%%###*= " BLUE "-::...::::. ",
> +	BLUE BOLD ".:.::-" YELLOW "*****###%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE ":..:::: ",
> +	BLUE BOLD ".::" YELLOW "##" BLUE ":" YELLOW "***#%%%%%%#####%%%%%%%####%%%%%####%%%*" BLUE "-.::. ",
> +	BLUE BOLD ":.:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%#*****##%%%#*****##%%##*****#%%+" BLUE ".::.",
> +	BLUE BOLD ".::" YELLOW "**==#%%%%%%%##****#%%%%##****#%%%%#****###%%" BLUE ":.. ",
> +	BLUE BOLD "..:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%%%%%+ " BLUE ".:.",
> +	BLUE BOLD " ::" YELLOW "##" BLUE ":" YELLOW "+**#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%* " BLUE "-.:: ",
> +	BLUE BOLD " ..::-" YELLOW "#****#%#%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE "-..::.  ",
> +	BLUE BOLD "  ...:=" YELLOW "*****=" BLUE "::-" YELLOW "=+**###%%%%%%%%###**+=  " BLUE "--:...:::  ",
> +	BLUE BOLD "   .::.::--:........::::::--::::::......::::::.    ",
> +	BLUE BOLD "    .::.....::::::::::...........:::::::::.::.     ",
> +	BLUE BOLD "      .::::::::::::::::::::::::::::::::::::.       ",
> +	BLUE BOLD "        .::::.::::::::::::::::::::::.::::.         ",
> +	BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
> +	BLUE BOLD "             ...::::::::::::::::::...              ",
> +	BLUE BOLD "                  ......::......                   ",
> +};
> +
> +enum output_lines {
> +	FIRST,
> +	SECOND,
> +	KERNEL,
> +	SYSINFO,
> +	HOST,
> +	UPTIME,
> +	IP,
> +	CMDS,
> +	CONSOLES,
> +	DEVICES,
> +	FEATURES,
> +	RELOCATION,
> +	CORES,
> +	MEMORY,
> +	STORAGE,
> +
> +	/* Up to 10 storage devices... Should be enough for anyone right? */
> +	_LAST_LINE = (STORAGE + 10),
> +#define LAST_LINE (_LAST_LINE - 1UL)
> +};
> +
> +static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
> +		     char *const argv[])
> +{
> +	int num_lines = max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
> +	const char *model, *compatible;
> +	char *ipaddr;
> +	int n_cmds, n_cpus = 0, ret, compatlen;
> +	size_t size;
> +	ofnode np;
> +	struct udevice *dev;
> +	struct blk_desc *desc;
> +	bool skip_ascii = false;
> +
> +	if (argc > 1 && strcmp(argv[1], "-n") == 0) {
> +		skip_ascii = true;
> +		num_lines = LAST_LINE;
> +	}
> +
> +	for (int line = 0; line < num_lines; line++) {
> +		if (!skip_ascii) {
> +			if (line < ARRAY_SIZE(logo_lines))
> +				printf("%s  ", logo_lines[line]);
> +			else
> +				printf("%*c  ", LINE_WIDTH, ' ');
> +		}
> +		switch (line) {
> +		case FIRST:
> +			compatible = ofnode_read_string(ofnode_root(), "compatible");
> +			if (!compatible)
> +				compatible = "unknown";
> +			printf(RESET "%s\n", compatible);
> +			compatlen = strlen(compatible);
> +			break;
> +		case SECOND:
> +			for (int j = 0; j < compatlen; j++)
> +				putc('-');
> +			putc('\n');
> +			break;
> +		case KERNEL:
> +			printf("Kernel:" RESET " %s\n", U_BOOT_VERSION);
> +			break;
> +		case SYSINFO:
> +			printf("Config:" RESET " %s_defconfig\n", CONFIG_SYS_CONFIG_NAME);
> +			break;
> +		case HOST:
> +			model = ofnode_read_string(ofnode_root(), "model");
> +			if (model)
> +				printf("Host:" RESET " %s\n", model);
> +			break;
> +		case UPTIME:
> +			printf("Uptime:" RESET " %ld seconds\n", get_timer(0) / 1000);
> +			break;
> +		case IP:
> +			ipaddr = env_get("ipvaddr");
> +			if (!ipaddr)
> +				ipaddr = "none";
> +			printf("IP Address:" RESET " %s", ipaddr);
> +			ipaddr = env_get("ipv6addr");
> +			if (ipaddr)
> +				printf(", %s\n", ipaddr);
> +			else
> +				putc('\n');
> +			break;
> +		case CMDS:
> +			n_cmds = ll_entry_count(struct cmd_tbl, cmd);
> +			printf("Commands:" RESET " %d (help)\n", n_cmds);
> +			break;
> +		case CONSOLES:
> +			printf("Consoles:" RESET " %s (%d baud)\n", env_get("stdout"),
> +			       gd->baudrate);
> +			break;
> +		case DEVICES:
> +			printf("Devices:" RESET " ");
> +			/* TODO: walk the DM tree */
> +			printf("Uncountable!\n");
> +			break;
> +		case FEATURES:
> +			printf("Features:" RESET " ");
> +			if (IS_ENABLED(CONFIG_NET))
> +				printf("Net");
> +			if (IS_ENABLED(CONFIG_EFI_LOADER))
> +				printf(", EFI");
> +			if (IS_ENABLED(CONFIG_CMD_CAT))
> +				printf(", cat :3");
> +#ifdef CONFIG_ARM
> +			switch (current_el()) {
> +			case 2:
> +				printf(", VMs");
> +				break;
> +			case 3:
> +				printf(", full control!");
> +				break;
> +			}
> +#endif
> +			printf("\n");
> +			break;
> +		case RELOCATION:
> +			if (gd->flags & GD_FLG_SKIP_RELOC)
> +				printf("Relocated:" RESET " no\n");
> +			else
> +				printf("Relocated:" RESET " to %#011lx\n", gd->relocaddr);
> +			break;
> +		case CORES:
> +			ofnode_for_each_subnode(np, ofnode_path("/cpus")) {
> +				if (ofnode_name_eq(np, "cpu"))
> +					n_cpus++;
> +			}
> +			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
> +			break;
> +		case MEMORY:
> +			for (int j = 0; j < CONFIG_NR_DRAM_BANKS && gd->bd->bi_dram[j].size; j++)
> +				size += gd->bd->bi_dram[j].size;
> +			printf("Memory:" RESET " ");
> +			print_size(size, "\n");
> +			break;
> +		case STORAGE:
> +		default:
> +			ret = uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev);
> +			if (!ret && dev) {
> +				desc = dev_get_uclass_plat(dev);
> +				size = desc->lba * desc->blksz;
> +				printf("%s %d: " RESET, desc->uclass_id == UCLASS_SCSI ? "SCSI" :
> +						desc->uclass_id == UCLASS_MMC
> +						? "MMC" : "Storage",
> +					desc->lun);
> +				if (size)
> +					print_size(size, "");
> +				else
> +					printf("No media");
> +			}
> +			printf("\n");
> +		}
> +	}
> +
> +	printf(RESET "\n\n");
> +
> +	return 0;
> +}
> +
> +U_BOOT_CMD(ufetch, 2, 1, do_ufetch,
> +	   "U-Boot fetch utility",
> +	   "Print information about your device.\n"
> +	   "    -n    Don't print the ASCII logo"
> +);

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8560-QRD

Ephemeral screenshot: https://0x0.st/Xk2N.png

Thanks,
Neil
