Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C123FFF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 09:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3BA84701;
	Wed, 29 Apr 2026 11:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YbYtjNx/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA40284702; Wed, 29 Apr 2026 11:13:11 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2830846FC
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rgallaispou@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso8564461f8f.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 02:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777453989; x=1778058789; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gi+bZQZZt2d+wVJGEgxth8N+mFQ6Yh00/muVk1rc3rc=;
 b=YbYtjNx/Ehe4aPrQqLwFf4PPo4rCgfQvRLTSRrrins++CXionumFXJ0vc1j/hYD6Qp
 sjloZpGUO93vB4opLZMf+LI+Y4PVQlt3OPMzJAS9shpTDxGhcHDXBrgiTyM/Av8ELnSc
 9oqfPMZvMsRiiCqufzzAjBooiA6zp6C4OZKNGszMpvAKMvR+4ze+AOejDDzVq+F2ogLg
 IaARbFifgUtsOBRDneAxZHH4kV0UBaF/03Gntnigtho1nUnfQbyQ/O2DaNfNQ60atkHM
 IEVxe9MmkOjsHr2AS/VwwYGV6gU2bFlogUdw1MxlU2HFmEf3g8894499JG2M4QWwMrWx
 r50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777453989; x=1778058789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gi+bZQZZt2d+wVJGEgxth8N+mFQ6Yh00/muVk1rc3rc=;
 b=R4xKo/LyWd+JrYFr7lFws8xE8Kst+dqQxESEiKGKQucahDGHBJnZHVc7wg5bw07eQ4
 c/BO2b8SXMIxMwJ0KYYaz5QYVA+MdymKgfBd5mT11ET7VtFHBoETrCvSpXyoit0HwhOK
 rif58x9Cn4fshOerMurSM37B4MuNyMEb3VZ6wEqBD9tUIfePwY+6r+RfzmQzfU5K3nhy
 bdRW7WC8G3yXP7UVueQDhQvsIeFegydxbazKD+i9XU+z8JaNvCc2lh69SIrhKhvJBoMu
 5GZtZIrYUsJFOq6iZE1/jl6wPGTrYyP/aBGFzSNA/zRY9CwmoVL2q5z+DOWtkLe6/Yn/
 5hJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QqnBBqN2ESChtUVo4MFZQtWBzL3btCWg1Ev24NoTf/0OR2MbQAp7YtDzkYHJx9a+Ke61L7Ks=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9GZmq0HJcn/+vw2oPKQ5CYy2qgbWVG27+/vc5S9GBIPIzDmbC
 0yMgEkIAERcM8ritiLY4KAmJyY4l8257x3ztIiLiD2OA+JZCQ7+FBK4q
X-Gm-Gg: AeBDiescKbTsgeMDN2BWnhjjQb2XrU48IGLbCpF+KQiNr0W/oPTXYZUG6BYx8Qj/M+b
 5AHjC1q38r64VbixfBDlizMb4VT8hI8311BLhbEyPenYcKFcSbADRCx7HiGt4svyYuQPCVtJPJb
 VV5++58hXBwgLvgmv2nDNSfi36lgpw26dAOrxdSPp3Mvuw3BCgXAB7hLqHZkLh9Fl6QTHvVSzt5
 nGDyd5veCdtwKSDhEJOHkd1LjRk4F/FnhVgV4sIhj+LYUjB00DsD+zBousBA9Nf1zsltVy5ysH8
 ZWrkj+mpOB7LHS1N5pOH8H79ub7UdgDijLajT6XywJAiSA/mpA9htJCb8LUTkb2JiwFAhz15biH
 vSAkJ2GVS8IZfMfW2FAodrZUe2ZD1CYtVBhcIrAUcAOwDehyWa1DGfltb0EmPnZYNW8T6MEOHV0
 YJhNHrd3Hwhg7J6t21rLtIrILKgRMA/KIXj7t7zyaEFMGWWMvvL0DURaZJtNVPvLrA6sAZlHfyJ
 UMKdp7nqg==
X-Received: by 2002:a05:6000:230e:b0:43d:7a97:78a2 with SMTP id
 ffacd0b85a97d-4464aced4b6mr13087425f8f.28.1777453989149; 
 Wed, 29 Apr 2026 02:13:09 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03?
 ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c22sm4314395f8f.28.2026.04.29.02.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 02:13:08 -0700 (PDT)
Message-ID: <255b4c39-eff9-46cd-9e18-8e1b47ecabac@gmail.com>
Date: Wed, 29 Apr 2026 11:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH] board: stm32pm1: Fix board_check_usb_power()
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Kory Maincent <kory.maincent@bootlin.com>
References: <20260414-fix_usb_adc_meausurement-v1-1-8cdbd4c10dd8@foss.st.com>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20260414-fix_usb_adc_meausurement-v1-1-8cdbd4c10dd8@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 4/14/26 11:06, Patrice Chotard wrote:
> Depending of plugged power source (computer, wall charger, ...) it can
> happen that we got the following message:
> 
> "****************************************************"
> "*      USB TYPE-C charger not compliant with       *"
> "*                   specification                  *"
> "****************************************************"
> ""
> "### ERROR ### Please RESET the board ###"
> 
> This issue has been detected on STM32MP135f-DK board.
> 
> It's due to max_uV and min_uV value are initialized at beginning of
> board_check_usb_power() and can then be used for the 2 iteration of
> adc_measurement().
> max_uV/min_uV values issued of the first adc_measurement() iteration
> are used as input of the second adc_measurement() iteration, which
> can lead to incoherent pair of min_uV/max_uV values.
> 
> To ensure that adc_measurement() returns coherent value for max_uV and
> min_uV, initialize max_uV and min_uV at each loop start.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---

Hi Patrice,

Reviewed-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Best regards,
Raph

