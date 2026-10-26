Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E177606A325
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ukMvNXbv;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=cedric.hombourger@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=kWNZqN98
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC1674082B;
	Mon, 26 Oct 2026 17:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DCHwuP9qOlmC; Mon, 26 Oct 2026 17:35:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5668D40830
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793036102;
	b=TVCtyow0GkqRQAjBxj1c8nf0D+Nb665W66mBG6tyElnR79AHUrpWIv/4l5jFV3uw6YrP
	 DvjlyRke2hKR4tmrqkYMDA067GoVuZubrVD7EP1Mptn3uXUoyq0n6E+qMnOIRtGWL8q8i
	 WBMkwCC2BeQ/8R01ik5ucJH3RomwrfrWVW1O2w1o4To/poxakUqYuise0D+z9ocan1LTS
	 yZvdCEcBdPvMECJXsUwll3jT5hyg2ngI2YMDXImvIH+eiDsh/l7SeI524UiloBLDv25sT
	 SL2IyEptzlLB3zMPLvwE/vITeXEOx6YIr9f7sEIIe99SD0j7FS5GSApn2VoaViCDwLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793036102;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Flowmailer-Platform:Feedback-ID:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5U1nK2HqZ3CGEq+CF0WjXHPI9DGRKd/RxXAnGFJrsGM=;
	b=V/t1JrqdWS3rHsVw+yEg46sWn+0/bLqJmwxNeDT5Cyi54/IjbBv99J83CymDU3vJlCcl
	 2X0ILiUzS17HQtBKyZZT34sY5pgMWTUXjKYRePoVjIY1A+84c/5Y01P8802o2AlCm9vpd
	 +MhvhLc/nAK3Xk9Ihic0AMTg9gejsUEbIHDYnTCKgrXhYEgOHJaAL/FUzBKjtxXP1FIm1
	 RzZc7C3f7GNx/PG0XvGLF+PnmsFvXuZcpO/qdT8KiBjk6ZNkeE2Tk750aMQ6flmEqF42z
	 9AiJu4YD6vbDzxvbbtcq/jk53k7XOhzpjf8Y3qL/CMt2g+bvXQgSd9P/SI2gm28SVkg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793036102;
	bh=5U1nK2HqZ3CGEq+CF0WjXHPI9DGRKd/RxXAnGFJrsGM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ukMvNXbvp1Oboz0xpj1E+n4zRnMTqD9haoYfqr/AA6dRSCei52UCOegjgcsHB4WWC
	 SUKFMNqT7xO0cI2DDq/2jYngfZ/6NJvH5lk2sE5hmp0r1FCRY1mSYwCxat0OGqLLay
	 dYHr9hyje3hgN+BfCxY1EppLwHPoqrfbhFGbMhemEVadcesPxHvxlS7ivO4cnZVYZb
	 kWl1wr+XDHiXoEO39+ycd3CrKpzZz1UOkl3+mwdJwfudcBQJz3xs6c7f1qFwgVPQ/O
	 hIJxJjVw7P0uWwY/AR7EP3iwvGKh3Tf6UlqAet7rGPaQ0EVy/+qp8XpYeiStTn5tqW
	 /jOf5diFJRibA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5668D40830;
	Mon, 26 Oct 2026 17:35:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 672E0D37
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 648C6401AE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DPKd1YYqBV-M for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:38:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E8A7F40205
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793032686;
 b=ErsfXUBNsHl2bY6Jbmb29vtSxKzk4PVlcvg7g6lIPPyShqq7e5901U7cnz8xBi70zq/5
 f7Zxci+wu+9AP03M/zEbwkifPGwKOYYTpyFa6IeIAKvAZlNBaWrAqQCetAOrJq66NGtbI
 hGmPfPnGInY3zJz50wrU2xFvhOfIJB8EgoXF1y4qpTgK1Kxn17Z3Lz/XtbNWFfuU+Ge6J
 vi2QzZvBRHtxfMiJJ/ICTEg/l/oJ3DyNuZBD+dxyO7ebPTR0vLDGJA5IhkuavmemLbaT/
 7lZTfDupfC2UHKILyvNDGX7uJKQIQ1INqhBu5VDEkthk5O/MrW/+Yncal/yLNxj5xOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032686;
 h=Received-SPF:Received:DKIM-Signature:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Flowmailer-Platform:Feedback-ID;
 bh=5U1nK2HqZ3CGEq+CF0WjXHPI9DGRKd/RxXAnGFJrsGM=;
 b=VD6v3G8G0636v9lxyePK+db0qnYqd5YXHKaS52/KVzslt+p2dxMgdhJhQW0bIsYCrz+s
 Izmial9yO2w1TvsQfDupdPTSeKjDy0SmkU3RTCEG+mqI8lWAH0iAngmEnaDeYti0Hvv45
 RtGHcFE9uEaDtafdeQQZu0UfNJV3mViFVzkvhR6GaORpMDggSN4yA8jIL9e4TwnDEsXtq
 TQtX06Qa9mz0RjqMp6c8M0dRxgkbXN+pRvWbPCr29BgbhmkbYF/1Nw0DDjKBxeSEiDM3k
 dCYgCey6l1m4fC30bMU0HLA8TOYIJIaEt46FHBx8PxQmlY+ebr/LalhOSgY4VV78hDA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=cedric.hombourger@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=kWNZqN98; 
 arc=none smtp.remote-ip=185.136.64.227
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-1212295-2026102616380190525a8c7e0002074e-s_mkyn@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=cedric.hombourger@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=kWNZqN98
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8A7F40205
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:04 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2026102616380190525a8c7e0002074e
 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 17:38:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=cedric.hombourger@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=5U1nK2HqZ3CGEq+CF0WjXHPI9DGRKd/RxXAnGFJrsGM=;
 b=kWNZqN98NsdZATRGbQqD/Jkj0SDv8ajQreHpSrDe0WSINvRSyxUul9W2zB8PKqeuAFoGk+
 qGci/gJp4pxh92/TqJAEsgxS86PbQk6ayxI120giqwO4ytO0jtpANCFTmgaMeu6QgRFMC2sG
 3lpSmXB7Qtmhyt863GoGtDVs8Y5MC3Td2rm4KuQom4K5y450pa57+r1pQ9hcD5rKval05pCp
 3ggkKQmbbnTv94X4lA5mXBwUNedJOFUt6iN0/JWPvQUpJWkRLCQwPXjpaVFNOiW6YIrgLUBF
 uH5djUos113eTJ9qpzIMJ7v/PZxACJTcQal7GP7t+VprTMWKy2b4OM+A==;
From: Cedric Hombourger <cedric.hombourger@siemens.com>
Subject: [RFC PATCH v2 0/3] fs: let EFI Write() keep the end of a FAT file
Date: Mon, 26 Oct 2026 17:37:23 +0100
Message-Id: <20261026-fat-fs-fixes-v2-0-41ae696cd353@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMSB32oC/22OwQ6CQAxEf4X0bA2L6xI5+R+GA6xd6QHQLRIN4
 d8tcDAmHnqYad7MTCAUmQSKZIJIIwv3nYpsl4Bvqu5GyFfVkKWZM3oYqgGDYOAXCfoj1dbaYMg
 dQJF7pPWhxKXcdKTHU1OHzfyGasdP5IIVo4EFa1iGPr7XUWot3P/+0WCKznoXQu7qPJzOwtRSJ
 3vft1DO8/wB3jVJIeEAAAA=
X-Change-ID: 20261026-fat-fs-fixes-c5eb444f1e63
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Cedric Hombourger <cedric.hombourger@siemens.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Qu Wenruo <wqu@suse.com>, Alexey Charkov <alchark@flipper.net>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1212295:519-21489:flowmailer
X-Mailman-Approved-At: Mon, 26 Oct 2026 17:34:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series stops the EFI file protocol Write() from cutting a FAT file
at the end of the written range. It is an RFC, mainly for the naming and
for the shape of the new interface.

The problem
-----------

fs_write() with an offset trims the file at offset + len. This was chosen
on purpose in commit cb8af8af5ba0 ("fs: fat: support write with non-zero
offset") to stay compatible with the fatwrite command, which replaces a
whole file. efi_file_write_int() uses fs_write(), so a write in the middle
of a file through EFI_FILE_PROTOCOL.Write() loses the data after it.

I found this with an EFI application that keeps a 256 MiB file on the
ESP and updates it in small pieces. With U-Boot 2025.01 on qemu_arm64 the
file went from 268435456 to 602112 bytes after one run. The code is the
same in current master (used for this submission).

What the specification and others do
------------------------------------

- UEFI 2.10, section 13.5.6, EFI_FILE_PROTOCOL.Write(): the data is
  written at the current position, the file grows if required, and
  partial writes only happen on a data error. Nothing allows a successful
  Write() to drop data after the written range.
- The UEFI SCT checks it: BBTestWriteBasicTestCheckpoint1 in edk2-test
  writes 50 bytes at position 0 of a 200 byte file and expects the size to
  stay 200. I did not run SCT on U-Boot. By reading it, this case fails
  today (and its set-up needs SetInfo() to change the file size, which
  U-Boot refuses).
- EDK2's FAT driver (FatIFileAccess) only grows the file when a write goes
  past the end.

So U-Boot's behaviour is surprising for EFI applications, and I believe
it is not conforming. I may be missing a reason for it, hence the RFC.

The series
----------

1. fs: fat: add a write that keeps the end of the file. The body of
   file_fat_write_at() moves to a static function with a keep_tail flag.
   file_fat_write_at() keeps its behaviour as a wrapper.
   file_fat_overwrite() is the new entry point.
2. fs: add fs_overwrite(). It uses an optional overwrite() operation in
   struct fstype_info. A filesystem without it falls back to write().
3. efi_loader: use fs_overwrite() in Write().

fs_write() and the fatwrite command do not change.

Questions
---------

- Naming: fs_overwrite() is what I chose. fs_write_inplace(),
  fs_write_keep_tail() and fs_update() were also considered. Please
  suggest a better one.
- exFAT has the same trim (exfat_fs_write() calls exfat_truncate() with
  offset + size). ext4 refuses a non-zero offset and replaces the file at
  offset 0. I did not touch them. Should exFAT get the same operation in
  this series? A test for efi_selftest is not included yet.

Cedric Hombourger (3):
  fs: fat: add a write that keeps the end of the file
  fs: add fs_overwrite() to write without trimming the file
  efi_loader: do not trim files in Write()

fs/fat/fat_write.c        | 32 ++++++++++++++++++++++++--------
 fs/fs.c                   | 25 ++++++++++++++++++++++---
 include/fat.h             |  2 ++
 include/fs.h              | 16 ++++++++++++++++
 lib/efi_loader/efi_file.c |  4 ++--
 5 files changed, 66 insertions(+), 13 deletions(-)

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Cedric Hombourger <cedric.hombourger@siemens.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Qu Wenruo <wqu@suse.com>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Vincent Jardin <vjardin@free.fr>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
-- 
2.47.3

Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20261026-fat-fs-fixes-v1-0-64c6ff76b7f9@siemens.com

---
Cedric Hombourger (3):
      fs: fat: add a write that keeps the end of the file
      fs: add fs_overwrite() to write without trimming the file
      efi_loader: do not trim files in Write()

 fs/fat/fat_write.c        | 32 ++++++++++++++++++++++++--------
 fs/fs.c                   | 25 ++++++++++++++++++++++---
 include/fat.h             |  2 ++
 include/fs.h              | 16 ++++++++++++++++
 lib/efi_loader/efi_file.c |  4 ++--
 5 files changed, 66 insertions(+), 13 deletions(-)
---
base-commit: 2203aabfa59826d04d9e2094c6b32c1029cd01f8
change-id: 20261026-fat-fs-fixes-c5eb444f1e63
prerequisite-change-id: 20261026-fat-fixes:v1

Best regards,
-- 
Cedric Hombourger <cedric.hombourger@siemens.com>

