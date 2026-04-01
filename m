Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B021107639C
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 19:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF0F83CE3;
	Wed,  1 Apr 2026 21:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IMjmVixp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CA2083D8A; Wed,  1 Apr 2026 21:19:38 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3031880517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 21:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9c11eba219so9109166b.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 12:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775071175; cv=none;
 d=google.com; s=arc-20240605;
 b=YBXBjnO/LAvyCqhi2muJG+QPVfZB9gPeOmzHzrtegT/EAQP6j0P3tv7ZRE4W8Yb8MF
 2Bu8i9lOhN5QfK6JILr96g2th9E6S9ClcAsBkfSUq7hCCBJKMgCVGReBvAIB/rU+CqyB
 lGC7Z7foOV2NMIKcYkcQAoK8L/monMG8+HGHBaH2o6aMzJTrJEhC6tCawsagEUXXJu2j
 g0+QeUUWqci4MyKdTS44CwDjB3YL5Fiu2DHc31Gl8rsOUVrPJt3Rw7HkRcIPt8JHnJuB
 Ly1LHjtow0xu+Cr+GJReUi4Z+FZh4wRnzEBEP/2kFWDQrpZtFsbLOrxCRUdPXRcauG2x
 ZEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fwNiQBIuvE05liWrPHAFDOzv0cBNmlhC7KFw224FOfc=;
 fh=S6aAc6Y/78Pc56EFkSQI9QWijYd6YKhsEqjMFeRofxE=;
 b=KZCJifxzIrPKn/Deqzyheviiv0vLCad2dnltou9c7vWf3PE5fyI5GRzHGkIlVxgbEg
 tz1QfEBPzCl3mtAerOYBFV9VloCf0J1vHCL0OYJzVaIhRXf96zdPxhK6MVs5wJeOue4D
 wLIWGnH7OFtFq+rVuaOh/PMxCLr1sWrJkVhHPhkdxg+5OvFGW3TNy/N2050pnp1sQdk/
 bYh01c7a2U5VAf7vvszwIuRbVYFWfdHN1C8tr682+YjJCD3SFYHbYhdXPsQP3saVLJzs
 JFYJepducY2X8OxFmC1xNl96PYv03mc0fpK8KMlQ3/YU35FIS4+M7xth5fRH6pIMU8vT
 0sVg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775071175; x=1775675975; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fwNiQBIuvE05liWrPHAFDOzv0cBNmlhC7KFw224FOfc=;
 b=IMjmVixpHPSzXbWt+LJMZOeGfnThY6kBxNam2p0jTaLNGDV688wXCHTd3DslXu1iKR
 CWaWJ5fuiAXA0I8XdvxSlyb7y7MUI9chAGMy6MD7lVEO+kiJ06BoXhmFWUOLZHOTglxK
 R55RMPNyzD75Eqx6G7OiDDisSU6PzTv9nMX5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071175; x=1775675975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwNiQBIuvE05liWrPHAFDOzv0cBNmlhC7KFw224FOfc=;
 b=Y4VZb9CNi+p/+dkuf5WaVvaEi8RC2YvwtpfnE3M7uEILsoHB1awMDfX60xcmEPj+FV
 R/d5/hF2qx3vituhj4VMPFBAMIVjc8185a6jg5NgiMWYa0Bb6vl6ThrWBge93axkN4A0
 ZHkhxCGYVrWKeaGAcvhrvUMHoYBc8tK5mBQTVU/97NprvMCH6eFEaYI9LHhR+KEi2IAN
 ZTD03bzGF71BBDfZcG8OxdPvI2yfYSUIXIPaCvyrrD604y3C1NECWKv7TfKAtH8wvH2l
 1S9L6wS7/L1bL5vZn6ripplkjgJiY2RS/C8If1Vqe9WKxPNqLwJWBdP/4v1p8lU/hThI
 cmtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl/I9RQMTS5QAMwlypHXebe1s0NxJteCQZzJ3z7REcU3kgE14/H2bwKLCZokVVfQBSTQ7XCHk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8kcvohFeLR4z7vAQ1Gb3AQ0hvfR/c5/HNbfmgv8kwrSBFQgeX
 9bWX+xudKKqWa9Kod2htZJFbaHWYZICbPUK91TI+fzhzh7vbTsfdPXIh9RC9I/BjJcc2EHakP6Z
 JOIw04Gq5ChVBxUPB/q6rK/KycJZN10fIS+iS0vV4
X-Gm-Gg: ATEYQzyjdSyyiPsUYUxMR3RpRZbSDcrQvmQqMLTbqqwPksPL4XtRC01FSUkXvzwdEJx
 K7zGOQBis2C1l8shlU62S84wBltvWxU14vyaveujtJt/vnt+qss+p55jlOg8Tsg436J4m7grQv4
 S9fMm4O2c8Ffk5cumjsqpDrJqlWd1sf3rZcbnNMnHEzpijPTXU4e25Q1CIndz/o6eahtSdvd/3h
 xcRyJyVAsi5jPVVzfyndNQJpIZtjIXUUWy6MchZ5Ed5RBmZLjNphBRtWpbm9z04BXZNQE9LZPTz
 5ZCl78uiNaw/957+8iaxdi48uWjKPKP0L+mWFzeE
X-Received: by 2002:a17:907:b9da:b0:b98:6c41:a798 with SMTP id
 a640c23a62f3a-b9c1390fe21mr258679566b.20.1775071175480; Wed, 01 Apr 2026
 12:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20260331080117.2370092-2-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 15:19:21 -0400
X-Gm-Features: AQROBzC36BADsXcX1wJGq0cwQK6JRQzZvANdI34EBQ1W1H4I2UTmDornrin3BPA
Message-ID: <CAFLszThSLK8aQKesRenfaPhkBAb0DKPaRV1et_3Ng51g-Bfoug@mail.gmail.com>
Subject: Re: [v2,1/4] fdtdec: Deduplicate iterator function
To: ilias.apalodimas@linaro.org
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
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

On 2026-03-31T08:01:10, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> fdtdec: Deduplicate iterator function
>
> Both fdtdec_setup_memory_banksize() and fdtdec_setup_mem_size_base_lowest()
> implement the exact same iterator over all memory banks, the only difference
> is the body that is executed for each bank. Deduplicate the functionality
> into iterator function fdtdec_setup_mem_for_each_bank(), which takes a
> function pointer to a function which implements the body as a parameter.
> No functional change.
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
>
> lib/fdtdec.c | 77 +++++++++++++++++++++++-------------------------------------
>  1 file changed, 30 insertions(+), 47 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
