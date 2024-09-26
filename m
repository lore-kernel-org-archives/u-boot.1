Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C4CCDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DAC88E5F;
	Fri, 27 Sep 2024 00:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="khf57inG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E42788F4B; Fri, 27 Sep 2024 00:07:46 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1595088F7B
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71923d87be4so1201820b3a.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388457; x=1727993257; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hT+D3A6sr64peXFaUjhNgGo7SLDF+Z2D2WheO0wNY+U=;
 b=khf57inGXh8Pj9HQe3tS3xtiZFApyNvt8nTRc+VTZ/fRSKs68j/MBumUJzcAbwXLvM
 CTjgFpyHo/BDTnEqUi74NcZLYXONAK/WYIwNHFxDt6mp9pC0KJJ6IMR1AVJlyUBfMP+0
 He98Ew4LVuAFsq2ZjL6QJnPU0c5FglCI3Hw08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388457; x=1727993257;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hT+D3A6sr64peXFaUjhNgGo7SLDF+Z2D2WheO0wNY+U=;
 b=gTGhOCl2hjQinFmm3tb1z1oWJNC4+MzKNnip4tomN0eSxBrFaXx/eDSY13BhVt/fdr
 A409rxgdD1ARORCQfINm2JnU5EyyiJrLn1i32+jAVs70OvAx3SHw46wEmBqjMPhoVIVf
 2CghSjBiMwcWH89LtYOT8lvoLJ+TnH8pLl89+7xfrzfO/6EnoyYYiLL846ZXIK52Aw2f
 0DOA4wNfaIQIjPIliqx1241fo41jPPNAy1H/MmFWmvrM/X3iB/JFQrymgKnKNWQce7Ns
 JdTu1g5Esoz36AN9H3meh6No3+/KQFWoF+4US6z5mkICF6FCXrSt5RUNPWwWQq93Cc3M
 VRww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhV2f6NfVeuKS+tAanlZEN8o4thxzlg+OJIGgM96lT8EIq3BjcG8TYXsZse9Zi+bUuAkJeAZc=@lists.denx.de
X-Gm-Message-State: AOJu0YxP2o+hlJZdB0vbX4ADEBS3SKNjdIQDLGGzXgC1O5XwOD4tQZg1
 HI+lBCxDAClk8Rxpjo+LWHh6te7diUJQ+Tt9FnGX+R2gd5aYYVb9OKVyJvR4ePaqxMZDgjuiPwR
 royn8SdVe6wkyVxW9gpFDx0sv63RPVtKnA3xW
X-Google-Smtp-Source: AGHT+IGoWMv9ofcr7PEVP7dIRx1XO93Q8uZc+VGypxy8JJU5YiG3FTBZ4ZIL9PlYLu0ahWCso/SkZKBSfwcIKRGswWk=
X-Received: by 2002:a05:6a21:2d8a:b0:1cf:6d68:5654 with SMTP id
 adf61e73a8af0-1d4fa6c8239mr1523716637.25.1727388457662; Thu, 26 Sep 2024
 15:07:37 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:36 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-3-sjg@chromium.org>
References: <20240826191143.426387-3-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 15:07:36 -0700
X-Google-Sender-Auth: 52dMZvOo55at5vN9Gn-QKoKEcPE
Message-ID: <CAFLszTjVZuGrHxSZwZtHTTZ8qbaBigCiNeiYYkkr1aOcds1O4w@mail.gmail.com>
Subject: Re: [PATCH 02/15] binman: Correct the comment for fdtgrep
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

This returns stdout, not a CommandResult so update the comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/btool/fdtgrep.py | 3 +--
 tools/binman/etype/fit.py     | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

Applied to u-boot-dm/next, thanks!
