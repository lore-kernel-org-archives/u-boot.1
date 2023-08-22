Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BC0EE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D418864DC;
	Tue, 22 Aug 2023 20:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oYK2Yc0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EBB285CB5; Tue, 22 Aug 2023 20:57:55 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D1E864B1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d7766072ba4so2416103276.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692730671; x=1693335471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ynfKecJ8P5p6m/IF4zIEh78CK+6rS31V6TlOabzw64A=;
 b=oYK2Yc0U6y3nndp7SFOD6csp2rilEnnbr4SYUjsd6pu0JwGFBML1DGVGZYKzdbp0ff
 g/6qe0vFVdNwiuK6+ujKq6cglxAljd1GjkCWitSFMRffRHH6imXikvsbHsbUgftfW08P
 7p+R9WN5iKQ2W+mGrRZGhZuHkbs7hulwYyJSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730671; x=1693335471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ynfKecJ8P5p6m/IF4zIEh78CK+6rS31V6TlOabzw64A=;
 b=CMCgLzD6qAQVGJyg3fEOdgUedHKGS8GvmbDoq0Wi2JqzQbJDflTQ09CfohO2BXuYoS
 UD2hzKGGWIWb7fxpVMpeNDv1oJn5DMgbA0mcjCRppPa2lrYqDXsWPz+S5akstSVRHXGI
 ahBzQkcYLHR4ACGGuQojE4KVMy6tX0jfavs7utS8+qdX4p8jHH+TsJH8ls6It/xSTHyk
 YNuYyr629+AIUpg36PrFUvLkX2sx/7+suTfemCnyIFxpE58Aek0q/EiLl3Hf6soWbRCI
 B/eYJ6SsZYQ753BCf6wsx5oh2/TfqCscMgeqozsXYkR6O9uEgGn0bqXgJfjd/iv869W8
 gS+Q==
X-Gm-Message-State: AOJu0Yx3gD7hIk2sRddPWe4iQhUOIxmJ9sWFYvI9tqcII4vrFkgUGur0
 CVZ/fyvZIOafplm4NE253zmP1qi6WV3pxEf2+OCNiA==
X-Google-Smtp-Source: AGHT+IFobhIwpifJVukKwKCgCKVwoxmBjoTTBL8WaQUmPzOtgjvWHVg5MOUqYbFFF2FJ2/Qb3YflJw4WYL6hKbkqUX8=
X-Received: by 2002:a25:dc06:0:b0:d71:8786:625d with SMTP id
 y6-20020a25dc06000000b00d718786625dmr10484288ybe.1.1692730670833; Tue, 22 Aug
 2023 11:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-7-alpernebiyasak@gmail.com>
In-Reply-To: <20230822121026.1007105-7-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 12:56:37 -0600
Message-ID: <CAPnjgZ3V6yYZpZu7b1XHZPTw3Bdm=12b1CL75_2gkFJJYTUHRw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] riscv: qemu: Enable ramfb by default
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Asherah Connor <ashe@kivikakk.ee>, Alexander Graf <agraf@csgraf.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

Hi Alper,

On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> From: Alexander Graf <agraf@csgraf.de>
>
> Now that we have everything in place to support ramfb, let's wire it up
> by default in the RISC-V QEMU targets. That way, you can easily use a
> graphical console by just passing -device ramfb to the QEMU command line.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> [Alper: Rebase on bochs changes, add pre-reloc init and error handling]
> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v2:
> - Drop imply VIDEO, env changes from RISC-V patch (in u-boot/next)
> - Drop imply SYS_CONSOLE_IS_IN_ENV from RISC-V patch (def. y if VIDEO)
> - Probe QFW in RISC-V QEMU board_early_init_f to bind ramfb pre-reloc
> - Add IS_ENABLED(CONFIG_QFW) check and error handling to RISC-V QEMU
>
>  board/emulation/qemu-riscv/Kconfig      |  5 +++
>  board/emulation/qemu-riscv/qemu-riscv.c | 41 +++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)

Again, please investigate DT mechanism which will work for all archs.

Regards,
Simon
