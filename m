Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774B2C88E7D
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38F02406C6;
	Tue, 15 Sep 2026 20:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id trYrYOd-gxzR; Tue, 15 Sep 2026 20:52:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7CBDC406C4
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789505545;
	b=hnGWMUSHhDJvjHBA0YDbmlxnSy7DLFpXAmr6Zi4BBVWIj43j+f/We94SZ8b/BXq0aHr3
	 iaOG4n5w0m2shL1GHuJl01KnjjcncwsLTlzN4J0nsl7RmPDM060Cd7rWDZlnsbH569bLt
	 CJonUoETOMc1oALzKTETWjQ+iKma3mOPdWz3582v/50JUMosHwdfAntDWPnWx3Jt7uh9N
	 VB8KtaytQDgrwAoIWDUXh6U4BUHdtjLJ99EZWAOsqccNjxbpok1WiLa4oTCG6qXrlxjKO
	 Frsi2AQlWHb/sGQQWZRZ+5+fMLZuRuiM63+UaOul06edyAMW2QVnZROCi1WE831586A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789505545;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JJP44cMePmdUU6vDpTMoABj2ntp9HgbNv54f7UoV1Z8=;
	b=TWfcClZZefdtr/bxsDR5aGFTmmQ9p9UTH6CwNNMLSUXSUp4CT2c9XiIjfbx6zkAWG1Vj
	 qNCxDPX00aObjAsSs8gT+k+DKpQ6xE5cwgFTRyC3npWtRZwe4QaXpmXk9BQ1Q0QInVSEj
	 Ie7QnT6yz4KLvJ7mA0Z5K+g+C52MkPKSShe2qQ1BHHSny+f60AvmueuqZZIOUM2aBU9qc
	 DOLHRusPb20cSA3g+d5CbC14/Zuef00NLZ5qqgT45Z0bVl9QM7gzRHaURNIOuJbs3vCez
	 v8HaLgFh62bzbgS+ep9JFRuzHwpbaMv1MTlXsiQZyGQUgLyhGwRoaURu35VXiB1z9jg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789505545;
	bh=JJP44cMePmdUU6vDpTMoABj2ntp9HgbNv54f7UoV1Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kvS6Sy8vG8dX9ZcXgI5+KhuqBXnEgUsnGaco0xwn5APGR09LHXpnCiNWV2BOYRHmu
	 VD6lOPUEsbc3REKUlQkxphSNfJAyRIPwGhwbTCybTxM4I38tCK1AyPQrUvXbqrW+MZ
	 PP2fgGUcPCDSXc0cBIm99I8TPbfunn4CjT6CL5jipNQveqeWTMMxZX4Xr6zgtWhZgQ
	 nMQZFScY82Zbtl3tIPbjJaAX0WGA/ztTp2oaxPoXVFoTLyf/7jRz1zkCUEbqStBKwg
	 69m109C7ZTBn9UWmBiMuoa9LvgWnytK3tcvZDXqqk7Bckqu5BPEyXxvfxWihHT5fDw
	 6OwfGL1pdjxWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CBDC406C4;
	Tue, 15 Sep 2026 20:52:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E5D1C23F
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7B9D60782
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:52:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MiB3T7LpJhTk for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:52:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 31A70606CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789505542;
 b=elJ/a8Kvu4MGv5z5z0kqQ40WyVRa4NBcjDedTh1a/dGVkNpSMTD1O8ueZH37XFMfLszs
 E5kHXSvRlQLsAcM/CUrbkbCh5xg4OFyppfBPDw+DZp/n4SH2ufQ/iu2a8m+elIhsS8pqQ
 aobGd10IiQQSvvjU4+oOl7sil+wQO08P8+0fXvrNLIKym2s3JFYDhuKhGfN5ctvRWgbWb
 Dd4asOW+p6wL3Z0VMcvN1la+uAZKb7V6x/SQD7QklG3sXs8NSZsVC4IhLWVm8oTZbb4bu
 PZ35hD+nTYiTrpbpspFVuqDcluucpP+xQ1uS+u37iq605Us+aFBWIH5y+ONDu1BikbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789505542;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=JJP44cMePmdUU6vDpTMoABj2ntp9HgbNv54f7UoV1Z8=;
 b=QVLBEdUrWn2YtsM7+X5xGY3L00YYz44CnExarZWnJKybkdG1K6kolQuTmhc9tGBwIpVp
 41YyJXr5vLtxBjM8aVSh8FtlcNFrLo9Sm09YujQdVrI1yXzrv0AhdpWsEQQs1tMEY2O58
 AMLDkRpwPntPHUDFXys7H8PY1g7Ic34ktdmgYi7alq8rkRKsZAfx2ptOurSQwUS3szyEk
 EgytvibC5haijaIyYylP+Zzt4NL3kBRRluqoaF9/cRHPQAkm8drZuR5ejazp6T+TF9jlr
 3P+K/7WWfiPQgsd6YcEcWkxZRxSUCpBKqL+mKWqLkLEnb8GeKROHNAa/TORpnbrpDTg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=HpIVtVtK; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=HpIVtVtK
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31A70606CE
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:52:21 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1410420B7169;
 Tue, 15 Sep 2026 13:51:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1410420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789505495;
 bh=JJP44cMePmdUU6vDpTMoABj2ntp9HgbNv54f7UoV1Z8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HpIVtVtK+y+ZjhU3SpR0jafV8ny83Xq3s0szs9VfbejQmTqCd5phHEOH42NUxGV8b
 GXQFPgMHXrxlI37hr9hbeYjZst0ubCUUsqP2Xdm1Faw0WajDYoJF/35tiz0xQX4vas
 vZOwtZNKjEK6cAN1ohFoFK8pqh2qh86eDCZ/TRqo=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH v2 2/3] net: tftp: verify the OACK packet is NUL terminated
Date: Tue, 15 Sep 2026 13:52:09 -0700
Message-ID: <20260915205210.260404-3-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Drew Kluemke <ankluemk@microsoft.com>

The OACK handler matches option names with strcasecmp() and parses the
values with dectoul(). Both scan until a NUL byte, so a malformed or
truncated OACK that contains no NUL within the received length makes
them read past the end of the packet buffer.

RFC 2347 formats an OACK as a sequence of NUL terminated netascii
strings, so the last byte of a well-formed packet is always a NUL.
Check for it once on entry and drop the packet if it is missing, which
keeps every strcasecmp() and dectoul() below in bounds without having to
bound each one individually.

Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
---
Changes in v2:
 - Replaced the four bounded strncasecmp() comparisons with a single
   check that the packet ends in a NUL, per Tom's review. RFC 2347
   guarantees the trailing NUL, so one test covers every strcasecmp()
   and, unlike v1, the dectoul() calls as well.
 - Smaller: +16 bytes of .text on am335x_evm_defconfig, against +24 for
   v1 (net/tftp.o 3222 unpatched, 3246 in v1, 3238 here).
 - Retitled from "net: tftp: use bounded string compare for OACK option
   parsing" to match the new approach.

 net/tftp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/tftp.c b/net/tftp.c
index beb9d08f5a2..73b31b8357d 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -528,6 +528,13 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 #endif
 
 	case TFTP_OACK:
+		/*
+		 * RFC 2347 makes every option name and value a NUL terminated
+		 * string, so a well-formed OACK always ends in a NUL. Checking
+		 * that once keeps the option parsing below in bounds.
+		 */
+		if (!len || pkt[len - 1] != '\0')
+			return;
 		debug("Got OACK: ");
 		for (i = 0; i < len; i++) {
 			if (pkt[i] == '\0')
-- 
2.49.0

