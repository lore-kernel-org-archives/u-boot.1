Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A237C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C76C94096C;
	Wed, 22 Jul 2026 15:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SoDsDIpFLrUe; Wed, 22 Jul 2026 15:08:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E8B440908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784732887;
	bh=jcMEK/A+nhuTPcZIfebG/KXp98LjP85fA8Uj5Lp+9oY=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gaiccM0BK3UU2JTD5z2l5MH5XpF02INLgHvl8RDOtjey+1qGBiW3xYYttytHq6WKi
	 tnipgKr7gYDK3W6silqnfdk0Bll5xVX1YyzVSHjIjCb+A90IGCgfGOZP5kFqA0xFZd
	 +wyy1nfh2TZSv695pUkcP6xzxEz0tkncMulGmoH0UIvGQDeIqTYXLLp4wNb7TFMzn4
	 IH1gh+UI+FnASJouC4W79XsKWFWnvsFfB1Lg/6NOwkfzGH7qkPDsQxIcUlZ/PfrTfU
	 adhuK8Y7loGbO/BhEJAhQqDHD/JtHld3gXeKI75c7/FVKIK5fslcGY23/UgPh/IJeo
	 C4vsDGJf1/vmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E8B440908;
	Wed, 22 Jul 2026 15:08:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 10C4F313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0320D40909
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:08:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ztvmFqyqwBm for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:08:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B42B6408B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B42B6408B0
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B42B6408B0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:08:04 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C61C8494B; Wed, 22 Jul 2026 17:08:03 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3878B848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:07:57 +0200 (CEST)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38e071ed6aeso8332284a91.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784732875; x=1785337675;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jcMEK/A+nhuTPcZIfebG/KXp98LjP85fA8Uj5Lp+9oY=;
 b=DkVRLgCB7140xI9zo0JtPI+xFOe1BcSEJ57hfwjtmCPXZcUxQzvmhV7TmdVgPU0HrK
 M11lAZPX10b/bHKpiKU9hTHtA3f7bJwFuS02ZaTJOLnLFI8p83wHXN9uIbT2qakqcRQt
 4AcJRtugJaiSBHRkIJ4Dug4HWDzqIcuKFAzD2nzD34B/Q3W+dH4tijjoZ3aaMvODaZ0c
 nhuJhybRcfaqlo2wjWNM5fsGGKoZAnU1NduXr4YQNnTTzbvXqx5op6761J8DWcULMEa6
 /qwjdmlcMoAtR7H+I2Epah4cWwJIw6k+DtJoextCvhmFxO6uT1eguiumenkHiiAl3Bpp
 z7KA==
X-Forwarded-Encrypted: i=1;
 AHgh+RowwK7teh8/D78WSUnng6JH7IqbkRuVkwcxEGe4V0MJhS/5ZLJaVE/J6iOqMT1STjoieoN8YNw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5+H93cXDJnTDqsjSXgs3jCdrRo9Jl0WcLSR9W7Dq4JhLuZ4IK
 7nYsKMgayeZXKfT7hTRG/LZ9A/AT8YXmTOZI6QZcMHT0gm/UJ1Gynl2tYtTdm3fMCFw=
X-Gm-Gg: AR+sD12SWWcOzs34YkEOPXhBNbnR4XzuOPbSOZvAZiEfJ+3hhWVlh+9rNohLOnFXUWn
 0QRMFwzomfbu4OJvq9+uj6hA6I9ELLNVuqfl9DMWYMyUiTMZzwoihOJws1LYRtZFEzwoRz8MGsj
 g3JfbiwHtKGJvY1LcnGcyiS5fb7mMdYggOdIyAPNwmor+Wb2a34xfsQcRm0WamJMXvvq2+f6QC7
 CnQ04pCIKduSt8h7DiaLctwEn+nuHr7kyJsmlx6wAhBDXk3wwI5rvEgbeq479WwhyOnDS4SLSpW
 wCIt1l9gNiH08UNx561b01A5IZfzrDPushWafB0SI3PW9r/yxccbSK8vDEei4oni4CNpBewb4xn
 0mVJAyB0gQ1uTZyPKdXVylVAiqE6Xl5LmqcTd1+hidS1F8SzSnSv0uheHDxmGxHyLjSipPGKQTk
 +cQY35/78Zni3HFJdB2zSTBFe0bYNKoSBz/DR4fDw9wmG1QHDpRMCButhGMqavxfnBujzzeQzAI
 QqggBRnA0RPp0EFEXVZMiSTYmJ52sy2P57/CcNSwgM=
X-Received: by 2002:a17:90b:3a06:b0:38e:b3fd:d582 with SMTP id
 98e67ed59e1d1-38eb3fdd768mr1318117a91.39.1784732875528; 
 Wed, 22 Jul 2026 08:07:55 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e088d3fsm10622267eec.25.2026.07.22.08.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:07:54 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:07:02 +0800
Subject: [PATCH v5 6/9] MAINTAINER: update Spacemit K1 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-m4-v5-6-c41a951e5157@riscstar.com>
References: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
In-Reply-To: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
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
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784732875; x=1785337675;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jcMEK/A+nhuTPcZIfebG/KXp98LjP85fA8Uj5Lp+9oY=;
 b=sDzvpLCNai6X5OvZ9PvULfR48mbIdn+h8VvnQcZ8soEO1QPpvUYbQRfDk9CQ2RkRK0
 K1dQusk9CdkpJ6qAv6L3pZyOF8tjaOoSRRbRqvLDm/sBB9Q0nMcv1o4XNv5SCHPWLalI
 k3KyC2PTmJgxADSnLPvCpiLRvsr7aTPyzeZsq2kTRIM1iYGbuG8y+F7/dGDiS1EEm9jk
 s9CduKp1wGWzjhZYTcXcM76sYduJBqF7zhrzqv+HFKCnVoYe6uqLWJHEKWwKQIJ8p88z
 O6USrAqJCfxuozTfIesj5+diD8GZsCaI9+Stn2ocNH9mavDmFr46HEVh9hk9sYRMmr08
 eDbw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=sDzvpLCN
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.chung@riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.b="sDzvpLCN"; 
 dkim-atps=neutral
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
From: Eric Chung via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Eric Chung <eric.chung@riscstar.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Update the maintainer for Spacemit K1 from Guodong to Eric.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v4:
- Update the maintainer.
---
 board/spacemit/k1/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index ca994e2a1fb..4b2bc4ecfc1 100644
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

-- 
2.51.0

