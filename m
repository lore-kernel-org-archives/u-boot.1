Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73841D13564
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 15:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC41B88EE3;
	Sun, 27 Oct 2024 16:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mY8MYzGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A7B388F0A; Sun, 27 Oct 2024 16:00:53 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D1B8897F
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 16:00:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a6acac4c3so543111366b.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730041244; x=1730646044; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gaUmX2V2pyxqefW6J1OgijChLgStA05UODras6zLaSA=;
 b=mY8MYzGtbDXuoKtjzO7su+BAHqzcNkPaNiN2YDDXwnXO4jt/cNxMN1w/7SpJVkL5vj
 PqScCvl6XEGUWTgvfPK9QwDQvIppE2Jx0DpKXo4Iu/AFlcFTp7/l3g9tOiOM0OTriQ/f
 ifMYog3KAhFf3ntswKDCaT8wkQ4zSqfjis6/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730041244; x=1730646044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gaUmX2V2pyxqefW6J1OgijChLgStA05UODras6zLaSA=;
 b=Q2wqCZ3IHGZfEPXPvDAmXIdDCCGhY24qWOeqpH60tBah+z3SU1EGZ3urS31+2x1tt6
 PaLO0MbAMvYlHlqjiRyuz9VCp6oz1MfvOjmWw3mxsxdwkppwxdSXmmMktGUOi72YAUdI
 tl3EtOrvTzkzv7WjxV4UML4DDO6Zw9tBf7SEP5w8ng8yJRb3FG9AdQLq8AsHeaSVmHKw
 cWeHj71OY7lBsQ/cSCKhV36hSuUWg/qB7l3tK6LqjF/SJNMyw36QgSN7JuSx8oi7I9n/
 gnfT7qNw2aPbcNBuQvvlBUdOs2gqWQt8XaJ9N/vsAZbpfZaLzz6sYXq2kk2+QUDTVurl
 jDWQ==
X-Gm-Message-State: AOJu0YzdZw9YWWqrKsj+Ss//f/eS+o6eKvVsbCKdIJexNfhR5ezSA//m
 Fk1J1HxGoYe5O834sS7gp6t692jmlPPpt7uphsNx6SEOmNR+F4VspWuUd50x0jeW8FPm7/SMoMz
 BfySkT0umKi2KWdYJJD8iD3YCZ44zBlDcdAlC
X-Google-Smtp-Source: AGHT+IHY+VNfRhFjVjawYGQp7C0AVu9dV3tAFLbkg6/Mq+QMgfgMdTYFis7qZDs6MUP8BBcgSHK6Qg4Mb5peiLB3W6k=
X-Received: by 2002:a17:907:3e10:b0:a9a:7f84:941d with SMTP id
 a640c23a62f3a-a9de5d659e3mr546703666b.6.1730041243776; Sun, 27 Oct 2024
 08:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-2-sughosh.ganu@linaro.org>
In-Reply-To: <20241025111411.165904-2-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 15:59:13 +0100
Message-ID: <CAFLszTgpUOpjMogv5q0EhLHe-i=VBYHtdaGyBp6as99BkbE0pg@mail.gmail.com>
Subject: Re: [PATCH 1/4] fdt: add support for adding pmem nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Fri, 25 Oct 2024 at 13:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> From: Masahisa Kojima <kojima.masahisa@socionext.com>
>
> One of the problems OS installers face, when running in EFI, is that
> the mounted ISO after calling ExitBootServices goes away. For some
> distros this is a problem since they rely on finding some core packages
> before continuing the installation. Distros have works around this --
> e.g Fedora has a special kernel command line parameter called
> inst.stage2 [0].
>
> ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> don't have anything in place for DTs. Linux and device trees have support
> for persistent memory devices. So add a function that can inject a pmem
> node in a DT, so we can use it when launhing OS installers with EFI.
>
> [0]
> https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/installation_guide/chap-anaconda-boot-options#sect-boot-options-installer
>
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  boot/fdt_support.c    | 41 +++++++++++++++++++++++++++++++++++++++--
>  include/fdt_support.h | 13 +++++++++++++
>  2 files changed, 52 insertions(+), 2 deletions(-)

Can you please use the ofnode interface for this? We are trying not to
add more of this kind of fixup, as it means someone will have to port
it over later.

See EVT_FT_FIXUP

Regards,
Simon
