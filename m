Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401D606A32C
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nKLkBFPx;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bT/oCz+A
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 670CD40740;
	Wed,  4 Nov 2026 09:48:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xhtcr8utPkYy; Wed,  4 Nov 2026 09:48:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA37540798
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785729;
	b=lZcBX+z/B802XtqHdMajP8Ic43j517peuHNLDmvw23UW9UEM60A5Jr6Rr31qfg9U7OFE
	 j2shSe6EwJ11EgQDSYiOyJtT6E0EqOw5At+EV+doFImv9f1GKe3R3VsTHIIzj5nJoDpTZ
	 e0EFVT2OToLq3EyJkYUgQGImzRng+55TJl+yEiXCt8b/X/mGsmn1qW95MJJMsKkSRPdpz
	 cwRYVe8vqa47eGFuU8v3Z+uhwhLaCbllUj9xG42UWGy5V3zHuALiuKmRmruQUTnMVK1DK
	 U/sGoce5bEIa+HgDDwZCG/lpL29dKhWaj33e24CLXZ7HmK6pO7xotwypZF4H2lA2/kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785729;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sbg3j1KGcECwDjKDptLpZGnxFeA80nTCh8hBOS0PGeI=;
	b=KUBa+e8hP0Ypwz5W3aE+ahe8OP2MAXMu/cJYGmwETAcHfrS30fqoMdH/tvXJ5NPrz44O
	 OK9myXfvUnzZTip7viFI1/9x3rO1MVXv2zGrjfJLQiXN12Ph+e1qQGF4GGyY5y1CHklYR
	 G2YOXEpm7Onbyb86WKCEnm6VdntvBQtvf4eYSBAgI3TT9b65fJY/PkJ+Xyk7bY3A2eY2N
	 bT4su6gkezA6kEcc6pYseKSkkIs+nPA96leUX8XN1SjRXUVQs+0vCuRG/UzxggeLb/tmC
	 kaE/WQLtvf3hmbQMi8GOJAF7K8vknI2DDvN5eKibNxpi4ZxoX7VCSM9Is1WxAPFuvMA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785729;
	bh=sbg3j1KGcECwDjKDptLpZGnxFeA80nTCh8hBOS0PGeI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nKLkBFPxpi+H9phHVJwMb9UzvT3VWCIIHzD/HhpgueXfyOWy5hDLFZFaDTrRCxNwx
	 KyJuozkNhYn7RcNz67fqdp+3lpZNj0C0ks1LVIik4D/wVaNvzPn4BsAj+aPdXShxWh
	 YktlSmQCYagfJaqee/xJMoKI5Wi/A8vYhQ0c1lzFNH87ZhCAcFrKVMD7CUEI6qzMZJ
	 uLpEb/yftOEmTkRAr45+11SsFSwKs8qRys1qcLXMAwpHOgL9fUXkSdc6vM9zantU2w
	 xxHKXuX5XBD6iGC9//ZUCzFKRSuv3+3XT8o48hFEIzg7XVbOPt+GJzMs9UkN0tUMrr
	 Ibn4BHeO6nUqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA37540798;
	Wed,  4 Nov 2026 09:48:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AF5FA10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A0A680C1E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vGvq6TZGMH7m for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:48:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7D83B80F3E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785721;
 b=LDTNc2+lDDRZp/b/DHoJyrM+2GUDqXV5SzV+yS/Y4BM4KbPQQWBBQhjjJMHnKwOgyQC1
 MtC0aRQNXHT8uqQjK+hkvxx7aPOjPxCBX5qpb5UJfnRkUNooZk7Q4Icgi+YtUy/peATrP
 hQLsAQtviWJeIMmiv3FXTHWOMPgNZVRJq6G11xO8l+7EmOgm98ytNmnnmB4ucV+WqzUgC
 TbgwABJ8/PYCKPia1ruf2cn+Bs5yLPW8TUQ/7B1IbagMKfc3HE3vIbmByFgiUH9fAMVpC
 pa68eeE89Ovexn7p49B3oTM3NWWCImCLbtWA0UyN1H2yEt/3ZNE6vuaG2TwNvJW23tA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785721;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=sbg3j1KGcECwDjKDptLpZGnxFeA80nTCh8hBOS0PGeI=;
 b=NvHfROaV6aWO8KwjJKNNPZ3hbEQtg83HmeGETwIIAZrsiWeqBdVB7kTy+1hZhsYG514Y
 iwua6c9PYhGBxhqwhmsfIaBDd50Evin0hhsP65wFFbMmFnh7itADsDkTUFInGPSxQg/3X
 tVHMul3fN+uaB2HZ3Iy0lpna87Hjq1xZ2S3vj+ItH3IMkRr1mGXnGpTI2vNtlN4OQaahU
 3noqn2YDw6mZ1PCD8XohZz1/1QsVblviSyjQtGacmT7q/4Cfj5w8r3so2Os5XvwnTWRrP
 Nw0ng5RvwpoX3rDQ0iAzzclFOPDnEzRcSmp10HDWWDcnhE6r5WgmNi8yKSSJ9KYpwRg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="bT/oCz+A"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bT/oCz+A
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D83B80F3E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:41 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so4191905e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785719; x=1794390519;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sbg3j1KGcECwDjKDptLpZGnxFeA80nTCh8hBOS0PGeI=;
 b=bT/oCz+ANsrHyB77bupbY+HfA3NVJpC76XiifztdtN5W4iuAMHVkmBGlY44tglQwvQ
 Sq7vok5ZDJnDpNUQq5eI2RYxoshKtgXgvJQXe2eypO5KiBeWsf4/of2X2TfsGqtwozyL
 OWd8h31dhbW0p4KFhwf4lGitN/4wunzAXwN9+gItz/qZ4flfXPaJniqntF+K1d6zIduC
 psLtciluNVAIpEs9HAEKbAA39+HLmUbNKwDEQYDIBZcB3ahZhn24deF95sCa1dArZ5GY
 kv7P4L617/m06OAWog++WorQMT5BJpL7EM8YSrNpqajK69lECKIChRK9etpp1mKTR7RI
 EGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785719; x=1794390519;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sbg3j1KGcECwDjKDptLpZGnxFeA80nTCh8hBOS0PGeI=;
 b=BECaPp+1x3dJv41qRh6p5r5yaCktkBNpNJOsszGj8+opxTqE+t9GSbBLdEQbnZ/VWt
 DpbifY7HugzSxrtX1cyjrlXygGyqL8SqSMMDoR2si/BnfB0NHx3yiip4bwPX+ClNIMmb
 aG4TzstW5lgsb/xqc8RO8v2hiQjEbHoLixmFjIdvAtV76AAx4LEuKrzZwAY3miHcOqk3
 UrklcjeHqcrRcYJkocBRPxxVZUHkpB8NKpRB2CRFghyUv4jRqQu6riL+hEVhH5Cv1BYw
 KuCUCvcy+2LmHQj2hCE8bNrSGtHxOR2vNDjAI72UX9P+izvOlIuP4q7K0egfNYz2FCNO
 ctkA==
X-Gm-Message-State: APuU4Z/40SQ77Iw5IjqRkWQqk0TJGuiE565uuKtv1kDwK1NoNtaj0+g+
 FpeNDTHAV2jyNxbJL989g2IQGR3yE/Y6Cv8A/u68yJ65qWZ+Pk9/7GNt+MQXEDrn6/Q=
X-Gm-Gg: AYBFou0F3I3zfpfnf0bPNSTWcWjw2L/CWE+KDR/LFGL7DVau5d0RfoenItH664d/L76
 V8AvF4IIAg0KKUIgcFTcMx/DhqkefHZ2zFPiA/Mt+fQyGErDCVx5zvYRXYMLeB/N78jh1e5CzFx
 PV5eehO/yv5kxBnofTmbskePplcuiUSZNXVT1iA5CxBMP9dDTFY0R+FA6Xw+cPyWdpGFP2QaO7o
 Ns3dSlvXQD9FZT78pP+OU0+Qv77Oz256TNDISQ1Q/baSWN/EuXLJ4BQmSLYsst3EtOQbyFOd2iV
 Kqsj49ix9wzIlInc6mfr1+/jQl2vA3T+U+wpSK6IH9uqecjiDIErZW3dijV5bnGQaYPOBdQu1AU
 ZEoT+flBzHRF+tcip1PwuTn6xV1B086XFkJ/Ub9qvXs9IdfCHTVumgNY9+n05rbYZN7LELKwnE7
 taG9TuQv5Z1UdAiRLIj8bHHEVkkjQU1TZjf2vV4+4G1TMu6JkvDSNz8Us4x42HCQuNrazvuLl/k
 iFz7g4WsnbeXqlgrEGn7E5H5FNHI2N1/9KIAKlUV8m4PRl2eodJPhBsXdo2ltaLEr8EJ+SQ7cvq
 UBJwImI3ef6gQnTJhjM4bok/MnGHN6+97SdDn5xjwIsvFWc=
X-Received: by 2002:a05:600c:4715:b0:49f:ffa2:1c72 with SMTP id
 5b1f17b1804b1-4ac17567cc8mr341082295e9.11.1793785719272; 
 Wed, 04 Nov 2026 01:48:39 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43cff3b14sm40093385e9.10.2026.11.04.01.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:48:38 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 04 Nov 2026 10:47:52 +0100
Subject: [PATCH v2 5/7] board: ti: am43xx: Use aliases for USB controllers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-5-6091edbb51fa@baylibre.com>
References: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
In-Reply-To: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=870; i=msp@baylibre.com;
 h=from:subject:message-id; bh=sLaeR/MYmTq88VOXXt5crRyAuLiCslUliLPL5Uuepy4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqxX/+P5L+wSqeJtvZLGkmnSrLiSc8HZnnf/Hk7yef3ya
 t4N4XUHOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAi8gsYGS7z1W9N/Ol1wXza
 NsFPqVf+O6q0rSlcXWmocSt8TzGP5yOGf5axbPkTo28+uKIo91Qt+Sebvu/jig+7jtxYYdrAr2T
 pzA8A
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

The paths to the USB controllers are currently hard coded. These paths
don't exist in the upstream devicetrees. Use the usb aliases instead
which works now and if OF_UPSTREAM is enabled.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 board/ti/am43xx/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
index 42e2bef8151f..96d1b5b3b5d7 100644
--- a/board/ti/am43xx/board.c
+++ b/board/ti/am43xx/board.c
@@ -707,9 +707,9 @@ int board_late_init(void)
 #endif
 
 #if CONFIG_IS_ENABLED(DM_USB) && CONFIG_IS_ENABLED(OF_CONTROL)
-	if (device_okay("/ocp/omap_dwc3@48380000"))
+	if (device_okay("usb0"))
 		enable_usb_clocks(0);
-	if (device_okay("/ocp/omap_dwc3@483c0000"))
+	if (device_okay("usb1"))
 		enable_usb_clocks(1);
 #endif
 

-- 
2.55.0

