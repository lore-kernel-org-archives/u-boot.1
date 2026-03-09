Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630B8F41815
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 16:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C61983F9A;
	Mon,  9 Mar 2026 17:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F2LmuXx5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD8B83A8C; Mon,  9 Mar 2026 17:57:30 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F32883F2A
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 17:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so11321597a34.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773075444; x=1773680244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtQatWpBBlSU0Lw1MBMEIJf9GE8FrJQc7mo7VYBZDN8=;
 b=F2LmuXx58TzwDuLPUx0WwsWChiHotnKZPFOfumzNiYNhHgMRyksTmLCEjwEp0Wwu7Z
 +iuZH2/U+e5Jw3DYHTa3ZtcMe04V0KTvQ9uEScjf8JQ5jTPDOFFQSwWDEANLX8VbJMit
 x0usHsYn8iWOdCKhfDj7zB5xhZtlih1K/rGk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773075444; x=1773680244;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vtQatWpBBlSU0Lw1MBMEIJf9GE8FrJQc7mo7VYBZDN8=;
 b=cIMXHxYctHRv0hRYwDvGR8QPXYiJLslhpZsOgwgOoPWoKmKlqdDEoAJz3p4Bnq/y+s
 gvN5hHjBpg8R+Mf+x9FcSE8SWR/8f2/JGR84N3s7Kc5Hb77USF6jLhjLXsmhm+SFpG4G
 vr8bdcs2YTaUIruMCvYbKX++7gIigkZHHWa5fsMcP2J+LU1GdmBwf8YHK8IqWMxURTvm
 BzYJnemX9pWeMVB3XGw4NzvPtRLLk2+VrhTPIymJpnrnpWFn3wdy2XmsHW19FGrULFLu
 lRIAYTkAKZ+2xcuAoBtGUePLQhmJFr/Dvz33jVqYibC50PiWUJ1tolMX3rNcg5sSm17W
 dS1g==
X-Gm-Message-State: AOJu0YzRFoC/fquWy7eIrtNxqfACN/o/qMFhjZHPEj4Uem5nvIBWUoBK
 l5H3DdvxnKfmeyVXaa/oB0k1zk7JKiD/+JQjy6pNe6Hn3LPEig5TCZuQMaOh/35e2KA=
X-Gm-Gg: ATEYQzzfqtNmeIw/q8DEqnyTSBEB0/mwIeUOVdnBQeRKKSHq/hQiePghrJDe+mNUN/e
 Be3USDFrpjO2gD/uSqExYKQVl+lN+Xxh/mlv1gmF6yFImATqZi9a+dRBdjfXXKRM1nW0JSxD06F
 odrTJtphLfj2iO8fSSHXgM+7sYsKa4+JrsgXOkfJNlhDW6MHVmWVta7J5yHnhiI5/bb08Yq3zSL
 a9uF2QC+iuDLDmGbm7ds6/iMJKl9fQhgJfeFP+WL6Vw4Hs+X9D86e14bzBlIsks22a3qadaInj1
 s/jUaR/xhwgSiS20jLUJ7rRziKQ4sflx4kuxGi+Qx1kLzdLtOJtbzrGVXhOZqy0TKeQeE3NLbUo
 jOWiTvtTuEIJwgxY1hDWgdF0hE8sd2DI9EYMK3Kn2OCSUk1RbdhLkaSAsIY4lp05Fn3QCScf5e2
 0lzPpy5WYigz2Ae7OxIkDPojtTFz9Y1ky8BinwzPMnsjNj/4/+bWU2lnusVBgOWe+Kcvy+PNuxg
 K4VCwIQhzIY/qoLxU/iac3K2irPKSJEdoTgPkwn7JSc
X-Received: by 2002:a05:6830:668f:b0:7d7:58b0:76a4 with SMTP id
 46e09a7af769-7d758b08921mr469912a34.33.1773075444097; 
 Mon, 09 Mar 2026 09:57:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d74885b5a4sm2690201a34.23.2026.03.09.09.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 09:57:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, anshuld@ti.com, d-gole@ti.com, n-francis@ti.com, 
 bb@ti.com, jm@ti.com, s-k6@ti.com, afd@ti.com, u-kumar1@ti.com, 
 marek.vasut+renesas@mailbox.org, a-dutta@ti.com, neil.armstrong@linaro.org, 
 semen.protsenko@linaro.org, peng.fan@nxp.com, 
 george.mccollister@konsulko.com, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20260227115841.333073-1-s-vadapalli@ti.com>
References: <20260227115841.333073-1-s-vadapalli@ti.com>
Subject: Re: [PATCH 0/6] 64-bit PCIe for AM64, AM69, J7200, J722S and
 J784S4
Message-Id: <177307544257.3622694.6052704761432659679.b4-ty@konsulko.com>
Date: Mon, 09 Mar 2026 10:57:22 -0600
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

On Fri, 27 Feb 2026 17:28:28 +0530, Siddharth Vadapalli wrote:

> This series is based on commit
> 437ea9f8be5 Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab
> of the master branch of U-Boot.
> 
> Since Linux device-tree has switched to 64-bit Address space for the
> PCIe Controllers on TI SoCs, currently, U-Boot needs to support the
> same. This series adds support for 64-bit addressing for PCIe along with
> enabling Root-Complex mode of operation for AM69 and J784S4 SoCs.
> 
> [...]

Applied to u-boot/master, thanks!

[1/6] arm: mach-k3: arm64-mmu: add mapping for PCIe 4 GB Address Windows
      commit: d62f1c98c5e78f4092510992f8174c284e3d1778
[2/6] pci: pcie_cdns_ti: enable PCIe root-complex mode for J784S4 SoC
      commit: 068d05ad5f82a58316e895fd1497cf10898b3beb
[3/6] configs: {am69_sk, j784s4_evm}_a72_defconfig: enable PCIe Root-Complex mode
      commit: 724952ac41c144a8528a273aeed23422b1e2330e
[4/6] configs: am64x_evm_a53_defconfig: enable 64-bit addressing for PCIe
      commit: 430874ce20c78c4d2f427dac34860642f044c5fd
[5/6] configs: j7200_evm_a72_defconfig: enable 64-bit addressing for PCIe
      commit: b04d709459073c6dc48cafd8eed9d14f552fdaa7
[6/6] configs: j722s_evm_a53_defconfig: enable 64-bit addressing for PCIe
      commit: f0bb3940b132d039a249815d34eea6fae5be60d6
-- 
Tom


