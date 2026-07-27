Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB403C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 10:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1578780D9D;
	Mon, 27 Jul 2026 10:09:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FvKtJyr01s-A; Mon, 27 Jul 2026 10:09:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07CDF80CB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785146943;
	bh=CExqJFsIuRbnXlkdWCvXRLrAo0+mrQTbJe1e7TUK7pQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=erV0wzQQf6wn/YXiH7vPkRdcJUj8EyFFGHrJPte5aD+6ND+b2knW+v7IBGrqJhTbQ
	 Bef2QyEHj1zsxTWvT5MCkcU8GWXZ5zx+uCojaDcwehYSI4RKBd0X3eyUYSIqBvPgAc
	 dYpgMN4HHaLv8sfXWVWqkYJFHy7Ui+V5Y4ZKifpUa0G5H/jCUZuDBMd+47qSGHlAlR
	 i/NHzvv13dU4klYBSROSl3jDpl5oKhk0aqYq1SWEc6L34YmitTEeqITxIR9hqdRbbx
	 flR8C41hACVQF8LqL9vjkgK36dd0ZadB/DLNKqw1PY8RbBStYmyknX8C1rBoyIb0DF
	 s6ie8eiTy2TLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07CDF80CB6;
	Mon, 27 Jul 2026 10:09:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8615939E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 780F940109
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:09:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v9Gady0sKl1M for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 10:09:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 56FD240106
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56FD240106
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56FD240106
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:09:01 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so10089775e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 03:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785146939; x=1785751739;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CExqJFsIuRbnXlkdWCvXRLrAo0+mrQTbJe1e7TUK7pQ=;
 b=Kaa4FxXkx54FeSX0u8p6wzv3AUUkYZKPvNWA+XHJSwNR/7k+sf36VTeykrGKYI8Xiv
 Fk2Rqx+tF1wzMXXr7kreIn0cYEyZaX45RdQ53hPnzGsB2C5QDLOOeB0mjfdKdlf4ZiZr
 RhMSnS5AkAeeIQiHKgnVZvQyes3Hacr8gXXoaNaoYv5BmPHWDFduIqUMHmtxHioM8J42
 s7CHykTacgi3Ne1L2Dfzp0eCYdygjMZdI68T1SWyqJzLqcZE3ihCKtRDj0uVkhgIISG+
 VQyObToX4bkTmBqRapSMCD3dxUKkwU6Z68lTovF/vZtdS1otZPp8KYy8TWCRwS0TQwSR
 hCXg==
X-Gm-Message-State: AOJu0Yzik97lHiNO30OFt5RRmuVtxPkLYGieWboLuzJTZc56xCBlZigM
 RZU83Mihmxlx6rcAoyrqvHoOotyDu+pIv4ihP3AZvDB/NeGq5oed0A0T
X-Gm-Gg: AR+sD13ReeMl6VaC0XcZtPN0obqOeHO4DxiO3yGVbaWF2h7oy0Te3xtR0xJFo+xubwp
 wWmrKda5RlMuBpyiS9ouySRcQv/Qk+ri6FyrB3PHWE+Ds9oz7RkXiYisZ3JdkQAw1hDCi5yZfKT
 e+gTUC5V/V/LtNgoDSZ4vjEoGUH8hT+oHxtK6XgZkDZ+gdjwg73qJV2bP2z0zKeGRxnTemAUTVz
 KaMh4BovsK5CPh5tG/X/0v/F+Rc7M2RFxy4qyshmTehlWkMk1KWu/m6c85YPFJhIRQ1Kn8wIeuH
 AUh2jEcL/G6SS7BpUSGTr7NYjjKLUH/tykmmiUXIPhnZ+5Q6e1XIE1oQvTBTe9lVUfHuwptvI2d
 aTNk5LLE+/TKG5ob2Q+jdp7IoAIXszCMJgYCwI7c51EbbU2j7WBREUjXreubKzAEjepjkXNwMvw
 ksMulLTf3S+rwjLpYdLKH2KgUZahcbTEBDqUDeWiwY61vHOH7/m7V3++uEcXVwddELWu0Mgg==
X-Received: by 2002:a05:600c:4f52:b0:495:6482:9d8c with SMTP id
 5b1f17b1804b1-496c00307c9mr30462275e9.37.1785146939154; 
 Mon, 27 Jul 2026 03:08:59 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f5665f0sm256805375e9.0.2026.07.27.03.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 03:08:58 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: [PATCH v2 0/2] libavb: update to AOSP 1.3.0
Date: Mon, 27 Jul 2026 12:08:52 +0200
Message-Id: <20260727-avb-libavb-1-3-v2-0-fcad1a79af24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMQQqDMBBFryKz7pRkohG66j3ERdREB9SUpIQWy
 d0b3Xf1eR/eOyDawDbCozog2MSR/V6AbhWMi9lnizwVBhKkRSsJTRpw5eEciQodtUrXjdJ6MlC
 kV7COP1ew6wsvHN8+fK9+kuf7N5UkCqxr04jJWXKknvNmeL2PfoM+5/wDlGfZ7awAAAA=
X-Change-ID: 20260712-avb-libavb-1-3-f273645366da
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785146939; x=1785751739;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CExqJFsIuRbnXlkdWCvXRLrAo0+mrQTbJe1e7TUK7pQ=;
 b=pRVA8oeow6kvsk8genFZfAk0HtsI+jwsNc41gtsDqUkd+jlzHnkp9zORo2oGna1smD
 GtNJOdghiqNPGLaa63AMLC1EFo4OqqgqZkSIdT1vnTthcV5RJtOda4+PG6CNFtaC0Haq
 PZDRWyQfQuSGxhQcanZNi0QXocFaskj69Aur8qAWbiOXsmwhvL5/yZy+z7loXwFw3WGK
 q7CirZgqDu6DDOGdXs3Ne3QM/3JJbOUKkabkXDO4KXPvZZr4naxW5b73zNBIPhy1VjX5
 XvrnAlQqDIfhKvhJJZEcesxyjGdfivtwf/OJ87Ys2o1a8UnuC8u1r553RXjG9dyMHalz
 s15g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pRVA8oeo
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

The vendored libavb under lib/libavb/ has been frozen at a ~2019 AOSP
snapshot (AVB version 1.1.0) for about six years. A v1.1.0 library
rejects any vbmeta whose required libavb minor version is greater than 1
with UNSUPPORTED_VERSION, so an image signed by a newer avbtool that uses
a 1.2/1.3 feature fails to verify. This series re-syncs the library to
version 1.3.0 and picks up the accumulated upstream fixes.

The vendored files are taken verbatim from AOSP external/avb commit
a1fe228b8654 ("libavb: support chain partition no ab"), the commit that
introduced version 1.3.0 [1].

Functionality the library now parses:
  - AvbVBMetaImageHeader.rollback_index_location (v1.2)
  - AvbChainPartitionDescriptor flags / DO_NOT_USE_AB (v1.3)
  - AvbHashtreeDescriptor FLAGS_CHECK_AT_MOST_ONCE
  - AVB_HASHTREE_ERROR_MODE_PANIC

Scope / integration impact:
  - The AvbOps callback set is unchanged between 1.1.0 and 1.3.0, so the
    U-Boot integration in common/avb_verify.c needs no changes.
  - The U-Boot port is preserved rather than pulling upstream's
    BoringSSL-oriented crypto restructure (sha/, boringssl/):
    avb_sysdeps.h / avb_sysdeps_posix.c and the flat avb_sha.h /
    avb_sha256.c / avb_sha512.c are kept as-is. The SHA API signatures
    are unchanged, so the retained implementation stays compatible.
  - Per-file licenses are preserved (avb_rsa.c stays MIT OR
    BSD-3-Clause). The Apache-2.0-licensed avb_crc32.c is not imported,
    as it is unused by U-Boot.

Note: patch 1 is a verbatim upstream import and therefore triggers a
number of checkpatch style warnings. The files are intentionally left in
upstream (AOSP) coding style to keep them diffable against external/avb;
they are deliberately not reformatted to U-Boot style.

[1] https://android.googlesource.com/platform/external/avb/+/a1fe228b86543a21739c51352f5ce72f134fccfa

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
Changes in v2:
- libavb: fix the sandbox clang build by giving
  avb_new_cmdline_subst_list() a (void) parameter list
  (-Werror,-Wstrict-prototypes). Reported by Mattijs Korpershoek.
  The import now keeps U-Boot's existing local fix from commit fbfcb614e05
  ("libavb: Fix a warning with clang-15"): avb_new_cmdline_subst_list() is
  kept with a (void) parameter list instead of reverting to upstream's
  empty () form, which clang rejects under -Werror,-Wstrict-prototypes.
- Rebase on current main.

To: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>

---
Igor Opaniuk (2):
      libavb: update to AOSP 1.3.0
      doc: android: refresh AVB provenance and pin libavb reference

 doc/android/avb2.rst                        |   7 +-
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
 15 files changed, 383 insertions(+), 278 deletions(-)
---
base-commit: b635d43bca429500cb8ef20aa151cb5773b9a8a5
change-id: 20260712-avb-libavb-1-3-f273645366da

Best regards,
--  
Igor Opaniuk <igor.opaniuk@gmail.com>

