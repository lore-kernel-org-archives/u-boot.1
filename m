Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D0606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AI93jgsV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y977BhBh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F28D80CA2;
	Mon, 23 Nov 2026 12:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id afprMeXsjtmb; Mon, 23 Nov 2026 12:28:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 219BD80B08
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795436934;
	b=TAU64AVHdGb7baUkAPc7uHUB0/MUYv2eBAoPmuPLehwTBBfLTYeEsmDIItvKZb09yJJ0
	 hLzgILE96z2YA7iUfYbP8ZBQ4ejBOIsT3h4gDGYjWbnkVKx60a0NB2NAZV0wEFoCyq7VL
	 234wfzxlNK2tCnQoSP9wizeE8jROmZt2xSY2IQSrg0/VmRiG0+JGRWWQ/nqJCFBu74p5A
	 UNIMEyBlW6BZU4kO/hHt2TQiawTc3coThq8NT0repfz+3o37RreRjit/G9+x/x40A7sVn
	 Y5SOiSgz9nusBhTz6+v5XUqw62F2mILvlmDq0MRgbRKhijw5OrmwBul48EnPBOgYizw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795436934;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Jm7i0BvDsD/+GCIy2MnI9fq7lvHSQI+JvNa4VC4dajs=;
	b=CmA1k8wrMXU//HPExenGiXOmOSLBEtHvWl1hN5nWKitC5Bs/Sev6UaDMa3MmrJNk4pYA
	 to/dZFX/lMow4e16wMUJIKqy86VTWA+yA7MyZBTWKFLmm0QHUSqMRwZF8qCgJOKcAweww
	 HGi8Obt125PuJNEURHzgfUuS5anzbv6xM/v5vXWjzrmcUPo490WjXfnpNhsFLsf80JW5t
	 qsEi8j1gYeFSmTVTTZOCJ+JFI2u7gNrc2ONbg8SeFuQw5nQqpgmuw6Ll5KoNly+C1F1oy
	 AYX7bBWslaNawKhOPbTQaEfvRiHTcA/pozdyQwZmJjqeibTfPk8FTwb66scMZ9nAhEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795436934;
	bh=Jm7i0BvDsD/+GCIy2MnI9fq7lvHSQI+JvNa4VC4dajs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AI93jgsV3ElzNOuRDxrtRYkTLcWqYu3L5PT7MPanOzheLyDXRoZZdsHshfLVgELGF
	 tZsRDqP1us65MngK7jti0CaruJbdPqsW98IiULgaKJp3T1wBG+jutsorupKC2YATku
	 R6foiiTGeUgq4/25VlW4BDfvViiXnl6JIjhtSmHsBGBsc2TabD1R+yM5iAv4lprcBD
	 mEli5IlznqNWaLD+Ief08w6QGweReAIG+6YsCR8ErinjlPH9tdpxZPIh8zETaa25uC
	 FQSLHWrLkKKS+PBFGs6oXn7jINFHfzKKqcNZ6P8pcaDVkpDQK1HtUGwPl0WzdHv5+R
	 DXXUpnYYes2Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 219BD80B08;
	Mon, 23 Nov 2026 12:28:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC6313A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89FCA40707
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:28:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hDtq_YbwDTTk for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 12:28:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD2BE40703
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Y977BhBh
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD2BE40703
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:28:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 819B14487D;
 Mon, 23 Nov 2026 12:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE241F000C4;
 Mon, 23 Nov 2026 12:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795436930;
 bh=Jm7i0BvDsD/+GCIy2MnI9fq7lvHSQI+JvNa4VC4dajs=;
 h=From:To:Cc:Subject:Date;
 b=Y977BhBhvl/wvQ63yV/LQkNaZYnkl6HRtZkZJNcAVKXkSo0vWaTJbd2310ZQesUTj
 lukPOnlDvrqNkpwUk14iVxF0vm+SskNMHBSgGxh+eyaA4cDz473OvWcth5p2EUDUV0
 bBlV+XJZwRpJons8ADiGLoJ1CTMz61c+IV6OSPXbiQkNmALZkjoXioaGRotExaQZ3B
 hx8RAd2PbrFDZbLKIPrt+bgbThVWnbCEEMUQYd2wUGTScSmSjQlpJ36QAGYZetWe0f
 5NzhXd8F3fPs7s64Sa+IdRK8scWuu1EVEepPBCPoiIvnnmxINHxDBsf00+spU/MKn5
 NppTMysuQvvUw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Carlo Caione
 <ccaione@baylibre.com>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20261123 into next
Date: Mon, 23 Nov 2026 13:28:47 +0100
Message-ID: <xhkdb33sru3y8.fsf@mkorpers-koolstof.csb>
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

Please find the following PR for next:

Android:
* Add support for init_boot partition in bootmeth_android

Fastboot:
* Use $fastboot_addr_r as default buffer address when set
* Invalidate stale/incomplete downloads on new sessions
* Don't fastboot boot when an ACK failed
* Support fastboot boot <fitImage> in spl
* Support legacy U-Boot images in fastboot spl
* Support raw U-Boot images in fastboot spl

SPL:
* fit: Reject failures when an explicit FDT is requested
* ram: Allow loading FIT images from a supplied buffer

CI:
* https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/2134

(I hope this time, b4 can apply it properly)

Thanks,
Mattijs

The following changes since commit ecdcf9e365df6249a57cd8cc946e7026804ff4ae:

  Prepare v2027.01-rc2 (2026-11-09 15:52:36 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20261123

for you to fetch changes up to c52cc53f454a3f7e039357a839a2b92f56432bc6:

  spl: fastboot: support raw U-Boot images (2026-11-17 14:25:40 +0100)

----------------------------------------------------------------
u-boot-dfu-next-20261123

Android:
* Add support for init_boot partition in bootmeth_android

Fastboot:
* Use $fastboot_addr_r as default buffer address when set
* Invalidate stale/incomplete downloads on new sessions
* Don't fastboot boot when an ACK failed
* Support fastboot boot <fitImage> in spl
* Support legacy U-Boot images in fastboot spl
* Support raw U-Boot images in fastboot spl

SPL:
* fit: Reject failures when an explicit FDT is requested
* ram: Allow loading FIT images from a supplied buffer

----------------------------------------------------------------
Carlo Caione (7):
      spl: fit: reject failures loading an explicitly requested FDT
      fastboot: invalidate stale and incomplete downloads
      usb: gadget: fastboot: do not boot after a failed acknowledgment
      spl: ram: allow loading FIT images from a supplied buffer
      spl: support booting FIT images downloaded with fastboot
      spl: fastboot: support legacy U-Boot images
      spl: fastboot: support raw U-Boot images

Igor Opaniuk (2):
      bootstd: android: load and verify init_boot
      cmd: fastboot: default the buffer address to $fastboot_addr_r

 MAINTAINERS                      |   3 +
 boot/bootmeth_android.c          | 187 +++++++++++++++++++++----------
 cmd/abootimg.c                   |   5 +
 cmd/fastboot.c                   |   4 +-
 common/spl/Makefile              |   1 +
 common/spl/spl_fastboot_boot.c   |  76 +++++++++++++
 common/spl/spl_fit.c             |  16 ++-
 common/spl/spl_ram.c             |  99 ++++++++++++++---
 configs/sandbox_spl_defconfig    |   1 +
 doc/android/fastboot.rst         |  64 ++++++++++-
 doc/develop/bootstd/overview.rst |   4 +
 drivers/fastboot/Kconfig         |  16 +++
 drivers/fastboot/fb_command.c    |  43 +++++++-
 drivers/fastboot/fb_common.c     |   3 +-
 drivers/usb/gadget/f_fastboot.c  |   9 +-
 include/fastboot-internal.h      |   3 +
 include/fastboot.h               |   8 ++
 include/image.h                  |  10 +-
 include/spl.h                    |  25 +++++
 include/spl_load.h               |   2 +
 test/image/Kconfig               |   9 ++
 test/image/Makefile              |   2 +
 test/image/spl_fastboot.c        | 230 +++++++++++++++++++++++++++++++++++++++
 test/image/spl_load.c            |  46 +++++++-
 test/image/spl_ram.c             |  48 ++++++++
 25 files changed, 826 insertions(+), 88 deletions(-)
 create mode 100644 common/spl/spl_fastboot_boot.c
 create mode 100644 test/image/spl_fastboot.c
 create mode 100644 test/image/spl_ram.c
