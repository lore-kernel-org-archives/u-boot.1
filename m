Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B19C5DF6E
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC1FB812E3;
	Sat, 15 Aug 2026 13:01:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dwjS7iV-g39C; Sat, 15 Aug 2026 13:01:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E9FF812B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786798887;
	bh=bQr8HtSOCkcvmJvbux6/d2biRjAYkuPZlT6Y2mFv4tY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZBDoL4+gFV6wNYZoYfrH+y55YZZ8LcXUmmJoep8jdDNOhAvRifhpUreQKpgNVkFJA
	 k3Ah+ilI/aWiy+vxclD25yJDoLrbHdLjW8+jhP2Pyyb0sG2n2AmhipeCQkow/Y+K11
	 Z1eKaBAf+enT6uaESKRyA00miVbnsLKk5fgbU3BP+dCOZwUaoW8paYRs5bqidQrjZR
	 V53XpYOftKdTCT1Ajs5D0cmbk4Rb7O+YcZ4pjVobaUCwBkI7AnhgLSpWYvvZT+B+nh
	 IXcxnmp5OeKHXuPFYgV0idJvL9Eg3TW1MTET8711qZ5wlH8ECsw8tqK1erclXpq0JT
	 Z9IBiBbP1xK6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E9FF812B6;
	Sat, 15 Aug 2026 13:01:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A674C2BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 989A460DCA
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I_w2IVSBNRFF for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 05:48:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8079A60A50
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8079A60A50
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=g9FtiT/S
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8079A60A50
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:48:48 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso824703a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786772927; x=1787377727;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bQr8HtSOCkcvmJvbux6/d2biRjAYkuPZlT6Y2mFv4tY=;
 b=g9FtiT/SB+c05MsCaZBDV6DXMw8tlKmAAWwmvqpPikuUwhe4+9X8hsxIhM4OOesNZ/
 hBjwFSNC6ZJJJCSW4vmqVUqjEG9Y2FgbzbBhCWJ9PhEBpO3a6zWwJDbKoDuGj5XnoLnd
 nLsAM4YI03lntu1yaLURyt+PKfhGoFoDyb4OaENY88tiSSXQLXz1OT/m+GuYKAuc4PVy
 X8RDZto75j3l0j8qX9yBVXLfgzKBxacasDMNIQzQXLvFoUJP5hWcmXUUurtyh09vEw1Z
 qQBSAv4Jt8sE7gJnSgXcDzUqOMNbLS/MiYvM7/t8NYslzzNYjKwxaptV2I+zZ8cA63dG
 zGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786772927; x=1787377727;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bQr8HtSOCkcvmJvbux6/d2biRjAYkuPZlT6Y2mFv4tY=;
 b=MxdMqIK0LA5Pd2NyZTwwbUhynMbJ3d1VQI+eth2dRKJjZVGVVTUfrvXLzFBuh+EET7
 p/6+17NgCS2pycZD2YrKFDIjYbJslPFxj7n25ECkRFXuBNsmlQbUBdyJqEqHom10XryX
 kkjWA53oopkoYyHTUWhkRh1nSZdzl1Xv6127faYL62xCUCzSvVK07K2CDu/QKlLyZLES
 fsVdZyioyp3RurVpi7yGi9S9u2gDr9qxWhB0TKV8MmB/TDMOLzXc5So6C4pZZQSqdENF
 bsPXOxdIYEeveQd3xrbyVtQyW/rbNEuXUED2CW6yomZ0n6Ifeg2Mvbzbol3560IBcmIl
 jQfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqaM6TtfaOdzPa7iL3KY4yalSldXsp/+n9kIzV9a9Sx7SzwcB6kIr/XtViV0+ROJ+joa2rc2tg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzL4fUj3YNveV6ZX7U9a/ZE2csoTcyIHJRl/NNG/Ec3SipR6Bt1
 GRdXYrVPJJlaCvmf4TRfvzEOKEhERGwAC9Kf0P0PDyeg0ETi3RjIs2l8
X-Gm-Gg: AR+sD13ytgTDElT5qboffsUfRKCNYnliX9x9X0PmYqKPMGJ1NuI642FUxWZ6orNNPGT
 R7Vbv+7gZTe0zG3AiuilItWZCbdB9jb+774GzyW+F3FnA4fmBWGhORGL2lN9qXCNNBLgklp7AMl
 AxVYLfv60/bXdrBNywNO2Yvdx4SW90qYBwhXOKRFp3InyeVKx6KTL06JEHQAbHOVM/GSFaOHAO9
 0Dq7TAJ2ZiQEcwueUPLWwv+0NAuEhA/Dc78q73z42DajOe8TFOvohGuayPfIA6Bqjk1qQRJe82L
 4aip1eHl5EalPqQp2UdTxjjqOVk6XhenIDgMEnMeg5oQxcS7NaVrEtkQZuODT+pwpZObDNjcEKS
 AwUmqPEEIUl5tp5Y/J6z/9+8EicOJRaxl1I4OjhtVsvAQ5yYkcXKIZ+KQvod8Wx3mN/MD2/b48d
 8FpfYgyNS8AvZtvGQPA9nf3C5aYrSZSO9HsqcqH0hbpoxwrgGkrspuw+3KFhMuJ8mJnRAk81Nto
 cTiH0wqmiKp7bgsfg+VfOensfTgt7RSfLAHnnN3wcxicaZKPAEyQyevDIBwW7AGoRfLHN6AvZT+
 Avxtm3qbHA6xYS47jRE5czzqoQ6bZeUufRzU7KYHRRfFFio3GjLbocy9O1G4S7gojNiR1YGoP3X
 eV1oVbURGQc27vua1tg9Q0Q==
X-Received: by 2002:a05:6830:600e:b0:7e6:f2dd:93c3 with SMTP id
 46e09a7af769-7f3de65f077mr9992444a34.15.1786772927486; 
 Fri, 14 Aug 2026 22:48:47 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86282a6sm2780166a34.18.2026.08.14.22.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 22:48:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 14 Aug 2026 23:48:11 -0600
Subject: [PATCH v8 04/15] boot: image: try all DM hash providers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-submit-ce-series-v2-v8-4-fe9212431a94@gmail.com>
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

FIT hash calculation currently selects UCLASS_HASH device zero directly,
so a provider which does not implement the requested algorithm prevents a
later capable provider from being used. It also turns every provider error
into the same generic FIT hash failure.

Use the common hash provider-selection helper. Fall back to the configured
software implementation only when no DM provider supports the algorithm,
and preserve probe and digest failures from providers which accept it.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - New patch
---
 boot/image-fit.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index d7d7c70fe76..9b39696de2d 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1322,30 +1322,22 @@ int calculate_hash(const void *data, int data_len, const char *name,
 #ifndef USE_HOSTCC
 	int rc;
 	enum HASH_ALGO hash_algo;
-	struct udevice *dev;
 
 	if (CONFIG_IS_ENABLED(DM_HASH)) {
-		rc = uclass_get_device(UCLASS_HASH, 0, &dev);
-		if (rc) {
-			debug("failed to get hash device, rc=%d\n", rc);
-			return -1;
-		}
-
 		hash_algo = hash_algo_lookup_by_name(name);
-		if (hash_algo == HASH_ALGO_INVALID) {
-			debug("Unsupported hash algorithm\n");
-			return -1;
+		if (hash_algo != HASH_ALGO_INVALID)
+			rc = hash_digest_wd_lookup(hash_algo, data, data_len,
+						   value, CHUNKSZ);
+		else
+			rc = -EOPNOTSUPP;
+		if (!rc) {
+			*value_len = hash_algo_digest_size(hash_algo);
+			return 0;
 		}
-
-		rc = hash_digest_wd(dev, hash_algo, data, data_len, value,
-				    CHUNKSZ);
-		if (rc) {
+		if (rc != -ENODEV && rc != -EOPNOTSUPP) {
 			debug("failed to get hash value, rc=%d\n", rc);
 			return -1;
 		}
-
-		*value_len = hash_algo_digest_size(hash_algo);
-		return 0;
 	}
 #endif
 

-- 
2.53.0

