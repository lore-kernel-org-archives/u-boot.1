Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31853CD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 22:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC8F849E9;
	Wed, 10 Jun 2026 00:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o2MYLMLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A57849C9; Wed, 10 Jun 2026 00:28:31 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12DE0849D2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 00:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4863cd41330so4558510b6e.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 15:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781044108; x=1781648908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJWqQRSb197vtTwf9fbY947mx/QezLmGID97egXKLWs=;
 b=o2MYLMLPTByFmXTEQmqgtfk8I1SVmT7N9z5iOXpagxomJ/VJTvAoOr7F33P3DMMjoO
 gS0tK6TNNs5dkyG6onY4x8pH8LcLXNVMvRUdPam+z0R0g4r7rH34wTMLSJEqcrZ8luG9
 6+E+HdMs4keEowDha8SfC1rsn81CN483xJHuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781044108; x=1781648908;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gJWqQRSb197vtTwf9fbY947mx/QezLmGID97egXKLWs=;
 b=kX2kMXJfgGfGCWagz1PeiZxM1b1gl5kBYBoazXrkBVGsmOLV1OSc6USvsjOUmXrz2/
 dnKC99NJ4fCvBrZ0Q3DitdGMN6VT3IqFDOVTPH9o+S5UX8kOy40bjJUO37UbmxN381mu
 Odsoxkr4W3LQhf+DBEJmbRBYWPu+wP2fsNJhUjB36BPuoSnEBm1+tiiytV7mtnZ6xLzc
 QYRRjp29Wa0Cdv1904H/A4WC8QSbhJC9D1qObCGSNrwFfnHBVLanJ57rZmal23vAB5W3
 1wBGElPBE5CiqEnRwiXGqbn0RNy7glwpl2leISXaHJwOprv1sy1IrxU3dIieWtItZicC
 8NaA==
X-Gm-Message-State: AOJu0YzyUanlTb5f36eMGhf5CYRvP9CUP4w48S5M+/GHvvbfSOIDb2sh
 +QwCSzDUkEavBzxHv9laKwMVUmmcW1CIisqqap1ygYW/5UDHGz06tMdcZorCREnu4/3UF7D6bCv
 z3uKAmY4=
X-Gm-Gg: Acq92OHgM1XUv33DEyg4piS050MB0wYq/5hFq7lJkGao8eb2kYYcmdedQvH9XU733C7
 ts46lkGCgUriq4Ukc4op1cv2iUFNX62UVZFQOKOLWT3+7eFUM7VrJm14YMOOpT7iqbAMdNRpevg
 41OQR8AakaqsX59XV3ydmhJ2dc0DduRvsw29HL+tMX1swwbnwZRmVbbEIqDnuaL9lEybbElq5Nn
 kZDKPGnDpEXOxxkHQd0NAfRnCIxJAGqVFY34qMsJp4kFXR36SRjEJTqCozqa6GhTUTzt4ycGngB
 65aM6Em6i2azqQBBPyuOnd/0Yw3OyAX7hHZ7tIzJinEjOGLNX/dV538iE5VsvhINRc8MlIVen54
 FzbBH1lKhNubJeYB8KtAT0+UC9tBrGVKYCXhWDiG8sk8lEKUD1MC2NY/yAZ9UbdAVkErBjI2LQM
 cSLN7sVnJb95fxdMqg0UnlpWpbkQn5m97rBEh04py5jkTqs9C23M5bxGodpA6qVkrCtLXqAKEZF
 1SqUl5bi21v6dBWYnRjOwLDhfMyjiRN9QS+3KzPRQKAc92IrIZXH/lZ+3OX9r69V1+g9ag=
X-Received: by 2002:a05:6808:4fd0:b0:485:7694:47e5 with SMTP id
 5614622812f47-48692d10963mr9395207b6e.11.1781044107889; 
 Tue, 09 Jun 2026 15:28:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm16790962b6e.8.2026.06.09.15.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 15:28:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de
In-Reply-To: <20260526074616.2800003-1-peng.fan@nxp.com>
References: <20260526074616.2800003-1-peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] ata: mtk_ahci: Use dev_remap_addr_index() and
 ofnode API
Message-Id: <178104410729.79918.15568655627879808020.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 16:28:27 -0600
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

On Tue, 26 May 2026 15:46:15 +0800, peng.fan@nxp.com wrote:

> Use dev_remap_addr_index() instead of devfdt_remap_addr_index() to map the
> controller registers, removing the dependency on FDT-specific helpers.
> 
> Replace the direct fdt_get_property() lookup combined with dev_of_offset()
> by dev_read_prop().
> 
> No functional changes.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] ata: mtk_ahci: Use dev_remap_addr_index() and ofnode API
      commit: ffbfe1cec387e35eadf522e4a7d6ffdba956158b
[2/2] ata: dwc_ahci: Use dev_read_addr_index()
      commit: 8d1d86ff58be46e17bb59b97c2ddc03f167acd05
-- 
Tom


