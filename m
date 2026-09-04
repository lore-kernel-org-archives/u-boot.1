Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EBFC79F83
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D509640BA2;
	Fri,  4 Sep 2026 07:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jV5jCPVF0vYD; Fri,  4 Sep 2026 07:13:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1E25340B5E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788506007;
	b=nXcQmrSqLKrSBay2N12eDg/PserceDyCZPQTKSfBGM/duiZNygz8JEvTYzzDqVmzTW1T
	 rq4caG7QKuTBQ6xFO9H1TII7WaYb7zNH6DcXhIjYjXFK7JaGVG2Yp5IoAl35UT0MSczCX
	 MNj1UaSHOjkEOmgqi3nuzpCxVZSpNfIBeAICdtnSzkMG0moSLhuY63WtRtSaquDOD4wCb
	 +UdCOymH9hXm7EEITqbM4u9dwANnWxwC75mVXaqolnZfwMf1vBHAvwnX0mudt0VcO2oDE
	 Qv/VvbLV12FvfpwpZKTM8lvf6V6MabIIkOIMXwOc73s94cDooZm3516BDhoG8rHb+NA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788506007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JYBURKnul0UyE0Fn1wMq6hSGYlXFVOCKbbREI++kZoQ=;
	b=hsWc4U0EIOSq7SL/yXTYc4vBg8Fhr8jh3Zk6s/WEjbbxBjx8OlhHsDUh1kcfx5sQ6HpY
	 84Nm5gWn+pvssM3XBN1CYJpN8m0go+oggMn7pUX1cVJLnidzYk1VwTGZ1QPJWFKncPcJs
	 58Q/s/I9RKwUOMQg1NEdMSa39MFCvxPipDjyNdLVVpcj5m69gYSvD1TC21agz99AZgcE3
	 X18BRCgnpRDpkWWy3DcAJmxnT2ohgIoHtzyjT05XTTjyNg0Rd0VGFGIFt/QVLmG3ZBtSa
	 H2g5KysvNJ2wSUlHrrwxwRjZLY06tI6EWVLrGUQQ+jqCDpdh9V8m5GB55pic1nAOwbA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788506007;
	bh=JYBURKnul0UyE0Fn1wMq6hSGYlXFVOCKbbREI++kZoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gmp5DmTePK/dm91lyHA0mD5gvNefuNQIls1mVz7YGbVSyRpkfTGI5ZIfLwmsreZSu
	 Dt1X3BFW9Vi96kale0ax/553x4It1MQevxCRWS84K77+mZX67Ohtv0Qotml9fWHWfG
	 lcTJMXIMsC/ZO9ZTVZda5H5EGaOrdFyrBWntKO9MhE/fYBFmoMjdlo8xDXDzP/Yjz7
	 AmIysqB/peRFYWq1cP1FXeofdZJ+qpnxTqoiAaGQ2FBNHW5Hqkd1yPP+yzyUQYt+t1
	 7Ucpi/mmPPUR0NSifEG+gl1AAMycZLhKScOEhA0YFcd5FdseGVMWCBrOc1Ezhlncc+
	 PdWcy/YKfhciA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E25340B5E;
	Fri,  4 Sep 2026 07:13:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD68C2FC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C28398117D
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6hbLIgDdxVVs for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:13:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DB92B8117C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788506005;
 b=q5Lo5GVJglc5y5PeIPD5j7dDW2Ki7AHNLFvt88nWIQ/r3qFEA083dFNlsP4ZWz+kDNWi
 4h72f0WX4u8xalYoCRklSXdIzJblDtuRR/NWs0EkmjLFZSTSReb6aiTsJ3vnOC+wPcd0k
 Q+OSrbeDfhkMgJzwLsRYaN6VPm36I9e0wWfTU/A0hVqgYEGY5UoVQfgzGqtfpFaF8TY5C
 z+7gmWEtz5qWplKJAhTFZy3/6m0JzsN/CciSoftH7mrsM/AeqbMdfoNIR6Im2MlboDbZA
 k8ukGzhICTf7nuyWNY5ovopwZ6ZOQoqEeQ5pAdevv2wpyahP6M76As2+B11PMfAKOwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788506005;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=JYBURKnul0UyE0Fn1wMq6hSGYlXFVOCKbbREI++kZoQ=;
 b=poisj+IuxB//aytVVOsHMScqwrnNPyIYULdJw5Aat7BPuMTVuCuaTWsqx2W0DbAnmPP/
 sqreLezLwR8fDA5X59m+/2X1e6xd73ZM9byClt/Kd3c+tyyVIE7I40MfiR80H25Sajs2y
 +16htF+NkCntVbdRuYn/O8IV2gqeWDHiZr7DvIBcAuRU2ssI31H/WnQewi/GL4SJ2QvBk
 8kyshd62yj0AsCRBMf0iyGzWcFVO3tSv0nlUjKIU9XH27mYhvosJF7CQUXZwl0QYLpP8B
 L7/UwMS1BTNoL1OGvK18L/CaaLivLed/uVJmuTlp+a/YiwFfY0DBMTriP8LmooukI4Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=JT89q2DI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=JT89q2DI
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB92B8117C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:24 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so9609655e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788506002; x=1789110802;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JYBURKnul0UyE0Fn1wMq6hSGYlXFVOCKbbREI++kZoQ=;
 b=JT89q2DIQkbNO6btUghAHzhblnTBzonrLIBQh6b3OdoT/xIjEZW9BPi9bSDEZH0h28
 Opu81uNC6hDdc+kAopGQuPiK3iXFzAYB+U9v597EhwMQkRMYR7V+/PCp+cR84bJ+QWwh
 ywKYdml2q1iuu74NApSu69qr9kvKapKwGP7zG+mlCzEBV/TG/brZY5MihhjmNHD5sAIb
 qcRtZUD+5K1bM51bOFAi89+8uUn/2ShvNQ5mNK4bVB1DlxAvnlVRXYoaEUsKTEX3iNal
 90AHdUIF9k/eznIsLVbZ0Is75UxGGhNgbfXLWagnS6/FMI+KtKv3Ajy+FMjNjwCCisbe
 JWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788506002; x=1789110802;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JYBURKnul0UyE0Fn1wMq6hSGYlXFVOCKbbREI++kZoQ=;
 b=JBQjFG4EWOVyiNQ8GW7AXYHw9yJ/LRpVqXasoWEeehw3Qhjlpk6AUbBksSHXoT5TrP
 beyAbtJwMCacQl7lnohei1/pSHwRhHS8Z1cXrV4iq23zi5Mb4yDrGdM3eLmri3VtEYq5
 dlhyuDCvv3uAYfyHwd0IB3W3eSYYGwNNVa5Y4s1ldsM+FurdGAhFASQscXmt9/b9SX1H
 e7fxDL7tDCqVxVEBOHyMpaJ3/bIy0mLRtcekd37G2foyVNZrBYRP5d0YqPSItMVFgQdZ
 kFax/vvaHKELItohW0srCgqy5/gKyH5xRefA5U5c1tT3bxPi2FY1PvnNX8o2zdY2cZDV
 yZvQ==
X-Gm-Message-State: AFuF++m5/n3HuTHrIejdoza5IFv+OaN+QyIeyqq4p5AWa0elgvQZiw5z
 3nEQZQjVuhvCkovLJ4JJm/KGxBTkN89CqpjfM1AHs7Ba0yayH9dS4/S841Ih4SrOvOU=
X-Gm-Gg: AYBFou2T/vMY87MvxwyUvMSuMufhwqTyZW0lri5mgeJE0vK0SOf20wijA9l9i5iMYrd
 r/OthFLILyDUl5mSO4wk9XKDEGz5HLCevz9DIuIQ/rvKp+NIitG53UikaFmPOwNjjMTMYhu67W0
 BgNq0k/mlAVbOPrq9vxLqDN7LpEj+EZwPPnVshJM2TcdKy6MJfF4G7A0zdX8HysjXHacLMu+vco
 V7v8SWtxWb6IWIP1po8MnMMsIImk/ZIHcOITyNCSVUpiC1pH4mdbybX4erdIC+DiGzdBd0EWY1I
 i2xJMs++occ4TPqYll9W80RE8x8xYaG5dlLw42M7rzxQUIFL7ghqvH7S2fVnb2LRrFK0tmzF574
 1k6D4uoYriPHKzC7nVL7Vp1BdkCaitSbnfgUzoQpBHbX74pFwFw0NxQZWL3v3oWO4jW1gCGJHuF
 EZxrVnYeqGXKggDK3AV/JCiH37d/LHHleeXelnVfR7Pnb4FanXTaHtsJwkn5FA1T21PPFt7U62r
 wsU3K2sDj47ZGP+xQflcS4g16MDyLNZ2CgOS0er
X-Received: by 2002:a05:600c:4187:b0:49c:f13d:ffe7 with SMTP id
 5b1f17b1804b1-49cf13e059emr58312565e9.11.1788506002350; 
 Fri, 04 Sep 2026 00:13:22 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm4261923f8f.8.2026.09.04.00.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:13:22 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 04 Sep 2026 11:12:44 +0400
Subject: [PATCH 09/10] ufs: expose the boot logical unit as a block device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ufs-spl-boot-wlu-v1-9-59aeea16c4de@flipper.net>
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
In-Reply-To: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486; i=alchark@flipper.net;
 h=from:subject:message-id; bh=nDUtLmLFWMHH/w2G7ufP/IZr8sqpNZbVoS7E7g6PpUY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNyi8qd/KtXJz0OIWjtY7neMzczWHClvPnBW+W+Gtdw
 hzd8P91x0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFMt9JKR4b/oB821h40l3+XZT1qt9MnohdlLj9X3ElpcY+tL58dPvcDwv/JzQXL
 jnsWVfwRe7y0peSp9y+bukXBftdvXfhm9E1iwnBcA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

The boot W-LU aliases whichever logical unit bBootLunEn currently selects,
so reading through it follows an A/B switch made by the device itself
rather than one U-Boot has to work out.

Leave the device and RPMB well known units alone: neither is a block
device, so probing them would only cost two failed round trips.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/ufs/ufs-uclass.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index da0d6f01146a..ba061dc8aef1 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -2195,6 +2195,13 @@ static int ufs_start(struct ufs_hba *hba)
 	return 0;
 }
 
+/*
+ * The boot W-LU aliases whichever logical unit bBootLunEn currently selects, so
+ * expose it as a block device of its own. The device and RPMB W-LUs are not
+ * block devices and are left out.
+ */
+static const u8 ufs_wluns[] = { UFS_UPIU_BOOT_WLUN };
+
 int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 {
 	struct ufs_hba *hba = dev_get_uclass_priv(ufs_dev);
@@ -2211,6 +2218,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	scsi_plat->max_id = UFSHCD_MAX_ID;
 	scsi_plat->max_lun = UFS_MAX_LUNS;
 	scsi_plat->max_bytes_per_req = UFS_MAX_BYTES;
+	scsi_plat->wluns = ufs_wluns;
+	scsi_plat->wlun_count = ARRAY_SIZE(ufs_wluns);
 
 	hba->dev = ufs_dev;
 	hba->ops = hba_ops;

-- 
2.54.0

