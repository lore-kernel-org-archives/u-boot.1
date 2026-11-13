Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268C606A88C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b340TaED;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RPBOSwtG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF0C4815FE;
	Fri, 13 Nov 2026 17:31:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DTl_EmlOv2pc; Fri, 13 Nov 2026 17:31:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 02B7281360
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794591116;
	b=KBRcozR32YeML5zveGPYIQVJO85PshLSkRYhKIZOggjq6g7mdH3fTTUigD6aHy96ayrz
	 oOfz8vCO+Ud6JPUnNwcQ5INMtjED/yZDai3uVQVFG4lrCLb6ZtI2AhFKjDrfWMq24tcgp
	 cgb+oJo1Lynim97HL+h4Iu929u6ezYp65kEHiiziZ7fqowliUbBv7QCDvX3xUvGNxDcrs
	 pERNGiEj4BJsIHpoU+1mrCZmwKIQtsMCQrtsUlj/yF+AxN6aYGSmJuenFoKUXltHcDKiv
	 M94B7b1O/LqKb5U49XtGUU0/lWQcjzVpobb0nXIkqtOK9Rm/6nLycAGanMHsv7LBQdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794591116;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SbH71d1VJO1oAkqR2XQrT8DCFpTmVZn1XK7UofGOIbQ=;
	b=E+o18SowtX9DtGQZImZu1TxgislILSZG/BiYuPmgaxBdhzY4dXjFSrriHPRWJThhJrdn
	 NFtH+/s/XcIE9s1p2E1ddTfIYwZoNT0s4y/mxLyWk5CnMhSTUty/U3UKWsj1aTD9TykTN
	 7NMsFaIt+KNaMr8e/tjV9qrBSNT1TKtoR2ZTmkXACml5ooJeebVMOCwtleGEDoxfE5/eE
	 2U2UWVehgrsjfP8FIUtFfyT85sCGF5Z1A/KrNquj6rvVpw9o1xbWMoLjrFz86AOCCyCcl
	 qnCnGQnhuYJT6teN4P22h7spMzoFoQzWk70X/MJDInMjQbc+Kuqm0P7n8XPeWcPqUmA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794591116;
	bh=SbH71d1VJO1oAkqR2XQrT8DCFpTmVZn1XK7UofGOIbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b340TaEDeGQFgmE18UcLIy6hTyEYW0HwEskvwoOm2MIw0RcecMhMy2FU0PyRPqGJ3
	 MbHlBZKpe2GVW/fi4pPsobJd4ipH81gpK+NeuDElLkjyETgx68stEyAlSeJxzoAO5P
	 Jcyh8uKoMMIXSmAsvgNXyhyhQz3+10zbunXzZsi5TV6hDK5I67/2+qOd1jniQ7gSUR
	 K9v612GsQos4OAWKN1oZjVwWGZbRlbJFLlbOV9a9D8IC/8Z7u+cZ5c0J0HyWm1JJjj
	 Yhf5RehSk0qukkNNxcEXooSRKx2Lfu8wZ2tZl99I+rXoEiMQyNbwc6PU99zBb74jv5
	 WgSpF8dwZmLLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02B7281360;
	Fri, 13 Nov 2026 17:31:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B2DC235
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6114A4005E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7YHUwxuaLXOl for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:31:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6CED9400A8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RPBOSwtG
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6CED9400A8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:52 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso490213f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794591110; x=1795195910;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SbH71d1VJO1oAkqR2XQrT8DCFpTmVZn1XK7UofGOIbQ=;
 b=RPBOSwtGmUJrAC4oOSG2wHZr9qhyHzOSv03/Stv9sAZca8Ge/c7ILzhLBX8ohVSa5I
 VyXbU6NWGC7YW8D+gcjpHNstaoY02sLMnVlzfjzajKyt9Mbq37twaOo1zPftin3LKvIx
 Hzr8FmnyEsgvbC/c1DMcwwwY61FUHTkKFhtbEDJbgOCKr/kEXb/H8xeyo7u6c4yoslEO
 nvnWR1iFyDgUo6/MTLSAeq1Hqni+a1cbqEVUTz70HhZC5rus1UG2JCESN6BVgaO/U8K/
 oLVgk6BJUTxth6v2H1jJzV0CUo/T69W8GRAusz+b0vc05C1hgUyzhqXWO6fZ9qt8q8tA
 TtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591110; x=1795195910;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SbH71d1VJO1oAkqR2XQrT8DCFpTmVZn1XK7UofGOIbQ=;
 b=2eWA4j/cJ/8JmaS6DSJP4h58mPnnJQeAtE/LvW/NOwSF093v5K6rY56Gio9q+TXRk5
 vuefy9GRL2IfeuVdGGUTFNycSThQo7r3eD7ZPvnyosGlvXXS5/oTPkdleFuX5gdfs4CJ
 7xEp3mq7Q3iSel2YdTtQFoVP7OI4IqVfkyQMVH+USXFOdozPcCVR5DVITwoiLdasOvH4
 ugJHbDMG6Ki058WgcNeeWZ7TuF5vTYFdsbuZI0WAAsTPYzMQkhL/O1CDEnF7C4XL7uUI
 VRgmCYymVJ0xhSm1fsCGXcc/3gojbPpr3z3+V5EGYy14uY5Lmkw+3j4+4gXEOOZW+jH4
 L8zQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHTUpFBcfajzctsvMiYD2YR1bDUZBGlIUkCrHuY4VBhT83rX/X2c/eMn5ddx0ZWvzqjGabtN4I=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z//AI3Im70BD3FG/cCAaPRYWbZt2NeFoYU1J7vGzju9M1SzmZaL
 w8C8EQ0eMW/L6qswHmePPCYOPyJmbgDy44974lRwfCEvYpqC9/3CeaZo
X-Gm-Gg: AYBFou2FeQUrTfvocxA6ZQ/OpdusrJtll6Tmavn6VQlg1tDejmbwVHmTIvphUGzO1j1
 EpgwCAoIJ1stVbpsXq3ClT9nuLOdEFtOQ/GLK8Mk7+b9+8avfdc16HbxoTB7b72uI3Q895DtVWY
 wzUvOMGZ8tmrGx7BBFuIkzKgw7I5Ro1ckSeyFTxlJcBnd9yUpHUj4LZz/ben7ULc1A8B/Pb7Avy
 ZoQI95UdHCL80e0sqyri308PTIQDaDiDLi5nYLlLlPI1kY8FSqOD1ygfm8d0+SQlXpVzOs0nIob
 VB4hIqUqvaGGKEU7orEqGEj2OiyClBq4uP/DSMlruxyuTi/2x03EnyF19IAsMO/WOSzlKGXGqkJ
 iG2pPLzO81f/h5Msen9akTnOme4HoYKt6KgiZpLaEAOwCd1SgQqdP75KPxHpx3c3vvkTMJ+uPgZ
 9akbphqslZJHAmvg+cdqCG+iIlzZ0VW60NqwECKcWdFh0DDMxErG39mv16k3G5DRhlSNuJiIHGw
 QU4e4DMnaVAwlDZ2BnIS+2SC+xnIHzKXW+MZ+sV6HcaF9CYJ1GU7kJePUng9SHyVR6CVDPmbG9Q
 9kVY8lrxVijcXO6+YVc9DbUbFA==
X-Received: by 2002:a05:6000:29c9:b0:49c:192f:cf34 with SMTP id
 ffacd0b85a97d-49c740bcf38mr5336750f8f.41.1794591110106; 
 Fri, 13 Nov 2026 09:31:50 -0800 (PST)
Received: from [127.0.1.1] ([151.51.254.138]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c81a63b1csm5587810f8f.4.2026.11.13.09.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:31:49 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 13 Nov 2026 18:31:40 +0100
Subject: [PATCH 1/3] Kconfig: Make LDR_CPU config option depend on ARCH_SC5XX
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-ldr2-v1-1-dd7dbf436494@gmail.com>
References: <20261113-ldr2-v1-0-dd7dbf436494@gmail.com>
In-Reply-To: <20261113-ldr2-v1-0-dd7dbf436494@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The user never has the option to set or change the LDR_CPU value because
this configuration option depends on HAS_LDR, which is a prompt-less
option never set anywhere, neither in Kconfig nor in defconfig or config
fragments. Therefore, the user is never prompted to.

Remove the weird dependency and make LDR_CPU depend on ARCH_SC5XX instead:
this is the only architecture using the LDR format.

Fixes: bcdd02328e65 ("build: Revive and update LDR format support")
Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index c8cfbf5d5de..a049cc80806 100644
--- a/Kconfig
+++ b/Kconfig
@@ -796,7 +796,7 @@ config HAS_LDR
 
 config LDR_CPU
 	string "CPU name to be passed to LDR utility."
-	depends on HAS_LDR
+	depends on ARCH_SC5XX
 	help
 	  Set the CPU name for the -T parameter in the LDR utility.  This is
 	  generally used on processors from Analog Devices, but may be also

-- 
2.34.1

