Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875AEC5AC79
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C95080E6A;
	Thu,  6 Aug 2026 11:00:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3bW2NRDABdLW; Thu,  6 Aug 2026 11:00:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEBA680D5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014053;
	bh=GrRpaz/haBCRiQStDW098u5pqFCcteqXPtH3qI4AC98=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=kSP4oD4q1Hruxf/9QdIZ+G3YuP+UvjKMxM4c1Jp1oobkNgXKUVxY1ISm73enVz+2E
	 YYGz7I7WKY3BsSwMrmjrrdSw/7d/HKb/nKeLiaMXed14X1ZhWZPuEspF/ykDayX8jx
	 jYNuw9KAg80Z12UpKdIWr+PGxYHCgRWzwGPNmT9u9DiHS9Csurijh7f3JbQW13axfX
	 cCKLrVWSpQJnGy88cvhKr8CNhGJt4eU0Mv3LHFuWLzfqRaptDj9SDYDeWuemcvhmRk
	 tsleLUzcFMWPgahQxKvCRUppLYVxzP2FNYiq3dKWn6ccN+B08iencZPy0ueOh0+QaM
	 r6U6EKLh9xeKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEBA680D5B;
	Thu,  6 Aug 2026 11:00:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73E7410E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59EFE40550
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:37:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OBPEeAubsSsI for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 10:37:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F0E504054D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0E504054D
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F0E504054D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:37:41 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9FA1E3F63E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:37:38 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cea6a46766so36326805ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 03:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786012657; x=1786617457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GrRpaz/haBCRiQStDW098u5pqFCcteqXPtH3qI4AC98=;
 b=d27hRNLgQv5qHq9MzURQvj0P9YhI4y70pJUUzlg1DhBxVyOkYgrFBkYW7iPCk4GFGX
 lOSTqpYlhNRhlHw6R0gVoxud+eDDJuYZOtEuzZtblF1nByMLzvEosL5HlL4l+9Ui/7Cp
 gBcbTSeCLXMhD34iAdd1EFcNdLCpIaI7yUm7W6/WKGYU5OqxMVyMIxFKe/vUBcbJN9bq
 RKn/8ZKQR/uY+32Ta8VJzdqXPpeWPxuYX8d3MxBKUJbEAqxYrNAF5kMjD374SvN1rp9G
 1iK/zqC9iqG+Rzwi53hcPyhSvjlba1Sr+5zaHfHsPSwRFKuVujZrSPjfbHXnOVmL22lV
 3dxQ==
X-Gm-Message-State: AOJu0YxZQTMYlH5s605pEs3Vdr8sT5zY6Yy8rf5vD4FZ0SZiqMkFk+mL
 s8/pt9DY9lZkL5usf5loMgUCkBtwZmg9HN5oj7iZCvQPudta72nyG2wBdNWvYhw1xlGzVsqNhKS
 01f/SeKJHv40klleCiF2ZYLM6CLKpqPaISPw+OptXv+G1RfTfWK3gM9f/+/iGADp6nVpUCAeqdX
 SP+8knMQFYXjJlmintaQ==
X-Gm-Gg: AR+sD12Q5Dj8a2K850yLXIxebsdd6HD6Y/jw7c7r7z9cOoovOXjf81aXBmawzDRcmE6
 /zCGSeXPT0/rPxm2zym9SQlMTLEBnTUmeSnHkjqpBxXkeACfClaQvV1t88m5x2sOCnqEt33XXUW
 l4rzKnJ9G0y/yJU0MIX7lbproh4imx32OF+Y5EPvM7dKBvYnGOzpc7Y+m0krYX1YiftY5xey6YC
 SD3l7/yBuOujK+vmrC3FwwJziXNR1uVE/IH1ZTtMu8OmD2yvcTx6/+gvAnlGUXwyvveB/OJXrXM
 xavTxAntSno61O9bampiWAa/zpQXtHrUOdpCXHiJ+he3QeO1EUKPN1xU55N6sOrljJ4Xl2WgKxj
 9nkiRuvVJCX+bnAcPWUjg73zij7nQjn0d2AR4/SXjbsQ8wIVP
X-Received: by 2002:a17:902:ce85:b0:2cc:aa38:4df3 with SMTP id
 d9443c01a7336-2d0ca76a992mr141533405ad.13.1786012657226; 
 Thu, 06 Aug 2026 03:37:37 -0700 (PDT)
X-Received: by 2002:a17:902:ce85:b0:2cc:aa38:4df3 with SMTP id
 d9443c01a7336-2d0ca76a992mr141532835ad.13.1786012656878; 
 Thu, 06 Aug 2026 03:37:36 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9fd3949sm29640545ad.18.2026.08.06.03.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:37:36 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH 0/2] gunzip: Fix spurious Z_BUF_ERROR in chunked gzwrite
 decompression
Date: Thu,  6 Aug 2026 10:36:58 +0000
Message-ID: <20260806103720.1026454-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 11:00:31 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786012658;
 bh=GrRpaz/haBCRiQStDW098u5pqFCcteqXPtH3qI4AC98=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=taugve52d6yLBITS91t38J8mVPS37p/eTk+ZMdOfGc+rtROvoQltmYO4/J6/Mmwle
 T5zzVVnMbE0aoXtkwyouIxSwXl6pRM8Nh5DlS65lz8Dvalgbz2dlMbJ5xLHxuYSGql
 VD5eCqWmXWPcgVaK3Z896nG+Gr56Y98c9VWt91N7/fGoXG8wQO7hLeOGt/NYZrQsNZ
 rUAsN8PTJipwW7KGx0yEZy0MVpWvECIMC+BJ5f2GgYW1go6kh/61ZU/oeulVycdBgf
 0GrtqUrI0I6Id8HUWHIc4OapR2qyqLKZtX+cvn7uuEUtQiNi/PCvoIiZgpHVSdqlq4
 4AYjA6T3vnNowwEWqzRbogo+KLoGisqO65ohcT8queWDJ2qImR1FEU33E5riqABHc4
 iTsAoo2nJMRUEBnGL4/fkWOc7FUhBM1CzKt8qF00FMrIukAD6aI1mzwS/0wsBd672m
 UTSQFeM1qzpyqW44j8yQNdLR7ovWMXYcZ1va7+etbP1Ycnu1D8FB7gkBiNnuF09wnX
 z1GIDswsy9mNJrA/lLw5Hf6/rwDNfkqG4vWu0gHadHYlc55S/BO1S7hMuP9qPIhCsy
 /DiTrSxfEi2fh8b6Z5cC6MmKD+LwX7KjFhSUel9LMyG8Q/bu87Vvu1Hp296SXsO4WP
 OXl9W0tIy6p1blyGJaCtIfwA=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=taugve52
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

Aristo Chen (2):
  gunzip: Fix spurious Z_BUF_ERROR in chunked gzwrite decompression
  test: cmd: Add gzwrite chunk boundary regression test

 lib/gunzip.c     |  10 +++++
 test/cmd/unzip.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 2 deletions(-)

-- 
2.43.0

