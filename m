Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080A606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ej13j3BR;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=O801jt9Y
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 257964072E;
	Wed,  4 Nov 2026 08:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3kcyLvKATGpK; Wed,  4 Nov 2026 08:51:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5F8D4406C9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782314;
	b=e4ZgLVSQ3Mn1IAukiq/6A25pu+jOe70bpcaO0rgghsSoxIjaHVlTsjOtu80oPI3hRfMK
	 2Py6Uy6jyV2YyZH8A9lsjmQoiN/T9n39J8twaq4vvRctMxR+rM0gXOmZ2p2d+Ruz0+PRh
	 iJ8RlOGHtCAi8u6OSC3TYlM8gkE2y6Qgxb3H1q589xOkihT4n9QCx3CPJ4noqO6NceHmM
	 GK2suTLS7F/yDmXnp+9/S/7d2tOtDP0iBsi+33kh139G/WA/t9A3CVavDTn+j5aN95Er2
	 oXZEfpi+ehJ0V6mKjKlpZc1zVaJ2/sAOtYBk9VrIOmDPfFwPxFrgPm6L/fFtax8fsRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782314;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l9rrMXC6X1fSPH8vAo4ey0QLfdOcPALYQYlZkWxLyLY=;
	b=j3k9q6bB0zsarVdvtbH4wIpR5t1o+XKu9dASAa1i5Sj3YUgN8s/HDV1P2CK79hhVEGTI
	 hLOYzExg6BbGHaVZdoWGKErcjGKABV64pCrgIqcqg/XMP7JeF5r0KzS3W9184pyyuAZeT
	 6zd22vVHL583IuT00AGgtnN89xZqet8G2KVInJ2ktF2Ec6zELovBNbQ/lwjvllIpKjh6v
	 Gjc9wOHG1hCik2Yai/jTN6/HEyybIIsRuCSh/SUhC+E26yCrSQozBD1I79snnnsPaRJDY
	 nKYIx1o77kPgZsnuky+CdJsMf5i+IPZpzhLsDWlA6DNi5/rFVgg38NM45r/5TxINHtA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782314;
	bh=l9rrMXC6X1fSPH8vAo4ey0QLfdOcPALYQYlZkWxLyLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ej13j3BRALE0BmeWTqaHgKvac8QBg7NT1qmDeIwws4hWlt7F/D7rZDeF5zwHqmdJz
	 rN8ac001Ts6rigvbxI1YluMVO+4BEQEvIhGPeZ8+UicDe7p+vUpg4zh86xxU2aV2nx
	 WuIPtEkE5qMhTZ7Zez7/ZzYgJRuw095DAJpKyOL474LpkHhI6JEe5Klhr5JRAEXwT9
	 G0nXgHhX6JpwhQpC9vTmmTVsLBV1XoKgT2Zl3H6JzAfaiJwPOWR48TsvsnTyeA1/OC
	 E3ZqiW1tcbHGwZ2jyyTwHOQxlE2FNp3i13GnCv+oW/ya9Q6sn57KdGFZoOXA8cO89c
	 +sD0rpAsLuFXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F8D4406C9;
	Wed,  4 Nov 2026 08:51:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 85EC32B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77A7C81036
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qHDmTaRjx2cT for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9289C80F44
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782311;
 b=ibq6pFRx+PGsfnk4yYQecO2FHtvF/rUxOr8UJyHjISWNu8yNEVoxEy5K+Ww0untSRa3K
 TejpAAg2tgpvx36dG+vMrrkAdgzG6gH5y6MDpBQJ6S68SB2PHCjN//cZIWryfvZCD820I
 WQuFAlZbCFGyRzSGfNG/3Cllxwx2WJCAzQ1y1Pa8d4Cvr4upbnC2m69x6enjTmCXISh0L
 pRD7RNXBFIPeShr2pEMTgCJzDvidCFVmTXk1qUDeXCSPlEUxO4dz5YPIYCcMktAuU60ae
 UR7oz4nlOUmEKPvKgjW72AlXoafXcfRYIQnLa0rqdyUaiPBGIjUtPQg126lHLdVfabQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782311;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=l9rrMXC6X1fSPH8vAo4ey0QLfdOcPALYQYlZkWxLyLY=;
 b=GxlHLSJJcuYYLXvk1qZgBp+6t3hIfc/WwUcOvMhgFpfaN7cp5uvle08SJ6rxQs2XHxuo
 R25PQ2eF6AnuzjENmk21++XydBRSOu4HgD5+KOu+b2Ck9ePr08WzAGxLgerNMamvhGNq2
 xeu8CQGW9RI+jjt33QffbF3MHYsRJxooYHSV2/7vNW/TW+Tuv8J68VWDH7hh7PJhnYovt
 9HyT2w4GmiTusZ81ws3C3SzKgu6cEd55TIdd1Z42fmZniA9/S/EerqnrVfynXt0aP3SGl
 aD8xyPSAj9ssNNLaeSCN9GNrEJjOoK7XEK2KXQQBbneCc3onbsiUbjFVdSafmesCBKQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=O801jt9Y; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=O801jt9Y
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9289C80F44
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:49 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so4110545e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782308; x=1794387108;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l9rrMXC6X1fSPH8vAo4ey0QLfdOcPALYQYlZkWxLyLY=;
 b=O801jt9YhaLDa91xg6rkRq42NCpLcTsag8F5AXAcMO3jAd+Cq8A43Hn26d48Bk/1nl
 erjhjdtrNnG90nHbZYRDRTq3tH6FNRKhfD1A5uzJRjaZXOXUd0xqFyvwTIZ5Q3oGHh6w
 KzJZRyakIvodtOBWbCKuU0x3wXCcQXD11E/58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782308; x=1794387108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l9rrMXC6X1fSPH8vAo4ey0QLfdOcPALYQYlZkWxLyLY=;
 b=PXD4lNEwTZbNuHV7CVD5yuKAJRuPMLmNzmkFBrO9dtBiPUbDfxXo0hUQbeRHvk1vkx
 9hc3w26iRniZg7yPJxEM7SFN1iq9aC4WKmekZjkV3gr+ucqy5ykhk5pN7lQV+F8QycUI
 V2yQzGnApEjbmq+OsyJAThuhtcQJfKObaAhVdF9E31p3b4eL398tPR4iTe/qWgKulhn9
 z4fFX5yrt5DYSWGErt2vY4cXYxEUf7FZEyRZkO0cKGIK8MEe1CIqfw07Vd4sx4lvbIcB
 ibRv7LK75GAPEB7KQVxjKnKol2HKrzZIj75JM+uWoSuf6YxwY9yvxbKcSFiFS1y1lX+K
 OSyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBze4g6576i/zZ+3MqLn6PKQ8l1ftZeU7psYfV7e/gOLslwL8HNOyQSR8daBaNtxZutyZxx6JBc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9UArjV3YzuO5rBf4qAc7iZxWsW2dEUq4lUXwocwesmPtDLEo9k
 MH9JA7cziGukVDta0N5wU71DF6LuMNrPfK0+WxPUHSj8/3K47g2p32p3fMkSlCXrmug=
X-Gm-Gg: AYBFou3VZj3SA/+0eXTJP/sViT/LT0pzYK0Bc+JjyCqt/1/moasEe1QNspYFp28HYVM
 K3S+eLo+rOiyRUQn7F7UwlmeN/uqtIGn7gVFY9ohJAdbFWoLuZVjgjcweqoUic9bcrIZbq6HaCJ
 SDpdMfovkpY6RtfFk6AbWHRZfpSlwsnQMECfX1mbXI5gqTQUnzAyrEk+B7CtKkC/0DK+0aInU0T
 MUDKBBbqIHbVBLMa07684mjiKgErgmt0TObFwJmFFb9gj5G6jtwT9H6A4QjkADo4/rmrHtC8WxZ
 Fv7/PxZNPMbmZrWTPNeFdEo/2zpSChj4PQrzTMP1pGYzNUZ/SiRveRxzVWdiLYqNrN1BewqOhxa
 gcbOSLUsTNUAw6YdAtbQfwNFhoLvRZmFlJ6jcflEBIRJvs9u3atpYzmKiUTFvUMkA7Bi/33fr72
 k61A7ud/KrJ4Srf71tLIyA6icK/XuDnun0vodN39iJ4ffNWK+MN8viftrIp+GHmUWkO7ejA5cgo
 ilMIBlGKnqQEpDUvBOnLJSS9yXXgTRX73aLKGPipZV1/6soAFI/DzWVL1kXU3Z0YitjhRyR4nM/
 KEpcHH8wtyxbRw/U2cNOEn59qGg141avLbQVsQXe2V+ceay3Id/7H/5uSeCa68MigGWaoX5Zbgh
 O349pa4pDyLG2jT3j8gEQChESzdE=
X-Received: by 2002:a05:600c:4e12:b0:4a2:a9:ed87 with SMTP id
 5b1f17b1804b1-4ac1765cf2cmr367009875e9.19.1793782307944; 
 Wed, 04 Nov 2026 00:51:47 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:46 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 18/33] arm: stm32mp: stm32mp2: fix off by one in mmc_get_boot()
Date: Wed,  4 Nov 2026 09:49:51 +0100
Message-ID: <20261104085036.4012238-19-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The > comparison needs to be changed to >= to prevent an out of bounds
read of the sdmmc_addr[] array.

Fixes: a3be0ccc4746 ("board: st: stm32mp2: add mmc_get_env_dev()")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 board/st/stm32mp2/stm32mp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
index 7bc7d2a608fd..f2575339b990 100644
--- a/board/st/stm32mp2/stm32mp2.c
+++ b/board/st/stm32mp2/stm32mp2.c
@@ -132,7 +132,7 @@ int mmc_get_boot(void)
 		STM32_SDMMC3_BASE
 	};
 
-	if (instance > ARRAY_SIZE(sdmmc_addr))
+	if (instance >= ARRAY_SIZE(sdmmc_addr))
 		return 0;
 
 	/* search associated sdmmc node in devicetree */
-- 
2.43.0

