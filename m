Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9A9C282EC
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 00:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E1681A0C;
	Wed, 12 Mar 2025 01:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BbWcX1qk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AA34801BE; Wed, 12 Mar 2025 01:32:11 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD59819FC
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-47691d82bfbso38958451cf.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741739525; x=1742344325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgqtfvlKWvO4ktGmRbi4MMbwUNlM5ToeO40arJs/5ME=;
 b=BbWcX1qkZg3YbHfWhHmPju9GiEqlWa7v2pofM27/vQ0Mkr6ugHm8a1LV9RWsit+jKG
 WmQhcoVyYuhVB3s3x69yHw/qc7+t+mI/PCA+BRDx0kUzGyV7MWdUpCQWVOR9IE/DG15j
 fkupIfefJx9PSrGiFhEjy6p3eplwxMk/Nnm4Y5NU5an6GQjih9M0I7BX45F7B8pqSMa+
 XdrTmMJeMfBzqrtmspUq5F539fAsuO7LmznKeNTbeO8dBCKeRxz8THtt84BdYr5rWrXu
 MsLiwwP4bUQ/8Ym3Wi8x6HCj/rzgEw7kKe2ma8WZC0DjuJD9XaKA2o/8A+MfmoaOnjXU
 QAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741739525; x=1742344325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgqtfvlKWvO4ktGmRbi4MMbwUNlM5ToeO40arJs/5ME=;
 b=gqcLDXT/nJ0yB5TamEd0q/vUiordSuJ8XKyU1MJ18h6YWC0YBXgFVCwZnqq8Aa9/ZA
 JZzpAxKHy5FHh4bXyv9XMuQgpmG/JYo5VPhtYoP1wNgQnVmfxMQh3n9UM6E5u7+SQdI8
 HHsXYBuJEVTzS17ZGFhZXwPlc0xC7FwUoVQyrP+j6YqTj1bbdLGOsCZJFToUPOrMtEO1
 udFqdpWR6t+OjJnzXm1UNMd4hO2Vgwx7C2f7ue2hAxDqLbgpJnQVe4wwrbi9skC/rHyN
 uNoes1X4AyL3hI2u56Dq1A78N0znfz+zUQuqf+qqL3oyXXIXMV8pK2bRItLM6hGPIdaR
 A4+Q==
X-Gm-Message-State: AOJu0YydU+3LVAtICL9d7dTdNnz9qRcjDayZOQVzfsFbIJVgZnW1abaH
 ef5RFKaSnGxepGXauzeJIujYYVf7kDDVSpFSSSzR0RZCkWcmKkLxnND+uA==
X-Gm-Gg: ASbGncu+F8efRvNbvoF6TTsMW+AhqoF/hIwyqvjTSo0DhaNRzo81eNlB2sTzZZDL4fC
 oZUpe8u62oAgavMcZJbivRf0eOWqQNDM1A8tkTrkavn8C5oiejnTDEcKewx8j1ysQfN5JDrHfVc
 kLBoA03Wakhxb79TS1ZrFEX3yREN1t5ABilhVnKQdiywUmk/N9p4bGq9J+v+hZYmkskBK7pkzlN
 jzrWE7v94pSsZ8k1Smg81uOeLsZ/nYf/bTciUTxYuQ70Q1M/TZdnteG6leCgedmtRLM1AzbCwDd
 Kz0qS+YGd8a1JWadsOU2b/cKgedrpcHdtKV1xHbcBmJ+8Me/PIdbR4YV2wJ7d9azepCNx/CyKn9
 kKykQa+oX0/e91UNymN0=
X-Google-Smtp-Source: AGHT+IFu6lSwiDSVkAO9lWi2c6h6aqqLxVXDqDcn7HdfGr2johHxilbUWj1O1ePiI/bHoojNcHo0tw==
X-Received: by 2002:a05:6214:212a:b0:6e8:f0f8:680e with SMTP id
 6a1803df08f44-6e9006049e4mr262861136d6.9.1741739525360; 
 Tue, 11 Mar 2025 17:32:05 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b798sm78025286d6.80.2025.03.11.17.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 17:32:04 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V2 09/10] configs: imx8mp_beacon: Select SPL_CLK_IMX8MP
Date: Tue, 11 Mar 2025 19:30:29 -0500
Message-ID: <20250312003041.110023-10-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312003041.110023-1-aford173@gmail.com>
References: <20250312003041.110023-1-aford173@gmail.com>
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

In preparation to remove manual references for enabling some clocks,
enable SPL_CLK_IMX8MP which automatically enables SPL_CCF and
SPL_CLK_COMPOSITE_CCF which permit various drivers to activate
their respective clocks automatically.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 configs/imx8mp_beacon_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index f39e4f5dd28..9709f628f9c 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -86,6 +86,7 @@ CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
 CONFIG_SPL_DM=y
 CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x42800000
-- 
2.45.2

