Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E992CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 21:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5CB660BB7;
	Tue,  6 Oct 2026 21:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DjRsrHaouxLr; Tue,  6 Oct 2026 21:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D1BD460B7D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791323324;
	b=cb7Md9vZNrk99lGaUS2oFs9+Ac3z6SDJ9ce2p9j7adwLLMX8sM+fFQkn7xI+3NKVwt+J
	 NIWZTuwj4U7kSsSE65R458KMyyr2DPk/BL9tXcS5Ez/b7PNQ2OqBV6OJIXSbZcHrtLFJD
	 NypA0DX77XeUsHpuzlDVCS8Sok29QCH3eFedKlO4utDE09L0pq2lar8ONe5wo416na/Sl
	 3amVQlgaaBzBLIY9lnhjAUyWXEcLRjgB9/1gkPmRrSJzZMhSQJuheZ8WBH3P51ESVUfL6
	 2qR1YQ180cM4w74I1CNh2fuQy41Ns2yp3XEyewjlqaOPh39w4HEsqPyKKJYeRpLc9iA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791323324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S5+U7h0oQfdn5uX/PDww6tOtz65Rq13B6FVoO0GzI50=;
	b=QU0Xh7TFIyQZ0YjmfAgOTQAyb93Y+urGfdYsVJBod60RKR6j/tI/Yivsvs1gGZGmfTnW
	 lEW8sxw2lRBxtjGuSiRH2ynaw9XL4nlCzDuL7xew157pvwNtUA5USzywEDMofyAlxf+/1
	 5p6EQ1A7+JgmPrJd2TBTo1A2DhsaAYjj0HzUXEHn92WZzeqskb2qXjRU70KRTOkGZOG76
	 RdQKlnRBjbnHAL2HDj0AEU5MRdZE8/oaGt+DTnKLO/XYo/kbt+0eZ2JBkxO1kDk48zdhb
	 kKj2wvK5AooVFIStiVEe1yzwwi5NWmBl3YifIhXkSsNThgRGdtlwUXgtGfZDyhVf+gg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791323324;
	bh=S5+U7h0oQfdn5uX/PDww6tOtz65Rq13B6FVoO0GzI50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EKBqsltmP12w2vTdmaP2TSXce8BxyyhSyPpAsDFqXx7QvvU41j6Fs8J11/JfCErok
	 Bg6OSPcU06qmiMtYHjPgdEexxwJO2bWWR6w3WkqRQI1IldaScDtkzv8VuzdkmM6sVe
	 vIt2XeSrzfZv2yKgIe7GGCLzwFIta+BGHJ7ooeyDsHnRgUiQPG3aK3XizezeLAuHab
	 QbYn+Jl4vjDeiWIsnax5rwvrETKneAVRvyxti3+dOqShSecLOkIxp5re0/wMOcxQQT
	 7KIp5jdEyx9ISGShlE+NKSkhCUcJobg4R09ngDLQGMqYSZt7hllmgkN1S7y1tg6Wjk
	 3XguLTNwwHdIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1BD460B7D;
	Tue,  6 Oct 2026 21:48:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E99132F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5FD2A40719
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sCgLRsvYKO5M for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 21:37:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 16B6A4063E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791322664;
 b=aegFEfxRLpu1tglGzrqeKDTB4Ymx2U6D3mEAmawyg1SNoaUn4MDqN4648afhT2mOus0w
 19BofOCe4G1VerwZG6FyeTzO6eAAHFnftsmTe5fwIETfMaRQO2BXigB838vsq4wiH9D2U
 G4WQxWCFUAQcfsTvrgQ/O8RCbgmQLPFMF7jtERVGdzYhiY2FCw7W5X4ee35aYwQsLaXM9
 5ipKodUruTS6BDm3+QOIreo7XLcmmXwuXCqp4hINf2RS+CN3p1wntuozc1wU6gX01lbVY
 qVRG1DbN4Ls0IKioyg7vlukV+Dhc0qrc5UHf1gaAO6CYX9xR1TXp1hWEFypiaQSZ1xQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791322664;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=S5+U7h0oQfdn5uX/PDww6tOtz65Rq13B6FVoO0GzI50=;
 b=bpaJfj2FLjW6zvkOBhg/aquk9gjBuo/JcPdpKgFBOuRBxeHXwE4dapYqzEqvj3BWZ/kW
 x5YlwuHOjpboEUkyjr7GAfKw+OyIhSxIFifBpn7Ovg5WDt9GR7C9GUw3tzYE+7eT5mvzh
 7zv4a9JyMn987EuW8KLCu37qQ6vsTY6/nqdrXnXoE6mzGEPCRI+OvD87NZMYmoMURWUZI
 4+jHcsZoK/4au7usv4NlW3xqzF3rjhJTEaU8H3P1cmSAsoVcMZwavlccnVPiGp6FFZLsU
 aQF/LiaIptWrpFvwroPpwhdSkKSEdmFIdTQem2o1gaTaQp1mZc6b6JeDZNFCS9xC5/w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="B7VOk6/3"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=B7VOk6/3
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16B6A4063E
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:43 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4a4cb36ae00so603188b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 14:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791322663; x=1791927463;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S5+U7h0oQfdn5uX/PDww6tOtz65Rq13B6FVoO0GzI50=;
 b=B7VOk6/3DVcm95CNt2CGvYo3req6JX3Bj/MrZUxtC0yu4jLuvNUq7GuRPBRNC6rxca
 wxl1J0ts2LZ5dxCLxpm20GgBIxm+3cduHZm5L9UJPFlm737Jwwwi51tG77BfifglPM06
 awQQTrLRoMb+A6DcY3H+B0G5ye7nf7ek9NX7aaNHWCGg9c/sNX25bWUGD+c+93kOO7MY
 Tv3fMKSdViSvTQnAQkj/hL2fzEXuo3qPAaQgZbK3lWPFPs81FsrlKE6K8K99mmu58YpG
 vjy9MLlpsNHuR8AMqBtyuJXsppy95cxVLKaNaHB5t5F7LO8EQUW48AOCoxN+gFp6XunN
 fZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791322663; x=1791927463;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S5+U7h0oQfdn5uX/PDww6tOtz65Rq13B6FVoO0GzI50=;
 b=PK+hpZ/hg6KMjrd/1jc5IqdohxFUxmNVOAEKzm6ye8QAjmpAV4mCQuXc3y9yPpATNv
 e4PccRdFzhmtGTuLYIG9LxYxAnwgI1qJvq6b5WOqxLXE3mjTvA74tmcyYOgL+TDqhp33
 X5kPBjinKPEbzsFe68T1NJh6toJHM3khNqN5O60ldJf2W5RQ/nAez3R/Ois0iC0UEoI4
 v/e+bQza79Ldnpg0wNB9wCWIG8ZirFCvJ0WSwPlomDPZx1p3QT0nVnAApSitB8Aei5Y0
 wYopVp29GG9aflhJVZDj1bdWaYsx3BiQIkNU5JWWrsM8OrTioQCZsP0PSSmf6k4Gf3vA
 0KzA==
X-Gm-Message-State: AFuF++lukqu0HzIk1EGVve7Wr368iQ7NPgg7m+RF+3kLxAmSBNQ3T/KZ
 6IL2+KzayNM72xFGr4Av075XhGx1O7JcNXX/CTaFd/FjD6pMEzt7QOfmSp+FpEPgmu8=
X-Gm-Gg: AYBFou0bTPtWHSBq9Gx1QmhoNXDj267pjWeYjQaLO5RIBSsV//jnf5o0RUplp3IkmhS
 52/+R0h2DMZlNBVXoUutNR04ZSNV5CptkH7d8arDUPOzUStWrYQS7MwVpxLlr9VhiTIiRQH0LcW
 UA9wurvwDFEVwm6/k4BGOOZDq0b+Ix2sKDri5ypIKYTmL1axeevmxIMtlIrZ615UFhlQGDXEWev
 JchFDb67s7t1cWrBk6U4ccptjuDu+qVeLkhi5hJaIx1u9vmLGNYDxQEudSslQ3JkMjFRFqxZg5V
 /O12zD7pKSE3Z5wprbJJvO49zM3Rj4eGnEubt1QIIC/Uf7k+dR22nq5oBndmbZILcYYUrvsdQfh
 5BGelP1bhkD0GdMQwxX9nwqvsaiaXL1dNstLEf8OT+0k9Kilayhy2kEUWQxVP0XXsXemuFpTu0j
 TpfWWZ0cuc8fzAj6nRFXeIdLvx+4cr/gcAASm/QXqxHM+XdL3Zy/1NQEe4CmNvO8jAKpE+9C50h
 Q==
X-Received: by 2002:a05:6808:1208:b0:4f5:4eb5:1cd3 with SMTP id
 5614622812f47-4fc47cb6e3bmr517362b6e.61.1791322662791; 
 Tue, 06 Oct 2026 14:37:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4fc4953f89fsm389386b6e.12.2026.10.06.14.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 14:37:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Oct 2026 16:36:20 -0500
Subject: [PATCH 8/8] configs: mt8189: enable the DSI display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mtk-genio-720-dsi-v1-8-7fa10e9c4506@baylibre.com>
References: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
In-Reply-To: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=742; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=RszQIAvToHWXLOdx8Xexre3i1Fo1IlD6r9jyBfM7fS4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxWoIAIC+zL2nGFFnXeIWOVdaeYvghQfe7T67o
 cfn2YX4i/aJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVqCBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6psH/RnIPuKwn4QMdJD9CxQhp+IYO8HrH40AxKD5S9l
 pQnZWt0dsYqbrd5f9G1+RQnCGnWwayV+cnpkUXqAMYkDlFkHanbMQL6OG4SPgdQG7byCnkAaBbM
 UPXypMzOBxFyALA32L7FjHs8kBSgn/1K7yJS1q+5gmzwtzit5aFgkE9QkBy05OK4lIKA09pZakS
 cXjU+nrEKdDU2xeWwO3dS87KBabC1toZGfMDCirwYg3oBA4ejLv0kqVwYvcDhYiyTirme3+MEKv
 hL3tGlPf3r/iLhmJcQ7vGI8MBAa/5bT4/E7ZLgno38fp2rRAi3yjHFrQ3fMrZ/ATwI15pBTvD0A
 Lzrk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Enable the MIPI-DSI display path, the Startek KD070FHFID078 panel and
the display PWM backlight, so the Genio 520 and 720 EVKs can show the
U-Boot logo.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index 8fdb6eed288..8995772f41b 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -46,6 +46,11 @@ CONFIG_SCSI=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_MEDIATEK_DSI=y
+CONFIG_PANEL_STARTEK_KD070FHFID078=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_MTK_DISP=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MTK_SNOR=y

-- 
2.53.0

