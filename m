Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B8CCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE1C5845C3;
	Fri, 10 Oct 2025 16:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aIeMNZzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B005842C3; Fri, 10 Oct 2025 16:35:25 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A5FF8455B
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso23050765e9.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760106922; x=1760711722; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E1lY7t+zM8Tc0j/ob+S5UPhbWRoQr0TCMQuAzOd6To8=;
 b=aIeMNZzSMMCsAA5PgUDuSllYK87dfNXXpJTXZVJOdWqS4OK+rq7d0ugVF8aWLG4tba
 DlglbBjBRtpnApizfE7VpRLIl3e4aGilLgAOXUzBZLpIrkNA3qSoWUZjoQi2kr/lfV98
 2Jlhz9dMTbUCNfPtwOifFCmxC+61COSjCNt2yuctwMWXoydW5ieEJEinQgIU1w5zkWVi
 zcD6CB6+ClpMDqke1b7JFu+c8G9dzfgfc+aMCzy025eu/SCrR8R9/1A7IbFhgfIweGFi
 hirsgJdIqyW+wbCXMvPQsVGMiPk3VWVvFaDWllmy3uU3IRfUoD6ZquHjy3W7R3MJ+6Dw
 XB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760106922; x=1760711722;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E1lY7t+zM8Tc0j/ob+S5UPhbWRoQr0TCMQuAzOd6To8=;
 b=Z4srzrmKGcSJpxKGdAiJc2KdjBR9aUyzk6UDEmq5NOYJnC08zaaWBbWBLx3fRG+4ZC
 GZBSdklaLU4tt/dh2xK8JINiX4xrCOiQdI/C2Sgl6U+vdErjmJa+W6joOdjd+goS6Toz
 pqR7uGahKzp95i3KkJrHmU2emOHIuNIA/drUcqRyIbMzN92MRX6AZVcjYMxvPOp2HKbX
 fF5HVJGXBkxyKxYZNpbXRWBggul8kGgnIaB91CcLtjLkCigVXXSpszoXlD71Dd4Yydja
 DbmiNUD9akMiaHMGmr4E2HgQgeaO9604fU4EQ54xNTx7ysb6YE+ZqPi743CQH7tQY3WA
 oM4w==
X-Gm-Message-State: AOJu0Yx9rFwufyEk7F2Von/12Lwn88PoeZSUqnzXDVsLKfCp7jtRPgdx
 Z65XE+NtSw+Oh8E7UZMQ4e3kk4w4o7tU1QXr/E+FIYjc1mxsce0BZ3oFy4H9VDJr4Tw=
X-Gm-Gg: ASbGncvi1SXFT2bLIS0jdUXgEUffieTJmDW4MEh+N+OqD8A8wKr2RUXzDn4Wd0OqO72
 9oPbsiiJQ1SBCHTtzH4CWOhVsL7kOSUFcfh/ZRBcyRbYeyqfnp758QmVQhFJtk3Apu2yOmtVKdJ
 c9ZBYw2FRFzudtw6qJTV7GkAf981gAuVTVWKhoXKEnMeD5snkAVt0FgNuh/X1HBaQg86ylr8dBx
 qIp0JJsPbYW3QCxc7XpBYG7V7cqbmPbNEuk533dSy246iFTQTdj8byqGnGuDwSFlglZJbJfzkj5
 Z67KZPebjOndBptOw3JEia1R8kbQxOGb95+qBk+9OBumn44jxW/tONETfqKB+CQQ7Ec6W8jr2vb
 PEf7C7wovNDO0pqJpYQIYHA5pWY6ifRFKf30caQ2bZWMM2M3UwvfhW5LeK3dVU21dYw==
X-Google-Smtp-Source: AGHT+IHIdyzgOUyUcqYAizdjJw2X2SyjTJUiGhXD5u1vV6QG71+9B4FlezuBNCVdy0uN88oNGGSf0Q==
X-Received: by 2002:a05:600c:6388:b0:46e:1a07:7bd5 with SMTP id
 5b1f17b1804b1-46fa9b0797cmr87418125e9.29.1760106921695; 
 Fri, 10 Oct 2025 07:35:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab5250ddsm59878215e9.6.2025.10.10.07.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:35:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 10 Oct 2025 16:35:14 +0200
Subject: [PATCH v3 7/7] qcom_defconfig: enable interconnect for SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-topic-interconnect-next-v3-7-b384713283a8@linaro.org>
References: <20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org>
In-Reply-To: <20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=604;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ep0hJJF3iIsA6wAEy8B0URuIjC6WkCkoAk3JAXjG/Ag=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo6Rmi1eMP1VdKS1T91xwFRF2nm8y8yOdHklE4bEs5
 Git1XxSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOkZogAKCRB33NvayMhJ0W6QD/
 9rTnqn5G9YDP7P7nrG27D7V67SLtzHDi+Tu3RT8e58+NcZ69fHwjeCURRsn6lZXa1xZweSntqMXX53
 fK8agUEF9T6dr5BF79shUL3yNg4vNo3dvvHd6ow2GJ6IOqUdii8fo6UGmmlgHkBO81BD/PyLHFcIcn
 6HAAKZ3bK/AXXWZRNMqm1xg6YPslRGwChVyw/NygR7Tvld2nBbW/r4zpqNTRPnZzhtLGYRp4XGn/sD
 INgU725TfVhVO53m9J3Cv9TkjswroDp1iYQrgejdt9Rx3EioTZiflvzZRdnpvzvqoyJjDY7zhXPYWj
 I1pZCx3hSwEvMjIOQCWYykmEXCgA/OUHtmKadJ/ZeDme4Hl2eX1GEoNYv32RH1M9k1F6/aQ+MdIITU
 5iocaz4SG1xcPwziASPmbgemWUHakb5pU9px6ECCKZGRd+7GV/R/z+EKb65Mj8exI2mFeO33QArDlm
 iYYKUDGZv6a0/udi1pC1l121mvA2nRkjC/wrXLLkni34x1REB3yHoaEiwModMSuibqnnMK4kFtFtpn
 VR1dqGz5KOvY6PguO0IZXA9Vq8SfVNEFZLp2tlS4ulIVpT87BUPNOUaWveLiO5jVPBnPsYkiQjxmlJ
 /HtdL9TmlgxBIL0Vs4mRcf/HWMi2VFK9JlMsv/mgeE7YCVzk+hGBCgYyhhsQ==
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

Enable the Interconnect drivers for SM8650

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 6a5b22591dc983fecc0929bae8949294d7033447..6b180e7e7369379823ec1aa1192ec688b6805f18 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -168,3 +168,6 @@ CONFIG_PCI=y
 CONFIG_CMD_PCI=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_QCOM=y
+CONFIG_INTERCONNECT=y
+CONFIG_INTERCONNECT_QCOM_RPMH=y
+CONFIG_INTERCONNECT_QCOM_SM8650=y

-- 
2.34.1

