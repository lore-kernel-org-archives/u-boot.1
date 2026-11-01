Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095CF606A339
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 05:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S2t0Elra;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QuRkcrXE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8FDE810D8;
	Sun,  1 Nov 2026 05:53:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-6S3AteJZqn; Sun,  1 Nov 2026 05:53:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3324480BF7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793512420;
	b=tP0N5c8QMoZntJuGV6hTohkauvdSW/iTQCnT52hwvZzQFmnW/x2JTbObNOCHJeQI+4E/
	 P+4c/P2YKcIUt0TuLegkIcZo8KG+VWYVgGepkOQEspAOJQvHvAc+FpuyX6/R04ixcRW6o
	 Ps7wTSueBi+O3G+gIUPLs89FH77B3TruC9OGjNwCpvtXBvwWypOi7TajCu9vA9GO+KCmX
	 JFgkXO/sAF8rZ7qWBjokK5P8YiyTB8POko1DYN905C4YhLnqGSYYqtOyo9PStnA+5G1jO
	 bkuVy2YITGyipqeYkSDcqj1J2Q5ZOgS1NmQ5iSJ8Izwrhj8xoCeyo7yyXvv6dTLUiHg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793512420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ksN0QKrXG3I3/cB8WHD5zYG7TVW5su/KBsd0um4XPNY=;
	b=lQw98Qhzin5XReRwebehCHbTcQsMCohn8kD6OWUVGUeYWvNFpwEydYq/BV3IUYtf2PgP
	 XRaBOmapQ4BdedKS3fcvjzPYJU3KnQqTfMyPipvuplXCPHta7AAqJaCccQ1i4GznziqCg
	 aDJfvrZ7V8t60raoUEjHsLxW4ClPh9kh6GqueXqwxWr/Iu8aq/O8qU4EYKVXVaVexvGJn
	 Os0OHr2K9ElazW1GDNFx7A2Oeev7sGvf1bkZ9ZzRw6Ao++sKbTabQD0O0+X4SR4hXIPDK
	 rhsDzD3NdG2M8Sum+Sq41fK8IUPB9FT1k3qv2nxt5yoWFGnY7mzcmzQQRReejjoEFJQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793512420;
	bh=ksN0QKrXG3I3/cB8WHD5zYG7TVW5su/KBsd0um4XPNY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=S2t0Elra9rYIpB2Qix+5Cm5e/4UVCOGLPAqdCHJxfEg1/43N2SpFimA5fpdxA+NWk
	 MBFcGWZrHYzWOpisAsgC4g/XP6VhLHFFdXFVJ2RfksM4i8pf+fpSBPUfwAVBcHLR9X
	 AVLAphJU1aIi45QTHNEWzaLtO/9l2rmKeA6at2g33y3lpK9tM5WNZPpGyPP716EhtY
	 YzbRGGRRx9aq1252ew1c1fxUBy2TIQFhrDG+thQ1Vb/mX7FMYdT+5pss6UismRPC4E
	 1b/NpHqZAjPYTSSGdz0+g7nnahaWiGdaRYSB9Zmu0OFkgN87zGj+bOkGIG0C8KR/dg
	 GRFay3VBNb7fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3324480BF7;
	Sun,  1 Nov 2026 05:53:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35F3932A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C44540647
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:53:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GA26UeM22p2Q for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 05:53:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B51604067C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793512410;
 b=CalqkCeep9/NEJYkxdix0qdLYnrN3ky6KxKtSHSy8Wi0ptlhWoDWbRz+yKFGKWcUeosh
 Fr7OingyXU02lhWpGy1ZNTBUjd8T/GgEeSdGTs8V92Yhj0JHtzn4k+XRWDcxw7I0NTYqU
 a3AFkYf4G6qzSuqUWNMSf8tdlgI1nh0WdDoJBk3+7tv/UDuwSSrlA2pbYQok8FuhYSw7r
 okCQjVCOSdSHbm16dQPcZsA2lXd8NQPHce3e2p5aZqDrcyn0X6bN8kk+pc+mUOKfaMFsK
 ujp+D5ESCEwoHdTYB9UZXQeUEjxzME1xcAHDRPNzFIRl32LCz4+/BDt+fvKXo2KHVfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793512410;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=ksN0QKrXG3I3/cB8WHD5zYG7TVW5su/KBsd0um4XPNY=;
 b=UYBiqhanVwCUB38RBn4LHOGMIa2EmYvR6NA9eUmNvJYu8BGMmZ4BZ8tLqUZqM0yhh6RB
 NiRd/us/+a/S93uyzNm0wQTv+v+0KG3KyzQQhuSxgZ09fEFSD0b+KPLvDClproutOW2Qs
 l6LqSQxT6Divjdcb09gUZtg7kzM4YgXUU33I4QZXv1gG4fvWun1gqjrs9k19CRg/Lk4YA
 JJqwP8oNV0XZoHQm16NWB8KC2NGswnC3M/6tRBhXHcXkpn9DYmmOd0LtHCT4TwgPwwWd/
 EzOAXZ9WzAR8W7uVO/FCIcOmffg88/du46hCXAZ3eHLCVGjTIcmkFtn5feXIr0oDuKQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QuRkcrXE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QuRkcrXE
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B51604067C
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:53:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F4A743BD8;
 Sun,  1 Nov 2026 05:53:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793512409;
 b=KMujyep9iiaXpMdEtDZ9VbAQ3TwB4Ytk1zXekDcvX5zja0O0sVu5jabKqgqH1v6aJt9m
 P7+JhW4/BqbaD8KdxQ9KZxnxx6LjitF2fxwZp23Df3y/muDW+8wJ1RmYfLSVbgzOoy9rt
 LMGJmWwqGEpnflXPNjdNk2ZjRLujV5hgPdYLSK1NnV0Ft8Q3s4B5yqOT0K4rRuQIHs4pM
 O5p35T5eYutZVdD5D07gCDEluwsQ/otQ3Uqdq7eSgs74bYRknx4zVRuir96Wnb/TT5mTH
 XF2kD0w7FsF6c+DQfdtW4V++SqhrIf6t24y83BIe+M6NyJmU8bQSXZnErB2k+VREXOQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793512409;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=ksN0QKrXG3I3/cB8WHD5zYG7TVW5su/KBsd0um4XPNY=;
 b=Y67Vl12y3cOVTe9mXWADS5e+0ahtJPfxhJAbDsrSPwS/1gAXxrIPKEbQywPVKmzSUaGG
 8WuTlH7H0tImUNkVVyeQzEhsYBhz7zFUyUWSzSaJCB9r5P4qpW3m2U9q9fNMyydEvGY+Q
 sEPFitB11dDSpuAUULmB98Sn5N7ouQbJx4aZgsLUieP2l1Fqz51z08oDpoRGVmwvpVP5s
 slXs4FoPpGWMYmSuqQ26uB7kTsLnX1IJDpJHcIxnqeXjTmHo/c1oZbSEAUaBL+e1oAmkM
 EozFUfjzl3sY+6MGHxtPDV4Og2xtuVZyIzng4RagbZmlT6GsVfP3eAFJ6NjdDLQ2i4g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id C342F1F00A15;
 Sun,  1 Nov 2026 05:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793512409;
 bh=ksN0QKrXG3I3/cB8WHD5zYG7TVW5su/KBsd0um4XPNY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=QuRkcrXENMn7mEz4Tekhf89mpoTHbUjzVlUZQvSJR+KkjM6sIznQ8ZnXMlySPjBJ6
 LlGSny+rtO5b7+uHRaPXPh/UhGHnU18YeeqPf0+THi7U6GIXndx/FJ7PJid9RRiMm2
 6uiZn+P3xJTH8FlDFT/8aisR0oRR0yW3PXUQkPWKjjZam9h1LmbVVuV7F1EwJ6dR/2
 WHVD5pLXp7J+uKMoJGzQwXyGqnVtRFjdUGzDvg8qt8H1Oj6lJj4/ZhuirHu5ecuenx
 eLmmfAN0of5KxcUi6Mfs/mZUr4UmYRZW8Ye6SF4SSYImOBChIBN6Mp0BDjcn5JLc9x
 hFdEwph0MU4ZA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 57DA9460C1;
 Sun,  1 Nov 2026 05:53:27 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sun, 01 Nov 2026 07:53:26 +0200
Subject: [PATCH 4/4] cmd: lwip: wget: write the download to a block device
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261101-b4-wget-blk-r4-v1-4-e27a009e4043@iav.lv>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
In-Reply-To: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11085; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=Pl2PkZfpjiggCYo1gZsZB0C6tdYAeTz2R8M/dKgGyKo=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFnPLl/lsWiNscubznVaMSJIrGrxxjAPt/gTU19e9dl85
 /bzuNScjlIWBjEuBlkxRZYJhzRuZSy5+tffw/wBzBxWJpAhDFycAjCReTcZGeZk67xtbddlyX8t
 ckz+43YthvXcmSt0zL4f+9dy4r3zJ0NGhrnMv2zVSqfzSXwO69bv2c5fInPN2vrslmu2jKZp4gV
 RbAA=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
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

From: Igor Velkov <iav@iav.lv>

wget loads a file into memory, so a disk image can be written only when
it fits in RAM, and only after the whole download.

Add options to the lwIP wget command that write the download to a block
device while it arrives:

  -o <if> <dev>[.<hwpart>][:<part>|#<name>]   the target
  -s <offs>                                   byte offset into it
  -b <wbuf>                                   write buffer size

Without a partition the target is the whole device, also on a
partitioned one. The target size goes to wget as the buffer size, so a
file whose Content-Length exceeds it is refused before anything is
written, and wget says when a download does not fit. A reply other
than 200 writes nothing, and a download that fails halfway drops the
buffered tail. WGET_STREAM enables the options; sandbox64_lwip builds
them.

A ROCK Pi 4A writes a 1.86 GB image to its SD card this way in 3 min
16 s to 3 min 35 s with a 4 MiB buffer.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 cmd/Kconfig                      |   9 ++++
 cmd/lwip/wget.c                  | 107 ++++++++++++++++++++++++++++++++++++++-
 configs/sandbox64_lwip_defconfig |   1 +
 doc/usage/cmd/wget.rst           |  43 +++++++++++++++-
 net/lwip/wget.c                  |  12 ++++-
 5 files changed, 168 insertions(+), 4 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6cdfcbba32c..0f2ff32f961 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2351,6 +2351,15 @@ config WGET_HTTPS
 	help
 	  Enable TLS over http for wget.
 
+config WGET_STREAM
+	bool "wget -o: write the download to a block device"
+	depends on CMD_WGET && NET_LWIP && BLK
+	select STREAM_SINK
+	help
+	  Add wget options that write the download to a block device, or
+	  a partition of it, while it arrives, so a disk image never has
+	  to fit in RAM.
+
 config WGET_CACERT
 	bool "wget cacert"
 	depends on CMD_WGET
diff --git a/cmd/lwip/wget.c b/cmd/lwip/wget.c
index 531e886e986..d43b3becf30 100644
--- a/cmd/lwip/wget.c
+++ b/cmd/lwip/wget.c
@@ -4,10 +4,13 @@
 #include <command.h>
 #include <env.h>
 #include <image.h>
+#include <limits.h>
 #include <net.h>
+#include <stream_sink.h>
 #include <lwip/altcp_tls.h>
+#include <linux/sizes.h>
 
-U_BOOT_CMD(wget, 4, 1, do_wget,
+U_BOOT_CMD(wget, 10, 1, do_wget,
 	   "boot image via network using HTTP/HTTPS protocol"
 #if defined(CONFIG_WGET_CACERT)
 	   "\nwget cacert - configure wget root certificates"
@@ -16,6 +19,14 @@ U_BOOT_CMD(wget, 4, 1, do_wget,
 	   "[loadAddress] url\n"
 	   "wget [loadAddress] [host:]path\n"
 	   "    - load file"
+#if defined(CONFIG_WGET_STREAM)
+	   "\nwget -o <interface> <dev>[.<hwpart>][:<part>|#<name>]\n"
+	   "     [-s offs] [-b wbuf] url\n"
+	   "    - write the file to a block device while it arrives;\n"
+	   "      without a partition to the whole device; offs is a byte\n"
+	   "      offset (hex) into the device or partition; wbuf is the\n"
+	   "      write buffer size (hex, default 100000)"
+#endif
 #if defined(CONFIG_WGET_CACERT)
 	   "\nwget cacert <address> <length>\n"
 	   "    - provide CA certificates (0 0 to remove current)"
@@ -176,15 +187,106 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
 	return 0;
 }
 
+static int wget_stream_sink(void *priv, const void *buf, size_t len)
+{
+	return sink_write(priv, buf, len);
+}
+
+/* Parse a hex number of at most 16 digits; 0 on success. */
+static int parse_hex_u64(const char *str, u64 *val)
+{
+	char *end;
+
+	if (!*str || strlen(str) > 16)
+		return -EINVAL;
+	*val = simple_strtoull(str, &end, 16);
+
+	return *end ? -EINVAL : 0;
+}
+
+/* Download @url and write it to a block device while it arrives. */
+static int wget_stream(const char *ifname, const char *dev_part, u64 offs,
+		       ulong wbuf, char *url)
+{
+	struct wget_http_info info = {
+		.method = WGET_HTTP_METHOD_GET,
+		.sink = wget_stream_sink,
+	};
+	struct stream_sink *s;
+	struct blk_desc *dev;
+	lbaint_t start, count;
+	u64 outlen;
+	int ret;
+
+	if (sink_blk_area(ifname, dev_part, offs, &dev, &start, &count))
+		return CMD_RET_FAILURE;
+	s = sink_to_blk(dev, start, count, wbuf);
+	if (!s)
+		return CMD_RET_FAILURE;
+
+	/* refuse a file that cannot fit before any of it is written */
+	info.buffer_size = min_t(u64, (u64)count * dev->blksz, ULONG_MAX);
+	info.check_buffer_size = true;
+	info.sink_priv = s;
+	ret = wget_request(0, url, &info);
+	wget_info = &default_wget_info;
+
+	/* a failed download leaves its buffered tail unwritten */
+	if (ret) {
+		sink_abort(s);
+		return CMD_RET_FAILURE;
+	}
+	if (sink_finish(s, &outlen))
+		return CMD_RET_FAILURE;
+
+	printf("%llu bytes written\n", outlen);
+
+	return CMD_RET_SUCCESS;
+}
+
 int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 {
 	char *end;
 	char *url;
 	ulong dst_addr;
 	char nurl[1024];
+	const char *ifname = NULL, *dev_part = NULL;
+	u64 offs = 0, val;
+	ulong wbuf = SZ_1M;
+	bool has_offs = false, has_wbuf = false;
 
 	wget_info = &default_wget_info;
 
+	while (CONFIG_IS_ENABLED(WGET_STREAM) && argc > 1 &&
+	       argv[1][0] == '-') {
+		if (!strcmp(argv[1], "-o") && argc > 3) {
+			ifname = argv[2];
+			dev_part = argv[3];
+			argc -= 3;
+			argv += 3;
+		} else if (!strcmp(argv[1], "-s") && argc > 2) {
+			if (parse_hex_u64(argv[2], &offs))
+				return CMD_RET_USAGE;
+			has_offs = true;
+			argc -= 2;
+			argv += 2;
+		} else if (!strcmp(argv[1], "-b") && argc > 2) {
+			if (parse_hex_u64(argv[2], &val) || val > ULONG_MAX)
+				return CMD_RET_USAGE;
+			wbuf = val;
+			has_wbuf = true;
+			argc -= 2;
+			argv += 2;
+		} else {
+			return CMD_RET_USAGE;
+		}
+	}
+	/* -s and -b need -o, and -o takes nothing but a URL */
+	if ((has_offs || has_wbuf) && !ifname)
+		return CMD_RET_USAGE;
+	if (ifname && argc != 2)
+		return CMD_RET_USAGE;
+
 #if CONFIG_IS_ENABLED(WGET_CACERT)
 	if (argc == 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
 		return set_cacert(argv[2], argv[3]);
@@ -219,6 +321,9 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 	if (parse_legacy_arg(url, nurl, sizeof(nurl)))
 		return CMD_RET_FAILURE;
 
+	if (CONFIG_IS_ENABLED(WGET_STREAM) && ifname)
+		return wget_stream(ifname, dev_part, offs, wbuf, nurl);
+
 	if (wget_do_request(dst_addr, nurl))
 		return CMD_RET_FAILURE;
 
diff --git a/configs/sandbox64_lwip_defconfig b/configs/sandbox64_lwip_defconfig
index 0e92728533f..ce5c503583e 100644
--- a/configs/sandbox64_lwip_defconfig
+++ b/configs/sandbox64_lwip_defconfig
@@ -3,3 +3,4 @@
 CONFIG_SANDBOX=y
 
 CONFIG_NET_LWIP=y
+CONFIG_WGET_STREAM=y
diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index e6c33b87431..3dc623313fd 100644
--- a/doc/usage/cmd/wget.rst
+++ b/doc/usage/cmd/wget.rst
@@ -15,6 +15,8 @@ Synopsis
     wget [address] url                  # lwIP only
     wget cacert none|optional|required  # lwIP only
     wget cacert <address> <size>        # lwIP only
+    wget -o <interface> <dev>[.<hwpart>][:<part>|#<name>] [-s offs] [-b wbuf] url
+                                        # lwIP only
 
 
 Description
@@ -81,6 +83,32 @@ required
     certificate verification is mandatory. If no root certificates have been
     configured, HTTPS transfers will fail.
 
+Writing to a block device (lwIP only)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+With -o, wget writes the file to a block device while it arrives instead of
+loading it into memory, so a disk image larger than RAM can be written. wget
+pads the last partial block with zeroes. A file whose Content-Length exceeds
+the target area is refused before anything is written. lwIP reads that length
+correctly only below 2 GiB, so a larger file, or one sent without a length,
+fails only when it reaches the end of the area, if it does not fit. When the
+server answers with a status other than 200, wget writes nothing. A transfer
+that fails halfway leaves on the device what arrived before the write buffer
+last filled.
+
+-o <interface> <dev>[.<hwpart>][:<part>|#<name>]
+    the target. Without a partition the target is the whole device (or the
+    hardware partition), also when the device has a partition table. With a
+    partition number or name the target is that partition.
+
+-s offs
+    byte offset (hex) into the target, a multiple of the block size; 0 by
+    default.
+
+-b wbuf
+    size (hex) of the write buffer, a multiple of the block size; 100000
+    (1 MiB) by default. A larger buffer gives fewer, longer writes.
+
 
 Examples
 --------
@@ -172,6 +200,18 @@ https://cacerts.digicert.com/DigiCertTLSRSA4096RootG5.crt.
    # The builtin certificates can be restored at any time
    => wget cacert builtin
 
+Writing a disk image to the SD card of a ROCK Pi 4A with a 4 MiB write
+buffer:
+
+::
+
+   => dhcp
+   => wget -o mmc 1 -b 400000 http://192.168.1.65/ub-test/armbian.img
+   ##################################################
+   1862270976 bytes transferred in 197525 ms (9 MiB/s)
+   Bytes transferred = 1862270976 (6f000000 hex)
+   1862270976 bytes written
+
 Configuration
 -------------
 
@@ -179,7 +219,8 @@ The command is only available if CONFIG_CMD_WGET=y.
 To enable lwIP support set CONFIG_NET_LWIP=y. In this case, root certificates
 support can be enabled via CONFIG_WGET_BUILTIN_CACERT=y
 CONFIG_WGET_BUILTIN_CACERT_PATH=<some path> (for built-in certificates) and/or
-CONFIG_WGET_CACERT=y (for the wget cacert command).
+CONFIG_WGET_CACERT=y (for the wget cacert command). CONFIG_WGET_STREAM=y adds
+the -o, -s and -b options.
 
 TCP Selective Acknowledgments in the legacy network stack can be enabled via
 CONFIG_PROT_TCP_SACK=y. This will improve the download speed. Selective
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 5d275d28a81..ce90990163c 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -191,8 +191,12 @@ static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
 	int ret;
 
 	/* Avoid overflow */
-	if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len)
+	if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len) {
+		if (!wget_info->silent)
+			log_err("\nwget: the file does not fit in %lu bytes\n",
+				wget_info->buffer_size);
 		return -1;
+	}
 
 	if (wget_info->sink)
 		ret = wget_info->sink(wget_info->sink_priv, src, len);
@@ -341,8 +345,12 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 
 	/* lwIP passes U32_MAX when the reply has no usable Content-Length */
 	if (wget_info->check_buffer_size && content_len != U32_MAX &&
-	    (ulong)content_len > wget_info->buffer_size)
+	    (ulong)content_len > wget_info->buffer_size) {
+		if (!wget_info->silent)
+			log_err("wget: %u bytes do not fit in %lu bytes\n",
+				content_len, wget_info->buffer_size);
 		return ERR_BUF;
+	}
 
 	ctx->content_len = content_len;
 

-- 
2.43.0


