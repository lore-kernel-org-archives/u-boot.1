Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C43C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20356887C0;
	Fri, 26 Jul 2024 14:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bVvQ3/27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC8288718; Fri, 26 Jul 2024 14:59:24 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F1C87C7E
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5d5af8a4abbso632246eaf.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998761; x=1722603561; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oZVQD3/MvZUrwmUIK5a5y06s52tx6uyBNAkMBOwmAR4=;
 b=bVvQ3/2731ZUG/HUK1aQpACy5hE8ZqvjPIytqUi8ktbJkvJYsUz1RaQWw6yPl9vrBA
 YBSDecYuzUnEeyCXATpzzZxraIeSFghgNNDi9l2XA7ZOi330APlLONqbMUK3UgXDMmVn
 HYpl5VG86axmsd5kDQn8CVkftpe4WgRRzSke0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998761; x=1722603561;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oZVQD3/MvZUrwmUIK5a5y06s52tx6uyBNAkMBOwmAR4=;
 b=bT9rsaMHagcGsRQ/Q6VT4UioBezOv9NiZQp4y187t002tPBHncda4Dt+P4aMHSm5cN
 OgZEndRkPNLv0KbWq03Q960k1SmYMa+zp/dw4G3ep+F2EcEfO66fP1rPpivcjX5Ht3Rz
 mMe8dL+z38pnQsifsJcdhrEg15r2+wV6E4OfCfRw5P3v9gl7WtghAlH2aweS2x7qHCEW
 dyFVWr9kigzstfZ73Yzjx9CIVL7Z3MLAeYluDJ/Na+or5pl2GDKq20oe8dhjgLlKEzpg
 yXZu2h3s6ILOVQIRcVoTDgyGyzNaMq3K9PjVCcTro5ZCz9B9KUj2EqNNSAlSlJkX4aWS
 Jtsw==
X-Gm-Message-State: AOJu0Yw60gjOCPf7ooUxkcG/2L1aVkQuEg15DLDu9Zu1I0Svxeti8ORs
 +BTeEOl18Ycq1576CpXz6q9nHUxnjjcafQInt062h47wbDQl6IzDdGrqf//2OfeFEz+uNV6du6m
 HbAvX+8pILm1PwzADwAjTSE8MuUz3/pPdFCNp
X-Google-Smtp-Source: AGHT+IFfUaUUsPsLsx050zE3O8+kFppCimoLIggobcLqt0HJLyXDb62Uy6YowyOnLh8gcax791jdnFYz8ZPlcl8BWQo=
X-Received: by 2002:a05:6358:988a:b0:1a1:fe6f:a2f3 with SMTP id
 e5c5f4694b2df-1acfb88bc64mr708652455d.1.1721998761315; Fri, 26 Jul 2024
 05:59:21 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:19 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240711144608.GA1149069@oliver.lan>
References: <20240711144608.GA1149069@oliver.lan>
 <20240711081004.304917-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:19 -0700
X-Google-Sender-Auth: 8uS9VCIw6PckRUN0CAEsAm_vjUw
Message-ID: <CAFLszTh2W5Nc=mEQ_1Z==2z0fSQm7JLpeYV8vX0HVQzE+4FVfA@mail.gmail.com>
Subject: Re: [PATCH] buildman: Show board list with -x
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
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

On Thu, Jul 11, 2024 at 09:10:04AM +0100, Simon Glass wrote:

> When -x is used, buildman does not show the list of boards that will be
> built, since there are no terms which cause boards to be added, only
> terms which cause them to be removed.
>
> Add a special case to fix this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Tested-by: Tom Rini <trini@konsulko.com>

-- 
Tom

Applied to u-boot-dm, thanks!
