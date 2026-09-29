Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323A9CA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E39D86080B;
	Tue, 29 Sep 2026 20:32:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W5zQq_CtyD-0; Tue, 29 Sep 2026 20:32:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 396E8607F0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713975;
	b=miae7EndlB59fC3eQeH2OPBzCTHnTzzzAwNCYtUAbxhtALXi6brIsClIC2IiAwrxYFNb
	 iZJkpTnSipbAUcJmJkdLB8xJdybLH9wbPRg4rppwcqpkba1BdYQk/fr6TRTbbYNYTzsbo
	 J22m/3AZ57CexpHiQxnVoM7BpO93igXbWOvTWpao8znNc9zut6WbifTLl3SUtZwCUsLaW
	 m6Feg6rqdH3EZw7Vj18ShNfBSqLOijGeg16Ay/rAkYjCr4L2muR8gmmR9fiVGSzaLG05j
	 hCqNyLskLQedIAVgvQFqM80R992pkQuTk291Lny9aPsGp43Igg4JQq38g/SzS/CJ8bg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kSYQQOCi1xowosfn9KKr1ki0SDcyOhl4Y+cIQKX0L2Y=;
	b=Y0+Ssz4B6N+JoNtVGOxfyuHIlK4OZ4u8p6Qere80reGWOJ6pG33n63jxqub5pNxsJg5E
	 axV7sio8+YOFAkFlWK8lQ8LRtqI6ZSAN5yhNd0aDjPS+qPx5umSmockC0LcnzTfhH1j+T
	 vlVUeUXtm5FB6Q20eQtBj3v3LoHgLstJPSOy38D+IprSt4+IIIdDwrsaNp3w20ZJkMyld
	 cL4+0aZnm1Vq6KIO+nxg181cthCXPu72JPRZMctnlUcAxAXOefVueMurg4oS3oj3xaRNC
	 24It9nJOk41ca9qPjT53FgOfYKgVkn85gwUM/hY2NAcWcGQJ116ZqtDlmf6cYnzwCbg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=brivo.com;
	dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256 header.s=google header.b=oryD0Trq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713975;
	bh=kSYQQOCi1xowosfn9KKr1ki0SDcyOhl4Y+cIQKX0L2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U8Shj1lvzRdGFxq1S4YGRWEVEAbJqWgjfghKz/vBQw0SqkxdpyW80bgn2hyYDJUPW
	 cLBwfCL+szZIkz1I1ANk2le/22UH3DaWGzIyaa5yofuoTCnhummteZE2PWNp0bqejZ
	 LVtplBWgeNGgEOUoODEiqrBy5dx57G3BOttq5WHgD5BCcSIx+BNCiTf/J/ZpkG7hcf
	 2q6i07qh06alxQmhQWpip4DuxO7bjXNdbKoYt5T+ZiZof2EXSc9mKnbf1l41iUz11n
	 Sb1lSMQgQi8CNj9FZJY3ZIz6+97LJpkgLyXm3twB8sTYyHqUEUgaRfUeNBhv5WH547
	 sWR59apRb4s9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 396E8607F0;
	Tue, 29 Sep 2026 20:32:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 83BE524E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 756AD6061C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a7Rc_zamU9Xv for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:07:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6F758605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790705248;
 b=QMRW7z2QziGOGrThxzcu6EAMpoq2gxSPTHyaQVlq7aQOlHLvSJ2krBD8F7AGh6qPQOro
 VXvP1KtzLLIyTKLQh0LqSGrDFde/gQMTsch0Z7Zw4a2dGmGYd0/Z1QjSAH6YPu2aTm9Be
 fo8Y11HylfVkblcZSEuUIW5pm04LwDY+gtVV9Gzcxg2n/0uAs48Yai9XYZ2qNPszx5Rkb
 dwxb7HOL9CSS2ThPcWrbe9iq9LRREesfXPyqoNyNNVPHrAAQZ4ErEKAOuFFOQoAjHUxcw
 QgkmY1XWT54Hbo5L3jmMbzTtMJ0AA2j8MBG9hpnhmWCTGO6NcZPTSSsLaR5hFpt0MaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705248;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=kSYQQOCi1xowosfn9KKr1ki0SDcyOhl4Y+cIQKX0L2Y=;
 b=GKPHNmcQSxTqnX63rCrqXrSSRNErMCqD0xaPtSGkkZdzhcl7Es8h4pgPx32wuFgsNurh
 8Yx+gvkVQgL9tPO5aCshk6ckF2V0muHqO6xXdp809rBajFDbXeXOWV6dCduv64yuV3PNJ
 PTgUERLMKXZYo26kdy4KaXstRY1PhQQ+UDgWOadNcI5q44fIaDa+PhpcwWHyJFWjYEzzj
 dxORUPlRN6MeNW6UuzbKU4V3ulZwOrGX+PPtqZcKcSp5T5IX7cEnHVi1T59uZZRR4ojxi
 /QuOGPse0VlzNv8vlmgoFkGJBWX/8nWWGJujodD3BIJve5VhT5+mZTaPw3AUX+lXF7g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=oryD0Trq; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:34::e;
 helo=mail-qk2-x0e.google.com; envelope-from=sanderson@brivo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=oryD0Trq
Received: from mail-qk2-x0e.google.com (mail-qk2-x0e.google.com
 [IPv6:2607:f8b0:4864:34::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F758605ED
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:27 +0000 (UTC)
Received: by mail-qk2-x0e.google.com with SMTP id
 af79cd13be357-93c56f7c1c8so434942185a.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790705247; x=1791310047;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kSYQQOCi1xowosfn9KKr1ki0SDcyOhl4Y+cIQKX0L2Y=;
 b=oryD0TrqR0EsLsoaNjvIxciKBDN/fMZy02Mmk23Os0ORNs78qBYz0zlzZsVdHMAZF7
 2a0YLZTIvZie8U1DyA1yjiL9Oq2wIZKwLhNhN8UdFLSedoPJhxH1njRZ2MPryvQCxAZI
 MgDo/AR5TcJIZmnROIp6jN9t+vOy3ZXhqE5Nn7OV8nV8MoreM5/V+HAHmSLR+rKu0wpg
 HF3Wn/oLjM+7jPeNNal5UtVRmiBmBUAZVdhQ4Fse9FwrM7puovD/A13065aqY6CnZHzR
 y/oMr6wGchx19RvKC6ctCNmA1XouILM/FB8+bqdXy2bQaFwJVI91Y26PxsIKTw2XNkdS
 DwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705247; x=1791310047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kSYQQOCi1xowosfn9KKr1ki0SDcyOhl4Y+cIQKX0L2Y=;
 b=pfTTioRyS6x44zyIsD0xk94VhevoPm7EyAp+shMDplfhlzLQL9luyFmFdMqGoTB1Jc
 l9LI1XvlaMdHVbcynVxk0woSiKMaMvEiD6FGtZmqMvS2xAeH85xpT5nQtyC8SmD8os64
 DbB86QiMkuc221hYM6YU5QNAUfbzboDXv5/6BhhlSzbh4MuPdboxRA32oXW1B/mV+xxZ
 1qDqjtD3+B1QMyd+okiJyVETt7CMzKmSYYHUDo0bASORnOq9ZtKTEnWRfZMmxeJNWRyI
 OqQ1llrTwq9WnEJlvKEYxWcldKriwB+BrAQf/KZNhtfmgIcGv2M3H05AWYduG+Qrh0+6
 C3sw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNeD/aAWKBF6GAUSDJJWRjDyhlb/hXGirN9coAhgt8TZJObw/1IsDjYCfx2rj7/y6hLg3Gy58=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k82el7djElOJ0BL3er1UkzcCu7Wr20jw3//cMTXPp0Zf3ZekHA
 lNdHgwSubScnjVZkb5gAzkZQlt+oXbLXDm2N/S/3XE0gvoRGsO69obUsJuJR+jaK69K8PnXawr/
 G7lk/3CR+7sgGP/kol+b+ZfFlZNeQHpohfJ8+h180OoiTNrFxxCOfwNZpHO2iX90=
X-Gm-Gg: AYBFou11w2X4U107plFguZsmvuxOLSE6E2uIzUEBZNxGBw3+gt1gHG5dRTT6LZviPee
 EmEwd9dAvoK9E/+1yD3Ez6JhOm2vsbU1pCOFxdcxG2OpRluZchx5B56luO4sfRoD8bFCSpiB3jG
 AgkPYC3iDR6QIvUbKMoDUB06V2mfExIEuzOGNI8wJ2A1M+H44hZKJ2/97ZB06pDPekt+7s6e/zL
 F2S7vz23qGuMTxTg32yMvY2cOiKES0rxFaQX9ZZULBLlEIUvNl4K/8tul0cblLgxJl25KnCqhai
 y+k704XyJC+JIwsZcmPdy3RfCbStcLU29/ZHjqOqGfIGkP/dBRDIIO4Ao4lDV0GQFnCP5fXILIb
 JU0NWxMiqiJtTAGlOJJMWQ1Tirwb7AX2+suPNU9ljVpYF6uT/8dTCVBfns86KsLBKbMrWm6chad
 hfPyZqphrbzLE/qtWUFBIxoOqb9g9GTDYSgt+xsee4ZdI+OD2OPJYk1HimDusZgA2m
X-Received: by 2002:a05:620a:4081:b0:939:a003:7127 with SMTP id
 af79cd13be357-93c9fc0822bmr61083785a.52.1790705246358; 
 Tue, 29 Sep 2026 11:07:26 -0700 (PDT)
Received: from strozzi ([71.163.254.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:07:26 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 3/9] clk: meson: a1: Use clk_set_rate from
 meson_mux_set_rate
Date: Tue, 29 Sep 2026 14:06:25 -0400
Message-ID: <20260929180721.3440839-4-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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

This function is useful for other drivers, but it's tied to the a1's
meson_mux_set_rate implementation. Convert it to use clk_set_rate so
the drivers's set_rate implementation will be used (no matter what it
is).

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

 drivers/clk/meson/a1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index d0376663069..422cdf5f4d1 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -523,8 +523,6 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong rate)
 	return 0;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate);
-
 static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
 {
 	int i;
@@ -542,7 +540,7 @@ static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
 			.id = info->parents[i],
 		};
 
-		ret = meson_clk_set_rate(&parent, rate);
+		ret = clk_set_rate(&parent, rate);
 		if (!ret) {
 			SET_PARM_VALUE(priv, info->parm, i);
 			break;
-- 
2.53.0

