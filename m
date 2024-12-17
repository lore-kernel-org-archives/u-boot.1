Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736E3E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1591280316;
	Tue, 17 Dec 2024 20:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="INLT/LPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5238D80304; Tue, 17 Dec 2024 20:47:12 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5485F80107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa66e4d1d5aso917974966b.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464830; x=1735069630; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uqxEAeSBuVGrO2KP+I+pemqyU/Ljg8ZdJb7XfbyWxQM=;
 b=INLT/LPcCshk7KzTIwELwmANw66KO5IuD9mJjNEYAWPrrtkyoR4DK5uXjJXTDOaHJY
 21d9fn2gtO4kuQpbq8TsAsYdwlMpaYh1lTAXVswuDIsuk1VLDnUUQ6Em1dXH45vlVYaG
 nPKvqyMCLgaRxvtkp/EXd7nFXk8I0xSbUnARs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464830; x=1735069630;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uqxEAeSBuVGrO2KP+I+pemqyU/Ljg8ZdJb7XfbyWxQM=;
 b=P3jyywaLeryNE8mQGiak0PYen0ipXf/dhL6DY8+ms45hbDD0QUk4c2RBW21VMUoXQ6
 C8zSrX1Fc+RlpXsncwi2TWeAix8AyNsy1MQfohsAjjoekUvz164LaA0kqNnt9OXIUalN
 VU7hXB0VAbQ/mG1/qbo4FMUjQY6QoHQ1XQkSQIhL/d64YhU+zaAd2O6iLoJtCCorltAl
 43KMu2kCkCFFBnVRNsdjwqyZkh8wJV8IlYNHhD6FEmW/bV+BJo03LtSwHb41o6LvQFH+
 FFue822CwJ3nhSvFSP11v+iKE3Mxq/xgmUUHy1VKWGd1mcGIFqRV8KpmyfFDzXftP3t1
 agWg==
X-Gm-Message-State: AOJu0Yz5TvvF7txN1pjCBt25miisvNJUTv5pUkqsdSTgRX9XxSzS4Bjh
 PAmRDrVtamndRPbsXBOlpo7iaSErxWFkNUL1Uo80pKYOC+wPR6QAQPsmXQp3NcftS03Eb7xluN/
 9m4Ukq/7WF0NU5xm01HnGeb21vfYrklBE9lag
X-Gm-Gg: ASbGncvNllHWulwtTIXBouMnLyvlh7HB3Xmo5a5zJEn+M0dMs2jBuBhCcGdxfSZuB8b
 9hRm1cRqtsKO7zSOOD1FGDAr3lfUOPBTjldoxpcA=
X-Google-Smtp-Source: AGHT+IET1h0ozwnjO/x7UdGGow3elarcud3VoL6Ie/15dJenqcyxyE/D7yqBWMmihm+Tqz/zZPQUpAaWT8c3yIBgDCU=
X-Received: by 2002:a17:907:1c18:b0:aa6:668b:2733 with SMTP id
 a640c23a62f3a-aab779b04d5mr1656580166b.33.1734464829815; Tue, 17 Dec 2024
 11:47:09 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:07 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWjJokyp4Rd_hMAY1+VY823zuAZRWUAVJVVJndbwWfLGYgQ@mail.gmail.com>
References: <CAC_iWjJokyp4Rd_hMAY1+VY823zuAZRWUAVJVVJndbwWfLGYgQ@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-22-sjg@chromium.org>
Date: Tue, 17 Dec 2024 11:47:07 -0800
X-Google-Sender-Auth: G2-xZEHQshslj6vM1uro0s0aIW8
Message-ID: <CAFLszTjH5xokH+SVPuSpZTwvdZKPL8hhc4jx9_m=zdGf-pxRtQ@mail.gmail.com>
Subject: Re: [PATCH v5 21/23] efi_loader: Drop comments about incorrect
 addresses
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Wed, 11 Dec 2024 at 15:55, Simon Glass <sjg@chromium.org> wrote:
>
> Now that these problems have been resolved, drop the comments.

Please drop this along with the patch that added it

Thanks
/Ilias
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_acpi.c    | 2 --
>  lib/efi_loader/efi_bootmgr.c | 3 ---
>  lib/efi_loader/efi_smbios.c  | 6 +-----
>  3 files changed, 1 insertion(+), 10 deletions(-)
>
Applied to sjg/master, thanks!
