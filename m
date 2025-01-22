Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F72C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E162780B9F;
	Wed, 22 Jan 2025 17:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ekAvgaX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C1D980A23; Wed, 22 Jan 2025 17:13:02 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DA28809D2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5dc052246e3so403351a12.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737562379; x=1738167179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57k25O3pf+yezh+tgDmCRgjDgyVcb3MhZ8H4uKAjd0Y=;
 b=ekAvgaX5TFBfMymnrUiPH/zQnSHWJSWc/7hNFFgWqqEi9r16yGdQs8/fo+NEi1czuB
 qmHR1vAUfviOWjlNvXJabeW4EsPot3wdutUZn3AQfD1ZDOUqQRZkBGUWCMOCCHuOzPfS
 gQITO11OplsUB1NemXiX+HkGnW+gFsa7MQFg2T6yZIC/n+pBKY5weX2Tg6HIpACuY6/o
 zfd9s4xLSArQJHTrxOHNkZbJ7DN16M6kq5JTntBzX2dZgGQARVUSaPSoaD8mJ6+0zXr0
 RF8a5tCbHTfYl04s7Sxk8uz5Zla3wInxVS2Yu3XTb66cWXLhBJ5FBXOPfqXyRew6OElF
 aJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562379; x=1738167179;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57k25O3pf+yezh+tgDmCRgjDgyVcb3MhZ8H4uKAjd0Y=;
 b=gY+QX1Q0YU6cwqGSlWslx8jXx9HxNgK2lSHr7Mu0jb+Qyrk2e29LSVkCIXP1QznOnm
 6pOGGhtrUw3/elXuxkuctH74TAKXvy0uhxd4ghTu+OujX3VafDm6rl4AfFmP1pukd8ai
 6RZua5g/fawPOUDqCq0E8miU4gdOfc10aiNcFU3v6ssB44TfAs/6ApcGQOYQfFgu7eNx
 8mUl/zp8SUuIztSSzb+BE/ysAOWj4l6VpyqVnCjY77imZIZ3DY+iE7HhC3mitZ3V2FBD
 D0ubOKWodqL1PTgwbnS1YHxe8CrzhKkAoRe4W2Y3kChTDuW/w6ZQZ2pg0qzY612D4lh5
 WRlQ==
X-Gm-Message-State: AOJu0Yyptx4VT5N6F0c78jVR+UX/Zl24s+Elnd+DXOdlqHn8ek7Ljyfc
 c4ZcaPqbTGTVrQblnBE+e31iSRaxnxdqN3pAVD/wcsAbbwFUblIBswcvK8oqtY0=
X-Gm-Gg: ASbGnctLIT4x0Xr4/SkWNeucDRlCXRKP5CttTNgCOY+EAQCmgwx3M3U8mkwEkFutr8m
 LW1+oUE0ipHht/0D7M3IrzBAPELsvF61gkeHXh/HCTE1uGm8YYRJK0QgM2kwnu2arOpvuxEKCG9
 KfVH2CdsmZ0jxTzx3owC0D1wEs+rpuEVnvVdrL/OHPJNojcq1hO/zJyj6y0EcIGIx4MplKSodB8
 +tmCgGUhPws8kyBDMCCHiPj/0DGEuMo/1+NVGlMddFO8WJK8diH6Q6gNFYZIHcKEXEUUvO3oHNi
 czXVPMIF9ZZ0
X-Google-Smtp-Source: AGHT+IHd8OtcXfierl6tD8bT8pxKkJ9B+DFGzI/fwfb1eYNdxvUI0QGWDC1nchBhJF9rOgO3LDM5pg==
X-Received: by 2002:a17:906:d555:b0:aa6:aa8e:c89c with SMTP id
 a640c23a62f3a-ab38b44d49emr2263371466b.39.1737562378877; 
 Wed, 22 Jan 2025 08:12:58 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce105dsm924966866b.39.2025.01.22.08.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:12:58 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20241125-topic-pcie-phy-v1-1-bf08811d0a07@linaro.org>
References: <20241125-topic-pcie-phy-v1-1-bf08811d0a07@linaro.org>
Subject: Re: [PATCH] phy: qcom: add QMP PCIe PHY driver
Message-Id: <173756237783.1864727.11566060079724497016.b4-ty@linaro.org>
Date: Wed, 22 Jan 2025 17:12:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Mon, 25 Nov 2024 09:54:24 +0100, Neil Armstrong wrote:
> Add support for the PCIe QMP PHY on the SM8550,
> SM8650 and x1e80100 SoCs.
> 
> The driver is based on the Linux phy/qualcomm/phy-qcom-qmp-pcie.c
> driver and adapted to U-Boot.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: qcom: add QMP PCIe PHY driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d22fe8f2aaf9

Best regards,
-- 
// Caleb (they/them)


