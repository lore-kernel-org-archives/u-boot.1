Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94888606A337
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DLrtCcOj;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Sp+xGhze
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02CE6811F7;
	Tue, 10 Nov 2026 12:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 50iDwZCZiXfa; Tue, 10 Nov 2026 12:24:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1BA86811DD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313454;
	b=fLt2gI33TRqiW20FlAcsuVmPedSLqpMDRHlMrosagMgYPyA0usVzw651S3I5J8YfLogh
	 SeZFHXKKR7mHTRTMUuclGJkKRoFi5wR2nEjoKueMZXy9pGHdIMKBvk+03R4ptPe5JbfX6
	 fnLCNir7AQoPw/7ZAdqxYTDhLVzngbBAu6EgyW9asytU2KlD7byw4auL5/o+DJrVkiQmO
	 LwnxLhWoi7rbrA2ZYV85IuGeKDUu8x9NRGHVeh6litkvtPUreK6aPbY+Hzaugv6BSs7Hx
	 W/f8M2qzaO16sWNSZ3BseRDqLvlUFUAONPMqEsMaP3Li73F+JdhT+WiKvUYN6MhsR+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pnuIdh7ld/4cWhFw0fwe1nCnXPcS0LNdHs62BoCskEc=;
	b=faLDCMY+KxuPzoNZYTn/LPwKGQNZFluLuqxDhorw7oBC7DA5ZaPcF51cV7ZGPJU4dZAk
	 AZPIFeKu2tf7dFL6Tjt6tGqQXq0H8oJV2zymi5lVwkIP9yD6VxwbKraKOftOD1/lGmywS
	 aZmX3Ui9xqbAGHvyxfCsx2BejpDaJsowOS1/zxVAwIAHXFuVjm5WcKhoGlW9wH35HtGTm
	 3XkRaqutUq6ALgHhHBy1vCA3LTf0oQ73UTmn/X4LTDOAcYzjkF0oyXAPrtHgMQ6vumrw2
	 0bktfKlKbiAPPyONe1/dUkBh3jTR1k/+RyhBExGRnM/xNKLnuk9UQvthaUYN4t31PrA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313454;
	bh=pnuIdh7ld/4cWhFw0fwe1nCnXPcS0LNdHs62BoCskEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DLrtCcOjXRZoXSYDUjZlubvd9h81H2BJl8hbUfiUiJeUOfFBuhxRT03dE5JfJLXTo
	 rm9amg/120ypP8KHW9BHu86cG9aT/P8BGBgSpCLoOgUFRIWW/F3bGE2UumCpodW4ar
	 BxGX2LFR0Uko+0lFP6XtDiMl3cd2pkBgKnZ6NLj5oUeJv3EamYkq8YNpt96oO6xlR8
	 +LjJTVQWxsV+fMuBCMDGaXuVp1WN1d5EugzA5T60FW8lw7yRL97ZinjUm8piWQgRWu
	 Zl5OitQ+MIDmEbTOo2lnik7O1v9I7D3ME41OywPwrDOxMLrmj5mMf6OAZvtAi/QEYy
	 xCDKXOmuurm3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BA86811DD;
	Tue, 10 Nov 2026 12:24:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F2D71A6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C3BC4085D
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVF7jCD7vIcB for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 244A840867
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Sp+xGhze
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 244A840867
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:09 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so18026835e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313448; x=1794918248;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pnuIdh7ld/4cWhFw0fwe1nCnXPcS0LNdHs62BoCskEc=;
 b=Sp+xGhzeUAiR/Nz2jOBoUDQ8wEfge9eQ+LcoBy9F1kTPHlghqQya9ahkX+UwidaOsb
 SPVKaK1g62r+EyOBCxDfBtoYC6jqKT14XIuPY61Is0auqfKqpAH84htZfXqpgm/H6a0b
 3D8Jg+exxnN3gtBji0EJ58UHU/Qb50Jn5HTMS9ZVpghDTI/5EZ2+3FbiUSaCI+zlEHHV
 UfGj9IPNZAlMYu+3d7YzVgdoZEy070Sd2grCXw3bvxclzUCG/S1uvmxmEHkhlpYifBM6
 WoEWfrjdBw/OjsY9RR7qOaRYxHhlAVc40IvH/1ZlhUU4vCSLH9sZri1IQv+XPfFMnBge
 FDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313448; x=1794918248;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pnuIdh7ld/4cWhFw0fwe1nCnXPcS0LNdHs62BoCskEc=;
 b=W9FbTJzQZJLayKMX3+d6ESM7q4axelJb5xHU66RgL3jq/snq1U+4SCyjF+PcJcMEly
 rVYFw8IfBZuFQ6X2zui/ZdYKzutq/DTn8hcAFcc82pEekOV3N9wnJJ1Mmsg+0lmnahJV
 7Z2Sg4D7JfCLkBFCptSHYWse6y3ne4QnYFD3jFJ1tTjrQpMSmevpzPlFJ31Qm6/Pwvvv
 g01Q2bClJWjkfJKgbMLWbF1jvbdbicqJq73xtCb+zhqL94m8PAdE+N0WnkauhVePNkiv
 vtMGAIpdH0cQ4G/wKAtVjOqaxKMbtMflM04Xw3oQPi1BnP9Ga5C69kOa9eWHcgE0uQII
 yECw==
X-Gm-Message-State: APuU4Z+Hr/+ECt44wVs2S6f4jB3V8IcMmdblGb4Aja4h1u5fStipb/fS
 4Ch4nJOpBMQXkVdJpI+z14b496rLVFGQ8WL42gyoYbviRxv/ylCfz5c3PdHeHlFqpXU=
X-Gm-Gg: AYBFou1LxXQ2BQ+yUJsJMkmHbThB3uYPmUZuoR/OfNKXn4cHV2ithOmmMESWS2PQCDw
 yvsRncB8pruyUIW+CYpZ/tOYlwsZ3yYJNgJPni3+ZFA1epvayQ9n33Gdd+mm5uGSAVI5ar/hzDe
 ybrv3z1z87gcD2mUVjb1IrcxBClFqieJ9v/+QbcOaqeYJrf7Q7sENv1ahl/cFq9xSaKpaaen0KU
 IImgYe4RfceuPcNwTQlmuSbRZbV2JL7sYOl73IyhpyVQ9/ZG9c1vJ1m33TJkKg1HcfwUY2kpY0w
 uQN4nOeP/5mltnbXWUySxlPnlwuujazbNqFzVHl8KGbM6e6aBPb1YWuT7EokperIh5StHbi9BWs
 ZI50wR6ZZ0rpAI709ZPDX18faT7tEzpMSJcjwd03uVFISe8AVNt2Fi3+XY3/3J0w4lIhDcNB1vs
 ksef4R8/QcrZNpSJpQpHhXwU6tR/OjJbVbLv2YN0+bUjJI5DCPdQfj87JnesSB98rtfEfLDcM1z
 48C8A0vl4O5i2nLvsVEyzjQ0YeignSSo8jTWBwDOgngrV7VEIvdB9cKERWet1xldLKLcLtgKgUF
 iIdLvvocRQju2TNNx7Cu9T9ptjygfnDc6VVxvK8ii77tQLcx
X-Received: by 2002:a05:600c:1388:b0:4a1:ddca:8b66 with SMTP id
 5b1f17b1804b1-4ba0235792dmr42930725e9.31.1794313447818; 
 Tue, 10 Nov 2026 04:24:07 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:07 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 10 Nov 2026 12:23:58 +0000
Subject: [PATCH v2 01/12] binman: btool: lz4: Update version regex
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-qcheck_fix-v2-1-1c76e0b68f29@linaro.org>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
In-Reply-To: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>, Alexey Charkov <alchark@flipper.net>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.16.0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the update to lz4 v1.10.x the version string has changed format.
Previously the string looked like
"*** LZ4 command line interface 64-bits v1.9.2, by Yann Collet ***"
and now it is
"*** lz4 v1.10.0 64-bit multithread, by Yann Collet ***"
The ',' following the version number is no longer present so remove it
from the regex used to match the version number. The regex will now
match the version number in both of the forms so will continue to work
with older versions of lz4 as well as newer ones.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/binman/btool/lz4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/btool/lz4.py b/tools/binman/btool/lz4.py
index fd520d13a56..fcc0d91553e 100644
--- a/tools/binman/btool/lz4.py
+++ b/tools/binman/btool/lz4.py
@@ -76,7 +76,7 @@ class Bintoollz4(bintool.Bintool):
         man lz4
     """
     def __init__(self, name):
-        super().__init__(name, 'lz4 compression', r'.* (v[0-9.]*),.*')
+        super().__init__(name, 'lz4 compression', r'.* (v[0-9.]*).*')
 
     def compress(self, indata):
         """Compress data with lz4

-- 
2.47.3

