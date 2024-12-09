Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01BBE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16BE88943E;
	Mon,  9 Dec 2024 20:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZQvQTu2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C226893EB; Mon,  9 Dec 2024 20:55:36 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD3C892D9
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a81a0277d3so9954495ab.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733774132; x=1734378932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ei7MkhfUcnkRKSkzooXL6UNGJTX+p/NsFp9I75v7eMc=;
 b=ZQvQTu2NGzmLslSPDOOghC5xVZwhUk5LW8eD7uvD7SpjsFnMzJ4ewgJ6C3j7fXtf0s
 3hc0JoEWTfizqLiVwVhuwMKulAtF6b8QmowsT+nabbqLVTx+7sRdY3kzY94g3noXY1Kc
 OyCoWmdoTAfBiCTc94PIbblMFYLLwSH6+Vt9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733774132; x=1734378932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ei7MkhfUcnkRKSkzooXL6UNGJTX+p/NsFp9I75v7eMc=;
 b=lVyLICSsmxxC+t80ShxqlpWLWp0vnsUgHr5mGm3/+KcDwDWZJth7RHf4/6k9DWxQ2G
 l1S6+n7eVJ3thwQrKpzCuUAIUpbWd54Uwa7j3DHyacMKx1YjhmHeF3o6tvl77AwFVImE
 2Z7wgodmEJ+98ueKjVuMdR0u0nTEUlldE8iVjtQQskR3qRReG0GVunOja4zoanMcNHUX
 mVyKu9FoODzSLS7zHi2vUk7x80i8EoQTeQbZU0H5gUIUej3byokErBVksqv3OnI6AtTA
 x4f73hs7QNUAoRxqmo49prawPRmS/I469Gs2M5sh4ioCtDwjS0emkJZeqlyJE3Hop147
 tdVQ==
X-Gm-Message-State: AOJu0YxOvSQkvJA+fKEcVD9C4ajRXz/wf0pfEku6V8Qu7R9PL1TGcFK5
 W6H2B+UUb6eHXQwhSFAGxc90FWqv7XTJsye9TCd55Uy9L075Q+qaJ2urugleuTCPhy3jovOywxc
 =
X-Gm-Gg: ASbGncsKmLTRZqb79WAi5HgrNHryz0M8brNQjkbxBiFmOwouMQo/8/0eH8088/g6B2L
 8xZEsqwyu5j9JfRysnZcDrGm9WYT+oql7s5FjLtD7qvk8JwWY/hXrx4dsqptZ9Llnolqx6e/gBh
 WBO1FtK8bsCP1zZHmU8toXtAjcN8hnWIcpoyhnT15CWHU9chOGHI3nplXOQCKH/ij0u1Wc8I8v0
 a6wtxyCm4fA1nBy1wbU3JmyXbNgIXqEJaNagq0bACg37MFdNeGGaUJ3VqYoGcRz4WrszAaE6m4n
 yyroJJj/MeWCTC0=
X-Google-Smtp-Source: AGHT+IG0ggOgRoUeF+nzxy2MegWNppe8haADVqmPq1G9K6MDOFHxHZsEyAPyy4cEpfNnDRboR0Alow==
X-Received: by 2002:a92:c54a:0:b0:3a7:8ee6:cd6e with SMTP id
 e9e14a558f8ab-3a811d78242mr159290385ab.8.1733774132068; 
 Mon, 09 Dec 2024 11:55:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e286146f85sm2348941173.74.2024.12.09.11.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:55:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 0/5] rpi: Tidy up booting
Date: Mon,  9 Dec 2024 12:55:22 -0700
Message-Id: <20241209195528.730260-1-sjg@chromium.org>
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

This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
ramdisk, by expanding the available space.

It also tidies up some strange behaviour with the provided FDT, where a
separate pointer is maintained to it, even though U-Boot has copied it
and placed it in its own space. This avoids strange bugs where it
accidentally gets overwritten when loading a file into memory.

The patch to expand the devicetree was dropped, meaning that people
should be careful to unset fdt_addr in the environment.

Changes in v3:
- Add to the existing comment block
- Update the comment block with the new values, including compression

Changes in v2:
- Add new patch to make myself an rpi maintainer
- Add new patch to set bootm_size
- Add new patch to drop fdt_high and initrd_high
- Drop patch to allow expanding the devicetree during relocation

Simon Glass (5):
  rpi: Add myself to the list of maintainers
  rpi: Set bootm_size to 512MB
  rpi: Drop fdt_high and initrd_high
  rpi: Update environment to support booti and large initrd
  rpi: Use the U-Boot control FDT for fdt_addr

 MAINTAINERS                   |  1 +
 board/raspberrypi/rpi/rpi.c   | 20 ++++++++-----------
 board/raspberrypi/rpi/rpi.env | 37 +++++++++++++++++++----------------
 3 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.34.1

