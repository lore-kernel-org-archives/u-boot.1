Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4609FC9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 19:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7572416FC;
	Wed, 23 Sep 2026 19:10:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tKqCPw_EqVCv; Wed, 23 Sep 2026 19:10:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A606D416FA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790190636;
	b=fuw0g0xoZnGDbWncXq7hSPFu0W3NVnA1znhOBgbZnlIiRuZ+PyLVZV3Ab5SvkslpaOL+
	 jPTTyYHqjWWrcBa+XTUAOUDUTu51u1q758Xk9OVfjKk9XR3TwDIOoxm5SoEm/Cvi3YQDs
	 N39x0Ip75G4Mmj6+yaygc0qJlV4JI3URtrKaOkE0Gl/mZDwkbCkZXzpkQGsnaY/GDT9IK
	 P1UxnyptQOF2nIyt3pIVQuTDO1rn0qIEXrxH1GXk8IXG2xNOpuRv/c9xfYDKfEnDuF/lx
	 ebTBpJzckleKzBbzGvuA6ppY+c6LIQa2n/YpoFB/jGamo8CZraoxkNvUVMgjNPnPfhQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790190636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ocjJQAQffkME/v4+JTMc381tISsjRSj2By3Cg2id/Hk=;
	b=QReYqhBoTZCWvI0rPyL8bnpw9cj0yKPMsh+ThZYtTK8yzEBCANX8SYWQ3qO4xcTFHX82
	 +zn3ltmeDx3QLHeploWLbi7MWmQ8e/qFvqVMedrHZlT75MdyIfTuF3u/8ujARETsHnbLI
	 ROY4B9dQNDo8vpoevA3YSbgBcZIJrkTyt0ufVE2ZjhP3UJk2LdKFaalsAX3CcjoBG88Oa
	 JTCt00yLkl5MDpCy2iroJ+SA8jikgbfTnBzVdV14q2T6n1k0X325DTn5JEZckEgmuybio
	 +ZFijIKWiC0/6W6FAx1O3Qr5V4dNEqQhzSGbOXJRe1v2HtHxSAMadzvuXKphKm22JtQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790190636;
	bh=ocjJQAQffkME/v4+JTMc381tISsjRSj2By3Cg2id/Hk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HOwSqPXjp2l1JwHSWcyI6zjCvie/BO9GUM/pF73ommXlVy+KYIoMMzHst+A+648ba
	 720O1WKYMPBa1C9vJ5fgjufWYNBkTNF+qdxbLmGgw39oEONyr6+IgHrIaP9SfeQG1A
	 vMxO8LXoF1gi5XV0qdyRH8yvgiBlsSQvA05GOTOldQPFD4XEpI6oOxwLzNCt1M+bGX
	 f7V7/cNzTYI2jHUIGnrlf/NnltRor8UNYLfRheZtuDtaOiiVVj/XP9mzpFdQ6SRzJQ
	 3PT/qpZaPpjSE3uR3YeOIe5gO544+1d3CvF8v+qcfXIT0Cmpk6/cFOp3MvfbF0yq4A
	 K4PZo56ELKp8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A606D416FA;
	Wed, 23 Sep 2026 19:10:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 67C3A13B
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 19:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4DFF34049C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 19:10:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qfallZSYowbb for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 19:10:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8A7C740460
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790190633;
 b=fnDL/tWEAmfk5mvfHhsnKNA1so+5rWgP7D1D03LW4gWZu9RFVasYYgq9DwHuraAVdcNN
 1KQ1Jxu6LVqcxYwOlakJTYFGNXHZgLC64rDEB7JXzBe0tHYA8DMsbxVwL6Laesm2nvKZk
 o+4UZxbNcSufFSWVx7YnyiSIAs4SBtrbsV984e9Dk+ZyGEnCwbleh7KD0yuuqYXZlbx7K
 a8BxTb7spzS4qL8oERZ5vM9JwCv6WE6g85WlWMOM2jdmCSnX9nkqo+IRYkvgGaL0My/Jy
 zCNfFldWebspmaKmjldp1+avursBwXJqXBh0D4JadwOw+evO4zUj0rMQiyuJvT0rpOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790190633;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ocjJQAQffkME/v4+JTMc381tISsjRSj2By3Cg2id/Hk=;
 b=igYGdzhPbhIbgcoANMEOHF1a5J89nDvkY5p0+0+G8alrmM3YOijfcKqAJ93bXn8O6GFk
 ybyN5Vpu9TSyUiDlY8iN8WAtUDjlF2XQ7QRoh/G2b6nK+bt3KD3B0OXMsGL3Jlc/Kmgud
 AimL/+N2eB0OEaK/o6kdTvMZN08JFv03oKaiFn/qh0jUCFvM+FGp61WysRdOIbDG8g7vm
 jJu+yhh6glh3EoiyRNQPZ5GXMSDJi7slvpUExcMoTHtOT/I0WUr5lstOXHcJ1ZytRZLu/
 HmFuNIcpLApYxG4a4nbd21itHQbUm+wda/7i+hxCLH1UetcyOo5CutHtTW1C8wgcrKw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=nEghMFOe; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nEghMFOe
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A7C740460
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 19:10:31 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so7408305e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 12:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790190630; x=1790795430;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ocjJQAQffkME/v4+JTMc381tISsjRSj2By3Cg2id/Hk=;
 b=nEghMFOeI9vhqDX6fYwVe0BbpollUGUy/MXVUepgyLF2JCT2gP/ZomPJ2KxSxSInBW
 0V0iRGN+cqmyw2gL+ZldX6S36EmFClcHA4uOn53mbecavI44UvSGAbEBZXGVz8s0Tpvg
 Fvp8QziHHOjwfu1rAY0iCZq2UjtxFLsb5oMzh4jCPr/ZdrUMajtlvr35AnG42BWjOuh5
 N5c9VjrVM6WYwIdVZFUZNJkvtHaRVwjeiDviqqVcf5sDsI2QS/6R1ah1uypKXf0QWmSn
 7w3ggAJTngmJ0Z3f09KiXWcbCgFPNWKbAuUaaUwARkOdBMJTe780raMnTIe8EuiB/E8v
 LtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790190630; x=1790795430;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ocjJQAQffkME/v4+JTMc381tISsjRSj2By3Cg2id/Hk=;
 b=ZDsekpenkQhKOt3LHzdrq+8JNFyvAbBM2+HlAAmYqDCP+1f8dIvzBcTGQuwqGVdpXL
 iNFunQGyBHH710YxLi24QhPgPQsmj2dToCutTegXKkPyW0GlSnOjJ31XTIprig0tpjHv
 5SMpBLnjY0uNnva1RiE/lMR/CRIeptMD6cuFpb/+nTwenwqy6jL5qJ+pDXyPki7wID+3
 DQu1jeYOLzzxKZAxiljlpr/zgPdRUc1UDPxYKVDYbKgqR+aEWL+9b9Tsy5YcdUgYSEFa
 3qaC7Hwehc07x27iuXTRmNM0NdbdX48vL0K8HiNlqY16zbiHJK0FXtZJEmgEwq+yU2/e
 LnIw==
X-Gm-Message-State: AFuF++nsKLNjzUkWnFlUjkDAzGMvnXdKC36eYTnjTyHN7a7F1iQ60/oB
 JlHLpByMaHyWKQkpi2N/buMhVXLAYzlgqJMNmAfOOS4mE2Bj5wN6Bh6A9lkIRSXkQm66f/Amj/S
 kA+mf
X-Gm-Gg: AYBFou1GZkFyxlyCVMqYfXiXF9W2EBZjQJnb8pVDkJQpbtY7xBVzUoZPibYNJ3NCnhH
 8l3LVsfgwVBNE/bKCmrTcx4pYaPVE87XjXktUqOqsTEUqll79saMiA2aL47HF/SpNiIFX+e3UvA
 90cL2zoPMcHOBIN6HmupcI1xP0QTMUTuEB6r/06ZdcIiMxL512ZTLj010qR1Y3niWsYKuCJ8pgZ
 t2wq41ikIt2i6PEAKju7SpffYfNCFvY6XoJjeaUlv9YcZllK1V4h2xczmaE3O6kS3Mbf1RnbPba
 uVLjnJZ2AyQaNVfhqndlhOCxq8MzsehDXj8GGEmoYvZDkJ4p9Ak8arLKybWCQiJv+d40WVoebva
 KvjbDcyGEEugZIQV3Esq/j7Yht2VvRQz3RdiBuhM4XVUYw/7wuz8iPF1r3m3nBzuj44MrAIz6B8
 mMVFkgly62FflHZ8k83f/SGH9Sz8u65kd/gJi9tXz4dr+1+ADrZ49P9KUPTRQ2YCFEGkx/8iqPM
 sksQcueiIpCMA==
X-Received: by 2002:a05:600c:8719:b0:49e:6c11:c4fc with SMTP id
 5b1f17b1804b1-49fe66c8a5amr3143495e9.7.1790190629803; 
 Wed, 23 Sep 2026 12:10:29 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:8223:c4e6:4d28:61c:74bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5b9c16dsm13724885e9.3.2026.09.23.12.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 12:10:29 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 23 Sep 2026 21:10:22 +0200
Subject: [PATCH] arm: mach-k3: am625: Wait for TIFS initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v1-1-300ddb9f5be8@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAB0ktGoC/yWNWw6CMBQFt0LutydpK8XoVowftVykPgrpLYSEs
 HeL/p1JTmZWEk6BhS7VSonnIGGIBfShIt+7+GCEtjAZZRp1NkfM+4JWiLxk5GEMHu7TGPQCYXR
 hwRTfg38hOc/QtmtdXVtjT0xFOiYul1/wevuzTPcn+7xXaNu+0/b4UZIAAAA=
X-Change-ID: 20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-15fda445257e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=msp@baylibre.com;
 h=from:subject:message-id; bh=yrSKZdYDdAJxfGCuIdeLRqd2i/Mp9A7bRpLPcbpUOiI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwtKvJbJc8GXXzZ/95OWanidllum6uQIHfwXtfSwuvTq
 7prsm07JrIwiHExWIopsnQmhqb9l995LHnRss0wc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ4h
 kKFjxMDFKQBTfc2C4TfL8QPX/87e8URua1f+kVWeXSaHNaVdZ+wUydpbUbU5aUE2w/+C60vWBLp
 2TF5ZF1ibaBG8Kj1p1+vds2N9ksr5v371P8cEAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
the firewall on the registers at the end of initialization. On HS-SE the
u-boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
leading to a race condition. This leads to a broken watchdog since the
signal configuration doesn't succeed because the write doesn't take
effect.

Add a get_ti_sci_handle() call before ctrl_mmr_unlock().
get_ti_sci_handle() leads to fetching the TIFS version which only comes
back after TIFS initialization is done. If a response is not received
get_ti_sci_handle() returns after a timeout and continues as it would
have done without this patch. get_ti_sci_handle() has to happen after
spl_early_init() as it requires DM to be setup.

Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/am62x/am625_init.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index decb50bf853d..43d29a3906e7 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -158,11 +158,20 @@ void board_init_f(ulong dummy)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	spl_early_init();
 
+	/*
+	 * Require TIFS initialization to finish before unlocking. Otherwise
+	 * TIFS may not remove the firewall before U-Boot unlocks them, breaking
+	 * random things. get_ti_sci_handle() internally fetches the version
+	 * which communicates with TIFS. TIFS should only respond once
+	 * initialized.
+	 */
+	get_ti_sci_handle();
+
+	ctrl_mmr_unlock();
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.

---
base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
change-id: 20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-15fda445257e

Best regards,
--  
Markus Schneider-Pargmann <msp@baylibre.com>

