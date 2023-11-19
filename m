Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9A5C2BB3F
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FB6A87505;
	Sun, 19 Nov 2023 01:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B25Cw8io";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A6686EDA; Sun, 19 Nov 2023 01:43:27 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6DDB86E95
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:43:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9dd6dc9c00cso447483366b.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354601; x=1700959401; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yQzmbS8X8/IWoZHemoC2zYpWGh5AVUPJ5SI+4ssbS9c=;
 b=B25Cw8ioR5xjzqGPmY9A+LCBZaWuYjLREFipmn5mtE8j7sApDexa1JB1Y9IM2sB2h5
 pcKJUnNdQjA96gDtnVzLDJgTS8QWLN3Ia971Gs9T2vC9z1d3P+obfI7G9PibUM+Qw1pB
 v7HNK40wYQ5t+L7Dg9OYFX7KpZmK1L0bd4GOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354601; x=1700959401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQzmbS8X8/IWoZHemoC2zYpWGh5AVUPJ5SI+4ssbS9c=;
 b=EcROlVo6Pdbm9cEiTT2rcsoxSbyMRCbWISGxzHw6SRJVlw2RDFivp5R6FxdtmBM0jg
 mb2wKVRYB/W+BNSmobIDU7dJWf9UuwYoY9htmQ5RcapkHQGkCf6hyu+NeepwTmKGtWbU
 fUB05Y2/uFw4iRCU82CSOUiQfkxWVodMXtxiY+MKcug0s6W4v54VKcFSFB3/5V3gbapL
 YSktPirOu166HI6j1E+1+1BA4AlWGFrzMQFs42itLTkXd2mDAeT0n0bDo7mhP95QiuQd
 9U3qCFqsAR2KLmedkYRaQL7xxJWuE47rT+sm3rkmX/pzh6160mTNSIBxQ+ZeC2xWs8hG
 6I1A==
X-Gm-Message-State: AOJu0Yy3bdbTzmZvSYWepNPsIGtyOLOjONdjK0wvvwvV6mLPT/TZE1mK
 OaRxNWwbOahmeYUyihJS9vrA+b5Z14wNDRYytZhIyQ==
X-Google-Smtp-Source: AGHT+IHEriU8/TcBoiCNMINpQjb0dBsh/csR+T8Lxzk8/ir9QSUMUwUmRZzcIuzUCD2IAQjNnVBxRvjrFRaooHIwj30=
X-Received: by 2002:a17:907:9546:b0:9f5:9c7c:cbbc with SMTP id
 ex6-20020a170907954600b009f59c7ccbbcmr1669570ejc.32.1700354601244; Sat, 18
 Nov 2023 16:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20231118225248.105229-1-heinrich.schuchardt@canonical.com>
 <20231118225248.105229-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231118225248.105229-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:43:05 -0700
Message-ID: <CAPnjgZ0jWeqVHvuSLnrwsawK+zrcinC4vyinOQnm9Lvp3vB0-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cmd: acpi: fix acpi list command
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

On Sat, 18 Nov 2023 at 15:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> ACPI tables may comprise either RSDT, XSDT, or both. The current code fails
> to check the presence of the RSDT table before accessing it. This leads to
> an exception if the RSDT table is not provided.
>
> The XSDT table takes precedence over the RSDT table.
>
> The return values of list_rsdt() and list_rsdp() are always zero and not
> checked. Remove the return values.
>
> Addresses in the XSDT table are 64-bit. Adjust the output accordingly.
>
> As the RSDT table has to be ignored if the XSDT command is present there is
> no need to compare the tables in a display command. Anyway the
> specification does not require that the sequence of addresses in the RSDT
> and XSDT table are the same.
>
> The FACS table header does not provide revision information. Correct the
> description of dump_hdr().
>
> Adjust the ACPI test to match the changed output format of the 'acpi list'
> command.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
>         consider map_sysmem(0, 0) != NULL on the sandbox
>         adjust signature of list_rsdt() and list_rsdp()
> v2:
>         add unit test for offset of field Entry in RSDT, XSDT
>         merge patch 2 and 3
>         remove leading zeros from address output
> ---
>  cmd/acpi.c     | 67 +++++++++++++++++++++++++++-----------------------
>  test/dm/acpi.c | 18 +++++++-------
>  2 files changed, 45 insertions(+), 40 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
