Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AD4CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 13:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12A8783335;
	Wed,  1 Oct 2025 15:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F2zyyfg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B048344E; Wed,  1 Oct 2025 15:18:48 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B1A4800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 15:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b00a9989633so228697466b.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759324726; x=1759929526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rQ5MFWRidAWKhaPtQF5UZk91JN5435L1bpHCxBpYKPE=;
 b=F2zyyfg8lza2lwpB8mz3hA94AX8KcOlIZ3olj6b8Anl1JlJ9OVW8cnO3ZpyQW9lBhT
 oGYxxYXfU7eP0Gts8NrhK3cWmMjrdDskXv8+8OSsBDi8hXD/H5wsANcKTgjN1bAne3Hu
 7FlRLPDt75b6fnLd6i465b7LBPQI3I52OjkcrWAIOj8ZC3Ck2q/aqV89vl0LoSWRYwiA
 Z9eEG+sKsIa6KD2iv7YMFOWk+v8M7ayZcbms+owmXGmv948l476wb6KJlnL4Or3nkSsp
 KIxXG8S0W8iOzh299hD3/UTVEtAFj7qgzgYWKg2Iku8ySNHRU1cZlruL+pXnxkd1tO0L
 6eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759324726; x=1759929526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rQ5MFWRidAWKhaPtQF5UZk91JN5435L1bpHCxBpYKPE=;
 b=MTBler7h7s7a9jXJ784t5aFymdKfR87Ud1eiwEMRv/sO9KKzN3Yje8qAmkt0/1+gUm
 9S+UMCY9xQDVNaXlwDMc4Lz/heDUluUB2T+SabTr89BmIgUOthHyUtCgGsISXjynHiS6
 pI7fU1RUEsPW5MBquwP89hb4t6040wjbzIKX1Kvenu1VhUbA5zoIfn8st4MT9NrwI4Hn
 sOPBjoaZP43uZOXdkNKSp9m/3VFBd0UDhGzeK/bKtRRXTOY0GwAPZ5JPywoskbcAIU9B
 VLIHdljeYJSp5P6tErF2Tgx4dcBTCzTXQLsGMleuMuMv1FreGHVFZhmLrGv+qFzJwpSp
 MlWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx8zyTGou2A6K3p040aNNww0sTS+EBN1pgwOfSQJjWLCg6jRIsiTnYZVH+42gVsUN6Fa0bcKA=@lists.denx.de
X-Gm-Message-State: AOJu0YxgQMrdzd6jMQ6nTOE3Y/u/EUFfF8ixU5+ogkhRofDw8ZD7hfBq
 lZ/8R25PsMelP1DZF3q5uNoCQj8S4XUWhrOfk3TQg6WCtAP3x6jlEtPrKWClKwox
X-Gm-Gg: ASbGnctUfuUrj20Uxg1q2++kvOx8v8CDWK3Aam750t/QL6mBvc99ht3na+ncQkdA+/e
 lJ/WuXHxYFakppF7s1SPDOo1Plx5tQ8v4Cx3p84Cyam79xnOGOU48/9r3jSOBmcVYKTDFgP71Bg
 h2VtwsD4fEfdmqgrz5QIoQxbwrcAotBUO/jc9QC4wsk8AZsuVcwI7cBJhv/Mnm0bm0E947tNMq5
 POVfFHl78EkWVFSeTY0vl5ixTPZVoSMIUpz6UsoX8X/gocoKEurDVVXG0pFkV8D6GD24Ph6wKc/
 UZ2yXgrP81g0H51szdEguSfVp/qTJmFTc5W0cl/oCBeB4gLs0CcqJzJpPSd8ApES3N6HO75uKzJ
 dwqVF6I5r/eCJhI16oW0NTy3STsfrZYPBkXObfxLpHVWqhR953mhZwQ6MRDK6rzIY8UhpRvX/ly
 FK9HuNOYCk9n04P9/hhg/b/ipMS8RFE0es+14cvvaMC+IJYRAY/UA6Vy2yiQoK8g==
X-Google-Smtp-Source: AGHT+IGM6UKVfXzU2i8+OIbRGElQdlGiOGrSyD/snEm850tqZQlq4+/nNDL236zKFNffOVNsGMb24A==
X-Received: by 2002:a17:907:6d24:b0:b2a:47c9:8ff5 with SMTP id
 a640c23a62f3a-b46c43e410cmr524833866b.10.1759324725369; 
 Wed, 01 Oct 2025 06:18:45 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3d27759835sm757006666b.13.2025.10.01.06.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 06:18:44 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/2] configs: verdin-am*: enable USB Gadget OS Descriptors
Date: Wed,  1 Oct 2025 15:18:33 +0200
Message-ID: <20251001131839.1488633-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

USB OS Descriptors are used to install and configure the device without
requiring any user interaction on OS which support them (e.g. Windows).
Enable them in order to improve the user experience when fastboot is used.

Toradex Easy Installer takes advantage of USB OS Descriptors to load 
itself via USB recovery.

Emanuele Ghidoli (2):
  configs: verdin-am62: enable USB Gadget OS Descriptors for fastboot
  configs: verdin-am62p: enable USB Gadget OS Descriptors for fastboot

 configs/verdin-am62_a53_defconfig  | 1 +
 configs/verdin-am62p_a53_defconfig | 1 +
 2 files changed, 2 insertions(+)

-- 
2.43.0

