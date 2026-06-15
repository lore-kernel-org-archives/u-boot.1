Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6B8CD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 18:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B6258484C;
	Mon, 15 Jun 2026 20:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M4pu3WDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69FA084869; Mon, 15 Jun 2026 20:53:20 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DD6E84105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 20:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-43d23173511so2304230fac.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781549597; x=1782154397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7zd2VAwU46rgU50gnYt7ms4cVnrYMM8dgsnUbGFfOU=;
 b=M4pu3WDNeqAYcahhRHOn5h01SwAoVu61LyVfUb9YyuHaYky4EHpxdBHRox1MNvESGw
 Fce+G7nrZIm3vS8ibKg6vqqqDaWBxSYcEcxxcjaHgYbbHlV1UV6lfTmG7V/vjQDIyrM9
 hKS+eAvUgPmWDzlZIbF/c0J1aBem+JTT8++nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781549597; x=1782154397;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s7zd2VAwU46rgU50gnYt7ms4cVnrYMM8dgsnUbGFfOU=;
 b=qLG9UA/Th44oY3upqAEpWmE33Af5bxVSNWF985gAk4Ui/WIVFtjEAwhbVHsQmIxVs+
 2uScfE/9BZXJpau6PwQaFx93aCqZQUiIB3n0iOGVjM7G+NOCl8SxbtdAXdaAigkjZtzZ
 WJWG5OiZXMeuRIwE0uMY66mK0MNryQ118+cla+215f8ivxGgylUYtO7y34hS8owpe1Yf
 YKnCLVG/T+ujrtKW80Zy5WxC1DZpIFovQBHagbQAZOwfNKDL5mK6/cv6J2HIw4NIqQQr
 lNI6dftrMqUV6B8r8OnNSvcBwZgkzGj95JpnoxSoMe8yKRd4pW70mOcRwYhGP3dmoo0Q
 ifmQ==
X-Gm-Message-State: AOJu0YxB5dlG4YqVWp/QGp4XViAi6C2u/5AONsrd1Fl1CM8a2ov3vdYk
 EoK8a8t2b4x6HYbqaZtENRwHvXrUwQytCSiSX9phfrTfFyD6LVaMoHxR7cJOZDYOjZo=
X-Gm-Gg: Acq92OFxHfkOb3u34IxTBcFiVLjMuXq62cl079NQhC6s2aQoTcUvxRni9TKXFpePdpS
 OWoZpvarNh+wg3Vuzwtmlp32MoDGAQHybeLjTb8+17EsLtBkjugx2gHm5Fwu6xokCmL1tHJX9oH
 kBo9TDdrwmfyX2xc7iB0S+PN+XXdoBIL0mVUd/Cj1Rv0ie7HpklmwWy+vqnycpTiYO6dyf1ug1s
 13MVCYGTt2ZFdultlRWDSJTqQ1tVa2vzEzi1xjCi4QaPlGYzJeBKbWMYq9WigzDkKBJRP6+X/ed
 L6OS/cPJCYsTF5JgnFhuVtDKyQ9G3LYjFofTVK36fjLv/MwEjtk5f9rzXZronoDI27GZI6w0QNt
 QF9H7dCWZi38PMkOfW15HKCZGeycVOGzVCtTMvKwyVynetf6wLHWx9fEsydwX5CnwofdRW6vqeS
 HaG92m4XdDsntit+6CPfXvvHbl5as7ejl3m+kk4P18VpH3986fumFXG266AlLOFmeW8yiqsX3Ek
 d7x08b62Flrcc8ULOg3+pKeIowIeZ3Zhwsdwr+zTztALJHIiQ==
X-Received: by 2002:a05:6871:5b17:b0:43b:6ad5:6ab8 with SMTP id
 586e51a60fabf-4430ac8256cmr424597fac.20.1781549597055; 
 Mon, 15 Jun 2026 11:53:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44308f1a2a6sm485210fac.10.2026.06.15.11.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:53:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, afd@ti.com, 
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 rs@ti.com
Cc: u-boot@lists.denx.de
In-Reply-To: <20260604155038.3182-1-rs@ti.com>
References: <20260604155038.3182-1-rs@ti.com>
Subject: Re: [PATCHv10 0/4] various memory related fixups
Message-Id: <178154959611.120909.3021453606209486351.b4-ty@konsulko.com>
Date: Mon, 15 Jun 2026 12:53:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 04 Jun 2026 10:50:34 -0500, rs@ti.com wrote:

> From: Randolph Sapp <rs@ti.com>
> 
> Nitpicks and fixes from the discovery thread on adding PocketBeagle2 support
> [1]. This does a lot of general setup required for the device, but these
> modifications themselves aren't device specific. For those specifically
> interested in PocketBeagle2 support and don't care about these details, my
> development branch is public [2].
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] boot: image-fdt: free old dtb reservations
      commit: 623f6c5b6ab7fa270a9e36db0c6136c5983a45a0
[2/4] test_ut: add a ut_ubman fixture to clean up tests
      commit: 5a17d02223b942f97bd3df9d6acb835fded4ad28
[3/4] test: boot: add a fdt reserved region check
      commit: de12fa4df89277460aacaea7c9a43421190ee04d
[4/4] memory: reserve from start_addr_sp to initial_relocaddr
      commit: 48412f8f2962e27abe3b9a4a73221cebbfd73333
-- 
Tom


