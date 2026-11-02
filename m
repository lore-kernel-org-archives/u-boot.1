Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18F606A32F
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q24b4lJF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NV+J1eMD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC66260687;
	Mon,  2 Nov 2026 03:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bNOpOwBZBtlp; Mon,  2 Nov 2026 03:04:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A3A56064A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793588689;
	b=s0EneY8pdI4GcUw1HNEBAT0PypCQxPsafHGK2VERr1V4hy/dRMyg5eWBAjJBQ37y5TNo
	 oqYeAVIKZpRVYfqrcIiCehpNWsyE/00X+ZwHC7o4tbCa0TaDDFJbKSkUru5mz2dMJJ5kc
	 TQduOub9Jp0zMIAPXYDnAcWAb9lHg+Qu0tTisqHIC4aZIWCWB75LK33ylPs+KYxhatihm
	 ZOzlb/vRH01qcjtC3cGYEFl1K9lKVx73B9OyCDFWbFHY4G0/W2WaSgsyLWvaLL8xNHuF4
	 hQce6I41nz9BtfMAlLD1QFu26At4/aTHvL6W4rbIGPp/NlG5Tp+LoRrQzisjDLl7Yfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793588689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gkytlVKVqWkfgqGrs5CZRIuXW3p1BcUOK4WOl6Byytw=;
	b=HANoJ5Q0D4jOM4JRB0h8w/wZAacLxrP1DqQcBLCc+St2UVZUjz+UmpSPyBJgKYQK+ljC
	 Ci/xMxrJaCfWRRWzHCitZ6vptOldj+D5s4XQxPcYY7LNVvYd7x6SG6zu3ZyJnD/uMhLwA
	 IHSoUUeNIBn/D3LkmMGii0vZApYKFkSemKyrhszMbzgBgwKR98Ol1zUexEVm7T29lvOki
	 KUbgmbbt+JGbdkc+M3dHhLdBlLdjpHYKpgLTO1nK4BedLcC8TbqoEHqAkceamJXLcdMDj
	 WAJP2kj9eTZ5qWDuXyB29kCHk0blk2uuvzslZw2kVI3/YToV/mcIoX/0t+w5nMPhGqw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793588689;
	bh=gkytlVKVqWkfgqGrs5CZRIuXW3p1BcUOK4WOl6Byytw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q24b4lJFf0MCzI5yxi0bNDUA/KZNU/W5MKQlRxT5pXZFaeQvQ75tCbRtJikC5yRM5
	 hsbyEizrlg1WtDnMEa25idB6usqOZcAKsbaVZ9D9dLNZQMdse0lU01+RtIP8kEVAMn
	 uIx8qyRK96IrZvkPluLaOK+wdmQQU+blu7S1naOENvopv+5okrLsmZ8dhihiHb85jx
	 dU0oPpn2BBHakJ2jcPSfpz92aM/B3UK58Xe3+5S41d6Xa9f1yPAwRkOvCYUMKwXYOW
	 I2LsjCZDSuQYsOISVoV7oSRFJNUAfG3YS/er+DyRd3GF1Ci4z91fsFF2MHNMbMg+w4
	 2NVvZLaDZJNrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A3A56064A;
	Mon,  2 Nov 2026 03:04:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E8363435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDED580D4A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M5BjRPGaxtaQ for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 03:04:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 370E580D1C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793588687;
 b=KBf3tMsNEBqX+A0yfHVzsjQLmoBHebRPkjs2gcQOwMGtOP3Wst2IVNI2rXagOozrRTPR
 P9Bc0gWH/R1UwQgzPcHXmvhrwMbA9PMFqAuyC2+AKzaNqziM0IjF140dWLQpgTJTq9D0y
 Jt+ZOkRpxXLmt4Giva48NBEeY3MFjysTEoKgDOLuHgX2BOr/uVebQKKiD4Qst51R12eDh
 ReHv5nBGW7DaOwTaTnmD5cLyx8TDL6bMM/XYmSvVVrYsM1D4tD7JuH+5IJF/vVV2o975w
 m5F23uLBktUpvU4bdnoFqUg61+34ld6B7J4w13I+2VzMdBz6BLWU4ONMPtrMPTtBs0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793588687;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=gkytlVKVqWkfgqGrs5CZRIuXW3p1BcUOK4WOl6Byytw=;
 b=oTgYk3Xbnamq8vuUSHklc8QOdMfzlc5uaxpGgkzWWlZ6Q0s23Cz+KGmSvlYQRBYqoUD8
 01XxzDGu3YPW74ZKB4AuugMGbCrewqXmLQXCLTJaxXDHWF7XiQAu8LHDe8zYV1QI9SmAG
 PoUG2jhr8e0MCq+gtzxVvW17XSwg/zd7TyL3aCPUiKNBZ+8TaBocHj+bf2vXANUUUWwQc
 wW0FYIt7BW5okIyJiyZXH8ExD6yZRHaSaNUJlnfD44dju230EpHe7GXZgqf5cOkzW/NV8
 NcI1N55Ar/1V6W2BmlEYVu62hrNMxUOO3M2uvv9rakb2zIqdwyZ0Iih66M8/F4Ckfvg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=NV+J1eMD; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=NV+J1eMD
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 370E580D1C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:46 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3adc4590de4so1974667a91.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 19:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793588686; x=1794193486;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gkytlVKVqWkfgqGrs5CZRIuXW3p1BcUOK4WOl6Byytw=;
 b=NV+J1eMD0otjTavAL/pxezogwbg7DN0lJQmXnJ7BX7rRDGmiJEcE6USPAX52Uglx6g
 v3fnKjFXhM/nLZfZzbB/tqRZPylDFV+x8m0+tSo++PFrxZ7mycyYwOMi2yXerhP7NNKt
 vd8FeV2Nep6DlhXrde6ScayiYOgoodAUEjV0BQd/VeEP20PqMwZgrwFh+ibtQVfpFx9T
 n0QL0bhvDYpldODhP2qMNN7ff41uuJ6NCI4g9mY2EvSdt3YLtfpwarPx/ORv5ta4Jh0L
 MjyaUCM2n9JHNSX/hM9750z9kNpTBYelC1a5cW201exR0p5sLDj0gxuh1+0Q1YDs23Oq
 Evkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793588686; x=1794193486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gkytlVKVqWkfgqGrs5CZRIuXW3p1BcUOK4WOl6Byytw=;
 b=zBjTUowa/AiIKIMdaaWy6Z5pZASQfeOwgKPe2JPh49g0gvElvJPvtR2QyeasLydvca
 qqEt8nYGIoHcHsvFjRsi2vYVbALuIGJ3bKWYuEQzuTwtvJHTJzSYlMAxXnecnUkXc4Cj
 /fXQMJcFQkFqnabvfbXbjb9lJlKyvppSk/3STfm5Cl/HqbddGioDTOyAT3hdQ98eia5a
 l2J8vjnrl2/LfPw/mlZ2uyqDp/7Yg5DPnuP59bCLxJGZO5hvmBJHv/IqZNIUyxpAydc7
 nTq4YApbswwKrT9qQr7M8V9nX144fV485ZnLqQiBaz8LXOtvYwpkZaSjJ4zQfaKnF8BL
 D5Fw==
X-Gm-Message-State: APuU4Z+zO0VeCKVK0bPvBN5kvRCL43YP9mPYo4KlS7c7tL/SP1TefcfK
 LwlYpMO4MFLRE+M0Wvg9XdVESAzQgXaJwXokkoDjlWqXUduDE3yc8RVaRFPSiC2U
X-Gm-Gg: AYBFou1TrQrfJcqIE7534XvLQeAIksJZj8OcNpGpchRkeax5WI3tpOqyRjQB3OirHVW
 vynQA3G+5QsZ9QWxlcrfDF5swk9wDa5O4GvRlbJG1mQMHXE+xeqvJSozrYQNc0RpAO6NJIBCT2a
 2810hlRBECzhEgVFehOhQJey5oLQh9sG1m3xm2ISxos/iDwC+Ue/AUQaohmoh8cEjTUfQULa0FY
 3pS0HP5iVP9kz3gfGOu844gm9j2lSlxigfN12TzIfylFNFc8XAeclOaSQaCSArhv3gjWgXLG7OG
 1dVXWgRVnYRa52oaLAf3O2orkwiY6HUlFdyPEW8d7BqsiS7udy5u5w1k/KtBWRcfN4VjatP3BCK
 6CpCGlN1kOLSllFbcx4e8nG2HcAMctKfI1vCKWFzdPzamBrAx1HcUMuAIEHABBG8sldcYr+zGJC
 xT1cQzhSfOVTj0gEpG36so6qE/Q7eiTNqzVlkoIdZqn/zi4IAjymagydaGWXLbxIaNH5WFBzRpd
 /XFCfJfOby3sYGWWqBLiH6fxYcEvb6vFgHmik1oDuZLaGANvtH4gPKZVfy65XsKdCbpIkO/SCGH
 bsksH19JxFvm8gWfVhmTUONLENuwYlf4Sccwvlaq7mDREexJH3l6TpYo3elszKviCl0wGDHRY4E
 FtaYxguEnHepgpVt9xau/xCZEsc2R4GywA7ElHBVBu+g0x2rk7+8+UZL8E48Gf/TBE31ZY9YM14
 9iV2trnu8o4g==
X-Received: by 2002:a17:90b:534b:b0:3ab:4f1:4f76 with SMTP id
 98e67ed59e1d1-3ae898127f4mr7261815a91.24.1793588686283; 
 Sun, 01 Nov 2026 19:04:46 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845432e4sm11995159a91.3.2026.11.01.19.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 19:04:45 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v6 0/6] virtio: Add a virtio RTC driver
Date: Mon,  2 Nov 2026 11:04:36 +0800
Message-ID: <cover.1793588058.git.alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QEMU v11.1.0 added a virtio RTC device (virtio-rtc-pci and
virtio-rtc-device), but U-Boot has no driver for it. This series adds
one, so that "date" and anything else using dm_rtc_get() work on any
virtio-capable QEMU target.

Patch 1 adds the driver, patch 2 updates the virtio documentation and
patch 3 adds a MAINTAINERS entry. Patch 4 lets sandbox tests answer
virtqueue requests as the device would, which patch 5 uses to test the
driver. Patch 6 documents how to reach the virtio RTC.

Changes in v6:
- Add patch 6, the documentation follow-up Simon suggested on v5, which
  I first sent on its own. Following Simon's review of it, the virtio
  RTC now has its own section, which also takes the QEMU version note
  from patch 2, and x86 is described like ARM and RISC-V: with DM_RTC
  enabled, the MC146818 CMOS RTC gets sequence 0. The Status section
  already lists the RTC since patch 2.
- Rebase onto main. Patches 1-5 are otherwise unchanged.

Tested with qemu-riscv64_smode_defconfig and RTC_GOLDFISH disabled, on
QEMU v11.1.2, which reports a UTC clock, and on QEMU master, which
reports a smeared UTC clock:

- With -device virtio-rtc-pci and with -device virtio-rtc-device,
  "date" reads the host time and advances between reads.
- Setting the time fails, as the clocks are read-only.
- With no virtio RTC device, "date" fails cleanly with err=-19.

With qemu-x86_64_defconfig plus DM_RTC on QEMU v11.1.2, "dm uclass rtc"
shows the CMOS RTC at sequence 0 and the virtio RTC at 1; with
RTC_MC146818 disabled, the virtio RTC is sequence 0 and "date" reads it.

On sandbox, "ut dm virtio_rtc*" passes.

Hung-Chun Tseng (6):
  virtio: rtc: Add virtio RTC driver
  doc: virtio: List the supported device types
  MAINTAINERS: Add entry for virtio RTC
  virtio: sandbox: Let tests emulate the device side of a virtqueue
  test: dm: Add tests for the virtio RTC driver
  doc: virtio: Explain how to reach the virtio RTC

 MAINTAINERS                         |   6 +
 arch/sandbox/dts/test.dts           |   5 +
 arch/sandbox/include/asm/test.h     |  25 +++
 doc/develop/driver-model/virtio.rst |  26 ++-
 drivers/virtio/Kconfig              |  11 +
 drivers/virtio/Makefile             |   1 +
 drivers/virtio/virtio-uclass.c      |   1 +
 drivers/virtio/virtio_rtc.c         | 244 ++++++++++++++++++++++
 drivers/virtio/virtio_sandbox.c     |  15 ++
 include/virtio.h                    |   4 +-
 test/dm/Makefile                    |   1 +
 test/dm/virtio_rtc.c                | 306 ++++++++++++++++++++++++++++
 12 files changed, 640 insertions(+), 5 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc.c
 create mode 100644 test/dm/virtio_rtc.c

-- 
2.43.0

