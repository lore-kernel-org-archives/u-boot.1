Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8B7C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F7387714;
	Wed,  8 Nov 2023 05:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U4BTlYtf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB2B87720; Wed,  8 Nov 2023 05:27:35 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A128770B
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d9fe0a598d8so6385994276.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417652; x=1700022452; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bj+i8kcSiIBpZt1SoyEtrOs6q/0W0AjsJhRrbhYlVGo=;
 b=U4BTlYtfB8/CN2xaGPHf9FJ1/TDtXjZqqRiFcaUojcwD3Ux+gfa9vbCPm3+MjQ52mx
 oun00kqt0t7MBiXmuQDZWqJbdCOiFuhb7nLMfW+ACUliPGQvfqO/9pRuAmh5FDjiiGTa
 4pmp9l5HVB/UvCMifj5lDfsS0v0yycQ/QWCI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417652; x=1700022452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bj+i8kcSiIBpZt1SoyEtrOs6q/0W0AjsJhRrbhYlVGo=;
 b=rCN0iRkx7rvCeYS+oQhrZreEdlkrfYuDbDA4jbpMnxTAgRYvUJlmYBiQ2Zp1RRXPAz
 ASG5he310Tx4HNhONUjeU5ppImOJq8/Da2ew4q9CS9bCRSOA5yl66H7Rl/XzZ8Va+G4v
 CxbFD+Z0zx10epSQbpRUztK+YIYeZz/lg6tsq4WomwGJjHCIHVlZU+w2c23fMqlxGBVb
 eFBCx+QGejvvA6ZLlLAt6LC9uZ8GExLzpptly9QkFq7u3qPHj6fjxTwzkaqJIea/FQiX
 qW8oQAGoFHCfEK+J7PtVvjSmZmWfHgg2DIZWQQZNi1kNxfuk5Lg0CFidmyrhkfXTW2LX
 J73w==
X-Gm-Message-State: AOJu0YzvJH6A4silXA1Yi91mwfTIyQHhzh5JTX5Pw8YX7O27r7qyg/kx
 xnC54oRWA4NyNzhqcTUlVxuCFBYzc2rh/fq1K0WZVqrXurOvrcxOd8g=
X-Google-Smtp-Source: AGHT+IGInqyTO07uITfRIO/SUutmueeNG4lrClNONmpiswEx7CKKKsDpbeX7xy8pAQ1o5PK6egGzEdT3USAcDytBQCE=
X-Received: by 2002:a05:6902:100e:b0:da0:6876:c20d with SMTP id
 w14-20020a056902100e00b00da06876c20dmr846657ybt.19.1699417652247; Tue, 07 Nov
 2023 20:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
 <20231107190601.17151-5-semen.protsenko@linaro.org>
In-Reply-To: <20231107190601.17151-5-semen.protsenko@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:49 -0700
Message-ID: <CAPnjgZ1KXmMf72QVz-3=B+Uke9Sg87mgenYuui8b0xfvi5eR4A@mail.gmail.com>
Subject: Re: [PATCH 4/4] serial: s5p: Improve coding style
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
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

On Tue, 7 Nov 2023 at 12:06, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Just some minor style fixes. No functional change.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/serial/serial_s5p.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
