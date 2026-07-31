Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897F5C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 17:18:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B92060896;
	Fri, 31 Jul 2026 17:18:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNwAW81OiE_C; Fri, 31 Jul 2026 17:18:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36BA66069A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785518331;
	bh=Ep9lvKpbD2l0UZ9rqWrcaPZTPSz4Rb92TWFI7RG8Y+I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yn5jKzMg32NKFeSXVwxhgDDNkJOifoTrGQOOXtrygIqpZHgxic0aDlQyc8BG9gfhq
	 dk6LaErvd8IF1R8XfuRX3G5ylL+dVwKU7zc7UsujNlNPpmn6zwM5JTqCsCVx97JsZG
	 K6qkJJaQAf2jB0bAgxPCVUrVKb6g71wS4iS69cjKyGFEXAep7ERd7s7ni3XTpfH/k8
	 13EGW0hDnZX+nrJDmN82wldKzERixouYgK3ox+WZeua2D26PNorJQLs3S1HMn1Iaim
	 QH/2DUPrEnUcyJpNiHonnzDj6ICXb+VkeEwW7YZGqNLg0+s0OOXhlGYrqt+WH2z0NH
	 MODR1K4Bq7u1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36BA66069A;
	Fri, 31 Jul 2026 17:18:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9322969
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8512280F2D
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s6tlRXQIBXi3 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 17:11:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 82E1880E41
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82E1880E41
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 82E1880E41
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:12 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so776329f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517870; x=1786122670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ep9lvKpbD2l0UZ9rqWrcaPZTPSz4Rb92TWFI7RG8Y+I=;
 b=K1MNF1B5VHc3db2lhzZpEb+YyhSTDOyJcfxm7li/1brvnO8j0qi2q7Klzz6ENunHil
 UsxwbArJMxbarLQUZlfrAT4GUf/x4Jos4Vw3l3G5ZqbiXTB3d7ZLf2lW1/JMQC2eeJBZ
 7nZW2Zp+Xlv3I7r6Zn/ONU4y0Fs+iPju6oGJFhkQMFnK2XhntNZEw6e2DSO/wAGy3/zD
 MnsHPru8Pbet56Nge9SDAbC+PpBtdIymV5xOh8bFbZQScS32cWtlrfSoOYvd5CzorHRf
 jGrCF7PSW8ZHbqf5GbsEGw/ttSZFOOaZe6C5LwdHZQ7TkUSVwQeeVrYeapVtcmpMmFpQ
 O2mA==
X-Gm-Message-State: AOJu0YzL63LdcH6pAvdGdprwK6J0+rWe3Pz7kl65cCulCbzgedNBUJfq
 6CrrLvbnes2LbgFLs3zAvpZngjXc6XsjUMmqaqCgw40IGMcPHEfPODge8yVsobDHg0E=
X-Gm-Gg: AR+sD11XyBW/EXh6BCHiOo+op6ReCSydKiPgo5lt/Pe6aINLpZNI4BbXERVaK6hf7Rj
 EUWlUkB0J1smzRKd4MyIH/gwCkTQTuKh3Vw+WecRzAYSdi6L4SCk/azijRDCyMSLZV0fFLFJ+WR
 my5nSnJkvt0K2p+fLJ6soyeq2pZ4F3B6G547M1B0ZJdyxcmJFTVTCPlXorR8r5BepEdd4S+x2TL
 xtgRcwLKzmbmsgmhn5PjmYosGA8Puus1DEDPjjNf1rxmguVpTivn+XhAYHOPxabyaPwXgJJCnuI
 5zyftbd36QH6BcE/lHmMkDWmIQbbecHnJg0UeYR4Domi22HcsZDEI2k5HSklUzRhhnQkyD4toYB
 1BrA7+1wS7yKqVnIhszQ+qNiIN44HDKpRwyhHR/NThIRoZv+6GWOo0lijXS96IZ3myOlZeY62fO
 FAq8quqtlxFKGFoeJrbYskxszV6NJ3eq89RZc58B2jU8PyqcRkUdWT9DsscYA6sWUVN0inS30a5
 NbqfnnMdaQNg2xA7qNrEbWLnYv7YoQmko5kwnKE8w==
X-Received: by 2002:a05:6000:46c9:b0:47f:8ac0:ccd3 with SMTP id
 ffacd0b85a97d-47fd72ba5a2mr709395f8f.2.1785517870439; 
 Fri, 31 Jul 2026 10:11:10 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm7541484f8f.7.2026.07.31.10.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 10:11:09 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 21:10:45 +0400
Subject: [PATCH v2 01/10] spl: Decide about Falcon mode boot only once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-atf-falcon-v2-1-acb97c172993@flipper.net>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203; i=alchark@flipper.net;
 h=from:subject:message-id; bh=y+Gt2ohpx7vDFUsS2PrPxz4VjbjMWIJqn44h4up9FYc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlXFf6uaHaa+HqiYw9Dhphe5KmPQplOsacx2sW921zM
 uORpj6rjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKb60xOGf3pz5XOkGX2CJij4KbltvH9jqaSiXqwOY+LVvzFsW/lF+xgZHr1xfXh
 LynBt+6ZlyzSK17yQW3U5z8L0rM++DK1b9moNfAA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:18:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785517870; x=1786122670;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ep9lvKpbD2l0UZ9rqWrcaPZTPSz4Rb92TWFI7RG8Y+I=;
 b=ptMzS6kk6ubYZ2fA86WC67nPtumaqNuMP4Q2/b9Te2TJFe4YWv4CXWtmG89dCMP6kk
 7gWZU5SerHwIdo3ARpiYSdkrJSxDqXX5WNTW++w2Jxas3E5msbY2S/aHrGrACbo3jAq5
 xYV4oYY4zJVWtK0c1Oot6oBjofvcLtrmD6r3SzHlCehQqq4LGSlOqq/Ao/yZ0of2a3aM
 rwXW3rMbGvwmcloksckFm8i7VDQZsxWFLUIV94GbGkP5twDyIuhBrHe6hmwDzCJcvcmC
 T2Sjv4EuYD9Ic3WgYfwoMWOPaTWJ2sKb51ilJi0iwTUxhaqegtqsT/qjcCT7wDrj1Aiw
 t69g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ptMzS6kk
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

Board implementations of spl_start_uboot() are not required to be
idempotent - the documented examples sample a GPIO or read a character
from the SPL console - so calling it more than once can yield different
answers.

Add spl_falcon_boot(), which calls spl_start_uboot() at most once and
caches the result.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/spl.c | 18 ++++++++++++++++++
 include/spl.h    | 11 +++++++++++
 2 files changed, 29 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 722b18c98edc..abbd56ca2fa7 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -105,6 +105,24 @@ __weak int spl_start_uboot(void)
 	return 1;
 }
 
+/*
+ * Decide about Falcon mode boot exactly once per SPL run. Board
+ * implementations of spl_start_uboot() are not required to be idempotent -
+ * they may sample a button or read a character from the console - so asking
+ * twice can yield two different answers. That matters because both the loader
+ * and the code which finally enters the OS (e.g. spl_invoke_atf()) need the
+ * decision, and they must not disagree about it.
+ */
+bool spl_falcon_boot(void)
+{
+	static int falcon = -1;
+
+	if (falcon < 0)
+		falcon = !spl_start_uboot();
+
+	return falcon;
+}
+
 /*
  * Weak default function for arch specific zImage check. Return zero
  * and fill start and end address if image is recognized.
diff --git a/include/spl.h b/include/spl.h
index 5078d7525abb..8da82e87aa3d 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -757,6 +757,17 @@ void __noreturn jump_to_image_optee(struct spl_image_info *spl_image);
  */
 int spl_start_uboot(void);
 
+/**
+ * spl_falcon_boot() - Check whether Falcon mode boot was requested
+ *
+ * Wrapper around spl_start_uboot() which calls it at most once and caches the
+ * answer, so that everything taking part in a single SPL run agrees on it.
+ * Prefer this over calling spl_start_uboot() directly.
+ *
+ * Return: true if SPL should start the OS, false if U-Boot must be started
+ */
+bool spl_falcon_boot(void);
+
 /**
  * spl_display_print() - Display a board-specific message in SPL
  *

-- 
2.54.0

