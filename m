Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28713606A7D6
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nAJCbC+h;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ESCLDQZy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED0EE81288;
	Tue, 10 Nov 2026 13:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id clqnTsd1fLDj; Tue, 10 Nov 2026 13:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 95D118130A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315967;
	b=l4yltkNwuNrHD/da70f89Ebv3RT6ezmft1JUz5r8LRVzy/eYGPHEgJImh4EbzSsWyQ+W
	 usrbC6r/FlIJURhkiNW52PrRFkK1Xgr9YUGRRAooc1h9J8H0+0jFNFukavFcGMQavN15b
	 Nh1VUi8f+YR58kbb9IJtAhRUEITa0HQxogzJ17cHTNZZQrOtKGxxkNSl8mdId6ehdy4VJ
	 P9Zm5BLCm3rbCt5ynQF+btSCcbXXuHFxg6AUuZ+kL4jy/6Hn/2VwGeAOZy3MBs4otceeC
	 NCgffH+8gVs7N3TepbD+CgKG7Rr7PIrUZJv8A+Dva8BmNBP8vGAYbfGQWAhN7adVNqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315967;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zqID6/SFrAw5Qa/5WxziAcu9yF4+pMxu26MUCERrq5I=;
	b=K6VX03q3Cpcwe++n1BijUZWRojdq/IuaGM6OvsSrCN8A66i4esMwXw8hy38FGJbMYlFb
	 U+Zbxx90rAsVC9jsnVASXW5GrMNjjRWLwY0I63q5kdR/LCRd7wlmbPuJnRAV7n0tlkT6c
	 1h/a33cUMIHK0jH4rr21u+czA/Vhdk+Fi9noSAuRJzWQpH3LyajKm4vta1Vdz4fj1d66M
	 +0LLawvFdk8CtuCBkXN2druRK15woO7ZLWYwG6P5SqI5ZTzES+qlWBaHFtiY2WhSkyi2D
	 Sgwci9RWawg1eaBd6XoafGvY07M6gT7vtS+GvuyiySvcfwIaa0yhhc0nML2jpIc2bRQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ESCLDQZy;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315967;
	bh=zqID6/SFrAw5Qa/5WxziAcu9yF4+pMxu26MUCERrq5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nAJCbC+h1qrOPWcFyt1DI7zIfrX4id3KoN9rwtdYnVcbA4fxZrXQmELoPACAPq1ue
	 LHC4Noz1gmmr3v5U3DM6NBbbMpAcGsRcG5aJ2JNmIDwQ8NZ/YXl7nKx8mK8UhKCLHz
	 0jkySY0BskL6oIbZqztlyVXVHBL9AigeMP+MaPrd4o+ZZnuZhl9C99r9bZ5EldsqfL
	 whvIIEgQYT/iYtwmaSrZlmEXH3zQbdi/89cWbI3UVoAoFKI9GcptOGXnD0g4UKbIIs
	 9ntFyEdn/FigTpCQEL6U0DnMp36dBmB+TNB94o7nIS/6DYeFSI0sve+LFkhIz+ztEI
	 S01VNaDu/NcgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95D118130A;
	Tue, 10 Nov 2026 13:06:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 673271FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 58CEF80DFD
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IQBqufSLNdWE for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 07:58:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E5D4C80E12
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=ESCLDQZy
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E5D4C80E12
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:00 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 168C13F9D6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794297479;
 bh=zqID6/SFrAw5Qa/5WxziAcu9yF4+pMxu26MUCERrq5I=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ESCLDQZyWOpqgTp6QlluhrRtcDsfXkzDaD3clBktlC8snI72kVvot7s26I9FQhe+y
 BZiOba90ZzsjZrpjwe1jYxFe1HUM3deo00a1uXNLAT3xSL4bjNNEcn4633YFd/Z4tu
 epQ0mWo4oVFXCXw7Xhfqr9sl7IgL0Oe7sbHi+IGVL6aT/EkK25C0y45aFy6dTvzQHp
 1y0OzvnzXLU7mIbu+GRNfy9tWarjdegVLW+m7xapIO6y52PLLdpWwltc4wqLF/XCuM
 xodYr/22/0iKnMWDDYH3d+sBeJSfUafhtbuaL278zAvBjQutvcgl1DSPSpyQt5QOhG
 SaBkglBDRIOZO7h9AelszaKn/UiWE5fC+Jw/IKv62+5iMvEzp5mipA4MGB5gXik2nl
 SWODqwT37MVDISF38I3DMhy2Q0npfJN0AygIK4vuQ8tl7VFPr1S7Z2DDlt/qEoAyEK
 34RKLWC8E+9cfn6AlBr4PvScNFcNM+6fr4nQK0T6jeQR13dnALp6VNJJX9x7+EvXxV
 6JI/zT5+EMsIyUsBtXHIJ36dbiepD6sqwwjzWYCYO+Zb3tNsGCLEXuiubJ4gvvsPLU
 upADS6nxitB6PZMfPZ2kbfP45CWYbNsvo1CDiSUgCQxhUcRaciB7j3d5ULnBqUrd+Z
 PbqmnNLL6TvDoY89JsyVioSA=
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so4087354eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 23:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794297477; x=1794902277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zqID6/SFrAw5Qa/5WxziAcu9yF4+pMxu26MUCERrq5I=;
 b=p4bj277VfyX0OTiYLIYujBLGEsWRv1MOaml9Pejc1hU/kZZQOgtCCXSvz+3z8js/wW
 i+exaj25cymLuYjg/0LVF/l67izzE9EfptaQawEvd2InOwQJoInrgp3Z2JbU8tJzOeHV
 /kGtvlYw1Cx6CNENDQ9icPO9vqX9F40bXgSNCRtGA3wq9IbkHCh6bdlNpAPtSwmcm0VM
 1aWCY2t5D98mpB5sZK69yjplnJfz9V3QXnfnV8mj2XF+Fgu+3J7yJQaC9gZtvDLO1mWm
 vOZvBi0eXFIg/QWqOY3e/8Ov1LPROMAg7YZuP2fIdsN342/YmFZOYFnTcJB6fkmMuddP
 ESew==
X-Gm-Message-State: APuU4Z8U/19oYPQfDd9QMPWZ3WBUmSPt2KSCeCT96BitIUjzHslEgeMv
 ITj1BRWmEdFEJ+EvAjZ7kNKJbi59Z/qv1o4ynev2WhgWKoWgX+qnGSaWw2xf7wM6a0r9F57wwi9
 EaD2THyzLrKsi1f5txXvkAlUv63coTKNL+jUCoLO0G8nifCUJeG4NILNg4bsuUontGKo3JJgw0V
 e0lCsuepQOYnIcTf7bJR3P
X-Gm-Gg: AYBFou2iDquwMu9y6ROyaValrzxM1uKNCUi3sD2zJUzPqpn7U0RmaC3HhCiilL2As7U
 Xtgni6gdZBzlwbOTg8nN+ynBriH+lXs3Y4q1NqiWO+si4MTxw0uR0cdBM8T/Ec+MU/BA2Fxx9Sn
 z6MtQN9P4YcYFpTiuSsUt5EJJt+l990TWrGk+UVwhVVs46aMaxwSkmOCRrOiHbimnWKWYEAmtrj
 RWdD93NRxQvjbaRcE9zCriOaGw02+M7RropPjIKzSFPdeOFxwkZQXH/Kwhw7LXDdmcjcC5mTCnD
 06uqjTIp96m7XFfyE2GPdPAy4w8v7e/u1tXIYkrjVGqFN68GtyddubTavyYnfsn9fFdilsBcTEy
 yrP+JffrceADadKVFaaPxcXSAzKN7tzT1I+u45kK2LCZzpQu7clIaihKDqH4bEkQK4twwv5OnTV
 yNuuSa6wFTsVTrIm3FPjlXnjOg
X-Received: by 2002:a05:693c:42d5:b0:36f:5861:69a2 with SMTP id
 5a478bee46e88-3751c830051mr2796920eec.3.1794297476953; 
 Mon, 09 Nov 2026 23:57:56 -0800 (PST)
X-Received: by 2002:a05:693c:42d5:b0:36f:5861:69a2 with SMTP id
 5a478bee46e88-3751c830051mr2796889eec.3.1794297476331; 
 Mon, 09 Nov 2026 23:57:56 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe3261csm4212914eec.4.2026.11.09.23.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 23:57:55 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
Subject: [PATCH v1 3/6] cmd: pstore: lay out the zones as Linux does
Date: Tue, 10 Nov 2026 07:56:39 +0000
Message-ID: <20261110075707.1409824-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110075707.1409824-1-aristo.chen@canonical.com>
References: <20261110075707.1409824-1-aristo.chen@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pstore display and pstore save find the records where Linux puts them
only when all sizes are powers of two and the dump records fill the
memory left for them, as with the default sizes:

- ramoops_probe() in Linux rounds each size down to a power of two.
  U-Boot used the sizes as given. pstore set also checked their sum
  without rounding, in 32 bits, so it rejected some sizes that Linux
  accepts and accepted some whose sum wraps around.
- Linux splits the memory left for the dump records into as many zones
  as there is room for records, so a zone is larger than the record
  size when memory is left over. U-Boot used zones of the record size,
  and its two commands did not even agree on where the console zone
  starts: pstore display took the end of the memory for the dump
  records, pstore save the end of its last dump zone, which can lie
  past the end of the PStore memory.
- With a record size of 0, Linux makes no dump zones. Both commands
  looped forever.

Compute the zones once, as Linux does, use them in both commands, and
check the rounded sizes in pstore set, in 64 bits. As a dump zone can
now be larger than the record size, size the buffer from the zones on
each call instead of keeping a size from the first call. Also, pstore
display dump <n> now reads nothing when there is no dump zone n,
instead of reading past the dump zones.

This is the layout of Linux 4.10 and later, with the dump zone size
rounded down to an even number as in Linux 6.8 and the stable kernels
that got the same change. The other kernels only differ when the dump
records do not fill the memory left for them: Linux 4.9 and older use
zones of the record size, and Linux 4.10 to 6.7 without that change do
not round an odd zone size down.

Fixes: 9744d1a54784 ("cmd: Add command to display or save Linux PStore dumps")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 cmd/pstore.c | 176 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 114 insertions(+), 62 deletions(-)

diff --git a/cmd/pstore.c b/cmd/pstore.c
index e864dc80df7..947be2b9327 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -5,6 +5,7 @@
 
 #include <config.h>
 #include <command.h>
+#include <div64.h>
 #include <fdtdec.h>
 #include <fs.h>
 #include <log.h>
@@ -12,6 +13,7 @@
 #include <memalign.h>
 #include <part.h>
 #include <fdt_support.h>
+#include <linux/log2.h>
 
 struct persistent_ram_buffer {
 	u32    sig;
@@ -20,6 +22,34 @@ struct persistent_ram_buffer {
 	u8     data[0];
 };
 
+/**
+ * struct pstore_zone - Zone of the PStore memory
+ * @addr: Address of the zone
+ * @size: Size of the zone, record header included
+ */
+struct pstore_zone {
+	phys_addr_t addr;
+	u32 size;
+};
+
+/**
+ * struct pstore_zones - Zones of the PStore memory
+ * @dump: First dump zone, the others follow it with the same size
+ * @dump_count: Number of dump zones
+ * @dump_end: End of the dump zones
+ * @console: Console zone
+ * @ftrace: FTrace zone
+ * @pmsg: User space zone
+ */
+struct pstore_zones {
+	struct pstore_zone dump;
+	u32 dump_count;
+	phys_addr_t dump_end;
+	struct pstore_zone console;
+	struct pstore_zone ftrace;
+	struct pstore_zone pmsg;
+};
+
 #define PERSISTENT_RAM_SIG (0x43474244) /* DBGC */
 #define RAMOOPS_KERNMSG_HDR "===="
 
@@ -36,7 +66,6 @@ static unsigned int pstore_console_size = CONFIG_CMD_PSTORE_CONSOLE_SIZE;
 static unsigned int pstore_ftrace_size = CONFIG_CMD_PSTORE_FTRACE_SIZE;
 static unsigned int pstore_pmsg_size = CONFIG_CMD_PSTORE_PMSG_SIZE;
 static unsigned int pstore_ecc_size = CONFIG_CMD_PSTORE_ECC_SIZE;
-static unsigned int buffer_size;
 
  /**
   * pstore_read_kmsg_hdr() - Check kernel header and get compression flag if
@@ -123,24 +152,52 @@ static u32 pstore_get_buffer(u32 sig, phys_addr_t buffer, u32 size, char *dest)
 }
 
 /**
- * pstore_init_buffer_size() - Init buffer size to largest record size
+ * pstore_round_size() - Round a zone size down to a power of two
+ * @size: Zone size, can be 0
  *
- * Records, console, FTrace and user logs can use different buffer sizes.
- * This function allows to retrieve the biggest one.
+ * Return: @size rounded down to a power of two, or 0 if @size is 0
  */
-static void pstore_init_buffer_size(void)
+static u32 pstore_round_size(u32 size)
 {
-	if (pstore_record_size > buffer_size)
-		buffer_size = pstore_record_size;
-
-	if (pstore_console_size > buffer_size)
-		buffer_size = pstore_console_size;
-
-	if (pstore_ftrace_size > buffer_size)
-		buffer_size = pstore_ftrace_size;
+	return size ? rounddown_pow_of_two(size) : 0;
+}
 
-	if (pstore_pmsg_size > buffer_size)
-		buffer_size = pstore_pmsg_size;
+/**
+ * pstore_get_zones() - Find the zones where Linux keeps the records
+ * @zones: Returns the zones
+ *
+ * Lay out the zones like ramoops_probe() in Linux: round each size down to a
+ * power of two, split the memory left for the dump records into as many
+ * zones as there is room for records, each rounded down to an even size, then
+ * put the console, FTrace and user space zones after them.
+ *
+ * Return: size of the largest zone, which a buffer needs for any record
+ */
+static u32 pstore_get_zones(struct pstore_zones *zones)
+{
+	u32 record_size = pstore_round_size(pstore_record_size);
+	phys_size_t dump_size;
+	u32 count;
+
+	zones->console.size = pstore_round_size(pstore_console_size);
+	zones->ftrace.size = pstore_round_size(pstore_ftrace_size);
+	zones->pmsg.size = pstore_round_size(pstore_pmsg_size);
+
+	dump_size = pstore_length - zones->console.size - zones->ftrace.size -
+		    zones->pmsg.size;
+	count = record_size ? lldiv(dump_size, record_size) : 0;
+	zones->dump_count = count;
+	zones->dump.addr = pstore_addr;
+	zones->dump.size = count ? ALIGN_DOWN(lldiv(dump_size, count), 2) : 0;
+	zones->dump_end = zones->dump.addr +
+			  (phys_size_t)count * zones->dump.size;
+
+	zones->console.addr = zones->dump_end;
+	zones->ftrace.addr = zones->console.addr + zones->console.size;
+	zones->pmsg.addr = zones->ftrace.addr + zones->ftrace.size;
+
+	return max(max(zones->dump.size, zones->console.size),
+		   max(zones->ftrace.size, zones->pmsg.size));
 }
 
 /**
@@ -196,11 +253,11 @@ static int pstore_set(struct cmd_tbl *cmdtp, int flag,  int argc,
 	if (argc > 7)
 		pstore_ecc_size = hextoul(argv[7], NULL);
 
-	/* Size the buffer again for the new record sizes on next use */
-	buffer_size = 0;
-
-	if (pstore_length < (pstore_record_size + pstore_console_size
-			     + pstore_ftrace_size + pstore_pmsg_size)) {
+	/* As Linux, use the sizes rounded down to powers of two */
+	if (pstore_length < (u64)pstore_round_size(pstore_record_size) +
+			    pstore_round_size(pstore_console_size) +
+			    pstore_round_size(pstore_ftrace_size) +
+			    pstore_round_size(pstore_pmsg_size)) {
 		printf("pstore <len> should be larger than the sum of all records sizes\n");
 		pstore_length = 0;
 	}
@@ -250,6 +307,7 @@ static int pstore_display(struct cmd_tbl *cmdtp, int flag,  int argc,
 			  char * const argv[])
 {
 	int type = PSTORE_TYPE_ALL;
+	struct pstore_zones zones;
 	phys_addr_t ptr;
 	char *buffer;
 	u32 size;
@@ -274,31 +332,33 @@ static int pstore_display(struct cmd_tbl *cmdtp, int flag,  int argc,
 		return CMD_RET_USAGE;
 	}
 
-	if (buffer_size == 0)
-		pstore_init_buffer_size();
-
-	buffer = malloc_cache_aligned(buffer_size);
+	size = pstore_get_zones(&zones);
+	buffer = malloc_cache_aligned(size);
 	if (!buffer) {
-		printf("Cannot allocate %u bytes for the records\n",
-		       buffer_size);
+		printf("Cannot allocate %u bytes for the records\n", size);
 		return CMD_RET_FAILURE;
 	}
 
 	if (type == PSTORE_TYPE_DMESG || type == PSTORE_TYPE_ALL) {
-		ptr = pstore_addr;
-		phys_addr_t ptr_end = ptr + pstore_length - pstore_pmsg_size
-				- pstore_ftrace_size - pstore_console_size;
+		ptr = zones.dump.addr;
+		phys_addr_t ptr_end = zones.dump_end;
 
 		if (argc > 2) {
-			ptr += dectoul(argv[2], NULL)
-				* pstore_record_size;
-			ptr_end = ptr + pstore_record_size;
+			ulong index = dectoul(argv[2], NULL);
+
+			/* Only read that dump zone, if there is one */
+			if (index < zones.dump_count) {
+				ptr += (phys_size_t)index * zones.dump.size;
+				ptr_end = ptr + zones.dump.size;
+			} else {
+				ptr_end = ptr;
+			}
 		}
 
 		while (ptr < ptr_end) {
 			size = pstore_get_buffer(PERSISTENT_RAM_SIG, ptr,
-						 pstore_record_size, buffer);
-			ptr += pstore_record_size;
+						 zones.dump.size, buffer);
+			ptr += zones.dump.size;
 
 			if (size == 0)
 				continue;
@@ -321,30 +381,26 @@ static int pstore_display(struct cmd_tbl *cmdtp, int flag,  int argc,
 	}
 
 	if (type == PSTORE_TYPE_CONSOLE || type == PSTORE_TYPE_ALL) {
-		ptr = pstore_addr + pstore_length - pstore_pmsg_size
-			- pstore_ftrace_size - pstore_console_size;
-		size = pstore_get_buffer(PERSISTENT_RAM_SIG, ptr,
-					 pstore_console_size, buffer);
+		size = pstore_get_buffer(PERSISTENT_RAM_SIG, zones.console.addr,
+					 zones.console.size, buffer);
 		if (size != 0)
 			pstore_print_buffer("Console", buffer, size);
 	}
 
 	if (type == PSTORE_TYPE_FTRACE || type == PSTORE_TYPE_ALL) {
-		ptr = pstore_addr + pstore_length - pstore_pmsg_size
-		- pstore_ftrace_size;
 		/* The FTrace record(s) uses LINUX_VERSION_CODE ^ 'DBGC'
 		 * signature, pass 0 to pstore_get_buffer to prevent
 		 * checking it
 		 */
-		size = pstore_get_buffer(0, ptr, pstore_ftrace_size, buffer);
+		size = pstore_get_buffer(0, zones.ftrace.addr,
+					 zones.ftrace.size, buffer);
 		if (size != 0)
 			pstore_print_buffer("FTrace", buffer, size);
 	}
 
 	if (type == PSTORE_TYPE_PMSG || type == PSTORE_TYPE_ALL) {
-		ptr = pstore_addr + pstore_length - pstore_pmsg_size;
-		size = pstore_get_buffer(PERSISTENT_RAM_SIG, ptr,
-					 pstore_pmsg_size, buffer);
+		size = pstore_get_buffer(PERSISTENT_RAM_SIG, zones.pmsg.addr,
+					 zones.pmsg.size, buffer);
 		if (size != 0)
 			pstore_print_buffer("User", buffer, size);
 	}
@@ -372,6 +428,7 @@ static int pstore_display(struct cmd_tbl *cmdtp, int flag,  int argc,
 static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 		       char * const argv[])
 {
+	struct pstore_zones zones;
 	phys_addr_t ptr, ptr_end;
 	char *buffer;
 	char *save_argv[6];
@@ -390,13 +447,10 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 		return CMD_RET_USAGE;
 	}
 
-	if (buffer_size == 0)
-		pstore_init_buffer_size();
-
-	buffer = malloc_cache_aligned(buffer_size);
+	size = pstore_get_zones(&zones);
+	buffer = malloc_cache_aligned(size);
 	if (!buffer) {
-		printf("Cannot allocate %u bytes for the records\n",
-		       buffer_size);
+		printf("Cannot allocate %u bytes for the records\n", size);
 		return CMD_RET_FAILURE;
 	}
 	sprintf(addr, "0x%p", buffer);
@@ -409,14 +463,13 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 	save_argv[5] = length;
 
 	/* Save all Dump records */
-	ptr = pstore_addr;
-	ptr_end = ptr + pstore_length - pstore_pmsg_size - pstore_ftrace_size
-				- pstore_console_size;
+	ptr = zones.dump.addr;
+	ptr_end = zones.dump_end;
 	index = 0;
 	while (ptr < ptr_end) {
 		size = pstore_get_buffer(PERSISTENT_RAM_SIG, ptr,
-					 pstore_record_size, buffer);
-		ptr += pstore_record_size;
+					 zones.dump.size, buffer);
+		ptr += zones.dump.size;
 
 		if (size == 0)
 			continue;
@@ -438,30 +491,29 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 	sprintf(addr, "0x%08lx", (ulong)map_to_sysmem(buffer));
 
 	/* Save Console record */
-	size = pstore_get_buffer(PERSISTENT_RAM_SIG, ptr, pstore_console_size,
-				 buffer);
+	size = pstore_get_buffer(PERSISTENT_RAM_SIG, zones.console.addr,
+				 zones.console.size, buffer);
 	if (size != 0) {
 		sprintf(length, "0x%X", size);
 		snprintf(path, sizeof(path), "%s/console-ramoops-0", argv[3]);
 		do_save(cmdtp, flag, 6, save_argv, FS_TYPE_ANY);
 	}
-	ptr += pstore_console_size;
 
 	/* Save FTrace record(s)
 	 * The FTrace record(s) uses LINUX_VERSION_CODE ^ 'DBGC' signature,
 	 * pass 0 to pstore_get_buffer to prevent checking it
 	 */
-	size = pstore_get_buffer(0, ptr, pstore_ftrace_size, buffer);
+	size = pstore_get_buffer(0, zones.ftrace.addr, zones.ftrace.size,
+				 buffer);
 	if (size != 0) {
 		sprintf(length, "0x%X", size);
 		snprintf(path, sizeof(path), "%s/ftrace-ramoops-0", argv[3]);
 		do_save(cmdtp, flag, 6, save_argv, FS_TYPE_ANY);
 	}
-	ptr += pstore_ftrace_size;
 
 	/* Save Console record */
-	size = pstore_get_buffer(PERSISTENT_RAM_SIG, ptr, pstore_pmsg_size,
-				 buffer);
+	size = pstore_get_buffer(PERSISTENT_RAM_SIG, zones.pmsg.addr,
+				 zones.pmsg.size, buffer);
 	if (size != 0) {
 		sprintf(length, "0x%X", size);
 		snprintf(path, sizeof(path), "%s/pmsg-ramoops-0", argv[3]);
-- 
2.43.0

