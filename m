Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99EEC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FE9980AEC;
	Mon, 24 Aug 2026 16:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J9DuNuVdTX_a; Mon, 24 Aug 2026 16:43:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589836;
	bh=U8SHpRUY6PKX1gUMJJN2098fJmvFLFdwiSrUA8BaZDk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qyU2JCcULXPhTHIgwUZfmnRz08z9Eecm10VdABfWbNYVtNH/AJz55jOz0NW+Y1vsf
	 G1Cn6DbcWTHCLDyIEvkpTqj9a17l3BwLiE8ULlu2xNP9enqsLar6IrD4bPR212tqDh
	 qktF4eye+l/f+WKpqKfjtcPieAYs3tWvbGgN6vfwuBr63U0gZXlc0lF+4uaQwY7jbF
	 XLYm67RvJ/ruuZIP2IAyKTneFnqTniUC04UV5McoOkWQE8Xip4K9Vs8w/X+633kG4C
	 kFL3ALcMcmj/qxaenB6iPs99J3REl9LWO4fJA4PxlH+xJPLgyhkO/sYWuXEiwc0u1e
	 mHAl3u/Ox6OOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72C27809BB;
	Mon, 24 Aug 2026 16:43:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6ABA9396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4EA4C80845
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GJNfBPZFPfpT for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:28:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mNYgzV+G
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87145807B8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:01 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c166ec26696so31562166b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585280; x=1788190080;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U8SHpRUY6PKX1gUMJJN2098fJmvFLFdwiSrUA8BaZDk=;
 b=mNYgzV+GvZQFefIWSeWVGFpXdcpAXIeCv1RsMKcs7jUY9LJj8kDwa0rDZVUKrwpq+r
 VgcoI2KXjl5IhK3yhjVmuN8WQV0ih0v96lX3edWNW9k2W5ODZfDjdjpPjAEmd5a7Z7qM
 XLDOGC7AjBXsivd/dbkWBc/nhMt/iPqHFlqMtR5cygBJS+x1Am4ZEbN/PCQ1Bm+4HPTS
 usPG6CEvTB0XCSRBDXLCDL7NRqfTop0LMNb9W2pNq4aQJldV0BGEXG11Rs4SjMcoTIPj
 GwdzkTk/VZJBqofraMuzJtpqWdTK+w+2aUZVhJAt/yVdWVLxMCLxETDE/5VcsVTctYtt
 C6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585280; x=1788190080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U8SHpRUY6PKX1gUMJJN2098fJmvFLFdwiSrUA8BaZDk=;
 b=XBydBlD1sQkMsWQVgN2AGU1Xq12JoJblbU3UAgQJyDrbjYtQ25f+9VHUKDhN8HU+DP
 tH7qPfixZXMC9dAK4iDChtw7w+ry4lGrxwIAskWL7LC+WrNbvmNlLXTp2gKCVCHT3xAp
 18gBRBt3DfZDQeVOlxJl5ZWDLB+85RGmSqAyrZr2ZMsFi4XcJ2cEYwSJZhERSsLXtniU
 Q3LCqrgNxGUi56kCy9NYsOLCvOSTpG5A5YZBskFGjMV4RXjjvexzZP4ZE0j48aB1L3tr
 eJIH56y00GwL04+c9plOYezLdSgBugkupuwBQI7KsDd0TYwsxJ5D1qqpqgI+vUmORjrb
 yJFw==
X-Gm-Message-State: AFuF++ko5HcDVjclSYByS9i0O7mvz0aNnv60LJNaq+lJXYSNbM7LvwVl
 yyZxW0r8/FHzq/0bRiFrdg1GujQSI9wXqXXTXroPvrC/pvDlHrw24OoIyAzU4wrdPqRt0CWB8C0
 klrpw
X-Gm-Gg: AR+sD12xynjjTcr254v0c0ERXe/hrcakuYtEqkUZGuWN9KhsH/w97T5j9YByJC/HU/u
 TCsGlsmmGPuUS8Gz/xi8EbywZ3iXcqWvmsW8j7PsJD8sONihbt8tJn8NYGoFcP79q4WmvL/cTAD
 4xF0rg8pwqXVXwCvXZzifyM+5iBegmTj6eyQQyX6BBY8ckGi2ySEw/wT0hHVA0z+zS9w7RaC5QA
 +atDEGVuRUlpsElPjYU+xRAtxODlt/WRg3qVwv4XZ/5/OKcte3VpZBYD8USi4jKBtqAJj1zmCB1
 198mhZgN5kDk0vF6ayPLiEjo6sSK80rINANs4xeiODQNDMBOX7Knhpsnu0l4indYVGClWXmWs0g
 bpsUFwz8X0bDGSwV/5WDxKfUc4SnItwvhsmSvO2IzSNDnhdW8SCKuAdmzwEUkaFwmiz0VH0LI0H
 I5rfmRcEBcF8I6u/mv5yWM6nNSl6zqrcBrv3g7tzwSPNKtfc4jvSSg4jwls4bYGCm5uRxK5myAZ
 X29B4I+eWt+QoYxQveR+gqy2ulh9Jrp
X-Received: by 2002:a17:907:c19:b0:c21:6f8c:231f with SMTP id
 a640c23a62f3a-c246a2e942emr1714307466b.1.1787585279737; 
 Mon, 24 Aug 2026 08:27:59 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa1dsm1247744766b.56.2026.08.24.08.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:27:59 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v7 00/63] usb: dwc3: part 1, reset and import from Linux v6.16
Date: Mon, 24 Aug 2026 17:26:31 +0200
Message-ID: <20260824152734.159794-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

Hi,

This is part one of two. It resets the DWC3 driver and imports it up to
Linux v6.16. Part two [3] follows right after this one, it makes the
tree build and work again.

Part one on its own breaks the build for every board that enables DWC3,
and USB gadget stops working. That is expected. The two parts have to go
in together.

The driver was forked from the kernel v3.19-rc1 eleven years ago, in
commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel to
u-boot"). After that almost no kernel changes came back to U-Boot.

Part one is three steps:

1. Re-import xhci-ext-caps.h from v6.16. Marek asked for this one to come
   first, since the dwc3 imports build on it.

2. Restore drivers/usb/dwc3 to a clean v3.19-rc1 state.

3. Import the dwc3 directory once per major kernel version, from v3.19
   up to v6.16. Each commit is a raw snapshot from that kernel. The last
   two patches re-import epautoconf.c and udc-core.c the same way.

The import commits are raw kernel snapshots. This is on purpose. It
makes it easy to see what comes from which kernel version, and to
compare each import with the matching kernel release. The commit
messages say this too.

The branch has both parts [2].

[1] v5: https://lore.kernel.org/u-boot/20260716134305.614278-1-anders.roxell@linaro.org/
[2] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v7
[3] part two, subject: [PATCH v7 00/24] usb: dwc3: part 2, make the
    resynced code work

v6 -> v7:
- Split the series in two. Tom asked for this, so review and iteration
  gets easier. Part one is the reset and the imports, part two makes it
  work.
- Collected Mattijs' Reviewed-by on 18, 27, 33 and 34. Those were the
  four imports he had questions on. Every patch in this part has his tag
  now.
- No code changes in these 63 patches.
- v6 never reached the list in full. My send died in the middle, so the
  cover letter and the last patches went missing.

v5 -> v6:
- Dropped the commits that only touch skipped or preserved files from
  the "Commits imported" lists. Mattijs asked for this on many patches,
  Marek on the v6.0 import.
- Removed a stray "Fixes: b1a3ed068869 (spl: make args file optional in
  falcon mode)" tag from the v4.14 import. Mattijs found it.
- Fixed the "accross" typo in the import commit messages.
- Collected the Reviewed-by tags, 59 from Mattijs and 24 from Simon. The
  code is unchanged on all of them, only the commit messages differ.
- Four imports had no tag from Mattijs: 18, 27, 33 and 34, which were
  17, 26, 32 and 33 in v5. He was right on all four, and what he pointed
  at is gone.
- Moved the xhci-ext-caps.h re-import to the front, Marek asked for that
  on 61/64 in v4. The epautoconf.c and udc-core.c re-imports stayed where
  they were, he did not ask about those. Say if you want them moved too.

Older changes are listed in v5 [1].

Cheers,
Anders
Jens Wiklander (60):
  usb: dwc3: restore to original v3.19-rc1 kernel import
  usb: dwc3: import from kernel v3.19
  usb: dwc3: import from kernel v4.0
  usb: dwc3: import from kernel v4.1
  usb: dwc3: import from kernel v4.2
  usb: dwc3: import from kernel v4.3
  usb: dwc3: import from kernel v4.4
  usb: dwc3: import from kernel v4.5
  usb: dwc3: import from kernel v4.6
  usb: dwc3: import from kernel v4.7
  usb: dwc3: import from kernel v4.8
  usb: dwc3: import from kernel v4.9
  usb: dwc3: import from kernel v4.10
  usb: dwc3: import from kernel v4.11
  usb: dwc3: import from kernel v4.12
  usb: dwc3: import from kernel v4.13
  usb: dwc3: import from kernel v4.14
  usb: dwc3: import from kernel v4.15
  usb: dwc3: import from kernel v4.16
  usb: dwc3: import from kernel v4.17
  usb: dwc3: import from kernel v4.18
  usb: dwc3: import from kernel v4.19
  usb: dwc3: import from kernel v4.20
  usb: dwc3: import from kernel v5.0
  usb: dwc3: import from kernel v5.1
  usb: dwc3: import from kernel v5.2
  usb: dwc3: import from kernel v5.3
  usb: dwc3: import from kernel v5.4
  usb: dwc3: import from kernel v5.5
  usb: dwc3: import from kernel v5.6
  usb: dwc3: import from kernel v5.7
  usb: dwc3: import from kernel v5.8
  usb: dwc3: import from kernel v5.9
  usb: dwc3: import from kernel v5.10
  usb: dwc3: import from kernel v5.11
  usb: dwc3: import from kernel v5.12
  usb: dwc3: import from kernel v5.13
  usb: dwc3: import from kernel v5.14
  usb: dwc3: import from kernel v5.15
  usb: dwc3: import from kernel v5.16
  usb: dwc3: import from kernel v5.17
  usb: dwc3: import from kernel v5.18
  usb: dwc3: import from kernel v5.19
  usb: dwc3: import from kernel v6.0
  usb: dwc3: import from kernel v6.1
  usb: dwc3: import from kernel v6.2
  usb: dwc3: import from kernel v6.3
  usb: dwc3: import from kernel v6.4
  usb: dwc3: import from kernel v6.5
  usb: dwc3: import from kernel v6.6
  usb: dwc3: import from kernel v6.7
  usb: dwc3: import from kernel v6.8
  usb: dwc3: import from kernel v6.9
  usb: dwc3: import from kernel v6.10
  usb: dwc3: import from kernel v6.11
  usb: dwc3: import from kernel v6.12
  usb: dwc3: import from kernel v6.13
  usb: dwc3: import from kernel v6.14
  usb: dwc3: import from kernel v6.15
  usb: dwc3: import from kernel v6.16

Jerome Forissier (3):
  usb: host: re-import xhci-ext-caps.h from kernel v6.16
  usb: gadget: re-import epautoconf.c from kernel v6.16
  usb: udc: re-import udc-core.c from kernel v6.16

 drivers/usb/dwc3/core.c            | 2961 +++++++++++++----
 drivers/usb/dwc3/core.h            | 1087 +++++--
 drivers/usb/dwc3/debug.h           |  432 +++
 drivers/usb/dwc3/dwc3-am62.c       |  424 ++-
 drivers/usb/dwc3/ep0.c             |  763 +++--
 drivers/usb/dwc3/gadget.c          | 4776 ++++++++++++++++++++--------
 drivers/usb/dwc3/gadget.h          |  114 +-
 drivers/usb/dwc3/glue.h            |   36 +
 drivers/usb/dwc3/io.h              |   51 +-
 drivers/usb/dwc3/linux-compat.h    |   16 -
 drivers/usb/dwc3/samsung_usb_phy.c |   77 -
 drivers/usb/gadget/epautoconf.c    |  292 +-
 drivers/usb/gadget/udc/udc-core.c  | 1890 ++++++++++-
 drivers/usb/host/xhci-ext-caps.h   |  158 +
 14 files changed, 9864 insertions(+), 3213 deletions(-)
 create mode 100644 drivers/usb/dwc3/debug.h
 create mode 100644 drivers/usb/dwc3/glue.h
 delete mode 100644 drivers/usb/dwc3/linux-compat.h
 delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
 create mode 100644 drivers/usb/host/xhci-ext-caps.h

-- 
2.53.0

