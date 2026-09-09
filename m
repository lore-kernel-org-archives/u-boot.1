Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D01C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A070480EEE;
	Wed,  9 Sep 2026 20:44:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4ZVCalesu98; Wed,  9 Sep 2026 20:44:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E620A80EFE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788986692;
	b=AYJha79hvnQFBBP/SoJqpnvlGFvmWZNiXLJsFeWbLnLxwGb8+LzIf0x6KxNaH1F7VNo4
	 3SIQyUPNjsQvmd0Gun+b9oPJWJpvW5zfi8v+77ebmasm2Rowzj0DIOpezVFPfiiugfmjJ
	 C5RYCtERXicwAXk41ibXFHI4Ekf3mAv8a/oRUtdWKZL5VMs501Z/uSQM10a6KIxMFMpcP
	 vCbKMxbXy2DtHtQ+d+nBToX7TjNKCbvmRt/MmCiL/ZrsotkGoVSc6KNV6J+MaBncY8C+1
	 ot6vnc2tq5g2iiqt2FySfON3NrqKjc4/FgHOXhCPJVMPQBmZ3FbnVQH77/GbL5Jix4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788986692;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0N0gEBdF78Azeo0zrEm1QEoX97TtVniYpp2Q+Ked5mM=;
	b=OpzsDk8lr4WfmsB+sJnlWg6HihRNLxEOqF0aCAnaaENo2ntbSzphTLho5a1I+xhQ74lH
	 AbavM6BvlKvgA5CYHJGdjO7Ko2N/l63rucERzQx8/uGAFmEE6UZw8aaHKK7gV63+SyRBV
	 A30KNtSIFLmbT6pmsoU04yeKifZ15/zBCLxkJW3/jHQn3GN295HvHLagQ0uj2f0Zsk5VV
	 yMcgH/XHhDojAFdUIKaJiwccc1TmIV6rWl+ZI8FEQjN5tmyCzwUhaljihwrXdawZZqGLh
	 O3u+sMJaXR2xFN0kQj/Vjs2oSva6hJdkz2UpQ6PfqBUwrt+OTxFMN/FhPXctTx2nOhA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=MUyqopsr;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788986692;
	bh=0N0gEBdF78Azeo0zrEm1QEoX97TtVniYpp2Q+Ked5mM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=N43Sc9obsY4XRTcQjYXfNGiK4whrPZweb6jlZFBvQkS7L4gGZM/I+IX4kV0d1FO3c
	 1bwCff8WeBHpHayL+q6k0XWFZuaT9yzmQSarcaqgA9quDY7f1yGtrq0fBGV/bWfwn0
	 j23Te9j3+bS03PGaEI0bousRtYGTPZU+HSlRLHNuzbEzn31QxTTF51L1D6szk1wbug
	 5sFiI9doqIy/2miDHGTrKOYf+AmYUqjlTCXglKGQbSfYsTpSCxOAwKb8axfvphYvHG
	 SkX2LSqDVhYsFMNqDV2e9WBZIfehLmrPPQ69QCVkh3yGgHyb73OjurHpxHRpIaEXrf
	 KmFLxpmn7Zlug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E620A80EFE;
	Wed,  9 Sep 2026 20:44:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E8F23AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64B0F81858
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X5Qc2rMQcBKY for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 19:20:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AEEAF81854
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788981624;
 b=l5J5DhF7s2v2g5I63wVzuhrEjPiyZ3LFTAbW6CYrQI8VCci/HSIyAFOotXqogwsoBBmY
 FsUPbP4oh+3s+yjcbfeZ3uL87/TJyA+e3Lq8OZP16ZBoII4lgSyErBD77+ZnIWCH6vQZf
 MgRvoW3UiSRImCYzv5aCz9hSp8HR7ieXsyWI4TuzpQKSrgfkbSHEhCObPAcg1FBi8Hi5W
 fpufuNVW8DafUtDnHw7V0JhgHZLr8tsQTqTwPJJMQLzYzd/YJc6KXV6uOnVKOd6C/uCqm
 4qamQwgISSBenFIROGA+EU2SePUR5kPczqVsLBoDHWbtksqi8Ty6FT54EaucOgopiLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788981624;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Spam-Status:X-Spam-Checker-Version;
 bh=0N0gEBdF78Azeo0zrEm1QEoX97TtVniYpp2Q+Ked5mM=;
 b=h0muaj9vos+urkrCd5AH8iUfbKLyhii9ZoHajeqEhDiOur6d29BYXA5FAmj27FRkeb5i
 CH3D/yPnfAWGgdC8yMAZh3fzuIdBrFR7bne/MdDoNMDjfLEi9nsDJgr8Ege6eV8D9UB66
 Wlb/c4qY20yX8ZY0fAVpnXUF/ZaG3gPwmlbnycc8aLqGS3UksuDezglVBjpSQChZDu+cI
 F8hVmTqL52Lr4k1dSJb//n5ZrSc89rQ65jddT/qNWlvjhPN0iRBWGwekQXAjT/U2fC9tT
 LC8fAuAX7gqIkf0NFEd3G+2iufJBcerJgD5BS86rER8g8kd27Nzim9Wv0ty7kLM5svg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=MUyqopsr; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=MUyqopsr
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp1.osuosl.org (Postfix) with ESMTP id AEEAF81854
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:24 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id 194BA20B7169;
 Wed,  9 Sep 2026 12:19:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 194BA20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1788981582;
 bh=0N0gEBdF78Azeo0zrEm1QEoX97TtVniYpp2Q+Ked5mM=;
 h=From:To:Cc:Subject:Date:From;
 b=MUyqopsrJLjWcEn0ZqjfhmJdGmQX8yj4te8UlsTqU+J23zE68O0W6hpkG4G1m9wSk
 5v8Hul3taLGIFnPsng/w2yhS5ufEVKk2UyCqHc1si14+VgNu94k4O9iXJOtVzskmfI
 NWC6k4bC/zB06M7f999Rhd/x7SlHiPqt9VnvS3ek=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH 0/4] Bounds/overflow hardening in NFS, FIT, TFTP and ext4
Date: Wed,  9 Sep 2026 12:20:12 -0700
Message-ID: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 20:44:50 +0000
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

This series collects four independent robustness fixes to network, boot
image and filesystem code that handle attacker-influenced or on-disk
input. Each was found by auditing length handling around memcpy(),
integer arithmetic on packet/image data, and loop-counter widths.

  1. net: nfs: the NFS client copies received UDP payloads into a
     stack-allocated struct rpc_t with memcpy() using the wire length
     without checking it against the destination size, allowing a
     malicious NFS server to overflow the stack buffer. Add a bounds
     check at each copy site.

  2. boot: image-fit: the decompression path computes the output buffer
     size as 'len * 20', which can wrap on 32/64-bit ulong for a large
     image and cause a heap buffer overflow. Reject sizes that would
     overflow before the multiplication.

  3. net: tftp: the OACK option parser uses strcasecmp() on packet data
     that may not be NUL-terminated within the received length, causing
     an out-of-bounds read. Use a bounded strncasecmp() plus an explicit
     terminator check.

  4. fs: ext4: ext4fs_update() walks all block groups with a signed
     16-bit loop counter while fs->no_blkgrp is a uint32_t. A filesystem
     with more than 32767 block groups overflows the counter (undefined
     behaviour) and the bitmap write-back loops fail to terminate
     correctly. Widen the counter to u32.

The fixes are independent and can be applied in any order. Built for
sandbox (net/tftp.o, boot/image-fit.o, fs/ext4/ext4_write.o, and
net/nfs-common.o with CONFIG_CMD_NFS=y) and checked with
scripts/checkpatch.pl.

Daniel Munic (1):
  fs: ext4: widen ext4fs_update() block-group loop counter

Drew Kluemke (3):
  net: nfs: add bounds checks on memcpy into stack-allocated rpc_pkt
  boot: image-fit: add overflow guard for FIT decompression buffer
  net: tftp: use bounded string compare for OACK option parsing

 boot/image-fit.c     | 10 +++++++++-
 fs/ext4/ext4_write.c |  2 +-
 net/nfs-common.c     | 10 ++++++++++
 net/tftp.c           | 13 +++++++++----
 4 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.49.0

