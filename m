Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA30606A330
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZZcp4LIJ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iJYy0gg9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5A1260816;
	Wed,  4 Nov 2026 10:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uWYM9YtJBPZD; Wed,  4 Nov 2026 10:59:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27E726075B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793789964;
	b=DCzohl5SCAwgaY57V7pqHJAy2HKLc1QS6Y/Z0pAJY0KhVx7jQQfRERVjG9hlzqx3c46Z
	 PhvPrCeKXWI+7k2LWxpqFqAP6KdRRUor8/H8e76WU1XPBwxW8GbofSZlBlusLgzE+D0DS
	 vkToSxs5ReAfJ+LtaYdQeT9i/I18c/ipUFe76FbaWuZ6k72RDwS1WN88KraPgXroJCey+
	 LfoXmTJRQlu6JpuCKr59wXCM5LziPCbNVkLAD5Dr0qJGH+w1Vzz9unjt73urgAn6IaOIW
	 IhC8a59i/ce0ZvIZG0BRGDTOM/EdAUwmLE/CQ+VKQYtu4gVQTPJMqXhf3pXKM/wJGuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793789964;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0iOuQQd5/riO1Mb8wMPnllZ77IIQe5+diM3y3EzzoS4=;
	b=cmIFLgW+XnUPhJjvdWVm/TtnWbtmW1p2QUnv46bctsWlAN8BJje+ruJ3mqe5+Wlm0bKj
	 gCf65vllv8GljvH8/fpW51BVyktxZJ83GPwq+PGugk+BEvuXNmTWfbmBe04DvVIy30qnt
	 cYhk9+WmNfhaShH/bMW7bOAIPIdC+rmm0IUJ6RAw+b0c5/FIQZf8+uJzEEf4C4D3ydGe0
	 Ijm5nC/TS0Kna4KSM83cdLqw7O6bIsDJwFGi7ksJTYBhfxBKZy0JdEzYz4ATdLX7cz2Nf
	 mFthZe21vNE9dHaTNuG1ek0mBH23HoTxO5c7Q+yKOi2qEuc7r5299uq4hFs5vSqtMtg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793789964;
	bh=0iOuQQd5/riO1Mb8wMPnllZ77IIQe5+diM3y3EzzoS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZZcp4LIJ3jc+fczKHPHO/fC7QLf9fga2tbD47/qSkHmMqVMr6JkD/y0paShZErVKF
	 FYBc1UikfJyGs3qRO3dwf7a4CnTrJZl4pZ5JX8MkPD+pMt3ABAhFxqwmHRUJqklepT
	 3jzJk6vaBoOyTdOIGvUq9uo3NoakUsYo5ylyeh183wfRlfP4vTF4rLr9n2Qk+F1QBS
	 xv+dBFhcQd0epjylSbgtjGnmnU7IMC2L8GMX8kwXOEMdqkme/aLAdEhX+lyt23LHgk
	 6kvXj7f4wRVUbkSMDaXSRUnnGaSlWdzNUelsqLle0Cr+J5hEbn3iQ8G7tz/jL/4u27
	 FjxmFixGpIv6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27E726075B;
	Wed,  4 Nov 2026 10:59:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 39CC32B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F90A80F70
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lenc2X7nmBnm for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:59:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 22E8280F6B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793789961;
 b=ldNzOoqVBeI0rpfgcYTK0fVqb+7eDQNnW2zqGts8OHQKfqOU8BlqtvXKFaZRgrF/cpYq
 bjHzv28kLam4KZ2kgTiJ2QZ8GiBeER1ABdsGGvDS2594G17ujnZdjiDH0rGDT/50oPQDi
 fIFrYf6VsOjC59YwtFHOl0pRMtvfdAkkL+C3uNlNWyhCBA9/ePerTNStqMYWgKP8Ml1mT
 jo2zgMEy4K48Vwwp08+dW4UF3N22TG4Nxjj4JsCoiYYl9a7htG7meekRWSzYZokaHONRI
 BcTOkf9GPTmP7Gh04NzdvT91qHB4B66r+RrL04uPxV/vpEki1+brjMN/p5b0WZAhoWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793789961;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=0iOuQQd5/riO1Mb8wMPnllZ77IIQe5+diM3y3EzzoS4=;
 b=iScEZOGL2B7yD5HGlQ8eHyrLJgL5m4hiFjKdUPQu8dekujixpLmz0QHrj+vlc+SRHoD2
 /8Q3c8aJRyelPCbyxQRUuPSnd4FG9jbCi6Ld81DnRXNr6zsp2LzlIe7btPN0EDF8K+dPq
 sRIlCGg8aitEssYRRbjQyeVBGd5loHjUOVrAxlGY1eDQXDC0QdKV/tgptw75/XEbwalIq
 SgAx7gPN//G6/a0mzU6v4O0fNKkSPNsZPR0HxOaoeHh3DXDYrHY5GkHMfFFW7l9No8U/9
 p/krDOmxiNCe1gQf+yHTUOB684FD/cWPLNs6kso5JIvTvI5WxJH1t7kVpOJT337XFqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=iJYy0gg9; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iJYy0gg9
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22E8280F6B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:20 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso488174f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 02:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793789959; x=1794394759;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0iOuQQd5/riO1Mb8wMPnllZ77IIQe5+diM3y3EzzoS4=;
 b=iJYy0gg9DK7zQ5W6VAgZH+JBNTQ6CVWuzVsVjJr7a5M0HNVqGHMC2Yibj4Bo41muo/
 kbaePTrgzlY5p96hod31CFfkLu0xDUy0i5Em/jMoZuGJcOdp0TMi3RQnXlzncEdVoYTO
 S3vsg+NfvbscvsBYr08J0LEBpYwNTXifAmtisqbP9DS3q/LlYJBTsh4Al3vkoseN3pNo
 UY/enG1ltJ/tbxo2AO0xpPKKA09GsFZh2pOy46DRkX7yNn7KpWtfqMQHyR/jnb6xO9V2
 eJEc8XRGpryLn77ulW3SCcpWJ+cLsCZTWKk5EkhouQAPnRs/p8wqyOb/45xwKf4z0t60
 uCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789959; x=1794394759;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0iOuQQd5/riO1Mb8wMPnllZ77IIQe5+diM3y3EzzoS4=;
 b=mvxRZLLMiTDqGa3PHIAzkHVWmVghCo/MuAeq/Cy1rKSTmcNG6RdfVaDImQJRKhN1VM
 qTrUddk8qzI+pF1NGcJizYbsAkfitKhxwsdFjpqgkQjR3lxpVL1OcipLzSO/dUETd2GN
 X2m7QLn+7jnHOkznIc+l8YvoxflmbfFXSAH4+D5qIk1O9DiUNvjLfGW9RZgcwWs+GKrD
 oP5Gg4Qnopdq3xhoVfFC0uH5GcYI4mbd43GxEZagMwQ4zn2AJrS59Rb5f6BjK7oS99hu
 xyxvEdcljh/3nEihth2Tqt5cPRSReCD3ypV5kapWF0BDQiYcOWxmMl5xJGOoM0T1yMQf
 aQ5Q==
X-Gm-Message-State: APuU4Z/SSfcvOiZfnu5918TJQnubxWq88kkd7TfxH+wmIamEungEKbMC
 iBSfDqAuFp12gfLhAp4Q65Tx8o1JfMjBO+zvW/tE76Qo/odlPN4UXXaN4cHMjrrA/Go=
X-Gm-Gg: AYBFou1eje4XWwFAtlkJ7M77RMa+7qhvvLznSzLsxWTLlxpAaCyQuEGjP8dAXtl5oKw
 D/nP3h5hkpjpITdM/PzRzKcOM60zdt0yfI9Np/rL7qLeboHkd3LaSG/bHv3GRJ60+P0hQAffdZ+
 aXvBGmGt7WeLTMxXF06ggvp+NQoZ3OGsFEUiE8Q1DBRU8vMwo15EcaXt+bGEtg24xHMF7PeE2Zq
 JJXVxrn0/K0OhH4xmPvEOeQ42pPasvgNGyeT3K83PjQ9wuTETYEA1sfL+MxfC66oZzac6oNDbb1
 ax9SpMuXP4y8+a/yQ2FbimCR3joSZpLvm4rqAsFlFqgAgEiU2nCxm8sPtsIjTfaIHXslJUgcX8u
 1XVzf4sia8pP9K3x9Y2bpj6Ga4R9pgZ5LVmOPbf2h/x3FpJD5HPcIToTN4s+exMrkTi50KSMuTZ
 BacPMFOIinLhk8CvHu78tuQgUBRvU2wQoCKI+0227fYPrt3mbFr+Jn4/PCcMD2aZWzT3+hw4BAu
 yAt6g2P4XUXP3dHlkYfD6nBYMzH/fHXKHaoqEvIag7DBryfQzGZZYpo0eQf9nFXSWcwHvY+nWNk
 kPJekTcuNrldKb+pvq/+dWIvLr/0Tj1jkA==
X-Received: by 2002:a5d:5f88:0:b0:48e:6419:dc6e with SMTP id
 ffacd0b85a97d-48e6e4f5431mr34176245f8f.16.1793789958864; 
 Wed, 04 Nov 2026 02:59:18 -0800 (PST)
Received: from hermes.fritz.box ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20567sm3503492f8f.51.2026.11.04.02.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:59:18 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 04 Nov 2026 11:58:19 +0100
Subject: [PATCH v4 1/7] event: Split EVENT and SPL_EVENT sections
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-1-e211cba9f3ea@baylibre.com>
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Jacob Parker <jparker@basepowercompany.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=msp@baylibre.com;
 h=from:subject:message-id; bh=nkgUpTgpCI436hrSjjfbhyo/2P+E4YbY/CX1+UKRnUM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqzX/I9NHiVY6b8+yML/jm9V5RV+pbvfpbax/3oUqekex
 XjtvH1Yx0QWBjEuBksxRZbOxNC0//I7jyUvWrYZZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jBi4OAVgqhU+MTL8PH296eFLniMdO4J8bmx/mHdjXRnv6lz2X4f+xrtLFV9pYmTY1/rm/zm
 mG5+cYvb1b2BS8V/GEfxtE/shTeZFK2NL/gYzAQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Logically it doesn't make sense to require EVENT if SPL_EVENT should be
selected. But this is what currently happens since SPL_EVENT is within
the EVENT section.

Split SPL_EVENT and EVENT into different sections, so they can be
selected independently.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 common/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 110eaa0d0049..592720373a31 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -674,6 +674,8 @@ config EVENT_DEBUG
 	  events, such as event-type names. This adds to the code size of
 	  U-Boot so can be turned off for production builds.
 
+endif # EVENT
+
 config SPL_EVENT
 	bool  # General-purpose event-handling mechanism in SPL
 	depends on SPL
@@ -686,15 +688,17 @@ config SPL_EVENT
 
 	  See doc/develop/event.rst for more information.
 
+if SPL_EVENT
+
 config SPL_EVENT_DYNAMIC
 	bool
-	depends on SPL_EVENT && EVENT_DYNAMIC
+	depends on EVENT_DYNAMIC
 	help
 	  Enable this to support adding an event spy at runtime, without adding
 	  it to the EVENT_SPY*() linker list. This increases code size slightly
 	  but provides more flexibility for boards and subsystems that need it.
 
-endif # EVENT
+endif # SPL_EVENT
 
 config ARCH_EARLY_INIT_R
 	bool

-- 
2.56.0

