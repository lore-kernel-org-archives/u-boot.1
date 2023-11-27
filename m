Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA00CC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 17:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA07787622;
	Mon, 27 Nov 2023 18:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qsNQvzPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB4D87634; Mon, 27 Nov 2023 18:11:09 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D7787547
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 18:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c72e275d96so59694541fa.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 09:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701105064; x=1701709864; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pCIAsPHbQnJgycpBLxVyqd2Hv4TNA2AXnw545LUnbLM=;
 b=qsNQvzPQsNttMUpb/9T07dBq6PVnzz1eYqx7hb/fh2ZZPCC6WiULsb3hoPWh+L6Y+/
 TjyEk0DbYOwlvBdBkpGdvj3ffavxL0FVGnCWGY0CRMnp0xBYeHV99iJ+dqmVeFTxDcXi
 GMrAuCMHqzz0cltyFm4CWDGhUIIDgsE1aEMJVFK7E24w+sO3+PvBscRxcbtJMpi0HqcI
 bxXuv/JeSISXK8HHlVNPaErsd/5gRt1Ktpqe/0+PJO8Dp+SIXTppGWWzSlRBw80uHcdO
 sJHqlBzkx1/stVR7LTznfEDiJ1YDIYFJ+0nOVfMDCYWix+s9nLynrPAlCIFuN1+O6aPm
 uwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701105064; x=1701709864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pCIAsPHbQnJgycpBLxVyqd2Hv4TNA2AXnw545LUnbLM=;
 b=EI3TJMOrIGBSghCdcQIAJMurYRZlJD628VWOXr93ebpQ8bUGrw/0rCt5++kUC5E0GM
 wAwDcUFhsVqjzpeDOIiqs3QQXXeW2l1a2yLskMSutKYz93GRpnjyUGIE7MDdJGEX4Y9W
 9tDIU9jhl2MPdKwgwSy3wj7nmWqOLtGkKxPOhKzr1NjkpiO2S37j1RNEX7esSRDSn4hF
 r8KSQ6davAQHUKRBZfdgHuj+93nBZhjFXVQ1wCUG6DbqAqJk9MCz0jvKAqsa6PxKrs6L
 uQEkreBGAsC8bFpxBbv5aiJvtG12TH9qHjK4qx1WNkj9YPfwFbRcEn5bFnGal7MnmXaS
 Wj+A==
X-Gm-Message-State: AOJu0YwYIho+frS6LxtJOk4UzkQvIB26H+qVzL71jmNY+bJchudfLpJp
 4cJw/dISEy+nHkh+6/VF5RX/jA==
X-Google-Smtp-Source: AGHT+IFt1NPLPE50ei8tkH65R78dm0+ZmAz0kHogSIfAF4YueVlHV+vloJEaoZsDPDH25hlefD8TbA==
X-Received: by 2002:a2e:8e6c:0:b0:2c9:a114:253c with SMTP id
 t12-20020a2e8e6c000000b002c9a114253cmr2724880ljk.15.1701105063621; 
 Mon, 27 Nov 2023 09:11:03 -0800 (PST)
Received: from localhost.localdomain (ppp046103219117.access.hol.gr.
 [46.103.219.117]) by smtp.gmail.com with ESMTPSA id
 cp12-20020a056000400c00b00333040a4752sm2401198wrb.114.2023.11.27.09.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:11:03 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: sean.anderson@seco.com, sjg@chromium.org, neil.armstrong@linaro.org,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 0/2 v2] Provide a fallback to smbios tables
Date: Mon, 27 Nov 2023 19:10:56 +0200
Message-Id: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
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

Hi,
Tom asked me to clean up and resend [0].
I've made some adjustments -- The DT nodes are tokenized and a single
string is used. The DT node 'model' is used to fill the SMBIOS
'Product Name' and 'compatible' is used for 'Manufacturer'.

The reason is explained in patch#2 but the tl;dr is that model doesn't
always include the manufacturer despite the suggestions of the DT spec.

[0] https://lore.kernel.org/u-boot/20220906134426.53748-1-ilias.apalodimas@linaro.org/

Ilias Apalodimas (2):
  smbios: Simplify reporting of unknown values
  smbios: Fallback to the default DT if sysinfo nodes are missing

 lib/smbios.c | 109 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 17 deletions(-)

--
2.40.1

