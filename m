Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D043606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fx3GIa7B;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k1gUpK39
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECB5A60B0C;
	Fri, 27 Nov 2026 06:36:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MypvQVJuqyxy; Fri, 27 Nov 2026 06:36:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2827060AB7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795761407;
	b=bverC1BvB1/awuKPRP5Y7wZ/1NvBH3p65QCfT1i0a/9j/3h54R3KCFw71OSfqVumn1xQ
	 RPHFrzecSmOnzlVG0fkwP69jkiK7V+VC6H2XSwDyEORxsE+vdVTtv8y17Wv5qVds5LT9y
	 Bm9IIuGKe8XQElFfiyyx5vUBSDvahgKY/F5a/vPmnHK3paVkyP2zFN5PrZIJ5xmMSEQxR
	 jdmHTYZFgYsKo31xtgXoay0Fh8rLB17IFGTQdCK0dpUvpFXYtyiJhq3oTnyXxicML7Tp3
	 3y2NtgSV3WlF51fp8RY4lQ1nXT3d1H6TG0DDR4a0WHINqXQ8B7kMbkiqiVN7KYA+CzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795761407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TvMdBdqrXN24hVvcpsaiXh17aGwQlsEfVAMcfMhiciI=;
	b=SOWipt+jpaVVNp+Zv5le2/Im+TIWKcQ0H1M7ADbE4m2O6nStdUZNJPj2LPu//59CuTDE
	 yBR3u39Lr2cZr6XdOAtsg/haBmti7PKGSqnMaT3T78wRewWdN+Ku2Hh90hIKiZQmnFzyq
	 8h4yd172d4mQ4jiw2Z8b5gukldBQ9EE/WFgNeEHlwY402uhe3dWtr5NZhqLY+b3kEW2Ot
	 Bk5fWtlMrVIAgRAZpR2LhZH+bCIHwWwFaNCSS2tLpfv5IOyfsp0v7NYLdMa0x/8abMidx
	 Arzk+ZumRAffzy9Sx2cvo8CMZhh2nGofTviGdFzraD7JxEMxB6lpF1HyJRwET5n+OVg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k1gUpK39;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795761407;
	bh=TvMdBdqrXN24hVvcpsaiXh17aGwQlsEfVAMcfMhiciI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fx3GIa7BAiqafKcQpG+vLvQ193NbxDecUDn7Uk8EFiwMPMF7DRJoKcQzr/Jp7OITb
	 Jps4F9xhRUUjlhsObQlDZ7Qxe+RL50+Xj2/E6jFCF9px1G2VqG8JNC0OKx0SOHSkqD
	 sa+D4dw84v5SaR754li68X1jxn0us6U/osehvGcL05qKAPx1wncpna43lI/IRxpg0a
	 KvRAIrZHgOfkuzErXpVbAfEXwuRMXI+tdjEs3DH/XXyKGFFTvoBytNyfBIEKRducT0
	 +KEJy6h/dymYNv5VOvSNz6wL76Wed7bH7k0xqN6RT80Kb53BvA+XHVWmfUSmzXl0FD
	 JdFUnqQ7thSuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2827060AB7;
	Fri, 27 Nov 2026 06:36:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2296F3C0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 00D4060A77
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KVtm5aDw-m6S for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 06:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A99F60AAC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=k1gUpK39
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A99F60AAC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:38 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-385c497bf94so7222265eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795761398; x=1796366198;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TvMdBdqrXN24hVvcpsaiXh17aGwQlsEfVAMcfMhiciI=;
 b=k1gUpK39ZwXzR2Z0GewUD/zgHORqVBpUwdbXlpYJTHpRT5zqgNb2fcdQhUzIrfYFxq
 nP1ttvpFMbBsfQgptejCZ6Vkax76sLQ7IIYP/e8Ph7vnPv17IzZht2l6OOTmlXMFuTN6
 EDFeOpc/RqmuNgJ4CgYpZ6WktK55VNwpQMs33jrLU7/WYB1F6TuyhqBgx9RNelflGg0R
 mNCMncLu7aNh44lN6atvu0zkCYwPVk32nMvq/hnTLdjHTlqAlmV+BTSkW1eqZkRReflT
 aEdmlmimw2Zt9fecsqQmZgIdy8+nTPjmUompBYBtRunlVHnyKG1V3xfy6Wsx5422KSpE
 +7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795761398; x=1796366198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TvMdBdqrXN24hVvcpsaiXh17aGwQlsEfVAMcfMhiciI=;
 b=QZImhuBzhAuzPPMi1lvrjx40zKTPj2EcPhwUzzqPGlcsihDtCQg29aYJg58nIpxOP/
 bBbGMCC03SWwsjna3Dht8pH2A6WYDqc8/tuZfbwOjqgkVKQRdOLVrIZ/SsAshQKFaRuk
 Y9WlMobzBNq8yEXU90X1WM8yuC1LYFBWFRKWppn/jdRhYVPwp4uPFL/6WxpON3+LzUcU
 gHZrlpNSGBP+wOoiZ9eoqTy4IAOqkQKSLAdS5XylxFr1ZxQaIV0stjmvlJiw8Oan6bou
 4qJ66+3CQBgGImwPNzo3c/UiS8QS8FOgKmprAuOUc2l1xvaNwOwauFYSSAGh4K1zQZIq
 5EVg==
X-Gm-Message-State: APuU4Z/f/Pme8FO9jTlhVDu1B11O6T+y5UWmo9pvtUZYFwi2P+q/ZKYb
 0/JPxMeG4Uq2gKne5Lrg1ruX5lTS8U5HaxISmP+TB7HJ3SEYd/rcOnLt
X-Gm-Gg: AZFdTZfIkT3cW85CmyuLjIpDfynCB4pqHLDD6Sk6AmtJJbnPKaJ1Bd4qCYBD4nLPrwb
 sGlxq35gaDODvBaL+Y0Cbepy7JkqaJeYO4okSV75lqUa5YdITcsoE+h7Rhu81qH4qzBvAal2oAY
 n2EZLnAT77B1eGkJj/f5JDpqNx7AKWFJfUASWHOmQANqoszGwmB+I3HgAS0tZZ0mL7ixQrJ+K2V
 gz5QtDx7aj3OHlumiSz8/aW/vYN4xt3oGIa97cQR2gjnciGmIVUbXvXaQYdGkIMZhWqzmOgwMYQ
 sFJAy22lRI25Ae5IhYe3Nm8k7W2jitjh3R46XHv7pz6RXo5/1YMBGu0D3ZZAwm6OtWOpd+GG5L0
 K5DvapTSZKxb19RRMZJabfPQFQnAncBpEZPTyzGBOuSP36YdGulrlBWDmjHx+buBzGPiRzf4M3R
 BIZn77a4fZCvxz2Sywv2S/x3oqNyNXIZ/M9ehQUK24ZJMjqFyzjSRZEfRovvAmsTOq5lA5d3Pzb
 ePFGEbR6/gm8YPtfo8k0fVhOOKS0Jk6+fY5kiiv0H23HiVnj2n+XqqZm2MLeciD8AnMiBxDF0Fa
 zLyn87aPpKGgFLv+YGgR9nDwnOCBCiEtLRLMORildtzABgj4gxifZgOgZRlJbYjT4jf5sJjFH/F
 Kxxc+4ylUeRv7Z9tc9vsbc6k=
X-Received: by 2002:a05:7301:4d0c:b0:376:a6d7:8f6f with SMTP id
 5a478bee46e88-3856ec3ec8bmr24835229eec.17.1795761397709; 
 Thu, 26 Nov 2026 22:36:37 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (55.11.81.34.bc.googleusercontent.com. [34.81.11.55])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672c6f31sm67452444eec.15.2026.11.26.22.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 22:36:37 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, marscheng@google.com,
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, visitorckw@gmail.com
Subject: [PATCH v2 3/8] arm64: dts: google: lga: fixup #size-cells DT warning
Date: Fri, 27 Nov 2026 06:36:15 +0000
Message-ID: <20261127063620.399391-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127063620.399391-1-visitorckw@gmail.com>
References: <20261127063620.399391-1-visitorckw@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Griffin <peter.griffin@linaro.org>

Fix newly introduced DT warnings:
Warning (avoid_unnecessary_addr_size): /soc@0/interrupt-controller@5880000:
unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or
child "reg" or "ranges" property

Fixes: 54edd8698bb1 ("arm64: dts: google: Add initial dts for frankel/blazer/mustang")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20260929-pixel10-initial-dts-fixup-v1-1-b304868cc3e8@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

[ upstream commit: 18686b294c6f6ba778cba66eccf01b9fcdf48988 ]

(cherry picked from commit 23f12084edc3ff5addf234ec3799fd7d0f10e0c9)
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 dts/upstream/src/arm64/google/lga.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/dts/upstream/src/arm64/google/lga.dtsi b/dts/upstream/src/arm64/google/lga.dtsi
index 26a14b3a1b1..3e670e524c4 100644
--- a/dts/upstream/src/arm64/google/lga.dtsi
+++ b/dts/upstream/src/arm64/google/lga.dtsi
@@ -370,9 +370,7 @@
 			reg = <0x0 0x05880000 0x0 0x10000>,
 			      <0x0 0x05900000 0x0 0x200000>;
 
-			#address-cells = <2>;
-			#size-cells = <2>;
-
+			#address-cells = <0>;
 			#interrupt-cells = <4>;
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.56.1.839.g22a8290db9-goog

