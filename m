Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983A2C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 18:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0D85849F0;
	Thu,  2 Jul 2026 20:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="YJB71A2n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 327E584A04; Thu,  2 Jul 2026 20:27:45 +0200 (CEST)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [84.16.66.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99C34848F3
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 20:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4grljp0P6GzxTJ;
 Thu,  2 Jul 2026 20:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783016861;
 bh=Ub5W7GhACldzcNnUTfob+Os4SqixXQLi7GXVjRtKMyk=;
 h=From:Subject:Date:To:Cc:From;
 b=YJB71A2nxAdlLBdr9pUd5KhOwEs5tmQLBTBV12I1T4jfLB/uNZSkkhD9YcLBK5EaT
 M7npqCsg55FvjTTi33AK7nwSgomWBE8dmjrpqBmIt4jwGzFyH0dOPlv12JF4wVuajV
 0TJ+/boxwPQnjk4i/wgyyhFhaou8ODQaPVgyXtS46XnsnIzLtV46MmajrQWjUmc36g
 P6lIh4HDAZOVa+9ajmtanFUlfxGu5WllcjNBtfA7QSW4mvL702icfCWW8dCt1M5rCM
 adTFGsZgZJZ2f63E5AvsyLSWbLXL2cppz0NUVIJPhCVkBL0Ol55nnrBQk21LiRyHr6
 99p53DPA9D8sg==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4grljm2VpVzxwg; Thu,  2 Jul 2026 20:27:40 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/6] drivers: sysreset: revert support for args
Date: Thu, 02 Jul 2026 20:27:30 +0200
Message-Id: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vche7ZJaagVXsV4KDiF9YBktxgN4
 d2pevySmX8jhTCUumojwYuVn3NBfapomOI8wvC9mJx1ZxusM2UEyUY/KlBk0/jQRjT+khyovBZ
 B4veveL39rWv/wJC/Gdr3AwsIwyZzAAAA
X-Change-ID: 20260702-revert-sysreset-4579ae458f2e
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

The args support for the sysreset uclass contains a logic bug. The first
sysreset device implementing the request_arg callback will consume the
args, not support the specified arg and thus return -EPROTONOSUPPORT
which will stop the iteration over all sysreset devices.

This is an issue if one has multiple sysreset devices and each with
support for different (valid) args. If a sysreset device implements a
-dummy argument and another -foo and one calls reset -dummy on the
U-Boot CLI, it'll depend on which sysreset device will be attempted
first. If it is the one implementing -foo, it'll return it doesn't
support the argument with -EPROTONOSUPPORT in which case the device
implementing -dummy will never be attempted and instead we'll do a cold
reset which is very likely not what's expected.

I suggest to either add an additional return code for the case where the
sysreset device knows it isn't supposed to handle this argument because
it isn't among the ones it supports, and thus we try other sysreset
devices until we find one that says it tried and either is in progress
or couldn't realize the request, or no sysreset device supports this
argument and we end up doing a cold reset (but should we even try to do
a cold reset if the type of reset requested by the user isn't
supported?). Or just don't try piggy-backing on the reset command and
have a new command instead?

Maybe I misunderstood something or misread the code, so please correct
me if I'm wrong.

We've tried bringing up this issue multiple times over the last
month[1][2][3] but it seems like we're left on read. This is the last
resort to get attention on this patches, hopefully we don't have to get
through a revert a few days before the release though there is only two
working days left before the release. Sending a revert as requested by
Tom[4].

I've not even build tested this, only had a cursory look at what to
revert so maybe I'm missing some patches or breaking stuff up. It's late
here and I wanted to give a chance to people in Americas to have a look
at this today, or people in Asia tomorrow morning before I come to the
office. I don't have time to wait for the CI to complete, but it's
running here: https://source.denx.de/u-boot/contributors/qschulz/u-boot/-/pipelines/30604
Yes the commit hash is different, I rewrote this cover letter to include
the link to the CI pipeline.

[1] https://lore.kernel.org/all/667ec81b-da7f-4b10-b1ae-45e578cd9d54@cherry.de/
[2] https://lore.kernel.org/all/4fc15188-3de9-4345-85e9-d594efe9bdd5@cherry.de/
[3] https://lore.kernel.org/all/20260623165021.GJ382693@bill-the-cat/
[4] https://lore.kernel.org/all/20260702174613.GC749385@bill-the-cat/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (6):
      Revert "qcom_defconfig: enable psci based sysreset"
      Revert "cmd: boot: fix edl being shown when not supported"
      Revert "doc: usage: cmd: reset: specify when the -edl option is available"
      Revert "cmd: boot: Add '-edl' option to reset command documentation"
      Revert "sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs"
      Revert "drivers: sysreset: Add sysreset op that can take arguments"

 cmd/boot.c                            |  6 -----
 configs/qcom_defconfig                |  2 --
 doc/usage/cmd/reset.rst               | 10 +-------
 drivers/firmware/psci.c               |  4 ----
 drivers/sysreset/Kconfig              | 15 ------------
 drivers/sysreset/Makefile             |  1 -
 drivers/sysreset/sysreset-uclass.c    | 37 ----------------------------
 drivers/sysreset/sysreset_qcom-psci.c | 45 -----------------------------------
 include/sysreset.h                    | 18 --------------
 9 files changed, 1 insertion(+), 137 deletions(-)
---
base-commit: f605dcee103c897b6f1a8873549a36949bd4e2a1
change-id: 20260702-revert-sysreset-4579ae458f2e

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

