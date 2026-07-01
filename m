Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817E5C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37FA84B20;
	Wed,  1 Jul 2026 11:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gj6vrE/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F2D84B42; Wed,  1 Jul 2026 11:43:17 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F27084AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4631679f204so941911f8f.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782898994; x=1783503794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyozbdQNxz26RrdKV4xjchd/kkIzLheulWEgk4HWYTY=;
 b=gj6vrE/VwjANNDKbxazpQNFjeALMym/pHvItA7rpIA85PAfsMHKh91qjzlV/bGjH2f
 rDtMa1Mu0P+BjeURUJJE9NtgPGLhEr56bvpVDDIWZAT91mq7ZDHfJKXzBKFutkhzu9fb
 NvEiwSaQ5Bh7y6wnPI48XN8T1jmi2W6knz5d/CSNpa3sL+chVbUQuhrmWr2R934r5vW9
 vSn4StpYZsKZ+dh/DGRWkQbycaUUHuL0K4lr071IczrKb2ha23kDY1q66sLxycLJQoVe
 H/cZ3Mcvhqqc+9tiCo1N+kBvoZmOoCUGWI20jCMQU7h0In28FTjQhdmGI7JsiULoIWtq
 8uEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782898994; x=1783503794;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PyozbdQNxz26RrdKV4xjchd/kkIzLheulWEgk4HWYTY=;
 b=d07Ua7QCP76bpMpyGwahPYslTKLOjBPRTyCE5H4JG6T9WONmXF8yAgXmuwYZh22QEo
 +KgykH5/bdZy7ih9QDCLSzeI/fO6FvqVzWvj7ziqLOZIMDX4zBqnfF2ePwGcq1jBpnzA
 IU55ENyrvAwPZG9iH2vQzlt5eYJ1N7pb8LhTG9DZh8P0Z3IWtK/djIry+zereGWHsUH6
 sb5jPNL2lrvq5HnR59bzNJqRz5nvA6vKAfzFOnjQZ5+g6B1Vk+OugG6Guf2R+k22dsww
 u5OeXzhEfmE7uBe4nWdkm+/UFMeFa6/+XETDj4C+Z5H5658Ek+z7yAT3NYH81J7oB7V/
 LcgQ==
X-Gm-Message-State: AOJu0YwoHRMghYGYchKvyy/d+kcEOz/zuBLT4LcQ2Lp9wIrEEeG19zvB
 py0sGOEYBouPNfCbBEGm7LwWLxmObh6iT8wrYpPoicsxR4qXaT/f9UW+8q9nZY+JYF0=
X-Gm-Gg: AfdE7ckbHTdghBqQ/DayRONGgNQ2e/KQ8LHfjTwRX3K1ejxI7KGMn+4WqLabGPPmEIX
 ySPKRvJVQ6Jf1X3DPdNVgDHW78/vA5NNiQYqyHPUN6scwHziGaP1EzwA6SWjq+2aGQ1zR6ddchr
 DRkSAI5zPAUFYdhHZLBYzlqRrU1SzWitdyQyuW264TgmwpUkBN1CK6Jc8AwvGjhQa5akfKhyvgX
 VjGyRK9P2iHCeWNWEBqY6l9h9v2fhFhaViMzM9vo1pV7TC8on7im6BxdTanQS1Fi0RKQi1p+bYp
 OVIdq5GtCfYYwa9X8RjjaS9zQsKUbmszm0cuSHWNq7/UjhK024Vcip6WbpzHBryaB4UDcBwrPYI
 SIqGgNuqT2NqepxEkfOSBELInMsXD7h2z3iu4zTQXIybZw5CJ0ihMphWVhwBgCkGtyBxrxJ+AXL
 8nuMOXv1Xn5SPPj8Pl84xzNuF+ZkJMbsPzZQ==
X-Received: by 2002:a05:6000:428a:b0:473:f047:4f with SMTP id
 ffacd0b85a97d-475de54e1eamr7914295f8f.8.1782898993747; 
 Wed, 01 Jul 2026 02:43:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d195a7sm15303193f8f.7.2026.07.01.02.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 02:43:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
References: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
Subject: Re: [PATCH 0/5] pci: Use dev_read/dev_remap APIs
Message-Id: <178289899286.231883.1738985232351249708.b4-ty@b4>
Date: Wed, 01 Jul 2026 11:43:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Tue, 26 May 2026 16:09:08 +0800, Peng Fan (OSS) wrote:
> Convert PCI drivers from legacy devfdt_* and fdtdec_* interfaces to
> dev_read_* and dev_remap_* APIs, enabling support for both live device
> tree and flat DT while removing dependency on global FDT access.
> 
> No functional changes.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-pci-next)

[1/5] pci: rcar: Use dev_read_addr_index()
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/f657eab9bedb0b7ea32857345fffb8c3c68dd6b6
[2/5] pci: mpc85xx: Simplfy code with dev_remap_addr()
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/9b6f2786aafd5247dd748e127ea6a01038b09b42
[3/5] pci: dw_mvebu: Use dev_read_addr_x APIs
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/06fdccbcd8b3f5eba2788ce5cf4a5fe39e91783a
[4/5] pci: imx: Use dev_read_addr_index_ptr()
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/fc1016d6838b9994083062a42a4ba530a85596cc
[5/5] pci: layerscape: ep: Use dev APIs
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/57abbbcc945079404ba8e3d4a68c991e3cd92a65

-- 
Neil

