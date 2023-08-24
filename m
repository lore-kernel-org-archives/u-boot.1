Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A89C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81F5F8653D;
	Thu, 24 Aug 2023 05:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oC91obQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9309486543; Thu, 24 Aug 2023 05:03:24 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30B9D86537
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34ca1aadce9so15071025ab.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692846200; x=1693451000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0TaNjr1wGiZnLNvnl6HUfz8BPmbHk1j3DsY8RftT8y0=;
 b=oC91obQM4rtPBj4XhY0KAMz/72aKsIwkhq2K1kWjHhjAzCS3uQ3ZvxH2XeuCICKFdL
 HlK8JJtR66t/0tgLEq+CrtrioKieyINLNkAKDX/4QL8MbLNr28ykRvDs+x5EMo7ri7Yw
 7JrBcZ2e+rnxw6+snZZmQ7DPxdAzAvjD+qO6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692846200; x=1693451000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0TaNjr1wGiZnLNvnl6HUfz8BPmbHk1j3DsY8RftT8y0=;
 b=LFtu2Y7LmObW2KCujTCKhEciwhrZJcpJJePpJbv3A2vtdmY6VoSIHnMCM+DWaIkVoM
 fWj5dguhsFMwh4yz6wC6Lsp/5qkv9uCDiOfP4Ko7OGDnchgFC1hbkn1FKS/gB2NaiLeh
 sa2h5nFXiAw1y03TtGkb3msnA3lHJZNp92AJPPVYwoRW0Awfnu36w9CYvSbHKGRfCSiR
 kVBf3iulrXFndw27iAvXHkgM9qKBvC6kL2AXga4PHNeFvtO/FPF729Xx8DFzG/qqmcLJ
 0k9nySksHQZdlAy114hfCYSxDTssAo3rcByWlFlt5xXkQYSBP351CFZnCxbPUfMh3mxd
 2KFQ==
X-Gm-Message-State: AOJu0YxEwf5Kn2ouwo2vLMwYrYhzj5UsxDbswefn/X2sTVEFHrwsrKCo
 shA3/MBuo/44lNEq7nFDFfh2rm5MTfYRgxKvQBw=
X-Google-Smtp-Source: AGHT+IHalleRke17z3NHQzBiJyQ8WEfQmejlVxy5wHxJXaX7Eo4fsCNy5BGT4fbBwkRtFZef6FrQWw==
X-Received: by 2002:a05:6e02:11ad:b0:349:2bb0:c87d with SMTP id
 13-20020a056e0211ad00b003492bb0c87dmr3706852ilj.32.1692846199597; 
 Wed, 23 Aug 2023 20:03:19 -0700 (PDT)
Received: from localhost.localdomain (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 u4-20020a92ccc4000000b00345fcbce508sm4274117ilq.39.2023.08.23.20.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 20:03:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dillon Min <dillon.minfei@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kamil Lulko <kamil.lulko@gmail.com>,
 Marek Vasut <marex@denx.de>, Michael Walle <michael@walle.cc>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/6] Attempt to enforce standard extensions for build output
Date: Wed, 23 Aug 2023 21:02:53 -0600
Message-ID: <20230824030304.1555547-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

In this early stage of using binman to produce output files, we are mostly
seeing people using common extensions such as '.bin' and '.rom'

But unusual extensions appear in some places.

We would like 'buildman -k' to keep the build outputs, but this is hard if
there is no consistency as to the extension used.

This series adjusts binman to enforce just 4 extensions for output images:

   .bin
   .rom
   .itb
   .img

Other extensions will produce an error. With this rule observed, buildman
can keep the required files.

Some patches are included to fix up some easy problems. But the following
boards generate 'custMpk.pem' and it is not clear how to fix this, so I am
asking for help from the maintainers:

   am62ax_evm_r5 am62x_evm_r5 am64x_evm_r5 am65x_evm_r5
   am65x_evm_r5_usbdfu am65x_evm_r5_usbmsc am65x_hs_evm_r5
   j7200_evm_r5 j721e_evm_r5 j721s2_evm_r5 verdin-am62_r5
   am62ax_evm_a53 am62x_evm_a53 am64x_evm_a53 am65x_evm_a53
   am65x_hs_evm_a53 j7200_evm_a72 j721e_evm_a72 j721s2_evm_a72
   verdin-am62_a53

It looks like the .pem files are listed as top-level images, e.g.:

   &custmpk_pem {
      filename = "../../ti/keys/custMpk.pem";
   };

but if the only objective is to pick up an existing file, it is better to
set BINMAN_INDIRS to include that directory. Also we should only have
simple leafnames in the 'filename' property, so the '../../ti/keys' is not
correct. It makes it harder for people to get the files from other places.
Making this easier is one of binman's goals.

Most likely the custmpk_pem node can be removed and the .pem file can be
included directly in the place that needs it, e.g. by adjusting the
ti-secure-rom etype (or ex509_cert) to use tools.get_input_filename() when
reading the key file.

For example, this:

   custMpk {
      filename = "custMpk.pem";
      custmpk_pem: blob-ext {
         filename = "../keys/custMpk.pem";
      };
   };

is really just copying a file from '../keys/custMpk.pem' to 'custMpk.pem'
so is equivalent to:

   custMpk {
      type = "blob";
      filename = "custMpk.pem";
   }

(note that blob-ext implies that the blob may be missing, so blob is a
better choice, since the key cannot be missing)

The fact that the .pem files are at the top level means that they are
output images, which surely is not intended. They should be buried in the
image description, at a lower level, as part of something else.

So please take a loke at the above and see if the binman descriptions can
be reworked slightly to follow these new rules.


Simon Glass (6):
  binman: Require image filenames to have certain extensions
  buildman: Keep all permitted output files
  buildman: Show progress when regenerating the board.cfg file
  buildman: Start the clock when the build starts
  kontron_sl28: Use u-boot-update.bin instead of u-boot.update
  stm32mp15: Use u-boot-spl-stm32.bin instead of u-boot-spl.stm32

 .../dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi   |  2 +-
 arch/arm/dts/stm32mp15-u-boot.dtsi             |  2 +-
 doc/board/kontron/sl28.rst                     |  4 ++--
 doc/board/st/stm32mp1.rst                      | 18 +++++++++---------
 include/configs/stm32mp15_dh_dhsom.h           |  2 +-
 tools/binman/binman.rst                        |  5 +++++
 tools/binman/etype/section.py                  |  3 +--
 tools/binman/ftest.py                          | 12 ++++++++++--
 tools/binman/image.py                          |  9 +++++++++
 tools/binman/test/022_image_name.dts           |  4 ++--
 tools/binman/test/311_bad_image_name.dts       | 17 +++++++++++++++++
 tools/buildman/boards.py                       | 15 ++++++++++++---
 tools/buildman/builder.py                      |  3 ++-
 tools/buildman/builderthread.py                | 11 +++++++----
 tools/buildman/control.py                      |  3 ++-
 15 files changed, 81 insertions(+), 29 deletions(-)
 create mode 100644 tools/binman/test/311_bad_image_name.dts

-- 
2.42.0.rc1.204.g551eb34607-goog

