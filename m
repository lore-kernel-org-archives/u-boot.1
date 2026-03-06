Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD3AFCC065
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0255C83FC0;
	Fri,  6 Mar 2026 20:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jPFZ9IBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C9A783F86; Fri,  6 Mar 2026 20:08:31 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F97D83F00
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-8cb420f7500so910645685a.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772824106; x=1773428906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cIx42QZfZLnQoLdNxte38iqCyTcIqNQQ7aXWCzWE5dE=;
 b=jPFZ9IBbCNHqL07L1TU8iSqYt8ACqyYz9a3Q9xCXKvoEMoaaBgNPzQ2sHdlo8YM3ZA
 H0lkoUK/NQZsFwUemWEStxmp/S3x4k07knBko483WhhDXCC8TwxZwGl4tHXZ4m0lYCWI
 bAPT25UZdaRv2Bql0D+4RQdChaPnsLT3xHRDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772824106; x=1773428906;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIx42QZfZLnQoLdNxte38iqCyTcIqNQQ7aXWCzWE5dE=;
 b=e15ZExQROd2MmNLlok3Aw6QloPKVBmZeG260j7c43RB4ntl0dunvz1n3fSpzwll9Qe
 dPivWgO+JheFM1rm3caj2lRN6YSDX2/BGwBgJnr0xtYMncp9js5hKsnUHnmjYvfACQXS
 cEkMU3sakkgYjzHGpKn0R3KVljnzQXyHydCODjxPkQ8z9lghxJON1tfcdVWY8p5tqVmX
 gQHjNCbY+lmF6RLSHtSH0+On2PJjAWs4sMTeHQlOYO+QEzFyDhbQIRMAmi6JO6LX4ZdA
 fGJhGhkwg9NrF4qn9Xv0KPYP4BZV1nsv/ni0jnm9P6qLBGMpTo4zR/CRs/EY9DIPTD/b
 ocUA==
X-Gm-Message-State: AOJu0YwuOTQ0yv5oHeNl8q0efgzPuemh/wC7zk7RIpj60wg6rtljqdTr
 GPc/QNqQpkpiIxlcKHKnE/V5qVGh0ctxqqFao2vYyD1KM9lytP8ks/pmYC+IrDYP6hqTtc31Bfo
 9szs=
X-Gm-Gg: ATEYQzyilLLPcfVagJLnCZcX+PQ+FpjYZ7pGtJDd2kqyDg53dQXkB+tbuE5/M5hL1Ri
 A9/T1TNphs3IJLww0zK7B5OmkOo2lz02UUa0S8ctIsuH2C1fIQbuu+8TUYl3EhiCgPg0ebxJy0N
 kcTqNU+3gDXk8LEla5d3vDrQs74SGsVXmKEKsBMNK3k0snGjAG9MO/gdbdyPkFn4u47b3zEcuQl
 v2LD/SpiZRuZKS8RkkVa3Dz6Zkml326zu6Sm5d6iRfLThUlF5+BE1Lg2ulT6JUkNeMzJB9EVKnL
 bbioS+YjFx5/yhSNo3Zc4+E428tQZCXC6wFXkChs4PehPuHh4DfKgeElzPX2nlAbFhPodQ6Q0R6
 P7Hjr4Qi+xSSSSB9Q39OqmXUw+E5O+SHMpTaK53OQYssxmrikKYFePgJGRiP8onptc93Za0UEwq
 cKRSnAzyi5vB4A6GrJ7w==
X-Received: by 2002:a05:620a:4687:b0:8c6:a64e:92b4 with SMTP id
 af79cd13be357-8cd6d54ba17mr392230985a.78.1772824105884; 
 Fri, 06 Mar 2026 11:08:25 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f54ceaesm164372285a.40.2026.03.06.11.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:08:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 0/7] Provide classes for building disk images with FS
 partitions
Date: Fri,  6 Mar 2026 12:08:06 -0700
Message-ID: <20260306190818.3586749-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Create a class around mk_fs() to handle the common tasks of image
creation, such as managing scratch directories and cleaning up. Add a
helper class for creating disk images with partition tables.

Start with a few small cleanups to mk_fs(), then convert a test over
to use the new classes.

Changes in v3:
- Rewrite the commit message as suggested by Tom Rini
- Make the class a thin wrapper that delegates to mk_fs()
- Remove cur_dir parameter from DiskHelper as suggested by Tom Rini
- Remove editorialising from commit message

Changes in v2:
- Split the quiet flag into a separate commit
- Fix fs_img to accept only a leaf name, always under persistent_data_dir
- Add new patch to split the quiet flag out of the previous patch
- Split the pylint fix into a separate commit
- Explain why setup_image() is left to later

Simon Glass (7):
  test: fs_helper: Allow passing the image filename
  test: fs_helper: Add a quiet flag to mk_fs()
  test: Update comment for fs_helper.setup_image()
  test: fs_helper: Drop the size_gran argument
  test: Convert fs_helper to use a class
  test: Add a helper class to create disk images
  test: Convert test_efi_bootmgr to use FsHelper

 test/py/tests/fs_helper.py        | 205 ++++++++++++++++++++++++++++--
 test/py/tests/test_efi_bootmgr.py |  38 ++----
 2 files changed, 211 insertions(+), 32 deletions(-)

-- 
2.43.0

base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
branch: testfs3
