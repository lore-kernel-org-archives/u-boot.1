Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F53C5AD2C
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 05:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE0196068F;
	Sun,  9 Aug 2026 05:15:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id icWOgK7jYls7; Sun,  9 Aug 2026 05:15:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C6836067C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786252534;
	bh=TqDEVOB6jVZ+a/Long7LIeKJJYrMRqzs0H3ZHjgbBRM=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=dTPwl3/hzA6bBkw54XpuiQP/nIWjyM/nAp5KZxQurGlvV3gw0RPMBVM3wtSj9vFwn
	 wzqZo6Xz5JRrqAXHApfi44INbxGjI0pgq6rk9VUpMVWjJZaIfoyeUdSBN2TxNzMg1d
	 z6kUqcAPSnrWLuE+ah5pQnAJC4Ve1UZ1D/fxxvZM9pITmuqCKpWyXx8xbv7YRQhck3
	 zcsuXpuRYiIBBNqbDbFcOTAJ9IEu3dzlGtNUhKjPAubOW0/7/RzN/+PYtNpjSKmMtq
	 TWhiVnl90Z8uTeZKDTCO+JeGF/2uxLbvyTF0CzlYUyPJHj851jRdOMgfA57ouucaj5
	 l+2y8wErf/Knw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C6836067C;
	Sun,  9 Aug 2026 05:15:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EF4D2F5
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23ADF403D8
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:27:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qN3xjUff5KSX for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 04:27:25 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9F764035C
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C9F764035C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9F764035C
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 501743F672
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:23:51 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso14384975ad.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 21:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786249430; x=1786854230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TqDEVOB6jVZ+a/Long7LIeKJJYrMRqzs0H3ZHjgbBRM=;
 b=ZjP6+IL2OhfaMQofMZGu2aqInDtuugIAEH/mFdvuGZdh2Tu4I83ypyudE1WiTjVPnG
 tJNHKDmjx5n/6W/KL1dXeOk4tQ+PKUoDBE1q8pQjDXSlyc0cwlSmPrGDpPepJ94JAKd9
 wNH/rw+nwIutAvL1aLnGwqfDdiZv/JBTOaBEw67G9mJVvUf4lmyQrk0RiUuq7DZFRtNd
 lUoaKs8CkFRjJYegkLpG2W87Ib71XZcmfjlkDyI3MZI4YDJdwhP+BZKlSj812LtvJQLj
 K7aass7Iz+uikjMF907LCl6+ZVQvTy97LmjqW4hke3XankFr64ygnd/AumXPDyl4gNbJ
 5Fdw==
X-Gm-Message-State: AOJu0YzWQZBJwF1Mgk82AAJLgoMeD4O7iyY2nNB8BDPXubfizyqAA21Q
 r18H5cN4JogO7lp4Xlami1AfniD0PC6t0IhWS85igFEfQExIet+MpVIqbb8HExsMTH7D63TvYl7
 Y3oOgd965nPDiOF9O8mQrEklftXWbzh3rfQ2t9v6sUAT+XYdlhTSR+bb9i5JBInPsfc0fi0PfUc
 AugAob3JuKhwZnPrft1A==
X-Gm-Gg: AR+sD12SU1dlM8wgiqx6dLuJTLAHSeBq/9rzJEngDHbqnJAm5/xo+QupXSnS/6edEj5
 jF2IvjjlJO6KKtGSF4qPES7SO9ZKGBWC1twwnf7e0choOU1YT5V2gWPQATrtTD0GvuPO5+tvGkB
 MGbWKDpjZvYi72+3QKHsmCQLJdNYSCLovvhw4I+3WUPDz3MQ8d9IRWiY8iedE5HXpCYcaWn0XXo
 BG0oTHEiAuhK+CqGDBT1illLv4lzkCjqfrOsomLhsopyKQcRHfuPixFaaxCZBbcVUiPQfTduoXq
 RUkRw7PMGWdw2WvVO7Nbr6KPTXc+9yq8wQsDofy/oIwkn6VlP5mjeLDA3duXFRCB0WUTuYaaSjx
 iWnDK+Vs7ULtYyIf46t7KIgx4mR9biYzVNve2S1QE6tA/zw/kXY+jfsd6wxc8hLA0RPGjHQ==
X-Received: by 2002:a05:6a20:918e:b0:3c4:46ca:334b with SMTP id
 adf61e73a8af0-3cb85e2acc2mr34396593637.9.1786249429667; 
 Sat, 08 Aug 2026 21:23:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:918e:b0:3c4:46ca:334b with SMTP id
 adf61e73a8af0-3cb85e2acc2mr34396566637.9.1786249429252; 
 Sat, 08 Aug 2026 21:23:49 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f35bc75sm2314583a12.19.2026.08.08.21.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 21:23:47 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH 0/3] bootm: size the noload buffer from the compressor header
Date: Sun,  9 Aug 2026 04:23:26 +0000
Message-ID: <20260809042338.63397-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 09 Aug 2026 05:15:32 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786249431;
 bh=TqDEVOB6jVZ+a/Long7LIeKJJYrMRqzs0H3ZHjgbBRM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=e152EMlLEeakTb+ix9wHyDcu0xdhpfHavLeU6xu1r7akbX13DYmQ23McagQihvNWD
 5SEYuwI05rpiODQs1/mTcjVxEMh2DYn8equW34NEgvvC/nRFSqrHyawPiGizoFDztm
 xTtYI5CUwj7+0yMhcuQ+3V2oRoRvwU5Ezlbl0Zc5L+l+md3yqfk3t6dOrPNTGjxcER
 uudR9rMbOjHuabJ9v+Q+gb/DPsUEUKG8OWS1KMcF2w+RGI7qWReHbjlBejbWu1USdP
 kj9m7e4q/RtUCCHHiFtFIq2b1p8lN+KnFa5a3fPgAnLvzYHblKUC5VNNE01bXoXouE
 qdB3HbZIxTB1PhymeahMfYhZv9Epzy2q3r/0LyT/MbN2FVHpU2I63GL3jcc8SLOM3U
 Zu+sLexcHeljSkBwHEeFiQVWLe87QuEJrU85WrvelWDjgv1xacUJ5C31d+R8+tK2P8
 tpMWNIiMTobx93fNfI61kwPEKmTtrCAHA5MQa66vafGB6cE4WcmCnwTxTMdCQEeLNu
 uYR8DphN4WL+xGzutk1YrMCxM0OwFsasr96H5rVV+Y0GTP8G4ErMjCK5zKLtImOGge
 mMMtmorBfEwKadGAyxbgtN9/2lb7e8abOQru8m3OsxrxaMrQtl9CzmH35wjleH6v2A
 iRWVfu9DuQNtv/2vCnFwbkCc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=pass
 smtp.mailfrom=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=e152EMlL
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

For a compressed kernel_noload image, bootm_load_os() currently sizes
the decompression buffer as ALIGN(image_len * 8, SZ_1M). The 8x
heuristic works for typical kernels, but any well-compressed payload
(e.g. a long run of zeros) can exceed it, and no fixed multiplier is
safe against arbitrarily compressible input.

This series reads the real uncompressed size from the compressor
header instead. A new helper image_decomp_get_uncompressed_size()
returns the size from gzip ISIZE, lzma's fixed 8-byte header field,
lz4's Content_Size (when the FLG bit is set), or zstd's
Frame_Content_Size. Where the format lacks a size (bzip2, lzo, xz) or
the specific stream omits it (lzma "unknown", lz4 without
--content-size), bootm falls back to the existing 8x heuristic. The
header-derived value is attacker-controlled, so it is capped at
CONFIG_SYS_BOOTM_LEN before use.

Patch 1 adds the helper and wires it into bootm_load_os().

Patch 2 covers gzip, lz4 (with --content-size), and zstd end-to-end
through bootm on sandbox. Every noload_decomp test now carries the
compressor in its name (test_fit_kernel_noload_decomp_<comp>_*); the
lz4 and zstd cases are guarded with requiredtool markers so they skip
cleanly on hosts that don't ship the corresponding compressor. The
lying-header case is exercised for gzip only, because the
CONFIG_SYS_BOOTM_LEN cap lives in one format-agnostic branch of
bootm_load_os() that every parser feeds into.

Patch 3 covers the lzma branch of the helper via a C-level unit test
with a hand-crafted static blob, because standard Ubuntu's xz-utils
lzma shim and Python's lzma.FORMAT_ALONE both write the header size
as "unknown".

Tested on sandbox; the five kernel_noload_decomp pytests pass, the
new compression_test_image_decomp_lzma unit test passes alongside the
14 existing compression unit tests, and each commit builds in
isolation.

Aristo Chen (3):
  bootm: size the noload decompression buffer from the compressor header
  test: fit: cover the kernel_noload header-size and lying-header paths
  test: lib: cover image_decomp_get_uncompressed_size() for lzma streams

 boot/bootm.c              |  20 +++--
 boot/image.c              |  79 +++++++++++++++++
 include/image.h           |  25 ++++++
 test/lib/compression.c    |  66 ++++++++++++++
 test/py/tests/test_fit.py | 182 +++++++++++++++++++++++++++++++++-----
 5 files changed, 346 insertions(+), 26 deletions(-)

-- 
2.43.0

