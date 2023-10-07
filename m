Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73361E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36AA286DAF;
	Sat,  7 Oct 2023 22:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rTNxOOiL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE528691E; Sat,  7 Oct 2023 22:19:13 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E18C986D29
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso579211466b.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696709949; x=1697314749; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8wTAz8CH5w5h3/8j8ZMIhd7yA/xHuZ/Xxhn1zhjfu28=;
 b=rTNxOOiLf0G+oFuw7Efa4SjvK4w9x5jFfgC1nC/wkLartYvj3oeq+AoTXTY6UCph8S
 MlZ1onC+CDU6Vqo7vp9JmKEW+B+jZNIQleCBQu+F7LKyFgr6gwSVP8fbC+bzmqJj9sQk
 OilCd7d2GW4jPpGegYb44PIYTJrAlC7Ht8E1v4DrNZ0MIrP7eUha5SuNrya+KMXqQylO
 MPcsQ1sz5Mv58ukuKDJayU7JIDSFm6stX8/uudHZKfpRw09jeLKRnju6x3skoqQ2M5yP
 sjTDx+05+stnlsNxR/JH7ybeux85oqm+er/nNBpI3hfwDWF5R54KjYlE1BVNOxeafpIl
 lRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696709949; x=1697314749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8wTAz8CH5w5h3/8j8ZMIhd7yA/xHuZ/Xxhn1zhjfu28=;
 b=CMCRHwPPBWqICNYinLBnLYjV2fO9N+Dr7rOCvbDIdcjc8jd9lld9j40uVfTe4tZt4V
 RGsntq6h98G1HQUMwTU8JDgPSUkOWJvonZlaOptSCxPB/ur/R/+dGBlCQui3BUerOneD
 B9FG8cZM+VkvtmPbC0RbOUwzP8p23Gpj6hQ3c1Hv1xQCHXMbko7r96GlSeeH58AdYaXY
 Wiywnrw3uHQVSr/ATJnG5MFs1psO13V+A0UQtkIVbpuOMomVWlvsxt+TdQZKTfj0Bjpo
 IMwo6nEAlqjEnCAaW8gsB05NwYQa6M9kDNW/waQhktdnnDrdRfd+lmPnWOA9q4L/+Kxj
 pl4A==
X-Gm-Message-State: AOJu0YzKmzWbqzt+K4j1YEtiooDNA+vu5sGLFGdGB6EA23xbIoP7S2rt
 jfrgdlD27nw9QJbpT3W1ZVMbLZZhad4ab+t7aeidxw==
X-Google-Smtp-Source: AGHT+IFpuV1VgeLThL/X/d36sVDC/jwXQd3m83b7Rc4G26w6wkjjLF7AuzUxK4gdHt7Kqc/+JsIqp2Ina1drLOEge6s=
X-Received: by 2002:a17:906:23f2:b0:9b2:6db8:e0fa with SMTP id
 j18-20020a17090623f200b009b26db8e0famr9756408ejg.41.1696709949292; Sat, 07
 Oct 2023 13:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231007191308.2222470-1-trini@konsulko.com>
 <20231007191308.2222470-2-trini@konsulko.com>
In-Reply-To: <20231007191308.2222470-2-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Sat, 7 Oct 2023 14:18:56 -0600
Message-ID: <CAPnjgZ0Eo_rjipnkjxcJ6SM80V+OfiR7UYYYEeCOEok1gAg1ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] cmd: Convert existing long help messages to the new
 macro
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 7 Oct 2023 at 13:13, Tom Rini <trini@konsulko.com> wrote:
>
> - Generally we just drop the #ifdef CONFIG_SYS_LONGHELP and endif lines
>   and use U_BOOT_LONGHELP to declare the same variable name as before
> - In a few places, either rename the variable to follow convention or
>   introduce the variable as it was being done inline before.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/mach-imx/cmd_nandbcb.c                      |  6 ++----
>  board/freescale/common/ngpixis.c                     |  6 ++----
>  board/work-microwave/work_92105/work_92105_display.c | 12 ++++--------
>  board/xilinx/common/fru.c                            |  7 ++-----
>  board/xilinx/versal/cmds.c                           |  7 ++-----
>  board/xilinx/zynq/cmds.c                             |  6 ++----
>  board/xilinx/zynqmp/cmds.c                           |  6 ++----
>  cmd/acpi.c                                           |  6 ++----
>  cmd/aes.c                                            |  6 ++----
>  cmd/armffa.c                                         |  4 ++--
>  cmd/axi.c                                            |  4 ++--
>  cmd/bloblist.c                                       |  6 ++----
>  cmd/bootcount.c                                      |  9 ++-------
>  cmd/bootdev.c                                        |  6 ++----
>  cmd/bootefi.c                                        |  6 ++----
>  cmd/bootflow.c                                       |  9 ++++-----
>  cmd/booti.c                                          |  6 ++----
>  cmd/bootm.c                                          |  6 ++----
>  cmd/bootmeth.c                                       |  6 ++----
>  cmd/bootz.c                                          |  6 ++----
>  cmd/cat.c                                            |  6 ++----
>  cmd/cedit.c                                          |  6 ++----
>  cmd/clk.c                                            |  6 ++----
>  cmd/conitrace.c                                      |  4 +---
>  cmd/cpu.c                                            |  7 ++-----
>  cmd/cyclic.c                                         |  4 ++--
>  cmd/dm.c                                             |  7 ++-----
>  cmd/efidebug.c                                       |  6 ++----
>  cmd/event.c                                          |  6 ++----
>  cmd/fdt.c                                            |  6 ++----
>  cmd/font.c                                           |  6 ++----
>  cmd/help.c                                           |  5 ++++-
>  cmd/i2c.c                                            |  6 ++----
>  cmd/kaslrseed.c                                      |  6 ++----
>  cmd/log.c                                            |  7 ++-----
>  cmd/mp.c                                             |  6 ++----
>  cmd/mtd.c                                            |  6 ++----
>  cmd/mtdparts.c                                       |  6 ++----
>  cmd/mux.c                                            |  4 ++--
>  cmd/nand.c                                           |  6 ++----
>  cmd/nvedit.c                                         |  6 ++----
>  cmd/osd.c                                            |  4 ++--
>  cmd/pcap.c                                           |  4 ++--
>  cmd/pci.c                                            |  6 ++----
>  cmd/pci_mps.c                                        |  6 ++----
>  cmd/riscv/sbi.c                                      |  7 ++-----
>  cmd/rng.c                                            |  6 ++----
>  cmd/sandbox/exception.c                              |  5 ++---
>  cmd/scp03.c                                          |  7 ++++---
>  cmd/sf.c                                             |  8 +++-----
>  cmd/source.c                                         |  9 ++++-----
>  cmd/ti/pd.c                                          | 10 +++++-----
>  cmd/vbe.c                                            |  6 ++----
>  cmd/wdt.c                                            |  4 ++--
>  cmd/ximg.c                                           |  6 ++----
>  cmd/xxd.c                                            |  6 ++----
>  test/cmd_ut.c                                        |  6 ++----
>  test/fuzz/cmd_fuzz.c                                 |  7 ++-----
>  58 files changed, 129 insertions(+), 230 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks for doing this
