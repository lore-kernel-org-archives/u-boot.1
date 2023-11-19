Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F7CC54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C969874BB;
	Sun, 19 Nov 2023 01:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KfaIWekN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE3E8749D; Sun, 19 Nov 2023 01:44:12 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AFA486E95
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d9caf5cc948so3087773276.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354638; x=1700959438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=narzHDnCVJ8Hi/7eHoi8B0YKjgJRvO+m2x3Ky/Qeifw=;
 b=KfaIWekNezZfyZGeCRcyIquJBzYEiVr/Cx7MGCvb+8kDxqBBSUKTJccVAcBUhcmgXS
 4WcUtUr0aaCHh2SLghkaLJFW9HwY7bJPkfPw9TuRNQvTgw+pKVWnKlx+bjqcc0pddwit
 5HsxAxydWM/NzWg0vKdFXSfbf2G5ckJqcEsOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354638; x=1700959438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=narzHDnCVJ8Hi/7eHoi8B0YKjgJRvO+m2x3Ky/Qeifw=;
 b=f/OZolGK6CpiSvwC63YVehsSLIabAsXZ5D9hy3G9gv0L9GDCmEiemL2HNFV+C00pCW
 n+TxiTh9SBO24hamaJw1dRzQhfJnPccTY8eleICc3GQmjmy+PTVM3i2Qqqu27qMU9XHH
 gROZvAxj94e1UT335pkIoHPdRYL+NknO9UOip+lt2aSsO7PLaTNshEKu67Rus3sbgtrZ
 SS25gjwITcrU/UM1VoNbikmgVn1ReE0lSNadFXonDgnwXbjsDjctgcI/c6B+DacjnESX
 v5JXFgLfWSkipyYh8Uuh5KwLS2dbpLRhfWaLUbpG2eTCNfWecvjTutSjXOAR1dbd7EsK
 +f5w==
X-Gm-Message-State: AOJu0YxJJ2xsJoPqAk0LPoqY/7wrb1f7yrbHCJeW2CgT+vi1RLDr9tk+
 zqH3HSLFWW+1vPfr6la1ZfzpyGp4GW4Dp2wgxcP8NCjz04xsj+R+zGM=
X-Google-Smtp-Source: AGHT+IFD3Tqoz9qhjBHKu6fOY1B/ma+KXYwGUMjzOUAb/lXztq2kRHD8RU5AIlHHs4ZAvQHIinvK45RDxdB+pF1hOuk=
X-Received: by 2002:a25:4f02:0:b0:da3:b4ef:ecd3 with SMTP id
 d2-20020a254f02000000b00da3b4efecd3mr3164975ybb.65.1700354637899; Sat, 18 Nov
 2023 16:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20231118215727.95086-1-heinrich.schuchardt@canonical.com>
 <20231118215727.95086-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231118215727.95086-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:43:03 -0700
Message-ID: <CAPnjgZ01wYe-kKZhfGAhn3NcAEe5nywAAJqQRHnRnxvC+w3Qzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: unit test for acpi_find_table()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Sat, 18 Nov 2023 at 14:57, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide a unit test for acpi_find_table()
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  test/dm/acpi.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
