Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53261C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C395810A3;
	Wed, 29 Jul 2026 04:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RzMl6G8MpYIG; Wed, 29 Jul 2026 04:55:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3116F8100F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300941;
	bh=bQr8HtSOCkcvmJvbux6/d2biRjAYkuPZlT6Y2mFv4tY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E6xWq21gu/kXUG1iP4PNaHQP8E84JuRzPVf8eRW/7dHRTfNa14VjwMS6s/HcOFTEl
	 bNdJp2gJ898pLM9r+m416aWAi4EvppjI8TLSuf8LQAbAQUUfVeWD1JufKP34LHORtR
	 upDeYJl+zziW/qqML3JRYE1i73bBfqQtbPnyFRbClb95H30WVS560bLylaedy9NSnT
	 PYpZfZz8WaODKoNUUIVLDdbnjoMbGJeAKnq0ryjCdnK4CD2zib54OnbGHHrXabxCOF
	 2cGxHzg8wZpzWWzmWaJBWy8+dK5pYPLVuvGWC/eAz+0KY0t4fEcb5BcGefkhahDU6s
	 cf1bVel/0pAHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3116F8100F;
	Wed, 29 Jul 2026 04:55:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2BAB788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 99316608A8
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PdFM3CINKHHf for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:44:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D1D41608A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1D41608A9
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1D41608A9
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:03 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7eb545db3afso117239a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785260643; x=1785865443;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bQr8HtSOCkcvmJvbux6/d2biRjAYkuPZlT6Y2mFv4tY=;
 b=GCB+YIDpxye6oWybQgD4PcwFRtgAXC5Scd8CMVlwSCjITRZwQ4o660XTWG1hVvzD9o
 /0CVjZPSCivcUzOrjUnVc4G0Pz4IWIIF4S6lY0Wf10wTACDJpQ0OFmoXCzz7uDUpEzRJ
 ScDl1QZ4/cuBFhFvdVL1FssX+JMmu+jOwwL4J1rOIFuLIcU9Y+5YWucyFwNmjB6eqRXx
 ZgIdp5CFS0RyVRCYvD6blVtgTYRZNnTyR6LO95sz6YIBxI1EZEvMZHqeTwzWYFd1iINN
 A/4ELhaByes38JqBFe/FRL2hw0J9VhyxxesE+l0HrXumS5mITHDi2VNi2oHAwYirgcQG
 lFmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbU8hBduktROtKlkxpu1RJdeEi90cpHxDXNf21iXPwcQ9eBKY2FQFWLAziH509/THw5t78Xas=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwNj8V+z1aDIWfQOi7J2ncmfkAQYWjtbZBGbSKdEVtH626aC8Y0
 4GBn+6UhEv9B0Izs37NWi5oAYijyqTe4eWeyngwB8WbRx6Fu7/YPlsYf
X-Gm-Gg: AR+sD10ehi7Nuiwl1hO5vYxHP1khqlaoZVdRouw9d7REKzDRiagV/mQ+3OSFgXG9qii
 Pz1k5GP7f7SQ745XXZ+r93euVkfaN6xrz3lv9mGYhTFag/GHZ519MZk6Q+jE4gmhB+8fu3C7PwD
 M2PKNEdHj6SEBCXY0Qh8qzM7fDa4PsCBqu2lmnmwAHucWeKd8S+tMsK4Lg52Vkf0b3FsArJy19I
 Owjp6MdB0Uu14GZpok/q4AiMjJhaqb23+yuByFYnDY62DRqNF+nm2NwDhONfwFml+KdL+wpO2uJ
 iJem/TnZPChMsYAUkw61DRohkm8tcDB7yNcHRa+0q1a4M7eVowav5RrgvbWXBjlhP9GHEHR7z3q
 PH1E6RkfiUe8fqS41I710ZGBqfBFDVKMn/c3e6VoqJVpuiZnuFWNDNfz744Iypj38nbaaXTvDyj
 Lm5imiWWQGr7q2V9v6+iLVnmqHkXi/mcn7C61OxCLNCKsbadCoxZt6aFy4SsKwDBUeBOq22lfcQ
 l5AEjWdbPuCghpQfS1qEp7FExhlWzYKgjZ5waC7nVC7kAzNpTlXQ7hvzuN/tieP1Fc=
X-Received: by 2002:a05:6830:6f8d:b0:7d7:e142:2ead with SMTP id
 46e09a7af769-7efff25f6e7mr1757624a34.20.1785260642539; 
 Tue, 28 Jul 2026 10:44:02 -0700 (PDT)
Received: from [127.0.1.1] (71-218-31-69.hlrn.qwest.net. [71.218.31.69])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d94389dsm271103a34.21.2026.07.28.10.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:44:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 28 Jul 2026 11:41:47 -0600
Subject: [PATCH v6 04/13] boot: image: try all DM hash providers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-submit-ce-series-v2-v6-4-80c1f7daffa5@gmail.com>
References: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
In-Reply-To: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
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
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
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
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785260643; x=1785865443;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bQr8HtSOCkcvmJvbux6/d2biRjAYkuPZlT6Y2mFv4tY=;
 b=RxldA2mVX4QHPT2bOKjkXJbCnF/BYdZKN/Spk8oHRQ+fyRrs1Hsw5RyRDhFTDdRLZ4
 OqxQxrGh7UZqOt1NcFtJvuMCniUTcPVYCP4EBguJhThSRJCwqGI79RyI6Z6x2CjKvTMf
 RsoK0umtmZp5Ht4zbmxYzywGgPp+w+dx1n9uGAbb/lreb1RsIY6R8C++2fZ9cak4NT7a
 Hw+ijUULdjQyDZS9cfoSyzmj2m0fs6sMRg9kGJQ77XrvKJ27c7DBRitjLaW5Q4q9l1mt
 gwAHLXxWBayUjGelT6ZvfGoRXLvDpRKy7pd+ur8qBqpsAsW2mV64ZeFKCLAbRtbKSRp/
 nlag==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RxldA2mV
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

