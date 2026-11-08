Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B5606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 23:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DK4GGCc+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z8VxbN7y
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 323026068D;
	Sun,  8 Nov 2026 23:34:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxWltYVZCCeJ; Sun,  8 Nov 2026 23:34:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 66EFB6066E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794180855;
	b=M7nFqhDb0Hktu4MtfYmiFMRLo17hENTSTUVWYCiCY3Z744XsmmjejabXGu1oVSilce0N
	 TRS4GgrGIJKbKnIOyUxWbI5lwyS1NAwjJsc1UzUESeETxDcnP3oYAKj44YaweCTw1/IVI
	 IcfOc+Y/DxkM/d98wbJ5noiXtIJ8S7MZrmM8DMygYMRmdcw7TmlMDjwKWuoU9a1C7rjk0
	 LEqX6Tp8RfAqMdIcPHU4HkJxxX1qRdAMA6Yirh35YvXh+frcNc+fUvFm11v9SiLXeAylF
	 mvJvH19a8s178UiRf3aKWIQ2akDr2aVLZwPO7rG+4kgS0OU2hyTf/bZbQaZk3vW8u5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794180855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KxutETqNdd0d2M8UjrWY6yKSKT785EN6Sfv631OfJUs=;
	b=jqBNRiKG+lzpPxyN67b+CD2fu3q05Spf4SoPcgHwiJl/A66H2cNaCSq9McCwdX5lTcpv
	 cJJ7YZp6ZxiaByMUPF1rr/1UVRb+fMAVo+OVfUZ3aVjq5oyB7YPFlL/GcaUn/bWnO5G8P
	 uBvHaUJYtO5PVxAfAnCilvxUhmjVrpcRLGA+l1XRtcWp3D0Ldnu8bPZDow2GYKZBGuLYt
	 X/T0lKyR8TYIgASxS49VSzBbNi7VOkPEAcNg2wnMAEq/YPI/ToQIkyCwh5V0zT63mRHSA
	 kuFpcDiFYhIghb7PDlo97v87mo5TCnSS91bODxz9WxIMtmZ92HBv7N0ZDbv2b+wbIGQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794180855;
	bh=KxutETqNdd0d2M8UjrWY6yKSKT785EN6Sfv631OfJUs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DK4GGCc+MSiyAY4ofSY4XY8rbCgwzQmMtiW+iteQtA38CGLA7h2jf/bhkeOhIFTeB
	 P1kliCtCSuUBuDV0vLYXaARUgNe/ADfpQuM1u4CUs4hRMBcIq8Aym7TYVB6qbIu0/4
	 uXIPLhrped5MRJsxj+ZIEvOPO6B/qB2UjbKtr0Df5KiHcingZkLeG3nGmLyZ7/yUdg
	 MeEQ+pDigNA8+NFR0XO4cd3lrj9na4kTV3w0IZR2Bu/Rn9KzB3+3eIPOaDmusHVPL3
	 h7wjyG/2WlBj3eJPhsOdhcYB2/kcJD0vp3pW47c0vh10KxCK3qeiijw2KZViDIelxZ
	 h1uufo0ziKQIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66EFB6066E;
	Sun,  8 Nov 2026 23:34:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CAB4235
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E0384064C
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JHjWSFiaP3C0 for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 23:34:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 327EC4064B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=z8VxbN7y
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com
 [IPv6:2607:f8b0:4864:20::1229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 327EC4064B
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:11 +0000 (UTC)
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-1b1ce85287aso244454c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 15:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794180851; x=1794785651;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KxutETqNdd0d2M8UjrWY6yKSKT785EN6Sfv631OfJUs=;
 b=z8VxbN7yTcdCyuBSpjAbEea2XdY4v0UCMmneyNtCcONxSaKMk3pwI9iztVXghZL5g4
 rXucC5SUOMQxkM4ERDICkLVcZ+4X6EiobVUF2K9rbb15RWo6xxgeFQ7m/BwrBuQ25xo0
 0fS/7uKJRSL1pdASrrpEEFIlR07T5UIZCb0O183MwcGjceD2QMeH7oSHQOWXpUyguDbB
 sQSRQOX9nPJ7Mng8r7gr/e8NPe4fWvY+ennAftkMTBtRLdCA6zo1gW7vQWVE6SxCtoMf
 Aq6eEF6G1U7gfGiMB8Y7ATe8nD3Dt/HGDAzoMZbbuYoxxVxaF4JtnG7Ma7rcjALUAyu3
 eD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794180851; x=1794785651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KxutETqNdd0d2M8UjrWY6yKSKT785EN6Sfv631OfJUs=;
 b=zlQd4X86EKsXsuf/Qo8ri65JqVxJsZg+m7DQu8H9+1GVWoEa5uIi9VoE4Fn300O+w5
 BPLqDO1U5RvNqETDqdMIMzyBi/6NJJSgIH56acxwQsBGldPYfoNZscrP6LcGk+OTHwcH
 AoLhblzE8ghcmWLcuIxuts9a7aXkUX8AS2eRQxcry+DO54CvFrDoHOv56xqLRyTM3vqk
 L2sYxIcXOpAU6GV/2ZwpC2UExVIyG93+VUfxpx3NeAhV4/eQ0f9oSnsxr3uL/LORATeN
 gb4mndit3wAjT0JalaHlRp5j2f7gLgCTwhwZQK0hM99igRdVWpomyHR4uDjvbOVw0hGj
 gRNg==
X-Gm-Message-State: APuU4Z+fEo/FOQ8XrMSCOfxSSKiU9eeaJ3PQevRIadAt7pcO+4WS42Bi
 oO4JbYimuBiTHQM9Hr5t24bWLqBeakZlDEi41W/lgjBvXYRW9ceNwjiT34/PPxz1
X-Gm-Gg: AYBFou2eY+2nXqn2xiVJ99dOTfp8pcgLBsh18EAwT6Jl3bbWRcvBV9y0FQZR1ZzegRp
 w5A6QqoFDnh+CeM3g6y0oJs9IdWNmXqjqhJ+OceQ7q1EL06cYiaQSWDIToOW9LPNGjh4t0gZ5Vb
 eQkdkou9P6G7rPV2Rnl7+OlXgvi/JuzYEENNACi65OiFUqyp0OMtxGhsanJMADQtw5UZlX46IBr
 kTookenaWIS3qLXplggfl7z/FkEZoAQpodnI8LOZjFPYthuW7frZZiKof974VQp3jnRZUEkbdZc
 N000mQYY+fiA13rhy2NaJodC/rBvkPzr4esfAMbQgZxuE4g8cDx2iDgaAmwfxv5uRIgv1l0XgXt
 4BFR2LQ63zeogjhQYQ5lGx5tWk/7MqMR5PcKiIjukAdccdpnZNA+vWGS80mQob8Am8iHI9r8bFn
 6USl9JLecyqOGhutcCPAQBtuOm2nnq2HZLHRwVWpjtzsM8doBa8fBMqfc/UZE+pPUzxGKdcHTAg
 8KYVrVQeRu3bjbcnmOEa7/cUePD0M04yd3TrhWbHZalVSZcisPN35kaTeLkyN0c96zTravJ1JdI
 ovMulR6pXxM1Ap+hWd202pq9klCtIYzTIwPwGRH5Gt85gJTeQm+y+1mqW7kutWC3cysShggRNFI
 OwpzL23AZBen7rUAau6qH2ADwQhYP5GCrjMgEHJfOvRaNZFWhA/abm7uFqt0llBtBup7GAMSU1c
 Msvc9g9T/6
X-Received: by 2002:a05:7022:4588:b0:144:fb42:52 with SMTP id
 a92af1059eb24-1b39feb42f0mr5290823c88.28.1794180850816; 
 Sun, 08 Nov 2026 15:34:10 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3771eccb9sm7221006c88.19.2026.11.08.15.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 15:34:10 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, bin.meng@processmission.com, trini@konsulko.com,
 visitorckw@gmail.com, sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v7 0/6] virtio: Add a virtio RTC driver
Date: Mon,  9 Nov 2026 07:34:00 +0800
Message-ID: <cover.1793836645.git.alan.tseng.cs@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QEMU v11.1.0 added a virtio RTC device (virtio-rtc-pci and
virtio-rtc-device), but U-Boot has no driver for it. This series adds
one, so U-Boot can read the time from it through the RTC uclass.

Patch 1 adds the driver, patch 2 updates the virtio documentation and
patch 3 adds a MAINTAINERS entry. Patch 4 lets sandbox tests answer
virtqueue requests as the device would, which patch 5 uses to test the
driver. Patch 6 documents how to reach the virtio RTC.

Changes in v7:
- Patch 6: drop the claim that QEMU x86 does not enable DM_RTC. X86
  implies DM_RTC, so the driver is already built there (Simon).
- Cover letter: no longer claim that "date" reads the virtio RTC on
  any QEMU target, which patch 6 explains is not the case (Simon, v5).
- Rebase onto main. Patches 1-5 are unchanged.

Tested with qemu-riscv64_smode_defconfig and RTC_GOLDFISH disabled, on
QEMU v11.1.2, which reports a UTC clock, and on QEMU master, which
reports a smeared UTC clock:

- With -device virtio-rtc-pci and with -device virtio-rtc-device,
  "date" reads the host time and advances between reads.
- Setting the time fails, as the clocks are read-only.
- With no virtio RTC device, "date" fails cleanly with err=-19.

With qemu-x86_64_defconfig on QEMU v11.1.2, "dm uclass rtc" shows the
CMOS RTC at sequence 0 and the virtio RTC at 1; with RTC_MC146818
disabled, the virtio RTC is sequence 0 and "date" reads it.

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
 doc/develop/driver-model/virtio.rst |  25 ++-
 drivers/virtio/Kconfig              |  11 +
 drivers/virtio/Makefile             |   1 +
 drivers/virtio/virtio-uclass.c      |   1 +
 drivers/virtio/virtio_rtc.c         | 244 ++++++++++++++++++++++
 drivers/virtio/virtio_sandbox.c     |  15 ++
 include/virtio.h                    |   4 +-
 test/dm/Makefile                    |   1 +
 test/dm/virtio_rtc.c                | 306 ++++++++++++++++++++++++++++
 12 files changed, 639 insertions(+), 5 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc.c
 create mode 100644 test/dm/virtio_rtc.c

-- 
2.43.0

