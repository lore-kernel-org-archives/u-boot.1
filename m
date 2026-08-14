Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69208C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 08:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1537980F6B;
	Fri, 14 Aug 2026 08:18:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JsXyboFoaIfE; Fri, 14 Aug 2026 08:18:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2ACE780F70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786695481;
	bh=JnRK987cswwj+3tIOLEVYw1O5704stHgAtKhqCm0iXU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YLUBiLnXqxkEDk8Br/6gw2tPVCMZ8LD90f0pkaE70XU1ReLY3Q7k8vDd7otPk3z9i
	 C2g6p9K/K0ld31aYE77pJvU4q1Jx5kqDQJ8cckQ073YDfcbc25n+kGBHXZPIsgUx2r
	 J58lQkSdRgp/Wi/nMOlPJ1O3uIWxkAppHKOjybigFroaOE6ugJepv+okpuD7ZiTXU8
	 44xwvshfq+NpWktmP/n4mjMPU9RxUvcY8/uoRrEamrjxmpf9CrkUge1D/Dgov8ENZG
	 6meAmdlwIMza9hzFpDTw8mjr6v8w5wzFCao5AiUeyVGCYbPmHMBx3tM6ABy8MJJE4p
	 8pYh+qAcSw+iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ACE780F70;
	Fri, 14 Aug 2026 08:18:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B0ACB139C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A288D6068F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1fuyRzQYAmvE for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 08:17:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7B5876061D
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B5876061D
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XMWfGVGC
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B5876061D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:17:59 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so6795695e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786695477; x=1787300277;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JnRK987cswwj+3tIOLEVYw1O5704stHgAtKhqCm0iXU=;
 b=XMWfGVGCkJmFM19pE6weQpYhiTaNi6o0PA+UFAWmLOI5ZygIwaGWq7E1C5EW487J8G
 BQmfs6+GvfHlwqam7yWDLLl00X25QQg4xqkJigCsdL5Cx6Y6rplIyQ2Uk+hIRvGIPfZx
 +jt242nlge9ouL/Y8puGjYcnKwNU5QkCzZ0QaiB98vnjoPiJmwopV8vDW1+FejO45pxE
 rui4nylq6isbUM/OyCNMAGUb1fxTArM5jCrheNue5/LRhssYp0w0C5YCPHBCCw0qpLdm
 PZWHwl0dJd0CYBBGI1GBMyzIAAf3sG4E+pICrZflkPGQiYBIm53Ax2nMaEXmxqYRmtUQ
 CXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786695477; x=1787300277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JnRK987cswwj+3tIOLEVYw1O5704stHgAtKhqCm0iXU=;
 b=KZ7fxD9TMPc1znSOOaqzOce9OpAfOxOeRTcT36OMIDkApjGN87chNx16iSXmszwH8E
 TyJ4jUkKKI1BYXNM6i3bcZrPpm2YBhsvEs2ACJZGgLAYauNiZOl9Ixjs3jA1HxS2ihGY
 BBV3/Ae7DYrq467/dJWoB3KI8xNESW9T2TGnqSN2qNOIPRsQzGZ1VhXP67JaqkZ4CGXh
 PKDsBuiReR5Jn/q9AGTjCM3/NnXg0PKj5+1Sg7wXwPuI2ze3Gp4BoAsd6pF9mjTgPn1h
 uFN85y+VAmlhP7cFoD/P1akI56rPhu76uTNPDh4OE1DqHXrqaG8HD0drn6xzUzW7q6MB
 KKjQ==
X-Gm-Message-State: AOJu0YyGPIb+jVYHsFW0Sv+P4UhcFBRiV13ijudiUNg3hZSRSIlHty0B
 k4Z1KQZ++O8qsPUtYg39aThhTZDqkJdFPzny9TaTuSg0adsjuRhkMzXnfGlV+pHm
X-Gm-Gg: AR+sD10pPVQH+QdPU2mpR4KDwsy/PaMsR0Lirc3h31L7SRp9Zik4A+0UPrG9Q9xTXo7
 wukltGGz3negU8KnHIjIIXdQ7gdtgpE2LnI61YbPJWkz4AmHy1zjvnsQoG8PmKk7JgJavBywiOL
 SUWAv9O4nBC6t/T/jLNoMJUYQ8xEKO2KHDBR8vsIAR3Q9HrNuKZDs9iHFtRTWXUdEED53wvRU9z
 zXrL9+xULdnBuBuUnHWfniswifxo+zBI1nzAoK2QjK57sSb1gYPU02/xH01fqoWiZ/5s2u6fLIb
 +lGdb6ut+d/B1yaqXV8XT81Z4znmLDdefzgAP8OU/rETGATaEqPLkC2iX9CKn2dMPeMSlahHRdh
 MNDUrVnaFXSfNxWF7HjMnM0pEqF248BbMqFjasOrGC5vgoUqUvVLctMq8wHWvLPjWxAebuu0Hg6
 yWrFw+jIo9Z9TkQ2wpjp+oGpWQMrXLQUNL9uGg5E+8lzjKir/6nU5z4hHBXvD5H+PKY7l/YnXgx
 XnN
X-Received: by 2002:a05:600c:3398:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-499879298c4mr38155965e9.1.1786695477415; 
 Fri, 14 Aug 2026 01:17:57 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b203cfsm33918625e9.3.2026.08.14.01.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 01:17:56 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Francesco Dolcini <francesco@dolcini.it>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Stefan Agner <stefan@agner.ch>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 0/2] colibri_vf: fix NAND boot and add the board
 documentation
Date: Fri, 14 Aug 2026 10:17:54 +0200
Message-ID: <20260814081756.2498285-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Following the CONFIG_TEXT_BASE report [1] and Francesco's suggestion,
two patches: the first restores the text base the Vybrid BootROM
actually accepts, measured on hardware both through the BootROM NAND
path and the WinCE-era loader; the second adds the missing
doc/board/toradex page for the Colibri VF50/VF61.

Changes in v2:
- code-block:: console for the shell sessions (Francesco)
- drop the TEXT_BASE note from the eBoot section, it is SoC scope and
  moot once patch 1 is in (Francesco)
- collect the Acked-by tags

[1] https://lore.kernel.org/u-boot/20260806124816.262259-1-mehmet.fide@gmail.com/

Mehmet Fide (2):
  colibri_vf: restore the pre-2017 text base, the BootROM refuses the
    low one
  doc: board: toradex: add the Colibri VF50/VF61 page

 configs/colibri_vf_defconfig     |  4 +-
 doc/board/toradex/colibri_vf.rst | 66 ++++++++++++++++++++++++++++++++
 doc/board/toradex/index.rst      |  1 +
 3 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 doc/board/toradex/colibri_vf.rst

-- 
2.54.0

