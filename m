Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4948606A333
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZY/vzx+T;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=PJrYq/e5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60918406BC;
	Wed,  4 Nov 2026 08:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sF9Nuzqj5ZEQ; Wed,  4 Nov 2026 08:50:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74C4940663
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782259;
	b=fSdfm02nrwIBJhaYGB2u/JAR9DhKCmHp7v57Oz7cgL3UJpiI1HI74b3BnM+LKVTM+PhI
	 SdPPS39JrEMDl3u+B5VC4MtNyvsgGRxq6sG7RGsgwV7MB3+qCGaRgCDSYXLG+Vwok3o9R
	 UBhvPt6TDG0e2iYrjF8S2WIBVPjDtKvaEunDsFuQaFJkaIA2Isf7DihD+HSWTGHFEf78w
	 0joFhIYGaWF4ecxpG2iyv9McmZwkxXdODci4nlL/sN1arUzdGpHaBzf0u5kJ0LAjjaveo
	 cGkPEOcpMzSxixu0bAuOvyMQ5pu1AMttSj7oKGAxTsACB7dzxvIictd99XPZOT6boVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hrzWhIYz8GDLcy2/XUJgVEikIrYm9v39jncqisTdzPY=;
	b=rHiMXSF/oPcP18YTmR+jThEj5ggc24NX0/PsLIzWuudq6K/VO8Q8Yu48MNR1Z68IF8+8
	 +HYzJV9rIW0jlnTD9jThsGZl+KlLYkkMOPXWs3M46dcGxbxPnqbqGES9S1MkE3XMzkQbX
	 29vK5UpOw/1wchqnkWWO1NWdG5LdvkFzfVU0iMu+sDLL1pMlb88lWMRMmy03veqNUMSwc
	 10cUFWF2Mojz6iYKxfAi3j+uTk+toGTwDZAwJ/zId6ZR2qw2AmuBd9Lynq7LPl6iDlFXi
	 EO6Tca7mE56rRP/YOn5NCcBQQ33iRnzq75TESyHbpVQ2nVqstTqzYklFlPcy3abd+mQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782259;
	bh=hrzWhIYz8GDLcy2/XUJgVEikIrYm9v39jncqisTdzPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZY/vzx+TTfIWkVnxaz9Um/xUoCILyrLMVD/KPJuDXBUFg7rGDl4l9STga+SL7w5dK
	 t4P7EXstS+e6gguwq7WYf4d57goxN/qUY3SE5zhloRtpW/f/7PQkUdUu+jYWaecSLv
	 jB2jjtVzbRD/44rlBwYEJpKbQUvvnbNO5y5z6zR4QltusBnzDBMsCnHB3ZapAdMgUn
	 JA+6FNC5jcJ+gsIuTvlVyMdtWJlbiiNzAzxRS1ZzlOWTSmibIdDYyRV3StP5bySDeY
	 CIt9WRVeyCjsACAGzqy4tt3ktQwk0s7q/gvsZElpoQ4KTDEaOYMsfiSyT7kxHZAExy
	 cDzyGtsn3of6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74C4940663;
	Wed,  4 Nov 2026 08:50:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C27319C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B422D401FD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:50:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fRbgivdu9usC for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:50:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 84C104004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782257;
 b=ZtPzeq2y1eMmD6d6q01fEqGGrFTVthAWSDqDOg7izTTIg/gxkODdWLgmVVf29jjVYpQQ
 y2T8yBmRe7IwxmNQKHvjuUFXQAJd8mEiZiz1D30yZFhPaxYywlh8W5pqfdJfjpP35HJi8
 2qGX6PLO/Yvj0quGpZqilie6t9SQw6ijnX4DemFwGJsNqDi4MaY+JwUjmq3auDAJ/+YHo
 yj5geSMq9vID9cNYQo/K7w9QEiw9Bib2FFr9JWs29fHw9xmfP7U9x4MgTu5mrHUSrXffY
 fcrQM3bx6pIyVe9Vfd3nj9rjeYZUzmQ4rQZCgX8P+lU67UQKe6a7DkP/P5ud07gKbxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782257;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=hrzWhIYz8GDLcy2/XUJgVEikIrYm9v39jncqisTdzPY=;
 b=byGIxUyt1zOLciCaNR6hTOi6JfrSG/mjXO6Ism4zecSjWdnfyYu81tH8LiIZj2NRBRWD
 REfHaAKILXkB5WhE9URiVwt2LlTutxjzrdWNzGL1nsLLtLCYc7i7p3y6l6bDekhvVpwGM
 AC6P3GuoUh0o4RR1zgEKcBXO3gcK/gtAHOsQuSzQe5hx3wA3raYUw4Ak1fzPyosLW56Ng
 l80pE5AaBIq8/osKY+CaoE3i1U3aH4U4PCIx1jqNJJa77lFZJK2Ro7g9GoKEbM64Fyxb+
 9PCNlmR01f/eKLwGVMMSK4b9qPDuqhmdCFkKg7jKDdizWQVvfGDXsJahIBPIUdqfpzQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b="PJrYq/e5"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=PJrYq/e5
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84C104004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:50:55 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso2546955e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782254; x=1794387054;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hrzWhIYz8GDLcy2/XUJgVEikIrYm9v39jncqisTdzPY=;
 b=PJrYq/e501xwPEAnr6+uk8nr9lgRxrncV4d0ihr1RfgfzqSHmjRRoo1q1/87lAkzap
 zQc79bnkjMQhYovhUK3lqiqtqSh3/qzJ90380/m67D15PzpKW0bPTB8oZcRhpLPPcDLI
 8gD8QzDfzIuvMEn5qgYP0cZYP4QJxZMgeqaqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782254; x=1794387054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hrzWhIYz8GDLcy2/XUJgVEikIrYm9v39jncqisTdzPY=;
 b=26uL7DKKnOecAqxdK2ye6MVkEQUR6yfjpq8pX0siwIkT92krYyY2c1L9bxB8zduOUj
 C7q0ySGVisRsPZmI0Wzil0xEB2rlzRqWV76VVMxVkrSqGSgtNYueI76FcWXygImH3KML
 1XecfJxDKbIBd8IhzoyalfI5LcG4boGy7rcVJZWw+NHkm3KOCWTkd6Y5osSDapc+IwvM
 bEIbCa9xd1EI2vQzoBawASTT5mbiqUVt0qtCC7U/5aH1xaRbX+5iqAHSCnpgG7GIr/Fy
 L3MzNcDHTKw56yqk3xPQfhknYEP+Z+D81WNY7/72P/813y4EGEK5SQllWChNPPwkieRh
 j21g==
X-Forwarded-Encrypted: i=1;
 AKwUvBydvPC/YkId0SkJKiamU3+T1DYcPkkKSVqdEnQrGm7iYFd1pS1PPar+/QPFYKcSqmmxWr/uL24=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+aGh7C+/Y/jrlR/iKPZaGQUN7GxWSeyrzDQrCbTS9o6LXJ2Pfk
 kOWc82S0n6te5Pk2NgwRCpwSW2LDXzhhLvol5MeYOTE7OBWl2s2CHH4QazJVV2qhoqQ=
X-Gm-Gg: AYBFou2tq6JyWvD3Lws6TcNbE82jMR2tbXbgcjPRcOn4cx/11j1bBKFRmPynO+eLV3s
 pGH6PCpk4Vh3v8oHgSKdjX//PGjvqC9wU7Na0JIb0RH5X54IMmju3JhnJEjwfqCzQjuWpOBL8ib
 hjqjOBLEv3m1hP0VfkICccE+8Jyol3h8zwNGHYjbRrR0M3XNDyYTkl8fl0nNcp24CCvi9KorbtP
 7BruB9gn6TZVlxA2OFA0OE3HDu2or21ox+0N04ZNx2kRTFsmYZRAngrXoPY6E18nBJnOLZ1BVBp
 uynTAQlHNFJgrsL3um4skr12tQEJPX99P28ap+ORn0/xXffXYGonlxln1fZapYdqA9aGxFOR93n
 4sjJjBW+qbF08Rt5fAR1RyjDJgbL1dSoroZBGnPKdFBLjk+tm91KF5vYyOi17pzNlfrtKQxbsNI
 wEuwTU0ezLO9uGEAAP/MzrCeD+VdWJ6YF2ZRoL/01t0daM/ZFN6J/76krhLpWFr6afa849Y8og/
 ke+3ZXt8SYDqaTMXdXHJTi7+rS1CkXry4BHmAdeU0A6wfIHTZarF94XtrtCVQWqVaWW1ybOyGcc
 Y33hypiTYoA4g8zvhy8VfI5k6CdTMVPQ9XpmezxGOpSyJpsEPcXxVhtU7NscA1ZuKkGPcTOlGBW
 lPCrIyUU8POt2IsIViwtpkRqO9Sw=
X-Received: by 2002:a05:600c:8b46:b0:4a0:4a8:d444 with SMTP id
 5b1f17b1804b1-4ac18c73238mr364657005e9.33.1793782254035; 
 Wed, 04 Nov 2026 00:50:54 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:50:53 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 02/33] arm64: dts: st: add power-domains to sdmmc1 on
 stm32mp231
Date: Wed,  4 Nov 2026 09:49:35 +0100
Message-ID: <20261104085036.4012238-3-dario.binacchi@amarulasolutions.com>
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

The sdmmc1 node was introduced early in the SoC bring-up before power
domains were systematically mapped. Add the missing power-domains
property to align it with the rest of the peripheral nodes.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-3-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: d92944ee1693b20c71215c3ad1a1661f05e85108 ]

(cherry picked from commit 38e8d79eac568b36a01076a5dba1e85676eab895)
---

 dts/upstream/src/arm64/st/stm32mp231.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp231.dtsi b/dts/upstream/src/arm64/st/stm32mp231.dtsi
index 9e1d240888ff..0feb8943efae 100644
--- a/dts/upstream/src/arm64/st/stm32mp231.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp231.dtsi
@@ -727,6 +727,7 @@
 				cap-mmc-highspeed;
 				max-frequency = <120000000>;
 				access-controllers = <&rifsc 76>;
+				power-domains = <&cluster_pd>;
 				status = "disabled";
 			};
 
-- 
2.43.0

