Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12D4C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A8D18144A;
	Thu, 13 Aug 2026 20:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 03qg-x1UrFTa; Thu, 13 Aug 2026 20:17:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C0B381423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786652266;
	bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B0RTKRc43sp6+4dhoEI7wzNSryH6XfjuKPjYJaLDn4+VSGNs9VXecg83oS9lKmBsx
	 Gcmby/WJdKAvlp7k4XEkcaKe/RMYZd7q1Y5voaFRptkAfddKklkeBlOesZ0d4Z8rmV
	 BqBMjFQhGBIZWaiG4Q/TrKHsyRaHRzryEUOdr07K8jQhELDVwilj344XwXIPGr8Hjw
	 GxUzmy+xJvgQ3MUAZLs+QuLWCIImo33hD1AmnmE5CEDWtxCbQqMDLJ1OwEXIS+whjo
	 pI7IxTSiaBq/9YjDpZpt0nnzxkvzMQ/V6RMYmrbSYLlI/He8jBWktsjdUZ2H/ev1jx
	 tOZy1uzsT2ZoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C0B381423;
	Thu, 13 Aug 2026 20:17:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ABBEA1393
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DDD180AA1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F3Bv8JdDaXLk for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 19:59:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D8E6F80A66
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8E6F80A66
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CKeJJlq2
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8E6F80A66
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:59:14 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4569e871502so187774fac.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786651154; x=1787255954;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
 b=CKeJJlq22mdFhn3yfEcqfJuys9xEOOqDGSkOFv69gc/jX4JiswtYJRyHFy5YDRfzP0
 aK1IabtUwGb/0sOM0cIlTsXk+BAmmMuuJVor9f955CfnGzGIeTXvm27uNDATK0yJcsYd
 5pGTe9nB7oOKk1VeUmZer67jV9n+sLgn3CEEreQarAqZY03APfLln/YtAa6QutXlHget
 nOcU93KzkQ/XqGGDHu5kpquzAwSbfoiBNnuGK7+AIPEyT10a0ChEzaR4gv2mX1EWF7Wq
 IcCKVJbfj3XHPamyExZ950t5rakCkoJ7SEmmtXvYysCMDPQrfkC+5cZRfcy1RY62GN6x
 78FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651154; x=1787255954;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
 b=lMC5SUV5jzJcYHf3ff6AgHlF5WGCbIt71N3AYUrI1katfEeF2D1Xa4IzvVzgA2Gdmf
 yd1QXBhvWktMUGd4ShcTSImeWNfK+mpzSxAJ9fpGDyPVeLd+xRyMJ7GFadVskoUKz07+
 tbEhrF4eTXJmK3GCb4FizhjM/VeiOh0S81Lf37GPh2S8BmJZB5u7w9SpQl21Co0AGg4W
 x5fdFJS54g5hfP7W27gljqCz7HyuZF6aPdeR+r3B0SDgvo4tMZlfph31UYwtBYyasrmD
 w0HcDI3rBKTD7QEhlCmtMww2mblRR6Hrwv0zVhkj72oJ8Ts82PYt7jqNJrARc51uhdMO
 BEmg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpK4i5et9teN+a1wyq++SCNZVXadfCx39pjNQ/OWUgc+Yi04dG+/5lerOqXldYHC4VbRPhl1cQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyn3rthrd2lWthsHrHFwDY2ymi2aWpLrcIDAzEBm1xPtq8x1vFT
 xL1lNphyAGCasIS8UANknLigEP9Q6QhtxJTTG+ZAc+sKcMJDeVsvmhpG
X-Gm-Gg: AR+sD12E2SkOjruq+UF5wDrj3m2r7sxkmW0N7YstGfPQeRfh9DzbHQ3txNtjQk+RqV4
 qy9oA9JJdeIVkIW6P+cTSwhNcQDRacLpkE2jqocj7z1MzgJAfO43AfD0xWDMJdoVis1Rw3GKP14
 lfEk4iiWu8otrkslD3ZRt6g51BDhLUtfZdBEPPDsHzp7MyfFzRRwRlUZHyYBxFE0UjS8pDB1Q5c
 lHnW7d/bS+ow7eKBqh9/t2d1qo6biV7l7yu9P4tIkdoM+Wiulhsmd4DyLNBmxFkW1ceecR9F8Ei
 SKz3LyFJdZWIRwrVQrTYiGlY97BLFXBsZHyi29CGD61i7GwLe4IsPuN08Gt13JQg8w5+crs9dsZ
 WSMTiuI/RhUCwqt+meaUxpXZYhz+1fRiGlkFC1KVot3uNeqFh6J7xx+BOltXrILJkkdqEbySCx2
 0iW1ZSBzKWKPUyEmV68KJ8iiw+XHdjdyyStQclGwkDif2gbDkKkVxAO3errZ3MKGpI6HA6W32Va
 VYGZpoYLrh8E1t5DnJSE/IUEQNzHZ9bY2FutYdekEUn6rFulHiBN4u7JxvMAtf9ivbYUJc21Tbi
 8dDMYSdSOR6u0fUH8JJj3HoSqQqEaKWbDzr+FVBROtuO5c1xUfsjxg/DBdAlt8Y6Bhb9l0yVU4Y
 mMYhNve4f87k8WNDQ
X-Received: by 2002:a05:6820:6ac1:b0:6a3:81a2:746f with SMTP id
 006d021491bc7-6b0d697acbemr948904eaf.33.1786651153580; 
 Thu, 13 Aug 2026 12:59:13 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c34sm3345507eaf.6.2026.08.13.12.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:59:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 13 Aug 2026 13:58:55 -0600
Subject: [PATCH v7 02/15] crypto: aes: allow DM AES in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-submit-ce-series-v2-v7-2-593fcd8479fd@gmail.com>
References: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
In-Reply-To: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
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
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 20:17:42 +0000
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

