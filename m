Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF38BC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9CF788677;
	Mon, 29 Jul 2024 17:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cH8PHsOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6825188677; Mon, 29 Jul 2024 17:28:48 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61CD488863
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b79c969329so17015616d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266925; x=1722871725; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tmPFvvtuiJI8/zFH1I5nXSA0SoMETzJ5zrUcOu+fOYw=;
 b=cH8PHsOD1g9ztk3cYvG27ZcMZRaVagFCwT5xVcETrJFrYr+siHAk9/n/q0Sw/N275p
 ID70pOalPg7exi3bvXBGB94r6yC463GZcTWtKjCeBscJnmXEQiAzAzz1Z6YdSgqqs9+D
 5k91z6PtF6AAC7UdVa296ItuYhUH+aK+7Q5pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266925; x=1722871725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tmPFvvtuiJI8/zFH1I5nXSA0SoMETzJ5zrUcOu+fOYw=;
 b=qXLdMS3hLx12uwWwUdsyDEtjBKIc06XKJUGBEVEVIe3NWb7blKgw0tbdBt1LoyQOxi
 vAVoAZQmMTE5Sozc6AT3+5joSevYNVu+yyedbDAHfyyM0TI0BJrEcET4kU88j3eFOJjM
 QnDqgyRycIt8leDzyz2Dove3q59bUiBzAbwQZvMxjCLSXH01dO4rwErA4eMGxTZWsGoz
 kP3pjX7BE2G0xtb5MGE3nsEXnxErrecQjYF1Ma7rSM+YovljFzT4jcqI48WrxpT+Nj2R
 W2FFu6j6cZNBAj8mNoZOu10LZi6rmI3V9gN/jWkqZB+TTFUuZH1u3nNV2qgn4RtnU6M+
 zM5Q==
X-Gm-Message-State: AOJu0Yy/PdvmAXCY8mxCadhroxgC/3dfnXG4/ZIwv25TMtCd6N/mV1qM
 FFtX3onPIsX1YgvuXGC5qwEe+GE3TGZ1OrI001yFUNEKme9Id1OAL6uTicigSZtH1RF/dTWmsMd
 2+9Z7PqrJiOpBLyEvb6lcEQebsl1ululro+p8
X-Google-Smtp-Source: AGHT+IFh7NL15XpDozjwTykJpmpbh0HjlUBfghiYEqTO3S9WiOQPh2TsU4C+Uf9JdEaQVQULfUykDw48AS+KWG9LiiE=
X-Received: by 2002:a05:6214:4113:b0:6b7:b281:fce with SMTP id
 6a1803df08f44-6bb55a79879mr91732666d6.29.1722266925383; Mon, 29 Jul 2024
 08:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-5-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-5-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:34 -0600
Message-ID: <CAFLszTjdnQ5AuG4SFPS-GuTPtHLhQL3mXREe-0-0ocGmYWKWuA@mail.gmail.com>
Subject: Re: [PATCH 04/17] acpi: Fix typo
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com
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

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Rename ACPI tables MADR to MADT.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  include/acpi/acpi_table.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
