Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E20FE77361
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 16:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4612084292;
	Wed, 24 Dec 2025 17:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MdAYFc+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A96584295; Wed, 24 Dec 2025 17:24:11 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A87C84261
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 17:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b7eff205947so870986666b.1
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 08:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766593447; x=1767198247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WIrP2TYFDdvthOTkuuCB6MQL0gUq51KpoMZSh78wTSY=;
 b=MdAYFc+liikOr14il5b9L310r/Nd5uQ0UZGRX1EfPAll7qZQ2YIh7jfZWsNV/aeIvM
 6sZMa3WNHwPnh+mtSG0o+73WL744db1K06Xj+Qa0rul0alsUE0LjyvtLDvOTdb7pxKgr
 ulKq1MT2ftDGJh0RNzXZRoPT98qnKhK4XxbVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593447; x=1767198247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIrP2TYFDdvthOTkuuCB6MQL0gUq51KpoMZSh78wTSY=;
 b=O9tVTdSDpse9ZADq+hkoQE7ISUQKiWSXdfhb/Mzqwd77c2d6wrATBXcfPaEP30nyZu
 7GWs8YW9rOYNhgEkG5Ov2jVyJDoCWjurSTx1btNKDk/rdlDpBAQwPPSI9KyZVUXHw8Zg
 COqKwiR/fH8553A0Kgz/pZyrHz1FwRkQ1GHMtqybAvNIIGYILvPwG10DcJEWyu1I7Jdz
 fEDfWRwYMadsVur4K7GALTeeaNku35IQPY02RuAi3KuGJnXAE/DZUs6Egit/D1Yy1zAx
 +KszDtijcnv9ykq86QFn7t/lKKB0a7sZNOCAQ0l97lI76fOxitCi7LR9wk/8Ig1AlH/L
 D/rw==
X-Gm-Message-State: AOJu0YyB8z9OUTnmnL+ccrtkQt6OAljp17/mxKuxl3We+lU2QANcK+Bs
 sXifxy2ULNU56h26AlyEglx6DClluasJfERA3y/NT608+E77K9lVPMDO9JLroLigdj8FsHlRDRl
 sOdRpnPksQurWMKuft48Ze716kD1QZVmGC0Ob06im
X-Gm-Gg: AY/fxX6ScKVb3y0sUt9uwJaWGr6WL0v+Jqqxb+A8TB/k36bp+nCLvETK92Cp9ghymWJ
 xqgamAluIc+OhFQ1gwGkTCHTDeOPXG2cy9MnaTvOkAesKBTdelhQzNAKauqRbC+vf/yxDYnTTWN
 oAdCC+INyZiRo9Yohs0iQUygx3MSkMOb6k3YzFjQKNFpYCaDK6CX4+wpLBtbnD/jHDI+En/0zm/
 P8jRNMVkhqNIFK6slTpjNvuM3iE38OnHICikOOuA/2/M11ouH9tjQRUBuMucOSzM2QkG+UwcyQ3
 fzA2
X-Google-Smtp-Source: AGHT+IEe+xdg/fiRrIPDKg33f541egzcl3NbxpdiKhH5xQlu8S6a4MWh1bYc9ACcDRv7WfF2m7CTOcC9hlRr/2AQUtc=
X-Received: by 2002:a17:907:fdca:b0:b7a:2ba7:1988 with SMTP id
 a640c23a62f3a-b8036ebbbd0mr1688276166b.9.1766593447609; Wed, 24 Dec 2025
 08:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251219202121.4180810-4-trini@konsulko.com>
In-Reply-To: <20251219202121.4180810-4-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Dec 2025 09:23:59 -0700
X-Gm-Features: AQt7F2rNxmQtBC5UNly5QmnzSTKsjP2Hy8BOv-BllPBZ0HHh5-wGWjkgSZvL3qU
Message-ID: <CAFLszTjyO9d+QzwC=9t-cJ1Kx9oNcNSD3f7T+11zWwD-PJeYag@mail.gmail.com>
Subject: Re: [PATCH 3/3] dm: core: Default to using DEVRES outside of xPL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Hi Tom,

On Fri, 19 Dec 2025 at 13:21, Tom Rini <trini@konsulko.com> wrote:
>
> The devm alloc functions that we have may follow the Linux kernel model
> where allocations are (almost always) automatically free()'d. However,
> quite often we don't enable, in full U-Boot, the corresponding automatic
> free. This in turn leads to memory leaks. Rather than manually tracking
> allocations and implementing frees, rework things so that we follow
> expectations now and enable the DEVRES functionality to manage frees.
>
> This turns DEVRES from a prompted symbol to a symbol that must be
> select'd, and we now remove our non-managed alloc/free functions from
> outside of xPL builds.
>

Most of the time boards don't enable DM_DEVICE_REMOVE to save code
size. We certainly don't unbind devices. A memory leak implies some
sort of problem, but if we are booting the OS, all the memory is
'freed' by that process.

What problem are you solving here? It is missing from your commit.

Regards,
Simon
