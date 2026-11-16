Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A729606A891
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uTl4Nf9C;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=WcXtgVhv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6526480DBA;
	Mon, 16 Nov 2026 22:34:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2PlTUWodvnWo; Mon, 16 Nov 2026 22:34:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B563180DC2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794868454;
	b=UeSW9pwckiyyIf+4OWlnc8ngsNMe2++ufsMmorY6v/Q90SA0gTaP0AP+OP8sJ5HgMctU
	 YXt8g2VtA9aqzHH/AUZnHjEx44MJhIIPU+zUFjywqinoSb4pE9cgFP/735P1yF9SMPi9u
	 FN02DocPd7OPWg+X/IthRIVnC61hd/9FAMwAQieCzeOUrxu/jaA4+QsICB8dRmSsYCOn/
	 muHmmFK1zg29ZNu3g/+mvI+9Q8xGJCGDasFbJx/kiz8Kyv69Fs1Nn9XsneVfBJCTCOcVG
	 FIDFyFj6tYy06UjkjxavNSGhk6QS3PDCh/39Tt4vL4kQV7V1oAOTn1b76ajEtazjV3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794868454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J6KiWeVGisFsmwC3wX4yS8VGNysjeBCcxG86fNcWx/U=;
	b=VkyOh+bWBZ3wSkdVGMd6DAxSsm8rhdBdR08dyMza23lRS7bZfMvBK/LLzAUN7DogNCMO
	 CGt3qDiu/kYyiwEurNNoDH7lAwwTo38TW9sIcgndy57CRE4MCLoCgNd3Rwm5h12pPbnpc
	 G3yWJQaIPLMmq+X25slL2bAj3zxZPzaIP0xyTrLGxmsCgsNezN57GtOIq6KvWCN7683dc
	 iI6SKkD1Mmlw9FC2k9BVrrKcx0MV/54oxvUQUpJBwXptnm1MT4LjsC9KphNXYybk1Wfb8
	 qTmzQkfgfiFuyJsh+Q1Dc0+a8Dwn2q4R02fK6ym1Wo5+NQjbXooghmsJk3tKEoUKv/Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=WcXtgVhv;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794868454;
	bh=J6KiWeVGisFsmwC3wX4yS8VGNysjeBCcxG86fNcWx/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uTl4Nf9CB1yCcZnPYDCWBe6CbQ8AH/+KrXY3pMWbJaxwYGMx6GDQavw8doKPOPE9C
	 NYOdzITcuCHPZ/adqTflHqLoXta0T6iO6TEOy4krzWVw7IIpTQyP2cF5IPyOC5hcDe
	 WguGqdg9mFvkZ8Yp8biKsU2mArnscBuTL4+r2rpENZNGdEeLFlM6F4RutjJOk3CkJ+
	 xDhF2OIdMKb9o7PX98YQEmJ6ozu3MYEA6esckxT7DL23BEC5+ZQa1jBo6hwJSmuwrT
	 MummoEqSRB3fvoCKJBGlsflL1vVXGYzdAIQfngg4zggqRCDKeHl5SAV+1+Y3Oz+4pz
	 rr+/pyQoOF7Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B563180DC2;
	Mon, 16 Nov 2026 22:34:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2ED9B49B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1521880DC2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id arYOUiLbOPxr for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 22:34:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5998480DBA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WcXtgVhv
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5998480DBA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:11 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-57297329b3eso1085945b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794868451; x=1795473251;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J6KiWeVGisFsmwC3wX4yS8VGNysjeBCcxG86fNcWx/U=;
 b=WcXtgVhvNiPGykwOWhgeXVCXfhcj//3Dcp3jTDE3imeAFaa3g7OCgdulDsF7rols0Q
 LbQxEMG5GT/ffr76l1ob2YlzHrHlIJVdUZMMmueUP5cWlnbu7F/owo12s+AJWIVhqwVh
 zdATocMkRB+8eiQwKU0ainPf/lIIE4L3zh+6sszS8/N8yXpu/sFklEMIL72WobRRsbnX
 +caFKSnB5ben0gmN+Ds54/7AtDaEeQhXgWA9nhrxE3OOebBQcODpYC+O9/7NMOyff3ZE
 8xOFls0PTzeL7AkthiVolOEsSn64DxHbdnb8HefJRm039Kvhi4JSlV3vc3LCpK5yBAx5
 jEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868451; x=1795473251;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J6KiWeVGisFsmwC3wX4yS8VGNysjeBCcxG86fNcWx/U=;
 b=ahepT8XRylCHLPu4/rmCIz/juxZfSzUVm+6Xe6mOYc4xF90boISCjfyuhgtJt788sA
 ONaJRZhtF4AQDxMkx2nAqBa0INnPPM7hN49fWblxMb3XeyD6Fd6J5sylvTviUSy+M/0T
 W84y8LxpYNMR0utsySPyrgkzBHrqlu2cg6FPDd3eKL6NBrsqJlaC3jsIsRvyJBC0T0wa
 OztmDwofv0AR41FP79/SGuoQDDPfRALtD6sJJRkhUdpPBff1ibo6AbdG4S8/ryUFzl3I
 fyuO96CDYth3M3Hj+wSC9XcaLpNdlozpFh2mGGXs4MpozvGTYhm0Uw9Rz726iz/KbMHm
 /pCA==
X-Gm-Message-State: APuU4Z/YCuv4jYsG8qKn2hrXW70zYqSOftGfeaBK8/B5Q/vFn2Xyu2Vk
 sqhhEzYF9s8I8YQ7UOGPYA02xjws7Yp8+FxplnAsFLR/QjRRHFdP3ab6ivcV3838pyo=
X-Gm-Gg: AYBFou3Wm/I+tK4y2QIUC2PFNb7iCDg9Z1tf5fc8lkD6O7b1i2G4ZvgWvVn7goanL0W
 43PUoI5oH22TAQLEukGL2wr8YBJurXbfHJHdDFN5+Gasa1yObBEXFgEaEnw0jH322QeMs72vFaR
 9JMLq+fcfx275pMnv2rUlL0xpdOvbgwDZ/aiMUfi+JevDzMELUodNBtyPvO3oLcwj8u4ycLRNoW
 PXxYECS+fohl1f4pTYG7UC8OEwHF55Eb2aNcdupkb3bY8njQ20SPW0gx6v01fZf+JJ+01Cqk5zf
 3qfMsnjS8lST7LHai7+HnVg1GM70hcVZbowcEipAin8Zr7L3F7Mi4Td19gSO2w1UjAXnJcoDNL7
 O0c5X/vS3UYOB6OyjD/KlLhC+XlmqNXM1G47WrN7iuiMHSdiz8NfcPqSafoYVVhqbgfEdp1izSH
 dCm/FlVWDkDonPygT7/fNJPeNp6BUO+zRSU1hMHGEjEce3MvQEpmxrSRHf4KvQwqTj71JI4yUuA
 8zWRVl5fOG0c8OAy0IROw1yjZ1U63BKlWLti4QygREQ2TSlAXNWYbUh6l+z0UkInQR9BvqIR9YY
 fjfTaCR7pmii0Dl6EwOhAcp7fPw5fSUulQ==
X-Received: by 2002:a05:6808:2392:b0:567:e716:dd53 with SMTP id
 5614622812f47-56e65a52103mr9954738b6e.46.1794868450834; 
 Mon, 16 Nov 2026 14:34:10 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70c58f9bsm10173280b6e.13.2026.11.16.14.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:34:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Nov 2026 16:32:47 -0600
Subject: [PATCH v3 6/8] arm: dts: mediatek: drop the DSI reserved memory on
 Genio 520/720
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mtk-mt8189-tfa-fdt-v3-6-ca423d2d8038@baylibre.com>
References: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
In-Reply-To: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=947; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QGIjWftBHnRR+9HJ6q4nR/RAJjGif3Kdghq1QnvZDCY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq+4S3agAZqbSnLWWggcE3q6EWj9NvMmBr65nYF
 aDsgI0IPsqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavuEtxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJa4H/ijUdsh5z4ZSnaem0d0xaSDvy81SW1WO62YLPDp
 O1CTIT2dGQolvali9jDqg95Ua+UKhymtve4QwkmZWVvbJJJcIzIGSK6h4cgZRP2BgJhyogqDwhM
 MwKO63N1lx3VoCgXZ3lGk3WV2VBzbq2ZI4mvzK77giTzMUztWzyiSi5nn/+AauvnF0XRyyu3pAR
 D73EpJXUIDPy0aFJdza7ki8w2u2ZKkNUYmlVimEY3QUJOiJAl/N5W9LfhtuAIDVPytZ9uYzO0tb
 fabDKUv9Pa4tMwG5nHjb1KkgwvOBNfT1hlpYwdrXjwIncGeoUZPvRHXiqpHyz2vr+Rf0UTj0VQj
 2Kpk=
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the dsi@60000000 reserved-memory node from the Genio 520 and 720
EVK devicetree.

Nothing refers to it, and the display bindings have no memory-region
property for it to be used through. The MT8189 devicetree proposed for
Linux uses 0x60000000 for the audio DMA buffer instead, so passing this
reservation on to the OS would take that memory away from audio.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-common.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
index 0ecd10cf026..5b066906206 100644
--- a/arch/arm/dts/mt8371-genio-common.dtsi
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -170,11 +170,6 @@
 			no-map;
 			reg = <0 0x43200000 0 0x00c00000>;
 		};
-
-		dsi_reserved: dsi@60000000 {
-			reg = <0 0x60000000 0 0x02000000>;
-			no-map;
-		};
 	};
 };
 

-- 
2.53.0

