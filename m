Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BF9CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6843A80981;
	Mon, 28 Sep 2026 13:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DqpdZKEy8xqX; Mon, 28 Sep 2026 13:42:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E34AD80F88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602960;
	b=LKhBVwqphPcwdZpWWPAK6SOYbhHawRmK1XzpyzGrU7ZnB3HlH4SpTmYjF1tvyleWELWe
	 NZXiQqKYQo47WNOvplnxINzgfl5it9YNP+uRADZn02EwfpMoPTG3dQETsptp1PQG+MzMy
	 k1lEnbfqjNAxQgcjGL/4tdxpgX10E2577+5Ppx4jPwHKDxL3SJvxE14PtP9HjgEaFczJu
	 Zs/FgGh4/BMDks1r7RLq6/2KOYuwBI76N+VG1jcB4h2I5tulMVuiW28TRML3pLLd/7mLc
	 f2K27/5qc2+NGzwEVNFY6JAe1KtxR6VkEZ4ruYCaapI/U88689GsEUPxoxKmNSMEK2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602960;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lyC4F2PyY94Psx7l34MohNJBUDo/Q1PJsECkd6UNbis=;
	b=XtYT48l1wYSkwvobYvB8gK6aHHpG1OUiacjGa3t+ga/EOAkUtwzFylol812lQF58O6kI
	 1tlD5XEZdp5nLyS2/FcjlYycrWIXSoEy2EIzVSea/axngPjhPe99oiEY/Rv0rGU5CgN3I
	 0ZX4j1vBgRsN6e38i8pDWr1w8tY6dm1hPMGe0O2d9Wvl9Ds7wnToIdp9LsfWIEiVoYbat
	 0XNsuzU7L+/zVjnJFi7FZoQ8b/tDe004i15hi/CnMsg7R4bPCiiuhm3gMoLLSJDZmvoXF
	 yZQnb5yiH/lsg0tc3PLZzSy4lSaZB6ns7W1/RndMopm016NSc+ErwqI2OtnJ9aL7H7Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602960;
	bh=lyC4F2PyY94Psx7l34MohNJBUDo/Q1PJsECkd6UNbis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nC+GL97SuhqU1nmhAF/iyhx2iQgAVjsogtBTtEVE56l4PLdFxb6EHckDV6xXFL7wR
	 wW9iu+/Pl3/K6UXsLS9hfTNTIBesu7CEoQCNgaYjREfaxBCTTaZGOyx04aEZr1t5aa
	 hu4rr/6iDMtH980x/Phgh/Ye2IM7PmithiYRPBLoDQUMRRyIMcYkimWuwOtnR0CVr0
	 bJLx/Q0sxlnGfzYgRBcJGWTL4uK5g5tR4VAjOUpM4ICSll0QBIpBqhfYu28tHU1whR
	 +5GBh1/hNKJVZfyBFbMld+FDPmu2m/YhVpUmQAFwfM8lhlk2Zki9BXjp8EDnznofQd
	 H6x2umUOIafYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E34AD80F88;
	Mon, 28 Sep 2026 13:42:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 431B8361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3501E60601
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 64EH49-mkaS0 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:05:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 43E8C605E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593529;
 b=UTqb4L9myScTTFaratFKg1n09JrB+wCd5UPud89viYzrrM7mxUnsEQpV5mR4fmH+fmXT
 VlksDbqd6q64RbBmfjOnNpFzPRzkNy8G77nnkRV5HlsKJNzvR+aHUTuB6bYYuF1sbaLqF
 VoGNOcBVMBwV0G9xwIb5XZnK9B9Ws5pubtYYrwsQBDFv0UnjTyaSZPWQTDZY4RdQvIOHm
 gGgueel0J4EDtp2yjkEP8RfPlTduTVw/31wsyR37pr569yV023KtUXwmyBT++NxfRjMHS
 o1FtcpLI0CXAyKAwkE3HQM6nvemvuqo/ddcTIl6G4QhmTHpZswI4IIYzJp10GZI41Ug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593529;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=lyC4F2PyY94Psx7l34MohNJBUDo/Q1PJsECkd6UNbis=;
 b=Yjn5EPfgTAN+bX0XHxuXVih5HkgAqnZl7J7apkar/m73gRFtN4r9Cr3w9F1GfvnpiSsf
 dfuFeza51CtfMUaBriZlD+HO8kRcERudPOIByqwq3zG7zV3Ov70m2Kw/S+WPqLWHVbM9g
 sWqN7n7IbYC8VOb9jYdaCouxmCTYLZLIsVoS4Qdg65xg72idW/zh1ATYOkPTS1eJnOatX
 aSny5U9X8TqIEocc8/CUcZAlOoETvIWokRFrH//WiakGVLAOspNuhrKCKQEwirZVgaKzI
 tpsTWilmo2/Xl4fqFCo/9pSazJU7b9IvgRSxqTuUe6TMmpuGFe9gSkDP1X/MM5j4Ccg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PpcYVkC3; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=pepe.schlehofer@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PpcYVkC3
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43E8C605E4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:28 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4887840c529so1067748f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593526; x=1791198326;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lyC4F2PyY94Psx7l34MohNJBUDo/Q1PJsECkd6UNbis=;
 b=PpcYVkC3jHDMLkyg43aiPzneH3A0ywq0a/SBe6v9au7CWiWoZdka2pbZArz3T87+6u
 K+91HiEPg4c3DY+6OfD+O9oQ1boijdC+RZqmopWNa1oLVbzq920y4BF63Yq2ZMBS9PhZ
 d62+L/Y+U6MUjWAtzePmdfw02NosLUCoXuuvJr6DnaqRNTQ/BmlESEzZcIKlSfJE8vjM
 cEQT9l+k/ihTf1CvTy56SF4ZgKHyFoIwljoGkhtRKdS8O9WQeJNHi3IJHFyJlN6+CMSb
 ulEej5bLIgQ8zDgD6ZNibRjGhCMkfzJTpTCKlhwX4GmJ815iZmv8nI4AEB/8EalUHeP7
 WSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593526; x=1791198326;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lyC4F2PyY94Psx7l34MohNJBUDo/Q1PJsECkd6UNbis=;
 b=zQW8nNWdhAZC/F+zXgItq5M7L6KBPwUUmY0t7v57GIGNeIC4cZA7ExeD3KB96/0B6J
 5/DHuENyjvZ7OdplBXd6ylQRSiIdY8zpNSUhDC6VfxnVGCJw8yXIqqJk9qZ0WnhVk6d1
 HxMCtT3eesju4xwb4aPY6fz/iCpocjgRi1S8m3y/Ku6o+Bj+FSJnsU7RskNqmAc/07zE
 uh5c7adkr1hkhPa2ucvQ18SRE6G/7dUuSgrVhLJboWz8XzpK8AUmViKU0fQeyEZ52E6F
 TR9SEWN4EYnlgV9jsPSJnaTVa8UcihHPeUvL0YHHz4gBtcyhjPfNymeCqwrypFH0P03F
 6TcA==
X-Gm-Message-State: AFuF++kq+DI1IcPRmprpXlZxn6EF5UoQDZDieRJG3tGQQkhq0aO20Raa
 od23tzwfnY1hLyqAvwUDkErrfvbEgT2NFhpuseIUltglcI8O1Rp7M2liRWYNPbZzlgM=
X-Gm-Gg: AYBFou1Qh6sOAlgDOYGh6XgxF5VLZQJX7Dfty+WNo9ZgZ4c3UzyfuL5ma+tmAVoUHC/
 vBU/vkmZ9Gk+oFR+gW8ALveMsXy9A6vgsIjkKOEgKlHKZgJb6T/fPRnNDao1a90xJItSEg9EH3/
 IEQZQ60rXbz6RTgYO5uzLJ5cjgBVidjJ6S+9PAGydRL6UBfigFc64xkkoesa9q8Lb6ebYjVt56O
 WwE7Z76NEV6SRMhzkUYkA3L5W3lKR524pLR/gO7sIGsXvaFc1mBLZ43qpg2025wdcDVjiXFHAdB
 iZnfhhsR4/+cBcBo6mNY3N6dekOyR7ny1g0LfTQdEaLGhoq5RKvTtXoMu85LAmPZAqSOchjI7Q4
 Vj4GuzjF4t68DF7kig5bZKGTdIsbmnmulz20EPGCxEgSa0szb/CIgtaKv/2+xZrm2Eyx+kYFSt8
 JA0Exuj5uQIa/nII+sPbefIbF2l2jVJFuvVlJxF9fYzUzTCBOnBUoHl9oqg6t+n5NUcgaU1jAX8
 eLIkcoX/43+MWpVxSLFtiJPwr76AwZ+0vJb6tAe8nIMEXpUWxb+kQMWRXqgDRC3QXwQ9kcd2kQ0
 1rl8K9KgGXWdHjsltAGUrKqWvDROzNqbLRzia5rMLzr8AJn8+B4=
X-Received: by 2002:a05:600c:4705:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-49fe66d03b6mr222138755e9.5.1790593526565; 
 Mon, 28 Sep 2026 04:05:26 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.05.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:05:25 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH next 11/13] board: CZ.NIC: turris_1x: Make NVMe and SCSI boot
 targets conditional
Date: Mon, 28 Sep 2026 13:04:32 +0200
Message-ID: <20260928110434.70686-12-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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

A Turris 1.x configuration without CONFIG_NVME or CONFIG_SCSI does not
build. The NVMe and SCSI distroboot targets are listed unconditionally,
and config_distro_bootcmd.h turns a target whose support is disabled
into a build error such as:

  error: expected '}' before
  'BOOT_TARGET_DEVICES_references_NVME_without_CONFIG_NVME'

List the NVMe target only when CONFIG_NVME is enabled and the SCSI
target only when CONFIG_SCSI is enabled, so that the NOR build can drop
NVMe and SCSI to make room for the ubi command. Both defconfigs enable
NVMe and SCSI, so nothing changes yet.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
u-boot.bin of turris_1x_nor and turris_1x_sdcard has the same size and
md5 before and after this patch (Debian GCC 14.2).
---
 include/configs/turris_1x.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/configs/turris_1x.h b/include/configs/turris_1x.h
index c05614950c7..3a2818d1904 100644
--- a/include/configs/turris_1x.h
+++ b/include/configs/turris_1x.h
@@ -71,6 +71,18 @@
  *         define CONFIG_SPL_MAX_SIZE = CONFIG_SYS_L2_SIZE
  */
 
+#ifdef CONFIG_NVME
+#define BOOT_TARGET_NVME(func) func(NVME, nvme, 0)
+#else
+#define BOOT_TARGET_NVME(func)
+#endif
+
+#ifdef CONFIG_SCSI
+#define BOOT_TARGET_SCSI(func) func(SCSI, scsi, 0)
+#else
+#define BOOT_TARGET_SCSI(func)
+#endif
+
 #ifdef CONFIG_SDCARD
 #define CFG_SYS_MMC_U_BOOT_SIZE	CONFIG_BOARD_SIZE_LIMIT
 #define CFG_SYS_MMC_U_BOOT_DST	CONFIG_TEXT_BASE
@@ -266,8 +278,8 @@
 #ifdef CONFIG_SDCARD
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 0) \
-	func(NVME, nvme, 0) \
-	func(SCSI, scsi, 0) \
+	BOOT_TARGET_NVME(func) \
+	BOOT_TARGET_SCSI(func) \
 	func(USB, usb, 0) \
 	func(USB, usb, 1) \
 	func(USB, usb, 2) \
@@ -279,8 +291,8 @@
 #else
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 0) \
-	func(NVME, nvme, 0) \
-	func(SCSI, scsi, 0) \
+	BOOT_TARGET_NVME(func) \
+	BOOT_TARGET_SCSI(func) \
 	func(USB, usb, 0) \
 	func(USB, usb, 1) \
 	func(USB, usb, 2) \
-- 
2.54.0 (Apple Git-157)

