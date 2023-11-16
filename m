Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B4DC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15BC9874A8;
	Thu, 16 Nov 2023 17:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="k6Ep1fMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D3E887479; Thu, 16 Nov 2023 17:51:22 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10CCF874B9
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc4f777ab9so9326895ad.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700153475; x=1700758275; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uZ60/4qTxC7iUFaujfoWF/FAH4L2vwypEPEHdC75scs=;
 b=k6Ep1fMOdtuKlFs3lCPuaHyhA9SKlLUizLjwIyG2WqdA0w//F9KvQAHR+2Nw9xTtel
 9csaHlDFOrARY+OFnoVzVVKOlMqjcdL/mOB5YF7gyTW1TbsXEc+2NHde6NqWzofQrEIn
 jeqxGxiu3EDg6emO4RWyx1/aKNERSoTu1N52yxoW1ETBc6hgMheLbnEsdY8AbNIHHe6u
 IvUHwfa03O8Lf/vYVkRlz1Gj3/Mi2vhqBzMPPdEq96elNcuRpOriblW1oTBna0r7kADb
 0GvOKjRqcMi+M9zUdRm3rlDpWC8gMA9CJIv+girt/gWxODpBirxpAQ0O5W5qU33SL8As
 dotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700153475; x=1700758275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uZ60/4qTxC7iUFaujfoWF/FAH4L2vwypEPEHdC75scs=;
 b=RTf2u4+TaindSaMbM7jHB2hBlQ8pxy0tV/0ggnXtg3y4HHsq+PtQz4PG8KFweuw4oZ
 c55cD2YeWti+hsS+MniT4CGoIDifOVHiN/EG0nf4I9jyfVBLzwp2VtNIQehRxflyAXbG
 sPjtIkTICvtZqimy2hpDxtlPBIv8yUphyp6vsGAK6RiN4xAjy/OXwoiTN/tR8aU+KHdH
 WjOisAVCX7RiTJn+j+7hMt0PmJvsP/KG95ZZEzyieEOZsOKcyMg0S6kqeua4ZWCzfq2t
 3Cv5shwO+9uU292592cgsCwEyWFwidw9fnwNjTKq+nOekD5IWr2T6pADZol7Ga6fszbs
 twNg==
X-Gm-Message-State: AOJu0Yzeuw1iTNZfALtfbwgYB+qTGjuwYvYgfBqp3P3nzxKdmDnAuyV6
 rYNAdW8DYtTnEKuv9zlY+i7XEA==
X-Google-Smtp-Source: AGHT+IF398sazQTYiw0xJ8AGjLe0L4kjAnzpCXrlyka+xhJN44fNa/EiQA7ogt5LiVCoIvgsJqJ/7g==
X-Received: by 2002:a17:902:d2d0:b0:1ce:5b6e:97ab with SMTP id
 n16-20020a170902d2d000b001ce5b6e97abmr22857plc.51.1700153475405; 
 Thu, 16 Nov 2023 08:51:15 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:57e3:f37f:e352:7f6c:bf18:83f0])
 by smtp.googlemail.com with ESMTPSA id
 j13-20020a170902da8d00b001cc32261bdfsm9438696plx.38.2023.11.16.08.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 08:51:15 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Michal Simek <michal.simek@amd.com>, Bo Gan <ganboing@gmail.com>,
 Puhan Zhou <puh4n.zhou@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Shengyu Qu <wiagn233@outlook.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/2] Xilinx PCI driver fixes
Date: Thu, 16 Nov 2023 22:21:01 +0530
Message-Id: <20231116165103.140968-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
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

This series fixes couple issues with the Xilinx PCIe host controller
driver.

Changes in v3:
- Add error checking and improve commit title of patch 1
- Rebase patch 2 on modified patch 1

Mayuresh Chitale (2):
  pci: xilinx: Fix "reg" not found error
  pci: xilinx: Enable MMIO region

 drivers/pci/pcie_xilinx.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

-- 
2.34.1

