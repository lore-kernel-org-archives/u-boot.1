Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC92BC5B572
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 17:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9CE560842;
	Tue, 11 Aug 2026 17:20:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xyCpSQ2UxOq5; Tue, 11 Aug 2026 17:20:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D03406080C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786468822;
	bh=9V83y0DMmd72Hq48rDf3Lg/vlZ6o/u9TooJbuD+pYm8=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=VJ1Pqfaoe0rRtyV2ZczlPQjqfxV2XgjxlrstJnqYL1kA71yFMKTHAp2Fw5iwQ6evu
	 vdMZ5vCqGGejoCWjMTKOZmjnd9FwS0Gicd7WOG1oLNy0FfB2aWcTVduw07IIvB3d/u
	 PpHfum9UqeETcw7pG3TYUqlXPPJQq3UUu54AYT8EWluOoluYgXG9voKV/Zlpw4Hp2m
	 +OAdDotTE6hOWlCIcDxbfNSCzLfcV4kN6crxWKRzgm4IiNwyaO/VY9ETWV+ougHEFL
	 eU7WioM7ptKRUsCZoWSIdotqbmxC2B+3PrJGHb3X89u6ywSIcJutzKnQNOhdNISPNY
	 Ml+iWK3zHkmCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D03406080C;
	Tue, 11 Aug 2026 17:20:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2611C28A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17D9740074
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:00:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yeLkIMtvCLxc for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 16:00:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BBC3B40086
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBC3B40086
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BBC3B40086
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:00:02 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 18EBA3F979
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:00:00 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d122bbc621so2018665ad.0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463998; x=1787068798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9V83y0DMmd72Hq48rDf3Lg/vlZ6o/u9TooJbuD+pYm8=;
 b=CAiYOG5sEFlsat4OMGNCF+UhPFltiAekI7Wag/9EDfNyPWRUkKLoToiIVdZFo1KzHZ
 o6msRv/a2cjTrXIwg5zP+vgzNHxOOFtF8Ec7PdKvVYFinXU+8pdS6P3mAlvAGCxALzZB
 w5z/2Fnndi0Rwbg3WOIggvWKZ4fQQd7nyCQVvf/tNnOrYYBOPXZ4siOJH4/Dg2Xeg5VM
 WGikMBN7kMWr4HB/vfhd3jUHbAlPJ6toavGB+GZqPKpSIwXSeXS2s5WxAe6MevNVkYNr
 d1K9+jR6n/PGH8v2VUQ2k768wkPSelHIrGC5S9QddxJo2A+SzF5NRvWlq35dDhIMKYku
 V2hQ==
X-Gm-Message-State: AOJu0YzGIPymZk9ok/Sbn4sXl1TZGKUli6k4c++/nJ5SSEjgWJ/cS6au
 VCoBQNzenoa2P/Ou8Qx68m1eeewMGwmlK0aM/FDqRV3cxpraci5uIoLJ3rJ1OTq0nKeT5w8XQAa
 E91k4ryoU1Q679WSZ6nhu3W1+ZivNyeyT8GBZkfXlv+nXM8P2QyJC1NHwozs+KnecdvtPr8zjxY
 UKZtWQpBWIdT/vhx2S5Q==
X-Gm-Gg: AR+sD11xC6uaUagvaoUAqct4Y/FhY5yKxbvxDi9BIs03yzMVLakieCWxQJ21iHDiIrW
 i2v9hHA0gq0CyhoAxiqUyz4h9g618SQPdncsJv+SIhhdmmnH54cmQdMFB0PVfu+ov2XyldVdTE/
 fRbIvbM8DSq4RXnr4U7LgywRNRh0/JjzsDvDHxz1V65vZ5MQiSGCUN81bVIoL505PZ9gPpUKJbZ
 x3NZW4g1dohYbOBhrKcb5KQZ2Mj/ZJzMKbZnIuzvSOpVLKbFOfHD5YFKH+YLHiGN1hZV1thp9gV
 O5jVnPQKvYuIMYCTI1ZjLJEMcVjuC+Jx7eCJTwSLxKbnmSzK4Z11op+JsbuK/6/8o9kwoXYEvP2
 2GRyfssPmsP/NcsevgtrV4ToBYFDVifrFDst306Www4X/SRy6
X-Received: by 2002:a17:903:3c44:b0:2c8:1c05:16aa with SMTP id
 d9443c01a7336-2d31796ab76mr53774405ad.19.1786463998466; 
 Tue, 11 Aug 2026 08:59:58 -0700 (PDT)
X-Received: by 2002:a17:903:3c44:b0:2c8:1c05:16aa with SMTP id
 d9443c01a7336-2d31796ab76mr53773535ad.19.1786463997855; 
 Tue, 11 Aug 2026 08:59:57 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3160f47easm10342485ad.64.2026.08.11.08.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:59:57 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/2] bootmeth: efi_mgr: Report EFI boot manager failures to
 bootflow
Date: Tue, 11 Aug 2026 15:40:55 +0000
Message-ID: <20260811155940.17698-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 11 Aug 2026 17:20:21 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786464000;
 bh=9V83y0DMmd72Hq48rDf3Lg/vlZ6o/u9TooJbuD+pYm8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=XqRZlDH6wGf2yNhHHA1uuFzsKOYa+BM5Sw+amV5xzOxBa2++Wa2tm4T6ShyUr8vNw
 gImLeujUZfmYMTC+UeP7ddSvh/9bEQF4pPWerbI4BYf0YX6c0GKPzSQaV6MMLGjiZP
 CAyUpvQNiT0vXmjUp5FgaSZoPxZJ64oD5Qkv8jM1Cxqo0yxmDJQbbTJNQRRVyUJJM0
 OvtXBkvLu+hb8maNl/xc3733//lGD/XkjaYo3gAV+B0nlyN581KwLljonfCAQ0HF/U
 f33ge3a0bRxSTOhyyKsrd5MV2X8Iw9tbFWZEootpXlyIAkxju47NQpKIudscAsnamY
 dfEidnGzAuEBCQh+kF/GlAewRVEj81+25v/cXAlTa6heBgBRtNhDxphnPNmPlEs0MW
 cC1Lsxy7cF2NZioLaP2ffQ9M/Lj7WYmBsxOCwhXCO0Ov2og3KJHw4njmrGZdN7Rk3q
 H3pPL5lCdzHyosghEkNXcA5jkCE5J0XzGbVhz8UrE8JHMDq6+ti8YTm7bstDoLcbCe
 l5a9PkPuj7aC9ZsCNSSWXVxvbX9I/mTid9JYOSvAzGbpitH3ZsjbvOtYCrPAJmikDI
 26UI6lhzUkFEbn85lKOuUw9iHC7/EwNFyOBqegvL1y26i9PZ8hncOnIWsbIfOpf6UN
 UiuOeU6NokZNc4iy9N7tEc60=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=XqRZlDH6
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

When the EFI boot manager fails, efi_mgr_boot() assigns the status
returned by efi_bootmgr_run() to a local variable and then returns 0.
A zero return from a bootmeth's boot() method means "should not get
here", so bootflow_boot() reports -EFAULT for every boot manager
failure and the real cause (no boot option loadable, load error, ...)
is lost. The unused assignment also trips -Wunused-but-set-variable
on newer compilers.

Patch 1 maps the EFI status to an errno instead: EFI_NOT_FOUND (no
BootOrder) becomes -ENOENT and any other failure -EIO, so 'bootflow
boot' now prints an error that reflects what actually happened.

Patch 2 adds a bootstd test for the error path, which was previously
unreachable from any test: it binds the efi_mgr bootmeth, points
BootOrder at a load option that does not exist and checks that booting
the bootflow returns -EIO rather than -EFAULT. Running the real boot
manager initialises the EFI subsystem in the sandbox process, which
would leak into later tests, so the test is also added to the restart
list in test_ut.py like the other session-changing tests.

Tested on sandbox: the new test fails with -EFAULT before patch 1 and
passes after it, and the full bootstd suite passes at each commit.

Aristo Chen (2):
  bootmeth: efi_mgr: Do not discard the EFI boot manager error
  test: boot: Check that efi_mgr boot failures are reported

 boot/bootmeth_efi_mgr.c  |  5 ++++-
 test/boot/bootflow.c     | 35 +++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py |  3 ++-
 3 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.43.0

