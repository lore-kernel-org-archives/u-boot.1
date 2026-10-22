Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5048606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NzXuPPAd;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KIQgnWiU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1973405B5;
	Thu, 22 Oct 2026 14:03:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BP4-CXQVJNzq; Thu, 22 Oct 2026 14:03:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DADD6409A1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792677821;
	b=N/OqeUyxuyiIyBw9ujqVOxaeW6Tr78gMPqartNHgfxFVdmKxQBedK3U3SofjC4lwWybM
	 F/r3WYo9BXPu6gGNyk5vFv7LIEyae1YGJPG9nzQY553nACNtguyu7VU8cRclRXbz08Nrk
	 RnZkYBv6dpctls+ugetFpMlgbchrrCxaAT2vjHxt8+HJNYzN/UuTnXHLOQmFRkRnvtfqK
	 hymejZHGYVwxBjpocmZXFOkkV9Ab3O9zWMMJtz2Ik76Xoo6o9ebunhoFQhaNDYsdOImIL
	 Rn/eXKUv061QHi95gbD/hFCltpst8gMQJP8kjliM4GjBXb73ljvtsMdJqHxfCdlUf4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792677821;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=unJaJM71hO2aXQBOTYwH3laakFr2QwTTrSXjkwnE1Mk=;
	b=XQwODf85oPNhv7/GvHhwnkd8qOZiW2O/gF7tfr6eaoURFTIFDsfP7l/taDl2Shd9Pn4E
	 SIJ5lruNmejElSKefYIjwCg+TaCJ8DnqjqjXwyLoi+LRkG2MMCCQalGeV7XOL8xEFnI3D
	 GWlLWAo83l3U+I7zE8o/ZZQzkzxF1uobuEDxmCN1kcKkJ1b364kt04pKWSVq0IZan+nel
	 KmPWYlgaH0QgBysF9WCsQ5eFy5zV4oOCIxZrNKO8+xiWHxZa1ow4qbjelx7VHGY+9Yg+b
	 1ZEkJ5DPj9EtUNZ0goGdB0xHUU+UXcFDX5NMdlNLdsZz37rad0v2Un9kAmZVbHkIkSg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792677821;
	bh=unJaJM71hO2aXQBOTYwH3laakFr2QwTTrSXjkwnE1Mk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NzXuPPAdlh2dFbHDHg7js877E1Z0sxgievdeGljX/mms9kRdbt/DyPuaob2hKel34
	 wOgjk3vp2V0IquTNA1FzIE6gpwKnSbE+kDC40Pt9bdNSYqGReq+4GtBRto3YVbuOzD
	 YUnfSCDFxgu2YR8Y6NRzHIZrF8qyDsGtSp+IfxqDzbyN4W+jVLMV6Rd35AFhml5OmO
	 Aj23D+U8D/K5unyeWhDgosccaoxpncMPZRwvLrjgP9JcJ80/mg0QYhdG8HvfDPza/c
	 /grFO9MBr+FbNOcAQ6IkiQTvMkEizC+1TlTHTiOl+zbXJQsKAhVExQa0AJWCGyapw3
	 ass4bOQgCxhuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DADD6409A1;
	Thu, 22 Oct 2026 14:03:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 17A2423A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F229C80DBA
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:03:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VHsWBfT74omH for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:03:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1EFC680D66
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792677814;
 b=AYTjHQ8A9yPmCjMqDUU/TbNsprOzoq6VJuizUuppiqun6sU4kgzWY11ttSe6G2mzbfdu
 ASmqkthVD6stAh5OIpquyNG9yguZuQxXQjBLVKLqGZSXrX4eR0eDBeeZnPTxgZt6xqU23
 B071+A+XhogEQM86VObZgvq/hfachUKV9U4iOw86wjwgMg7hHGCWV1ro6X0uTPGD3CBIX
 iyt+dNlQSEfTooIQAfGihPgd7forNWveE4noWUlmAdWUTROrFACAGv7unjUpZkMC3u5uw
 zQuugWXxB4i/dyul7Ckw87mh9kzrShRXTkaBgJRDik0/n1t8zDCqbxosp026yW86PnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792677814;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=unJaJM71hO2aXQBOTYwH3laakFr2QwTTrSXjkwnE1Mk=;
 b=og26GgMo1a8b9wjcOJ6n9+K1hBo62gZ4z1uSaB273Nsn1TtLzJzNCRYfnod0MNMIkThZ
 MHA6hOlOwEuoVWSJDCIA6tVWadb4gN6WJf0gnYo/5GR6HaftllCoc7MXlIC0RB9fhy4a4
 j/8X+F7otS2UIfGlmureCyyJAuJSHBfvnPeQqY905WDhTBOfpLVPnEAKd0d38ysJsUSZp
 S/mMzDZ0GFqslsrn+v7XbgL+p5xt2b33u+/ZHp6oG9sHCpYrcBHLyVVRxxW5XwwfhWCxE
 IYy6NLael7QXIXaq8QnNhELyc9pn+UoDixSO2f81Lgh3DyFStQSjzjJhG6cD+Fpwm5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=KIQgnWiU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KIQgnWiU
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1EFC680D66
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:03:33 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so4107005e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792677812; x=1793282612;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=unJaJM71hO2aXQBOTYwH3laakFr2QwTTrSXjkwnE1Mk=;
 b=KIQgnWiUm7JPoLJBgfiQv1NgZsv7sHRsuUot4FBZ6gE2kQSUXAQ2QE9Rv5i+9i6fTt
 7COCZZqSMSU4b33/SFtTqyRINGXV4VNmEn47YdkJJwZzTSc+d7M0C1tOXBLbZpTCDA6d
 FsU4raOILsYhNoPaJ1ENfbDoFTYuCQxu1msWNvzldQ8XHDgH1bzK6ERcxI4y6mLblb7Y
 ZKiaFhn0DfwRyYK900FPnJ1L3Zt7iil53TgQzm8Y0PCUaDj9q2ND4A877EHwQ3771uST
 n7mC7MIKJKQzKgAN4KYd7V6crOnc8Ato3f/ikN3t3D2s95tHxy9F54iQ8Gv5Z2lePXHQ
 Em5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792677812; x=1793282612;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=unJaJM71hO2aXQBOTYwH3laakFr2QwTTrSXjkwnE1Mk=;
 b=WD5G/Ge/tsieSPpMW1V8oqdL1HL+yw3xafGdz0w6DFrIBFzBDaow/7lFYRvIVoNwyW
 9kQutd399IUjKhgwDCaFcX0g2PpGPJU6EdtakI8ySp7tXDl8F3wBxB4Bat1spuLFpz3b
 cSHGlqmBtuWFxkOMsecqWEk4K0s24ExgRmiul3+ZmLUyEQpGC7UPPss8L80JV0EywFGj
 R6Zd8j+gdmiN+iwZVB61l8ywuA5Yej9M5vb4BAAr2nEieA8BVQVImmgR91MN7bhY+Oiz
 QEHr2I1FId6VjI5zNqu+JtGTPcEiAgouOEtqLZMwzEPZdKZuA/1mz5ipgDYL7DcYV13Q
 bqyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxotANcEP3qTLTaI/L555G3jDymNssHDLSTBVWTR3YVYEkJ7CNWFrUD8CXEOr4vCB5Zz4rY5cI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIEWqvmBcphTIRxA/iwOc9gYB3Uf2u/YfVYmxR7hALlMHDLhvVo
 2w+M5mmUOOFN7d6qHeEmPhheRAucJirbeyKhJ3uxatNbQxdE1k/LHHOnJx5YF18/zO4=
X-Gm-Gg: AYBFou2hPUIlKuLt/l+9MkPrPby8jGPeunUnqAE49uBjRcCnLCYD3x5Jxc4jp+wycCh
 86B6EBz4WQEjdidJ8kWcc5qknQmKJjouxHUw0k547DyrCovm56l6rMrRi/g+6OVRNPO/Aquxesg
 WaT107BFG3uskrDPB39oi701kZz0j7pCAMTwo+y1UBLP+wciY2H6RatdGpBJi6QownGJLW0TQcc
 GZswX8Ta08YKQWjfXLzR4q48NmU8Yasetr0Tf9LkJ19j50xTERfu0MRxctPdB+WXjH5s+wT5v02
 DAdhtNL7JYCRA4y9FCj37bRVThjJ16nKJT0OgoTvBGLPf5blxU+HqApbjs/u14+cA+snxEwGuyw
 9gpnhkg+Nsy5r2VO/PXMDE1hAR+EdCAursfxTGQi7Lgjhk8jtxORr66zc0X4q/g8z+6BpXijep+
 ZHvLZDk7zF7AUefwIsTjMYmCeISVtIZ7NyFDKSv1gtEit5bsatSBqhzXw7Cw8mq2IN7KULdxQm4
 kju+pmuKrNTAA2pJuwByImipNz4BYC/PDOO95vucadtiUd5UKOq18vv897U6r4Du7bWMpbjBNpq
 QI+5GxNapwBtg/qi/W2gdCvQRgHUSuC6L7ytP/dR39ZuHKXfM3BKL7Yz3+iJgwFMCo9vUGc05Ef
 OHGI1ox+nbQVJ+0PyZo0Rk6qpFTSo9FbGZ/Aq
X-Received: by 2002:a05:600c:a49:b0:49f:ffa2:1c72 with SMTP id
 5b1f17b1804b1-4a204b20321mr49468645e9.11.1792677810414; 
 Thu, 22 Oct 2026 07:03:30 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-f269-609e-a542-3b36.rev.sfr.net.
 [2a02:8434:7c41:c701:f269:609e:a542:3b36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203b66f6bsm102604335e9.15.2026.10.22.07.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:03:27 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 22 Oct 2026 16:03:46 +0200
Subject: [PATCH v3 3/3] configs: mt8365: enable the power domain driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-mt8365-add-power-domain-v3-3-90b82ec1e7fa@baylibre.com>
References: <20261022-mt8365-add-power-domain-v3-0-90b82ec1e7fa@baylibre.com>
In-Reply-To: <20261022-mt8365-add-power-domain-v3-0-90b82ec1e7fa@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
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

Enable CONFIG_POWER_DOMAIN on the MT8365 EVK so the scpsys power domain
driver is built in for the SoC.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8365_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index b3dcc5cc5b4..cc01dcf434c 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -22,6 +22,7 @@ CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y
 CONFIG_PINCTRL=y
+CONFIG_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_MTK_PWRAP=y
 CONFIG_DM_REGULATOR=y

-- 
2.56.0

