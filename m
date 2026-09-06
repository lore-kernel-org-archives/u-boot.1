Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BABC79F85
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 15:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBFA560624;
	Sun,  6 Sep 2026 15:30:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HPnLRD5tYg7S; Sun,  6 Sep 2026 15:30:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 23D5A60608
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788708638;
	b=dPrbqoYICj0kr6r020KtwKwL9gTLejavPJ4XQq1wNF6xwBTs2XVRdfSU6iSnaw4eZ/Ew
	 k5alL+ynmQwCl61UBEI4fumUbxf5y+cs9Ui97WmC9oYCvIUiksJwhQx01bkY0eqLADXXU
	 s7jBeM/QQyHpb1PML8QrabrgcO+7Gx2sKhnCE8mXrYT5gNKE1f39S6Jz4CYCRoblWEMIO
	 qsConxJ33EwCA05sYqYLtDvfCtn2ziVpiIjAqqnurmZasTZjQd9tYkK6tNsqPxJDVI6MT
	 RzDx1C8ti7mBYIKMdcSWNUZGAm7GRAThM7plhn+0Yecl9Vi+rsBdw8F640L1F0/cTaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788708638;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PDhHNMqYd1CMayy5d5iUtgCDbCRfHX8Xz7OVRnWUvc8=;
	b=ifSourGCE4gOLlTImqOf4aOkEr4d+fV/uuCzKcdULtXoQFfo7G5IbdrIw0146ZtK3mjJ
	 VcraZ7G+AmA6LjsK35L+6YmGnvHRRXYGaBtZFtzAJ/RhC9KWIxK6xQyB9Gyo+8NGuIwoH
	 GgL8fEcQVNXaTvB4zTuDLnG8vS9l6/Cjwz9WIiRgW3iJyXfbrT7H8a0SZneJMCiwMxGzm
	 xnnZyiXZZI0q69ehF1bP1gT0bzIoItILNhDGzUymhzTdR9k63tDkeDLG5gjheA696MSK1
	 w2lsErOCWIQ6avzHfltdtvTC0vQYlOVcq4qhq5M3SYjj/8De9fUABYS5VQ/2rop+OHQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788708638;
	bh=PDhHNMqYd1CMayy5d5iUtgCDbCRfHX8Xz7OVRnWUvc8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n3ZTPFf3JUPEoiqBZwyRhCN5d+q0Z81BTW7eNv0iCdCgYWDmirbolnPljLO7FDsaN
	 w8nya65wVZWrcTY6H2EmRBLQxr0zoJQE5OLPiQotXohsScUmIpSknpCvud3Bmkh5c2
	 IZ6+tFdcIoFZ9ciTFucG3kCtDeByXs2s6aGx4mvOZ/t6RHT2fgbQ7tt0+k88eGInUm
	 Lk8eL/TRiT+5xajmCBWo5HUZY+eM3a5hICWYiBchnicqkyboIvAzajdV//J8eNOIGG
	 N+r2miQVTddaDouqw2R8qM6qkOFwSgHaxV8bznSZZY8+B8F3nwAYoVj+bTnQMU8w1t
	 zgsDGhp1b3w/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23D5A60608;
	Sun,  6 Sep 2026 15:30:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3FBC118
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93B3E405E5
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vnqggj-gvYxK for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 15:30:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7E119405B7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788708632;
 b=Q3MFf16KxZfheCN7+eE9jZlkr/ndsWeGWwxgEGFTGBqH959Fk3eT4LQG0/PsW136zav3
 rPy1noWeLyVU7rhKjGEv8E7R0d2ecJei2Q3KYGd7R2idWHgw2PR5rTzok6LuyKdkSP39p
 X1OlcTE6EEa9YEsTItLH+4ZjI5NV5JuujbD2EszfGIMG8eIh/4J06FXgW8ZdGFyD016g2
 xTfJkcmmsk/sCqcdXWJIK4n2r6fyy2mM93m4RuPoAf8H7xDb2mmhON7iwQTvlp/cQiZsn
 OPBZI1ghNivKxV7Q4/ts8nu2O0gwZ0YdraoZfkuj0rPzsQY+0oHnyMAvIsAYVy+K2iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788708632;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=PDhHNMqYd1CMayy5d5iUtgCDbCRfHX8Xz7OVRnWUvc8=;
 b=OgsrySDRn2K7mSfxcSSjo01uxzPUbwbBn6dqLw1rNjOSmWd5iXbte1ysjYxeyGpIKzwk
 4ixgOItVKJzX7viMqGzgs4Fct8dcbWHFAC9z7tvpEjjypROlIPDgBcm/JS8BGM40OW3pQ
 lr6gGUGZo6aUdjFPMEPhHoQcSFbuMAecCVZt38IbncHAUL+VZM04r0BYPUHwKNt2t2Tpl
 8oEFXrLYog244JtayHmt6lckct0bObB0luj3BgAnhdHOls2TGZocsqREwKB/IgDTNzSSU
 ZzxNB3SUhl3bMBesiTCBddAsR8CLIzSfeEKmcrt4t0hDDqs6mzD4SeHDfmwZb6vabBQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZemXTGCT; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ZemXTGCT
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E119405B7
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:32 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-485850cf499so1537726f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788708630; x=1789313430;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PDhHNMqYd1CMayy5d5iUtgCDbCRfHX8Xz7OVRnWUvc8=;
 b=ZemXTGCTtg++o8/ZlFNzCjF7Y48jCAvxBmq782zUsAW5aNAuQWaa7OQ4mEnkg9OL13
 3zPBbcrq75pFgU5Iop+0Me644uM844yqm/9wO9oeONaEyW8BZGmfICa4lhmX6dSnlrxn
 N/8vpsz+8eY8KzbcsoGJzlVqwNA5Uyne+T1nnW2zX/CKydz+9xVeBydCgKjQ1/oC7Mtt
 j6IYqzSL55BOOF9qdm3NYcevVo/8UW+P9RsVTuTXdBMWVwKY2Iy1VJEx+d+FNOUXWxP8
 moZvsYzd2LD5+tWg378v4EAM1WeWr9jDuwUy/7uWhZK7jLfYJ9NUOxMrwJm7UhxPu7Qy
 sQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788708630; x=1789313430;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PDhHNMqYd1CMayy5d5iUtgCDbCRfHX8Xz7OVRnWUvc8=;
 b=qoVqbIH0sjJQ0spbOEOoAcz2lJj34Sc1pBZSAfCyZftXX75b6OW7YZH8DNgP22ATOT
 DBezWLInPkX3fwUfUYyvPktwgITWaILn5AiVYecz1lamVKqLqBGCjL4Dd2x2Na38kFdz
 Zwtyuxc6yABPE8j8VyFCLYDY5fXZEJjolHkulwklbE/jsOcVpNqdNaWlAS1tpl6/+jGP
 lgIdaB1Meoyujy6k6KGc8RsS/RPf43HSm6UnBOnokHOUJ10wJ52GqpTOhhn/sYmPDokN
 XhYI72GpgevxsMcCO6eluJFwVnpoz2MgvS4aSNQK00v0v76nuHOrsBkAKZghPPhcsHT/
 tlGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBycEKgMAGP51Dyl7j7L3s8yjWITuEVcFz9uIPZNg+1TG/njn5KhAOj0ffmjt3XHqQPH21e2Pso=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nnDUbZSCDDnvtJVUAFIJW7ccSL06eAqjgwU64JezlEMxbDG0r8
 vwJyQPnU153Rd0ALfl5VlCAL0yrajdwBWHKA0bJ+GTYpxTd/1jzu9bQ88dJVE110vB4=
X-Gm-Gg: AYBFou1VlEGIdv+7EytRozbtEAqL6ov4/328IB82vNEN9uWbDD40DiUpQwY2qp3UeE4
 B+b4m/qSf3xVFbjMVihOng/SomR3I+xmC2ogKRz+Wxzsktbi0zS7ooIqknOp1d6csv4d9SKKsHr
 ggVAcl8T49p5pjCLQHNV9JH6qitGvYb7c3Jn+W+CQIb2rRkSTkZ9qOaKGlJcvTxGUWCOCspqKKt
 vCDiosQNcXufs2JtFNj9uaA92AWiiRXnRRJhXT89I4FAQ9TLOxvDG7rZcUvbljNv7QwxkNtb83l
 23s3JjWJwP+/opZPG1Q8xldmYXhmKlGTz5yuvbvXx4uW91Y04OObZ6sk/qRFJV2McYj33oDkM3r
 Nw/2MwwQGZZdLIyxb3LcJodjSKbgRzeuzhJD6r26o5XkUPXp33MN/NNAhSV58Pq5nL5X7CT3AgU
 Sage8LdM5zsfSD8jKmkIZBgv0LVx5e70enxbouBenJfm5BVjBBcJ3drM7bZENgtZinOPDcgCSzV
 L6t825I7Wu+7G6cDaApyRw2D/AbLzEE91ggqqU2Don1tyaAcwwz
X-Received: by 2002:a05:600d:4444:20b0:49c:fc6c:be0a with SMTP id
 5b1f17b1804b1-49cfc6cc001mr113660115e9.33.1788708630167; 
 Sun, 06 Sep 2026 08:30:30 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf770fcf5sm238069605e9.6.2026.09.06.08.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 08:30:29 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 06 Sep 2026 17:30:22 +0200
Subject: [PATCH v6 5/6] arm: dts: mediatek: emit the Genio 510 and 700
 BootROM payload
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ccaione-upstream-mt8390-spl-v6-5-4d4a11d5741d@baylibre.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.16.0
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

MediaTek secure-boot tooling signs the raw DDR-loader and SPL payload
before adding the BootROM headers. Signing mtk-boot.bin would instead
sign an image that already carries the unsigned headers.

Have binman emit the existing payload section as mtk-boot-payload.bin.
This keeps the fixed DDR-loader and SPL layout in one description and
does not change mtk-boot.bin.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
index a7ee09feba0..af5cb96398b 100644
--- a/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
@@ -18,6 +18,7 @@
 			       "-n", CONFIG_MTK_BROM_HEADER_INFO;
 
 			section {
+				filename = "mtk-boot-payload.bin";
 				pad-byte = <0>;
 #include "mtk-genio-loader-spl-binman-u-boot.dtsi"
 			};

-- 
2.55.0

