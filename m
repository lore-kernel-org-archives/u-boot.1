Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF736CC6B2E
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB0CE81013;
	Wed, 14 Oct 2026 20:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yJ-9CtA5wGQF; Wed, 14 Oct 2026 20:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B64A581005
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008197;
	b=ioPM0X+KdUf4B89qzx9fcS1lq7MRr98a2VdWJQRi31fTRFYxKsWok/xCdlgDmFeKTQXj
	 nqj8BxS1xAtpouo078Zj158Dp6cIkrH+C41qSGzwFSYF7A0KaB/Hodk576jXChr2CllKC
	 +vLcsknfS9Ztrt3E75Luul+jj6gGFKNLB1RYLg5zTYf7ZOnNyNC+AuBuMG6qTOFq6s26I
	 u1inM/aCps0+yRnBvPEVOjW+heAmIC/AGf9nijQoKWNemxcLDipBAYCcD4uw+xqwl9Imq
	 CzBj00v/73GoagudxqVCPG2T7PkR0IpprHWP4GwUk/MyHwADJ1iG04z8JnedrL55MBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XcJIuvLgUDjyCPNvajw8QQ10vVu9LLybfR//XiiFqGc=;
	b=LnfG3UW5jVuVy2p8QfHdEaP5sBgaHuiO/L6dPKRXwVjHHccTsk1ikA7O05kkWF98LZYw
	 wPbJjv1hTK2IZVMZmcfhKgmeXAgnCrdVGAohhBuuMN7Kbf5dl+iLS3dD8+j4jGzoQfK1W
	 O5AdUxV2oOJSNAtLWWVzplo5K81eL4mgSsuEAzk0JykqV3RQXdLQnJzwjPiKat2+NlW3/
	 3sk9nXcNYRTMbtIoHYvc7Eur7/w9rNNs7OSp3FC+RAUrtYKQDXe5dTafRtbHYlkIweLSP
	 kSCwyE5TtCcxOW/USMwO6rQoAHEGYW8nT6vvn6iJxqryFdY/G0juan1xIyM5FMSrDaw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008197;
	bh=XcJIuvLgUDjyCPNvajw8QQ10vVu9LLybfR//XiiFqGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F1ffF1wGb6y1XzzRJQvklMcZAiiNBnYXkTze8ZgWNmopBhL1gW/eSH7pYqnkjUuSm
	 TU9Kmhn1cZRmaMGE5uKFKAYqXTek9wH56xGykjD3Jch17P6PN+fMFhgpLlQYuvC7LL
	 C+oKfsRKZG3TKoiXxbgWjhJNSY9HMHn8/YI9IwIiq4LcoWdeyzXA04s389/EA8g18D
	 inQf6S5glbVEvlQ1143b3+eDFbH+oH6Z0eKW4wHzQroQjeU3r/hlQv+LUPf0+ExQED
	 RnA5eDExgBBPbmlma9Co6VrcQtNhjNtPv2jtU1600H1xjeoEM5jvWzJeCURedXRQ0H
	 ohU94mplqnBJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B64A581005;
	Wed, 14 Oct 2026 20:03:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99F81A58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91F1740191
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m5iLgqLyML2X for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CA8C74009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002194;
 b=I0HBmp6re4znO4JgyS/auDXKwLTDHS17pUYBf7n4Uy+C8WRCcXIZoYnavI4G7rZe7rlm
 oLW5WkEWlxPJVb4z+l0ZZsXTFCfesMKsvyOR/oBY4SUxKS7ij63w7zoGbX0SiznNzHYdz
 rHzo4gLwo4uoWd/wrijbNFCZbjMfg2KINSJ3N2OHLNkz9+zDewVws8z38QBxoG+4IFjLC
 7xTCVnRcr/jVAPWBaFKguzRNHORm2el7ikw/+OjC1RfyGf3NMPRvRV4rs/REEquC487vB
 PnRS9se6H+IQC2q+T3iKZAYqp1bxAHmconfkg0moh1TXH62Tx9mRLk6SeRjemXZeC8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002194;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=XcJIuvLgUDjyCPNvajw8QQ10vVu9LLybfR//XiiFqGc=;
 b=P0H7Ngha21lh5/FIR2lgwua5abyqjLgbUiiAKS5TdECeMZOO6CEtNFzqDIz1+Y2cyAsw
 /JGUDBY4S+41rox3FdMDaoCZ+u13mscvLxWRanI8ds7ryDnDBvKRuE0LKLr3D4KU4ixLX
 N0k1ozZyKLZg7bocBBOq+aljgzJ47rxgRLuYApQd66a6L6PVQEPCP/Il/6YD6yaFAoqiB
 xyQupPcnAi8NiiNI0Yyv4137CSFtfAvmhVn5vz3J0Tn2leg2agDouo6JPeVf9GXHXWTGJ
 FnhTyX4xbDvQNiQIi2YuKh4js8nxZLfm8/V1kXusOc3We+2lYDU86m1g9FoJxrhefTA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=Pb43xekp; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=Pb43xekp
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA8C74009D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BC45153B;
 Wed, 14 Oct 2026 11:23:09 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57FD83F871;
 Wed, 14 Oct 2026 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002192; bh=UBGA88JNxeF0dHF8/zzVxuJc9TD0JmvJWfVJ+cOOus4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pb43xekpmtCYeZIl8xuBYGfDFh/1TK7teMCOQonjC/KKANlA4QsHlrLYQ5VjoH5kz
 bPdH/GbnOWf1iqWzdIt3+8KGuRgjJSJBYwx9nXGRNUYExl15jbcbcSoG65QRv2gWvy
 Ga0WVeMb0d6XaExfHnfYy8rjNzvI0sA+ssIEQFX4=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 01/22] efi_loader: add runtime memset helper
Date: Wed, 14 Oct 2026 19:22:41 +0100
Message-ID: <d274af5bfebae789ee0eac7e273b24efec9d95df.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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

Add efi_memset_runtime() for EFI runtime paths

This keeps buffer initialization in runtime-resident code after
ExitBootServices() and avoids relying on non-runtime helpers.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v2:

Simon:

- Fix the `efi_memset_runtime()` comment and kernel-doc style
- Drop `__efi_runtime` from the header prototype
- Align the definition signature with nearby helpers
- Cast the stored byte to `u8`
---
 include/efi_loader.h         |  3 +++
 lib/efi_loader/efi_runtime.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3a4d502631c..9dfea1fd7de 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1151,6 +1151,9 @@ void efi_memcpy_runtime(void *dest, const void *src, size_t n);
 /* runtime implementation of memcmp() */
 int efi_memcmp_runtime(const void *s1, const void *s2, size_t n);
 
+/* runtime implementation of memset() */
+void *efi_memset_runtime(void *dest, int c, size_t n);
+
 /* commonly used helper functions */
 u16 *efi_create_indexed_name(u16 *buffer, size_t buffer_size, const char *name,
 			     unsigned int index);
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 73d4097464c..c0182931c42 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -233,6 +233,26 @@ int __efi_runtime efi_memcmp_runtime(const void *s1, const void *s2, size_t n)
 	return 0;
 }
 
+/**
+ * efi_memset_runtime() - fill memory area
+ *
+ * At runtime memset() is not available.
+ *
+ * @dest:	destination buffer
+ * @c:		byte value used to fill destination buffer
+ * @n:		number of bytes to set
+ * Return:	pointer to destination buffer
+ */
+__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n)
+{
+	u8 *d = dest;
+
+	for (; n; --n)
+		*d++ = (u8)c;
+
+	return dest;
+}
+
 /**
  * efi_update_table_header_crc32() - Update crc32 in table header
  *
-- 
2.43.0

