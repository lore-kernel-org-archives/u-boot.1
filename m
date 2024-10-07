Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFF8CFB446
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 15:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A19388D9A;
	Mon,  7 Oct 2024 17:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gtdgh/i2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EAE388D5B; Mon,  7 Oct 2024 17:24:15 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692C0888EB
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 17:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cb2aac40faso47113436d6.1
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728314651; x=1728919451; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yAKla1S5BlCcyNB8Xg5CQvs/7VwYTyPQWuig19S66zQ=;
 b=Gtdgh/i2Rx3Hpsj3u9Ok+2ncYCxY7owm4yOgQpaZbX7C+1L+hyf/Hm7Lo2a86iqcx9
 ++BrpdcSKSopPG53QhZhu++Boqx2GnE333Th3fBhh2o4h+FrVFJbopTrGGJZ7XeuRD6t
 fkUKG+RR7zuIL2wxbNllGMA+CPa22LW8DdCiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728314651; x=1728919451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yAKla1S5BlCcyNB8Xg5CQvs/7VwYTyPQWuig19S66zQ=;
 b=tuFHHT9AYbZn8ZONagV+r9hxKOf4NOUpcSyrUmeqBUs5uJXheFRXdl4dAXcwwMH+lI
 a7T2lLWCi8ZbiKFC2olEfLzLZk237VFkunTT8Bxmps7iSX74GONCX9zbDQhY2ddOFDqv
 qrYajpos4zA+GMqYvFqT6mOppiE7hpX5+kN/1TMitXGs9l4OQvGZQP7K8R3BPztyQqRh
 E4sdIvkV0ldp+zkE+tzA01De13J/+7B48v7MrMHyyPRKAuVCSbKXjOs4MTgCpwcEFfv5
 jmj3sR+6pxrimlmJu1BwesWFYr945mj06k9C56YBeMaSxDz4UYgKql0Ayfe5WHavGdOU
 vkbw==
X-Gm-Message-State: AOJu0YzKpTVPxUv2awzQocn8JLRpooaC6YKCQfCP9XrG4nUctiSPHnvn
 PhOB/j8DsKfSP1mOrz94mVyTVDxKic3NGKLERTcegh2Bc9xMFxTOSFy5h8kB92bBCvmZ3A6Cgoe
 LK02I+E42ju7iF8xuJZOL0TxtXoUCThwGHXSb
X-Google-Smtp-Source: AGHT+IGlCI0esUn6WFDrnyz6f5TWIiNrv2S90Kk90Tw+RQ6VFsD5AlU+1KetJx8I8iU87c+RhhScMhthu/Fo6TdVqjI=
X-Received: by 2002:a05:6214:5f0d:b0:6cb:8239:b8b8 with SMTP id
 6a1803df08f44-6cb9ad34f7bmr245873896d6.1.1728314651287; Mon, 07 Oct 2024
 08:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241004230756.371153-1-marex@denx.de>
In-Reply-To: <20241004230756.371153-1-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Oct 2024 09:24:00 -0600
Message-ID: <CAFLszTjfwF_WnzyScyAPw65ke=JUFj2rmnQfxqJVYF260+g+gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Makefile: Drop SPL_FIT_SOURCE support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
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

On Fri, 4 Oct 2024 at 17:08, Marek Vasut <marex@denx.de> wrote:
>
> The SPL_FIT_SOURCE is long superseded by SPL_FIT_GENERATOR which
> is long superseded by binman, drop SPL_FIT_SOURCE support as there
> are no more users.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
> NOTE: Depends on https://lore.kernel.org/u-boot/20241004225916.361000-1-marex@denx.de/
> ---
>  Makefile                |  6 ------
>  boot/Kconfig            |  8 --------
>  doc/usage/fit/howto.rst | 11 +++--------
>  3 files changed, 3 insertions(+), 22 deletions(-)
>

yay

Reviewed-by: Simon Glass <sjg@chromium.org>
