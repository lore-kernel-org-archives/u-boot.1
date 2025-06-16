Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E4DC71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D181482CF4;
	Mon, 16 Jun 2025 11:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lc6tCVYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7862382CF4; Mon, 16 Jun 2025 11:45:01 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F3ED81760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so36869265e9.1
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750067099; x=1750671899; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0tI552L7mTgYqZusNS13qrXDJ+hqulytFmlIfsAlfnQ=;
 b=Lc6tCVYPttN5epTKkC01JFk4NQ/iLVq954P2oJzckxjExyZuFxidddSxgfSL3AwS0m
 WujewIG2Yh47Q2GCoGFUMhOPlm/nDFjYBFYZDuPqZXm/WXNyGvb+p00UinFOG4s7e1Pi
 NOEgMlQbZcg+YyRrgHMwJock8cPANFtD9DWJIsg8t1LfZBhDR9nPfFuIyZMjT6RB87P1
 XBDGi3+GhaSQYrtBFdQWxH9/Eiu5G8XSnCy+9h6tZo0bbqBgoX9/AJgql4paqH4DdCAC
 U7risagy2rnfM/DTi7wdlSmO8Bbafn+1HyY73tWd0ddrIJWx8RnPKDO9ZgztFMB1u2xr
 6GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750067099; x=1750671899;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0tI552L7mTgYqZusNS13qrXDJ+hqulytFmlIfsAlfnQ=;
 b=kdEJiD/akzGDt9Psq8g4AHxMKH3ZLnpiM4qDtbgKuOHqwe2vVfWRr1q53G1wXcRAYr
 j8K9FzUCguuSW+8fjrGApGdBBK/aQoTCWYc/mbR0j9gHLx5FUdGrIc0NHsP3F7HcRQpw
 7xQ1vkGRWG1xyvxPx/2I+1iTo+AkVhXV18vXn76pzZGy2cMxvVyfAq+Reg+U6kdO2dv2
 qSsEDr/WKBpt3EwV7BrI4gLbpndj/z+1Fis96RZMJvBa8wgfeFkRNYHuB6AEVNfOaPvd
 4HL9V7VntEcC08FOTvpPhUDntLJ4C8B+MhdCVigjaNr3lqi/Qv8KbbxKfsuI6aslzxR+
 fFCQ==
X-Gm-Message-State: AOJu0Yz+ljszq3YJ1dmDrgIhqfS+NKU3M8yFbOono9yQp/AEjBdpW/z7
 Y6Zyn/sXyXJwh4pOkJCER8frmTbWYXStO+1w3tN+maBcvo/GkT+lyui3L+rRy/HbfL8=
X-Gm-Gg: ASbGnctHpe6CH2a8BE5MvYkWqfMbXFdmwoS5L9DWVLQOJQ+ce3FVRC/lhvcz9IlUijd
 Afz0vycCCU8qkuS+nRWshDGfXcI6ABYBGJfXje39OVlNFfcFZ74cY3TQ/0xHDsMahISYPOxIKr5
 HGLhMNpSA4n0EZVkaM3zf+C6/N8UevmlZZfNd+vbpDEwhqGTY9W7DdR3G7XZnnbS3o+srm8jjN4
 JahZTuPap5wkH2PbXPKkzZ1yyVwb6viKtRkG7Q87YdPvpS+lOt9EjO+QQ8lFH+W3XduvQLFWFl2
 oI1oLfxyNhY+4X08LTwB6ZBo3Bp9RFyxO6ZTQ+QevMHgpy1YaTtk57enGxbEAYXS6zJ+894P1K2
 Y7tLy
X-Google-Smtp-Source: AGHT+IGDKa2WR90e6Qv0RtAub2mOZpemSHjbqdUdHSN86BwwLQDYacBz2INdgsBJLEoR12twWP9xNw==
X-Received: by 2002:a05:6000:220e:b0:3a4:d53d:be22 with SMTP id
 ffacd0b85a97d-3a572e5db88mr7121468f8f.58.1750067098909; 
 Mon, 16 Jun 2025 02:44:58 -0700 (PDT)
Received: from toyger.localdomain ([213.240.182.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c229sm139308105e9.6.2025.06.16.02.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 02:44:58 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 16 Jun 2025 11:44:49 +0200
Subject: [PATCH v4 7/9] WIP: rb3gen2: describe micro-usb port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-geni-load-fw-v4-7-e7df44205505@linaro.org>
References: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
In-Reply-To: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=927;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=k7EXl3DttnXz4DwnLA8b+LxdvZp3ZvqTTkzsnsuBe4s=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoT+eOQJB/AeS1+SnIo92BgBYuDmiVsY9zpnDDN
 eI402kuOYeJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaE/njgAKCRAFgzErGV9k
 th+2D/sFeAM4Nz2Mj9CyhKgrG98RR1Vu6Si7DWeOe3J9uApRKb+MXCXOsYTxCfaZxbnZxIxc1CD
 4bBFJCrVTpOfxTZisrtKXsmBshMClPCsCenX5Ku6/T0qJ19/j60HNx5yd/LQKSUrPUQWu09ip3e
 d/y9LqXyG02ywTndpCljFw6lnJFz8F5te2XUxaHI8f18rBERUKOd7vtO/Ty11mOz3Edc0YYCcXB
 WcuiCUQCLMt3dM1tsW3ZD/lsoqM6mOJLZYpGKcgbhVzolJCKbVKHlqFIKDw17JGOKKGT4KeFiFn
 Ga+QmzO5Ei2UbZXxLNalPT4HcWF/vOYfP0vZMa6STyCVReeR+ar7Caqd91WaBbWNZbUmlrltaUs
 TbZ5JfGDg7ur6XFtBMlvPm66ATgG4PhSzbMTIkjShGX6xNdT9qKdTTr6dXmT2VqqfbUtdLW82Gi
 GPVhy0avMwM4jGWIoYUtc3lxejKOeoXs0a8t2Hi3UCC1MflpWu4aB1hf62m6050TtFRj4v7VkDP
 LtGysbSNfG75a40lTAypx26t07/jjEa9SJzdBeTQ7ztXFwDqtK164rySBsXMPEQa8GjwjB0AY6W
 v/EBC9wzFVd2Em/tjpixMRwh+B2v93jiZMCC3e6Iov1CZWQ5JTpQnGbEoJegDZ7bb5IvfiU399N
 /t+pzgCR7JAOl6Q==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts b/dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts
index 7a36c90ad4ec8b52f30b22b1621404857d6ef336..a9689f126cc7f94a01921fe2dc70efb83774610a 100644
--- a/dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts
+++ b/dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts
@@ -881,8 +881,25 @@
 
 	status = "okay";
 };
 
+&usb_2 {
+	status = "okay";
+};
+
+&usb_2_dwc3 {
+	dr_mode = "peripheral";
+	/delete-property/ usb-role-switch;
+};
+
+&usb_2_hsphy {
+	vdda-pll-supply = <&vreg_l10c_0p88>;
+	vdda18-supply = <&vreg_l1c_1p8>;
+	vdda33-supply = <&vreg_l2b_3p072>;
+
+	status = "okay";
+};
+
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&redriver_phy_con_ss>;
 };
 

-- 
2.49.0

