Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CB0ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5367488FDA;
	Tue, 10 Sep 2024 11:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G+f+LgOR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B775888F7E; Tue, 10 Sep 2024 11:50:26 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB41388FD0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374c84dcc90so3107735f8f.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725961816; x=1726566616; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8/g8TDwEK3sGn/SlztZA9xPRWKorc7MdJTE5X0JAEMk=;
 b=G+f+LgORPYIPztwuIyX05ohKhyEuPYX5CTAsjC9PRWmpudwXdb0OvexD7q36f73Q7K
 phRBlWFrSqEz2y7Sdshvhbdh8R31zyYGdHfh2aJEfikwo38O0S4vdKIcP8huBwHPLQPL
 DEhx2MRVtnIa1HRXaTabHJ21P9JbfGjHVvnIOW09IpOEZDRBPbS+RYDWLlUmWCEcKOTx
 NjSslZ2lBSg1j7DaNtLnTY7od2FDxgvbPCUEYnti+Yy+ryEExiD8JiiTR6wjhk8+ZNXn
 G96F8OQn0YF06JNrB3FLHL1gvk26t6GeGsWZNvx+Enr9tzgBYjvs9S5FTJD+Q7+vI32w
 jUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725961816; x=1726566616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/g8TDwEK3sGn/SlztZA9xPRWKorc7MdJTE5X0JAEMk=;
 b=hSMsFhn4KkkHqW/ikU+Nd60VGOXZmt7aD/+NFbM8BLIcpW8Gs92n9ZruFOxvKG/lCw
 OZcXkIQ8nGIm2xyHZO+cQi1IU9mzYWsOJgVe5WuGfUiaw7iqpo9u9IBtHPqEWUSuWOH9
 Q/4teJ5ioahAlYn5vJqw1Lr6A41wx9F3unAnVVguCWZWWuxugyLDrXf6AbkshUSp2v3p
 XzyH8mFtqiP1cN1TFe4XyBLjcVELlLESktD/MPiSFLn76mnZqy+mR94uOLB0j2y033dy
 rYN/isDM7nFv5Hc7oArS6TlOz+8pDWYXuv59ZeZAqknmn1yHD/kDFVJGQaFIhbQCwi1P
 Aiqg==
X-Gm-Message-State: AOJu0Yz/X0OMmOdB+ztTa/TvsjPJvcrMLwMiLJExbUcyvaSPQaR3gHIp
 rDCsBkEX48hvG94mcy732hbmakPxnaQ1eb54sq5euZYGAoSGDPGC9MNnQx8G790=
X-Google-Smtp-Source: AGHT+IG8y5B2sXABCZQ90Nx8S11inzm2YsqZpGV7p1Xn77LYzXcFKsL2UPoPF+0mdzab6j38cT3xAQ==
X-Received: by 2002:a5d:4d42:0:b0:371:9121:5642 with SMTP id
 ffacd0b85a97d-37889609f2cmr9457842f8f.30.1725961815534; 
 Tue, 10 Sep 2024 02:50:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d3738sm8364030f8f.69.2024.09.10.02.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:50:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 10 Sep 2024 11:50:11 +0200
Subject: [PATCH 2/4] ufs: add get_max_pwr_mode callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-qcom-controller-v1-2-54c0d2231b10@linaro.org>
References: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
In-Reply-To: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1803;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=WmVaY0NkNjcuMhUYGDUhjiq00C84ZtVgQk182nddMCE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4BZTkfm1M7kGDMOQoJN3jePWUh2v+XCix3ZAqv0A
 TpMgJ9aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAWUwAKCRB33NvayMhJ0Q58EA
 DK8N2rljQKagEvDR8k4nvWZ492FofzwK5CMNQHYUc0C2iPfOu5NIl+s/KJQeOSA2DqZb5k3/+aMQ4p
 sVb3mKHHNIHpZKfjpm45XsUQS8rObRwtu5Jdc4G83vfhFSuKWvC4/2zMRavtELiA1Utd7d4uXWXdWE
 jeZQWAgG0yNeQCKpCuBJlykCpQemTkg0zWQT3kqNP5BCbg2QHM2oe3ljgvL4q7JlCXFaKMfNT+A6by
 iua0lMf1vStSWx/M26ZRVRrEv/6pH1jJNPYwCPJwOJGxErMbP+5pe54/n8NgcHjfUvMmVYwy8RS6oE
 0+BYW544iF29xya7YfPPF5f2LRtWGyRCKCj2ZB3SfEhrV+ocGKcGKy1M7+7bVGKoLDHJ3zQHDj7Gre
 TJLSuApvVi1DikdUGp0sw+kc9Zcf6YZdc3UtBR7ESI4tsar5ifwFZegY5aVVPMs35kuI7CdxMuj072
 HJ3TLVmPAZ/waWu2NDp4J1OKvTmrP3Z41czBk8BSiA65voDZpFxwb7KF/ORZrWzkkGS35SLlAm1ilM
 b/TnOmBgOvspjKpOgFaJ9F23zSlfVH7J982tVYE0RzZ1p0UaPhweRRR3qECI8FoDfilFy5sNXq8YiR
 Vzq8ZTMiGCi4cWfdWR/W3TI41Hz7gqvSpv8uk39e+l36UBGpNGmALF9ShZYA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add a new get_max_pwr_mode callback to permit the UFS controller
driver manipulate the max_pwr_mode struct right before setting
the new pwr_mode to the UFS device.

It can be used to limit the HS Gear with errata and hardware
limitations on some UFS controllers.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c |  2 +-
 drivers/ufs/ufs.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index de8ba011d57..1edd31677b2 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1744,7 +1744,7 @@ static int ufshcd_get_max_pwr_mode(struct ufs_hba *hba)
 	}
 
 	hba->max_pwr_info.is_valid = true;
-	return 0;
+	return ufshcd_ops_get_max_pwr_mode(hba, &hba->max_pwr_info);
 }
 
 static int ufshcd_change_power_mode(struct ufs_hba *hba,
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index faaebf1f9f7..fb47d0cd3a4 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -696,6 +696,8 @@ struct ufs_dev_cmd {
 
 struct ufs_hba_ops {
 	int (*init)(struct ufs_hba *hba);
+	int (*get_max_pwr_mode)(struct ufs_hba *hba,
+				struct ufs_pwr_mode_info *max_pwr_info);
 	int (*hce_enable_notify)(struct ufs_hba *hba,
 				 enum ufs_notify_change_status);
 	int (*link_startup_notify)(struct ufs_hba *hba,
@@ -861,6 +863,15 @@ static inline int ufshcd_ops_init(struct ufs_hba *hba)
 	return 0;
 }
 
+static inline int ufshcd_ops_get_max_pwr_mode(struct ufs_hba *hba,
+					      struct ufs_pwr_mode_info *max_pwr_info)
+{
+	if (hba->ops && hba->ops->get_max_pwr_mode)
+		return hba->ops->get_max_pwr_mode(hba, max_pwr_info);
+
+	return 0;
+}
+
 static inline int ufshcd_ops_hce_enable_notify(struct ufs_hba *hba,
 						bool status)
 {

-- 
2.34.1

