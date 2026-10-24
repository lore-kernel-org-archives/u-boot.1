Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF96606A31D
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tcQqnVGK;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cWsEYTA8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6917C40A9A;
	Sat, 24 Oct 2026 00:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XVLyTeHXwyV7; Sat, 24 Oct 2026 00:10:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 65FDC40907
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792800611;
	b=M2jeVm580Qchzrl9/3alhjejfnKimYUcbU5xLXlGB9A4lfHw+C/NHIFBiFrN+hUjXThf
	 B1XsX/ssTJ1ya9q3GyGuy5FD7yue9hSbmTbnut8kBNA/xAkDul59gxlGyEmCVWCeYesDy
	 VBqedAqilEpnvx5KPYvKabfC+Ru71ZBJX69sxiiD4DbYIRQIL3FZuoHCzzhV+1uezwy4l
	 bu9NyCL2+Cnltr3YuO+6VbhDirj1qc3MyOaDSKgbyDBy9dozTyitr6AdJnp8v/nYJZkom
	 NXOBeL+oz8WV78b+/jVrMgDXKfgZqElqy7mDfSjQ15jNtdP79juMWHFmtqZPVQk+7qQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792800611;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=olYddDSBZHKmfSKuRyrpe1FRB4bQdtU8bHNsFqT751U=;
	b=hM0YPxluxLtX1dCx61gWnrYlCeS1SS1GIUH/4Z84dPiUx0JtHZFWjdvtrdAQrlU8LwiE
	 +iH9bS1GG9w2bdldPZz8pJM67b6k7QUj9AMHiUHGIF8aNehRQ3RyzBJW9k/RSiAGzEL7u
	 QdSvX7vCeIo7K72/En83Kfu/FeGPipa7eMFsAXTzu649PpOHcQp7EfkBzqlHd94JwPeKN
	 wfJuQWHrouzyQzytwnnijqq628c9SBwy5/h5FBndzChEyHw8NlDJd+LQo1VQirm84esd0
	 tW9RCiufJR+JpfrEGtTL5ya8Vk5yxeA9T5DyF52gKLXY7k7vVSl3HypNmp3hGmeE8Cw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cWsEYTA8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792800611;
	bh=olYddDSBZHKmfSKuRyrpe1FRB4bQdtU8bHNsFqT751U=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tcQqnVGKzBOV/wLzKPBsCASFpQOldAqUgn6bch8fQldvbOh5SqHyANCQb3frDb/M3
	 dpljbeMK79tKZQtTAYRD8L8bJrrYL1CQWK88yevZckuwj0WLZRrP5UGJ3oqWFqzLF4
	 0ZRJYmSfBTPbx3hsh5mWr6r5huNaYby/Xl3TWV4BQguY+rVkR9FWB012cj6hQ7/qww
	 aH1McEP5jfWG238TwNjGwWlpixap3OCXsX5srkdt3xU26OKr7YL7Y+h1VAdUUWslx3
	 /+tADSoLabfEb20T/2/xZMBgyyhhv0QDmm8kKFE+N9bZQ3ggjUzx+KE0jV8PMKCFFP
	 eK+UOFIVWTivA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65FDC40907;
	Sat, 24 Oct 2026 00:10:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 484353B6
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45BA240907
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FfwQtxP7hU3r for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 00:10:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A72E4082E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792800609;
 b=Kqb/VPlUw5ckPdXapSBCX1Z3AjItSt2Mf+N7LU0s+o4bLJZW+he+8LJKRRHaMgWhjScm
 iqRc4FW+I7LdbSMlZ3mcTnHK7ziK+IqNzCQuKI2eijeLQM1X5DORuTKLm9FWVCNQaGy73
 2pkgGYoGDs3t+DmgXRf+5k7hwX7IKEA4UtDX+nWB5QKxu3enj25JfZWZiyVQTtu0Mpycu
 bZMRN7HjPSy4DmIE79y7hGCla9zQV5xvHb4MEBTDA6eL0C97gblL8dxeMKgC5hWRgm6Z4
 On0zOsMQYZBBtIKYqtsDG3Je3Peptdw9gG1v8R6Avyhpraeg6oPHqaqCFfLNDyyIUSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792800609;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=olYddDSBZHKmfSKuRyrpe1FRB4bQdtU8bHNsFqT751U=;
 b=UGFnzoxxRqHXUKG3czzCmloX2GGL6yNdB5pOgVlmGKdJDbm/lr4hYLZJoXpOHc/z7JI1
 MURfIz50mrij8NoL+IGUf/d/tMHsrbyNvuhuzRsRCzrnDh+zSjs2SjOjCM84GEY4OIPRX
 azSFpkiYmC/XqhqrPAmX5bZrwZZlP1YFBzoyRSfFsiBchOz9+7bGfrmFttDHO54D9b60y
 +LKaVNsf+7UlzRZtpzRJ+UzTl3Q+YVSnhCSP/UvGN5ge9I6Uu7oVFP2qf+/pnhE+MmSr3
 RU5YYof/XlTpFa88IknOXZ6JisI3eKJjk7WyhRrzKoK2nQAZ7HN1vwGr4y/isYsI6Kw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cWsEYTA8; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cWsEYTA8
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A72E4082E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:06 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-84e513874f8so835327a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792800606; x=1793405406;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=olYddDSBZHKmfSKuRyrpe1FRB4bQdtU8bHNsFqT751U=;
 b=cWsEYTA8AZKAVN1ima8Cuq4Q2yuJrwJDTsp/aGGM9mmFNORIykssqLd4MSym88S5DY
 WRA9NWAbEaKW7ZPU1pOeciBf2LQWD1YfLbiXl49YEOPh/hUfFZwSiP0qBEyuliM3KlGX
 wt1SBLVYV95AugphiMK2mT+cRVPPvr8jVynRrqR2uMgwgpdXM7xvVh+riTWX0CtvwSzs
 xDX6ubb1tG0Dr5FuwmkO5/mxL9aaDMSJI64EnLCooi1aFnmlLDp6AA1NaWRbg1lCVNFO
 pzt197UGkJRi2ZHVuNbvfknEtiq5w4plG1ZZpY0KBuBZLfEGwmndu1bPPqpvLVwW1k4Z
 7hiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800606; x=1793405406;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=olYddDSBZHKmfSKuRyrpe1FRB4bQdtU8bHNsFqT751U=;
 b=v/qtY7EQozkEG4gcb0t9dPuHa8kgwXt089KbjQzc36lDR84h6+RvmfCcedX5ojfFK/
 0ZofOVp0JRdy+nCcpO+ZpkzsVbLWimlXlJk4gV1XJ67sh9ElxXyB1ITB2bckReijOIlY
 QqPAgr+ajrON6vb/JjlqJNbd5XKdrSbOJZEOPZmEBN3STv1owgju65n/Oz4OB8HS141x
 X3aZA70Ikq7x7yXiHlivGkrwyXdSP2x+Xz/etvsGgXbBFozt+9Db6MzAvfIn9TfSTDFJ
 gpobuNXWJN+8FBO5VU1kWdBPD9ZRRrZ6DJ9K5ZWOQ0WzMAJjxyxAg9WkH2W1mYOMELP+
 VO+Q==
X-Gm-Message-State: AFq9FYLzUNneDIGzbXgVyBTMlzGXRJQk6wLJUOdBr6C3SwHd2gLaHOYn
 TxdvpPoOkqLR69vSlotLrSzMrY9hwf77bWcVNTxD1gCtw44AJVehxsmoO8BiDq3Q6Q8=
X-Gm-Gg: AYBFou014PHhdxUk1xO3PyeQpt9VwLIquIRryGeFzowQ7vqt4MNT2trsAvJAbp5QzRA
 WDAaxdNhxfcRV89IlnYzkCV4VhJ9TIgT78VJSQLszvHzZrw/RDmmRIwKAIxqOq7owG5/PEhG51q
 tyWkrEVycDrk8hb+UZHpvqYpm+t6HdqVrp6MNTjH+em7dW3lcrnbjVoFw71CB0EQKQqb/VAmex1
 Og9OOYX+2vgN2h62ZhAvCQya2R95nLs4ks8Px9e9EpJ2BK0QYZS9+5cKSS08elEHW68bQl3gRlu
 Jcju8jKjozqoF+lylQ2/mAQgBY+2eBVxWF/5rqJwY0Gkn56ViIUvd6X0iwEKOqo+7UY+SSwI4pa
 XxODcpTzoq88bSqBBkILPdVeLvPQd6on1aL4Dzq8Ckzy+0ePr8JBzkCbPObzHmRI9GLtM7oqpgu
 SCgxEl3qCdKdMVmapDf4Q8YT0Sn35W5osbcuC4U5utPg6YgsNr+Q3cx6kvGVr0MLjTiQCpWMrlT
 hLaodob1f0NuhAkFTrPwUntcZShtMPSh4baLf4hlhTtKkC5oXbjEAyu2D51
X-Received: by 2002:a05:6808:e82:b0:53a:d128:4021 with SMTP id
 5614622812f47-55c001904b9mr614576b6e.15.1792800605948; 
 Fri, 23 Oct 2026 17:10:05 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d2b5:d533:1cac:8248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c04248804sm328636b6e.3.2026.10.23.17.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 17:10:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/7] mediatek: mt8189: add U-Boot SPL boot for Genio 520
 and 720
Date: Fri, 23 Oct 2026 19:09:06 -0500
Message-Id: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTNJZyQ18SqEBZYRx59COmhIm
 t7dqstv8V4Gk6RicGoyJHmr6RIrqG0gXMc4C+pUDezYk6MDPrc7zhJ1wSM7tPWB5Nl15INn7qB
 2a5KL7r9nP/xtr/NNwvYdQSkfu7kEkXUAAAA=
X-Change-ID: 20261013-mtk-genio-720-spl-1620416c6224
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=l4qzHEP7UPi8xDjV0k0LwtlcUr3cJtyeHrVA/pCIyfk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2/cnj261sqsRrtEf+1qgoncX8+QdV9ZDmTXvL
 85ylvsUSzqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatv3JxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJKAH/RZXt3e2b4w3tIV/uKGheP1QKiUV0zvskNXMvCS
 itsXNokIbii0BWzV5esC1YWBau1aJz08fTDI7eVCWTsANkrGC5pKxm02asLro7dTTP3sNLN/2mV
 y0Wp1ldhJ1Au0RUUl2NLYFy/c7aJb/z849VnwczYdQ97PfHVTDSCBdPw6qEbRugw7VD6vqZDulh
 vDG9lgzEu7JWIXcJYsyddZ9MF6JV3tYMpFknECnERm23r3HEUjdbMGhBcpEFY/S1ECYw+cQxnMt
 FAL9nnv+YJRK+FcLF+7e2YYxhjnPHTuhnKzWVbodugN1eBIPqnQNGG45rz1Ob+Qexu4Bt76Vw0R
 jjXQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add an optional boot chain for the Genio 520 and 720 EVKs in which
U-Boot SPL replaces the platform BL2. An external DDR loader initializes
DRAM and starts SPL, which loads BL31, OP-TEE and U-Boot proper from a
FIT on eMMC.

The DDR loader describes the DRAM in a Firmware Handoff transfer list,
with a devicetree overlay like the one the platform BL2 passes to U-Boot
proper [1]. SPL passes the transfer list on to U-Boot proper through
BL31, using a new generic option, SPL_ATF_BL33_BLOBLIST, in the third
patch.

Tested on a Genio 520 EVK booting from eMMC.

[1]: https://lore.kernel.org/u-boot/20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (7):
      arm: mediatek: mt8189: fix the reset_cpu() prototype
      arm: mediatek: mt8189: use phase-aware PSCI reset
      spl: atf: optionally pass the bloblist to BL33
      arm: dts: mediatek: prepare Genio 520 and 720 devices for SPL
      configs: mt8189: enable eMMC FIT boot from SPL
      arm: mediatek: build Genio 520 and 720 boot images with binman
      doc: board: mediatek: document Genio 520 and 720 boot

 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi |   9 +
 arch/arm/dts/mt8371-genio-common-u-boot.dtsi  |  81 +++++++
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi |   9 +
 arch/arm/mach-mediatek/Kconfig                |  10 +-
 arch/arm/mach-mediatek/mt8189/init.c          |  14 +-
 board/mediatek/MAINTAINERS                    |   3 +
 common/spl/Kconfig                            |  13 ++
 common/spl/spl_atf.c                          |  29 ++-
 configs/mt8189.config                         |  36 +++
 doc/board/mediatek/index.rst                  |   1 +
 doc/board/mediatek/mt8189-genio-evk.rst       | 306 ++++++++++++++++++++++++++
 11 files changed, 501 insertions(+), 10 deletions(-)
---
base-commit: 7f48587ac9e89f2e9537f457580bc0cd20b731d3
change-id: 20261013-mtk-genio-720-spl-1620416c6224

Best regards,
--  
David Lechner <dlechner@baylibre.com>

