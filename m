Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09D3CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40B4760A4F;
	Fri,  9 Oct 2026 16:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nKHaIOKdiC5f; Fri,  9 Oct 2026 16:16:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4A464608EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562582;
	b=LLAZDlfM8eOIubglSEiUSGFJDJ4aG2T8LT8z/ubsoVKH6rvBBD/FairKxHM6LXnCTtFB
	 n/Ie9Pq6aylmFnnpG37W7KNjuGHlhgGKp7j9Zus3PTGs0qI8sMrJ09sVT7UgDwbP1w4xQ
	 37kOtSiSJowO0eHc4Bb92tyZdJLNv3laK9cnGMQ4Typs8WPF3VKARI812UbdednK7QWEL
	 +LEvZBFhH0X10xMIqJoaQ37dZZUlCSp+ugFB+4MKFnNKzzTgwzkwOX15T5ts9eo3NNImx
	 4YBB95ZIOuL8FC/baCMWHXuE9219VIY9Knvy8Et/tU7sbx/j5UmbMS7ISgBiNyEYQsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562582;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pw1418+ZZDlCSCxYFbE2fV0I4kTzLuv/vL1GCId9iU0=;
	b=QXcdYYa99SnR6CPlWBDY2ecvZGNEFtb61A+Y02lRkmCwcSFI67MT15qHCeInVVyOzEZa
	 huCEBFKIxGPDJI3ckg1B+3elY/dIzKNXiC/tvZ7eCiQ572tTW2mWa/oRTz4ejumMkzhuv
	 e6SyPDDDta5NkxlLhKgzuR+GD3ZtL2zK7F5OjVBqcJoGgpLoTSKDKZG1PpCS3d8MjZ5Er
	 uCZV9IHR3qZyWmVJOnEB7cda3Rysc2MOCMl3tFZl4dK7cQ28R9vyQhdYK9RPVST2JVlO5
	 CqD2iVEws5fdcs7ll38Lqf6hjQ8QBzKPxxQicNwZ7owRP/Pnjy/PUjV8vKqynZxfpeQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562582;
	bh=pw1418+ZZDlCSCxYFbE2fV0I4kTzLuv/vL1GCId9iU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xIT36YPpExEAruanss3XoaQAEdO2+cDwI5nfeLGUN5frMq6HYGWACXoUpqRcZtK/R
	 eGsKomBsrSm4Zl/CJr0AaX5a3dDtrL4mOyi1ddax0Im2Q+wLNUEDl9mGkY8itO7QMJ
	 FI63wxU/4GXQ+TxIHPyDyL6ec4t08SyOGObpRHg9mZTdFG+AtPZMZuie0JscU3uLt8
	 SmU+0OMhT5QvNeSUskwjHI8CwH70ZsAvdDZQITLxvqq/2GYZpqQnUG21+ljldIcgQP
	 oH7KI3wv9MNzKMTwyHX5szucu9/ZQlvzBOmxXYOZKiRQy8Chh0iQAaXycgOEEZ+beK
	 BOcFMbWD12YVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A464608EC;
	Fri,  9 Oct 2026 16:16:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 358022AA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 278C44094D
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zh3tBEhCyKyl for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:16:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74F1040958
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562571;
 b=juQhNUb0QJlLF084SL2CvI08w7OWLCyG38fmOkza/SS9eaFD1ROMx+X1lOh0HAMmL+iV
 yu6Hb47o3L90C5dQN65r6BKatVwVHZ2op+/Sj3E4pLT0MTlW0YeBxzVjVjdegZ5fMRl0h
 bCDxeMokOiXFtf0LMd79tEH0xe7E/XZkQnN9E/7b3uArluvIV/c7q1Quvvzlej411v6pC
 WxYCGMNq8lI/CEubGQadSTKyX1bPehVskZ0nrrsig6H8VNBHo1gjRSHI6BkelA+KWxAfa
 cttzkxLlEdvw1ttTd5Bl6bdMXZKuxWQZcht7upPyq1V0a1i6hNQdZrjxrJcOfhlAS2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562571;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=pw1418+ZZDlCSCxYFbE2fV0I4kTzLuv/vL1GCId9iU0=;
 b=YFHHNmwdjoyoylYSv2MGtltxJpOIHgLx0MqUA5Ij0kZVQqEsaOjQvaIqRmS63U08yZi6
 blQdi/Eq1EOuhTUjss0EqLlqCSeIqCoodhjDdknFGbW+sovPqPubjWzI9NygmdmxuloUI
 hthwT8OcniHVgVDNlxnKPN54IjM2/ifnnfFPbtoqxmkexKYMaG7f8vWxg33u+h4sL9ct7
 hvDROSDu9rU6P/bjvYkyOYc431LCHectI4SGhMU9+XB1AH6XWFUKW1AGgYul+APs3jUjo
 semI3ID9L2rtPw4TR9THgJxjy9woFoRZyQFLrdOcqoOtSQJHaXr2Y+yKZ6cBm9fp9bA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mBo6OfdJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mBo6OfdJ
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74F1040958
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:11 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-8258ac98bc2so5162935a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562570; x=1792167370;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pw1418+ZZDlCSCxYFbE2fV0I4kTzLuv/vL1GCId9iU0=;
 b=mBo6OfdJdLV5zYFtn0OvCxISNE4hnp6DFLvOsYOq/9afMiXM28WqFQ3ADSq/BZFNCe
 SwdmObyy8UdJ1tMsR5O6IjZ84t+jQNG00PI6YtpNsU8cBBUt2mgajq4MyxKf0pBROQa0
 zHhnt/zTqRUtQtusr51GFxYKUvsX/kkyWDPem8sNRciDgzqCdRFR98XRN9IcBF9fkMXV
 UqaAZxr5SB8ReP9Gq3bsyx/vA1bHqYDjtoEm15WwHL5/fnNsp6ib7+pSuZMDFs7yCLPY
 t/LjHcmBLyDyhUU9unRZA8DwqFD1xtKHZ0fy+q7gGILgxDTUQuUONtJwqyXBta9NEnde
 WWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562570; x=1792167370;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pw1418+ZZDlCSCxYFbE2fV0I4kTzLuv/vL1GCId9iU0=;
 b=QVCS3dSbPAkg6bRGLbugj/qL1EGYmT6kPWU24MJYynX/FOm25551aIWwR2qASR45Xy
 H52o4peP9rrSnqjIPqE+gQzum97029h0dEhltEvLDNLtmIlsqbd4akxrwOp/3UWztv7Y
 jthc3JgzfB2WpD3IVa/JQ664juFZbhn5uRfccYBordbTnKcR2kzgZYAM5EEFGP4+sAYC
 dcdESw+6k9NkUHX3jrkqhqUrcdV0Al4T17iPGRJR5Y0CMWWbhdIt/j49T/mT3QsA2y/L
 jRrZEfkm2F4cT+aCDUFK3WFA8pPVZWCvrn1ygCbuWn1x6jm85VE5MXnsTY6FahXjJgwm
 KW4g==
X-Gm-Message-State: AFuF++lXkGNEeO+CimhZe1zQaswSu87yJpWrCgl4V6PD+aMbjCRVikT7
 h1A8Wy0ZgIntrdJlXsb4l8v+IZe4Q8hUpabIT/a0Qst2NQlm1pxB28nndzZf0oYlW/Y=
X-Gm-Gg: AYBFou31JUwOmOkD/Dw1OAJp69QOL3upbXhjEOJNtzMSkpNgWwtlnhW4N5t/5IMA8an
 MWFcX46p+H1aG/7c7ci8zOt/yKqBVQZ63LxGYozuGRh6xMYfW9bVh8w49ChKKLMmazaTYMMl8cR
 4fu7NS5/vJbR1VHTRFgVCbeNn+CIazOf3dw97WohHeCnekgufi/L5fltI294VV5STd9RYlMoS3r
 z0wBveDLARQnKcI3NSWV4jQilRwSfULtZ0GHbP10zk0kFs/dXOV70XkEdCL3FFCZH+IH63s4K5b
 KlZjsdh3FdyXUKs44AwG/JNFXllVdGo7gdZ4yYkXm8aopsj2tDOOytz5Kz4Orwt1X7qRQ20ZfUR
 0SY0vyt4aRHAW9mcP8fXBnZZxCbpVb9hyokpoLsykNMh+j+5A9J02ee8kqifKGVaYVDa8pTU3eb
 vLFgBksRfasUwftYspLTDyNjoqYg36rInNGPgMUm3HFXmSNxngSWbr4iJ1TpZVIHECQVE5z6jM6
 VU=
X-Received: by 2002:a05:6808:2511:b0:4e9:69e9:59c3 with SMTP id
 5614622812f47-50c5c6c2bbemr2098912b6e.67.1791562570128; 
 Fri, 09 Oct 2026 09:16:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:16:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 11:14:16 -0500
Subject: [PATCH 13/13] configs: mt8189: enable the eDP display path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mtk-genio-720-edp-v1-13-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
In-Reply-To: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=651; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=GRYgcjjWK/xIvYxKmz7exLIjE7X/+coZuAUGS0oc33I=; 
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLJOCmsKL5Pd8jCIKSz7UsbiSwvcVR6narQV+E7mUFosZ
 aimqivTyejFwsDIxWAipsjyRuLmvCS+5mtzbmTMgBnEygQyRUwmJSc1OSMvtcghKbEyJzOpKFUv
 OT+XgYtTAKbw3mwOhnZpkfTFkmY6QXNuedZlOdpuKe2IO1dvPOm5RQ+Xyi0TngLzgqBDNn97mZk
 136fOU5Pa+vX+5P6w0PxU1boJd0waomWM3h5kuHzXvqinbeOKGTXya/dOWFrkolH8Jy/A28SAIe
 boRL/2tObuV4dN/Vj+XPx3wXC2uFDSQuG9kge/ZceJ8M542Ll9ycp1v+f2MDfkLAkQ2dfslRy4Y
 V8h85Mjs/yt2g4smiqh1CI8TXbf7XR3bpfgIzYff7O7Tc92YcrO/K0a9zRQ8nnWRZnNHllFTUw9
 eqKH83LUz3kWeOkdmxkXaOTVsOCgdMc7/huz/PkaWtxjvN5HqlbamYpYGbesm/1VLXpN4szJxwA =
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

Build the eDP driver for MT8189 boards, so that the eDP variants of the
Genio 520 and 720 EVK device trees have a driver to bind to.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index 8995772f41b..b5eac181d9c 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -48,6 +48,7 @@ CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_MEDIATEK_DSI=y
+CONFIG_VIDEO_MEDIATEK_EDP=y
 CONFIG_PANEL_STARTEK_KD070FHFID078=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_MTK_DISP=y

-- 
2.53.0

