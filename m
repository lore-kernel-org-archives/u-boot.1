Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFB2E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 13:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2545A8012C;
	Fri, 13 Dec 2024 14:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="QHX8I6P1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F24F0801DA; Fri, 13 Dec 2024 14:46:11 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EADE8012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 14:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so2483160a12.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 05:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1734097569; x=1734702369;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uhP+yxF/qBojVhDHZhw2/7bP7D1xyDAN47tW56OoBmI=;
 b=QHX8I6P1jBgfU0tPmQuf+tgbxWvVGuyC2HN/+wOxtUEZMB9Rkoz1ytMgQsRSQUDNi2
 3UN5zSFmwW9mnt4sUWBOzGQ/EY/ob7OoLltzD4BMXoFameNh74g/bkgzYwFZl1/pVDPx
 LMuLBvyclKhIxF2OtqGdw5AtkeHMjc16aUln5XuM2bZwD6dRsE81ReUXu+IYcCBau9br
 0ZA6SItHKZUKKaYKywlN4z8SG6Geee2aVdJzh5gfKE9v0NnYiY9JbAR1y1goNEtZ5F6x
 b/s07uG/uv/EgofQSlo+5lfj+ODBmYs1pL6QkkQv8QU4vykfgtPDLXFZ7DBjC6vk612M
 brCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734097569; x=1734702369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uhP+yxF/qBojVhDHZhw2/7bP7D1xyDAN47tW56OoBmI=;
 b=U/iOR2KIow64pyury4+L4MOgY0WssAs2L7MFZbS+NCC1AvFd2HilbQUQVRwQ7tfvev
 CoD5gL1/6PmfZ7tdn0puWTKYU2zNDlaa2wX5RoCX2J9K4tRHlbuBrGvFslpvZk1zh2Ny
 R9zQf9quF5E0tBr1E1khH5mYuNx5bs0HWB4CWR+yd/d3fEN+UeNEOyTQxAQIBvd+pIFZ
 zWBUkzFsU3Sn/gQaDplDqjceIcoD1Pe+PS47ef0pEEmbeea4exL3eTXWS/OtLtEUMBUQ
 fTzWjEO1BfkRzcwrTosewuphIb0E4g1/Kf40uL8bxT5mC8aVBjPiXuZmpeCaprs97Xzi
 Cv8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfBcEgtsIarDljzmzuprq30WGyK5i4u2CSMYXy+r9izgSQ3BGeT2509wdChyhhXhgQGf8pNo0=@lists.denx.de
X-Gm-Message-State: AOJu0YzDYncfKkfe81frCIkiRb4NK8NDKhs/bZgu0VF3rLqtBjIGicCm
 LYHRJPuESA+kxibOy7iUGk4fLVxCGqNXJ3GYO2qaStetqssRMTlQja3cfeAX+UNUdbKEulB2fMp
 TGw==
X-Gm-Gg: ASbGnctvuFw/qp44Rjwc4+rIKPPZ1ikMBRfLiJDX57MO0+rjmYMESgVlPkuo5ZpvwhP
 XzFj06vZIyP3FXWlZDA1wgtY8gF3tdA4sjn3zrRIVkfSIngbxRPbGGpaK4x0UJroPNL8API+afx
 eT83zcCp08DuIje00lU7KmlflQoxneRcBtlPnF/tUzO+APxyisXfxIFxWIP6y7hTYmvbjS7BqPM
 3joYCQGlGNav0gYwXFEjPJUuD6931nIWdw09DCt+E48otWzYbUqlVC3VEnhJ1/IkjA4GApV
X-Google-Smtp-Source: AGHT+IH0NBRGONWyXz0LuaqITMiiCFr3YV0LmrXGwrpKHLA/YdyysQVdWXdd+Dz3CTnvdgXSWFdOXA==
X-Received: by 2002:a17:907:720a:b0:aab:73c5:837 with SMTP id
 a640c23a62f3a-aab77ed4919mr294027166b.52.1734097568605; 
 Fri, 13 Dec 2024 05:46:08 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6705a566dsm837924866b.162.2024.12.13.05.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 05:46:08 -0800 (PST)
Message-ID: <0964dd45-1982-4a63-a430-73cca10aadf8@monstr.eu>
Date: Fri, 13 Dec 2024 14:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] board: xilinx: zynq: Add a new cmd to run postconfig
To: xueweiwujxw <xueweiwujxw@gmail.com>, u-boot@lists.denx.de
References: <20241213085225.2800775-1-xueweiwujxw@gmail.com>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20241213085225.2800775-1-xueweiwujxw@gmail.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 12/13/24 09:52, xueweiwujxw wrote:
> This patch adds a new command named "post_config" to execute the
> "ps7_post_config" function.
> 
> Signed-off-by: xueweiwujxw <xueweiwujxw@gmail.com>

first of all please spell your name properly here.

> ---
>   board/xilinx/zynq/Kconfig              | 17 +++++++++++++++++
>   board/xilinx/zynq/Makefile             |  2 +-
>   board/xilinx/zynq/cmds.c               | 20 ++++++++++++++++++++
>   test/py/tests/test_zynq_post_config.py | 16 ++++++++++++++++
>   4 files changed, 54 insertions(+), 1 deletion(-)
>   create mode 100644 test/py/tests/test_zynq_post_config.py

When the patch is applied.
make xilinx_zynq_virt_defconfig
make

   CC      arch/arm/cpu/armv7/syslib.o
board/xilinx/zynq/cmds.c:21:10: fatal error: ps7_init_gpl.h: No such file or 
directory
    21 | #include "ps7_init_gpl.h"
       |          ^~~~~~~~~~~~~~~~
compilation terminated.

Please look below.

> 
> diff --git a/board/xilinx/zynq/Kconfig b/board/xilinx/zynq/Kconfig
> index d6f40631cc..a1624c71c0 100644
> --- a/board/xilinx/zynq/Kconfig
> +++ b/board/xilinx/zynq/Kconfig
> @@ -30,4 +30,21 @@ config CMD_ZYNQ_RSA
>   	  and authentication feature enabled while generating
>   	  BOOT.BIN using Xilinx bootgen tool.
>   
> +config CMD_POST_CONFIG
> +	bool "Enable post_config command"
> +	default y
> +	help
> +	  This option enables the 'post_config' command in U-Boot.
> +	  The 'post_config' command is used to execute the PS7 post-configuration
> +	  process after loading an FPGA bitstream file on Xilinx Zynq devices.
> +	  This command ensures that the programmable logic (PL) and
> +	  processing system (PS) are properly synchronized after
> +	  FPGA configuration. It is specifically useful in designs where
> +	  additional initialization steps are required for the PS to
> +	  correctly interact with the configured PL.

ps7_init() is called only from SPL in current configuration.
And ps7_post_config() is called from spl_board_prepare_for_boot() already.
It means cases where SPL loads bitstream should be working just fine.

Then we can switch to case where bitstream is loaded via u-boot command.
The biggest question is if your ps7_init_gpl is aligned with the design you are 
actually loading. Likely yes but in general it doesn't need to be.

Then we are getting to another question if calling ps7_post_config in this 
context make sense or if it is better to do it in a different way.

I think you should work on better description why you think that this should be 
called/done. And it is not clear what else you want to do after bitstream is 
loaded. If this is about enabling ps-pl interface and getting pl out of reset we 
can talk about it.


> +	  This option is only applicable to Xilinx Zynq platforms and

That's what it is said already because this file is sourced only when Zynq is 
selected.

> +	  has no effect on other architectures. If you are not using the
> +	  PS7 subsystem or do not require post-configuration steps,
> +	  this option can be disabled to reduce the size of the U-Boot binary.
> +
>   endif
> diff --git a/board/xilinx/zynq/Makefile b/board/xilinx/zynq/Makefile
> index f40fe382f5..366a4d931a 100644
> --- a/board/xilinx/zynq/Makefile
> +++ b/board/xilinx/zynq/Makefile
> @@ -32,7 +32,7 @@ endif
>   endif
>   
>   ifndef CONFIG_XPL_BUILD
> -obj-$(CONFIG_CMD_ZYNQ) += cmds.o
> +obj-$(CONFIG_CMD_ZYNQ) += $(init-objs) cmds.o

No idea what you are trying to do here.

>   obj-$(CONFIG_CMD_ZYNQ_RSA) += bootimg.o
>   endif
>   
> diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
> index 05ecb75406..60278fcdf6 100644
> --- a/board/xilinx/zynq/cmds.c
> +++ b/board/xilinx/zynq/cmds.c
> @@ -18,6 +18,7 @@
>   #include <zynqpl.h>
>   #include <fpga.h>
>   #include <zynq_bootimg.h>
> +#include "ps7_init_gpl.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -548,3 +549,22 @@ U_BOOT_LONGHELP(zynq,
>   U_BOOT_CMD(zynq,	6,	0,	do_zynq,
>   	   "Zynq specific commands", zynq_help_text
>   );
> +
> +static int do_ps7_fpga_post_config(struct cmd_tbl *cmdtp, int flag, int argc,
> +				   char *const argv[])
> +{
> +	int ret = PS7_INIT_SUCCESS;
> +
> +	if (IS_ENABLED(CONFIG_CMD_POST_CONFIG))

Clearly wrong. You should enable this command only when Kconfig is enabled.

> +		ret = ps7_post_config();
> +
> +	if (ret != PS7_INIT_SUCCESS)
> +		puts("ERROR:run board ps7 post config failed.\n");
> +	else
> +		puts("INFO: run board ps7 post config succeed.\n");

you have return value from command. No need to be verbose. But you can but under 
DEBUG only.

> +	return ret;

use cmd_process_error()

> +}
> +
> +U_BOOT_CMD(post_config,	1,	0,	do_ps7_fpga_post_config,
> +	   "run ps7 post config after fpga load bin file",	""
> +);

Obviously own command make no sense. You have zynq command already and this 
would be it's subcommand.


> diff --git a/test/py/tests/test_zynq_post_config.py b/test/py/tests/test_zynq_post_config.py
> new file mode 100644
> index 0000000000..4493f8f190
> --- /dev/null
> +++ b/test/py/tests/test_zynq_post_config.py
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Test for the "post_config" command
> +#
> +# xueweiwujxw

This should be full copyright with name, year, etc

> +
> +import pytest
> +
> +@pytest.mark.buildconfigspec('cmd_post_config')
> +def test_post_config(u_boot_console):
> +    """Test the 'post_config' command on Zynq platform"""
> +
> +    output = u_boot_console.run_command("post_config")
> +
> +    assert "INFO: run board ps7 post config succeed." in output
> +

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

