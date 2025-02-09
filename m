Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94902C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD3C18083F;
	Sun,  9 Feb 2025 17:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ke3Rn1AJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9850C809A5; Sun,  9 Feb 2025 17:02:14 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CC3080821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5de47cf93dfso3323469a12.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739116932; x=1739721732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JZ8pFw+MtvVniUJHun8Wv8uGrC1S+gf8512FtkiJSZE=;
 b=ke3Rn1AJ8I6HIWDCrkWKdFiY29efSqbu6r0RRCZpG1DOMr47Y/5MhmDX9gX/6SO54N
 ePBpbCO5jA29AGjwwttkKC574P3jK0+LhZQwiNM8SQhClkAkR+0Wq7Tnr9JB8EKNRY4M
 DempT32FFt7UyTR5ytVMAxQeU0Hn2ViZJ7bVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739116932; x=1739721732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JZ8pFw+MtvVniUJHun8Wv8uGrC1S+gf8512FtkiJSZE=;
 b=X5yTmZGEiekKFCWvkbXHDDDMVFoZ6ozMZsluGdMABLFQNPp9xT/KYB52v0qaxPG/rz
 Nyi+yaZeq7nCBsUxPWCgUtMm6keJqBf63uqU6lGGrDH61mW2mIClK18z4WUdE6gboiSW
 OErEmIgveYctZD91F0OoJgt6ZenIn/LZYOwY/G5vDVv4Ngn9RI0P9QbtBZAymxFC7Aaq
 3UIJVolvi8CUeHelPVFCns+68ysUxD8oG8o2y3UqxZHZQsw8megkT2k7K9tnhaDu3InG
 Xk5mex4jPTIi09LDlo1oFHNfyXwW6HtnUmsvxF5bz4xpoQ3HG0sdt1NYWcshJq6sQ7XN
 XmlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmqxhxMkpE4GDeCsCiE3sAxka3lX6gHRq7wb+tyKh+FjhnRFA3625ZiO5SCdOkLMRkEuAS3po=@lists.denx.de
X-Gm-Message-State: AOJu0YzmgM6Tau3EfwE2NoR9pyMG3eg0+wPJTqQuiNxVdAZQ9lBygDyW
 PMuoxRmiVEfc/FNKXpweOQ2QvxJtnpoPnN/tj/PvJuBJvAQ1dSEWVrDhfJFlTIpT9XuWeLjMYUS
 SuR1dPbkeYMfRSbrpYFccLXom0TDUKCmAwhgc
X-Gm-Gg: ASbGncsCwJUrz+LFXPiTX2OjtSsgf+RF/3ZflOX1+uuNwX21jrd87aWOUSdAfoZ/fzW
 bcWGnMUjdNyhFr/Gs0BP92nEAxmtGbhaPSPAM9MvjEiO4VTdZlRZ3yoNEcs1sgMxhP+L2KyhDNQ
 ==
X-Google-Smtp-Source: AGHT+IEl1ba+DeDebTksDUlv3rz9cGCjy8/9QveXEoSwd3EhJCqhezfzVcV/yMWx8r1EdV6LcHWg2YXUWNdN1WhFcoE=
X-Received: by 2002:a05:6402:3907:b0:5dc:893d:6df3 with SMTP id
 4fb4d7f45d1cf-5de44e5b84bmr31407015a12.0.1739116931876; Sun, 09 Feb 2025
 08:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20250209115217.85250-1-heinrich.schuchardt@canonical.com>
 <20250209115217.85250-2-heinrich.schuchardt@canonical.com>
 <CAFLszTirNaX-6KfMPJ1LNHe3iU_QzATy0s1dHnfKbUw22NCP-A@mail.gmail.com>
 <83c2dc33-83a3-45eb-96e7-8c3b7ae38b88@canonical.com>
In-Reply-To: <83c2dc33-83a3-45eb-96e7-8c3b7ae38b88@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 09:02:00 -0700
X-Gm-Features: AWEUYZlwY5XQV6zRMXUPtX3sf7v07FFS9VstIWgXg9BhECZ2G_CrLM9Fl5IzmBs
Message-ID: <CAFLszThBmOvnkGLZEv+rQkS1F+4gB=yJMQ-+UShDrUbGyGP36w@mail.gmail.com>
Subject: Re: [PATCH 1/2] boot: continue in fit_find_config_node()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 "Franklin Cooper Jr ." <fcooper@ti.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sun, 9 Feb 2025 at 08:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 09.02.25 15:29, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sun, 9 Feb 2025 at 04:52, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> If a single configuration node lacks a description, this does not rule out
> >> that another node with a description matches. Anyway we have the default
> >> configuration as a fallback.
> >>
> >> So continue if a description is missing.
> >>
> >
> > That field is mandatory, so we should really fail if it is missing.
> >
> > What problem are you trying to solve here?
>
> Sure the field is needed to make a configuration selectable.

It's actually normally informational. Have you looked a
CONFIG_FIT_BEST_MATCH? That is how this is supposed to be done. But
with starfive_visionfive2 I see:

# CONFIG_FIT_BEST_MATCH is not set

>
> But as long as we can find a good configuration we should boot instead
> of leaving the user with a bricked device.

The more likely impact is that people won't bother adding the field on RISC-V.

Regards,
Simon
