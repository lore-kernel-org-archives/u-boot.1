Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B85F41807
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8945A83F14;
	Mon,  9 Mar 2026 16:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NY8r4wD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56BEB83BC7; Mon,  9 Mar 2026 16:13:23 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE3583A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-50902b1006cso17722291cf.3
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773069196; x=1773673996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HnqVX58OrrM4/U8Z7Ben+ExMjxZh0pszMCrUOmdovgQ=;
 b=NY8r4wD6erfK2QCXJPHbb/NSxef3QyQZWKrFrp++rxDpWLv/dha31LES4W0N9evFgZ
 K9RM/E9ZeklBcSxhc9v1sZC25Tq0xDURp4ZGjO7I3pms7tZE1nKv30WteKqqzFxZZXyw
 8Z1U4/O+wupJXhykGsd8K0dOdsCSzL0dKhXK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069196; x=1773673996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnqVX58OrrM4/U8Z7Ben+ExMjxZh0pszMCrUOmdovgQ=;
 b=OatW8cY5rXYbbxpw8Cp3q+JCi9RclSyP5XsbqBNLv2r3rTVWjhqVDDT1LEeyoRDdBk
 rzj28KjtZbzSIi0j3sxAYvo8BDR9zpaSBs/cuM3N8rC2Krt69nMHUFRUUkfTxwlgmjSm
 Kf2ZryjzqRPjrsQ4lqA3n4PW43iDTcciQhPudEqStXqik1NBn6cSzbVibUvgoF7TZT1h
 uap1PABDNo0PQdKeMO36hAYpYzfQg/VSzdJDjQc7+b1Vs0JpOU78cw1K6m0hyRDe2Su6
 iJP1MgwoJOqX0U0Zay19Ji0mmOB/gM96VfkiICNAnWQvK9T/r7X/mbiNAG7ummZArTpL
 tk4g==
X-Gm-Message-State: AOJu0YxHCBCbSP8F5UzuYvQuaNLMdxRXF3GeWT+SZapTrhdaHAqO3Px7
 96UgWUy2I9Z1K4T0U3izzpZDNe++9/wa635IQ9ottFE9wiTwL7fXj/ecp9yeNoyuw4DuscfNo8J
 01WI=
X-Gm-Gg: ATEYQzz9FIyohmOKizpGauGdx5o+dNjlv/F9BN7IOhTF3wb+fJNiNBygdNL0814TiVp
 G6P124l23adnOhkvtjuE/4dHZPOX5tnBurnzIMFz/PVp/B3rt4tBCMTdFO0h0WrmmrQK6/Pu7Qe
 P3KlTjbdXLnPAQO0ErTfkAGLic/PpKr/dW7j6VkXNZM7n6Jk2vozK1Dmf2ssPlGSIRduHhxOihw
 TOlBLa0mTAIEPA7EyEvdi5Fdl0TR4NGQSjuvbDsKqMoToaBkIxygG4hioLYixvHKG8ymCenFn81
 Nysl0xs76ynpBtFr5qjjFk3AcEHONCniEfwtm0RAcHdVysFQ5yVYSvC4Lvt22GV8S7Pz17xGNt4
 DNC7zfgNu9P3T2pJaB4Y4PdnXpR1h7xGFTOzQazpr6Ciwhwm4evCsm/LPTxB5Wi1VWoBk18C4I/
 8wJV518g1K6NGp8YLB/g==
X-Received: by 2002:ac8:7d84:0:b0:4ee:280:2e49 with SMTP id
 d75a77b69052e-508f496ea91mr147855401cf.66.1773069196462; 
 Mon, 09 Mar 2026 08:13:16 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5091a7dec85sm19337291cf.32.2026.03.09.08.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:13:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v4 0/5] Provide a class for building filesystem images
Date: Mon,  9 Mar 2026 09:12:59 -0600
Message-ID: <20260309151307.831537-1-sjg@chromium.org>
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

Create a class around mk_fs() to handle the common tasks of image
creation, such as managing scratch directories and cleaning up.

Start with a few small cleanups to mk_fs(), then convert the helper
to use a class.

Changes in v4:
- Use an explicit list for fs_type validation
- Drop 'test: Add a helper class to create disk images'
- Drop 'test: Convert test_efi_bootmgr to use FsHelper'

Changes in v3:
- Rewrite the commit message as suggested by Tom Rini
- Make the class a thin wrapper that delegates to mk_fs()

Changes in v2:
- Split the quiet flag into a separate commit
- Fix fs_img to accept only a leaf name, always under persistent_data_dir
- Add new patch to split the quiet flag out of the previous patch
- Split the pylint fix into a separate commit

Simon Glass (5):
  test: fs_helper: Allow passing the image filename
  test: fs_helper: Add a quiet flag to mk_fs()
  test: Update comment for fs_helper.setup_image()
  test: fs_helper: Drop the size_gran argument
  test: Convert fs_helper to use a class

 test/py/tests/fs_helper.py | 111 ++++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 8 deletions(-)

-- 
2.43.0

base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
branch: testfs4
