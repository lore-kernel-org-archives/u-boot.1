Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42091C55173
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F27EB80E5D;
	Sat,  1 Aug 2026 16:41:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wtlK1jOKpn69; Sat,  1 Aug 2026 16:41:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF65580E12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785602477;
	bh=PH+Jt5Po8u3WCRb9IhAfE0hPEPWjqJp4IyxL9BqvJVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iqSAJ5dfBVCDzO8mrDM6RPA9fbx9OGu68isexQTh8ywxQN0VJ1pVGqAkAaPgpdkbf
	 9azDpddezYKYjS4CcLWia/rGCSAe+JCBGEn777uKLRITKvsEui1PfpdIG7o7IooNbp
	 wJ0ubQlEkdvHKCrtYPI4lm7kzCZwdZyugCYPKjfPoYZc9s2pRY4uwN48ZaTcEiR5iF
	 27GKIGazSgtChkLmQMI7rC99qB6E7Slxl/hfPIEIt6kT48zYT4YmhTRV+OIR08MBhf
	 XaNDWzcnwQWf2IWssVX71iFhBpmB5PHWimiCYTPCbRpfLKmqig0s7vssjOoCgPHKQ2
	 Fr4YhNsjwPI7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF65580E12;
	Sat,  1 Aug 2026 16:41:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A1B53B6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4048040065
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9w2iOCmAQown for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:41:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9D60E40015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D60E40015
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D60E40015
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:15 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so2214699a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 09:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602475; x=1786207275;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PH+Jt5Po8u3WCRb9IhAfE0hPEPWjqJp4IyxL9BqvJVA=;
 b=CFo9bsf7YY77msFbm+emJK0hW5MfuToakpF37g3uDLkgjoEV7S8bX5uNbNTXqPm0jl
 8qgNI1SpymEoCdKSCOVnVjpYHAN2/2FWU35E1sPi4FkzCkQhfqLaf67EmXDEkHUrZEan
 XYhvlooEjPRoelhp6JZXjHHyoQmEuHPlj6e5bPXt2KeClu+8XAeBVDr0v76zY3rGZXT6
 Q1ZHZUL3qLjGio2kwBG6ZS3y1ObUP2jmPgKNijoR/Jh0N2gcIjMDP+AiwNzfcYREN87i
 08bQQ5XZaKFp6SqWnxk3jf5GrzTtu0hqRH8fA/tJVboaGIAClIzydo/p5+SAVUpHzsBC
 XfCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpcbPGGtzY3fdxhZij8P1wwyezvsyVTDo6X6QD6PUtEPjNQPSCsmc2yugWN3X5IhQ+wDD9oNVw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyAx5quSA88BXtLAlhuuKwai2rPFdifqOEY/hWqy42JnVoCzMIB
 sCnFTsqfudjeHWRkp86n/pkcEXimYBmu06Iybe1vY7eaK5V6SD509njbMVC45LuWj+U=
X-Gm-Gg: AR+sD115bsVFuF3R9vae8XQlCRtlrGh06TBjfwPXxdl+LSWGhQcO3sBLs6FHjlA0LBZ
 ocXVh9nJeFrzrykg3Uk6Z3QX+Zr9JHA//wlX7hqbQ1Af83wDuReegUgaJG1BPvZd23wsKYES4ga
 0wRkF15U9YrlY2HN2DUaBmC1YKLa6cthwTu80WqYfBVrQBjDMJdFSbFUtdPbEGKVAYNWHY/N3Qj
 TQH76R0tzzdcn8FOstBw4etnd2t1PcUf5IrfjSfJvs7QYA+PxA0c0Eo2GxMlS8umkuytUtb81ZZ
 k1GS/Hu+aES2Y0v4xBbi8D3pX8IKrCUk66+im60g9ZNJQ6XHFhlnoqcVnehp3FLHBU1P80StwYJ
 GxMgbnsHA8AIebzu6u40ThEqRhFUq45jA9wjS3Ys032BY/03TuS05/VgCNWVm1LesE09qej+OZM
 xaOyK7VmEaRT+vi8BhcIX95DBpULTgj1DxhVIz/7y2W1R/7aqQ27YVeMwKuEnmMI9RNqRNi6gRT
 R4rs4mJcrP1JnJKaoin/F5WyDqZKuqxLbPjhqeccAIodns/PxX7BdzRY9FOgwD8vrPDiffdN6La
 lialaMlbKlwYg71AJ7XG42YJIUveOmO0tQ+dug==
X-Received: by 2002:a17:90b:2251:b0:384:5dbc:cba5 with SMTP id
 98e67ed59e1d1-38fbc4cdedamr3705414a91.26.1785602474906; 
 Sat, 01 Aug 2026 09:41:14 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm14512998c88.2.2026.08.01.09.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:41:14 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 02 Aug 2026 00:40:44 +0800
Subject: [PATCH v8 03/11] pinctrl: k1: fix pull-up/pull-down configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-m4-v8-3-e916643205f3@riscstar.com>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
In-Reply-To: <20260802-m4-v8-0-e916643205f3@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785602475; x=1786207275;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PH+Jt5Po8u3WCRb9IhAfE0hPEPWjqJp4IyxL9BqvJVA=;
 b=x6gUVRf/5hkWHpVZvF6HMhQ1fB+lBhe7u+QeD141IJp15id9pqh1jWx1mNzZ8kE+I6
 KhuNJkZZjzZBDN8jPwTV0nrMSwAGhawSpbjfTEHnpUBnV+o1k+udTuR02EPB/pmo1qvQ
 ncdzDl/HfMLvDYJKYUsDp34osUiAk7NxU0n9T/rh7no3v1etE1ojAAlnNPmjBEz7J5at
 HLOi8gx0V+HJ6FXW3n11vhe7l9sqGZb0FaMsXLGmAoVNcwMl7CZ7XauQzzTWFLYjCO3g
 8+wB5QeuDW5mxwTJ8B3d7qlmYFGtKc69T62ZLjYYPn5Pf1pLcc+LLuN2wBFK12vEtQbr
 7Kdw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=x6gUVRf/
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Fix pull-up/pull-down configuration to honor the argument parameter:
when argument is non-zero, enable the requested pull direction;
when argument is zero, clear all pull bits to disable.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Simplify pull-up/pull-down configuration by using a single
  clrsetbits_le32() call.
v6:
- Fix pull-up/pull-down configuration.
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index 6ed511879daf..4e65fad1e8c5 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -409,7 +409,6 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
 	void __iomem *addr;
-	u32 mask;
 	unsigned int io_type;
 	u8 ds;
 	bool found;
@@ -424,12 +423,12 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		clrbits_le32(addr, PAD_PULLUP | PAD_PULLDOWN | PAD_PULL_EN);
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
-		clrsetbits_le32(addr, mask, PAD_PULLDOWN | PAD_PULL_EN);
+		clrsetbits_le32(addr, PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN,
+				argument ? PAD_PULLDOWN | PAD_PULL_EN : 0);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
-		clrsetbits_le32(addr, mask, PAD_PULLUP | PAD_PULL_EN);
+		clrsetbits_le32(addr, PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN,
+				argument ? PAD_PULLUP | PAD_PULL_EN : 0);
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		io_type = IO_TYPE_1V8;

-- 
2.51.0

