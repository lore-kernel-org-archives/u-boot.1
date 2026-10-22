Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62D606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JhWFJG/X;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gqyEOREj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08ECC81271;
	Thu, 22 Oct 2026 19:02:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MuaGt_HC8Pdt; Thu, 22 Oct 2026 19:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B8AE181285
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695770;
	b=OBfRCG16o/3A5YyCXEkjifw/7zNox4XwzlrAlBkeQaTaK4zqs2eURkReJjJl7TtrIhgd
	 sonaq9PXZUg0bP5j18e2hTRggJBRE7RTSY6ByZ88+e4SWyawsw9DifGj+dCZ+S6QWmrcC
	 VdysVavi6plYsPLEwey1psc9lNwt6LigJ4C4xeHx1mOlQbea/S3bRZjik63zHTph+e1eN
	 qwlSNEgThRoi80lipIucLdZq74spGR2OlK0lO+PUPRXe9y+K0FvXpN0mOSTAfsrCRsjKQ
	 oJJyXO0WdUV4qsOoeJ/L5Wb4vLF5+J/pY9BM7N56pGw5a3/VmDjnQ0yMlrGUuNz3G7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GL8yhPLOF0nBS2S5ahjvqsAicmZWaVobkeKetTfCAbg=;
	b=K24/V6acGtRzj9YuG52sUhZnHR8cUpr7RQWENUSINAQi3gLh49NVMsUazSiva4NMtUAS
	 cPEVa0HBwsmWq2mDBwY8ajERTz/rhNudnA7q7EuOE9eNztJczy2wNRB7d0XggdpuJ5rS+
	 yhoKMOtbdVXwond8Ly3byBZg0bHM7SikYAnj+7zZQqbpHmgYX9ulULKx6PJC0JlxdTQ4U
	 UNS57+zaqB2aPj2BypGx1a+GtwdGYpvvyd4WDNc6D4bQlfqc/lna9TVDgsgKILSvNH28g
	 iy8Ba98OyTpxYTKxA/smIfye7iXhIVa6TkFvWiA8RGS7Q7/RLIl4peP1gTxLcPALV6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695770;
	bh=GL8yhPLOF0nBS2S5ahjvqsAicmZWaVobkeKetTfCAbg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JhWFJG/X/w65J3NjM+riuB74HL1vNP5JyjM1FBxIKyNxyntNtKRugDCgMUfEDj0u2
	 yhuKyvXzcL/fxeMPfv7EIXoYgboPRNNkKcUT5/s4NGAJ+TasgubBkpskj5kMX9lQHl
	 WJEiKRc6grz88V6emfEJmWnlvnrOkxRMLoZKoHWtnaX7W27URegGyoqbqFyB1+5KnY
	 ZB/xk26MjVH+c62tVv/KY6o1a1Xx3Q+SyWJABGGuRTannVKxS0Qtm1pCJNaM2TfASF
	 bgtps1FAb7rwfb01tdE7DqqPKd02SUZqvTeGzCi0tPyFeC5lymUDDV9E9zsqeF4i+7
	 AhMkGzQT3NHXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8AE181285;
	Thu, 22 Oct 2026 19:02:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 159A691C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0420E60818
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wMCqPg9GRXQZ for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18AFA607E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695763;
 b=ZYIwHhweI5djt2Zwz9whyF1AhbtcAV+OvhWzu6JuoLVmIM4RhSXWUXntoMsIzDSZ5pSq
 /UK8aQN1bCw1/uSFrXhOkq/nTjkrA1ZTJJr2aS2OgzAdkHeKx/sqRpWIipHVpBPFJPs9P
 xqjhKJ4IwAx7cgI5c8djeTrIkt3AiP4m5uWBxT/12WLu8+dNL2vSiF7Au+qkNqDRGmTH/
 OJLg0usre8WlYNeSKUOP9pbbaIxcfDr5+lWW7nLcEFBh2u/CWEuZOOqQ2cqpWEm+DXwVT
 gzoojR5U7zRDJYJ00xWkCUkpnFDMs9Vkf3Sy6bCjFaehdraQ7zmgwm5IW7+/Add4mpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695763;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=GL8yhPLOF0nBS2S5ahjvqsAicmZWaVobkeKetTfCAbg=;
 b=gWO/J2aS72ryZ723sV9AAdjG3pO5euFMyB9XU6SWIRLejE90AzSh0wxhPZdyhimtM6X3
 Kq2Fyq2Oe5HMr+dgMpb0Ox5GuuTC4P7XsMq7ug1NrcgiRTUWnFtxPRlsjzSP7EsZOWP39
 hN0c2AUa7TAEeM1vtyTuf3f6QTcPVjXPieQB6eKlUOC699AL1bSS1dOZeqS+HQ/lQUANI
 4vFlOTK2HGOSvFS1e5zrQlsLA9yrZnsMqd7Mb8mg1hoYQW9ogeZr3Q/+LhWIBMlQZtswc
 bvHOHfQTNTvvNNi1IcxsGI4ZOlVwuUIzlx9x/eoMhodELVe1Vt7vjGaPuuxkB8dyPug==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gqyEOREj; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gqyEOREj
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18AFA607E4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:42 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so1591235e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695760; x=1793300560;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GL8yhPLOF0nBS2S5ahjvqsAicmZWaVobkeKetTfCAbg=;
 b=gqyEOREj5L5DwQ5WFmE3wv7Y7XjzlGaFANLe88D3Rlj6jEnX3jXmM4qB4xHVd8A9Iy
 fOPSs1uSXF+sqBwJC8TjlOHgDPT9yFrI1J/YJ5L4jezcZ7k5xM0Q9wSbnzdr04HgFe49
 JcmEgMDresqsWDJXUo3ayP/sVXz12FRobRwCNkMMvOq1gioOvGFyL4C2wiB0KasAnF+F
 17W35mDUklUg5RJd5yRtGYKw42zYNiZ+FOJte3Z59hv6Bu8Zg3wTcEJMy0kC7g5c/wxw
 3hymNJoqDjFhglk/w7He6PRg980xLvDCELSzS6h3mtwch92ZtcTp7FR4ozJ2pw/QokaD
 s/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695760; x=1793300560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GL8yhPLOF0nBS2S5ahjvqsAicmZWaVobkeKetTfCAbg=;
 b=OiWyeYnWkJKDG42IoWpd8UG8wLnrshep/HnWfQVQlLVsDi0nD+NlWwLxZmPtFXaXDZ
 jjcV7EQjPF6mOjPadHI0lAgJ88/fg4aBuZVG/lXRtwzxZgAiDWkjLabZSnM5+KRVjUfo
 MCNZQrL+GIl78+Iv0+BiswVHBHe8K5YV4GwcRSY4z1wpdsEHXtA1BqR2h6qVoTSx56BE
 pXpjPqUNCL6UE5fjFn0l92ja/E1BzhaKS+Cfd/xnkE7T4zEo4/8dvCjajifeGKaBCU/i
 cHrQd4OO5fgZmItmLlV3L81CzJAxCnfDvPFxQzObj74JuvuqJGX4ZLh2SFO9FAO+lOwa
 mhkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzc5cNl/tAlCayRRvKYOOgmNuyul7BXGDBSU5KB4MHpC5p0bUgSPsWMPIH8RRc++zT/28rI3Z0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJsb3LwUwTh8qMo8qcjMQQ6wxjyme59NLzoLXlIqJrXwjBrgYWM
 5wOzQcW2K5ia6zkx4cVeCzATAoqipj8yJrz4HIqBDGa+sqemt3HKdL9W
X-Gm-Gg: AYBFou2mQetd1Q5lPwDvDE/MOwNOxIoKiS28u1xmJjUY3Vf+V+cONd12fo6T21z4UbU
 eRwFTW5fOz8AK4Ur4n/4rz3S30lgZORjk8g1ztY8i4XDDdekfbxHn9TXOEOimPeSaRQlCHSa6RU
 Qs3YdFi+KLEBYzXDbBqf7v5Cq794sKc6n17IvLJWocJupjltRZB60/AkO1taTnDbm44tkgI9oZN
 uKGlH6+Ou+Z9W2l2C1te7VQnpAPJ0YYjdxbbz18DEast3GzFd2OZYbgDxqKCXFPyZKCC8kdIUCX
 6hObvkDGmgRzq1jemkIV53L7ZURU0Kv7KfkFy2jJCQghRj/Obw5GT6tTPHLEGPCr92CMLS2urSQ
 svCUsfS9lCnmPFnJP8rrjlGT43Q4VefhpprZzURWV+iwV/fg1HkMUFEAv6E1kKcOVVNFPPd87xO
 zYgoCLzY2nlQx+Qy4NCwqSkJVw8/SI8ZdZ5Pf5acc4w3sff/ENQRRlcHWneP9gQZPFeajPKMALf
 x1of0fjZQvfouBCv7aKSqM0BQld+vWjOQs84xyyXnz2yel4pKEoaREAzSnDLzAabXBuXVAVpTO/
 euYGnqvKkMZ/a3O8JSHzx5dta6m8TA8ojERHeS6TevJpArHa/OVeXlpVIExXtw==
X-Received: by 2002:a05:600c:1d21:b0:4a1:cef3:fb3a with SMTP id
 5b1f17b1804b1-4a1fdb1d85amr129483035e9.9.1792695760249; 
 Thu, 22 Oct 2026 12:02:40 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 08/16] ARM: dts: an7583: add Ethernet node
Date: Thu, 22 Oct 2026 21:01:50 +0200
Message-ID: <20261022190206.666950-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add Ethernet node in AN7583 dtsi to add support for the integrated
Ethernet Controller.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7583.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
index dd7bf49dbbc3..629f0e64de6d 100644
--- a/arch/arm/dts/an7583.dtsi
+++ b/arch/arm/dts/an7583.dtsi
@@ -131,6 +131,29 @@
 			reg = <0x0 0x1fa20000 0x0 0x388>;
 		};
 
+		eth: ethernet@1fb50000 {
+			compatible = "airoha,an7583-eth";
+			reg = <0 0x1fb50000 0 0x2600>,
+				<0 0x1fb54000 0 0x2000>,
+				<0 0x1fb56000 0 0x2000>;
+			reg-names = "fe", "qdma0", "qdma1";
+
+			resets = <&scuclk AN7583_FE_RST>,
+				 <&scuclk AN7583_FE_PDMA_RST>,
+				 <&scuclk AN7583_FE_QDMA_RST>,
+				 <&scuclk AN7583_DUAL_HSI0_MAC_RST>,
+				 <&scuclk AN7583_DUAL_HSI1_MAC_RST>,
+				 <&scuclk AN7583_XFP_MAC_RST>;
+			reset-names = "fe", "pdma", "qdma",
+				      "hsi0-mac", "hsi1-mac",
+				      "xfp-mac";
+		};
+
+		switch: switch@1fb58000 {
+			compatible = "airoha,an7583-switch";
+			reg = <0 0x1fb58000 0 0x8000>;
+		};
+
 		syscon@1fbe3400 {
 			compatible = "airoha,en7581-pbus-csr", "syscon";
 			reg = <0x0 0x1fbe3400 0x0 0xff>;
-- 
2.55.0

