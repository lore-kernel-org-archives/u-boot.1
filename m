Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA782C88E41
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 944564084B;
	Thu, 10 Sep 2026 06:26:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PjwerA3LU5qb; Thu, 10 Sep 2026 06:26:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C98AF40A2F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789021588;
	b=CUqXfboONM587XPi3QBjpnulyH12yWHF35czVNeQ+HlhuyozfOAxI6dbm2LPTdMwy/IR
	 aQcWdKh0Q85o4oY6QnrwXpwalkw1FSMOpqz0FkbK7P12TYrHm6vy5R9EA/ojP4GXwAAos
	 9LjKj+fiv+WX+fJNi/hEV7xAnhuBMlxJF4Bdwm1rVoPfG7BTN4gWMVHMgRuejC3bhAwpd
	 kk9cbhqydHdgEePfjVcOJXf0uIXlHCVv5hHZH9w3ShKNlx2z1YLFNH205msIuLxm0WBya
	 dRit+mTPf5jEJPJtDKSvXSVhvOFtu304zLPQ6N0eeVKiuRgyVQxpq3tgq89HBOq3UfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789021588;
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
	b=iskeb+gcWNzCD2zeANYLwNhyMkat2CPHxzmWh/bTPeFzRW5e4urf+yXdEhesGIJAcHNg
	 nup2IU4UQsrXs3IOWXnYQMfjkiA6odgzw8Xy+DecB1sUZEIOjA6GZBTqrKmjbuJE5Z+Gw
	 ppk9jKubFlf+cK0cHi5h7V/96wDcJS33YdcrphhsQp5b7/ZyzcDC4j5cpisu8L4fsUqIM
	 JJtgWK8TP1LQb3d8DD8f3ukq2XpdYorPhX/qPvKutgRjXh7WFLHHIYSzFGVNumxOHMBKu
	 6otsSH7klWkk8Zo34ctWiHQrYWlux9f5uiikKjUlKG/deCMHMfT5WbYUN/MqYFKy4Cg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789021588;
	bh=PDhHNMqYd1CMayy5d5iUtgCDbCRfHX8Xz7OVRnWUvc8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r8yJMTd1jPr+AoFRzi3ZyZUjWb5K3QFPIH31FHxJGhNk8YpTLd9gl+EUKQuFebEiQ
	 RVhMIvteRGymdzpQ52+f12o9Wm9Q7bXrgHYGa4hHuH9Ti/P+rdrkkuQgM9bUlW5hor
	 Xc9ZeuiNiSB06a+x/TLcOMzUlZLB+dTskSKfXgAsfoDhbqkNBO5e/gjH854ERFgKdm
	 m1Qd0sJRwmRqheB4J2J1axI4d+P9R2uMAYlb7uqplhcBvYLuP+66qLL0ox9ymzgByz
	 9fmg6lOSVXK+F1ZAT4Pv/6WWxEyh27itHzve8ED40Ml5vvc1PLOdoJ/9J+ihyO+1mT
	 HSKVy2N8cdxyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C98AF40A2F;
	Thu, 10 Sep 2026 06:26:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2619A362
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B41880F0B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gYLVRjIRNU58 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:26:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1057980EEE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789021579;
 b=Rrv0TGVJa6JL2NMVn3spGLR4w5Wj7axwVTo2JHYUA8LV0hQBUgSQKS0DeDSYRX7u2eBG
 3Z6ml88y/lY5Fir/4yr36h0j6lvj29yczWrxDZNuNzkTdPZi7KbTlI8UIIJjsxfzjW7MY
 zR6UcePJ1tffGhV7fHxvG6GEV9Y76s77dIZ5xbsmd/rmuFVWMQsLW5lCibJTqcBgMyCg3
 9pgv104jepkUMU8/sfugfeIPtbWL1eHFK2vwztxy6WsoGOyLdSY5sDc+CtHepRzM1gQla
 SMMU+w08IqRY2HEzXV+ej+T7qGhopgqZe84peeGbk7b68VmkR4bEptn0YYjljYrXK+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789021579;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=PDhHNMqYd1CMayy5d5iUtgCDbCRfHX8Xz7OVRnWUvc8=;
 b=YigbbXv2TwsZN6AhTONHWnTddh0O8UJwkvOUJLLDN9Ld4Zqsp4a4j+36dswFTmw4FsCs
 F1Lr+7EYNvS2MH8HVfPe7K6d0HWKzI0HUUtLJ3Iip/W/g6ZCMlxKV0H6DvKz7zs3kjo7+
 pMaSmeqpB2iZM9MnONYuSuWA1q+v943xusgsD3LRhq3/Bk3WDdBP8cgrOBKnfR9gGANRu
 CLY1KfsVZlGxHXuHuB0mjGwW97YOi6j7u9o5ok20Seo318sVcBrZTrhy0qtonmPSdG4um
 DvBcNgXmumMThenUzI+u6ubj0bE8PIAYmWKo67WYPkTXiUZmzL5Z48nBULkWJ3PyAPw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BKzBnshW; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BKzBnshW
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1057980EEE
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:18 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so41672905e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 23:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789021576; x=1789626376;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PDhHNMqYd1CMayy5d5iUtgCDbCRfHX8Xz7OVRnWUvc8=;
 b=BKzBnshWV3rse3e56muOCLOCOOo8+rdXcxLZie1GqiN4FLkz/5qQYcbvznx8sXFSrF
 ALhPq4+Kv9mglWywqm7YaLoCKPM+8uNt/DI+dUKaeh7g6kI3rVo9oEfP6FvwsJIniTQD
 VSAAto+ioAAOyUxC+n2TWYyo9pQ8CA7wN5sC4gaCJDpaHMZWvqFiAmRad9lCI4beiuNW
 p1V119/qk9FuudRJLOPs5/n/QYVgBYD6MyrMSIu1xHN1MXYkwTCstmvTqB+JalaS1WCO
 U1pBg5l0Dpc49Hm/qrHHmLl6ca1DlFTHwoMwNI7XXJUL2/tmZTu4ftADYBsbTwGaf/li
 /73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789021576; x=1789626376;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PDhHNMqYd1CMayy5d5iUtgCDbCRfHX8Xz7OVRnWUvc8=;
 b=VjfZjbg2reVQm5frf0WWfUolBy9VoJzhRuNV5hFsJwBj/64H8xlENmPk9E/z5AP9jQ
 5AYHBG1vsgGSMhxRT4S7KS6JxLyz/7fHMEwYmfeI2QNfnYrVe/Z5QlPAXxxfqYtC2VBu
 1dqoQRQwySy8YtwCpgh7X80J965bntQrGD8nnHXLX1G6eDV8sH99D4/KVZHW7Tx9tv8F
 AGqQ9r9kxu1QROqVSBU5XnjKsghmLXx5Q1w646DhM1LV/hnxEjf8+b20LhzV5V5pO7n3
 hIoYuYO5QkcSguCcW7LUknfTAIdD8ngrORk3E8k0NXZuVtqQWefqrFEL1RhY0BgohNDN
 CRdA==
X-Forwarded-Encrypted: i=1;
 AKwUvByigl0dQWSCgL9d8T8KZZ0gD9/rWQmMQpEyC8JPYLo+bXWFaDjXcecd24CtSr0B3bN1FZOAJQM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++msMX08VhMgJPoxDFVRLRXKGIPech6U3vCd9G44vhNhIXDfXtBw
 T55W0rYNqOByXS56Ar0+S+eLpbrRkWftWtk+quV1i6GoIkqPiIpkYdp40TouI9SNNoI=
X-Gm-Gg: AYBFou0pPXyUp6SQvmKO3oRIbHmiThwEtYVkw3OnHS1oiBAigIJ4OhhqmoQ6INzoam6
 v8Oftr7bHNx1ydB5eztfzxV3wTXlyTWJ5iPPJ783ftj00zMRyGGzCy/voAihQgFxvDQQmnhdvrC
 psOBnevFHH8lGvlJZEJoyHSVPSx5BR5AinnlnkN7ID0MnjnAoc50/hKql4lNy4jd1s+gNjQ4fFV
 qDJTYLCmkKHNGKajhxKhB+wwNEnwsu61A+GTy9n5NdbZZI0lgJ/naxL6/kg6yZP8JS/PYfXqwed
 +9Pi3vE90W51pOosQhTUV+GrP9Dp5aEhriZ6ZskYiZrDzWao+iAYU7MZTsVGIsfvBDa2H8/NOU4
 T2Sng1+WT+NNo2XKoGO6TEhmwyiSB0FNCg3e7/Zj91XnNEVYTolZ451n44UuHk/FEutsz7VZ8ck
 ot/39E4MU3gZYHLSXHOsTBd8/GIbn/ILI4VFXGlK5njpd2D0yiN8SwxVUwtlQO2mT43M8n6jbZN
 eGk06pSg/KxSJ2qGzbpj/WYwdktkoZRE1kLxOGdNeHjCDFi6uL2vmYJklVgPURAy9RJ/d/s15wF
 RaF0ceAhsH2Wt/8=
X-Received: by 2002:a05:600c:4e0e:b0:499:bf8c:cfd1 with SMTP id
 5b1f17b1804b1-49cf81e6063mr376893955e9.2.1789021576600; 
 Wed, 09 Sep 2026 23:26:16 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c38e3asm52279585e9.9.2026.09.09.23.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 23:26:16 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 10 Sep 2026 08:25:54 +0200
Subject: [PATCH v7 5/6] arm: dts: mediatek: emit the Genio 510 and 700
 BootROM payload
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-ccaione-upstream-mt8390-spl-v7-5-0a5cf09c5761@baylibre.com>
References: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
In-Reply-To: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
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
 <pablo.sun@mediatek.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>
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

