Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354AEC47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0A1D87AA1;
	Mon,  8 Jan 2024 01:16:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CyWsx2vs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31E387A94; Mon,  8 Jan 2024 01:16:25 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4EAD87A58
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67fb9df3699so14485906d6.2
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672979; x=1705277779; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pEqHk08YLjONkHiYvvqCiwIJpwf1Ho7WWtEsP+QMTkE=;
 b=CyWsx2vslaNEpEdtjEhhB0JrZ5mm4/5bsNb1rnlBaCBxDaOt7LtZhQ5k0T4cfW/kk2
 vnoIN18AjdVv+f6Fu7sClaiIJoocBPR659TwLCPREEZDNe+FcCNII681xWOrTGDABg+i
 Zf9lQCKy0Jmb+g1oa8xh1MqbgpepiuF3QmhoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672979; x=1705277779;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pEqHk08YLjONkHiYvvqCiwIJpwf1Ho7WWtEsP+QMTkE=;
 b=P3hsNxqivlggfefp5oxA7M0R/I5lGhd7EHkMbN0VAMA8/vrORfndlkT5NszkZSXaRp
 7Rd87mP5ZQuTxtLiqEL8F9BYIAtYqilDnrBwXITn18JtdPtQPdr2CI+FRbRNlpX0BXMF
 NCfpoZv9czZ74DOuU11NRD0jdi8qipSiEU5Y1NQ47SRDCH3xb4d08XXcR+icGeofXHXY
 ErKoUb9DJpkMcFp3zJG8C/AxnH84ZMogshPRMDjyySMcY0hJuJ4SbWxR1fIJ693KrR4C
 Z1cg++wy549oiSDr01uYrS7/+WyAXocopnvbRcgBFUA38bvk59eMAH2z8pK8uNvynE9e
 eKyg==
X-Gm-Message-State: AOJu0YzzVF6uHazLrKr6OvnpHD/jHWkjnos4wlCGQDMyrVOfIZUvZdSF
 6wbCqF55mDFRLr9dADateI5Sguj+WPUz6cnaWI+JWCjZVLHq
X-Google-Smtp-Source: AGHT+IGVNXkOaHD7JI2d5Gj7a5HbN+gzz3lkL/Zy6clqv8Hx0R6WQQ8LnU2718bOBSzotrYRuSiDC5dk0oevANHQKhE=
X-Received: by 2002:ad4:5ba9:0:b0:681:9ab:4c5 with SMTP id
 9-20020ad45ba9000000b0068109ab04c5mr350411qvq.78.1704672978838; 
 Sun, 07 Jan 2024 16:16:18 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:18 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231231152555.464874-3-sjg@chromium.org>
References: <20231231152555.464874-3-sjg@chromium.org>
 <20231231152555.464874-1-sjg@chromium.org>
Date: Sun, 7 Jan 2024 18:16:18 -0600
X-Google-Sender-Auth: iX0I-iq7SP-jgrLfVws4Aj8f45c
Message-ID: <CAFLszTi78X7SHwQ82U0s4M0cAPBGehie972srhaDkcqKN2PPzQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] smbios: Move the rest of the SMBIOS2 code
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Move all of this logic into the else clause, since it will not be used
for SMBIOS3

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/smbios.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Applied to u-boot-dm/next, thanks!
