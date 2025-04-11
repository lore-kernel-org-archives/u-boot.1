Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E17EC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65551841B9;
	Fri, 11 Apr 2025 17:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mAVgtpci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB6D484003; Fri, 11 Apr 2025 17:31:02 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04AB78419C
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so14558835e9.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744385459; x=1744990259; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMgY9ksSmExFbWzvay4LioQwsmmTDVnEOWiIAKfLOIM=;
 b=mAVgtpcifJQo8VIbVXhnPk4e1Upm2dmX3etyvEJ7VrD2CUD+yUbbkLjXIol8jjI+pM
 JKcIsCjRnSZIBs8LwYsnyFnw/cG7itqDthHdc6ckgHdHGWgYVkCdCMAhBCVH8ExGnVQL
 n5RlYx8B8ijnzAzVgkA7/75xh4mOtri3SkZ71179Co4CkFYsWsNpYs73mQKhlJ8Y+cp5
 vcEzz0aNxSzThX4grndvR30ZiJhrbrcU1fe1pWCN+I0Lzh5XyRyWFl9YeE5KGUwQcMqw
 7DeeIilcxHjgr4ssUTcULBSX4s5k+nu8XcXYQlDXDf7D+6otzzKlJyuEDylM/4/kMjKQ
 A1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744385459; x=1744990259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMgY9ksSmExFbWzvay4LioQwsmmTDVnEOWiIAKfLOIM=;
 b=nOpmDwCiG18uLMFtHMw0kDimLXpm6wlpcrp91+fWO0jhrIJ90n7sS/eIvfEUdd0+Kr
 NpjFwMxfzt4Nx2Ds59OlhrzzF6Ssg91Yrhn4gIMkyS06QRASAiSk8bdvxSRTLdlwgoyS
 gVz+uxon1Z+cdATTLKSH58l/9n1JEUdPj8/DuO/QtF5RaIgXgvNs/AE/kNdCe2dBOMdc
 bQ/TvsO+IbyitMuuuohRnf6plXInnYJje3uEBb7GhFYq8ruGrcGWbPiOaiIRFJnCuefB
 39Bp7+5hpTeE/+tTaKMNbl7QjI/8avgnuSWo1TpuH5t+GxgNI7DSDo1FVTr8U618wS4/
 LqMQ==
X-Gm-Message-State: AOJu0YxGlxRiA28wBHr0QS1ZX1ToKwdhDTkgtijVnTfzNnQeBzfikY4Z
 YKeaAQpjUkB4PfDeX3i2speEWBtPWRUfQ33V71fFE5nWKBbO0FSTlHDVDqQ35veloOAWWH2CsjY
 vgR8=
X-Gm-Gg: ASbGncugLwEllL5EN7KWp/MDJ4ImqqKUUUfUxkt5eJ5676QdQuTSTubEwR2wZhjlxs6
 LXgPcB46PuX0Pe5pSimCdSPwp2AbCKh7xM2x4i83ZuykAzSFv79bP/xldXcZuJ4cV3PxMJuOp+Q
 PhSH/AZEuH+3958wWRHHmYyDCRIxIPRiPWMzaCcAQzvExzfYmhpVCRTT1o0urkGvdUbUeCAYDhC
 JVlj5460Ia+vKk5IsVQ0YfObZbO7pgXwZnIdioSWs+DhbKZTepA0/OqxKTX0lkNfhFbaK0cHkq0
 kSrws4Nx6AW06n1n7ylOCsAkI3IDcOT3+36Y6VPGCg5mt3aKPQ==
X-Google-Smtp-Source: AGHT+IGMJb5HRRRnYLguhIZiKrLb7/hbWNcRREw8WF8/F6Mdv8gZOS26+zh8jfxCKBPGoNRrPHARGg==
X-Received: by 2002:a05:600c:1c91:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-43f3a9b4870mr24355425e9.29.1744385459256; 
 Fri, 11 Apr 2025 08:30:59 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:94cf:dbda:d223:8de8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecf30sm90337355e9.1.2025.04.11.08.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:30:58 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Love Kumar <love.kumar@amd.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v1 5/7] test/py/tests/test_bootstage.py: add test for
 InfluxDB report
Date: Fri, 11 Apr 2025 17:29:31 +0200
Message-ID: <20250411153040.1772000-6-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411153040.1772000-1-jerome.forissier@linaro.org>
References: <20250411153040.1772000-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add test for CONFIG_BOOTSTAGE_REPORT_INFLUXDB.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 test/py/tests/test_bootstage.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/test/py/tests/test_bootstage.py b/test/py/tests/test_bootstage.py
index 8d0afe2611b..5619eaf4676 100644
--- a/test/py/tests/test_bootstage.py
+++ b/test/py/tests/test_bootstage.py
@@ -39,6 +39,17 @@ def test_bootstage_report_json(ubman):
     assert '"dm_r"' in output
     assert '"reset~board_init_f"' in output
 
+@pytest.mark.buildconfigspec('bootstage')
+@pytest.mark.buildconfigspec('cmd_bootstage')
+@pytest.mark.buildconfigspec('bootstage_report_influxdb')
+def test_bootstage_report_influxdb(ubman):
+    output = ubman.run_command('bootstage report')
+    assert '=== Begin InfluxDB v2 bootstage report ===' in output
+    assert 'u-boot_bootstage_report,' in output
+    assert 'u_boot_version=' in output
+    assert 'dm_r=' in output
+    assert 'reset~board_init_f=' in output
+
 @pytest.mark.buildconfigspec('bootstage')
 @pytest.mark.buildconfigspec('cmd_bootstage')
 @pytest.mark.buildconfigspec('bootstage_stash')
-- 
2.43.0

