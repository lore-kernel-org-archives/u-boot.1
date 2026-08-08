Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629ABC5AC82
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 02:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ED3C40802;
	Sat,  8 Aug 2026 02:22:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tVKrXFVoZVf9; Sat,  8 Aug 2026 02:22:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85EF6407FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786155770;
	bh=Hic+vnBb48EpyDlEaYzlTv5uWYqAAZkZkcDA9LD8zvI=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=ap0gibXKtZvJVqZuBuOSaz8YmNUArdr0a8rNiz0Lf813F8+daCqfYsQCfwmemrfGY
	 jbj0TRi2o4A44OX0rdkNC2Z0QcUcPPrR6KqLC+ea29VVuhY0WeATg+Ig51SGD/sOyf
	 kdkLmBl0eVvSx4L7yA9rKn/rchvKbkCuK+PIziT+ZlnJxs1Udusm9iK86nTRbajQ4M
	 PjavYG0psrhdp5o2Tq2dHZY4FUZCanbnfAX9NF9tx1m5igWrbxXEwQYwsSl8AEqKJ8
	 9cUp+MjMmfjV7Hv0dYDBXXVAhmKRAlzflz2x0aXVUSZEsPWTu2DnK1JJV8yCaSCFo5
	 HQlduFDjnXSyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85EF6407FB;
	Sat,  8 Aug 2026 02:22:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 99C6C2B6
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 00:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BA64407E3
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 00:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ch8knRZ5rIQO for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 00:45:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3AEBE407E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3AEBE407E5
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3AEBE407E5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 00:45:05 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BFA4A3F9C0
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 00:45:02 +0000 (UTC)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso134841a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 17:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786149901; x=1786754701;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hic+vnBb48EpyDlEaYzlTv5uWYqAAZkZkcDA9LD8zvI=;
 b=b1xJGHvoQv2BECIYoP4qh4iLGBfe4Rygn1cIZm2uvUx+IorbszzbMa+04jdGuj2HIx
 bA/qvmFfAwGLHlIUkXK+HaadCmeqkBWksYhNNnCChYtpmuTeFQbPBotZvujhPgMYqLW9
 lO+VNnYobaGPkBZP6ImtjeFgRYBHLynJw5uttc+zwVykSwCrsS7PjZCDCPC+GlBWr2kc
 W4YgZO8h7MPVdlpOzk6QSOQxWBY1QXKl4tSaOK73UKLq87tlAUAZHyhjwM/FXXCY3IY/
 toFJy9+TLcpKiTDs6WKIqfdktBwzwJSJa937+lP+hLSYo9bTL4K68xpicDWHF1jj1bKy
 QKYA==
X-Gm-Message-State: AOJu0YyCemgOmPKMpOcmzCtA4Hc0uP/lB5hfm34kKEP2giTXD167/E0C
 GQM64biBunlAtQH42l3K8JsAHHzbT3eDhaMO2BFDuA2IzoFg1q3a++W8ERxmw9DIsW+8JpwEuuw
 hZuAArFLk8+75GNBk7wNsPIp0dl7jvTwa6VmMTnz7UGSCQE7zC/83ixHgS9XJmRC9OBwmwXv7nx
 shHyLnDD4AqAhsh6AzhA==
X-Gm-Gg: AR+sD13AvoNafrNEu8GqTjn+0D5UHH0/atGfi8cXID7+k+OIY54tOHkMVvLE9KZaXjt
 VVqpZAFpNGdkUlnICayeg8JC4Ro9sWXdNCm04BtwV3fu4u4WpRH0RkJLD6w3ZIV80WBr4OVtupD
 /rzDNtCskG30bPa3uEN5KO9IiRVy5xJu1gZXMkbGbBOQWkyu/ABseRYaBQC49hM2Ml2+8H+Hmtg
 2o56XfShjRBjF1zQBRIlMqIsIAqiY36mYgMz2pwPIJ3egp1LjgG69vcf7v/FtDG2smOlbb+bMt9
 BFGMlxp7aaVF/PjbZFRvmEUMyhaVIXVkKwtM+e9OnR5PvtlIdopBiFm2CGtALgk/8jpGT5JrTKh
 ZosLhG0J4aFAOWg9lnU+MgJWfEd50VWCR5xWVkMw7B+lMcKgUpJHKuCEwjPGLClBaXjVS3w==
X-Received: by 2002:a17:90a:d010:b0:38d:eaec:4396 with SMTP id
 98e67ed59e1d1-3903c58bdd2mr26539642a91.11.1786149900911; 
 Fri, 07 Aug 2026 17:45:00 -0700 (PDT)
X-Received: by 2002:a17:90a:d010:b0:38d:eaec:4396 with SMTP id
 98e67ed59e1d1-3903c58bdd2mr26539614a91.11.1786149900554; 
 Fri, 07 Aug 2026 17:45:00 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925ff912c7sm4316935a91.17.2026.08.07.17.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 17:44:59 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/2] gunzip: Fix spurious Z_BUF_ERROR in chunked gzwrite
 decompression
Date: Sat,  8 Aug 2026 00:44:32 +0000
Message-ID: <20260808004437.4367-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 08 Aug 2026 02:22:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786149902;
 bh=Hic+vnBb48EpyDlEaYzlTv5uWYqAAZkZkcDA9LD8zvI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=aTR/wYN2YRRmfvBE6PHAuOrD32RZivki9KKTJK/LDFDbAX1ujEFLh5TO+GI4ozcOO
 9NCvf3s/GztQOLz5f7/Z2ezgjp8AwaJRA3Xphttx//8cutQzT2/Qt1ZUQCVEqQEDsZ
 aYhnb9yphFH2OSGN5vmYMtA0Rkib4PVJHuHbINjFvMzez5YU2mkgASZSjtBthVeWZ2
 zltgdO/WT1Bi9gQpjPvwBkLZMPC1XayLPm8EdV3+PDzkHr5FAnCQsFVihZ4E/dDNEP
 Is5Un0JzyGm8xoujNNekzvotRdIcxgr1Wv1FofMY3/LVFc68+ncWWNPov7sGkleEFD
 SVLcDBYdAyBzEmgzxig/cXS+2tUi2MMHAm1jIwrXrgnrcRWAV2g6QsIrL3f27m9qtb
 2VGVYl7N5IME5AL1gjkUl92ENcSubuFqpgdi4YZbNMZ6z6i9Pen4RM2LGcVtqZiXX1
 x0XSUi2PLYM064IEHXdLxVccXnDcMEa4rI7ogWHR+RZZeD8iFLToYQALfr+DX3bQyg
 X+3is++Bp03DlYMF56cj08PiHg4C1ft/jEla/xG+N0hXe5YKCMB5hVWpabbSIj8uvm
 j3FjJghPISpuizkGD88GaLeXA3kuEWTN48omquKlQ33YtLpnpEEYZIDJY+wtpfdAjB
 NKpx9t2dlS56qtY8fEoRWByI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=aTR/wYN2
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

The dm_test_cmd_zip_gzwrite sandbox test occasionally fails in CI
with:

  12582912/16777216
  Error: inflate() returned -5

The chunked decompression loop added in commit 58e523fedf48 ("gunzip:
Implement chunked decompression") treats Z_BUF_ERROR from inflate()
as fatal. When an input chunk is exhausted at exactly the same time
as the write buffer fills up, the next inflate() call is made with
avail_in == 0, cannot make progress, and returns Z_BUF_ERROR. Per the
zlib documentation this only means "no progress was possible" and the
call should be repeated with more input, which is what the reference
implementation in zlib examples/zpipe.c does.

The failure needs the consumed/produced byte counts to line up with
both the chunk size and the write buffer size at once, with no
buffered output on the inflate side, which is why only certain random
payloads trigger it. Note that the failure offset above is a multiple
of the 1 MiB write buffer while gzwrite_chunk was SZ_1M + 1.

Patch 1 makes gzwrite() refill the input chunk in this situation.
Patch 2 adds a deterministic regression test which builds a gzip file
from two stored deflate blocks by hand and aligns the chunk boundary
with the write buffer boundary exactly, failing reliably without
patch 1.

Verified on sandbox and sandbox64:
- dm_test_cmd_gzwrite_chunk_boundary fails with -5 in 20 out of 20
  runs before the fix, passes 100 out of 100 runs after
- dm_test_cmd_zip_gzwrite fails 17 out of 2000 runs (about 1%)
  before the fix, every time with the same signature as the CI
  flake, and passes 2000 out of 2000 runs after
- dm_test_cmd_zip_unzip keeps passing

Link to v1:
https://lore.kernel.org/u-boot/20260806103720.1026454-1-aristo.chen@canonical.com/

Changes in v2:
- Assert on env_set_ulong()/env_set() and move the test body into a
  helper so gzwrite_chunk is unset even when an assertion fails
- Name the stored block constants and derive buffer sizes from
  sizeof(raw) instead of repeating 2 * SZ_1K
- Use mmc_dev_desc->blksz instead of the literal 512
- Patch 1: no code changes, collected Simon Glass's Reviewed-by

Aristo Chen (2):
  gunzip: Fix spurious Z_BUF_ERROR in chunked gzwrite decompression
  test: cmd: Add gzwrite chunk boundary regression test

 lib/gunzip.c     |  10 ++++
 test/cmd/unzip.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 126 insertions(+), 2 deletions(-)

-- 
2.43.0

