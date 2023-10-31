Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B48DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 18:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95211875F1;
	Tue, 31 Oct 2023 19:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XGNFpmDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A624C875FF; Tue, 31 Oct 2023 19:47:09 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5457A875DE
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 19:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507e85ebf50so8381771e87.1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698778026; x=1699382826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R/Smet0cryX3tIpCeHd2/yzx/dIuM7pyM+XLw7YH4dU=;
 b=XGNFpmDLcT6xOL1J3U6iGgJpXltvwyLODL5hvpPWl6v5CNTWt6h3ZW+Tt7Hi9lPb9J
 BIkxdATTq+i9zkn2Z0OCOP+KYwHYOtqGn34fa+X+5y6pHQPruW2A/9OE5sl7hSeQ8uTN
 IPkVKw4sI3xhC+2Mv+EFGJunLgIgoiDFJdIjNuU2JrBR+TDKxiqAAVWO/IjF/bYT3oDk
 f19M3UrIgssxkI+eRqcIOnhRJrrs8CiwNWTY5kYsyEvKjNgfLOnb+NVxplUhhuu3IHNc
 2UrNdY2giG+EPW03xxcMzeCqd8/quIlhmlYB6uaaunRrQjRVIV6qW1MgGzwJhQqe2mlx
 iL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698778026; x=1699382826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R/Smet0cryX3tIpCeHd2/yzx/dIuM7pyM+XLw7YH4dU=;
 b=U34vRHsxaxGeClkE5CF7tHwxr/20BXeGgvkbKO+lXkNN93oWY3GoXKEddlGKkEzW3N
 iA2eSppyzxaUF5LDBP8R1m2EZ9jcGOIdiW/gEefq9ljgIgTxoRpbwXILTohk97jfIyfH
 Yg/9FJiCUU+VteSAitR8Kpe2rfRYi4YUCMNt/rhlx31vMv2p0idkPtrwnwLSEHIuN734
 nY1ssuooEUY33YAy0wIpPBovFoHeF34I6PMKlm4EyEZrkH1Fhuf0Ev2JQp9ofgp1BPfd
 U4yzsZN3narRwa/hiFxEGcKUhE5u3D4cBenU3dxu6ZucHzz9nsPonVHGkmyIcrfFiamG
 0TNA==
X-Gm-Message-State: AOJu0Ywaa1WBPp41boRYVD9i684r21VkjP2/RLNh9FhMUHBwStZsBM6c
 QKvyE1fXnRBzoAXi/iDUa9o=
X-Google-Smtp-Source: AGHT+IFsBHS2oJPX5eNudJI6Swgae5g5y4DQx/4Pa/D2NQTcCEMB5WNolw/VZ33U7DSEW8/ywW9lzg==
X-Received: by 2002:a19:9112:0:b0:503:2561:adbc with SMTP id
 t18-20020a199112000000b005032561adbcmr9345357lfd.64.1698778025950; 
 Tue, 31 Oct 2023 11:47:05 -0700 (PDT)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 u7-20020ac25bc7000000b0050804a97f01sm278794lfn.160.2023.10.31.11.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 11:47:05 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: 
Cc: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v1 0/1] Step up as co-maintainer of Tegra SOC platform
Date: Tue, 31 Oct 2023 20:46:49 +0200
Message-Id: <20231031184650.9141-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
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

I would like to volunteer as Tegra SOC co-maintainer.

Svyatoslav Ryhel (1):
  MAINTAINERS: Step up as co-maintainer of Tegra SOC platform

 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.39.2

