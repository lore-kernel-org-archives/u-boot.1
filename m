Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9189C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6F41871FC;
	Sun, 12 Nov 2023 16:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BbNvIEPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 348EF8720A; Sun, 12 Nov 2023 16:28:05 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7226871A1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7a67f447bf0so151393039f.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699802877; x=1700407677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6fMcAhae8hJ8I3K24IM3z3VHA3ZHz95j+23lRMfRewI=;
 b=BbNvIEPRtjwTzb4XAdIVs1PkPfUtV2q8hY/v0e+Owfd4aPSMSeHwKVu1nU2xmEvnee
 qP2VSRnXW+NxFWE8Gdt4Y/oSWhmcMF+Z1h2XDgb70u9djsnPyyDCQG8svSrLOyXoCe0n
 6UYY8vwblHoJfk0XKfGXdI3/PxRUTqfGGGwD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699802877; x=1700407677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6fMcAhae8hJ8I3K24IM3z3VHA3ZHz95j+23lRMfRewI=;
 b=eINf64amZmJmEVYIktciN28h0QTvDsRcpw0uqt1cqTncisndsKx/0voHgZocFGLjDV
 ZBqCS6D7lObcPeKJ3cz5a9xYCjWG8rJ5uqwfUy1UWrbGj6q8SXP7WltzUJi15uk9P6jc
 1uQuU6p+LNxonjCBCy9OASef/v7FAzy4J+5hxpLzP4V1CNtgCjKVJWN+gGUpCIfdZxPN
 t1914arLIX586L+UqZvw/JmO2RbpnSlHcTGeguZK9KuFWaj74jH7HOSNtPRctpkYub/q
 oPjMc39aGf047w1w9aM1EACJtr1jFp70SmVwzjOkUQ2aWY60GC/KMW9dDkSXHgoYVNZ7
 k0FA==
X-Gm-Message-State: AOJu0Yzwn5Q4uxZeMWIAqy+WyQCI+U0G9+bOvwtoRE5D4wqzv9wD4YOP
 3z+NOaRLMqFIxrt8mGRk/yOsZU4MIfjcAkv3Pj6Khg==
X-Google-Smtp-Source: AGHT+IHLXHTxH0bJml2UmTNNVawzQwl7Bct56XYROVrD9ORfSWHF3yBibK/gfD3lnLefIj2H2SCx6A==
X-Received: by 2002:a6b:d013:0:b0:79f:9574:b93c with SMTP id
 x19-20020a6bd013000000b0079f9574b93cmr4492022ioa.0.1699802877318; 
 Sun, 12 Nov 2023 07:27:57 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 76-20020a6b144f000000b0079fdbe2be51sm1226241iou.2.2023.11.12.07.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:27:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Edmond <seanedmond@microsoft.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Andy Fleming <afleming@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dhananjay Phadke <dphadke@linux.microsoft.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>,
 Tobias Waldekranz <tobias@waldekranz.com>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH 0/7] fdt: Move towards using ofnode for devicetree fixups
Date: Sun, 12 Nov 2023 08:27:43 -0700
Message-ID: <20231112152754.130399-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

When large quantities of fixups are needed, using the livetree is more
efficient. In any case, the ofnode API is easier to use and read than
the lower-level libfdt functions.

This series tweaks the DT-fixup implementation a little, so that all of
the non-ofnode fixups happen before the ofnode fixups. This should make
it possible to whittle away at the former.

This series is based on Sean's one here:

 https://patchwork.ozlabs.org/project/uboot/list/?series=380576&state=*



Simon Glass (7):
  boot: Drop size parameter from image_setup_libfdt()
  fdt: Check for a valid fdt in oftree_ensure()
  fdt: Improve the comment for fdt_shrink_to_minimum()
  fdt: ppc: Drop extra size for ramdisk
  boot: Move adding initrd earlier in image_setup_libfdt()
  fdt: Drop the confusing casts in lmb_free()
  fdt: Move ft_verify_fdt() before the final fixups

 arch/mips/lib/bootm.c         |  4 ++--
 boot/fdt_support.c            |  1 -
 boot/image-board.c            |  2 +-
 boot/image-fdt.c              | 27 ++++++++++++---------------
 cmd/bootefi.c                 |  2 +-
 drivers/core/ofnode.c         |  5 +++++
 include/fdt_support.h         | 24 ++++++++++++++++++++++--
 include/image.h               |  3 +--
 lib/efi_loader/efi_dt_fixup.c |  2 +-
 9 files changed, 45 insertions(+), 25 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

