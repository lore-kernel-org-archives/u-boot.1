Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB73CF8553
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 08:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B257840C3;
	Thu, 20 Nov 2025 09:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tK8goFZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC9B8405A; Thu, 20 Nov 2025 09:13:15 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D5DD84057
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 09:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b3669ca3dso218766f8f.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 00:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763626392; x=1764231192; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DQYMpLJKpBAe6nQG3hwPJMRE58tBlJCweot7OWVwp1w=;
 b=tK8goFZnr0hD7XAt0tlsbAV1yfsMabfsqg6uV0pCRlpUgI/XuLBtOTCM4404QGAmRZ
 1tr6IOQukqHE7SsBhBgt+9AkU48H24UkkNBwNMZVOrBWFg1r7FOC8K/dPv0ixsouupV9
 d2UaY+Ds3fkpXtGqcn2KKlIHX0FCfrM5UrNNl0ZC214SBzp+EsKj6SSsk38uQuOzQKSA
 mDJZTrMWp7q5EImgdC0LvFNMqXWZ7jxA5unT+51dAnma/cxWi972x7gT9ANxTdBrQ1Fd
 /j7l/3nmv8f3xAA8Qme4T79+Rl4hcpZ6FLDSiNhow8HsejD8VS4ydNQd21bKVdTVV8v8
 emqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763626392; x=1764231192;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DQYMpLJKpBAe6nQG3hwPJMRE58tBlJCweot7OWVwp1w=;
 b=P1EOdCQBtFKYa3w1DFglb6Ye/OkpnaT/LvDRQbQ6Qr0ezDx0kGQg4krcLTMZqDDCH7
 v4jgmGvnW54oqsgsirtPybzcXt0GBLq/U67iwNrPqnIxF1LCJdiDOTiJG8T920v+zXMk
 JsH0fsU9Vi87GY1RVcUoRiCE/3GrdGHAe0FBQ34jLZP9Ei72QhrwKCJPnpBVvxLcMm1x
 X0tkKjn1cja6UuGAtg168eFefr8LL2UsVGm1IMKWGHIHkc268aG9sxFWhnoQAiAqKUiA
 0Nk+2Ww2x/pKwcJmRy0UgesYMx4z7mNih9W5cQL8tYyUaVGH5x0o/aRdEfVxtAtykgwd
 /K+Q==
X-Gm-Message-State: AOJu0YwScWTRuQLi+drwFg9jM3J6nXJkEjXbHPowMbx+nK/QfGd0YLFa
 /4h/9dn34oxaZfxP0CdMk5dXI5/W6I5Wl/kBg3f3h2INL7qvgEQmIWRa0Cc0Ky2p41k=
X-Gm-Gg: ASbGncuNJLuln+AsG++8YvUCQFFCMMMItCSTAr98hLebeIiB3LFR3HVu+SEU8viAf3S
 Kv1mYeW+V15d3TpkzD4K+Sulf7+sWZ1JQ010013QrTxHq5TbsLsSno5vgTUxbuZyoL5nouDMeEx
 9hBon3XVMcDMshrN20GsC3eyRKvW2ZRC60Rfqi7G/SRKvQWRCmWQHDCsBKUx75OK5bCq1FvykGT
 2XxpgZx31kiS8d/lD3iHTM5UE+AkQzzTHr7E53YghFH8sZT2pJ6ueMUbEW/ScMLZGkxua/EtiPG
 PtZV+hE9Fc1VOmEcrZesfoGLmGgnaRx6y5XJWcx0YVx9OyV3xLyKMm4A5RbHr9nLJuCoHWM6hzw
 nG/L+zHdOMY5hrlXOziixBDymCb3PfoPnfnJ9lH2eyhyRNYJ1Cd7Q/ttHFI6sdyamFsp+iaVjrz
 7QY4igCYBHRbdwnOelba5oxX8Qyw7UH38=
X-Google-Smtp-Source: AGHT+IFprHOug80vAFv7VIqqo7GshpvFmR04nuJYfLmCN7WRVE0+XgOSh9Cwa1tuE9NRYv+Z//hSWg==
X-Received: by 2002:a05:6000:2387:b0:3eb:d906:e553 with SMTP id
 ffacd0b85a97d-42cb9a691c9mr1608767f8f.55.1763626392204; 
 Thu, 20 Nov 2025 00:13:12 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363c0sm3844398f8f.18.2025.11.20.00.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 00:13:11 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Nov 2025 09:12:58 +0100
Subject: [PATCH v5 7/7] qcom_defconfig: enable interconnect for SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-interconnect-next-v5-7-e8a82720da5d@linaro.org>
References: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
In-Reply-To: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Anurag Dutta <a-dutta@ti.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Alexander Graf <agraf@csgraf.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, Sam Day <me@samcday.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Sajna <sajattack@postmarketos.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=617;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=l1OaNqfAmhRIe48N3BIxIps8arKvVqV7RbWbaTnuCcw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpHs2KHilMIN5Kv6dyZfM5ukTYNrT42zy2Eys7QCMl
 z3mp/GiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaR7NigAKCRB33NvayMhJ0aTYEA
 CVHqdE00GUdPVCgnWcGKKIUAcNHpNdZu/S/iIYcSCDF5WN6IKSGtRp3whTmDW76XDRB1ha10RyNJU3
 Ja5sdMIDOjMzefMSkJah2+TjQAYN19tC7jy6xf7bpjd2xKGgx8I4SduNq7p1uEEhUaGH2nMucGvTm9
 8uUxd1stwKiOeVmCivZQw5VKm5BpfXeywJFD+HRHawQFV7d4cUm13cLwHJd8RQIS0eU4JrBhpgK6bQ
 13LMYny+wfRcM8p4nAsZLnReRf4E4M8ZrbwyCA4H7PbRJYpajZmE9BXOTRpRvYwiUb+1hHbk2EkyVF
 3+vkKx/CYNaLyC81FGMEm7ATd439wOH2nSA8CDOJsDq2aqo5/LtR6JIkUsTv8rr/xVGXV5x0Vv4GDu
 d9IGu46UQW16XNNZYZlQJMuSjrvO1P0kCGCAEXXiPDtR5PXjus+Bx1vP2k2NLD+Mvzf/b44Kapsd6z
 bjisubX/Qj/t4kkH1Tc8mdZcR4h26QT8UN1TYbLJSv56+Fkxl5k04USETZKWtDNPYocuQoOOrC3Zd1
 GtlN9xi8MBdyqlbs5g60BLHPYWIsLb9+o4rBUjCkADHONuITwKOFgD8F1yIYzikzJtu13LUhKumJWt
 AYjF/PQUF4J2FktEnS2sMjn1I82L1fZ8syTy8CiM9DjBwn5GOtRF6cIpoWpA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Thu, 20 Nov 2025 09:14:18 +0100
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
index e686ea857b9..a56e1282821 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -87,6 +87,9 @@ CONFIG_SYS_I2C_GENI=y
 CONFIG_I2C_MUX=y
 CONFIG_DM_KEYBOARD=y
 CONFIG_BUTTON_KEYBOARD=y
+CONFIG_INTERCONNECT=y
+CONFIG_INTERCONNECT_QCOM_RPMH=y
+CONFIG_INTERCONNECT_QCOM_SM8650=y
 CONFIG_IOMMU=y
 CONFIG_QCOM_HYP_SMMU=y
 CONFIG_MISC=y

-- 
2.34.1

