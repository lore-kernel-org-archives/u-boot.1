Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B450C5DF6A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36ACE4094D;
	Sat, 15 Aug 2026 13:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ab2qFQhnoa7N; Sat, 15 Aug 2026 13:01:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 894FB40966
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786798882;
	bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b1eXpPYJ+vsPQ4hRcXKyfOTdINlJgEkF74rIculepymcgpsDCkSh0SYr3AnopcUvE
	 iIxic/lx7Y44wtK8YYVc9pnkz4YwQlD5oDJGZLVm3iFYwd3AKOVZF/kqEgL6ENFPHH
	 RecZ8O5ROf66DdNrF2FNXxT3efvM2V8sk/8c8LQY+eDW+vwxNxlEIr6bWoypUKWFz8
	 1wBSCbEE3JbnFLPTMuJWC7AhOA+k1j9Zgx1aBWNa4QSnAINFC77ZBbb4oj6XbQbW5w
	 +N5aCofk8ak0acukqurLMt2HCiX5sSiSYIuPpxVPEaqoIbyoZPPCA7Kye11UvoXyEM
	 sVh7MRopMN1Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 894FB40966;
	Sat, 15 Aug 2026 13:01:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D323F2BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C53954005A
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o9L3ncfAOK6B for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 05:48:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 08EB640026
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 08EB640026
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Lop9L+gd
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 08EB640026
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:43 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9fc3de7ceso854395a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786772923; x=1787377723;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
 b=Lop9L+gdesrlbh8frZfimb1jUIx9y1aFJDUvI9cG9vOZRDOdEbsO17SkgwMxGGs/sx
 1w5XrmEmAN7hAAY175TV8XCUAKETDwaVV9uCqreGFq4DKOIL7ra/wU1OoNrNen15856F
 68dsLn0EjYbMDtcLPM9puULibwn9poSkfuizPxuYQ99iNZaytoaEZvDuLO212gZsEWNb
 bMP89ktypm/I9y7sGxAoNN5M7nIDAUiwISuEMIE53nS4CbJb5nVAPepsOsMhVxveL8xk
 Gr5UT2qi59VvWfounBfBdiCq3+baKtemOVtQ0Y4Ir4l8SDpjzTUX4qMkJGHEpfGakeuN
 S9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786772923; x=1787377723;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
 b=IAxYfvH6FxKYHMUwh5lID6E98MZc5p7jm7C/Q3j7iR8ogYL6QNKreaYxr2mlJGc3Ej
 Im60J2GBmpIJrXS19xLhNCTCfSlrgDR3v6oGrCRgOAcgK67ew9nvA65CVGPefBPwnl82
 su48ZKaR2KXFyGnO8mrG+wGgI34KvUA/XXh12v2pe/K90CwYWR8aMLMBziEox0tRv3zr
 C1viJRxqpOhlYKHDri9vH3b9/FYTl0N92UJwWHaD0VqngL8H1jAW0kKcYuwHXjWWtwZl
 0J7OhECTluAo0Dd3nr44ET0X5SQ8q+ZjEpyE06LCQ4ncVOgwtZijiotNHei5d2lBUwQY
 TAVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNenn5p7pjrLQqJauzNihvMq7dZBm71D7nNGptXXJYKLQcf6atB9pK4VBzkTFdQw5iUQsET3I=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz388BG5l9ZSQStrc3Ypi13BvbbLGg3Fj+sRkywBVyUO7OEBfb8
 0WOxbWTUUx4/PIGpKWbJ/u5RxsGVQBK1cFMZjrfjonpEOKFmQ1gth4Tu
X-Gm-Gg: AR+sD133R3XgW/AgEVkwZO3hTyIHNIZmA7M8SwtCp1vq1DDd7kzMA8TDyWJRESErVGx
 z+QGzIfYSzNdAyhmj/wNSkWkyrFxBAB5aMMRmqBcPohFcMiV4rL/W/E6SK0M/IYT78LyIqfiwM0
 xD2t8kYWoLd4A7QyYndQ+3yx6y3qJHq/vMBwunZHG0HB9OTtZOlk/Atz3hoNNpynjyQ2gBMGBsc
 IbLnuSHRdxGpepO43CInv7iQV7Oqg7765pOpYallunvXi7UuqdbYECNrYz/KBHxBSpm7FCXO3bx
 OQMig0pFrPW/PajXjps9IvFse7p6xhFQI8v78K3nJ5H8xobFkPbL6eOXr3H7K7H6FQkIfDMmCCB
 9O0E8iTAhXkgGeYUzSaw89EiCQdd+Yc7vMry/uM4dPkY9P8f5j8pJVHcpQbr4jDhqvNErCr81pj
 jRn7m/mmT25IgQWVPblySrvybnqC4/Ul/OQFAtTcYrKxY5dyqGQIK07qHU8CPJtiogWHhf9YrzW
 ql8r2wcaEGo30nYF88ovADWZKUtT80ntC7rDH5srBVGnjuahaqEkB6okINVKkryDACmtjGtRIEb
 g3jFS7AUDIAlW85TYwqbTpliKYPNS4wrJCmA1q8upCncWSO0286eNLTcspnjmc7EeiX/LxqOJzX
 CINEq+3+R12l5NXcw
X-Received: by 2002:a05:6830:4108:b0:7e6:50dc:6512 with SMTP id
 46e09a7af769-7f3de452e9dmr9334741a34.6.1786772922670; 
 Fri, 14 Aug 2026 22:48:42 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86282a6sm2780166a34.18.2026.08.14.22.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 22:48:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 14 Aug 2026 23:48:09 -0600
Subject: [PATCH v8 02/15] crypto: aes: allow DM AES in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-submit-ce-series-v2-v8-2-fe9212431a94@gmail.com>
References: <20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com>
In-Reply-To: <20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 15 Aug 2026 13:01:17 +0000
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

The AES uclass Makefile is already keyed by CONFIG_$(PHASE_)DM_AES,
but there is no SPL_DM_AES symbol to build it for SPL.

Add the SPL variant so SPL code can use UCLASS_AES providers, for
example when decrypting FIT images before loading U-Boot proper. Select
SPL_CRYPTO from SPL_DM_AES as well, since drivers/Makefile only descends
into drivers/crypto/ for SPL when SPL_CRYPTO is enabled.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Select SPL_CRYPTO from SPL_DM_AES  (suggested by Simon Glass)
---
 drivers/crypto/aes/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/aes/Kconfig b/drivers/crypto/aes/Kconfig
index 7e1b1b2875d..254cb598568 100644
--- a/drivers/crypto/aes/Kconfig
+++ b/drivers/crypto/aes/Kconfig
@@ -4,6 +4,14 @@ config DM_AES
 	help
 	  If you want to use driver model for AES crypto operations, say Y.
 
+config SPL_DM_AES
+	bool "Enable Driver Model for AES crypto operations in SPL"
+	depends on SPL_DM
+	select SPL_CRYPTO
+	help
+	  If you want to use driver model for AES crypto operations in SPL,
+	  say Y.
+
 config AES_SOFTWARE
 	bool "Enable driver for AES in software"
 	depends on DM_AES && AES

-- 
2.53.0

