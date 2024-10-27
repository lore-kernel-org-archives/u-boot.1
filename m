Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABA1D13564
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 14:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7119F88EFB;
	Sun, 27 Oct 2024 15:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UCJTZQhl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F072B88F6C; Sun, 27 Oct 2024 15:48:43 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6FA788EE4
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 15:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so503648566b.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730040518; x=1730645318; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1M0yNPIEjVfZEprdWMNGapZmUVxBxTgZRCj94QPTn0k=;
 b=UCJTZQhleQpflEhG5qi8bXM9JE7tlsjekxswTocFHypfCvbwPWayp5VP+7LNe1WGeX
 48APrazGNaygwZ3wFS1Fmv0plWMjTD7XP2Nn6JHIQKHUvNMTwdWOxlg9pFDVT6pNLoF6
 K7IaS2wiKlpF/n5bGLBvTNRsQot0dPUYu3Jvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730040518; x=1730645318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1M0yNPIEjVfZEprdWMNGapZmUVxBxTgZRCj94QPTn0k=;
 b=gEjneFyCUlwOFzyyT3ZHPXLnJ7VZT71rKVbHfWptF5aqcjJm9u+BrttLXnEXL/Lidc
 gGQg8XMRYZO8MqQ54f4wotSgu2kXkX15s8mpugIJnnX5vMcWkJvBA8Wfk7OCwPmHxrh8
 JYaSpsZDADSaQaZ8Il3O87FYP2UIuQ9ClefxBURAlWmGctRTi8zLPGnqD66oJjhG5Ibi
 srDeds18sCSO7JaAaxCcTyuF/WOnTCrN+fdGvu4OUpWInwzm6/jgs+OAD2lRd9OZ326G
 YMSgmp7b3XjJeKVq4w0mLC2QrnE5XCfl9T6zUi3NO2NyFTWW5rISMTbqWTJUcwEjqrTJ
 GEvA==
X-Gm-Message-State: AOJu0Yxan0WDxqBvdcF3cFMCb5I0HUzq5RALCwrJTgGPxZaFr+Avnz8/
 1H64ys1OhAPirj81PRHF+C8z2UcwZUO7LyHhhMQ9Bu+oRVnrfjAxCDcsNZWXPpEhjYFWUUe0wJO
 /jl0Z+Od7r19CJ1JBnAM78eMY6zv0OIn/nyUS
X-Google-Smtp-Source: AGHT+IGIcyVQPJvYtkpSqsiFm33aqyqnFVhczm2U19uOY4tk2deRHdjULfvSodC49bdbseDes42pPVw1bqfNiPzr2+Q=
X-Received: by 2002:a17:907:2d86:b0:a99:5f16:3539 with SMTP id
 a640c23a62f3a-a9de5a41c9cmr418302166b.0.1730040518014; Sun, 27 Oct 2024
 07:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241026155220.26300-1-l.rubusch@gmail.com>
 <20241026155220.26300-12-l.rubusch@gmail.com>
In-Reply-To: <20241026155220.26300-12-l.rubusch@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 15:48:19 +0100
Message-ID: <CAFLszTgWndJu3H=byHS9Lu-ywFcu_4Gh+-CNwmrp_E=WufxR4Q@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] doc: develop: orthographic delights
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de, 
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com, 
 sumit.garg@linaro.org, xypron.glpk@gmx.de, michal.simek@amd.com, 
 jit.loon.lim@intel.com, barnas@google.com
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

Hi Lothar

On Sat, 26 Oct 2024 at 17:52, Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> Fix some typos and duplicate words in documentation files.
>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  doc/develop/gdb.rst      |  2 +-
>  tools/binman/binman.rst  |  4 ++--
>  tools/binman/entries.rst | 22 +++++++++++-----------
>  3 files changed, 14 insertions(+), 14 deletions(-)

Thank you for doing this.

For binman, could you send as a separate patch? Also, the
'entries.rst' file is actually generated automatically from the
different entry files. So you should fix those files and then
regenerate the entries.rst file per [1]

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/package/binman.html#entry-documentation
