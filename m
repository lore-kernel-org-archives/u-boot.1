Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324A8CEACCE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 19:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81E528926A;
	Tue,  1 Oct 2024 21:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UhjZ3lFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 906C68926D; Tue,  1 Oct 2024 21:25:21 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA8089268
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 21:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e263920b6bbso131483276.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727810711; x=1728415511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/l6Zh0QsefqcOl/MHQ++XbVRLtBS3cjVTFUyWLYIXa4=;
 b=UhjZ3lFurB1A80FjAuaSYxOSznRDCktA5arECrx5WHt5v+OpprkoZFKfDc94ZqhQqS
 /49iDlNeoG363Yde7UuBywLUEapbKpSkNuTtkKOQz1RXwHDmThB79jpFIhbi5+jZMLKC
 BTO0QNIUWENvupMnvQmOXp5EcYGH9s3VpBrLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727810711; x=1728415511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/l6Zh0QsefqcOl/MHQ++XbVRLtBS3cjVTFUyWLYIXa4=;
 b=RQvAEEsIHLqK4SA9rgeNap5l4O/2ZJbZWAOOMHGq5V+vb1cnxpG0aeW/FLXQGYQgtt
 Sv9uSXHGq2pueEUIK6wQjy/E50/YpJ+lMhtYOOiUfwVkFUKhOLxBld1ijBk0IekyG895
 7P1c41IQNQ6JaZ5xVGtEPCLVAMqZxrh3hYB56Guzz8O+yJQnQ4u6SMeHxzEhRGRWk3zJ
 sw+2tt5KH+DwwzAvqu0kqJb0/KuV1eTDpgrEp7WagYqruaf1R/PAyVPCOyEcSYQT/bop
 HxyYSALZL7Mw6BmYFHiN038T8mLlTUGAm7d08+zeV0sE/NuslheZcS5YxLypJ19JG3T1
 QSeQ==
X-Gm-Message-State: AOJu0YxsPrVB0g3T3/DD9cqEAY+ZMwBTdCaOBtPqdexuhPb3gauE1ikc
 z+w6Csw1EF/D2HBsWUq4M+4RgfgZItPUmiqdaq9kkoZgI/LTx9q/4KEgD0lTFTWK6jkXDS//3Zu
 fxhw=
X-Google-Smtp-Source: AGHT+IFxECl5E/GXiN3sgx8l+GMXkD7wqBB6HzNXx5NPITkcf7GYKFmwqwjH6GH4O+xNBv3imJADpQ==
X-Received: by 2002:a05:6902:cca:b0:e16:1ebf:293d with SMTP id
 3f1490d57ef6-e26383e7b9cmr721175276.20.1727810711604; 
 Tue, 01 Oct 2024 12:25:11 -0700 (PDT)
Received: from bill-the-cat.. ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66b4fcsm52605486d6.75.2024.10.01.12.25.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 12:25:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/1] Squashed 'dts/upstream/' changes from
 20e0f0897ea2..3347eecf3408
Date: Tue,  1 Oct 2024 13:25:09 -0600
Message-Id: <20241001192509.152745-1-trini@konsulko.com>
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

3347eecf3408 Merge tag 'v6.11-dts-raw'
[snip]
git-subtree-dir: dts/upstream
git-subtree-split: 3347eecf3408998fa7136c8789322cc99646ceab
---
[snip]
 1503 files changed, 78440 insertions(+), 20166 deletions(-)

I have massively editing this down because the relevant information here
is that we are merging to v6.11-dts from the devicetree-rebasing tree.
