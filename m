Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CFBC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADEBA406FA;
	Wed, 29 Jul 2026 14:49:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4FyDKJvxuFe4; Wed, 29 Jul 2026 14:49:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73E164080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785336575;
	bh=uJQRrMlbLg3+wVrYNdX20krCDzsw3oKumSiqJW7NJ9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aoeORf4t5m7CXrYQnKX8R3URWoj+j8JyW3iSuxIljDBw3woLdZwcQKtodOzj3wwAC
	 pTq6TKyud5RhF1jRcAfSwL2YbMjp1cK+bUzhdcNQcxlfryT/C4m4CUORTeDvEsnkHb
	 eWZy5rldJd8eKmohPTBU/lty9ayEpCFXMWeeY883udMtt8aBJMqVPKwR4J3GjSxRWp
	 YUF4L+X3iE10N2z7R5ZyLfujU0klw7D5wVl/nZQU1k/2dVt2mfmwrHiatzXv4fWAa1
	 Sh/7QoX2nCPO/bxRcQhAs36eB1Lh3fLkNq/zNqsSXc8sn2FVS8t/2UGoOQJKKEneGH
	 g0+Q16fHMi05Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73E164080B;
	Wed, 29 Jul 2026 14:49:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FCB5788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51BC56067E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V2a8-ahdv2jR for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:49:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A6687607D5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6687607D5
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A6687607D5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:32 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38101f85591so1965525a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336572; x=1785941372;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uJQRrMlbLg3+wVrYNdX20krCDzsw3oKumSiqJW7NJ9w=;
 b=KjbhmGcBu2kifJz5Ik2U7CIqSaP2XHChF/8iADoCV7GJJa3RQBkdEGd/ZO81WLdxz1
 IP1VdUiMUtw0BT2KxbaOaAl7CCuPZ4lzs3PV7T21MheoQd0gKKzrNOiRJ/P7Ytry0xle
 0oigY5Ky+bpUcW1fJqaGa1H8qy3IdMomZmGe4j3uiQSSMwJW5Y8FVaDfIIP4NdeKq+Z0
 KFSqzvNs2i74AibHGcj1zCUsp40bx35W7y78ixEr/LoeVUGJdQX/klUY7PJyHqUBt0Th
 QqUFsd4kQM4NbrHCLk4qGwiLf7gKTkZDQlEOV86/RfD0gp0NnfVBKfX8r/YW+6o1T14f
 m8mA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5LVaMmgi0W7+b6+Ls4cX9vhZcUzSvMCUjGW36weCFh5GyNz8L39pVT5k/ktCJL+9883wqH74=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyuOCD0Ofrp9bfMY/Csn8AnkRDKvBY1WjfOSXNh2M2/z8482zHd
 9w/kuP4KGqAwUV4TGP/434yw8I48vWKBWBVDZ5Hd1a0bU3Ew4lNRtjMTqoLR8GIDydE=
X-Gm-Gg: AR+sD13iknEZWNKHY3vhJkk1Cyuqb5HxOAAkjr9ecxPgy5kvd2RaHjVTvLCJ4alw7Os
 xQ6Ir8yk2ZStK6nP3q77TYQfp7wIHFXL7aPnvJP4mY7Xf46VtoPeLCXWCAjd/RozxyDPcD7Soqc
 GJwIG6iX4d8VZU6S21MtZ1bg/fAYy2ojWMQxQf/NHdIpO1eORxFg1jHM5ZIv3BDwMAPaQYhvW0l
 Nnpf9W5K89Siou9hFSv+v7EuqE5g2Yez512Ne1/tT9SEauZ3HyBvs7Y47rJls/Eqly5XmYRD+CZ
 hp4dzR58dMvR5oV8imsrFGdlIUhRvVDm/K87yDaEgCO/yt4od3ayI1TmzECx5OxCUEMZYZa6QBt
 NesagLW0yRFEaqAwh0qeo0pAPIYis87VDfUaNvc58q5BTluW2wIFPzw8KEUhc92AhQ7AkHevLeO
 FJxuGuRMaExWNrXDDQZvz5n134p93+OIH0tbBv67BXeIDiopmQi8SlmhRmjeEr4FzbIdeg4rT7i
 QbzG+W0N1ftLr06B8n2yZK2M4RNCJ8/3WOQgxhEGHii5iD5XKsfaqlo6rEtS+5L2c3nIZEcZEz4
 vd5Y/6PFy+7xpBGWjOnS8Vt7hA==
X-Received: by 2002:a17:90b:1cd0:b0:38f:a81:15b1 with SMTP id
 98e67ed59e1d1-38f836f1a9cmr2664917a91.19.1785336571897; 
 Wed, 29 Jul 2026 07:49:31 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262c23bsm9320192c88.1.2026.07.29.07.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:49:31 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 29 Jul 2026 22:48:26 +0800
Subject: [PATCH v7 08/11] MAINTAINER: update Spacemit K1 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-m4-v7-8-2cb04b4fe389@riscstar.com>
References: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
In-Reply-To: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785336572; x=1785941372;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uJQRrMlbLg3+wVrYNdX20krCDzsw3oKumSiqJW7NJ9w=;
 b=LelrFfNXRkq9AFl6Bkqatdldb4ANBbT4TWh0oD6cTkj14rNCu+aD1spDNPa0K6YW5m
 08CvLDrEPe9QlzNrhmgBklmI0LaeMwWfmugtvX0PPpl3eyowQQlExRK1DfYXfTMaOh3g
 xxqxgxY74nbprQ1YVMjnygYdRbPFDJwQS74ZMNMt3yxqrwBvHUoDO4OFMDsHmNeTe5SG
 jmZJE897p86YwSkX7VIjW43fAAOP7QOaRntV6z+Xt7cAj81RuVb3nkXhHWqenthHKJ9P
 V8N1EzJI9wALmiQKO7dOzq8ARDOgYAZ8V0EZRqZTItB5aWlpqdcwHZNvkL6rNsuAqFjR
 TVcg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=LelrFfNX
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

Update the maintainer for Spacemit K1 from Guodong to Eric.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Add mmc driver.
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

