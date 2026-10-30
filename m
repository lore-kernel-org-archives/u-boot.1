Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE95606A323
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aUepXADl;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0NJsJsxp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F74D40A72;
	Fri, 30 Oct 2026 12:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JRgkk_PB7o9y; Fri, 30 Oct 2026 12:59:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5093840A74
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793365187;
	b=RhRQDk5zYP1pIkzSg+c2rUk9MZBHWbB8ZZSbeqiwDKDtZZ86GdNeRAdvA3wHFWKYegNI
	 RpiDiTKHjXqABGbZRJrWVsINRX+H/F2n7PvyuvG11z74osR6zgFVqLykrzqUa3dY8A7jk
	 fyJ5rZ5EmnhcvaNWHU3k4TNwZwHo9/LzoAW/kc40lkj4Xxvr1cM4yFcRrMzK0BYdFY/g0
	 kPywN+6ys5zizcrOE0HE1z1fDyMnUORamPI9X0HJT43sFY15ofWvi3pgPMELXy2Rq9laM
	 pZFKUO4HQCATvzqcQZ4M3KDXWhU46QZUyPGV5QzX9UlYYltzIyZpJhK7Qmi9ewQsJpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793365187;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ExYOTML29SU9r/SZQC+mDxSvxOteQ8B6GMfOPaeWobE=;
	b=UEvfYAsggxsKP2yzAD4dW52R6/PGvR3uzwgqRgbi8n+MJtNVoNG+hGfEgbrUu+FjwTI4
	 8evz+bq8weuu1Iijpy5W8+o5eY9q8xn344AlMZ2ELOqVit/YGiNWv0jdHdXfoe8r2Sqkc
	 waNgBZQLL856WmEnBlVMhEFMlI35K4iDZV2ztCuKAW61oaIsJ+Vwit64LJCRl2X0Ye+in
	 8NRLyFv25aGoUuwxCMJsWS3Zn8tC7yuzuYHGKlr1F2yVxk+AI43e5xZMSN7h0c44JQawV
	 eRtwViZPIMY1ISXp2RWkTrz4tLsNnPp3ASHJmDSoYfQXkvERa1pzkpeiCSZK1If2+iw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793365187;
	bh=ExYOTML29SU9r/SZQC+mDxSvxOteQ8B6GMfOPaeWobE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aUepXADlDsXt9k+iAEnXT9v48Ld0PzztrzgClGhn18/cblMmaGszzAcJdVZhWJMLJ
	 cEs4XbrtUEuAVi2eV/A8NsTQAMkKGHaED8JuWh7DZVSpIuNoZ8SdgZ8LpGiVSLMUD3
	 uQofda3jAb2NrFvFhg/ZE5tAFvo1mS4brfgk43OblHSNR2/t0rJrvfjm7GD5VEWm4a
	 8dFt20SYJt9Zy1mD4b5ngWGm4BRE1Vf9AG43tnPpBTbFZL8+WL9CiO3dcDGvdLTr4f
	 pmWopCHtYtwoli/v6HhMlCmLhmtyYelsEvomDpCRCITFD8xHNHeJOoakD/EOD1L7s9
	 st+sWNfG2bZAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5093840A74;
	Fri, 30 Oct 2026 12:59:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C2CE14BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8C0B606B0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3tobDPpzCj_f for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 07:37:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B79D960667
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793345844;
 b=Xy7S4sqw/LfrFUGG0cx7PqDqley/tns2AkNNae2fw29fDtL2hc2uVARcAVLMBsA4gjF0
 AjKFAkzcC0aCzXBXWeAa128bsiOeBuiELQsW7vHrKOyP9SHNASCPvqK0YESNjrYzr7uUf
 na4pdIBAkNgqUJ35wvmDiDb4yZbFh4EzpsqaMg6QqczCtrZm/0YpR61CgYNvG1eE1luMn
 0lQ0WVNnMMNY5zed8TUWEPwiq+KuVkuRI/77/7wbDJH5aRK7m6+zt+5AbaIfzDbAS+u/p
 gxG/ZC0aSHiNMrSULqc/30lVJjC7ZX2/mL8/Xw/HQ4+RAoNwS8XCfytbwvobLFa+KSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793345844;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=ExYOTML29SU9r/SZQC+mDxSvxOteQ8B6GMfOPaeWobE=;
 b=RCLry8Ww/irhmznmchEoXbINIf6n7lwYntB5pwuXRxgpLiinlhz6L6hdQiP/wiW4dSSn
 2Z5GuUINrKABFbNNJLK0gsRhpXDysaTx54Po0+A3O006K+K05uE3Es/CeQLRxf1nDP8ZN
 cJJrvpbXWI30MHcLcQsiEGgEkfhrqjZFRRjj0yiN45MJzXtDVU2QLi7XHKcZD44ZGc8Fa
 /LuR7J5KhQiobHmEbnZ/VEUCcZ4tdugMIE8ILk2BrJMC/ekdsmomW7dhlQ4FIuEjVe7n0
 5ZJBQlDWb68Nkosrd9yt2Eq9M/mjqsIx3yE9lqInVsntLjC123aUskwl1oI9WHsH6dA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=0NJsJsxp; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ylcncn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=0NJsJsxp
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B79D960667
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:23 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so7862585e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793345841; x=1793950641;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ExYOTML29SU9r/SZQC+mDxSvxOteQ8B6GMfOPaeWobE=;
 b=0NJsJsxpWDUo7kHnw9Z3/shr/FXMrqF/2r1JqbgkA2AIPwoZ72mO2elLw4pEuEpZAb
 O9sqraCxPWsc+uXDI49SqvWSpeiGaH5DcbTevcKVXQMIYAc5f6UR8+RKt5irigyTERNL
 8YK6+VQnmcgWpC0yyjlXIQ6IsXfgYUffZnr9PAIYuc7VV/pKKFwHmxyMFg6OGkTpKs1+
 0H1J8OODcx7gzlfWMxrRzj+J6nIJaaj8EOjPdRAftVQ7n3QUUedKfAUbR1R/fhKzbVkV
 eKKLgpmnA8zq0l4CEkHd40E0lTKgklgPdOgzw29x5xwv5n8x3gQVu1jU7A0j7h6yg1Hh
 Ai5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793345841; x=1793950641;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ExYOTML29SU9r/SZQC+mDxSvxOteQ8B6GMfOPaeWobE=;
 b=cI7pG6uv8t25NE/y6BEp36UjtdC7Tzuio8/1Ff6mwA6UWVyXLlNKc2WXTVuIVQRrzv
 HEDU+YxnOPkct1i0pH4ksrqP/VJz5e2u7pT0Gwmgwux+r5tagx5/cXdW8NBtlBWVNv8Y
 00GphUldbdF5Eg/lq9PIZAEaNhQNWCyo7vLxoJqJHgh7Jw3CyDxyQehwt2jWfIRgP0ZZ
 qxkf1c+ViiXL6i64dgmwhG1L2/cz3/0xybjhYcAaKe+ngZpvlS2f9NoAqwfcAkOrOZwF
 BUi5Xny4H9R6EY1ID3FiDGKj+LoCuhwpKbDx+wiaT/vNso9vmWk+EyldC2RNu42i5mJQ
 Dt0g==
X-Gm-Message-State: AFq9FYKI6ae37OqiUnBrMXQvE3YCf5ZxiCfBSRibhPcf0aAKcToadlOw
 9iLfLFqSycYy0nKxAaj0Ye8I8q998I5b2MpGWNMZldIYXCGc96QM1A/5HM25BAH8Ndo=
X-Gm-Gg: AYBFou2IDRtHgrC0pUOor9aO4K89aQ5yfrA0V6g+zXBqvjxj8C+Yc6QxnqSs7EOJJEn
 MAO7oKlXQejL4J6aAU3MNoIMEPshDGrpGd/GtTaRneZW7iB9EDNytjIgduzddnA3KeOHyVYoUQZ
 C8yTNndUHLMdHBXqp2tBuVKTOSrjApzdKAgZsgId3qDC+e6dlHiG9SsVivEaRG5/dBlXPxw+qPb
 pRbmlm64SY+VSgswedJtAV1ScZWobl+Q0Llpwc2ytErAgEj2pC7A5t1cu7QLqLLHvkBWiXgl0fg
 h/Eq+rN5i8KFjSe7vGhpmS5BZF46yFvboiQG+QnCfyVnO4lyiNA4UBLduIJobjD+KXrzqxhIYEC
 LemGLD4AAWqa2bCHHPVk4zZFopfZcllSDMo4wwIWaJFcWVn2XxxAWRbh49exXJV9AeVooNPQz3o
 zbnyeTgINwkkknzcfF4ewoXhen3NFlZIPobEPQLVq7YmUK97hyCWpLQn6ekcrkVxpfhebkruOVo
 5jPbGzHHn2VaIeYvfSglNHaAFktjDhmDK4dRlXF3+bm9I6gs/9ReHDQsk1DtSjzhpWJGGZZMb51
 +55u1xrFAO8XYx5JnoDu/fFFCHbi3kngf6spNUG3o7+55EQ30UH/mxaj
X-Received: by 2002:a05:600c:4e08:b0:4a1:9c71:9f17 with SMTP id
 5b1f17b1804b1-4ac17287d04mr31204165e9.9.1793345840994; 
 Fri, 30 Oct 2026 00:37:20 -0700 (PDT)
Received: from thinkpad.hgw.local ([159.146.110.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe885d91esm30975645e9.0.2026.10.30.00.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:37:20 -0700 (PDT)
From: =?UTF-8?q?Yal=C3=A7=C4=B1n=20Can?= <ylcncn@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: rawnand: rockchip_nfc: size the page buffer for data and
 OOB
Date: Fri, 30 Oct 2026 10:37:13 +0300
Message-ID: <20261030073713.164596-1-ylcncn@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 12:59:41 +0000
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The page buffer holds a whole raw page, data plus OOB, but was allocated
with NFC_MAX_PAGE_SIZE only. With a 16 KiB page and 1280 bytes of OOB
(Hynix H27UCG8T2BTR) the raw accesses run past it and corrupt the heap.

Also refuse an ECC layout with more ECC bytes than the eccpos[] array holds
(CONFIG_SYS_NAND_MAX_ECCPOS) instead of overflowing it.

Tested on an MK808B (RK3066) with H27UCG8T2BTR: nand read/write/erase, UBI.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Yalçın Can <ylcncn@gmail.com>
---
 drivers/mtd/nand/raw/rockchip_nfc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index c134045d..d6d49692 100644
--- a/drivers/mtd/nand/raw/rockchip_nfc.c
+++ b/drivers/mtd/nand/raw/rockchip_nfc.c
@@ -880,6 +880,12 @@ static int rk_nfc_ecc_init(struct rk_nfc *nfc, struct nand_chip *chip)
 		return -ENOMEM;
 
 	ecc->layout->eccbytes = ecc->bytes * ecc->steps;
+	if (ecc->layout->eccbytes > MTD_MAX_ECCPOS_ENTRIES_LARGE) {
+		dev_err(nfc->dev, "%u ECC bytes per page exceed CONFIG_SYS_NAND_MAX_ECCPOS (%u)\n",
+			ecc->layout->eccbytes, MTD_MAX_ECCPOS_ENTRIES_LARGE);
+		kfree(ecc->layout);
+		return -EINVAL;
+	}
 
 	for (i = 0; i < ecc->layout->eccbytes; i++)
 		ecc->layout->eccpos[i] = rknand->metadata_size + i;
@@ -991,7 +997,8 @@ static int rk_nfc_nand_chip_init(ofnode node, struct rk_nfc *nfc, int devnum)
 	rknand->boot_ecc = ret ? ecc->strength : tmp;
 
 	if (!nfc->page_buf) {
-		nfc->page_buf = kzalloc(NFC_MAX_PAGE_SIZE, GFP_KERNEL);
+		/* holds a whole raw page: data + OOB (16 KiB + 1280 on H27UCG8T2BTR) */
+		nfc->page_buf = kzalloc(NFC_MAX_PAGE_SIZE + NFC_MAX_OOB_SIZE, GFP_KERNEL);
 		if (!nfc->page_buf) {
 			kfree(ecc->layout);
 			return -ENOMEM;
-- 
2.47.3

