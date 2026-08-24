Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A83C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99495406C7;
	Mon, 24 Aug 2026 08:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WtJ8QwarJjHU; Mon, 24 Aug 2026 08:52:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561547;
	bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VP1UWN+Rt744rDWYlGSEnNGuWp0bP7L4BnL8zARzJy/sl5YwYP9gRbmHDVsYNOyGf
	 lWzr2Ip44BXF5NZBXWNyVT8lR+GNDgVxPhLAOGsMJHcitTXW6P+6YnEjy8YYoyBSXq
	 bnDAYWvu+72LanYgeUcUcxtxycVkaNFfx1uA0dTjZHHfLIUfAnNSfEzn2VJ1A9Td8w
	 mKUuo86uwWQm6BA4oXawkWJC0/ylecQgL/+iZDIx7m7kGPfZj6wZ4/GnA9py2jquPS
	 0lUOT37coznmr6Fwwdsim3x1gdBLatHCPH7t5nPa8UaDoXBHt+hVOSYzUsUi2WGv4f
	 +TL7qre7iv5UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0CFE406F7;
	Mon, 24 Aug 2026 08:52:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 78CD4230
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A7A9406F7
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W_L11Ae5038s for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:52:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=nCZmpV5x
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB2E540719
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:25 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso2649115a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561545; x=1788166345;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=nCZmpV5xig0T7yMZyEuiSR8ynpN9L8qOdpP+QlcBpOvl8QavbqRH4GJv29ofS7GZXQ
 jPDgGOxmzbGM14h9vnaqjhpOno4d/3JtgimbT6ZHTPe6CmID9NvzUHSfxnjodZJN3fa6
 uIPhqYs2bz+Vc2J8CEoxLTf7P1t0FCicwhzvQo2yu7MaGXq0fz+z7ZjqsC6DB2bVR9wU
 dnewy/Dz3XduVhu6COmjk7JAki7jgt4vO7YeLUZdr4j4xg9uCOIwnYWf3RvOHjEwYrrZ
 8++OGfino7KWrj+myu+msVEBMt3iFfvKrUjiSBNuajlHELMjyyp735D/x3tZirIHvXlB
 Iqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561545; x=1788166345;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=NZyBOQFlrSmwjPAKmfK3McY+QgVH3VEJZBfgcFTo/mITeB3KxvaF7tjykkk5IFf0d+
 q8hs26G0fnVoawRS3e1fXqYQXdsiBwKxFDI81NnQ3XPZgdc3fVlQwXwW4uHmTbAjctqu
 LwI99yvlOhbE6lxmU6PRnmuvttNcuew8XRIHdBtcvHSL+2UwRYpHMJFTMOLwDdYg0VGC
 sAW7pxfdOBXlt/Nznee85kuiILFIIOOqdNSRNyhLx+jXHkzGZQB5Qk/l+5JWxDb/3qLh
 p/XGI8nkYP93srHjHf2ohfm71hHvEyBzfuOdzKEJg4ggL2aOHYV1XjwJuuUouwxfRCqE
 rNcg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzORVmzezAn82ZYUdIjvO5eT49XozSaZLBZPq4L1uU9pKU/4q2aWrZKVC18NeTh20WCo1CI2s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mcHZEY8+bc9WA6Lwn8owNmE+mxBTqGHbusIOV6r1Z22vqvyvo3
 vI/HRYCO1utAndyYeJwSuVLDw2mh3dxeXySAJG7KikYzG4Am/3WauSDuMBvpYVR+SgA=
X-Gm-Gg: AR+sD11KVtUxk94SlMDMPMI/vKByGrOkH1QCZc3l/1WdVWZttNWMEinhDFSzInGrz7Q
 3xLnz40RrDy7lLCB9jRFLNHvUpxBDtvRMNt8wD+xoPIKAdl/5l/ehNx+WT3LKdLRI1k/stsLCrT
 pYy3PsctB92S6OjV8xkBnDglzq3Uo8CWC2Lf1SdKMfZZgk3ddMaoCtuFApgLxcAqgM5gSigO8bu
 SeGcx76k/FiyZiSugwYNEsWrJyCjrsdf8TN/tzGqF6F03mm/QrTzvUPXMcl4w+k/RSduEe8iTQF
 XK2tn8c98ouPNRUkVcIXd4NQuwTeBZGOxf+GsSURGRDj2ZpX2dqQOGov4TV9ejmxheAWJ/x6Lc+
 rYLERgwNG9WdM7qRTR15zM3wDFqQYeTfN2MF7RCJF2UcPM1Hr+fNjkwqiF8JAA+ecdOhKVPfAjU
 bmmHDVvr9UGWpzv5W5iw0oRBWOo1hJhqEBQ3upq73ISwi6aTbdtRLl9w9p17pov7BYvG/8fKyGa
 3DE05TJ+M8mN0APUFGLfP2rNYcTEXQ1AdJ5DDh3OXtD3tcvGPgisSx+bQpUf+VLDORyiElMejBc
 cmbhp+xP0kZSMT0lZkL4IPka+g==
X-Received: by 2002:a05:6a21:482:b0:3bf:9bd9:cf60 with SMTP id
 adf61e73a8af0-3cd14d30051mr38069896637.6.1787561544925; 
 Mon, 24 Aug 2026 01:52:24 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:52:24 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:50 +0800
Subject: [PATCH v10 15/17] MAINTAINER: update Spacemit K1 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-15-5e0adcb1edb9@riscstar.com>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Update the maintainer for Spacemit K1 from Guodong to Eric.

Add mmc driver to maintained files.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Add mmc driver to maintained files.
v4:
- Update the maintainer.
---
 board/spacemit/k1/MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 32d47ecc8f1e..4b2bc4ecfc10 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,6 @@
 BananaPi F3
 M:	Huan Zhou <pericycle.cc@gmail.com>
-M:	Guodong Xu <guodong.xu@riscstar.com>
+M:	Eric Chung <eric.chung@riscstar.com>
 L:	u-boot-spacemit@groups.io
 S:	Maintained
 F:	arch/riscv/dts/k1-*-u-boot.dtsi
@@ -9,6 +9,7 @@ F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
 F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
+F:	drivers/mmc/spacemit_sdhci.c
 F:	drivers/pinctrl/spacemit/
 F:	drivers/power/pmic/pmic_spacemit_p1.c
 F:	drivers/power/regulator/spacemit_p1_regulator.c

-- 
2.51.0

