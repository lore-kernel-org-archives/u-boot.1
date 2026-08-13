Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4D1C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1527680C92;
	Thu, 13 Aug 2026 17:59:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 12rEDHtE8gmu; Thu, 13 Aug 2026 17:59:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1FC480D97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786643960;
	bh=LvFAzeya1yYX4e1nLYUprjBIluWuMGn6M1EyWN4OojA=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=xhQfjMTNW/D5KT7z8IsFJ4mR4S/ZlMlqXUZJFJ9EJcx0Y4C+LIl8NJUtLayOijACm
	 4cHqRYJtwwSu0aF1koLcNzJXzXqBqIBnNtjL6WQlvvP0Mo9H/nrUhOa9x4QRC/s7+e
	 9tOoFtmQjsybvuwz68CaXyEMnP4AMCldkiKylT4M/RveiV+NhLWkk2MxQQNlKGwORa
	 NKnjTwutlOpwWwAfqK7RxP7qkSVxxT+MlHrt+j+a+1AlzCr+gJhU14wlzjqeG6SELp
	 j7IBTI3SYTbXXn4mLuT9Ok2y5ZAfW3XkJ/IHW535JJ2Qn8Al38BsR7RKA7ej0WrXng
	 zH39vHPDbhybg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1FC480D97;
	Thu, 13 Aug 2026 17:59:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65F36EC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4BC7B40983
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:03:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_ZPEEi53dRW for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:03:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3D41440854
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D41440854
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D41440854
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:03:11 +0000 (UTC)
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 93A943F0B5
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:03:09 +0000 (UTC)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97778aef5c9so1387964241.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636988; x=1787241788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LvFAzeya1yYX4e1nLYUprjBIluWuMGn6M1EyWN4OojA=;
 b=K24KitTZuNQ4L/AHwRofM8b5TFOFjuwwT+3pLZeOqb7rlOeBQEsg4E8wM/LL0/pC3B
 c0PzWrfB9i5Lj01HWNs11cqRiRZk5DTvVIXPCgx77VhbXnR3sp36cp1bP88CIRDpZ1ey
 Emanrb8CpfClYJHfCHqcPC9DHSxctwNbmSabIX6z0BMXU7MDXMjooIzMAMweoKYtOdnm
 eLM+IxtGtaoeUwN2gNEyw8wdEhZfzwzD6yr8d5xEbGHuPFWsNR5eFRhQl0uesp3yYMWN
 qC037k+V5bPdrhGGxo+/8vd20j0JSPdKf/QtQ1SptDAopbJHMsJ9Hqy3IjmqFHcGEfdF
 4XFA==
X-Gm-Message-State: AOJu0YyQ4/3d6t0J9YzckULPNXO3nB7k+7xgNXG08bl3qeaG0A7Q0fJr
 7wUblWEbWVTgoKp63q7p9+Cg5GCm24hMazJYAZrdoQ3FPawVjYYXmSU5gnStZ6zFM+NYijsMsEe
 VLYhCizi6wBRFi8CFyknMG+t7NegAWPq+R8WuHvBep1zq9oHjud8I2/fBwEziex7Mh0IFnj4x0Z
 yX3l82KoiUPsU97lAjzg==
X-Gm-Gg: AR+sD12/g9oNgPW8U3lOLaTxQUadLrcAzbiNSB3IrP4wqaYLb2y3j7s3pgwL0CZk7RT
 FQP7F3epHgjM9itqzx4tUZ30B7SxLNZBVBnLvS0zXc3lM0VZVcQiPYIufyx+l5qiQM4oxBvWYON
 CPWWv0DkNiImx2Es4LYLyIyJnPE0gkZzxT1Gapjd2V4rIADDMYCpWALEylShGoziufXcsqQOaDQ
 ku7h6ZCpD5IRa05nhTUVgiP0HyDTS/r9Bi1cK+9H2XK8l3sYeqeJwc2tsKjB9I+bWHTpoa8/agb
 zi0LpKU3QEo+OKcORbYcrUD2RKktaoxuySJDqUeeQFqfIjIQEp9l5faXXtlTz0BzU4A251sRuzp
 gozJSPNn1ZPn47t3wEUwyEtQVkeFN7/SK3dxuQMHMKagwUnT+Ays=
X-Received: by 2002:a17:90b:384e:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-3931e075496mr7459239a91.5.1786636598662; 
 Thu, 13 Aug 2026 08:56:38 -0700 (PDT)
X-Received: by 2002:a17:90b:384e:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-3931e075496mr7459199a91.5.1786636598194; 
 Thu, 13 Aug 2026 08:56:38 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f44de1esm3603538a91.13.2026.08.13.08.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:56:37 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, Francois Berder <fberder@outlook.fr>,
 Denis Mukhin <dmukhin@ford.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/7] bootstd: Fix crashes and memory leaks on scan/boot
 error paths
Date: Thu, 13 Aug 2026 15:56:10 +0000
Message-ID: <20260813155617.184928-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 17:59:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786636989;
 bh=LvFAzeya1yYX4e1nLYUprjBIluWuMGn6M1EyWN4OojA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Y7nPx49GT6AMINOicZ+5B2py8IkZPNf8DzQWUIuhV/duZBpqqjHj5yApuQqeT2/to
 gG2uW/883lAyxEAe9y6oDIHmwGAoUMWnBC/LM54cj6L92qTMbG/LfCzGPZ3+krLqAY
 XmisLSkBuMzpQ1O+DdMLducmlHGnPsbsrG87lJxzITPTSorBL/EHUWeoSYI9fMf5xs
 tUw8pemRm0e9KMo6lGR4iZSMJrKut4DaakyVo0owwIUeu5NQr1sondXgrKI/h8N2VH
 4ZZcp6Jh80x3VieyVdtUJVZ/vspQP6b401AyHQqNYFdrZnw9dHzrDJ/9GNjP0Rudk+
 Q4BEkqIekX7G54sronfYXpgdgrLW1w0wB6v9YvdQyhYc9RIvXJtntWhiWqC7R3CAd5
 CfevP8U1HWvWh6rbcFighpXUVd0DjZ45cpXJGqpGmVzjxjBFQydN3KJgDkaaRP0X4Y
 h0ENaiJzD2rT/cSARHM9MOiTqHwjh+t9xSZx7kfiU5mf8USU2Wx7Th5pvKugu4sosm
 s5sCNDVoeAchad3pVAPtIJQXKclByUfFJb5Y0TDJLoQkSDCjTXgEt6Snqby7Nf1C2I
 gD9PyBJquglY6/+SCPR4OsdsyB9I3BBOKkR56xC6KL4TDQfiML78KCpT9VWZ+oCa4N
 IAMhe0N4tnuCfWDfvareZdfM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Y7nPx49G
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

This series fixes a crash and several memory-safety problems in the
bootstd scan and boot error paths, most of them in the RAUC bootmeth.

The starting point is a NULL pointer dereference in the RAUC bootmeth's
get_slot(): its loop condition dereferences each slots[] entry before
checking it against the NULL terminator, so a BOOT_ORDER environment
variable naming a slot that is not configured in
CONFIG_BOOTMETH_RAUC_PARTITIONS crashes U-Boot. BOOT_ORDER is written by
the OS (RAUC) into an often disk-resident environment, so a stray or
corrupted value must not crash the bootloader (patch 1).

The regression test added for that fix then exposed a chain of further
problems on the same paths:

- The RAUC scan error path frees its private data but leaves
  bflow->bootmeth_priv pointing at the freed memory. With
  'bootflow scan -a' the failed bootflow is stored, and removing it
  later frees the pointer a second time (patch 2). The ChromiumOS
  bootmeth has the same problem on its cros_read_info() error path
  (patch 4), and the RAUC boot path has it as well once the boot script
  returns (patch 7). bootmeth_android already clears the pointer; these
  three patches follow that pattern.

- Several RAUC error paths return early without freeing their
  str_to_list() string lists (patch 3), and the strsep() parsing in
  distro_rauc_read_bootflow() leaks its two strdup'd source buffers on
  every call: strsep() advances the pointers to NULL, so the error-path
  free() calls are no-ops and the success path does not free at all.
  This also removes an interior-pointer free() that would corrupt the
  heap if the two configured lists ever had different lengths
  (patch 5).

- The bootstd scan loop abandons every failed bootflow candidate
  without freeing it: the next candidate's bootflow_init() memsets the
  struct and orphans the previous attempt's allocations, starting with
  the name allocated in bootdev_find_in_blk(). A single failing scan of
  a RAUC-style MMC leaks about 1 KB across ~30 abandoned candidates,
  and scans can be retried indefinitely from the U-Boot prompt
  (patch 6). This is the only change outside the bootmeths; bootflows
  returned to the caller (BOOTFLOWIF_ALL) or stored via
  bootstd_add_bootflow() are not affected.

Patches 1, 2 and 6 extend the bootflow_rauc test alongside their
fixes: scanning with an unknown slot in BOOT_ORDER (SIGSEGV without
patch 1), rescanning after a failing 'bootflow scan -a' (double free
without patch 2), and a ut_check_delta() check that repeating a
failing scan does not change the number of allocated bytes. That last
check also covers the leaks fixed in patches 3 and 5. The cros fix
(patch 4) and the RAUC boot-path fix (patch 7) come without tests
since sandbox cannot reach those error paths: there is no
crafted-image fixture for the cros case, and env_save() fails on the
sandbox 'nowhere' environment before the RAUC boot path reaches the
free.

Tested with the full sandbox unit-test suite (test/py -k test_ut, 951
tests) and the bootstd, bootflow, bootdev, bootmeth, vbe, cros, android
and efi_bootmgr pytest suites, all passing with the series applied.
All patches are checkpatch-clean.

Aristo Chen (7):
  bootstd: rauc: Fix NULL dereference in get_slot()
  bootstd: rauc: Clear bootmeth_priv after freeing it on error
  bootstd: rauc: Free string lists on error paths
  bootstd: cros: Clear bootmeth_priv after freeing it on error
  bootstd: rauc: Fix leak of the strsep() source buffers
  bootstd: Free abandoned bootflows while scanning
  bootstd: rauc: Clear bootmeth_priv after freeing it when booting

 boot/bootflow.c      |  2 ++
 boot/bootmeth_cros.c |  1 +
 boot/bootmeth_rauc.c | 37 +++++++++++++++++++++++++++++--------
 test/boot/bootflow.c | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 8 deletions(-)

-- 
2.43.0

