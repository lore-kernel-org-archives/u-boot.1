Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9D606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nstDf/mv;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gH0r8o9t
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA61E60607;
	Mon, 23 Nov 2026 04:03:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3wQF2zDmqm4s; Mon, 23 Nov 2026 04:03:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B9A6760683
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795406618;
	b=LTVP/E/B4QyF15S3Jk84C5bwCEYoMcCC/05sgNBCqX8bR5uSrgrJ5A31oIb55bfh6Y/D
	 evpQDcnJYvR29u2gTBYODP6oPD5oy/5X9+nQPrJSoZFL2C9ZygvSC2JugneFdp0dkT3aK
	 1GJe8d5S2Ak/zv6ujORSui9q1PjSIC9opG/526Zr181OP80yC9wfogIiGM8LCRtHO8Zck
	 WlPghjOP4EHKvmQ8Xr/MN9Y7VX+DdttfRivSzEUVU9YrfyIKcn0EWChA9Wqw3SGVj7gCi
	 yzqJV71Plt19uk3m7K6vhUV/79Q/y8th+BR0Ur7qLWQnZRnAC+Ik6E99OQuk2PmmnWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795406618;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:Errors-To;
	bh=Y/aa+zP9+194WbDiAcpohpQThO7gnnf61OA+rBq66J4=;
	b=DhRJplQLzDSDdvxuYSX2GY57fr/8D5EjO02YbEl46NR2AqPCiaKUMSgdubkLCAiq3DnM
	 bgRHDYGrpp/GOF7+Tsw9UFHHi8XcODHlXhl+hsjvsRBc1volqYMb8FVpxoFBGaa573gqd
	 ztb5GUgIJPYFuc2DxndY5zFOdMMo+z7BmU+ujUv8FR4HC4qq92bEwZBsVyh96OkDRm6xZ
	 lNSExjf2MqnBj1XywYddnv70hgUADcior97cYXxnq7+eRuIfGIP3cDcG06kDcE3hmCgWP
	 fr/pAdZnLavykxWkE0WlcfCEna56QVAVzCKXABHpOKB3aNWscH723+JNpIchaYZAU/A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795406618;
	bh=Y/aa+zP9+194WbDiAcpohpQThO7gnnf61OA+rBq66J4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=nstDf/mvkRaQlt6Pq3qZZmpM51g85Lc1dSWyS3akIUsfC7+HlY7rPik2kpb/e+CsI
	 YPCSy2VZywc7KBt/3a2ROE9v6ykfSBEP3CcoHuxIygK0wF40QmpMP4TNdORtW6UNRs
	 YbBTI81hdivZ8bb8+FSijzyFwvQ97CbeIejLkayRGTtqMaYHCVcE3aK1T0RatAB7H5
	 9PfKi+7I1RxoTbLVjHF/XneYrSzFyygxv6nRcJFDLW27lo1Fc3wKpHnog8FJH573t1
	 YdbNowJz+VkPvbL7x+q19wHw82L6wBt9o3HvPJ0V2XzyheFsydKoeFoqPlL2/1Jz9n
	 D/cOomEE62ilQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9A6760683;
	Mon, 23 Nov 2026 04:03:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DE566499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C86D380C81
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mzA6Pe1270EM for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 04:03:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A93680B9D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=gH0r8o9t
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A93680B9D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C82C341291;
 Mon, 23 Nov 2026 04:03:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 92E321F000C0;
 Mon, 23 Nov 2026 04:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795406613;
 bh=Y/aa+zP9+194WbDiAcpohpQThO7gnnf61OA+rBq66J4=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=gH0r8o9tVbC0nvFzinGsTOhQ5UJMnKZ293nVNW4aB8TsaaNmXEzne9RUDJ4amUZvV
 oTSEDHhXejPiSiZZopRbhiDOR4RxMog2ZLGpSw2+4J2LTVfOHuU39Gr4NVE49dLrCR
 7+4s6bZEkzgHIpinZPTuh22gy6z05IjOc7lqz8mCZedaWSKU2UrqgyUz5d845cFmGc
 QEelI1h16cnw0q6qzRnt5ghBa1f72VJP473R7CMkxlR68XHkMLHwZHNhLKI+pJ1LuR
 qEslCrebRWpiZxhL6e/v45xmCwsg32runBFRGdTopGr3hO/7bEvQ7ji3hdnV/QbRAL
 OBtKrzT4QjndQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 24E8F4C321;
 Mon, 23 Nov 2026 04:03:22 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH v2 0/8] cmd: lwip: wget: write the download to a block device
Date: Mon, 23 Nov 2026 04:03:15 +0000
Message-Id: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAO7A2sC/3XMQQ6CMBCF4auQWTtm2k4UXXkPw6LIABMJkJZUD
 eHuVvYu/5e8b4UoQSXCtVghSNKo05jDHgp49H7sBLXJDZbsyRgyWDO+OlmwHp4YGEvn2tK7xjE
 L5NMcpNX3Dt6r3L3GZQqf3U/mt/6lkkFCsWdPdBEmdjf16TgkqLZt+wIG7W3TqQAAAA==
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5213; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=G8GYtpb356ooV2Y3KO81na2icZvAt7lEYQv4BxKLFks=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNnMu1kfaXD+mx5s+8zaxulMM+f6XqF83T4+x4Q7oS8C1
 lv5WSV1lLIwiHExyIopskw4pHErY8nVv/4e5g9g5rAygQxh4OIUgIl8Smb4Xx3TtoQ/VqSu36Qv
 7/yZM1K6qfGFdWq398pqfrghm75vHSPDkefOrMUF08zTj2U6sEWwX1/f+eq7jgSfROOtviCDbZx
 MAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

wget can write a disk image only after the whole file is in RAM. This
series lets lwIP wget write the download to a block device while it
arrives. The target takes the usual <dev>[.<hwpart>][:<part>|#<name>]
form and an optional byte offset:

  => wget -o mmc 0 http://192.168.1.65/disk.img          # whole device
  => wget -o mmc 0 -s 8000 http://192.168.1.65/idbloader.img # 32 KiB in
  => wget -o mmc 0:1 http://192.168.1.65/boot.img        # partition 1
  => wget -o mmc 0#rootfs http://192.168.1.65/root.img   # "rootfs"
  => wget -o mmc 0#rootfs -s 400000 http://192.168.1.65/part.img
  => wget -o mmc 0.1 http://192.168.1.65/u-boot.bin      # boot0
  => wget -o mmc 0.2 -s 40000 http://192.168.1.65/env.bin

The write buffer is 1 MiB unless -b sets it.

Patches 1-5 prepare the lwIP HTTP client and wget: the Content-Length
sentinel moves to the header, the size check accepts a reply without
a length, lengths and counts go to 64 bits as images pass 4 GiB, and
Content-Length is found whatever its case. Patch 6 lets a wget client
take the data through a callback, patch 7 adds the block device
writer, and patch 8 adds the options.

Jerome, v1 is in u-boot-net for-main (8498fbf8788..f0870bb385c);
please drop it for this version.

Tested:
- QEMU arm64, eMMC with boot partitions and a GPT, and virtio-blk:
  every form above, HTTPS into a partition and into boot0; the data
  matches the files byte for byte and nothing outside the target
  changed. Refused before any write: a 404, a chunked reply, a file
  larger than the target, ':' and ':auto', a hardware partition that
  the device lacks. A server that sends less or more than its
  Content-Length fails the command, and nothing past the declared
  length reaches the device.
- ROCK Pi 4A: a 1862270976-byte image to NVMe at a 1 GiB offset in
  68 s (26 MiB/s); the bytes at that offset have the sha256 of the
  image, and the 8 MiB before and after it are still zero.
- sandbox: ut lib lib_test_sink_blk; every patch builds on sandbox and
  sandbox64_lwip. qemu_arm (32-bit) with lwIP builds without warnings.

Notes:
- checkpatch flags lwIP's own style in patches 4 and 5, and asks for
  IS_ENABLED() at "#if defined(CONFIG_WGET_STREAM)"; that #if picks
  lines of the help string, as the WGET_CACERT ones next to it do.
- Patch 2 changes what EFI HTTP gets for a HEAD without
  Content-Length; its message says how.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Changes in v2:
- New patch 1: HTTPC_CONTENT_LEN_INVALID in http_client.h (Heinrich)
- Patch 2: no Fixes: tag; the message says what it changes for EFI
- New patches 3 and 4: 64-bit content length and byte counts; a mark
  every 10 blocks when the length is unknown
- New patch 5: find Content-Length whatever its case
- Patch 6: with a sink, refuse a Transfer-Encoding reply and data past
  the Content-Length; set neither filesize, fileaddr nor the EFI boot
  device
- Patch 7: refuse targets that leave the choice of device or partition
  to U-Boot (':', ':auto', an empty device or name, numbers that the
  lookups truncate), a hardware partition that the device lacks, and
  'ubi'; read the partition table again after the write
- Patch 8: filesize is the number of bytes written and fileaddr is
  deleted; each option once; wget.rst lists every target form
- Link to v1: https://lore.kernel.org/r/20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv

---
Igor Velkov (8):
      net: lwip: move HTTPC_CONTENT_LEN_INVALID to http_client.h
      net: lwip: wget: accept a reply without Content-Length in the size check
      net: lwip: wget: count the download in 64 bits
      net: lwip: count the HTTP content length in 64 bits
      net: lwip: find Content-Length whatever its case
      net: lwip: wget: hand the payload to an optional sink
      lib: add a stream sink for block devices
      cmd: lwip: wget: write the download to a block device

 cmd/Kconfig                                       |   9 +
 cmd/lwip/wget.c                                   | 130 ++++++++++-
 configs/sandbox64_lwip_defconfig                  |   1 +
 configs/sandbox_defconfig                         |   1 +
 doc/usage/cmd/wget.rst                            |  95 +++++++-
 include/net-common.h                              |  14 +-
 include/stream_sink.h                             |  84 +++++++
 lib/Kconfig                                       |   8 +
 lib/Makefile                                      |   1 +
 lib/lwip/lwip/src/apps/http/http_client.c         |  68 ++++--
 lib/lwip/lwip/src/include/lwip/apps/http_client.h |  14 +-
 lib/stream_sink.c                                 | 268 ++++++++++++++++++++++
 net/lwip/wget.c                                   | 177 +++++++++++---
 test/dm/lwip.c                                    |   2 +-
 test/lib/Makefile                                 |   3 +
 test/lib/stream_sink.c                            | 204 ++++++++++++++++
 16 files changed, 1028 insertions(+), 51 deletions(-)
---
base-commit: e578056c766d653270b14557c2a9d8daec414c17
change-id: 20261101-b4-wget-blk-r4-833f8a3d344e

Best regards,
-- 
Igor Velkov <iav@iav.lv>


