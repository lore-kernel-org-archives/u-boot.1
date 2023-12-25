Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DCFC3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 04:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC12877CB;
	Mon, 25 Dec 2023 05:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BOMMQCVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D6A871DA; Mon, 25 Dec 2023 05:45:43 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA49A871DA
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 05:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6dbf0561f8bso53437a34.1
 for <u-boot@lists.denx.de>; Sun, 24 Dec 2023 20:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703479538; x=1704084338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a134M/rre9VCF78Vqldrr5aEUusobu/LupyefrNgbow=;
 b=BOMMQCVGDTr3l+KTj7tUUFWSCxRuLTV8hoxzQsoAy2PJeRrVLJentVbFBtiGcApFTj
 HWT7Rn4fEbcEyx6rC+/Q79IMREylQZDuAUIrUrBXy9rky1kTah+R4kl4Z3hMfq4+/FMQ
 A4QxmZSQZv+FwCBfH/ts/oytea4Vommt20Vpy7uMdmPKjyaAFWsbpH8vRBLL5sXxpg+f
 CWwKpdHm2ZhAq5gAFC1+wydMcBUEFpGj6S3AmpIpQ8oVDfcK8bpJJ7DUsTktoflNLLNv
 k9x7gH83A57J/bEg05zoKPR3lFtDPMDCxzAiEX53nJQONVEdMzAErVQ9SDmwc0BGiXi5
 ztcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703479538; x=1704084338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a134M/rre9VCF78Vqldrr5aEUusobu/LupyefrNgbow=;
 b=fEH5odmgvWBF3tGhXp/nZaYM4ppm5OcsbOUHUP+h8HNvrJ9xIZf1LXIWtiVHTpxCKv
 UbqQ1o9jMWzaETRTIc2P0xMAuQ4mNV40IG+52Bq+ZSbZolDjrRZZkRkU/aARRpM3dNoU
 bYrTCMv3A1DoRhfcwC+PJB4pR7dnhDe9Cwr58rdSiWUpKeoJmucxdY7OLwfmpElmjlxJ
 wHo/V1yIAuj7Z7ropRHh+MPkLZpDyLccAIF2ZgjIniGg51c8PmwPCpY55mYhcBTIIUi1
 3UThhio4xUzSCwaJYTVgIWWaIcb885pKGdikPGaxfeMZUT9RJmS/qmO0jW2Ojw7IOe6W
 oksg==
X-Gm-Message-State: AOJu0YyaB11wOUfbIRtxJ2MUftInbVzzVpBFPl1Sb5tuaqRYrzLKwwxb
 Q+OtF9nY6g1i3RX+Wez8BRdcQZ3voX/KPQYoPtLmmjmnzgQ=
X-Google-Smtp-Source: AGHT+IENT5Yq3IwnY0Yh5sPV8Y4tqQD2IvldFNGxCr3PhLNOAUdobZimnIdJsr+qxMP7oUZhSLRueA==
X-Received: by 2002:a05:6808:1288:b0:3ba:9d:9b54 with SMTP id
 a8-20020a056808128800b003ba009d9b54mr6748632oiw.14.1703479538804; 
 Sun, 24 Dec 2023 20:45:38 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 x13-20020a056a000bcd00b006d9c0dd1b26sm218370pfu.15.2023.12.24.20.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 20:45:38 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 0/3] fix and refactoring of efi_disk.c
Date: Mon, 25 Dec 2023 13:43:53 +0900
Message-Id: <20231225044356.626900-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This series fixes the memory leak issue in lib/efi_loader/efi_disk.c
and removes the unused members in struct efi_disk_obj.

Masahisa Kojima (3):
  efi_loader: remove unused members from struct efi_disk_obj
  efi_loader: avoid pointer access after calling efi_delete_handle
  efi_loader: create common function to free struct efi_disk_obj

 lib/efi_loader/efi_disk.c | 50 ++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 22 deletions(-)

-- 
2.34.1

