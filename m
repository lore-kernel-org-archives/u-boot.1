Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA488C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B0584AE7;
	Fri, 10 Jul 2026 20:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZuRF/V52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 253A584AED; Fri, 10 Jul 2026 17:33:58 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B32E84A3C
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C08433FA6E
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783697635;
 bh=6FOrNEgl3de6XYvHqrcdPY5tiF9oLqlUh0azD/EaTQ4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ZuRF/V52TyUAaf+L+QH0hxJBnJJ5BtYtSUdzHp1RwSGgYbYsEwMNEnOof5ff2P6cG
 dWRzTS6ucfbzdu0hGdBOZik9qy4Ypd1MWXwGoOClyHLqvTiEhRjiSB4SMKszRrMvRF
 tD0DkZ8AQjlRRrnK7ikyGm3Kq/zy0MPXpieibcVFHJzgWsqd1btZGY5BsRKIVnMAgt
 zWPL/JFKoEBup3VQOfAdBE+3i1XxJRrI65F0Ng1AsW+Kk51XE/OFqc3KrWDD6TVaLn
 KfLhJeoqupAs0tx6ylKHN+fr8uwlw9W3WGxu8fmzvWnjbe0aC38WFX/VckBSpXgxTs
 hfq7WrjA+Xe4AzS5QRFa8r0h9NsnQjf2+fNlplvc64vZj6LcBWXtYnDhermZ2+yd7H
 PzWJMWnxZmvmo3phTbjeuBExtcWipAaFiQPKTm7/+qvBa5DZQxDgoXhd/HQxfJr+Ni
 ika4gvwLSB/lFMl7xazafzoiyk4ztj/3NweZfpgamH29EyKvIfXVa7XN9BMQnGWSG5
 u0lMOMBqs2VF0kjR+RthdERd47yG/9OxHSdAUmz0nT6acHzcj+cbWwyXcVvw92jYpo
 SnaUe2ZFysttJw66rRkXZBDenk8HmNTSqgQ5Piv3nhAvSmN5Lf3dIJrxqKNP2oGzHP
 1vhN2FT4xnNJsHfs7kWZm0OA=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso13960535ad.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 08:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783697634; x=1784302434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6FOrNEgl3de6XYvHqrcdPY5tiF9oLqlUh0azD/EaTQ4=;
 b=PzxaoMskT513CP6yKWXC0bvY1jPQfP+tkE87dsm26GEQKk9yKWOpJ4OH5c2JgVerzQ
 mn/hhdhV+370mo61I5TpdyduqKSR8Qt9Af91Mp8Pojgc4YeX++l8PFNLNa7mEz9PMk0h
 hHSBpaXOk81UjW0jjzUZiUkOhekspE9JVqNA0hAo+F30xt9WcRF9sYLIgJox7ef2HrPY
 L8itJ9djiQCUAJXzrK/3ovhcdD/w4DSwP9/uqorcY+TbpYawwP6yHf/MjaPqY82GBG9J
 ZPh/SEWAIg5T/NAtETdcQfLjro/xFhwNI6p6nwKvAcVG1te6H/ogpE2SNR5D0EDt5ktT
 Ucjw==
X-Gm-Message-State: AOJu0YxialCmzV/eSqsc5+xaIDCk7t36qeF0+Y2atpst4z0zk3BSmr3R
 pAkS6XEPLfJcndoklf1JtU4bkABZngGuZUmasmwPjXY90F/NCWaTukmE6GPMJOGQHEESWAFJDZ5
 iOIBex02rfb/5cTroQjHKq9xbELzHi58YeBp9kD5xjkt10WydjBaP2o2cYViXmgfKR31kV/sRRa
 y+xG0=
X-Gm-Gg: AfdE7cn2a6reHBhzsXmZHRkrusU2RfWoMbrZunYBMhb0sDvuaiRpQvKIpLFianaHsM9
 +1eommcNC9u4x6jfYYnfmWk2B7Edg5zHz5lwO+HCzXFwOX7CwgKdpPscKmWwInwmGoAH6H84pTb
 e5szj/nYF68AK+91NOhZdsj42ryMzpwY9wqWV0AfUa1oPtaOLqcILmZDkhEHxuAypC8a3fKakZl
 U9EK+hYVCmQyLZCUB/dvrsglIq2/U/8jCcmdFwEz7hbqsu4Dr92noUpu5pMjwlGLyxCGXJb+gwU
 FQHsya/DOd9ZGIGDgkzm56Q72Pv6KwJVa4e7BPTQEmsaHi6zr3L/jp70WbkaEPNJb190jXMcHG9
 xxXd2zhpvPLvagK+/i3QUx0d0vUQ9tjCB/nVLEVMgK7varlvtbBWMunVBbLT2OsRSTDFPLk3MAV
 E6M81k
X-Received: by 2002:a17:902:e5d2:b0:2c9:cf5d:d9bc with SMTP id
 d9443c01a7336-2ccea3a28f6mr124994185ad.35.1783697634235; 
 Fri, 10 Jul 2026 08:33:54 -0700 (PDT)
X-Received: by 2002:a17:902:e5d2:b0:2c9:cf5d:d9bc with SMTP id
 d9443c01a7336-2ccea3a28f6mr124993955ad.35.1783697633815; 
 Fri, 10 Jul 2026 08:33:53 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb882sm61390895ad.16.2026.07.10.08.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:33:53 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/2] tools: mkimage: fix stale data pointer in
 fit_import_data()
Date: Fri, 10 Jul 2026 15:33:38 +0000
Message-ID: <20260710153343.1839357-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:11:14 +0200
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

fit_import_data() in tools/fit_image.c declares the data pointer and
the name of the external data property outside its loop over the
/images subnodes, so both values leak from one image into the next. An
image node that carries data-size but neither data-offset nor
data-position then reuses the pointer left behind by the previously
imported image: the previous image's data is written into the node,
after which the import aborts trying to delete an external data
property the node never had. Since that abort path only prints a
debug() message, a regular mkimage build fails with nothing but the
generic usage text. The failure mode also depends on the order of the
image nodes: when no externally stored image precedes the malformed
node, the pointer is still NULL, the node is skipped, and the hashing
stage reports a proper error instead.

A FIT authored from a .its cannot hit this, because dtc-authored
images carry inline data. It takes re-processing an external-data FIT
in which an image has lost its data-offset, for example one edited
with fdtput -d or produced by another tool:

  mkimage -E -f demo.its demo.itb
  fdtput -d demo.itb /images/kernel-2 data-offset
  mkimage -F demo.itb

There is no silent-success path, because the failing property delete
always aborts the run before the file is written back, but the user is
left without any indication of what is wrong.

Patch 1 moves the declarations into the loop so that each image starts
from a clean state. A node without an external data reference is now
skipped consistently regardless of node order, and the later
processing stages report the malformed node with a proper error
message (Can't get image data/size).

Patch 2 adds a regression test that builds an external-data FIT,
deletes the data-offset property of the second image and re-processes
the result with mkimage -F. It asserts that mkimage fails and that the
diagnostic is present on stderr; the unfixed tool fails the second
assertion since it prints nothing beyond the usage text.

Aristo Chen (2):
  tools: mkimage: fix stale data pointer in fit_import_data()
  test: py: add regression test for fit_import_data() stale state

 test/py/tests/test_fit_import_data.py | 89 +++++++++++++++++++++++++++
 tools/fit_image.c                     |  4 +-
 2 files changed, 91 insertions(+), 2 deletions(-)
 create mode 100644 test/py/tests/test_fit_import_data.py

-- 
2.43.0

