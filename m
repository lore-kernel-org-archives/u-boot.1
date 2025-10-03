Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34EACAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 22:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3D283906;
	Sat,  4 Oct 2025 00:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KFv+P7ty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE30C8383E; Sat,  4 Oct 2025 00:57:23 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A732D8387E
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 00:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-930a6c601b3so242324739f.3
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 15:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759532240; x=1760137040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPTfIBJZnu6g5plR1uol5ueKueWI62P5+/ReRfYzr7I=;
 b=KFv+P7tyZND74mL3+iL8Vbr1xiUB1VnGqA4GsQ/mJJLxkO3ca8uFoj9n/dVdtT9xf0
 FUXINFEheeIcuSlb/ka6KobsALJPBTjiNgYgNaqUp2A8IY58KjbCH1paMr3Rd4GE1rp6
 71cTf28qtxvbAi+YOGbXofYnQNZ+GfStMIQtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759532240; x=1760137040;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPTfIBJZnu6g5plR1uol5ueKueWI62P5+/ReRfYzr7I=;
 b=L07k8ZBMXH3AAYnvMAbx/wZ1iqjuCBGkvqv66MuuyHwCPjL92QSM4Sbj5lS1h8rsXr
 LPtis4bkQRo1MTj3741OQl9J1sn8pVEOzSYvXQynQ0aSkd7wkfWJgYj/pc8oNAGW4MyX
 92UGrtG3R1hTlQ+TQaxzoshQ1XGFSE6hFFfJJISPlqYVyuSnWPRCv5tMfLeWtek3c60e
 yUR8tS7lJ4u5lWBUDYPD5uo2yAT9y3x3qY1TNvLNSOD1mpnJZiQbylg7tgI/SkqQuXqR
 oGdcU+WrXmJIqt4FP4bgZaVb25SO9jemXl2CYyCDcUMFDBRlC3fXxLLMDp3p5x5KfuxE
 oY+w==
X-Gm-Message-State: AOJu0YwwAVJ0j29bGn04wEQ0GHYm1vdlVG8jjLMZJ6a8hqMC7XEPCryS
 EKx9NskMknyS9Zd9jW7uJyiePRgAPT4d0iHBeEH5oBMTTR+SD23MSyBex018JobEVCE=
X-Gm-Gg: ASbGncsR78Hxr1ypPWf4jKG3Qn55E4WzLdFKN7uz/oVLesXPLZq6oGaFpTrfZMT5c6f
 692DZSZtuKHcWjOz6Jer/+Ge5oD8HhHqemygCflQqLRV6zmv7pICuz5FIytJCEoweyHcESRflXI
 ZqTKcsTLVPRWLX4CFSkZ6SSNAfhsPU6lTOrK+3nr7YoQ/aymiAxWug+9M0rZN5WF6TKfNpQfNPE
 XfMR0jz3J271aO6I+sKi0KJ2N5ujv9GlMcXVwpzPc3e92QUW17V/ANTej6zwUZ7ealBZlZQYUUV
 TFlAs9TINRkozy0tXa0galsUAUHQOG5zAnROC6XXC0h2ecVTzLokIXpOcUzk7gGwArZepANFTv9
 APMUORFPMDPgDp5tvnBdF3Jq1jDsgNt0Pg14nZPrVZcQbYjFjVH55eP5Ld88b3pTAdZELaeHNBP
 wYNtaAUN7qG8loVkbjYP0QcYBOJs1R4Q==
X-Google-Smtp-Source: AGHT+IEHfFWgNQZKDfrY71En71E3Y1s3ZTa4acSPk6FW1wVH9C9dSTkqjy9+3lbklSl7mjPk7qDe/Q==
X-Received: by 2002:a05:6602:340f:b0:936:dfca:f7b with SMTP id
 ca18e2360f4ac-93b969bd686mr579173339f.8.1759532240421; 
 Fri, 03 Oct 2025 15:57:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a7e3a3ae8sm231743639f.7.2025.10.03.15.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 15:57:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, nm@ti.com, 
 robertcnelson@gmail.com, w.egorov@phytec.de, francesco.dolcini@toradex.com, 
 ggiordano@phytec.com, m-chawdhry@ti.com, afd@ti.com, bb@ti.com, 
 u-kumar1@ti.com, devarsht@ti.com, ilias.apalodimas@linaro.org, 
 patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com
In-Reply-To: <20250916112205.238811-1-anshuld@ti.com>
References: <20250916112205.238811-1-anshuld@ti.com>
Subject: Re: [PATCH -next v1] arm: armv8: remove redundant definition of
 mmu_status
Message-Id: <175953223736.2203583.3040246467628197482.b4-ty@konsulko.com>
Date: Fri, 03 Oct 2025 16:57:17 -0600
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

On Tue, 16 Sep 2025 16:52:05 +0530, Anshul Dalal wrote:

> mmu_status is used in io memcpy functions to prevent accesses to non
> 8-byte aligned addresses when the mmu is disabled. Though there is a
> redundant definition enabled when icaches is turned off by setting
> SYS_ICACHE_OFF.
> 
> This patch removes the redundant definition, allowing mmu_status to
> properly report the status regardless of config settings. This shouldn't
> be a problem since access to non 8-byte aligned data can be done
> irrespective of icache state.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: armv8: remove redundant definition of mmu_status
      commit: 8fd3768ca1683b45aeb5662094de6bcffdb7735b
-- 
Tom


