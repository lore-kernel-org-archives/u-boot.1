Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68D0CEFD04
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 20:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3061483FBE;
	Tue,  6 Jan 2026 21:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UyjwHp0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F2083FFA; Tue,  6 Jan 2026 21:16:26 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7697683D9F
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 21:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c95936e43cso562729a34.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 12:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767730579; x=1768335379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7m5bfeWBH8pKrUXEpX3/JcbaLnQfwT/a2C0sg+7PINE=;
 b=UyjwHp0DEcli8uCQB4iK7LUZHD2mDFywCrxmjvHEl2C+YbOlBSTUe/baCRXM24ZTkm
 C5wpLxcG+IzPzT6JaThB6Ny4CvX6cl6SY8n8hs7cXJf7pT055I0BQxUmAgrKSPWDWbNF
 wE3tkDTo4wnNd8Cn0wmsSMm+AiiHwLqRLN1C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767730579; x=1768335379;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7m5bfeWBH8pKrUXEpX3/JcbaLnQfwT/a2C0sg+7PINE=;
 b=VBtD9EBDcdZ+VnhwLsRrCaCiw4DKHeBPrlGYbXOydNdjllS/KVwDIGEW2arTLNb0ge
 NJw6ck/mYksLYbG1osfN86YtPB4PJ93QAVy9FgP9yl1WE+trZEHnZcdQ5rxxDL19EAms
 kCcE9V8ej5xjcTuyow55/A9MPtkl/FwIT5nlMi9KziG92yoDeUNMJM7ZDAxwbsb/n76J
 Ph1QS+0SvJ7uGfgXWrbU7gh4RkzJIuOpWWYB4YA3QTFR90GwDQUeEntUuMNxXR+b+Trx
 ye3eSwL2selwNfxCoe09zMRQ9IbkJsaCNo/3uWx42nyWI+xsxjoOSeCpc6AezxUmEUoa
 cC9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzmILpwe18SPoRvMoxhZThv10eiINnu2GCEYsLztZnlOhoqKn+eyTsQn3qrYKxoIZzRKx4OeE=@lists.denx.de
X-Gm-Message-State: AOJu0YylCTsA0CUWCmiiISe6SEEAOJT0vatGR8pmXhTCe/0janI0jfwr
 zC7VAyPIM7ASQ14DFBaOY6jqQ714YA5iwp1iVGdRhNnBdz8HiCr2D09bmroY6v+oSmU=
X-Gm-Gg: AY/fxX5lMIILJcf1YwANLq8FZFGHS6NglwBwVLpnLovYH9eDq7JLarnVyvecDcXOhg/
 L/aYS9KBCpbRPcwd6IqwCMJjI7dydSUirEVOsntkjz1KMxMLYYjEYu1LFYi/1a4O0m87Dwiiu1A
 e3ilAM4r88Pu9/+Y+MXo9gxEy91sdxJNi1d6CJgUlyV0tsQVmSYkDhl+ja5UskWqnQ20oXhXZ5e
 hrPUQ1W7uUhL/5QVV9/Udb4URikHO6vtzRhxVerhXaUcD2lXK+7qUKnlBQcrZ8pwtVmYm4UArjd
 I9WOPn3sN+5zM6JSGXsiuMwxythfF/yaIlGPGGk4aVrIPbdYDWSd3YfdGTnl8JQRg+jOEfTpuLH
 cXOE9EZaMrdJR77OGgAa6V9mDzOO9xmUifqyLVEoJ03mIa/YsHsEblMDiYAea4o3LDRFDpZO6jA
 RivG5OUu3fy+Jkb7xysKruqmkQrIVNC37BO197mHpfvS/socF6VDSibj4ELsd/TdSIhy3FJlYJ4
 1U3TkjmlvaEAQgrVXrsAWqwnIj9HU2JiKM/8w==
X-Google-Smtp-Source: AGHT+IFOZYgVDVTS7H6fHUrxC18cFwng+Zda+8759GMX5dmK3DWXb8lthm4AjYbU+fyXKq+ArtU6fg==
X-Received: by 2002:a05:6830:4426:b0:7c7:8060:e197 with SMTP id
 46e09a7af769-7ce50ac87a3mr219069a34.34.1767730579211; 
 Tue, 06 Jan 2026 12:16:19 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af63bsm1962355a34.16.2026.01.06.12.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 12:16:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymondmaoca@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de, 
 Jerome Forissier <jerome@forissier.org>
In-Reply-To: <20251224074507.15540-1-heinrich.schuchardt@canonical.com>
References: <20251224074507.15540-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] test: The LMB test depends on CONFIG_LMB
Message-Id: <176773057841.3765597.7998346172231584463.b4-ty@konsulko.com>
Date: Tue, 06 Jan 2026 14:16:18 -0600
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

On Wed, 24 Dec 2025 08:45:07 +0100, Heinrich Schuchardt wrote:

> Many boards use CONFIG_LMB=y but not all, e.g.
> amd_versal2_mini_defconfig. Building this board with CONFIG_UNIT_TEST=y
> fails:
> 
>     aarch64-linux-gnu-ld:
>     test/lib/lmb.c:411:(.text.test_noreserved+0x428):
>     undefined reference to `lmb_free'
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] test: The LMB test depends on CONFIG_LMB
      commit: 81b3558e74a372b8355c8d9b234566dcecf71bf6
-- 
Tom


