Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363FBCCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81621814D3;
	Sat, 17 Oct 2026 04:36:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NFeNNLeT_5FO; Sat, 17 Oct 2026 04:36:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BA1F8814BF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211783;
	b=DTm9e5zK0onPST8WN0CDewPCQrnaxWWWgeLaSYFNCDnUdagSnPYYnw9y6zE8un+3OZaG
	 Ytt90H2onHrZXXm77y60eXq+KxP8E9ybPT3BQyLpoAZxDBAkaHjkLLGQzKd15urQgStrk
	 gnxbbntlW7BcuZ/ZV8MEW1ESLmfswKRN1kGSsSoyYPpuY4nVZo92JOwq4wD74LfrDC09H
	 hS2xwcHkHn69ohuSqHeOZuJB8mJH2ve4GvL8G0LHODm/p7kAXdVQ7dSwC3yul50hUb7Dw
	 Kh9lof8CochgLzGEBGXP0KfPri0kqMmnHhRPffxWQh3l0dn7vu5+iYpd+qWr+2Oe6sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211783;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
	b=BEe113uwGmXKN47PRDbxTO+rD4Whns0QjO6/PboSHXmI426CZ7JUWS1EX03/TZ5PF1Kb
	 PRE1NtEfAb8JlwHfFMYixoWI2PqW15WCse6PGUkzNlvP+zuFbXwQKRVz+tdQIRLPXUqd5
	 c3SkOEwCqdPiDlKpcFj1xL9qHStK3OqtTZmHRFOMeV7SoxH5lt4Trym2AJ2zh0Twg2IwY
	 S4qQ8ToOHhzCTBxFfwUoeatsXRVVfjEV+d3fYJUPCFFod0xw/Nt6XbBMcXGKpfGsqhKZ+
	 PXdiDLpIUULY7hi2SXeJ7a64TdHAAXPIxTiYmv1pBwOv1Bgej7p1rx+Rpoc3OfPSryQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211783;
	bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mg7ZYkaEKvZODsKobdXp9CdgBaN33Xp0s2UvcJfFRK4uF9u6jSSFrmuGea/eDtVal
	 uaq8Db4+qLNU5JQntIbMT/gsYl722CA7Bl2etal4245hGYDtzT6sWlTCb2+yxY4iiM
	 yjmV6J0chNs91Of66ZA3K8ILihCPwYE2nmWAJrkXSd67vPpiUtSWuFwdTUwPYViGlm
	 9kQX7153GjVQPRX7THJrMxbfdaIZgCXXSyaJYObifvtJHazZmiv3m5p7h/KWVhjsfm
	 t3w6hbOKkm6gH0GAGowAZBm8AwMgMUZRlIchx4uLpaYzlnJL5a0Al01cwqqJAfgacm
	 dXe5NjomjUhkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA1F8814BF;
	Sat, 17 Oct 2026 04:36:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78FBC362
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F773408BD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nHS_jLzHtko5 for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:35:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9A2ED4022A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197338;
 b=TG5t/R+0GbL2uFL2Ou0JrMPmC2jUTCKERm7wEA54Bb2J2pSzJVtPHHRuJf3q8Ox8MWtf
 y9pQnmfL21LIjUPcqpQdO+xOq7lyvHKDcL20q+HNsdxacjG4raKulpjzMod/ghshsiVH1
 y7voEDzpSNKPap7BnC6HATla6yS9/GRjsFuliEL9GY+CLMzfxbp5hQ3hLtWnGg79zFSkJ
 EVQ9nwHzuAQYxt/wCw8BSbMKENYNJIszPj/O7ZoqmdB3NIqFqxRGL8G8cEhMxsnUpB0HQ
 j30RNjfffOw9MgiH0iHvHPj7H+eUAhZ97tlMimWFQ5VO2adHiYwpivjydvz2tmKHcHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197338;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
 b=FAkWS/P2PuekH8LV6tZGWuBwBivOpUCUL6iP+K2tiIDmKpY12/97HyNIT/7OGpzNl3G4
 xA1g/GqKAZ14e6nXjoPLJZMk4/3lMbLlSjWoFUnVhPIKcxFOA365dqkTzuEHbYQIJK3qT
 ilnXPU+V5hy7wAIZENx0R9xdymAgIn9voq0lgHNWSDhq6UT1Qf9brBS7voWBhFL7FIQMp
 BwPj6VWUDYrz2q3EzVMBTxPda29JgB2rFG0K3Koezbk/ddNJQqoMbzYARJAe7q/lG2pRH
 BxXqmmrpfckdvfEqPkZcHpfbjfU2NqL0YViMJiXOfOmyOrsQ6StqllZ4u2mReWhmYXw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kMSiVeH3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kMSiVeH3
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A2ED4022A
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:38 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-8266c388b67so295534a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197337; x=1792802137;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
 b=kMSiVeH3Y+pktiKpi6vNSBXuUzDo58LeqDqnN5o+ZXwp9gBnnsY/GGM9qc2Hz5l4jy
 fsTTvL5Bl9vu8Y+F8p264cBY9xYDGxVYxTcMvoWoI5y+nDn1/6sRPS5jWPOAWdvVxwqg
 L3OKNrRltFGGPWjOQlsJrQVMTTsZvW+yMfUXVc/FSxS6rBBlQwcbOeo1S77BbZ+EgHh2
 lhORq4z6Y4GeUIKSyuQySi+Vb+J4htMvy4QP3KBOFJxqYHG5Noz+6gzwmhFx6vbBReT8
 tI13KBclAfe2GwsHMPRpC4WEhU26KvsH2tzFJpMETapitoC/G4XnIjBJSxDjVtgkRtWt
 R+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197337; x=1792802137;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
 b=gMocqudSCMo5t/pkM/ORlMm0iF2i7YXn29hyH4kd2PXY7DId5PrfX8t8EY0onA3Vr7
 +k1d76HRSuIAlZt9gitkW2WdQsteTWy8tBO27DkNcE47We9a+xZJLt8YQvCox5R4OMAl
 x+vSzvG9aYcRvHMFt147Nra/5Wx49xxA2zlRx8A6SrpUonbuEUZXevbAJdEZqa9NWgMj
 0zOWULMWSLfuyCr5eY0mJJjbmzax9ZdAxOilIRgVk0sjdUdfD57wXGrGeoNwER0DxE7U
 m98Kh0rU9mYKdUxKOB+hNmtuJSczU5z0NqrMI3aBVVSse/i9GDemYECfdP4Vl3XpLjrn
 Khjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoOt7PMfqGKaQcpaQ/T4AR+l+CQ6d62lJDZ6H08Kk5wDmo3PwAB7zr8QlWHgQ08GUvlnxhShc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJfBK1QxXxWq+NmkpGrYav07n4fRQPx0jWYnR48RHeoXS/b1MZ+
 mPdHjLWhC+Y8b2u1hv4QimPsJD7rOnL17W54144FPwg/Q+D8yflGKxma
X-Gm-Gg: AYBFou3otU+WYU7JZRicX1RmvWX3UQxkKWDD29pKLuAMWnPr3X9zjb7vm38BTlXeNLg
 39u5hgP0EiH1wR5E+FTBysAatz1g7WTOszWT2oEKdNYCxdb4510LgVcLxgXDLDok7vhamTRjkLd
 V6wrSE3WMkr2fhDapgOllrUGW9fHHRaxWZhl7v1dh9S5wj4PgZlAk8OI4E45dYuq6QFwVGGa47i
 I+Q1tJgvMaTzZqAYXdVOwYCFqLjouvfJsfBOG9Tw4x9jgOnrJCHHoRr0lmQ7FW0HJJmmd2KgoqE
 +PD1z/6Idk5/VRKYIseEa068bqYEyuJ0JMbWkfnZl3YarhjelwUc7D5wjKCeHmWgCoZh5QHxgYm
 3/ttDZuyv6Cwq//S2b/gqpqWmzrD7oJ/r7/ro2kDc8yZSyQ+Ud9OwnBWFIxKBb0JcdYlSDFguco
 QCmS1EzRl8t8yd0++Go0wcLL84irTFl5YB+S/cLgkjyePYfAw89Vu5LNImOygj0vKEMrWz9lnJv
 nQRsiFibgdVGSh4Fs81vLNCilUOT2btvnhADWtCnVIZc1qz1ienxIsGzK2twXrqi2w1JsAsoNp+
 YMAEqiYKaHWeth3+p2uezXyCqxbnW0kD2vW1CKtmK3UgQ/EsiiVGPMseBtWsMvwpEwJnf4ckPQ3
 Nwidt22tI4KzGIe4tdOvWGvo=
X-Received: by 2002:a05:6808:2215:b0:4f5:6fff:3ac4 with SMTP id
 5614622812f47-53cd1cb5b4fmr1157317b6e.41.1792197337114; 
 Fri, 16 Oct 2026 17:35:37 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:35:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:16 -0600
Subject: [PATCH v9 02/17] crypto: aes: allow DM AES in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-2-c24e64daafe9@gmail.com>
References: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
In-Reply-To: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
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
 Andre Przywara <andre.przywara@arm.com>, 
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
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Pranav Rajendran <pranavkasthuri@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@flipper.net>, 
 Lukasz Majewski <lukma@nabladev.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 17 Oct 2026 04:36:15 +0000
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

