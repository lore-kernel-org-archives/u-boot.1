Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36984E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8146280379;
	Fri, 20 Dec 2024 05:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MW6MXZys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B40408021A; Fri, 20 Dec 2024 05:05:29 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78D4B8043C
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so212180766b.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667527; x=1735272327; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UNys5T+d6tNEwva0Q8w6lqDnfDlIELST9OgvCDLC/KM=;
 b=MW6MXZysrRzm3/jXNzDfhqU6ec7NyLHi1rzjsi8TpMCgaFwpIvkgulGNVAiHMLBgj9
 HncHAo6GcdqwdO0Mr+mLyuYx1FBDWrkUFJ1o3tGbn12uw6nI7dt7iRd5UzXA7FN34U+T
 5IpOk7SUX21UW7fQWah7mUYo1Uh2j6m7tHg0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667527; x=1735272327;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UNys5T+d6tNEwva0Q8w6lqDnfDlIELST9OgvCDLC/KM=;
 b=wif3yd0oCU3Wpj0Lle0/utk/oW2N1L8nQvKBAKKRtTnGsXYv1ya/0RLlgB0Jro+Mll
 ADz8SY1Bw5lvD7f0PtZzAAbCJR1/quEmxBHTzpnvcjxkfGZ4wZOi3p3F9wdZRz1CIZ4v
 V+T5oUUwehOCjYp/qH5kUzZBZllh54evdVQth7OzsHzX8MO73WerhuRq8nxX81aT8AWU
 HmeejdV+ohjz74/pXd2nB/N4cDAWnd4G6DQYE0ifjyGDFh13BqdP3kzlM4e7Vj9KABA8
 cg4KVaihkCEMgP7sIwPj9IW2NchASMrCz0edmUPZltfH8I83xNYbk1urVbsjGW2ga1Nf
 Y0Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVLTB5pX7sMWliDB3S21UthsDEN7+E/LQYKmQIWoFcOtL6xGZ1jjiC7mb7Jdby253V83Ei2LI=@lists.denx.de
X-Gm-Message-State: AOJu0YwBvlkOJ31xIWNZMfZq0akJtMxxpauEYH9A/zEfu7ovFV2Xf1vA
 hW3eKEhFnjWodJYXO6nz6mA4YkKptr05DDWSWEkSwcK24dHVhUrQ1YwC6hu0aIaxtQ/Gvc2/DPw
 zOncVL3Xp/upNYnuFcbklSkoByllwyHyQ/KMz
X-Gm-Gg: ASbGncte7lqBIUHsJ9xzcxUa+3BmUSE57w7SkHs9Uf8S6S9wsZ0RgneWzzTFDjcL3kN
 L9nOBQJg6yL2rA1TDyqVmTW0pmjFuGPG2QewpAAk=
X-Google-Smtp-Source: AGHT+IEaL6fw1EN/LAfcHC8IcAb70E8zrsSJRZ/1kVTJm1imF9SSzR/Qvp5O7V4dkQT7diBM3Gh40Z9sveP+jqhNckc=
X-Received: by 2002:a05:6402:5204:b0:5d0:ced8:d22d with SMTP id
 4fb4d7f45d1cf-5d81de05c3fmr2820729a12.22.1734667527009; Thu, 19 Dec 2024
 20:05:27 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:05:26 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-35-sjg@chromium.org>
References: <20241206023626.2456858-35-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:05:26 -0600
X-Google-Sender-Auth: akPYNDDXnMdyLI4yWDb6gGboxys
Message-ID: <CAFLszTit+Lerb_FxK2jV22Smj2tjAFVp7u0=eXE5BTz0bmVA8A@mail.gmail.com>
Subject: Re: [PATCH v3 34/46] test: Update bootm test to restore silent_console
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
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

Unset this environment variable at the end of bootm_test_silent() et al
to avoid affecting subsequent tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootm.c | 7 +++++++
 1 file changed, 7 insertions(+)

Applied to sjg/master, thanks!
