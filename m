Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61560CEB2C6
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 15:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C19083A6A;
	Sat, 15 Nov 2025 16:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bs2HDIjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD5783A84; Sat, 15 Nov 2025 16:33:17 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DC983A47
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 16:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-65704dae718so1296323eaf.3
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 07:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763220794; x=1763825594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+19JiXeBk8PavsMftnm/8RgP/XeHZN4xOoY0Sjp/rA=;
 b=Bs2HDIjWPEthT8j0VPoe8wjECRI7xsDHdTL6PG1ZhYKpMX9jLlxskexPqcbxAlgkyv
 H7WRvzHAigGoKLg7l+Wb9vp36eZkAi9CFtWNPv534A8XgCAUivO4uOemgzyiLoyR3s7V
 M8RIkiNNNSG1punwmEiqE12mb77NaX4V4VVh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763220794; x=1763825594;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A+19JiXeBk8PavsMftnm/8RgP/XeHZN4xOoY0Sjp/rA=;
 b=XJyUFZlApsInlwYA0ip2E1LhwkzL561BX4pAfP88OdLY0OaFkMQDzB2t4qrfnCIGc0
 WwgYU+NFhALcwbHIDXN+611aKqSjPxYM/KWs9gr5/1+c64N2GP9QxFL0X19CcxjWwXfg
 j61QlKa9txeUrYe9OTRobQcjEAErWYmG3VMYHShCa5AcV/T5tKlQ5DFyRoCU55NXeArS
 Qa951ST+ayUT5EdFF2AXn/kvto3rg6oBYffQ0e/kGLmmU67sNeaKjJZ1ZrxAPphsZMz8
 96QXjeDrzRhhyptclktFmcPFgK4u9J/UNGWmgtNY0ja7Wh6a1sPfeBgUAVxuenSs9B0W
 0pHg==
X-Gm-Message-State: AOJu0YyidOQ17KiV+zAdggdUsLDfqHvuG8PVfHaEMgan++8ygDNYSYGh
 WgNsRL3v/nt6UcZQ+MKrIc641DHcEkbBk4PNj1XC4tKUyn9t0v8Mfgo63fxoRRQhNCI=
X-Gm-Gg: ASbGncsSbfft4InsEeLvulR4NtxJ9vxFhFwW2+HoTZNbxauvvKYThnrxvoxTaaYe0G5
 AF0IIv6JaooLQ3F79j+yYVtiXKHemc6VOURRijikjunD7TdDd5fBQK5lqYYdjmJtMBq+y8KMwqT
 uP4uFOShNA8orabF2wCBc5DFkcDup5w8hC5zq4ZoE6eW+BtoENc8V4x/Nlth6nk7O3P6mPFKKAr
 cm5ZIraOjqpzV6Ec3XPGr9VZzBWrcxBcIZwzeJaZXtA/YzrUpJmi2Oo2ZojvqaUVdi3TJBGmZR5
 74Hz21hPOqrnb+kIx2qycYU0aEnbK6khUcsn2FdsIXra/V+fl1FE1kMgCKrIl5bBHC5rwyRM2nN
 URbUZrFWAxzLmQs8HucvelvI6bN5yNhBu9IpOA7HU/c0EXZ4tan/RsTnLcwgMxRU7IW5SChrgPm
 cT9LmydsK367uIm9DaQ7GKl+M963yq3/JorpM5kfANrOsJxW+R
X-Google-Smtp-Source: AGHT+IFvFU7J+JJwPK+AFbYXXx/Zw1FeNys+6S1dGEIgG1Kd1cvlE7OdQl/hnfYbe35xdk/5UxfE3Q==
X-Received: by 2002:a05:6808:220f:b0:450:3d40:dec4 with SMTP id
 5614622812f47-450975d1e47mr3689368b6e.67.1763220794003; 
 Sat, 15 Nov 2025 07:33:14 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65724e0055dsm2932739eaf.17.2025.11.15.07.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 07:33:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Huy Bui <huy.bui.wm@renesas.com>, Thanh Quan <thanh.quan.xn@renesas.com>
In-Reply-To: <20251113221627.1141330-1-marek.vasut+renesas@mailbox.org>
References: <20251113221627.1141330-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <176322079272.2593579.14322462383521369537.b4-ty@konsulko.com>
Date: Sat, 15 Nov 2025 09:33:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 13 Nov 2025 23:15:40 +0100, Marek Vasut wrote:

> R-Car Gen4 pinctrl alignment with latest reference manual.
> 
> The following changes since commit 6c2f2d9aa63d1642dffae7d7ac88f7ae879e13d1:
> 
>   Merge branch 'master' of git://source.denx.de/u-boot-usb (2025-11-13 08:01:57 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


