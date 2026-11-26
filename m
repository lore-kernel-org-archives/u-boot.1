Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A808606A326
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wp6aQz6Q;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aFCRCjzT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F6088111A;
	Thu, 26 Nov 2026 10:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UasM0CbRp8Rd; Thu, 26 Nov 2026 10:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB45081111
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690573;
	b=KZVYmCqTL06GIjOSn19NecQ8Qa3dyFGinl4TZim5IRstliQ/6CKiUU5kkX2uFcZ39oIH
	 nLsEtfR8U7s6J1taVKi9K59XzmVFFfqh3Vmmv8kPHwVaWx2zJJfhc7DX2n0Q4732YJ3AY
	 J8k8QioOKu4ZsxE7UtIsXkTCagkY92Uxj2xp/zFNqwrDncB8v1NzeberqFzSw3cvOeVDY
	 VwXCtculIo/cHDwgqDfeEgq9besol4pWMen38HKl7hwuSXjowbKqwWyynnHSfMXxqNM1Z
	 GgAVp3z4u+q4dZJs9E9umgbHJjx0eM4ojxxJHwLz8yoAfSUyQPVw5dvdUzSS8wP9/aw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690573;
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
	bh=UEmGV1lVGQ+NnGNdrBjxnhdr9ZuJzpgxhesfU0EF/lk=;
	b=OcnD6wMT3Dt8IrAEgWwhekNHprcia1V/6i/snOkoKML0f0OqqDVECTo5h8zPywgCL31A
	 KjaMnPBqkknb3qlqqtiMZB+i3x3TYKmDs13BKiuJ0FtxgyTZIBBXRH31XEP20VSHaV6/W
	 cncJaxyUjvFtD11qG6Jk1cMnYXI7Slo52pCrLAvVYUYil42qny4E3XZy3w74xQ0G9wUyh
	 OkcN0yMECUirkLbYTRAWSY9std0xA4fBlOIyL41cuSDhDu9dubZaqHhPu1gMb/03HLmB+
	 vnGURrZbOCJEZBoR6T/1ENpd1RusBstktbwo5kQldgZyllDUEjWTjrHLf6UhtduikrQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690573;
	bh=UEmGV1lVGQ+NnGNdrBjxnhdr9ZuJzpgxhesfU0EF/lk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wp6aQz6Q31Vgkq8f7EsDGltkySbBtYSPKiGWaQv4eTTkbKUihy0aqfjOaQpXheo+H
	 p1WuDG7mkSgahWs2cBZix0osHrSgclevFSMAI/Vf2JrqmDBNzAEKf/bhRo0gConv97
	 4J4y2eOiU7jmWZMlHbHSbRgms756EzQTck9ZF1mWiS3Jet/JaatlhlG8CwxDfS1H9e
	 zJxDq8vphRYAx9Gj1/JSF48IdM+CZZ/kckvvxtFzfqPZmsxoYnNcAWuuvIkucyggrq
	 DbE+JXov4TgVVK6BoU/WDzg3klyUqbPs4NoV01Wzzskxlco8ctS4nsfQz+rVx5jkuK
	 zWGTRAgxjNoKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB45081111;
	Thu, 26 Nov 2026 10:56:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D8BD032D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6A2140249
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:56:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TnJCE1gcNFga for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:56:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6E67B401CD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=aFCRCjzT
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E67B401CD
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:56:07 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso68582635e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 02:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795690565; x=1796295365;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UEmGV1lVGQ+NnGNdrBjxnhdr9ZuJzpgxhesfU0EF/lk=;
 b=aFCRCjzT2TqMushBTG8qqoYXfR1ADXdoH6MgJNimXyVnIPrnNq+jQ043h4ADtL3DwP
 eKWYMzK+zZqFWawkDQKf3DROUUSxCHCW1CQUxQ1l8nJ6Zj+tM4DaH3LaYn6TA0piltKL
 BR0KjH8XuFaIfLh/qO1AuRBnXUkzbSwJql+6LZW+M4j+LUfSUHjE+jyM+FHZ/kyDXwTy
 RfIsWtLuPbsYIngbdXeLEdR6MqNh6d9zX3JQD6SqIP1Ph9LVcOMXtz1t7s0avHT+znbo
 Jo6zaU+E7M2lvJIyikeyU76/gcfBsax5u3tO+mFFGjH4qcESIrFh+t8i/WQIwIiANPf+
 ZOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795690565; x=1796295365;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UEmGV1lVGQ+NnGNdrBjxnhdr9ZuJzpgxhesfU0EF/lk=;
 b=y8o9ahkRwHX07OOQzEb2Ypfth9rTsr/icd8xI8+nZgv2FmJYpHE2KB0Epx7Kqi0Rau
 cGdqvJQOVejZLhrlY3ODylRyRn8jywdIHu5Z9GPP7q8Bb3aWBs0AQlEBMcZs+bFw9BTE
 4O73R6QkraKnysrdbuc0B6MmNSr4TajONxCqNX3kkV6o7fyVZlaE5gUT0zWjMFG2Lj2U
 AmpEUpsUJ4/DrGoQanbSPULELmjx0M1YRvyiKnm870RWBy4eekPwNAysGkxGPCts8gkt
 EwrsQqoU/4nty722PtcMyyAGCTPqGh4Cv0ywdi9XISOiXJ+UVeaZVtuxhY8xdRCURP72
 DQew==
X-Forwarded-Encrypted: i=1;
 AL+hErE9tn6GaRzExl3StuLSdFMf8Olcm0uLTEmqscwm1wifiWtewqlmCxB/bLB7EW9l5AZUcpSpFB4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+yoa04/1kPWRl/legpZ3IJMKjz2D6hoKUicS5j7GbKVrYlzvrG
 e9E3Meg996SenshRM7JXLE3apvIYWQxstCJEaQoa2JpWZjj+gfp4xbivjbFe+f2D/ug=
X-Gm-Gg: AZFdTZcq8F23LVegxtKFIQnxc5GJ6uUVq6tEoQIOpgAU2fygN9MAduhvkgEHi0e3Jlw
 ATNJvxDJAWKBHXn4EsHbCaS/aE1yNyyAspmakd+yqV92tcPWQJNJt5vJABZFzCR1PInASz+LHat
 aorkCTJq9/uBkZ1tToJYQ3/fyvyXA0Xjw6GCPmvrLycfJ8OjutKejPnKdhgS7FgZPomo+cyeuIq
 Qi1jqdKTbfeqJkAOgLpxptG3DQKy/H+LNjFpk6Lx5lb1wcOniFn76N8QUCRpJZQMNJDYc0oqJ2N
 zC+Aic+Fo2XLu7AcOiqV6VbEPM798+ccMzbg44kmEt2PpcSrkHK74XwdufyP+/pmtID6pqgTkYU
 a5cB1OiaebtgZMwhmKEkpFlxVA+TyeaAW/TgsBUS32w3zBlIpfj6RocjJoFmvyNe23Ov9atK88S
 YjIeM/kKwlZ0lJyar3BOUFG7OW45dgEmIV77E+amA0r83nUpwoCgzb1DpQBIQcaJnfdumFLlWgo
 vOMK+x+o4d0CZ+vl/CAnA1488BmurB/tihRaE1QIDQH36RQCKk5xbeeiN9UlGxlVuqktpdqrQbe
 rnc15/+mLUiRMP4pg2ZYOmUV/+87e4PjOnxvJ0LN0cDPwyp1y8HjkU5Ae24mer/WhMaIF/kM
X-Received: by 2002:a05:600c:4f81:b0:4bb:5e8c:13bc with SMTP id
 5b1f17b1804b1-4bb88805902mr397082165e9.7.1795690565172; 
 Thu, 26 Nov 2026 02:56:05 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9066f6e6sm278313125e9.3.2026.11.26.02.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 02:56:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] net: lwip: serve Fastboot over TCP
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
In-Reply-To: <20261123-submit-lwip-fastboot-v1-v1-2-34c1eff8b1f0@gmail.com>
References: <20261123-submit-lwip-fastboot-v1-v1-0-34c1eff8b1f0@gmail.com>
 <20261123-submit-lwip-fastboot-v1-v1-2-34c1eff8b1f0@gmail.com>
Date: Thu, 26 Nov 2026 11:56:01 +0100
Message-Id: <179569056100.2037761.3416251367835999900.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795690563; l=7466;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=cO57RDpiobFdPTZSyscwwVPxwMshEmBJcpxsgLpVT9g=;
 b=wewiIoPtljWzINnOuh81/5ZeIIJBTHX6OxB1sEGvdNjCkKoaM0+WLvHACaJxgmm6t8zrk9dAz
 6m9etdbro3sAXe2eJtm8wz9NtZ793cj2a8VNoMHcP5hzbJbMj0MudA3
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi James,

> Implement the Fastboot version handshake and length-prefixed command
> and data stream using the existing Fastboot handlers. Parse the stream
> incrementally: a segment may contain part of a header or data frame,
> or more than one frame. Copy download data to the Fastboot buffer as
> it arrives rather than allocating the advertised frame size.
> 
> Bind the listener to the selected interface. Wait for acknowledgment
> of the final response and release the listener before continuing boot
> or resetting the board. Document how to select TCP on the host and
> target, and select the TCP implementation required by each stack.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  MAINTAINERS                |   1 +
>  cmd/fastboot.c             |  31 ++---
>  doc/android/fastboot.rst   |   4 +
>  drivers/fastboot/Kconfig   |   4 +-
>  include/net/fastboot_tcp.h |   1 +
>  net/lwip/Makefile          |   1 +
>  net/lwip/fastboot_tcp.c    | 302 +++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 322 insertions(+), 22 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2400daab7bc6..d878749efd57 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1051,6 +1051,7 @@ F:	drivers/usb/gadget/f_fastboot.c
>  F:	net/fastboot-udp-common.c
>  F:	net/fastboot_tcp.c
>  F:	net/fastboot_udp.c
> +F:	net/lwip/fastboot_tcp.c
>  F:	net/lwip/fastboot_udp.c
>  F:	test/dm/fastboot.c
>  
> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> index f8ec1374dcce..e6e05111ddf0 100644
> --- a/cmd/fastboot.c
> +++ b/cmd/fastboot.c
> @@ -8,15 +8,14 @@
>   */
>  #include <command.h>
>  #include <fastboot.h>
> -#include <net/fastboot_udp.h>
>  #include <net.h>
> +#include <net/fastboot_tcp.h>
> +#include <net/fastboot_udp.h>
>  #include <vsprintf.h>
>  #include <linux/printk.h>
>  #include <linux/stringify.h>
>  
> -#if CONFIG_IS_ENABLED(NET_LEGACY)
> -static int do_fastboot_udp(int argc, char *const argv[],
> -			   uintptr_t buf_addr, size_t buf_size)
> +static int do_fastboot_udp(uintptr_t buf_addr, size_t buf_size)
>  {
>  	int err;
>  
> @@ -26,7 +25,7 @@ static int do_fastboot_udp(int argc, char *const argv[],
>  	}
>  
>  	fastboot_init((void *)buf_addr, buf_size);
> -	err = net_loop(FASTBOOT_UDP);
> +	err = CONFIG_IS_ENABLED(NET_LEGACY, (net_loop(FASTBOOT_UDP)), (fastboot_udp_run()));
>  
>  	if (err < 0) {
>  		printf("fastboot udp error: %d\n", err);
> @@ -36,8 +35,7 @@ static int do_fastboot_udp(int argc, char *const argv[],
>  	return CMD_RET_SUCCESS;
>  }
>  
> -static int do_fastboot_tcp(int argc, char *const argv[],
> -			   uintptr_t buf_addr, size_t buf_size)
> +static int do_fastboot_tcp(uintptr_t buf_addr, size_t buf_size)
>  {
>  	int err;
>  
> @@ -47,7 +45,7 @@ static int do_fastboot_tcp(int argc, char *const argv[],
>  	}
>  
>  	fastboot_init((void *)buf_addr, buf_size);
> -	err = net_loop(FASTBOOT_TCP);
> +	err = CONFIG_IS_ENABLED(NET_LEGACY, (net_loop(FASTBOOT_TCP)), (fastboot_tcp_run()));
>  
>  	if (err < 0) {
>  		printf("fastboot tcp error: %d\n", err);
> @@ -56,7 +54,6 @@ static int do_fastboot_tcp(int argc, char *const argv[],
>  
>  	return CMD_RET_SUCCESS;
>  }
> -#endif
>  
>  static int do_fastboot_usb(int argc, char *const argv[],
>  			   uintptr_t buf_addr, size_t buf_size)
> @@ -127,18 +124,10 @@ NXTARG:
>  		return CMD_RET_USAGE;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_NET_LWIP) && IS_ENABLED(CONFIG_UDP_FUNCTION_FASTBOOT) &&
> -	    !strcmp(argv[1], "udp")) {
> -		fastboot_init((void *)buf_addr, buf_size);
> -		return fastboot_udp_run() ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
> -	}
> -
> -#if CONFIG_IS_ENABLED(NET_LEGACY)
>  	if (!strcmp(argv[1], "udp"))
> -		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
> +		return do_fastboot_udp(buf_addr, buf_size);
>  	if (!strcmp(argv[1], "tcp"))
> -		return do_fastboot_tcp(argc, argv, buf_addr, buf_size);
> -#endif
> +		return do_fastboot_tcp(buf_addr, buf_size);
>  	if (!strcmp(argv[1], "usb")) {
>  		argv++;
>  		argc--;
> @@ -149,8 +138,8 @@ NXTARG:
>  
>  U_BOOT_CMD(
>  	fastboot, CONFIG_SYS_MAXARGS, 1, do_fastboot,
> -	"run as a fastboot usb or udp device",
> -	"[-l addr] [-s size] usb <controller> | udp\n"
> +	"run as a fastboot USB, UDP or TCP device",
> +	"[-l addr] [-s size] usb <controller> | udp | tcp\n"
>  	"\taddr - address of buffer used during data transfers ("
>  	__stringify(CONFIG_FASTBOOT_BUF_ADDR) ")\n"
>  	"\tsize - size of buffer used during data transfers ("
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 8e15f287f9b4..5c8d5e3f4733 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -248,6 +248,10 @@ or UDP::
>     Using ethernet@4a100000 device
>     Listening for fastboot command on 192.168.0.102
>  
> +For TCP, use ``fastboot tcp``. On the host, select the device with
> +``fastboot -s udp:192.168.0.102`` or ``fastboot -s tcp:192.168.0.102``
> +before the desired command.
> +
>  On the client side you can fetch the bootloader version for instance::
>  
>     $ fastboot getvar version-bootloader
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 07973ba0e53c..ecb2774f6289 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -43,7 +43,9 @@ config UDP_FUNCTION_FASTBOOT_PORT
>  	  The fastboot protocol requires a UDP port number.
>  
>  config TCP_FUNCTION_FASTBOOT
> -	depends on NET_LEGACY
> +	depends on NET
> +	select PROT_TCP if NET_LEGACY
> +	select PROT_TCP_LWIP if NET_LWIP
>  	select FASTBOOT
>  	bool "Enable fastboot protocol over TCP"
>  	help
> diff --git a/include/net/fastboot_tcp.h b/include/net/fastboot_tcp.h
> index 6cf29d52e934..b070f2f8dc71 100644
> --- a/include/net/fastboot_tcp.h
> +++ b/include/net/fastboot_tcp.h
> @@ -10,5 +10,6 @@
>   * Wait for incoming tcp fastboot comands.
>   */
>  void fastboot_tcp_start_server(void);
> +int fastboot_tcp_run(void);

Could you add a comment for this one, like for
fastboot_tcp_start_server()?

>  
>  #endif /* __NET_FASTBOOT_TCP_H__ */
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 8d4074b8b239..bfafcc7cc04a 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
>  obj-$(CONFIG_WGET) += wget.o
>  obj-$(CONFIG_CMD_WOL) += wol.o
>  obj-$(CONFIG_UDP_FUNCTION_FASTBOOT) += fastboot_udp.o
> +obj-$(CONFIG_TCP_FUNCTION_FASTBOOT) += fastboot_tcp.o
>  
>  ifeq (y,$(CONFIG_WGET_BUILTIN_CACERT))
>  $(obj)/builtin_cacert.c: $(CONFIG_WGET_BUILTIN_CACERT_PATH:"%"=%) FORCE
> diff --git a/net/lwip/fastboot_tcp.c b/net/lwip/fastboot_tcp.c
> new file mode 100644
> index 000000000000..fff996eb0bcf
> --- /dev/null
> +++ b/net/lwip/fastboot_tcp.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +
> +#include <console.h>
> +#include <fastboot.h>
> +#include <net.h>
> +#include <asm/unaligned.h>
> +#include <net/fastboot_tcp.h>
> +#include <linux/ctype.h>
> +#include <lwip/tcp.h>
> +
> +#define FASTBOOT_TCP_PORT	5554

Same define in net/fastboot_tcp.c, maybe move it to
include/net/fastboot_tcp.h.

Also, there are a lot of sandbox lwIP tests now, would it be possible
to add one for the UDP and TCP fastboot paths?

Thanks,
Guillaume

-- 
Guillaume La Roque <glaroque@baylibre.com>
