Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BA8CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4553E848E2;
	Wed, 17 Jun 2026 14:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iCvuAsT0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33AB68491C; Wed, 17 Jun 2026 11:26:35 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB4C6838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 11:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9612460121;
 Wed, 17 Jun 2026 09:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A81EC2BCC7;
 Wed, 17 Jun 2026 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781688391;
 bh=n7imxsJ48h5XwII+Zs5b3opfXpHbUYLzmBcsuNUX748=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=iCvuAsT0Gg3GpsGfg/izgIjaRxpQLOhViaelskJam6JTq/TgR9SEergTvTSS60IHH
 WU0gll+ZdMLY4X7g3T/MWi02s6kOQcWxQfzXkgXxW5JLPNCDV6gdZgEY0/zSW+Q3je
 afIteeqwNIw88SSSBtbToOVZ4c4PdMqRO90opBmMAbPYZsUp5r21JarPU6U0ptfeh3
 bLn1RL4k+jJGeWJ0KrTzmBJpF4f92pJQAoaWb8dlq82KEOK5F7sfttJk+M95yn211y
 piNXSY+T8L/LvMtAFr9E9BPJYF1dbIKVWBd7qBWiwLlm2O7FE8+K1R1/n3cXvZGNeo
 82tW+En4qDk3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2D858CD98E4;
 Wed, 17 Jun 2026 09:26:31 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Subject: [PATCH v5 0/5] Changes in v5:
Date: Wed, 17 Jun 2026 12:26:12 +0300
Message-Id: <20260617-ufs_tool2-v5-0-1cf099f71111@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADVoMmoC/23NQQ6CMBQE0KuYrq1pP7W0rryHMQbKr9QANRSIh
 HB3KW6IYTnJvJmJBGwdBnI5TKTFwQXnmyWcjwdiyqx5InXFkgkwkEyylPY2PDrvK6Ccm0ToRGp
 mBFn67xat+6xbt/svhz5/oeniQGyULnS+HdezAWJvb3cAyqhNtbUgs5wrc6197ioc8WR8TeL0k
 Gyx2uJkwZm2XHFUEkDvYLHBnG+xiFgUmKrcgGD/eJ7nL5T8kqoxAQAA
X-Change-ID: 20260607-ufs_tool2-11c3493690c4
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.Kondratiev@mobileye.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3793;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=n7imxsJ48h5XwII+Zs5b3opfXpHbUYLzmBcsuNUX748=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqMmg9zlEw9fg3poIZz98qVoPdNQlqARrk1/AHv
 uPA3QfHF6GJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCajJoPQAKCRCfmumUluiO
 OTcyD/9NJ3uI6KJ6JKtkgLTfmuzi5jvcjpheLJj4XAJ9Y/NK459Lb7JX1jVAJW/T2/LzdEsCXWs
 666iwEMuS+AWNqPNj+Yb8etf1NiNb6dnH2puKBK1JiBiS3fJsyiuOvJIXghYVXLtrmRcyR2Gi2F
 ZuUC7YOBDJyzOzi39bG4hR948k7TIjUaDmFjchFwjgkdEWkWn+O6tOyeVQdS4pN6XHgvWpnQ6ij
 72cSqRVeL41xRV/vCB/g38kZ2W7vJEti2e9DTnYxMwVc0kPUVTHGFrTwyD4d4FvR6pTFLsRcksw
 zX231gUu5LbgI/u1DcoPRZl3uN6fimsCbeHqox4Nij+5SNWbhL2g8/7s1JUtrTLTJ5iBVAeQKS7
 U6LXmxWMKa0VuPgKydHFORn8yhvjk12TSh7q7cT289Q9VLJ8qjW4ipRDi6/jl44lBxmTdHH7xna
 LRiQgpd0JbOATX49A2VNZiXTdOgN9QQF6CFCxm6LmYpT0mVpidWuwEB6yMi+cDiF1DAs/0ZuWWB
 8RIOxE9C/ScaZ8alWXY0R6Ww9XG3FfdoK8rAJ7pplde6U+x0PzTtUcl4PJb736RIVr2hQXIQf+S
 1lpX8ck1fUYypK6y26lsuGzy0m7IvtLrZ5dfYWlr4x7ZUccwRk5poDVfn2EmptyvYFD/7p3acL6
 WukpRqev4VYfUmg==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:29:55 +0200
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

According to Tom's remarks
- Improve the help structure and content.
- Mark functions as static.
- Remove documentation of exported functions 
- As asked, addded a kernel doc to:
   ufshcd_query_desc_idn_geometry, ufshcd_query_desc_idn_config,
   ufshcd_query_desc_idn_device, ufshcd_query_desc_idn_unit,
   ufshcd_print_idn_geometry_desc, ufshcd_print_device_descriptor
   ufshcd_print_unit_descriptor, ufshcd_query_desc_idn_power
   ufshcd_print_ufs_power_params, ufshcd_query_user_flag
- Add command get_lun
- Add command clear_lun
- Add command provision
- Removed float use in the code, it breaks arm compilation.
- Add wmb. wmb is not implemented in x86, brakes the UFS compilation in
  x86.
- Test: ./tools/buildman/buildman mips64el arm x86_64 -a UFS -a CMD_UFS -a SCSI -a CMDLINE
	Passed 94 boards, but consumed too much time and could not continue.
- I stil fail to run on gitab ci, My adminitratos do not know how to
  help me, i have no runners.
- github does not work as well, no runners. I do not have Azure acount.

- Link to v4: https://patch.msgid.link/20260611-ufs_tool2-v4-0-a4de78bc2409@mobileye.com

Changes in v4:
Apply Tom's remarks.
- move exported functions from drivers/ufs/ufs.h to include/ufs.h
- document the above exported functions in kernel-doc style.
- Fix commit title: "extend the current command line..."
- rework rst file, verified the html version.
- Run pull request in CI. 

- Link to v3: https://patch.msgid.link/20260608-ufs_tool2-v3-0-a9f181e86229@mobileye.com

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
      MAINTAINERS: Add myself to the list of UFS maintainers
      ufs: Expose selected UFS functions
      ufs: document the UFS command
      ufs: extend the current command-line interface
      ufs: wmb is not implemented in x86.

 MAINTAINERS               |    3 +
 arch/x86/include/asm/io.h |    2 +
 cmd/ufs.c                 | 1612 ++++++++++++++++++++++++++++++++++++++++++++-
 doc/usage/cmd/ufs.rst     |  499 ++++++++++++++
 drivers/ufs/ufs-uclass.c  |   18 +-
 drivers/ufs/ufs.h         |   52 --
 include/ufs.h             |  421 ++++++++++++
 7 files changed, 2536 insertions(+), 71 deletions(-)
---
base-commit: 0c035ff60c1e8caee7fccd2673ce75380dee825b
change-id: 20260607-ufs_tool2-11c3493690c4

Best regards,
--  
Raz Ben Yehuda <raz.benyehuda@mobileye.com>


