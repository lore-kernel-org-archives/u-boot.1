Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F126C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 649BE608A3;
	Tue, 28 Jul 2026 13:27:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aanc_6SN3Zq4; Tue, 28 Jul 2026 13:27:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5658C60899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785245260;
	bh=AgTlCmTlQqAG4UEGpPegAYCx58YbNnkcmzshIi5qLeU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sYFFbSSUXUybU0PZ8QjkGh2xaqwoc1kwINqdHK8jDoTEhEfU87WM2a2qoHyY1x0iR
	 MnRdDpgLCBRxRlREQXgYGRZVQeQS5zPpMS8XNwyVDKNfYtpAmWYpcGVQdimrQJ0yua
	 YI/yvoAmcix1kINSrxRXNcMFfZmjWyA3418s7KZJrIc9TLol8S+8TSrWtqwMQUKm9I
	 Tn3ttEpSsp7/eTWI8fLuSeIWMpgvDwvnQoD8ALyd7PE917tmoZm2/637mxVJ3B7gZl
	 fOZ3z/wsJ0Hc3RT622L+cN55Xi5kBuGDIXEKC4OdcwrUTpwMaTQKhtqR44VWam6ZsZ
	 oVSfsk6cig6WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5658C60899;
	Tue, 28 Jul 2026 13:27:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 773C54BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D0494027F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:27:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7cwuAi2HvP1J for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 13:27:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7549E4005A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7549E4005A
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7549E4005A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:27:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B727A43AB5;
 Tue, 28 Jul 2026 13:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1FF1F00A3D;
 Tue, 28 Jul 2026 13:27:35 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Alexey Charkov <alchark@flipper.net>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Jason He <jason.he_1@nxp.com>,
 Marek Vasut <marex@nabladev.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20260728 into main
Date: Tue, 28 Jul 2026 15:27:33 +0200
Message-ID: <87wlufz1kq.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785245256;
 bh=AgTlCmTlQqAG4UEGpPegAYCx58YbNnkcmzshIi5qLeU=;
 h=From:To:Cc:Subject:Date;
 b=BFN/ZKcak4CLSHqKi5YTH/jzWulP/BzgcAwZhIdejCz6TXG7UHSEl0esC8FAOXmNH
 v0bxTdQV8klcTcjYvRVUIR+141p1vxCtcjNOn/uX8AAzygHtMl68TvWPAKnF1HYdVi
 wyZkDSow2qFLXicYSIU5IH1wtfB/6isWFeK7vkN5+8ZlI5KmRYFMy2bu5MyZTycJBU
 zM2j5m06Jiy9YPzBZfYpm4Hr56Y0MkQ5n0YebScv1Bz2jWyBXAeIt8BEXiyxyO8G/N
 5C0hg6/8R2VepzqlJsffrvDXHEQKb3/dTkSZMOLm7tvVRlJ+jCE+pr9oOaXbx+69G2
 YJjynlDOFOlGQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BFN/ZKca
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

Here is a PR for main with the following:

Android:
* avb: Update libavb to AOSP 1.3.0
* avb: Fix memory leak on mmc_part
* bootmeth_android: Fix memory leaks for AvbOps and verify-data
* bootmeth_android: Fix out-of-bounds access in bootconfig parsing

Usb Gadget:
* cmd: ums: Set serial# on iSerial device descriptor
* dwc2: Set maxpacket_limit and endpoint capabilities to prepare for
  udc core migration
* ci_udc: Fix ep type in ep_enable()
* ci_udc: Set usb request status to handle complete callback
* ci_udc: Ensure dtds are inactive before completing request

CI:
* https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/769

Thanks,
Mattijs

The following changes since commit 1b8283bd3220e898d338fb98929f0b06ed63da84:

  cmd: read: fix unsigned overflow bypassing range check (2026-07-21 13:52:50 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20260728

for you to fetch changes up to e6f091a208276db72596c8f7376648856a276d97:

  doc: android: refresh AVB provenance and pin libavb reference (2026-07-27 14:26:32 +0200)

----------------------------------------------------------------
u-boot-dfu-20260728

Android:
* avb: Update libavb to AOSP 1.3.0
* avb: Fix memory leak on mmc_part
* bootmeth_android: Fix memory leaks for AvbOps and verify-data
* bootmeth_android: Fix out-of-bounds access in bootconfig parsing

Usb Gadget:
* cmd: ums: Set serial# on iSerial device descriptor
* dwc2: Set maxpacket_limit and endpoint capabilities to prepare for
  udc core migration
* ci_udc: Fix ep type in ep_enable()
* ci_udc: Set usb request status to handle complete callback
* ci_udc: Ensure dtds are inactive before completing request

----------------------------------------------------------------
Alexey Charkov (1):
      boot: android: fix out-of-bounds access in bootconfig parsing

Igor Opaniuk (4):
      boot: android: fix AvbOps and verify-data leaks in AVB path
      avb: free mmc_part allocated by get_partition()
      libavb: update to AOSP 1.3.0
      doc: android: refresh AVB provenance and pin libavb reference

Jason He (1):
      usb: ci_udc: verify all dtds are inactive before completing request

Marek Vasut (1):
      cmd: ums: Set Device Descriptor iSerial based on serial# env variable

Mattijs Korpershoek (2):
      usb: gadget: dwc2: Use usb_ep_set_maxpacket_limit() for fifo sizes
      usb: gadget: dwc2: Set endpoint capabilities via .caps field

Xu Yang (1):
      usb: ci_udc: set correct ep type in ep_enable()

Ye Li (1):
      usb: ci_udc: Update usb request status

 boot/bootmeth_android.c                     |  37 ++--
 boot/image-android.c                        |  30 ++-
 common/avb_verify.c                         |  29 ++-
 doc/android/avb2.rst                        |   7 +-
 drivers/usb/gadget/ci_udc.c                 |  30 ++-
 drivers/usb/gadget/ci_udc.h                 |   4 +-
 drivers/usb/gadget/dwc2_udc_otg.c           |  26 ++-
 drivers/usb/gadget/f_mass_storage.c         |   8 +
 lib/libavb/avb_chain_partition_descriptor.c |   1 +
 lib/libavb/avb_chain_partition_descriptor.h |  16 +-
 lib/libavb/avb_cmdline.c                    |  42 +---
 lib/libavb/avb_descriptor.c                 |  62 ++++--
 lib/libavb/avb_hashtree_descriptor.h        |   3 +
 lib/libavb/avb_property_descriptor.h        |   8 +-
 lib/libavb/avb_rsa.c                        |   6 +-
 lib/libavb/avb_slot_verify.c                | 313 +++++++++++++++-------------
 lib/libavb/avb_slot_verify.h                |   6 +-
 lib/libavb/avb_util.c                       |  46 +++-
 lib/libavb/avb_util.h                       | 140 +++++++------
 lib/libavb/avb_vbmeta_image.c               |   1 +
 lib/libavb/avb_vbmeta_image.h               |   8 +-
 lib/libavb/avb_version.h                    |   2 +-
 22 files changed, 501 insertions(+), 324 deletions(-)
