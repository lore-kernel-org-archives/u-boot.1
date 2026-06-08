Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A5BCD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B41684825;
	Mon,  8 Jun 2026 15:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZMcTUBET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B4184154; Mon,  8 Jun 2026 12:34:05 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9059B83EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 12:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DD2DE434CF;
 Mon,  8 Jun 2026 10:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFB6EC4AF0D;
 Mon,  8 Jun 2026 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780914840;
 bh=7fBbCj/9tXFiudNY2vw15eFxlB6lW7s58RlJd1Zt9Jg=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=ZMcTUBETJgss5mcaXGBWUkVDspAgN2Yf6MjnN7N3m3LHAndD1wDSG4gp7RQ/SCyNQ
 mViQGAPYl1aTzL4oHOshY9mp97maIL1rmaXDdwmh4hkRs5CW63Ya6WZYDb4EcaAOba
 d3MOVwPV3HlcJ7JtfSnLE2jEGvWPRL363iKLe3RPfLZiTd9DqUHK3/G3iu8qsCSWw1
 RrRWL03kqVecumjocNwz+kvOYyaHzpUyIIqwKYGpmxZWDiWT9WtxBs7nXz7Hd10ELG
 PMMaCFN7gPl0jmamhsK9aC6WtbA7nJWuj3jKSWpGWzSg4h7B1nNxW9Ud3B/Qom96UP
 QdfzHYXBug5MQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC79CD8C9D;
 Mon,  8 Jun 2026 10:34:00 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Subject: [PATCH v3 0/5] (no cover subject)
Date: Mon, 08 Jun 2026 13:33:24 +0300
Message-Id: <20260608-ufs_tool2-v3-0-a9f181e86229@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHSaJmoC/22NQQqDMBAAvyJ7bkqMEpue/EeRYtJN3aKmJCoV8
 e9N7LXHgWFmg4CeMMA128DjQoHcGKE4ZWC6dnwio0dkEFxILnnFZhvuk3O9YHluilIVUnFTQvT
 fHi19jtat+XGY9QvNlALJ6ChMzq/HbBHJ+9ddBOPMVspaIVudX0w9OE09rng2boBm3/cvw92o6
 bcAAAA=
X-Change-ID: 20260607-ufs_tool2-11c3493690c4
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.Kondratiev@mobileye.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2213;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=7fBbCj/9tXFiudNY2vw15eFxlB6lW7s58RlJd1Zt9Jg=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqJpqPo2gJmhxKDBd6ca+qYarScUGR0WkETSmnn
 tSCY8jrYOuJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiaajwAKCRCfmumUluiO
 OYDkD/4ieZK9+V17TX8rOCF8cjXwuJoLT15PwVCFOxHneZF3qhvfMoWzx0IyKFk+O1h/+LHUEqz
 QRRS+bG2E9YIB9nI9EKFhrNneGGCNFY24Ns2ckP+mdLwc/2wbGt+JBKf/q1TcF1CYazM/378eBv
 sxn3jSrLkz+cgD+Ox/GR5A1HAImttmBA96DYg/KHcKbopApxQTVtTyuGoYGsKOmLRW2fjsgc2vT
 xqiKn9JHa0ZvCQ/vAmLZA2DV+LC4roIvh8SdI4DtDEcKpeFfTwE9n0RGIh9cfeWZoSunMqUPJXE
 HMHE2AFwJC3iU3+rtxqqmY/mkMZtoSN/OlrCEkoE6SGpMX2GVOWWFa7p6UG1jTgrAEzV+vbode6
 qNwqEYhfPWjHXfry5Zm5EgPgfnYP6s3hd43v+kEwP7fLB0PssTs22rBASWTS0D+L5TtLEnLlb0Z
 Q17JzJdf+pxoryodEJkzZkZ78tm5BIyoy6IufiW1afQsiLueG3eVlNFEAXySghdZ49BV6H5LYCc
 VCwm/ZHzROo8jAV5qO6mxesUzYRHBRdz7GpQ7tu1TE2PKVp9+77ibyd+oe085V9O33wgCfQtEO+
 01u7B8CKSGeGLHYnOXrLN2IgymwgBUGo6Mgb4+kvcgOvtT2+SsthXcUxKRoA8TMOcNaktLFuQT3
 SN0RGWoi4z4xVqQ==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:05:23 +0200
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
Reply-To: raz.benyehuda@mobileye.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Changes in v3:
- remove set_dev_desc command. DeviceDescriptor is not writable 
- Beautify the rst document
- Link to v2: https://patch.msgid.link/20260607-ufs_tool2-v2-0-f79ff26ab18c@mobileye.com

ufs: Exted cmd line

The UFS command provides utilities for querying, displaying, and modifying
UFS device configuration and descriptor information. It is commonly used to
configure UFS logical units (LUNs) in U-Boot, allowing storage devices to be
provisioned and reconfigured as needed.

Features:

* Display Device, Geometry, Unit, Configuration, and Power Descriptors
* Display LUN configuration and calculated capacities
* Modify fields in Device, Configuration, and Unit Descriptors
* Query common UFS runtime flags
* Commit configuration changes or clear all LUN configurations
* Decode and format descriptor contents for easier debugging
* Provision and configure UFS logical units

Changes in v2:

* Add HBA ID support
* Move ufs_tool.c to cmd/ufs.c
* Add myself as reviewer
* Rename patch subject to  "ufs: document the UFS command"

To: u-boot@lists.denx.de
Cc:      Neil Armstrong <neil.armstrong@linaro.org>
Cc:      Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc:      Neha Malcom Francis <n-francis@ti.com>
Cc:      Tawfik Bayouk  <tawfik.bayouk@mobileye.com>
Cc:      Vladimir Kondratiev  <vladimir.Kondratiev@mobileye.com>

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
Raz Ben Yehuda (5):
      ufs: Expose selected UFS functions
      ufs: Add flags according
      ufs: extending ufs cmd line
      ufs: document the UFS command
      MAINTAINERS: Add myself to the list of UFS maintainers

 MAINTAINERS              |    3 +
 cmd/Makefile             |    1 +
 cmd/ufs.c                | 1271 +++++++++++++++++++++++++++++++++++++++++++++-
 doc/usage/cmd/ufs.rst    |  202 ++++++++
 drivers/ufs/ufs-uclass.c |   18 +-
 drivers/ufs/ufs.h        |   16 +
 include/ufs.h            |  374 +++++++++++++-
 7 files changed, 1867 insertions(+), 18 deletions(-)
---
base-commit: 0c035ff60c1e8caee7fccd2673ce75380dee825b
change-id: 20260607-ufs_tool2-11c3493690c4

Best regards,
--  
Raz Ben Yehuda <raz.benyehuda@mobileye.com>


