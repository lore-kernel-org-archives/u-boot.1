Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D525ECD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 20:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 016338056B;
	Thu, 18 Jun 2026 22:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rcuszVrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49CD680287; Thu, 18 Jun 2026 17:48:05 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 251BE8005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A66203FA74
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781797682;
 bh=OSbIII5wmuB40hMI/FDzQqYnyAd/YLQ/yRe9wQh0ZWU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=rcuszVrA0EJONNK5p+IAZzhTYbY961wiqu7Xct37XjLzXEQcsoIKxb+KNuFH4vQcR
 DUWwfk2vEeQ8mqsPoDZMKO8T00Fi7xUSPbBGGo5c6BQ+pWpU7ypOU8KKZef2slmkIH
 31yy0Ntc02fHgpz6hhbv485fp5+JZEMsPCaR4WvHBPm2KvCLsgU4MuxSPfdFPSGc9A
 0EV2XsnIVKCufSrHHhPPlbkPMNjm9HqyikmfqQhGcUsJdjyXd8FlLkSEWQD6Cu1utE
 uc4ApulZ6e0j2cx5qhx04yNKtotqda7LQKBZOtYkJ6QrNevpymQloYlBkUmW2bx1UD
 QtPdIO6bpdo9tjELqThmH+c+DnwP5UkJXEdhUrCM3whSE8SWzAPtt8IoRmMDQVE6U+
 5V1Gxt+gUWpgJuxuGeoVxGw4BQLEI9fXsyIkPWBs9+bbffgB1IeDRG8fDUKKQL1kl2
 J3Vpd7WaoZhTB+vTsPA6n7u8/nWaUUuWfdIiCVmTorndNek65Y3KDikiaSxutAJjxg
 dh+QTZlmUI4WLIOXnrgXfWJWJeddHAnJK05os4yMc/BQfZzFe8jwmQVTqB9LRCL0x7
 JLUdnHrd9H+mHvaPY8N354/gWmnCEYuwK+in+yceNJQCLanNq7o4TQs7l8mYTWtT0I
 baCKyA6RHb8tDuctnduX8ZHg=
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85798977dcso728703a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797681; x=1782402481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSbIII5wmuB40hMI/FDzQqYnyAd/YLQ/yRe9wQh0ZWU=;
 b=IWnS+4hvSOhBKG2rksp079eXiDZUCe5La1DgEOzlequqhxXcFgB+zOxrc1CSVoCfq1
 JBlkpC4fOfrDGUsFgDUiwPJnw23l1a1Fog42JZo1HkbhJuzgD5gnf6Y4ps3pQsUe4WMf
 lXJ6NhdSzPa9S7C63M+zHvUH2hPxGZ0/+F2VjXjxpJjb88CpyO1TRlesxeX68EsjPHOC
 LmQufxEggHAJnugCsB39WrfMOtpuk0wGLBcWiRVH4JtXAwFqYngVnZnV1ylbBGAec2TR
 d3BDdt1bT1WjlRfTj5RLCBTIgTZN+qSXIpx4idavxYrEhMKUtyGRuo9l/cWivgB4n/IP
 00Ew==
X-Gm-Message-State: AOJu0YxySHSJ49v30RiVZwIQFvo/z5axzk6d8ItPd787ntvD/Y88kOeB
 OX6CVq+9oymj1l5L9GqN+/2UQTkNygh/65q+cgJIzvL3yz9X3BX6ZsXRyihbwzuGMpmJB+q/VPj
 MJ3adli7ZCnjqBSP5HcTh2rBBVveX66clhTGIuOEZng/H3eMCgjQiw7WGCb42NVwXa52v9ofSiD
 5Ogvk=
X-Gm-Gg: AfdE7clx4KdWhRCJywxaGNoWlEBqUjaOBnGauHrYApqlOuofmbtlWnVzIyKdEUbQReD
 J7+ihTWCh0ZnQ9d9GYMA84uJbaBsTet4p/5myiLaZf9HtaSlPMkpzUG3n0SWwLlb4GBZXCzQZdb
 /1s4KotWOf1Z5lgjSVJlMtmW9iHNoBvGT17Y/gfkChycYnvOiLcbFojJARhLHU6Gkgkp8z6d0WG
 46uDx1gOp1tOLQumFMA2byHpOpOU5TGY5o6CIg6251WdyxNicQd1p2NfHohQYU4q6VSNin54Z5V
 zI89VgatVeMrcvubRgpiE9dCZI1qedKBdfbO8ImbcrmEHy7sHeGQnQ3BCOmwVRVl2T4eoeQAyMB
 eNTpU6cOfooJampFuDkOY8/3FW8Ta1XR/7lhjyV9nc/YIlfU6xnX0SHt2p65GhVXgQTx6KHXNzb
 DgA2ff
X-Received: by 2002:a05:6a00:438f:b0:842:670d:f6ff with SMTP id
 d2e1a72fcca58-8453b202947mr4849596b3a.44.1781797681027; 
 Thu, 18 Jun 2026 08:48:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:438f:b0:842:670d:f6ff with SMTP id
 d2e1a72fcca58-8453b202947mr4849563b3a.44.1781797680614; 
 Thu, 18 Jun 2026 08:48:00 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b049120sm19860127b3a.55.2026.06.18.08.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 08:47:59 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/2] spl: fit: bound external data-size in load_simple_fit()
Date: Thu, 18 Jun 2026 15:47:45 +0000
Message-ID: <20260618154750.180675-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Jun 2026 22:42:13 +0200
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

This series closes a pre-authentication memory corruption window in
the SPL FIT loader. load_simple_fit() in common/spl/spl_fit.c reads
external image data from the boot device with a transfer sized from
the FIT data-size property, and only verifies the image hash after
the read has already happened. data-size is in the exc_prop[]
exclusion list in boot/image-fit-sig.c, so it is not covered by the
configuration signature and stays under the control of anyone able
to modify the boot medium even when CONFIG_SPL_FIT_SIGNATURE is on.
An inflated value drives info->read() into the destination before
fit_image_verify_with_data() can reject the image. The device-tree
overlay path is the sharpest case, because there the destination is
a fixed CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ heap buffer rather
than a sized load region.

Patch 1 adds a max_size argument to load_simple_fit() and rejects
both the raw data-size and the block-aligned transfer length with
-EFBIG before the device read is issued. The data-size property is
read into an int, so a value with bit 31 set arrives as a negative
number, and comparing it as an unsigned quantity rejects that case
too. Callers that load into a memory region pass CONFIG_SYS_BOOTM_LEN,
the same limit spl_parse_legacy_validate() already applies to legacy
images. The overlay path passes the size of its temporary buffer.
The two guards share one diagnostic printf via a goto to a common
label so the bound check stays under the SPL SRAM budget on size
constrained boards such as am335x_hs_evm (CONFIG_SPL_MAX_SIZE =
0xb0b0). Measured cost on that defconfig is 57 bytes of .text,
leaving 114 bytes of headroom against the limit.

Patch 2 adds a sandbox regression test in test/image/spl_load.c. It
builds a FIT with external data, then rewrites the data-size
property in place to a value far beyond both the image buffer and
any plausible load region, and asserts that spl_load_simple_fit()
returns -EFBIG instead of overrunning the destination. Without the
fix the test crashes inside the test-harness read callback when
memcpy() walks past the small calloc'd image; with the fix the load
is rejected cleanly.

Verified on sandbox_spl_defconfig: the new test passes, and the full
SPL unit test suite reports 20 run, 1 skipped, 0 failures. Also
cross-built am335x_hs_evm_defconfig and am335x_hs_evm_spi_defconfig
with arm-linux-gnueabihf-, both within the SRAM budget.

Aristo Chen (2):
  spl: fit: bound the external data size before reading it
  test: spl: check load_simple_fit() rejects an oversized data-size

 common/spl/spl_fit.c  | 41 ++++++++++++++++++++++++++++++------
 test/image/spl_load.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.43.0

