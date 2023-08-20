Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D571EE4996
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 23:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC3E86B86;
	Mon, 21 Aug 2023 01:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VoqBetor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C2686AF4; Mon, 21 Aug 2023 01:31:28 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B54286923
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 01:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68a1af910e0so600031b3a.2
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 16:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692574283; x=1693179083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4rNhs+3uDBc2nwfBSa50Nq4m3adQv8cFDgJsu0f51Lk=;
 b=VoqBetorBaleCwZK+bP7EzSBp8EERdGJOOn9cF/eqXOlkjzgjrcuocEeu46i7FvAGu
 /mlZE1n9OxLvxG2aWf6M1nfPPgGHB7mQOBqUW4kqPRafDO+/App0HjbwTVdj7+3uTJ17
 RL85dvUtE1ehbaFvjnZD/5e5rjeTe9r9IIS250Rz4EGY+Cf00w/OmQvoaLQJh0rzhzL1
 SWQd8k5MN985Pc0OH3FhBeoSDMGrmI8zXTwgJyw/ao44vSIgi07xJdSm9uosnXCvYdi/
 iuwHjVyrFhKPQc8XYQ5XWuWi3St9kTJPCHVbqO3gsz+HN4yafqG2FK95SqbzEdQ/kJX9
 FTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692574283; x=1693179083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4rNhs+3uDBc2nwfBSa50Nq4m3adQv8cFDgJsu0f51Lk=;
 b=J3AbUMfIH8rq4IebqPeMfatuzOekHvnMdcArSABQDkWW1oscIf5Ngo7DkSZQPF9PUt
 /BzMjf5eyJ21N4lTUplHtJF0FV4B7SV1krNS0ej3pF/z9QkQ40BqlXhZKxiyzuolTwVI
 ENUH8D7k5iw47CtpoTlYLMSymHO6LIDsHJJwlRjLrfF53XhkWlDVkeX6nlRpwWckkOcp
 9rvb/uq4xs3ReuxdaG33Y7WM2WLdgX+zf8eg/t8vGn3oSqSi+tUNbpfk1g5j57Fkur49
 gW+MhJMbH50u+loepefKAzKrjxZ5x4Ak7hNIKjbNuSjMmfKo6FZYN2QrMmOQbT4C+2Uj
 53kA==
X-Gm-Message-State: AOJu0YzfHH6a13PZZ4cm5lLkg781vHlNuYmXm6lOirBfkb5fEbTgkIfm
 PR8ptSj4HBuWFXix2wtrhDR+SiH9iMyJmQ==
X-Google-Smtp-Source: AGHT+IGfJbkjkKe8CowB4+ZgP/epdL2mYmAFUPsGk63Ml67lMN5RNVhowh83nXyIzE0i20+ZVsqXPg==
X-Received: by 2002:a05:6a21:7788:b0:131:6464:217b with SMTP id
 bd8-20020a056a21778800b001316464217bmr3516873pzc.16.1692574283031; 
 Sun, 20 Aug 2023 16:31:23 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:a119:6030:1ae3:c940])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001bde440e693sm5650082plb.44.2023.08.20.16.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 16:31:22 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] ARM64: dts: marvell: cn9310: Use appropriate label for
 spi1 pins
Date: Mon, 21 Aug 2023 11:31:04 +1200
Message-ID: <20230820233113.575818-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

The CN9130-DB uses the SPI1 interface but had the pinctrl node labelled
as "cp0_spi0_pins". Use the label "cp0_spi1_pins" and update the node
name to "cp0-spi-pins-1" to avoid confusion with the pinctrl options for
SPI0.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 arch/arm/dts/cn9130-db.dtsi | 2 +-
 arch/arm/dts/cn9130.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/cn9130-db.dtsi b/arch/arm/dts/cn9130-db.dtsi
index 1b28732ee752..4b21ff46d507 100644
--- a/arch/arm/dts/cn9130-db.dtsi
+++ b/arch/arm/dts/cn9130-db.dtsi
@@ -183,7 +183,7 @@
 /* U55 */
 &cp0_spi1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_spi0_pins>;
+	pinctrl-0 = <&cp0_spi1_pins>;
 	reg = <0x700680 0x50>,		/* control */
 	      <0x2000000 0x1000000>,	/* CS0 */
 	      <0 0xffffffff>,		/* CS1 */
diff --git a/arch/arm/dts/cn9130.dtsi b/arch/arm/dts/cn9130.dtsi
index 68b767a70639..efcb2e906b91 100644
--- a/arch/arm/dts/cn9130.dtsi
+++ b/arch/arm/dts/cn9130.dtsi
@@ -66,7 +66,7 @@
 		marvell,pins = < 56 57 58 59 60 61 >;
 		marvell,function = <14>;
 	};
-	cp0_spi0_pins: cp0-spi-pins-0 {
+	cp0_spi1_pins: cp0-spi-pins-1 {
 		marvell,pins = < 13 14 15 16 >;
 		marvell,function = <3>;
 	};
-- 
2.41.0

