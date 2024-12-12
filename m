Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84DCE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C080801B0;
	Thu, 12 Dec 2024 11:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ey9htMTC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A65C801B6; Thu, 12 Dec 2024 11:37:30 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71926801A9
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3bbb0f09dso709936a12.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733999848; x=1734604648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eKDAxdyLYVzRJ+IHMMFmMA8GyvXThla84fXRo/RTqY8=;
 b=Ey9htMTCrkicflpN7AcMvbvXE4nw2hs+fy+QWwUTjy7G1iA/DGsBDAt7GHPmk3VlcM
 V3vwna16nxVAA/6ESmOxS8T0N2ucfQ/p6xb5Fd0MGJlmn6KM/poaarCYRmofuosljsVg
 0vZziOQRy86vj5Y1TPiZwi5Q0PwU9go89zx3WQKDx9iEMe6TG2rd+lU2FwwHaqB0bG08
 XQ0K/MITt0nstXel+6TbH5qRRJmyYXDPVoEs2hgWfI/ARo3I1MOZ0MoM7/spJZN7AIfu
 oHBk8tlAq0pk4SbUM/lpeS7Qsj2hSpX+Ch/xQxy2gbUU+Bam0TYHp6YbcyiJfFpRqjPj
 PmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733999848; x=1734604648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eKDAxdyLYVzRJ+IHMMFmMA8GyvXThla84fXRo/RTqY8=;
 b=BPOAWZh1Dtic4sQinU/8VRF/zDYpXjEXIW4lv7dIcH3cANiOsUwMWm6qJinYSvFIx4
 Ke4P//U7Y+0RaS7SpB6wLfgWcj+RyZkw5dwEI0U2B8i9fX/m6GAVPui79yxUQnI+oWpJ
 bXhD2Xmu2qaoa1I6/JkMVde95pbfI8rR1QG5IyDvZ0E3sGLX8OLnJ9Y9qlueWqkkGSe/
 +jm00rNCoUhJ75Udd08KzA8WgiKax28VUsIVCo7fS+Tk5/0zBwOxRDL53vNPJ2hsVxOs
 UfBIBKoDj0Aag7jJz11UIj9kavvoDfh2PQ7hmZp4NAnQFgqFe/7daKPbo/t3xGTWv/4a
 Hxqw==
X-Gm-Message-State: AOJu0Yx1mTCAx/hjINEVvPvrXNkxz8DRvYBEuMi7ZYRHZAVgjxrKNGYs
 nhvhseF+USmHZQ1GEs5TbjjPiAVKTB+jILzYMVNBPzdzV32U1Wc6uH8WVQ==
X-Gm-Gg: ASbGncs4nkRH47ZoHC6HOTtxFt3dpbIdoNy1CiSuo5mcVk02RaXQMQC3FIKikeodOlB
 NNn90XCAuF9KhLkhk1r5VN7i0Cm6x/p4QS3PorTusDx/XQz0fuYuQ5Xpjl90DrxdH0IXpKHPMqK
 Hzb34RPtD+XRVdS54RJi7lfCDegYaDEDavbUfY9WgQUqBhpeMv12fJTQpkxVTkm19MSwzJbmeGQ
 UKD5B6EgfwOlMyVyfh9MCxJAQ8wqe7+WaRR37603e/6qtoZ
X-Google-Smtp-Source: AGHT+IG8lNMlozVr0MpKP5IF5Q7iqVJpMzc3TJzepFyDrsUaAG6qavIFipXQV+JEStCetU0sPXH0Iw==
X-Received: by 2002:a17:907:290f:b0:aa6:ab70:4a7d with SMTP id
 a640c23a62f3a-aa6c1d3250cmr295446366b.58.1733999847731; 
 Thu, 12 Dec 2024 02:37:27 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa68770c481sm569415966b.110.2024.12.12.02.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:37:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Thierry Reding <treding@nvidia.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/2] Misc Tegra changes
Date: Thu, 12 Dec 2024 12:37:04 +0200
Message-ID: <20241212103711.7516-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Include changes which are single commits with small changes

- adjust Tegra 2 pinmux parsing logic
- update documentation to reflect current state 

Svyatoslav Ryhel (2):
  pinctrl: tegra20: adjust pin type detection
  doc: board: tegra: update device information

 doc/board/asus/grouper.rst              | 12 ++++++------
 doc/board/asus/transformer_t20.rst      |  6 +++---
 doc/board/asus/transformer_t30.rst      | 13 +++++++------
 doc/board/htc/endeavoru.rst             |  9 ++++-----
 doc/board/lg/x3_t30.rst                 | 20 ++++++++++----------
 doc/board/microsoft/surface-rt.rst      |  4 ++--
 doc/board/wexler/qc750.rst              |  9 ++++-----
 drivers/pinctrl/tegra/pinctrl-tegra20.c |  4 ++--
 8 files changed, 38 insertions(+), 39 deletions(-)

-- 
2.43.0

