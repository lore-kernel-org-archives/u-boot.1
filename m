Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81D8C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C726F87EB2;
	Mon, 26 Feb 2024 09:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iyDQ2Br1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0964D87ECC; Mon, 26 Feb 2024 09:06:03 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0722387ED1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e08dd0fa0bso2361877b3a.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 00:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708934758; x=1709539558; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4vLzNaRxzsYY/k1BC5UKDE7tAGsBXZ6szORZiDv0cg=;
 b=iyDQ2Br1YfmM45fU0U/arODJJMG/e01N2c8flcIizp2ItUXIkHTiD6GtURRToc8hWG
 fo5kkMZEUh7xzaNX3E/EF0AUpDFgWI/4CCnSLUIon0oK/KlSNx9DX+EisV3bJwrPF1pg
 H5CIlx7EJ8lcSZb1WMy7Sbsz70Ow3cEBTiyeepzei9g75ursQBYGzXjVUIKzirePSgat
 m7rk9UJB0LkK930SxT535ghr3RFnsaA/Wbfahu3zB4tiP2yYiN5ER7IGOkquiJldVjit
 T+Skav0BW72eTzOljWhROmtDcPT+WcPh3tdy9KM3NaZw1baEToTJ0bZzyayWe/NAiuqY
 z/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934758; x=1709539558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4vLzNaRxzsYY/k1BC5UKDE7tAGsBXZ6szORZiDv0cg=;
 b=FbQpy4Tu6eoTvH/m6e7BW++BrkthWJcHHlWnk4/ow61pzAnUPzoGIgdQMLSHhhu7tb
 guJgu7QfyaazdRd/Jv9xZ/AHpbiHAOMCt0Z2HJFxoHKNkI/O7ITAwoUVf8TZ7ZHi1Gh1
 lJOCefPKco56bxIjJ94WZ2YYpxZpcJBAVNJN9U4MizH9Nqmo6EAcLhrdoJSPDP3jq5Wi
 ahtQUqA4eGmsU+mxkMpA/oBgV+F8ueb0zqK7u5y1ZHrfJ9CWpP90RFJPeLiwVakYV1GO
 FihIPxoKEoUERluBcH/N8nEBMwGGTtbCjldutYYppwmTDd+m6sg26g7grN5wvNhlVrcq
 tn2w==
X-Gm-Message-State: AOJu0Yy+RjMh5eAHLEupwYo73NVfg5Tdr66Up6TJ0SINW/FnOVH1a9e8
 bvOIFP05GsVmjgE69HbdOOTpF1UQZ4TQMKyi3Qi1ihpVZUAdhIKAskg1K6PwbUB60XS7Q0UziKb
 1
X-Google-Smtp-Source: AGHT+IEW/WwC5j5NiiIKS2JBhVu4uVhnzloTsbd3F08TRXEgLOZh56VqeMMEQx6qvLJyNgMDzGgk9w==
X-Received: by 2002:a05:6a00:9a2:b0:6e5:37cb:64c4 with SMTP id
 u34-20020a056a0009a200b006e537cb64c4mr962973pfg.9.1708934758215; 
 Mon, 26 Feb 2024 00:05:58 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.32]) by smtp.gmail.com with ESMTPSA id
 k2-20020aa788c2000000b006e13a88d52esm3392842pff.61.2024.02.26.00.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:05:57 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 8/8] MAINTAINERS: Add entry for PCIe DWC IMX driver
Date: Mon, 26 Feb 2024 13:34:33 +0530
Message-Id: <20240226080433.3307154-9-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226080433.3307154-1-sumit.garg@linaro.org>
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
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

Add myself as maintainer for PCIe DWC IMX driver support.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b08ca192397..af23b0c6c862 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1369,6 +1369,12 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	tools/patman/
 
+PCIe DWC IMX
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	drivers/pci/pcie_dw_imx.c
+F:	drivers/phy/phy-imx8m-pcie.c
+
 PCI Endpoint
 M:	Ramon Fried <rfried.dev@gmail.com>
 S:	Maintained
-- 
2.34.1

