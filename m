Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B75CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4255C840C3;
	Wed,  8 Oct 2025 17:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mg4RqFcm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD67B83FBF; Wed,  8 Oct 2025 17:31:43 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF06483A5C
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso40957f8f.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759937501; x=1760542301; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E1lY7t+zM8Tc0j/ob+S5UPhbWRoQr0TCMQuAzOd6To8=;
 b=Mg4RqFcm2HBLiAXW9VncxvKNGEWVXmkRtLhSVTDNQi56l8AG5fRatMheVjCDj43GK+
 tQuo6DpX6Fb+6CBHfcEaPG7ucFgkh4UYqUhSC6YAFhYlIkyEfL+13Gdcb91MjBPnPPa+
 L46cvx3zzRTD3ttdUBOirjdkUrgVczbxdFPbzbTCj/RfEExeudy73tZWCwGKkVAqPjKI
 YwgUYAvY0JnhBuZ4FdEqBsWfXZBbShVMoj/Pfx+jDJw8ffU6nqKGOXFKbZ2AlH1T0Frd
 v3jKQJfQ5AR8aJWcsWrlCUvNKzSJhArSoypMEOF6RV0eL6t1aXWSaWgEv6l/qn/ClG7S
 MoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759937501; x=1760542301;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E1lY7t+zM8Tc0j/ob+S5UPhbWRoQr0TCMQuAzOd6To8=;
 b=JjGuLfGmYl9w60Z7JwEOxi8rwBXHTmF4pQtCn7PADnccASLwU4wXgeD15KtRl/RWWX
 l9fXsrGRIioBK9UIuWLK9bC5QR6PGHy07CIGDIuKI+LGFLtRi+Y/SUOvoyc6ElBOEdvJ
 kwUsYkEChToQx8XV5IKLB2JdWmDIYjCEf8ASvml9YcwETaLYL6LfHAUWgmgrX/nzhiiB
 AX80k96z57Vj8T+DfsL1I/kQGL2RpBmoBUDLkOcRNvV+diPEExy6svLehkwTUg7hNR+J
 8Slhx3FYg0MVUz8iGOJTo0y4tFb9eMDl1lzGWMNWHJuojJNkEfOQRCOoDWLeZRjWmDWe
 gLqg==
X-Gm-Message-State: AOJu0YyGWh5ndQ4oGQcCD2FzVM4j141HbhCP//VXnvS0VzBpaPnI3gqH
 6wBgOaPay/7gVf+lYCMYM27m5HVkfEia+Hd6uKh2NG2geozDnQR/TEoGMYl2gtRyc3I=
X-Gm-Gg: ASbGncvk+ZVun1CEXd5cZ+sm8g/gheMLOmyHQ7BQiKN/IcrJsbW/SAGaeSf8nR/TJqT
 RgMuhEYLEbVEiRMfWjPHm1RK9XHXD2fQvPurYeE8NVGqpjFm7I7e0A61Nr4iGBPFJ6iybdvf1g1
 ZcgodTxozPZsCPBpW/B2yz2XHHl+jeSnDk3baxQSdVy/fLXLqlXDDOgOMza+vQGIVUesXONT8e8
 pvGdSI5tKTZ4/XtMh8E+jbJSI49JGZN/Qlf6/UFpF+3tcvQ9Np/iaIwCAeB9qxw7FEOpfdU0mng
 hkxoAsbVoNW+boidXk3GuC7hiAa+Ickdwz7LJSDLtrmPthWQm9pWNMBDqSzuzfC+ghtcdJm+hpo
 TAJ1NxkQiVIyINjRwmuX1az5hz/tffqtE4sienn0h1+6FP7xY4IKpVsUgDfhXk/XxWciIhu4=
X-Google-Smtp-Source: AGHT+IFd8T+m8mq1SPvFuq70oGOKBRtpazs6PHD9MXljDwdpxc9DuphVn0iTTilyeLZAaQnSd9LURA==
X-Received: by 2002:a05:6000:438a:b0:425:75c6:7125 with SMTP id
 ffacd0b85a97d-4266e7bee7fmr2872388f8f.16.1759937501327; 
 Wed, 08 Oct 2025 08:31:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9890sm30715289f8f.32.2025.10.08.08.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 08:31:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 08 Oct 2025 17:31:34 +0200
Subject: [PATCH v2 7/7] qcom_defconfig: enable interconnect for SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-topic-interconnect-next-v2-7-c46e94dd328e@linaro.org>
References: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
In-Reply-To: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo5oPVVWeG5oSg07sZ5wRP5/wI74OF7uF+OGkjduO2
 vHwipsiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOaD1QAKCRB33NvayMhJ0XeaD/
 0YvRaLYHPkSzzyk6yG7RjubBvkQEjE1z+4CT6XSOsmiAeV3zNBcxncbTztjwGSrKagUPBTlzR4rIws
 Z4AZwFzCVPrAuVTqoa3ynOwn8Z3iWC2wDSI7Z2+wQwuzUH09HCqMJlmM1vrQlnIcrwCu23ulUbm1Cm
 ksKFWvLtDgVXhzm0PRJpzxQ23qvuNjciGtdFgQyK1PvbsC0aJ/BgEAgNXDLRY3K+ZEhEhSP9frgkjc
 vXxwkhExQqFM8johKQFJvMf/zyPw8zotMtir/fRs6S2hv9hwN4+IO90yZC9rZlFNX45PrUZIRqdox3
 5fcWgRYIlAD2L47/ErTSOWFp4BGrwURevqyXV5qRqSfXp02D43IjMmxJ+bO/4TnwP5nbU7v8PLykLI
 RVv888CHhztYcKno12kfWgmf/cU5UNLxc2ilfRm/+OSlqpd6L/DebD8PEYGOtOYorS/A5wmE6LmFy2
 b3Fna/HAfWomAO3KMQ7DQDgqCxlgw6O4Y+t8/bv9DNY64jOSrl5SCH2GfGgfzhT04QH5VllbVLHtUx
 TRqwJgQ71RQyk89Y+UxBsyKvmuh6c2mMsbY/QpvCX6oEK7V6VUV9Rd6rVZO098CoKulBGynkVzelcy
 vEOckbuKRgpvN/7/p79JWVcj7p1ICVvESKVGBAJznag8zeauuYCVhkOe8Hlg==
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

