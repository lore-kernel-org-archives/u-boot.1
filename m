Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6924606A6B1
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZuNMxucX;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=M9QTevcz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAD158188B;
	Fri, 20 Nov 2026 22:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CvgIHi5mzsl8; Fri, 20 Nov 2026 22:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DABE1817A1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212327;
	b=CbPGkAGPCw8+r39Y1MA6dsvFOglLQ+pZeaeJBxD05eJ0uqX4aXuKamCk0P2gdKVUCNoL
	 VX3G8raaNuynGHYbKCg5huCdnrR+VWd0f61qz0jwYTvM5CM2OwrZHIfDSS3jClNhrNytG
	 TXZZi9kvGHN6bRi8srE7xz/P7X43ac4y7bekpAEnlZgKQTUuDoyfoCOCGpjnv0vGwXOxn
	 JQfK6yngoQUGMoovVlpk9uwYTU8E84qYrYJL5vXDVj+Knugr/pHNwGgvNGnqaRENokOrd
	 NDXMgQTFgnYUhywOwUwJigqhMgBf6Cu2VqMFE9Do+xtc2/5yaA74VOEbYO6l3jAz6qw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z08iZAIKKPepFqcPesU8KmKFb0C9ER3h7y4h49/8XCk=;
	b=fyHWwgJoyQmeoZ8jglppSLVyjO12SLsOhj7upcWT/wdahwVOpx7ETm+F/gMpf59hAy6y
	 ZKRwvZoF71JPQsRSDPBdyJG2pFXmFgt5MtcQxm5x542srmJGvbtIm3vIpdkwfo2+PN3ZU
	 JAJBk6yUhiBCLTkZpi3Q/tKcOK2em3pRKsdJ8nrOQqIPpvUnO4jlPI95ooRah9bzIkKwR
	 hSEKRsXEjpBxz16boyogyogODozWLbkJp8STTHx+QHKBGGImGk34L6hVmf3u0tdGl6kVW
	 RAZDJnOVocy6iojmvv8ZvwCFtxgRbLQjIhYCEePP4mMTvJ07EJeBnn3kxzjFf1RTcFA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212327;
	bh=Z08iZAIKKPepFqcPesU8KmKFb0C9ER3h7y4h49/8XCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZuNMxucXS+HgZfxcsaea4oY+3y2VHNOSLbvZ0VHffe87OYf1/l4A7DhkrwAlcIXhA
	 2ds2u/ZkKRAzTbiubOLaTNeVwJRg6CNHTP72Ygcxom9AmxXRrBICJMf149R7sOIO0C
	 uefnHsR06Y3kgbK+VeyW1SYwoP2GVXW0+jHC8n8Z9x2O41kFbJE+gNBgk4XCTjWf/V
	 oUHl8fjUucBpwp3jm+ThKDCs1fPN9BbsAnQqFU8uYOWPw2W8/u0JC/1zuB11jazjyB
	 X1WiKkrIlRt5GbZntBpQWgSUGlZ0FbLme2LN2Jqf/+ZX1vRe/XjIWnQK9V9ayZ+dQ2
	 qEwqtERAvd31Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DABE1817A1;
	Fri, 20 Nov 2026 22:05:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3E88310
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4DE140208
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CtPEcRGP4Phm for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:05:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0247840176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=M9QTevcz
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0247840176
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:22 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4b8587b395aso912539fac.3
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795212322; x=1795817122;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z08iZAIKKPepFqcPesU8KmKFb0C9ER3h7y4h49/8XCk=;
 b=M9QTevcz4Xki9sxs6W3FU+v9KGYXZQDO0xAH+x1e7fYEK3XXQO17+M8jcJokEICAqY
 7QGBzony0voLebWJwnvT3ETNlCxodQQ3fMmwWACx1AtMKn4l4jpZkzBDaw4pHRh9pDF/
 XT/kEsiydi91F/NUfmdkWxrKQfULYdB9djdiqX6HQ2RiKHzdknSnB5MWoU1Mofkl7aH9
 6PAUJKm7jHZ48hnY+JptivjLkP5N9edGpwCejNK2Jwr/miQtLGBY5HroKPz37IXS6dtL
 pUgZ5ksJ86agLy4n/m4dH6VSiWppuiA024BJi2RZcuZXaw+LeoZaGu+xWcXF/rifC+xB
 3m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212322; x=1795817122;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z08iZAIKKPepFqcPesU8KmKFb0C9ER3h7y4h49/8XCk=;
 b=UZxTmJx+wTp5fuZflkX2LgUnhhHHq4lowzPsJjcvfH8v8oux86L1Y+U4VWep7oKcud
 lY1QVAGnlQWJ9IMIgypXH7J0A8s5R55wN5itLw8gHBm7cIC9n0WGq5lcNO+lt1NWHcfB
 cEWrYXQzvRH8avlHWmvN6iGWaJZtPWn0hoJQhHW/rjLBh7CjWXZbfZSr9ggYVObGySCf
 staomLSXa484yxQrkLA5LdxyZHW1kLHM8wQ7zHoltgJo2x5GCYE73HoWnGgVC0Xaa3cl
 ceqeA6OExDwR0DK1IEPoLu94S3FOx+6rxEU6Tj3CSlof7uT2rRqOUcAsUfre8Ge8wM66
 XKvw==
X-Gm-Message-State: APuU4Z/EA9m4PBRNkJnM39egmM9ITKCck+7TEQ4WWUg26vM0VRdoscYE
 B1BDdTrbvFZ6WmiQPqnQZwp3knWX8ZZIqQmYuWLkrwk/hyaqxOtzgP8Sy/0+/tYB2Lo=
X-Gm-Gg: AYBFou2xgoE8m88n2yfxyZYNlnyV2vE8vfzQpdopbZg7GHbUCJQbz+EM0opGVILjPlY
 2Fvk2JmMYU1QZ1Yi13TMv0LinlIYGoikfYuna//3FUh0INzbpelpjYBiG7HuW4Z5uLntEjmKg7D
 6u5jleZKrLCufQOovpgaRugL89NBeH/IS27GlsTKsFEJ0PMCyQ94Gv7Bt61//KxRyDfDFqH6MAv
 p2I5AaDnPpgVEyKQ/aQjavxmGnUcXZd2OFfy0ncuVYTvPW81GXJHsbwfGezBtO+h8TuRd3dIXuR
 fkY8lXsR+/5xM97tYduhE45JmoHCd1m4YngTg4sWHfUtIQpmE4MN7rDMRUGNmB/xRd2gNlSc7a+
 Ts3kW8BnMonEd5sOvw2XNCsmZVj1A9gXVPDf69nuuWlmDjrxmx6GhE3PdtGsy2lH5R19NdLnjUo
 IHLlRzsIO/t32Vnm6y3uTaYYkmM6+k2I8OppitnmJYXGyGizNdebPLKnTwWjP82ejSJxWk8cMw/
 VC9D8E031qHOZECQCbhqW8MYpv1RsL/ItD3iJF4MUJpny5gBx0hK9wPocqU6NLaBOJbNImjzREY
 bdS2paWAzdM7T/iNy/Aj2gTEHguHkYTq
X-Received: by 2002:a05:6871:4193:b0:4a2:809d:8fcd with SMTP id
 586e51a60fabf-4bc84145f26mr3821772fac.35.1795212321746; 
 Fri, 20 Nov 2026 14:05:21 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm3878346fac.12.2026.11.20.14.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:05:20 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 16:03:46 -0600
Subject: [PATCH v2 05/10] lib: Kconfig: do not enable BINMAN_FDT by default
 with BINMAN_DTB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-binman-dtb-v2-5-4fa1894b7e2f@baylibre.com>
References: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
In-Reply-To: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=JwpA4RroIYBaKEXqeTjA/inLbvwJPnEIL0eCZjq+vHc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMPpChxipsNlCbqwiiopNEFGST8om5nA1S9hf
 OZhzmH4saeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDD6RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AcUQH/1oDrbdT/G+Gly4e/eKGcvepgA6/KCQb5K29KP+
 tjqIlTPbvkkYcv/A9mIps7R+MjtHSwsUFijaA+J7Tfh0wr4fRO9o82hRcjX6zatcJ8HTDwDopiK
 QZoe79GI/IMTEcCumGCa2Gli2WRAAnptsY/jOd2uuHz8kDrC/6xFcPEhjwRu0o6t7JMV7NzCNgG
 J1oKq8MUY7/uXcxUbCRigab3z/ROA8fkg1jSUYDoDHgf68GmTkXuAtKHhb7S9H0HMLC6jPIDehx
 mynoZGAEEw2SgkAuhMPM0/wy1xH1Xu52K6l2D2W2+qM4EqzZ8lIVyeRTzSHpKy+lH6UH1v0qrv+
 g2q8=
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

Only enable BINMAN_FDT by default when the binman description is part of
the U-Boot control devicetree. With BINMAN_DTB, the description is in a
separate devicetree, so U-Boot finds no binman node at runtime.
binman_init() then fails, which stops U-Boot proper during init.

The boards that set BINMAN_DTB today disable BINMAN_FDT in their
defconfigs to avoid this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 lib/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 437387bcb3d..9246953ec73 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -38,13 +38,16 @@ config BCH
 config BINMAN_FDT
 	bool "Allow access to binman information in the device tree"
 	depends on BINMAN && DM && OF_CONTROL
-	default y if OF_SEPARATE || OF_EMBED
+	default y if (OF_SEPARATE || OF_EMBED) && BINMAN_DTB = ""
 	help
 	  This enables U-Boot to access information about binman entries,
 	  stored in the device tree in a binman node. Typical uses are to
 	  locate entries in the firmware image. See binman.h for the available
 	  functionality.
 
+	  This is not enabled by default when BINMAN_DTB is set, since the
+	  binman node is then not part of the U-Boot control devicetree.
+
 config BINMAN_DTB
 	string "binman DTB description"
 	depends on BINMAN

-- 
2.53.0

