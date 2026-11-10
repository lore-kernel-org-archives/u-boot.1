Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE760798B3
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qi4lwuE6;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hygCL5vZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 786F88136A;
	Tue, 10 Nov 2026 13:30:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vW05Wk4YZNJU; Tue, 10 Nov 2026 13:30:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 70FE581361
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794317406;
	b=ZB3KFKaEUmF6OM0rSwyLtjdBtqmQaA1XnNwU7xXS/dWCQOCLECb1l4p95h+JqAu3z04L
	 //vnORuOKLA5QNpWk8uNJjNz0qb3gJeci3evDvNLbWt1X3VdHqddfBq2KM3obi5QzeFL9
	 MbNok4L4gs2IxY+MAReinwCx3aCuGetWUGGpb+e2noMkCGBs86TCWUtVbyi/T7qofF1rw
	 HxJdSFSo/ITKfukGIVtQt2PBMbor16IYSvHyQC0jA4Ju3B+oZeS1/W3zCHg5MgA94xQ1/
	 L2ugAVOU5fD7S8XzjjQdmftKz0zJbUH+l/OYXmKkxMRBGzm4sz7ZemKlt+0yciw2MUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794317406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RvkCuNSz8YDS0uvCYbQ+A0Zr6d+WAF+DhlId5/3OqfM=;
	b=kqSsQz1v3XpPCHDYH8TXdNO09YhSnooxS3JQx38Fh7IVbFZrzY5eVsPsxGAWrYebliDx
	 oUUaLKC7zg36iuOHWr/dUhlS1oN1hLzdIlLgiS/RNeb8V75XMnt02xYfFJ3RgGkDMdshY
	 Hz8bKNvVTaL4po8Nmx9Yr5hhAiFhCjAL+Zj5YAnXvfobEikPHMY0EfuZ5/EWb8iVCAsWB
	 0HpbP9wMCG5W1LIJC6YuCF1ATWVamIbiRhHBJ9mGRKgm9vFMtv21ViWn/3lO668KnBVPN
	 T8dq7M6rrW7OiCA2fDqi6aaltm1aXS0Hc90OaSxIHIbUvh1DRZqTWboJOJAtFpj1qjQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794317406;
	bh=RvkCuNSz8YDS0uvCYbQ+A0Zr6d+WAF+DhlId5/3OqfM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qi4lwuE6fTmHMF6EVztr7GTFGQ5GLmMSYfLNWTzGT7Y3IaY9ZJ+M+NomJY1+6YNeq
	 LEBCnOxwhcfGvtGXTeK9BuFkwomRSkzumz9cBav06LI6sBxWsHXIeW/ad9uDiZG47g
	 2y+mcLzt1K1wW1mHrm5ptLXcEk/ZYurb85yF6Hd4RdzY2lG9qkLnzfdcHqHCpSJmkn
	 hn2H1N1X0T7/R15sXVeYxM/usNjgGe/QmQT9b++x4xrEwAiLVZ/PsJNFIJeW7s5Epp
	 NqmmvW5zYG2XcPNqT/7y1/mXzPSj/f65TRD3U5yCE5/ZOyPcPg6o+sC+SaExueYxhp
	 VQ7EZZWYKqOWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70FE581361;
	Tue, 10 Nov 2026 13:30:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D1681A6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 13:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E93540941
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 13:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4OhdD5gUwug for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 13:30:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 300174093F
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hygCL5vZ
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 300174093F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 13:30:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F1A41630FF;
 Tue, 10 Nov 2026 13:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319221F008A1;
 Tue, 10 Nov 2026 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794317400;
 bh=RvkCuNSz8YDS0uvCYbQ+A0Zr6d+WAF+DhlId5/3OqfM=;
 h=From:To:Cc:Subject:Date;
 b=hygCL5vZmc7PQi40g5WUnT/3F6Dm39GL7kKH+XJ2g5iRlTvlQoJXf36ax/BwwFWp/
 IKXnNI4diDHxUTwR789VmnGN5p+oHbADwOSfEvT5vin4noqu9CufOJhBl1AMoUnNGh
 nIZi3gWeaMGxFFEABN6xH6zQPJveBG+7QB0PHzXfcBEO/L+ICWY+iIYdLm1GKFx9T4
 6PRUN2FNeZFjzlUKwgeIr0/zELgeOgzDDPWZGpAZz8FvBlVPguc49272Rd57f7F/mD
 0FcrfMtlCatBOUVTEqvxllnDAWGqHOb5cLjLBidgQZIfwfLM3RAawA9Knhy+ErxS3/
 /NOoNaTRFo4aA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Dan Tran <Dan.Tran1@synopsys.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Igor Opaniuk
 <igor.opaniuk@oss.qualcomm.com>, Guillaume La Roque <glaroque@baylibre.com>
Subject: Please pull u-boot-dfu-20261110 into main
Date: Tue, 10 Nov 2026 14:29:58 +0100
Message-ID: <xhkdb7bikx19l.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Sorry for the late PR. If possible, I'd like this to be included for
main especially the SuperSpeed patches from Dan.

If you prefer that I split this out, let me know, I'll do a separate PR
with just Dan's patches.

Changelog:
Android/AVB:
- Add Guillaume La Roque to Reviewers
- Update libavb to AOSP 1.4.0
- Use U-Boot's SHA libraries in libavb

Usb Gadget:
- mass storage: Add SuperSpeed descriptor support
- dfu: Add SuperSpeed descriptor support
- dwc3: Make Set Endpoint Configuration macros safe

CI job:
https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/1985

Thanks
Mattijs

The following changes since commit 709a97a05df66e394f40d249105d0baade46f107:

  Merge tag 'efi-2027-01-rc2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-11-05 07:58:42 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20261110

for you to fetch changes up to 0e3fb22a5b2e330bd73014f0ced13f5df259d087:

  usb: gadget: dfu: add SuperSpeed descriptor support (2026-11-10 10:00:17 +0100)

----------------------------------------------------------------
u-boot-dfu-20261110

Android/AVB:
- Add Guillaume La Roque to Reviewers
- Update libavb to AOSP 1.4.0
- Use U-Boot's SHA libraries in libavb

Usb Gadget:
- mass storage: Add SuperSpeed descriptor support
- dfu: Add SuperSpeed descriptor support
- dwc3: Make Set Endpoint Configuration macros safe

----------------------------------------------------------------
Dan Tran (2):
      usb: gadget: mass_storage: add SuperSpeed descriptor support
      usb: gadget: dfu: add SuperSpeed descriptor support

Guillaume La Roque (1):
      MAINTAINERS: android: add myself as a reviewer

Igor Opaniuk (3):
      usb: dwc3: gadget: make Set Endpoint Configuration macros safe
      libavb: build the SHA functions on U-Boot's SHA library
      libavb: update to AOSP 1.4.0

 MAINTAINERS                             |   4 +
 drivers/usb/dwc3/gadget.h               |  14 +-
 drivers/usb/gadget/f_dfu.c              |   3 +
 drivers/usb/gadget/f_mass_storage.c     |  28 ++-
 drivers/usb/gadget/storage_common.c     |  52 ++++-
 lib/Kconfig                             |   2 +
 lib/libavb/Makefile                     |   8 +-
 lib/libavb/avb_cmdline.c                | 109 ++++++++-
 lib/libavb/avb_cmdline.h                |   2 +
 lib/libavb/avb_crypto.c                 | 348 ++--------------------------
 lib/libavb/avb_crypto.h                 |  21 +-
 lib/libavb/avb_mldsa.c                  | 136 +++++++++++
 lib/libavb/avb_mldsa.h                  | 144 ++++++++++++
 lib/libavb/avb_ops.h                    |  10 +-
 lib/libavb/avb_rsa.c                    | 398 +++++++++++++++++++++++++++++++-
 lib/libavb/avb_rsa.h                    |  10 +-
 lib/libavb/avb_sha.h                    |  27 +--
 lib/libavb/avb_sha256.c                 | 375 ------------------------------
 lib/libavb/avb_sha512.c                 | 361 -----------------------------
 lib/libavb/avb_slot_verify.c            | 116 +++++++---
 lib/libavb/avb_slot_verify.h            |  13 +-
 lib/libavb/avb_sysdeps.h                |   1 +
 lib/libavb/avb_util.h                   |  10 -
 lib/libavb/avb_vbmeta_image.c           | 118 +++++++---
 lib/libavb/avb_version.h                |   2 +-
 lib/libavb/crypto/avb_crypto_ops_impl.h |  43 ++++
 lib/libavb/crypto/mldsa_impl.c          |  57 +++++
 lib/libavb/crypto/sha_impl.c            |  50 ++++
 28 files changed, 1257 insertions(+), 1205 deletions(-)
 create mode 100644 lib/libavb/avb_mldsa.c
 create mode 100644 lib/libavb/avb_mldsa.h
 delete mode 100644 lib/libavb/avb_sha256.c
 delete mode 100644 lib/libavb/avb_sha512.c
 create mode 100644 lib/libavb/crypto/avb_crypto_ops_impl.h
 create mode 100644 lib/libavb/crypto/mldsa_impl.c
 create mode 100644 lib/libavb/crypto/sha_impl.c

