Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990AFC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29CFC88647;
	Fri, 24 May 2024 18:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L9ie0/z2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41DF38866B; Fri, 24 May 2024 18:25:51 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258A888640
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-64ecc2f111dso460678a12.2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716567946; x=1717172746; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bOAQ/nofC37E29elLvdSe/cxZKvf2fTsmrLAPfHtBE0=;
 b=L9ie0/z2nyXgtvhQ6k4Dz+7XepCIhC9MAg59ZS5yilFD7FjbFQZ/N7+6WV98sgMM9M
 1oV2L/YlNne4A72YJg37vTgFmZCtNiyQpS6BRjmDCKdFsgjV+wW4dnoHeg5poUXlPnLK
 tkqxnMeo5kZ5J4kwz9W2nzfpXQjWw9CoKnsaTxCleP4D2if4mK8d7/UlUJ33i+sqsvVj
 bHfhuhluhL0YuE1+lJN/n1toflvOhw5qSAQ4pY38Hku9eVWIc86QeLfYXJ8OrQlxTs+q
 xLMs6sCSe9NzcRcbvKWe7reu813g4ah4tAdElWTlYo1wOOBYWJZKDbleqGkgSvGf3C7o
 HPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567946; x=1717172746;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bOAQ/nofC37E29elLvdSe/cxZKvf2fTsmrLAPfHtBE0=;
 b=mytVQ1Cm2f+R2s0bDkEUWRf3gqzaYYR8waj/+iGmdOhfB/VfIrTZ2AW5cTPZ9/l0ty
 AY1lIYXb1DlFAqeql2NPzt7dRPcHVu4oUEbStPebyJ5f+gy/O/g9ZcF9pqZamDEy2IYZ
 G6EUSnIkqtgJdetGH9k8Lk0zXe9ax9Z5dHCwcM8wQ5mNQ0uZNrtSEHvb4jpMIxsMtAIQ
 CBjK8ExxctOeLEC6clGjfCC3WbZaLod8kLyWYTbColASSylfY8yqKBwod/3eDBfFLUT9
 5iWk86BaFRgOuJMdXEom3nD3j6XaS+Bx95cfl/+jxYoIuCmvfZSbK5TYsx/2Zc3M0Tzr
 eZmw==
X-Gm-Message-State: AOJu0YwKMg/+8DvGg5o/OYdScbLiyRHDxzIQsq0Q3u6roEv51UyF2cD4
 tLQDgqrW9U0l+m1ZSQBbud2nI35NaqTfD2g3O4Ww97QZxNmXtVl2WpFJgU7c
X-Google-Smtp-Source: AGHT+IGQLlNidrwAWP5f+Hk/e8XuzYg1b57WKe3/Ra0jNQLNh25/svoaGNv9FsgxuCMi93cmfilGSw==
X-Received: by 2002:a17:902:d4c8:b0:1f3:10e8:1e0 with SMTP id
 d9443c01a7336-1f4486d301fmr29993385ad.2.1716567946395; 
 Fri, 24 May 2024 09:25:46 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:65e7:ae86:b16e:97f5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9a8db7sm15779005ad.222.2024.05.24.09.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:25:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20240524
Date: Fri, 24 May 2024 13:25:41 -0300
Message-Id: <20240524162541.552282-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit 377e91c162ab09ec20f96f966f380cb55c590edd:

  Merge patch series "Clean-up patch set for MbedTLS integration" (2024-05-22 08:55:35 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20240524

for you to fetch changes up to 7457dc6f183303aaf2d58fff0a622e6791aba33c:

  imx: hab: add documentation about the required keys/certs (2024-05-24 11:33:15 -0300)

u-boot-imx-master-20240524
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/20834

- Allow signing i.MX8M flash.bin via binman, which is a much more elegant
solution that using scripts.
- Improve i.MX8M HAB documentation.
- Increase PHY auto-negotiation timeout to 20s on MX8Menlo
- Add bmode support for the MX53 Menlo board.
- Update Update iMX8MM Menlo board configuration
----------------------------------------------------------------
Claudius Heine (1):
      imx: hab: add documentation about the required keys/certs

Marek Vasut (8):
      binman: Add nxp_imx8mcst etype for i.MX8M flash.bin signing
      ARM: dts: imx: Introduce SPL and FIT labels to i.MX8M DTs binman nodes
      ARM: dts: imx: Wrap i.MX8M binman SPL and FIT nodes in CST node if IMX_HAB enabled
      imx: hab: Use nxp_imx8mcst etype for i.MX8M flash.bin signing
      ARM: imx: Add doc/imx/ to i.MX MAINTAINERS entry
      ARM: imx: Increase PHY auto-negotiation timeout to 20s on MX8Menlo
      ARM: dts: imx8mm: Update iMX8MM Menlo board configuration
      ARM: imx: mx5: Enable BMODE command on MX53 Menlo board

Olaf Mandel (1):
      ARM: imx: mx5: Simplify TFTP server layout on MX53 Menlo board

 .gitignore                                      |   2 +
 MAINTAINERS                                     |   1 +
 Makefile                                        |   2 +-
 arch/arm/dts/imx8mm-u-boot.dtsi                 | 195 ++++++++++++----------
 arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi |   8 +-
 arch/arm/dts/imx8mn-u-boot.dtsi                 | 209 +++++++++++++-----------
 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi           | 124 +++++++-------
 arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi      |  26 ++-
 arch/arm/dts/imx8mp-u-boot.dtsi                 | 172 ++++++++++---------
 arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi      |  10 +-
 arch/arm/dts/imx8mq-u-boot.dtsi                 | 182 ++++++++++++---------
 configs/imx8mm-mx8menlo_defconfig               |  28 +++-
 configs/m53menlo_defconfig                      |   3 +-
 doc/imx/habv4/csf_examples/mx8m/csf.sh          |  92 -----------
 doc/imx/habv4/csf_examples/mx8m/csf_fit.txt     |  30 ----
 doc/imx/habv4/csf_examples/mx8m/csf_spl.txt     |  33 ----
 doc/imx/habv4/guides/mx8m_spl_secure_boot.txt   | 131 ++++++---------
 include/configs/imx8mm-mx8menlo.h               |   3 +
 include/configs/m53menlo.h                      |   2 +-
 tools/binman/btool/cst.py                       |  48 ++++++
 tools/binman/etype/nxp_imx8mcst.py              | 164 +++++++++++++++++++
 21 files changed, 799 insertions(+), 666 deletions(-)
 delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf.sh
 delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
 delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf_spl.txt
 create mode 100644 tools/binman/btool/cst.py
 create mode 100644 tools/binman/etype/nxp_imx8mcst.py
