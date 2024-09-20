Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73D7CF58F1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F97893C4;
	Fri, 20 Sep 2024 11:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y35IlmZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E16A58933E; Fri, 20 Sep 2024 08:27:08 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1483F88D55
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martinstolpe@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-374b25263a3so1011962f8f.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726813626; x=1727418426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3cvb7b1JgbavkVlSlJ81hEC6OrfKgf2Ogcz+6xK2Yzw=;
 b=Y35IlmZQnvaCyopUMBGD60dLOOp+p1UmLH09wa3K0jYM4Pn4VA3T7TucIIK7uOCbAE
 PWcfI+tGb9XVmry+JmEAKsb8CVtc/eaFLLTbyW3GiSTsxQd8nYBeOov8l+dkHkGQAgkN
 i81w+Kg47G2j7lFvCe1aOMfTXAnODRmqpmeRhwWE8+pVJ7IdWEzSYT53FKVeGfWTQ5ib
 8fNhM+TTJ2SpTOTLQr97LyLLrDTsMubPwvETPdInTUVsFJVM8HsPUd3Mt68hK9I4Mhbk
 WRbHdNHv4uyXNA6mroGz6ya6TQ+gm0rtrdjwluFYqau+S8fEoOw1/jRVoPpCw/r5UWyB
 193g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726813626; x=1727418426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3cvb7b1JgbavkVlSlJ81hEC6OrfKgf2Ogcz+6xK2Yzw=;
 b=oJTrUfiANlrARpdPE6DGp84wSx4bUcMB1vs3E04WO9/pn2Oic0f5M+gOWEcU6GhvAD
 OxeYTm5iNvrW2fk6p5ed+pRicjNpNZJXT5dHmb49dHaFU28/tLWIIvtwneRm3WpmejOf
 SVYbFSEMRys+J4TMgKYSzFcfG0FBwvvFcoLZ4KkVie7/zXsnCa+wUV98z1lBB84Acrgg
 rChKGGKsJZcNf+Cbyl9B4Wt96k/t4G1I1sOaFnFl1o6gI9WOoyXC7mcnuhj5/9sA6cQX
 DBj4sP20uIMZVS4s82QT2xFK+UbjAU5r7m+LPuij/4ZZVRJeWrEoqEcmkdLMvC62Hi2V
 LXNA==
X-Gm-Message-State: AOJu0YxeLnQ+LFYbSqV4NbfW8ysEX9PQWnMfRyT2k3K90297uN4OusCK
 UHUe+BhdianVrRzg8U/sJIxBZeA1m6rVaTRav9W6F09YTu7wVYUIHPVPz3SX
X-Google-Smtp-Source: AGHT+IGRWgEKjiH8CI6AqMZ26r22h0myy+IOhGJQZjxrrn65rrUtiPdb44QjDloa5z1IV/Ykob+VlQ==
X-Received: by 2002:a5d:591b:0:b0:374:c90e:9909 with SMTP id
 ffacd0b85a97d-37a422af062mr815617f8f.28.1726813625986; 
 Thu, 19 Sep 2024 23:27:05 -0700 (PDT)
Received: from NLOOP11.neuroloop.local ([213.164.76.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73f97cbsm16632963f8f.50.2024.09.19.23.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:27:05 -0700 (PDT)
From: Martin Stolpe <martinstolpe@gmail.com>
X-Google-Original-From: Martin Stolpe <martin.stolpe@gmail.com>
To: u-boot@lists.denx.de
Cc: Martin Stolpe <martin.stolpe@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/1] rpi: Fix compilation when CONFIG_VIDEO is disabled
Date: Fri, 20 Sep 2024 08:26:07 +0200
Message-ID: <20240920062611.1046826-1-martin.stolpe@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Sep 2024 11:15:35 +0200
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


This patch will fix a compilation error if CONFIG_VIDEO is set to disabled.


Martin Stolpe (1):
  rpi: Fix build error when CONFIG_VIDEO is disabled for Raspberry Pi

 board/raspberrypi/rpi/rpi.c | 2 +-
 boot/fdt_simplefb.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

