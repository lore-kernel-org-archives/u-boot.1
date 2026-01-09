Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE34D26D89
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01116843AD;
	Fri,  9 Jan 2026 19:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c7DKfETp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021BD843BC; Fri,  9 Jan 2026 19:24:29 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42AB843AD
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 19:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3f9ebb269c3so1998787fac.3
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 10:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767983065; x=1768587865; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ir9q+7HpGYUIRLE3ylJPvqZSyqWwb+nGCNlwXgQBntQ=;
 b=c7DKfETpMsBf9iCrYRHKqUUX+e1iAglFdO6+6jl0Hxex6EJmLdkhkAf1fJdVQM+Z7j
 DipMEo8GGXd64nZfIy0GxWW0z2U4KZXSNiAJ5vs/jmz/Hrtnkqo0U1Az5/cFZt0M8VrL
 MeXsgdumUcN57LtW6RL2D05Z4Sunbcqqw1lHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767983065; x=1768587865;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ir9q+7HpGYUIRLE3ylJPvqZSyqWwb+nGCNlwXgQBntQ=;
 b=qPW+F9IXXS0yYCHojCoFu8zXotvihpYmkruoHDjxGW9Z1dcuAF1crx6gbHEP/QfoiI
 EvkvdP6pYhc/f9XbtC/WBzBARh8e8oVJelLrndib2tiXeSHRt5QRdp8jLO/ze8pdJ5M8
 o4IWadw2gei34NVsUa2/DcPHNVf99V4ACYdJVgMx+ClcVfEDtoJnDrd5L6dBhl/D3Yuc
 Pjpd+4cH0mAfKhr/D+bsPS+KNXU9Py7F6zimIKg93mKr78XABP0ecXsPbv7c6CaxWmy9
 jiGQCClwpfxdtnGCdnX9f+zZB5V4l4+XOIswPcddOe/jRKcXeux7q0FJkNUwODk44E1d
 clOg==
X-Gm-Message-State: AOJu0Yzk0MhFdtMke4I3BVZTw2z+iEKHIk8S6Y+Z0GAAiWb6XH/oqUlJ
 2fh8XBBUpytWKdtl8Bb+kWvZiHAICTbKM/P6hxO4T0Thn/OGYA4EaD3wsBNmXIQqcQU=
X-Gm-Gg: AY/fxX5sxgPrngfQ07PAO8kR/m23r/yGsvN1GnqLnd5Y80Y/Tt5Hyf2oIgNlzPYm5Gz
 J+MFkDM5hRaPFbFENFcJDaX9ifGuoPTfRCw1vgmLA+CSIJyfi1YCEzr+tZOTxsOAAkdo1/kLQnW
 lD7f4wJXizA92i96V6IHbq3lVMn3g+BUnnZ3bRbUBYWrm09PDnkbjvETCBhOMJe2+WkuLyZrvfd
 2Lr1WXDOb+FjpwB8Fzj/MV5BxxTXSSR6+OV25ILEeNbioshB87jiyqcOLXeG+IOReZ77IwGP+DQ
 oW0zj8i1t1USDpO5mJaVVdCTEkZLbDTaL/B9eC0tPDNkn7B4UXqOfFK+4tDzIMJP+dKMAQcs2qi
 CKY+OqVGkcjWyDNASkJn6GKPiQIgDKEUAJ9D2QhnXTiyrLLTy/okL7iJDjbe3Aw4n/qhQqZ4LMb
 Hur6g011vWqp4Q4La4UXSc+e3Ed++ysY3DTJq7HQY7TcWAgfDHqz2/WizjVHIVV0Rq9cgPplo2f
 BT4laQ4VWMFn8PXnxKIKFT5HW9iT+ISBTuK+g==
X-Google-Smtp-Source: AGHT+IGK5dRFNqnxcnkj8d5ibAmUatqIWN8d/PyLsKMBgAciUGCdh1zNbRQmtOL1GerEFSTxELc+bA==
X-Received: by 2002:a05:6870:241b:b0:3ec:4b7a:7ceb with SMTP id
 586e51a60fabf-3ffc0be6431mr5888436fac.48.1767983063838; 
 Fri, 09 Jan 2026 10:24:23 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507235fsm7687647fac.13.2026.01.09.10.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 10:24:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Francois Berder <fberder@outlook.fr>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20251227223833.3019311-1-trini@konsulko.com>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251227223833.3019311-1-trini@konsulko.com>
Subject: Re: [PATCH v2 0/2] Enable / require DEVRES for devm_.alloc usage
 outside xPL
Message-Id: <176798306271.1453020.11262471757305335316.b4-ty@konsulko.com>
Date: Fri, 09 Jan 2026 12:24:22 -0600
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

On Sat, 27 Dec 2025 16:37:09 -0600, Tom Rini wrote:

> Hey all,
> 
> As seen by a number of patches fixing memory leaks, U-Boot has a problem
> with developer expectations around devm_kmalloc and friends. Namely,
> whereas in Linux these memory allocations will be freed automatically in
> most cases, in U-Boot this is only true if DEVRES is enabled. Now,
> intentionally, in xPL phases, we do not (and do not offer as an option)
> enabling DEVRES. However in full U-Boot this is left either to the user,
> or some drivers have select'd DEVRES on their own. This inconsistency is
> a problem. This series goes and deals with two small issues that were
> shown by having all drivers that use devm_.alloc to allocate memory also
> select DEVRES and then we make DEVRES no longer be a prompted option and
> instead select'd as needed. We do not make this unconditional as it
> would result in growing the resulting binary on the many platforms which
> have no users of the devm_.alloc family of functions.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] x86: Increase SYS_MALLOC_F_LEN to 0x1000
      commit: 284e1a00f4f28dcd6ddc8c860d22f1c8c427c5d5
[2/2] dm: core: Default to using DEVRES outside of xPL
      commit: 217cf656e249f698d390a7d8eaf255eb1a6c0230
-- 
Tom


