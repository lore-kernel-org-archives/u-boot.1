Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1C7CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 15:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5947F880CC;
	Wed,  3 Apr 2024 17:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MLgigw6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C27AA8838F; Wed,  3 Apr 2024 17:34:17 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDB6187FDD
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 17:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 10F6B3FB6F
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712158455;
 bh=dZxrK3nGpq9ojuvn1l3u8NkPIvroQ5EAMRA/IGX7HJE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=MLgigw6oZPP3nsrA3c44JVrrgasxLbrs5vSCKOfOFSY1tW3bvoUahcH7S/s9MwjrC
 tXf99ZOQf2zk6/ov2aMehjPdrrPfIcCe3s2xc0jspikfOE0cz9MTTcFQE3+kpCoaFs
 0FZuEloBTvSQGK0LisCjj/0843naf8ZlXeupFcPbqIgGZwY1e7y2bqGUIzHakxMzr0
 6iMx+WUpvthFWleNlHrIrkI/3uPGmeNQPxGa3nOCDwkbVIhq2gQOTHdTyK1e3pCcOD
 9sCr9wriQ1q0WQJmmbzxfwYrcUeghsl+vO9BaB555POg8eypki+jYETrmqEnr7GD/l
 ZwITP094OiW8A==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ed2f873b4so3553095f8f.2
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 08:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712158454; x=1712763254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dZxrK3nGpq9ojuvn1l3u8NkPIvroQ5EAMRA/IGX7HJE=;
 b=pYa1obxc1DgEldjpMLdy01yeBB23LThIOQFVj5FigHFZVIQoO+xEd/Y0Ljb+mOKdxZ
 P0BlAenQbttHstRNILgSdtR/VR4ZzqA3mtIMK+KZhtJyjukNKQnbNbex5wz5PixJJyQz
 MrOpVj76wsDOP2OMDewzK6dn06z4F+Hl1GSQCJU3iSL8vmKxtKMtHAJBuEuHaGbz9FjM
 Fy8xX08T0iJXDdpGVdKpTkHBpQKbJNESsMnEP/umTIlo+p2K096YNNTsrewevNxR9T3D
 bQiPyY7vRukTTPicK6HPOXnSywjOJbTtlvUroCwH7grbyKHaOvHkSWo9KUsPYqU3D8W8
 bnSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPpmw84puSNJaBFPxhRjVKTD30ULX4efccpV8Z60LkXo65eIsh49yDtkJw6ejZxKintClUW43ng6qRCNCNRTsXkS5BRQ==
X-Gm-Message-State: AOJu0YxaBc2iLrzG+hHO3WeT5g/nBeH3dtAOz2cTIe3xb9njL2CwnWKw
 XDf6tEi5q8pt1n8GGLKNSluF07eSXI5GBlZzKapaccVKhYUDUJTRi83Bd10TzbhE1yN4wLNNgcn
 J6Sp5lvpfNGuJ0LUGxo0AC3bXPVQnGkSYfeFHVSop14VMSWQqSyDnL7p8dW5Iuxi7xLc=
X-Received: by 2002:a5d:4a46:0:b0:343:955c:b0f4 with SMTP id
 v6-20020a5d4a46000000b00343955cb0f4mr1527961wrs.0.1712158454437; 
 Wed, 03 Apr 2024 08:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg3admXEIxcj0xWGEvX8/oDgxZn2OFO5bzNW1XgYn+diGWzZMgVgCI20scFHibZCbsIxkQ5A==
X-Received: by 2002:a5d:4a46:0:b0:343:955c:b0f4 with SMTP id
 v6-20020a5d4a46000000b00343955cb0f4mr1527945wrs.0.1712158454068; 
 Wed, 03 Apr 2024 08:34:14 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 cs2-20020a056000088200b003418016b04csm17585710wrb.76.2024.04.03.08.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 08:34:13 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] efi_loader: fixes for EFI variables
Date: Wed,  3 Apr 2024 17:33:32 +0200
Message-ID: <20240403153335.96971-1-heinrich.schuchardt@canonical.com>
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

GetVariable() and SetVariable() use an uint32_t value for attributes.
The UEFI specification defines the related constants as 32bit.

Add the missing EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS constant.

We don't yet support EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS for file
based variables, but we should pass it to TEE based variable stores.

Heinrich Schuchardt (3):
  efi_loader: all variable attributes are 32bit
  efi_loader: EFI_VARIABLE_READ_ONLY should be 32bit
  efi_loader: handle EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS

 include/efi.h                   | 18 ++++++++++--------
 include/efi_variable.h          |  2 +-
 lib/efi_loader/efi_var_common.c |  2 +-
 lib/efi_loader/efi_variable.c   | 16 ++++++++++------
 4 files changed, 22 insertions(+), 16 deletions(-)

-- 
2.43.0

