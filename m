Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF37606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I/0cm6S6;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kYDFfS44
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D57406066D;
	Thu, 26 Nov 2026 10:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FFxEGo5j_9pB; Thu, 26 Nov 2026 10:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0502B608E4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690569;
	b=jny79UA8hw67gyhanCotNRBrI4jVIlsMJa/5IqvCs2ZJ2q6Cu83BeiO5XhkQb9zp496f
	 FnxRLJllz53ou/Y+svmakt2+aWl9KgwvhFlyU8lzZad0PVGKI5J1TKdMSyIQfKlnNx/6E
	 dUVWQDcuuBjTKPScZnQP01fsO/ngnLbB0nOUXyMzGBX/YPe5LoE2g6+SK9W4Sm3ut4EoY
	 KCvDPgGd1iUwF9um+JBtbRf07tYNYgP9zGrO9KcZZL55d0avZTCttVkimL5DfZtu2UHHj
	 3qXOSPt4HjvR3sDV61+prO5BudC687W+Fob7DfNvpxQQNAj3AcBirLWxXAstNvBJmGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6BG4E3/3Luxar6r+aeF0wp6/OQkjNBA00++MjBR3ELQ=;
	b=lIFxYNRHumWBLmBy7wxWaVWF9STOUsSGmxWoBRccZbjc3gYkdoN/tqHiWkEexxD1bj/k
	 d0lFcVqU82l7z8/U+4epApFvvqxmWBxDuYz4HI3OGDt4B4IHaTFzG/Fv9HM3Dr53hF/EK
	 eMEUWog2aOHFyRAV5fY0y84c3VDUOG91tSncJ4R8Im400q8Yq6h+N1YUyQogTJ2HahilA
	 wtZJ2esLjY8xhQxy0laME0vCkkRW+EFJZHjlKK7OiEsTJurLEXDdOQc757X2s6KGioy04
	 ZdVr6F8M70PGFOlATpThkg9+Yyu2l122TDGTntoo7J//lxvvqItzCofI3I7dDrG85+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kYDFfS44;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690569;
	bh=6BG4E3/3Luxar6r+aeF0wp6/OQkjNBA00++MjBR3ELQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I/0cm6S6axEQtNRv8op8/IccFPraRbjRcmFjBFZOeSzCl3W4tTHBuFo8cWDhztz3r
	 /6tWpC6vMhc017czAY7dDsB6DZJDneI+a3rTVK41Fm18TILSQGzdpSuVikrNVTzmQ+
	 tqOxnYlAlkK/WL14MuBEXoqWvnQymkW6qUNnlUhS+xiGRbNpXgPZ6Culryzq9mrcp+
	 Fc3CPueaHRsd5T3WK9R36NTCUijY7LlSi95IV1r+Cg55T620C+ml/cHJpCtmFNqF1n
	 kbxujr4BbboP9C8GpzUnQ75CO2kJR0Lx4gyvIFOTWzVNuio1RhDnyh+TYejvcc/MIK
	 iTVngiDaOvZUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0502B608E4;
	Thu, 26 Nov 2026 10:56:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD5EB371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3C59608E4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ge-bLF-MkZm7 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:56:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 995D66066D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kYDFfS44
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 995D66066D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:56:06 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso68582405e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 02:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795690564; x=1796295364;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6BG4E3/3Luxar6r+aeF0wp6/OQkjNBA00++MjBR3ELQ=;
 b=kYDFfS447G1/tz0zHrk+X5rq96ut9V7nZtpOK+Un7DTeipWqzxK6oQ5arcDCp5cE1L
 31aLLo3sukubkURWjEEklMYhHz4EqTwOn4QKfpGmeDZIxIHZqGGWLSS0/jLBGxZhJIf7
 rxijMJiz7RQ4A9PH3lZvcNg28SZj3DWaoARBe4LM7hgfmdZKr3xEp6Lzog8XJCFXuSZG
 OoGmGhh0RHcdLa6YnMC9ukBk3ATMZUWMfvN8Khj16dD1ihPcj3wbfaUl0WZtoM/mTKmF
 xhCQg/5WfOp+jVnsuokLV94I5N3o7cS8R139qD8kmmRAH6GIiJhS0H996Txs+b68jJfE
 KxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795690564; x=1796295364;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6BG4E3/3Luxar6r+aeF0wp6/OQkjNBA00++MjBR3ELQ=;
 b=c9F5Vbuzsk5caJauLSJusWZZqj5ItwNBBUggeJT0FfcJSv8mdnbkD6wKVsXm5nvxNI
 8X+c756i850cE9FuApXY3+7GhNHsNAoi/YkosUFR8imXx+YUPB6pto2rhZjeHSKM6Vo3
 oc3d80KhcpBzrTHPswpUvS9xSMHadf/2uMXyyQyazYyPuM15D0aVrDS+rOUy63mf5c0K
 5+Q+xJE6m7enSk8TF9dtGb5PXxrMutIl0QkcENwAYX+eJiPaoloU60EsAGdth6ZLKCPM
 ynroxaBGrknA7lGVpBEuMzDPfvgRiVFYvhTlKwLBi8Wz1VXYEjpygZ3JurCfNtDGLpjQ
 STWw==
X-Forwarded-Encrypted: i=1;
 AL+hErH31Nz/pmU6ZMgQATrcoibrpxY7aYcWpZF2yDytf4psM0+MJVivfIti7pv4wvswf+78CoZiAfo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+0tdGRMeyymDkHCjz9zUP+7Ik2A5UgiU8qrnd9BrM9BxuH2nu/
 Xp6pYIko984Ek2ZDJQcIdZejegOvjzqEzhOD0j14DJXc7mVVdJffeKUg2BdwgPCQA2s=
X-Gm-Gg: AZFdTZfye0Wm4Qf07Vo3sbF88gG2NLZXSvRoip1h9TBJ5aqUWsjn4NH9HhUSzHVAJbj
 xXU8/2nRD+iVvoQUHbbttQZ4Xys/EHVsrqMFsErRJx7ZOssEtB9o8VeOL8/ROHg/7XOgX7wtNeT
 6E0kiN+jnlCzDQpwLHYuPEjAVuZ8gRg/yuXeufuLITBDLvCstWro4Qkhk5PW0uK/uFhCPoeoZ9X
 +KKn6Lr6DLyvFvvA3GuaiMZI3cnSMyF7jNCieDwcnTd3hZWoh2UA8KmoTYozdSgPgN1bcffUzme
 BeZRuZ4Z2t0RV9Wpw4oBpDyCN7yewLAB/GmhY9ZvrzZr1PObTIRXViak0hZ7o92JbJS7D9oCN3S
 uRZez9ivCmV45402Ray+YQ0Fw6hhrFTsijUxFaedaqxl1tnDYMJuai3xAyWzK06tVzh47T6Q+UM
 zQLuwm0RGbEY3XGp6zGWlo6AwsfNhXmb9q/w18k0M3/8ynS9lLB/NvR8JJWvTKX7k4PTv72KJN3
 vyWbdx6mLkiYfKdoXJYS5kZsGnDwrsPWQq3PqxJywjMut2DROLDGU/Rp6HR5AnhTvb3J5i8ZkY5
 7JwocbgmUQO8eqcL9LjHLJ5Srd74657cBwXptoQe/2WuZzYcGjzJmG5dcKwc96RizgXj6lqp
X-Received: by 2002:a05:600c:4585:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4bb8881b8e4mr425337525e9.17.1795690564373; 
 Thu, 26 Nov 2026 02:56:04 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9066f6e6sm278313125e9.3.2026.11.26.02.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 02:56:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] net: lwip: serve Fastboot over UDP
From: Guillaume La Roque <glaroque@baylibre.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sam Day <me@samcday.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261123-submit-lwip-fastboot-v1-v1-1-34c1eff8b1f0@gmail.com>
References: <20261123-submit-lwip-fastboot-v1-v1-0-34c1eff8b1f0@gmail.com>
 <20261123-submit-lwip-fastboot-v1-v1-1-34c1eff8b1f0@gmail.com>
Date: Thu, 26 Nov 2026 11:56:00 +0100
Message-Id: <179569056100.2037761.12085622432481166235.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795690563; l=5185;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=ABjpxPb8KuqM0Qd1I/ZC8HeZOMM8CSwcjaJiX0vRXk0=;
 b=4M2ulPert/9y/DpD03KYPlZTtS3OpWTy8hN0ulkZ7j/ChmhZqj3QaJvkjZm8C9WZQ4aR5Pfc+
 3OBVo7d4pBICuDfzaiJU2Qn3RiTdVZI6f/83ZmAi3QxCKv7/lLTgpXi
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi James,

This patch does three things at once: it moves the UDP protocol engine
to net/fastboot-udp-common.c, it changes how the legacy stack behaves
(one multiresponse per host read, Init check, Query not overwriting the
cached reply, ...) and it adds the lwIP side. Since net/fastboot_udp.c
is mostly rewritten, it is hard to see what changes for legacy users.

Could you split it, something like:
- move the engine to the common file with no functional change
- the legacy fixes, in their own commits with the reason (the
  multiresponse one is a real fix: the host drops packets whose sequence
  does not match its request)
- add the lwIP UDP server

Regards,
Guillaume
> Allow the fastboot command to listen on the selected lwIP interface.
> Use the same UDP protocol engine for both network stacks. Restart the
> command state on Init, negotiate the packet size and cache each
> sequenced response for retransmission. A Query must not overwrite it.
> 
> Return one getvar:all or console response per host read so retrying that
> read does not skip an INFO line. Run command handlers outside the lwIP
> receive callback and release the interface before a boot or reboot.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  MAINTAINERS                |   2 +
>  cmd/fastboot.c             |   7 ++
>  drivers/fastboot/Kconfig   |   3 +-
>  include/fastboot.h         |  16 +++
>  include/net/fastboot_udp.h |   7 ++
>  net/Makefile               |   1 +
>  net/fastboot-udp-common.c  | 176 ++++++++++++++++++++++++++++
>  net/fastboot_udp.c         | 284 ++-------------------------------------------
>  net/lwip/Makefile          |   1 +
>  net/lwip/fastboot_udp.c    |  96 +++++++++++++++
>  10 files changed, 319 insertions(+), 274 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e8350b26c20a..2400daab7bc6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1048,8 +1048,10 @@ F:	include/net/fastboot_tcp.h
>  F:	include/net/fastboot_udp.h
>  F:	drivers/fastboot/
>  F:	drivers/usb/gadget/f_fastboot.c
> +F:	net/fastboot-udp-common.c
>  F:	net/fastboot_tcp.c
>  F:	net/fastboot_udp.c
> +F:	net/lwip/fastboot_udp.c
>  F:	test/dm/fastboot.c
>  
>  FPGA
> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> index ace877b6e280..f8ec1374dcce 100644
> --- a/cmd/fastboot.c
> +++ b/cmd/fastboot.c
> @@ -8,6 +8,7 @@
>   */
>  #include <command.h>
>  #include <fastboot.h>
> +#include <net/fastboot_udp.h>
>  #include <net.h>
>  #include <vsprintf.h>
>  #include <linux/printk.h>
> @@ -126,6 +127,12 @@ NXTARG:
>  		return CMD_RET_USAGE;
>  	}
>  
> +	if (IS_ENABLED(CONFIG_NET_LWIP) && IS_ENABLED(CONFIG_UDP_FUNCTION_FASTBOOT) &&

This is removed again in patch 2. Maybe do the do_fastboot_udp() change
directly here.

> +	    !strcmp(argv[1], "udp")) {
> +		fastboot_init((void *)buf_addr, buf_size);
> +		return fastboot_udp_run() ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
> +	}
> +
>  #if CONFIG_IS_ENABLED(NET_LEGACY)
>  	if (!strcmp(argv[1], "udp"))
>  		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 9a5251d4b60c..07973ba0e53c 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -28,7 +28,8 @@ config USB_FUNCTION_FASTBOOT
>  	  This enables the USB part of the fastboot gadget.
>  
>  config UDP_FUNCTION_FASTBOOT
> -	depends on NET_LEGACY
> +	depends on NET
> +	select PROT_UDP_LWIP if NET_LWIP
>  	select FASTBOOT
>  	bool "Enable fastboot protocol over UDP"
>  	help
> diff --git a/include/fastboot.h b/include/fastboot.h
> index f3aa6fcc229e..52801930d5d9 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -170,6 +170,22 @@ void fastboot_boot(void);
>   */
>  void fastboot_handle_boot(int command, bool success);
>  
> +/* Commands whose successful response ends a network Fastboot session. */
> +static inline bool fastboot_is_boot_command(int command)
> +{
> +	switch (command) {
> +	case FASTBOOT_COMMAND_BOOT:
> +	case FASTBOOT_COMMAND_CONTINUE:
> +	case FASTBOOT_COMMAND_REBOOT:
> +	case FASTBOOT_COMMAND_REBOOT_BOOTLOADER:
> +	case FASTBOOT_COMMAND_REBOOT_FASTBOOTD:
> +	case FASTBOOT_COMMAND_REBOOT_RECOVERY:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /**
>   * fastboot_handle_command() - Handle fastboot command
>   *
> diff --git a/include/net/fastboot_udp.h b/include/net/fastboot_udp.h
> index d4382c0a0e03..121b770411d3 100644
> --- a/include/net/fastboot_udp.h
> +++ b/include/net/fastboot_udp.h
> @@ -11,4 +11,11 @@
>   */
>  void fastboot_udp_start_server(void);
>  
> +#define FASTBOOT_UDP_PACKET_SIZE	1024
> +
> +void fastboot_udp_init(void);
> +int fastboot_udp_input(const u8 *packet, unsigned int len);
> +bool fastboot_udp_output(const u8 *packet, unsigned int len);
> +int fastboot_udp_run(void);

Could you add a comment for these, like the other functions in the
header? Mostly what fastboot_udp_input() returns. Same for
fastboot_is_boot_command().

Thanks,
Guillaume

-- 
Guillaume La Roque <glaroque@baylibre.com>
