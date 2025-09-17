Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC13CAC5A0
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B77D83804;
	Wed, 17 Sep 2025 18:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="YLKpEbmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C75480C93; Wed, 17 Sep 2025 14:47:59 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2397D8359F
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b0473327e70so522780866b.3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 05:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758113276; x=1758718076; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zZU+JYDP7GjXQVjF0he4lodJ+Nwpxri1NhNEQD8EK34=;
 b=YLKpEbmvbcUz1FAChMiuROizbakGh4WPIedp8ZRWL3j6L9a1eqqNV/XRNh3lce9tA6
 rT7iNZdo9WG/h3fcCE0pGgNVKNOXrQ6yl406SPhCEVRHijX/csmS/pBfA8k23zHgnB66
 btBcVs3ehJd2NchpXIZT6uuCf061j4b6HsXM6xCGR8koqedi4AAYIUP3CAASOEkNuLSP
 IwgGEK/GazAFKHGUR7iqLrocQNQ1djS/OWrm1k7L3CNZBO5/JflbNNLDhSoxUsxsZrGW
 Ck00ir86Hth03mH9b63NSlc5EntuanDleXZAnRhngvCgxYakY3XJJhyLIqjnAxn9bTs5
 CM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758113276; x=1758718076;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZU+JYDP7GjXQVjF0he4lodJ+Nwpxri1NhNEQD8EK34=;
 b=derdm0XB9R0UHMRISlREj4ZWg0MWcM1CT+wONiJCOun42+RY6JPy0LJpKTYhn/z+rB
 U+35hegxsMYatbwXFSg87uBiJZEnxOsKJdsQkhilQ9kozFKhdffuRRb7yUIk+2q64GcZ
 yDKKhKqMmSAyuMr/yOw/L16Hig/VQZ34zlYdUR1qNDZMge3EjMGCUpta6T2VhtOGFs6r
 1ZuKEb2bAce5rqMJWswPZkqeMgncPbWcz06/U7RMwaWKcFZBuRhzXa5i/kdA2NLIfH6Z
 0biQteKS2O1vuatc77BTtmGSX5D3XexSCJC3WyLxxDPE/FMEa3+Ckze6w+S4rG7cnkv6
 CaQQ==
X-Gm-Message-State: AOJu0YxKtsSW9XVWYcvI7itMmH5lFdE4yNv5DKYZa0p4hDtX8tGHrrjH
 wapSm2DdHZtD+mhfF9EqFVVyRgYVmGailly/mjnriGU6YsK+6f9GavX69c93nbr/Zhs=
X-Gm-Gg: ASbGncuoUk6pT4mp5PRX9MdQ/RoqY+nibUMJ4by81p0jJFEluY/8MWzK624qKvBs+3g
 DepfRDWdK0aKB69lgkKqBd7A3kf0lADdJ1XIT37vVsIhbpQCgJ7EE/g//XVAa7KAto53lnCo9ZU
 Rh8hQW88igNCb66k3UFP2Tj8ee/nqgstnR2iJh+bi4o1DztZqP6c1E+FpLhIG0ywfqlefyHQHWX
 C6XEgAJoiNOzCNBXp8Y6TYe6KRcgPtiBUaHbsOSB8RxOQneYemF9784Z578LpmB066uoGU8HnCx
 Bx41GnYC2nHoibdreW3pLu+vjIg6n5ItnNqbcld6a4z8zig3AcHirIN+5vh+JjKY0qxty2ipYuM
 0yYOqVLaYGzj8u+LoBNQhlcbNfuMRvlMei7y9b20U6/PMMxjPKplmzmNEtYAz+N3TBLCEIw==
X-Google-Smtp-Source: AGHT+IG3gpejeioLT8VxUDDvOZyeTbLnkkd7IMZ9q35tf2smCuCXTr7BmXlUrTHq2IKzwJx1L9TYFQ==
X-Received: by 2002:a17:907:d19:b0:b04:6412:95ec with SMTP id
 a640c23a62f3a-b1bb17c8c16mr238205366b.10.1758113276485; 
 Wed, 17 Sep 2025 05:47:56 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b08cab32303sm937441866b.72.2025.09.17.05.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:47:55 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 17 Sep 2025 14:47:41 +0200
Subject: [PATCH v2 8/9] qcom_defconfig: Enable SM6350 clock and pinctrl drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sm6350-bringup-v2-8-13346fc2a2f6@fairphone.com>
References: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
In-Reply-To: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113268; l=996;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ByrumRdNfNiHkKLSwrnKks9XU2lYfXUvadwHQ1iShL8=;
 b=mutrQUb8ZnHa0Q40rmp2ahZVUplRk3Mi2iRPDZLvTFcj8l1ULxg+Skp+7eO95Ly2SJG/EC8D3
 GBFSH4cY4C0A+Uiaw0RA8ksBm5bxWuVPX5IMDiqDv8OQIqKChGI8ijO
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 17 Sep 2025 18:22:41 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Enable the drivers so that SM6350 devices can boot with qcom_defconfig.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 86d7de89e7746e33f4385ca78c839b43319cd861..e8e6e93ab4b17a0b69160d2113c5c0b5935da544 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -60,6 +60,7 @@ CONFIG_CLK_QCOM_QCS8300=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
+CONFIG_CLK_QCOM_SM6350=y
 CONFIG_CLK_QCOM_SM8150=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
@@ -112,6 +113,7 @@ CONFIG_PINCTRL_QCOM_SA8775P=y
 CONFIG_PINCTRL_QCOM_SC7280=y
 CONFIG_PINCTRL_QCOM_SDM845=y
 CONFIG_PINCTRL_QCOM_SM6115=y
+CONFIG_PINCTRL_QCOM_SM6350=y
 CONFIG_PINCTRL_QCOM_SM8150=y
 CONFIG_PINCTRL_QCOM_SM8250=y
 CONFIG_PINCTRL_QCOM_SM8550=y

-- 
2.51.0

