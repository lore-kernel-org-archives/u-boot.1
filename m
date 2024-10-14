Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29966CFC538
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 10:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F8BD88FD8;
	Mon, 14 Oct 2024 12:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cW2A8CRM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07018904A; Mon, 14 Oct 2024 12:23:42 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A465488A4C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so3430657a12.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728901419; x=1729506219; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0cK4di1wZAUtSHMCY40YXnMRX9pj4a+aK1QJAquE/EA=;
 b=cW2A8CRMtmRSOPp5Ztx2F2f1DvEZfNIIjqmNMaUQYicZkugid+JSG9QWmFG4dB7sV2
 DnlFctvwDp2Jir99O7CVkfzDFwRY5qvUgFmLSLdogGdeKed5umMvd1EiSIbpPZwnzp2m
 a8zNWSWFC3basWnru4JYKwe4unvBih7RU2Q4XPcZ3byq3MyhZt4ywwbzWQJtlrZNrW6j
 qzxLllfkRnAbF1Q9w0TdUc1nwYilhQr7FXtHTB1V+aQgo8fCRI10ybtyyrIJSlAJM5Em
 hpS7vBB4xzMdcItTgUe6XLMn+lNRNGnd8HHLQqVhHlZfN+rDveq6n+bMjFARFNn8HCef
 7NEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728901419; x=1729506219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0cK4di1wZAUtSHMCY40YXnMRX9pj4a+aK1QJAquE/EA=;
 b=nG+x6GFeFsWXhktWUAHbwnVakhbyxvypCsFs9qgoUyIW5eIOIVVkYm31L5brdBvIWE
 q5YfGvjKH44Q+4pG2Lj0013h0KlBrFJRs77qNdUIHGZHxPlnrVXFrQ/D7L7FSa6aqySh
 xfs7d0neY956WITDUlxN529lHzwSbdqnGV3twLtJ6TsAIpZqA5hCmKsoq5Ok6fw3CtY3
 Y2JmFbGogJHH3zCPF83CeuJZ92TQ+mURlOSzbhgjNwlfoXFuIBZhyMP4o/yQJ9lLKnRp
 jlMG/wzZ70h7Ws5W/Qc6G+iMNIy1UfSW/9quZwBv2KYotyEsYmX8N8aapElJXvK48wP4
 PPOA==
X-Gm-Message-State: AOJu0YwSn5IncV1qJiwOtxC/aPND8OlMSBButVUkpq3JKVeZJtVTmkNi
 nJngMJoPvjvZdjq/LrcF+k0PuSWX+56deE1Srm+ZbFIzy90dUkcsrHtTrGb7LI8y3Rc+f2ZUDie
 XEPvj0G6wuFMW/ynT9zam4zpxWqf2DBOQO62Vmw==
X-Google-Smtp-Source: AGHT+IFWjrlaTxCGBEXJeTdBX8HsMxfBSPpaxb4ckid7DvxH5vdrmeRNYRKAiDCqN/hj+fcxI9odv0XX8IBlgt8q9pU=
X-Received: by 2002:a17:90a:1789:b0:2e2:b462:1d21 with SMTP id
 98e67ed59e1d1-2e2f0adcc73mr13450560a91.10.1728901419110; Mon, 14 Oct 2024
 03:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-1-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 14 Oct 2024 13:23:03 +0300
Message-ID: <CAC_iWj+YVGoqC8wRLxQoGTdqCTvERNnAZJ1LktKGySJM4Pnoow@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Make EFI memory allocations synchronous with LMB
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Sughosh,

On Sun, 13 Oct 2024 at 13:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
>
> This is part two of the series to have the EFI and LMB modules have a
> coherent view of memory. Part one of this goal was to change the LMB
> module to have a global and persistent memory map. Those patches have
> now been applied to the next branch.
>
> These patches are changing the EFI memory allocation API's such that
> they rely on the LMB module to allocate RAM memory. This fixes the
> current scenario where the EFI memory module has no visibility of the
> allocations/reservations made by the LMB module. One thing to note
> here is that this is limited to the RAM memory region, i.e. the
> EFI_CONVENTIONAL_MEMORY type. Any other memory type that is to be
> added to the EFI memory map, still gets handled by the EFI memory
> module.
>
>
> Some test logs to highlight the issue that is being fixed by the series.
>
> Without patch series
> --------------------
>
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
>  reserved.count = 0x3
>  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
>  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
>  reserved[2]    [0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-overwrite
>
>
> => efidebug memmap -- does not show regions allocated by lmb
>
> Missing TPMv2 device for EFI_TCG_PROTOCOL
> Type             Start            End              Attributes
> ================ ================ ================ ==========
> CONVENTIONAL     0000000040000000-000000007f751000 WB
> BOOT DATA        000000007f751000-000000007f756000 WB
> RUNTIME DATA     000000007f756000-000000007f757000 WB|RT
> BOOT DATA        000000007f757000-000000007f758000 WB
> RUNTIME DATA     000000007f758000-000000007f77a000 WB|RT
> BOOT DATA        000000007f77a000-000000007f781000 WB
> BOOT CODE        000000007f781000-00000000807b5000 WB
> RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> BOOT CODE        00000000807b6000-00000000817c0000 WB
> RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> BOOT CODE        00000000817d0000-0000000082100000 WB
> =>
>
>
> Trying to allocate EFI memory with already allocated region succeeds(should fail)
> ---------------------------------------------------------------------------------
>
> => efi_mem alloc 2000 42000000
> Address returned 0x42000000
>
> => efidebug memmap
> Type             Start            End              Attributes
> ================ ================ ================ ==========
> CONVENTIONAL     0000000040000000-0000000042000000 WB
> BOOT DATA        0000000042000000-0000000042002000 WB
> CONVENTIONAL     0000000042002000-000000007f751000 WB

Any idea what caused BOOT DATA to start from 000000007f74d000 with the
patches applied?

> BOOT DATA        000000007f751000-000000007f756000 WB
> RUNTIME DATA     000000007f756000-000000007f757000 WB|RT
> BOOT DATA        000000007f757000-000000007f758000 WB
> RUNTIME DATA     000000007f758000-000000007f77a000 WB|RT
> BOOT DATA        000000007f77a000-000000007f781000 WB
> BOOT CODE        000000007f781000-00000000807b5000 WB
> RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> BOOT CODE        00000000807b6000-00000000817c0000 WB
> RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> BOOT CODE        00000000817d0000-0000000082100000 WB
> =>
>
>
> With patch series
> -----------------
>
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
>  reserved.count = 0x4
>  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
>  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
>  reserved[2]    [0x7f77a000-0x7f77cfff], 0x00003000 bytes flags: no-notify, no-overwrite
>  reserved[3]    [0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-overwrite
>
>
> => efidebug memmap -- now shows the lmb allocated memory regions also
> Missing TPMv2 device for EFI_TCG_PROTOCOL
> Type             Start            End              Attributes
> ================ ================ ================ ==========
> CONVENTIONAL     0000000040000000-0000000042000000 WB
> BOOT DATA        0000000042000000-0000000042200000 WB
> CONVENTIONAL     0000000042200000-000000007f74d000 WB
> BOOT DATA        000000007f74d000-000000007f752000 WB
> RUNTIME DATA     000000007f752000-000000007f753000 WB|RT
> BOOT DATA        000000007f753000-000000007f754000 WB
> RUNTIME DATA     000000007f754000-000000007f776000 WB|RT
> BOOT DATA        000000007f776000-00000000807b5000 WB
> RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> BOOT DATA        00000000807b6000-00000000817c0000 WB
> RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> BOOT DATA        00000000817d0000-0000000082100000 WB
> =>
>
>
> Trying to allocate EFI memory with already allocated region fails as expected
> -----------------------------------------------------------------------------
>
> => efi_mem alloc 2000 42000000
> efi_allocate_pages failed 800000000000000e
> =>
>
> Trying to allocate EFI memory with non-allocated region succeeds
> ----------------------------------------------------------------
>
> => efi_mem alloc 2000 42200000
> Address returned 0x42200000
>
>

Thanks
/Ilias
