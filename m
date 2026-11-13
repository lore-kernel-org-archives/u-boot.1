Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C8606A8B3
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AXkCOhSu;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G3ZICSsf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EFAD606C7;
	Fri, 13 Nov 2026 17:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UyfW-ueuBCqN; Fri, 13 Nov 2026 17:31:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 84C4B60896
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794591114;
	b=SFI4tKyqe4J3BsXZtM0WABezT2PpzJEVj+IuPLXDcP0bl0EnBTJjKWpg50Zh/XoxH2T2
	 NPPYWOFPpGabBpJtP9lKbUgHn4YGsNUnbGrcK0/etZ4BEnztKzn4d4z6aYIo+jikL57yb
	 tfi6iP2TzFZCh5upzhtsc5IIX+bJd4e2Q6oddpkHgJtf+u8ZN9UPBwFQmsrrcBUJDn/K4
	 I/xdPYGPI4x4gKUbyPSsEznd+HRj6fX30narJrvkP5yDNutFxRFXzz4kAhRleVZBE6KQw
	 Ah4es74f5lMFZ/+sesALoMfEiz6zPRQ1XiYIQoKyb+Z59ZtPnFup5lwqmCy2NNsy8Bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794591114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=H2tYczLc1CzSJXoz6lLZZkDRlHUc+HymiQdxK1iCzm8=;
	b=FJrYS1MFGkrUXlIKOzUpYESpp41ruLVMHBTgTw9hhXUp5v9vA92knpySOHtdIYnCjn8R
	 JUtm8avNx4ujY1g/rgpT9mjXepLSzgnTvPFBNN63a68vTnC8JlSQC0AkLVX/6Oe5hZJkj
	 61P6qfdv7lJA2+e4V6Og4i9r/jAcZGcWCGMvZ86cvmYWeJfb0JelyXHGQ+OTA2Wjw284B
	 Mx2uHTdwdR9HMC3DtEDpQUc2zoEfcm6UDJA9InOM0AvTVz5JJJ0B9b9pUeu0d4I5WwZ7Z
	 6Zf672GvpeheDQJN3g3l0e+Yjthsp7bT98OdXN0I+ap3gTJpsIISMLZz6fWzW+2lgmw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794591114;
	bh=H2tYczLc1CzSJXoz6lLZZkDRlHUc+HymiQdxK1iCzm8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AXkCOhSuvRs3CQ5qM777VpZzffn3bxs+OC0doM4yQhAHafWnB5NPzalfP+wxt7N2Y
	 wtABeMd7nO7n0VeP8yJ5PXGvO5Ug0A9oD92dBPVMeW+iq+0R+GC0qRWy/6d8L4kgJ3
	 KZCugTktS6k0eOtJC/KfnDf1cIk9r3PyZ1lWkHgiYtKldtQwd+J6XLUHSes5GoZ6p/
	 HCjXeY6V09ae2RNaR2uUvfPYHZ0BVGq7dQpE6Y1JtfZFBqtjEFzL1BzceNAip1KZMM
	 g53BwLfS1MIx3kHz5OzQ0JMw9jzRMfEs2gc+CmufdRu3DEXbmJcsw9+RMHbWmaFHqv
	 5gdwYwzaazA3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84C4B60896;
	Fri, 13 Nov 2026 17:31:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 171D4235
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 089EC400E0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9h5CNUB-wwA for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:31:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2F3764005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=G3ZICSsf
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F3764005E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:51 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-491d1f66968so430108f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794591109; x=1795195909;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H2tYczLc1CzSJXoz6lLZZkDRlHUc+HymiQdxK1iCzm8=;
 b=G3ZICSsfLe47Dzo3Z0vjo0ISyyRAfTtOvMZxrmqCJpc+LYNQ7queMHMOKtglMTpHsQ
 xTTApLesk4MQFqR9KWe2qEjoqn9R/f/zVWbuYTA4NUSRjeJaFV5JohvALyKsSemrvBsg
 6tVn1kMtwKZq+GSSt3+nkLpDkSC6tohN47D0oDBq7hdO+OnXZQ6gVtZ+JvguQA4cf26o
 dM299WQcOizWiFJn3BJpVeL31bOpXSa8WnlvM4jQp5A8GDzhreqTCJ18lDNXHPwwudT1
 2aAo2gqPfGoiVFKlM9ThKrwPaAEfxLDdJVV1ijO4zaUz+0kacSahDmNw6sk+URhysvrg
 9Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591109; x=1795195909;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H2tYczLc1CzSJXoz6lLZZkDRlHUc+HymiQdxK1iCzm8=;
 b=fbmuGI+TfkzjwtiFsB433wGKkVXSuLMUQpBnGfLKEoUf4eu5AYNZbj00OG2GRiUkdx
 VZFGqmQ6fryIawsdeMZL6V6TitdWH8Ju+2Y1TrOwtznae07ccNqD0gxFRObtKcRPkECv
 ZrCCxsuqR+hzA6Zd/o8nlF08poCm1X2ci1Tu3t4IheDpwjF/CYhb6lme++bk51He0xYS
 8norP858WPctaW/tEZAxICpuversFzS7hOWJcnmDCBtDNe/KBa9nr2VOfKPufjNaCLHc
 5PHybjabNtMWMMOuG7ihEMUuF+SksdPjLIRLBecR3OmzbvEMKIJnKw4WZ1xgO81bDl+6
 /OlQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFFoAX+zgSwFiPhftMh7C/emp+RuNKsuG/nSmgASOkUMX/HLKwzmnLRly8ZXnmtBKx6Yi3yIf4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8k5aMhCFsA4Y5M7OejzvIfK39xGxipwtvZrOtNtfK11GJTrlaN
 twG1wO/5Sm9bSihpYCR5pIJ/WgzANGSb6xPvaf00C1asboC2rOZ6ar7w
X-Gm-Gg: AYBFou1IvV6z4J+PhIbr8YgorkqdrXV/L9DQKbEWjnvwrZn+Ull8lPQw2TRu6TqKUzs
 IqBzRhiiYMwAQwnYmwSPx20VkG2wgMP2Ba1T4bG+p05LJVR4ACi6lB3B7UG4xDlonVsCM7fc0gP
 +PP+qoCHiF+LDj67pMfe0+IuLZK1CIYFykYP8C2+UChxk29S/U63pKcEvIPgBkBeAd6ex30VmPY
 zmpGnJZWzQpH30N083S0qmqiue6LNfrEZcUY1UkVHt3Mif4QczOw3S4QXX0GheEIwg7fkCJw6ao
 YGzXBVBLC6XiPTP3I80Ko0azToD8Gh5cymh94dGzVoTXvXX5/a+Xt6VC+Cn1zu1vcRsGXPO8td9
 6u7S/DxhAF0jq1B1C8Ulxxo/ifiIqimiQdhOfCl5tbNOcoTxl9QD232kWi5iFnymzpBZI2wevIF
 je2uEPYIEi07q6xPoK75UIDVV0Pu4e7M0iGYTL8ppMHeRzEPVx/x4Ji2yPMg4olDGvN57LQ7eEJ
 AG+Lyqr7DIZfgsXgtCxiDH1BBtuHuMc3ltYw3UREelgTpNvA7lYlxOPsTNDrDsL47WRFALOp8OH
 t5SlyGeaE92XU6idmQFPfxOrdJaWZASrBo5pUAlx
X-Received: by 2002:a5d:5c05:0:b0:49d:8d2e:40e with SMTP id
 ffacd0b85a97d-49d8d2e0438mr2286615f8f.16.1794591109281; 
 Fri, 13 Nov 2026 09:31:49 -0800 (PST)
Received: from [127.0.1.1] ([151.51.254.138]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c81a63b1csm5587810f8f.4.2026.11.13.09.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:31:49 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 0/3] LDR format: Kconfig: fix LDR_CPU and drop HAS_LDR
Date: Fri, 13 Nov 2026 18:31:39 +0100
Message-Id: <20261113-ldr2-v1-0-dd7dbf436494@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHtJ92oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Nj3ZyUIiPdNANjC7O0ZDNL41RDJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAL2MhHdoAAAA
X-Change-ID: 20261113-ldr2-f0386fc693e1
To: Ian Roberts <ian.roberts@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LDR_CPU has a prompt but depends on HAS_LDR which is prompt-less and
never set anywhere. Sounds weird. Instead, make LDR_CPU depend on
ARCH_SC5XX which is the only architecture using LDR format, and drop
HAS_LDR.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Massimo Pegorer (3):
      Kconfig: Make LDR_CPU config option depend on ARCH_SC5XX
      Kconfig: Improve LDR_CPU prompt and help text
      Kconfig: Drop HAS_LDR configuration option

 Kconfig | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)
---
base-commit: ff8a9bc41e4e5bdd3406932af5abb4c18064e539
change-id: 20261113-ldr2-f0386fc693e1

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

