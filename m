Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81615C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 20:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FECD60615;
	Sun, 23 Aug 2026 20:39:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9x2zx7LdmCDB; Sun, 23 Aug 2026 20:39:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787517597;
	bh=hkIkpPqja8HZGSUI0J2nSSwjZjftedBFRJJ33BW+9Zk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E6sX3UalMlw2fMSFCzmLLBmA/VVm7HzxeU3DV9swqyAsZpGqqbNDlJ2vO8CwuZBBY
	 bu6T/8w+VkkEfIwcDnxM8k+myFM/jpjb8Bv+W0YEbPRAxGcAHhDO2QFWG04dn7W4lK
	 jr0xfSK9lj0bp/3RfFauPkUZALTI+FqAH7T4iZ4VUzZs7za1R+QzZ8FP6bYcGJs7z9
	 mPJM4hn2yPBTuLYpMT0KKHFmq96+A8UNOUT1oKbskZfNQzEial5EyAEbyncLMKV1Tu
	 f88jjtHvY5EXvuBuDLWixGK69fW9SA1zsD2AQ3pUstfcQ3mYSlOaGmX10Wmw9RcwJs
	 nmLoUAQd9f7fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 777C66066F;
	Sun, 23 Aug 2026 20:39:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 20E782FD
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07FB6606ED
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SCpj8hTO_zan for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 20:39:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=k6HR7h5r
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F51260617
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B1CB1600AD;
 Sun, 23 Aug 2026 20:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5301F000E9;
 Sun, 23 Aug 2026 20:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787517589;
 bh=hkIkpPqja8HZGSUI0J2nSSwjZjftedBFRJJ33BW+9Zk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=k6HR7h5rb71OwW/ICO66SIcwQnhBHLum8TPQI4t2snVwDW/VIWOPfqbwa9XF/kyST
 qFxieFnquW164YeSQVoq9S/96XLbiI49xd32wV2T548iUzJsSd4uw0DuYUD2AYlX/Z
 IHCa46kDrCbbL6kxWkmzXNt5rEADJqCsQeiniEIRi3jSNb6MELj/UUKqHEB6Nk6dDY
 dwjK/Rc7n4hx1dMFWDpxM2MqAxnT6WyHbDO3BWiKzZvJpZfSEmzcRLeZJN/oiUj+MW
 k3WXk+E5n7yK5m1zn9Q/ft3EErsulk1CMl7LB9UfB9wGITI3d0ZjTF7Qe70ySO569Z
 wwiGINA2Cking==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 23 Aug 2026 22:39:31 +0200
Subject: [PATCH v5 12/13] ARM: dts: ux500: Harmonize GPIO key names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-ux500-external-sdcard-v5-12-07ca794e2b94@kernel.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
In-Reply-To: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

U-Boot want to use the volume down key for activating fastboot mode,
however the code there relies on using the key label, and this
differs betweem Golden and the other devices, so harmonize this
by using the same label as the other devices.

Signed-off-by: Linus Walleij <linusw@kernel.org>

[ upstream commit: ..... ]

(cherry picked from commit .....)
---
 dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts b/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
index d4f364ec8685..1bb667300ed3 100644
--- a/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
+++ b/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
@@ -391,21 +391,21 @@
 		label = "GPIO Buttons";
 
 		volume-up {
-			label = "Volume Up";
+			label = "VOL+";
 			/* GPIO67 (VOL_UP) */
 			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
 		volume-down {
-			label = "Volume Down";
+			label = "VOL-";
 			/* GPIO92 (VOL_DOWN) */
 			gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
 		home {
-			label = "Home";
+			label = "HOME";
 			/* GPIO91 (HOME_KEY) */
 			gpios = <&gpio2 27 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOMEPAGE>;

-- 
2.55.0

