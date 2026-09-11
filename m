Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D850CC88E50
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 01:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95D976070D;
	Sat, 12 Sep 2026 01:07:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rz72IkRsKKW7; Sat, 12 Sep 2026 01:07:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 70E2360706
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789175258;
	b=IVAjRaqtcNj9fKQv+Qj/XCzCEZGP/ibwitjQhJpnvfNtE0yiQN1kD1PdNEbA5j1waUVA
	 ZQpFlt98UtT1NFWuPhsCVmwMbXfy0aucdTfnWJ3NB74rz9TUCnReb127E7Ikb/p8DOqwR
	 lN7MJQXWq4hzl2qyNLqbME6OSAp9jU01ekr0UCo+TLOe1wWcMUN+Yx3WxtzU1eT206y6a
	 sG4R+hNqdVucRSeBZPEFwYReJUXF7B/u6SjLlQ4T6xqijSZzDP9Vxk9Q2XovIJWtN7AiJ
	 w93dysXRUxSH4UkMTI1ARefmsbqt/tT3mOaNICtjj42kI34sfc5bf9Em9UseTtGbHIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789175258;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=6ONUAMiiDwgZlzQCsk+LqbFGPjs2fjzY+5uk43Eb4TU=;
	b=dXcGBxBtoq8V4t99rx0Ces55f2F6mx/8mtIhL0nkFRIsXhZ6nuRO2HI3WrlQknpl9dv0
	 /0RJ+7JUGgjoQ4VCYU4mZulIM0FzgEzDQEf0gRCMfZRZiy7Sq4yme1ceCb+oXen+yLdsm
	 6j8ptBsf4ZmNtss5ZttMZQtefINtgMTLFhLu4Rh4Pr14HXj1jCrFhBS/t0OxXwdc7HMxS
	 nyacn5SexCtLUPDDH2mTuvi6RTkzr3erMfcWGbUnw09tcenCmTh5VeNvkXE607vX8ReSd
	 24lfyZbFnhwywC3RrMtuCPOANLScrz1tCi+bLn4Oyv6pjQAU/479PMdiQyoH+ExVmCw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789175258;
	bh=6ONUAMiiDwgZlzQCsk+LqbFGPjs2fjzY+5uk43Eb4TU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=q0Q28bf47hqaLnFwd4UoaFmpJrnI04J9/TVMpe3NQAxRAElsUbdxi6/W69CWzhVyd
	 u5dFk05DBZjufCMf/vo4GqmCCBJtrHuW1GjGziOSDw5DACneNCrsuKMz/Vuj8RPpif
	 ElGdYPwnH4Ix4nJUvvvksWtmQ1a1q2O5HkUl+iCQNsU4o5FMAboqSubfJsKUw7gAVI
	 oDkp6QZN8bUuIphW9aDPAyyv7R46tibDDLAyIMEeiDztYYvjc68px+PB64zwXJcyro
	 Z0LOBj/Yw41NCEM+FNUdtzF31YlWaV5rE8nDG4yXNzR9zydXQQH+0bwR9SJe5X29xs
	 fExULFLuxbw2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70E2360706;
	Sat, 12 Sep 2026 01:07:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 635A0255
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49ABA80EC8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:25:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id olZHNrcpelwK for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:25:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3EBF380EC0
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789151120;
 b=Cs3oTSImDYrCEGNqDr/NYobWmWeNU4D9ZXz9KVxi4GD+oEu8Iok1ip05U33iLCOwMH0l
 GveCO2xyxfCTJPH6e/2E5tfq5y+dsDGJH8kUOnV90+5qggA1KwmVl1pGjOJL18W9KAgrF
 tS9w/IRvcwEfDKJA62vd0vH4cHBQ7xdZZZ8GaGrBtXiXkmmdkWKw/tEgjsmE/6dHqqK6c
 qcOGNXWVAu3aIWPufRIIsYDe4SGvoTgE4ivxiZVTBnnmmIQb7a1kkRpZjlJOR8UPr4GGV
 mqzTfpmqEtfEjx8LymTGdxukxaLNXNIShgbxL11vxoQCf+PEijuX4m15pyHkO+pBiow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789151120;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=6ONUAMiiDwgZlzQCsk+LqbFGPjs2fjzY+5uk43Eb4TU=;
 b=pQCaN8oAAlWXKUHz4XbazbdsjLf0Ejqi4QQ5MvJVqBpCMx7l7JSvsy6K3WxLvKGsGCEW
 Fo1FNXrHnjpvQV1L94c7lqO1gHeGTZp/2Cn04rnm7ngzXO4VXwQ/Wq84Y+0nPsSG+zlTU
 m/dlStggzwwd9dJPGGqNLaWbsGUPs0pzIco8KSYg9vWjSeRM7uEB2+k1okQ2VVHfpT+mB
 UbeA7PVqHDYYlw9idEu7eH117myQ/N02dlXqPiU41tsmH866PtQtR4J9KG5mUQGNxhvNC
 DYY6u+FHuiSDNkRzOs2ZBWn2RFc3OysqQMnJiCn3ynAN5bpBTUVP2GKD7a5bH5gu6lA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b="j8Rxh/Im"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=j8Rxh/Im
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EBF380EC0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:25:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EF2D2600AA;
 Fri, 11 Sep 2026 18:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6B56C2BCB8;
 Fri, 11 Sep 2026 18:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789151118;
 bh=biy5clAMKB6KVjGAY4OYCpVPehZ4FNgvgkaV+qjHEl8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=j8Rxh/Imvi7Lkpt01ZbIUbFY7fawWSmBZbeiPwPF/KVIVuoZPLfO3+qHQQZSAkUOK
 k/Br63lJVFjrPKnBMoTjBr9yKiQ5JJdd7fHjtKickQLIWmyQ61RRe2uFEL/Dxjy18e
 jKnDVDFVlHtmWDRntzmZPyj0CWf1WswY7/p5Dvq1dHMXJO6XLwzL8yRdFhdGdMRtAb
 zahmesxTtvVCFxwxfKJlT4e0k5mKPBFdckJmgNEgXjq89Lx5+nR8W17VcT4f0x2CcB
 JMn6VokJMKQhggurvoqrzorf8DcV++kn7TtupCGNQ9lLTPjc1JXDwRaWRilhJuTYJ1
 QJvyph7xxV7Vg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE06C88E59;
 Fri, 11 Sep 2026 18:25:18 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 11 Sep 2026 20:25:16 +0200
Subject: [PATCH u-boot v2 2/3] lib: qrcodegen: configurable maximum QR code
 version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-lib-qrcode-v2-2-c5291fb7c646@protonmail.com>
References: <20260911-b4-lib-qrcode-v2-0-c5291fb7c646@protonmail.com>
In-Reply-To: <20260911-b4-lib-qrcode-v2-0-c5291fb7c646@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789151116; l=2578;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=KEFc0IGNdnHH/KW2Az/zDEUde8UYpqr6m3aX1epjazY=;
 b=q1iZiov3pZ3HpjPlrDb+PVoTZ8ipcu7hmGQFjqu2L6p+737beinVvfFl3qAdm5YdV4Dy3vMeT
 yvZIdbMTgRzBnacrO4GKSZrTSDYs5W6hdTxD2a413oQDLxA3bLZeolf
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 12 Sep 2026 01:07:23 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Add CONFIG_LIB_QRCODE_MAX_VERSION (int, range 1..40, default 40) so
callers can cap the QR code "version" the library is built to handle.

The version determines both the maximum payload capacity and the
static scratch-buffer size demanded of callers: each buffer is
qrcodegen_BUFFER_LEN_FOR_VERSION(N) bytes (~370 B at N=20, ~810 B at
N=30, ~1430 B at N=40), and callers typically need two of them.

The default of 40 matches upstream Nayuki, so no existing callers
need to change.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 include/qrcodegen.h |  4 ++++
 lib/Kconfig         | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/qrcodegen.h b/include/qrcodegen.h
index 6f87b76bb2a..b67b77a30fe 100644
--- a/include/qrcodegen.h
+++ b/include/qrcodegen.h
@@ -134,7 +134,11 @@ struct qrcodegen_Segment {
 /*---- Macro constants and functions ----*/
 
 #define qrcodegen_VERSION_MIN   1  // The minimum version number supported in the QR Code Model 2 standard
+#ifdef CONFIG_LIB_QRCODE_MAX_VERSION
+#define qrcodegen_VERSION_MAX  CONFIG_LIB_QRCODE_MAX_VERSION
+#else
 #define qrcodegen_VERSION_MAX  40  // The maximum version number supported in the QR Code Model 2 standard
+#endif
 
 // Calculates the number of bytes needed to store any QR Code up to and including the given version number,
 // as a compile-time constant. For example, 'uint8_t buffer[qrcodegen_BUFFER_LEN_FOR_VERSION(25)];'
diff --git a/lib/Kconfig b/lib/Kconfig
index 18311276443..5f37a07e512 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -303,6 +303,24 @@ config LIB_QRCODE
 
 	  Imported from https://github.com/nayuki/QR-Code-generator
 
+config LIB_QRCODE_MAX_VERSION
+	int "Maximum QR code version supported (1..40)"
+	depends on LIB_QRCODE
+	range 1 40
+	default 40
+	help
+	  Maximum QR code "version" the library is built to support, in
+	  the range 1..40. The version determines both the maximum payload
+	  capacity and the static scratch-buffer size demanded of callers:
+
+	    qrcodegen_BUFFER_LEN_FOR_VERSION(N) bytes per buffer,
+	    growing quadratically (N=20 -> ~370 B, N=30 -> ~810 B,
+	    N=40 -> ~1430 B per buffer; callers typically need two).
+
+	  Lower this if you only need to encode short payloads such as
+	  pairing tokens or short URLs and want to reclaim the static
+	  buffer footprint. The default of 40 matches upstream Nayuki.
+
 choice
 	prompt "Pseudo-random library support type"
 	depends on NET_RANDOM_ETHADDR || RANDOM_UUID || CMD_UUID || \

-- 
2.55.0


