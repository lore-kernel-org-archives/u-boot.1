Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9F3FD4F34
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 20:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D2E8415C;
	Tue, 10 Mar 2026 21:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WtJ4xPlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF2583FBC; Tue, 10 Mar 2026 21:45:37 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD1B83FA6
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 21:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4671cbce465so867082b6e.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773175534; x=1773780334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AXzxGIDNjG8FA9xCJU5WzT8ChG+BZK0Bx4Lmg1Ho9g=;
 b=WtJ4xPlCh7msdMwps6xZeV+LPU5nuj357ISfSkLazFaGn0I+iXs3hIqa3G/8m53811
 nbYz+vgM+qi8ap5F2lIwAeRBC1hfgQCFUFKqfrKCRCX/HwB4Vgj++P4BpXN4nhiQ1vkD
 +a/L+SvIFH1qfVl7y9yBKbv9IX15JSJhlgKyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773175534; x=1773780334;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/AXzxGIDNjG8FA9xCJU5WzT8ChG+BZK0Bx4Lmg1Ho9g=;
 b=q6xmgV3JLH563crurbUSzu9WjslCv2o65kJ/rF31RIW9JIBQ+CdrGeHL+oJA1adYym
 kjGp374jbonvxn1oe1/f3kmEeQ4Bro/ymz3SlkuoVkVBry8g5QCl1gJ9D0QFyXomAXgd
 RsuGR/eF3Oq4ScHkWhMx7ZwhcO62NJfeCYdJV6iT3QEbXBMIi0N/E4dxbTfzb9I1KgIS
 FT/c2GnAnolTz/aigL9QafyeUfcd7DaRJ20Xizw+VPTrTf1IRKJ6az6Z4CMNLUB61fuV
 JepkGsAC9oBqlTeR10agsrSwPjKyb5hiEBP1aEZvwF5FFpSkz1IsYHp4M6gNHQYtEwzO
 PnFQ==
X-Gm-Message-State: AOJu0Yy7AbNHiHLhYJflc6LuVhO2VGe9+XboRWX+fqxqsec0JmbCaW2T
 Aw5QK/vfatrvJndEIhM55sQrLtkqrHmpwX2Z+81hA8kGqoOuk/LGiqrKW/nJ9EmJqNA=
X-Gm-Gg: ATEYQzyJDIjrHd0VYvgFcP0ErUGf13dPb3dz2wZi2tr2odnecu6CFL5alvF67K4i22p
 Gj4I12qherl/RPrL5YKVkkTGby61ET0tHKLTDaQuU/60ET/87OsdeBp0xUGtbmE2sh0p793UX2F
 fiHdZHJ/tYsYD8xzss/P/Oc+Cq2vjIGE91G9iNfxo1aWx0ZVbuKsrI75Ywd0aR3cW8jcfAREtYE
 txPTPXQt/9HmNtvFuhmMNGyNUS2qC0B02SisXliDwyEvSRsYIMTe1JWBtBdfVyOMSNHxIHFiEaq
 0xpVMWW2gUcLAzhCtNVm2PMxIyFeIX81ylpv3Q9RAwqDOh0JbHMlBzCnSsy4FZbWmBQvH06PAW2
 GEVvGL8iXaUV6i/8TExTt0J5/yCLxWParsUOBllE6YaqQo1WvNazpMS4zUUDEP1YiNPicHZ8+ue
 ToFo5t8J0y/U/6g+xfITPaLf58pHTyvgdCjvEz1uYi857fSnxWpXYZs6OkRjQKplTuJlmVpPPgo
 61cXpiFNARkrA0LD89ndZYeNPHspj+tfCNh9cjRZU+M
X-Received: by 2002:a05:6808:1304:b0:45f:27e:5cb6 with SMTP id
 5614622812f47-46733469f30mr55554b6e.19.1773175534168; 
 Tue, 10 Mar 2026 13:45:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfac3acfsm8256086b6e.16.2026.03.10.13.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 13:45:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, bb@ti.com, Shiva Tripathi <s-tripathi1@ti.com>
Cc: u-boot@lists.denx.de, u-kumar1@ti.com, praneeth@ti.com, kamlesh@ti.com, 
 vishalm@ti.com, k-malarvizhi@ti.com, afd@ti.com, anshuld@ti.com
In-Reply-To: <20260225112438.1035185-1-s-tripathi1@ti.com>
References: <20260225112438.1035185-1-s-tripathi1@ti.com>
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
Message-Id: <177317553318.23044.13643896894203476698.b4-ty@konsulko.com>
Date: Tue, 10 Mar 2026 14:45:33 -0600
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

On Wed, 25 Feb 2026 16:54:38 +0530, Shiva Tripathi wrote:

> Enable firmware TPM (fTPM) support via OP-TEE for K3 platforms with
> MMC hardware. This provides TPM 2.0 functionality through
> Microsoft's fTPM Trusted Application running in OP-TEE secure world,
> using eMMC RPMB as persistent storage.
> 
> fTPM support in U-Boot provides the foundation for measured boot
> and disk encryption use cases.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: k3: Kconfig: Enable fTPM and RPMB support
      commit: 8bc2a5196c1c0bb5dbdaca073323da0015a0de37
-- 
Tom


