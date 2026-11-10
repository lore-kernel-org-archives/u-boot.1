Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738A606A7D7
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KOeMSOTk;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=bGEXJV+a
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 345FF812C1;
	Tue, 10 Nov 2026 13:06:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 39-dvCK_OIBm; Tue, 10 Nov 2026 13:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 01F7D81332
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315971;
	b=p23nzljNXZqp3rRSQqk1Klw5sQ58y/r00hYyACcyd/oa8NzWIUmNfOH6zFdbnL3BjfFS
	 eUz60A/8pbngrPAZGFhXVtMy0dhH59BnenNmbS1vB0L2VOeqdMnd06tB0bAQFZDlXgCl8
	 KjG9k5u1+SsPnC434TEXHpKszsJxROVy0N6zmX9YLBbD6b3nwv+mYurJrso0LHYa5Q1cl
	 rSrsxkmEPCikjnXznDmnsjYV1p2KktWrOyEVDo7E/kWFQdaiqw0mbQOxAQLIZV72n5xU7
	 jhXg/MUAKdXOvrcTeyYpjQN8r5x7Nvfh3szcPWSJUuCseUNCJUCn479jIldpra9H6Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315971;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z7Pk9jBqzy8HkyXnXLHLh/6bWYsAZkU+slswMBvvVVE=;
	b=U3t9rTMzLw/lcggtvAPOfl23oGASe6C4iLPPSd3jqrdj+ijFEXvYKIFJDlxP/dOCyKzy
	 t367Rnej9iEN6pG8JYhBkcri1Kfv8VjNDqcV6IBWgE/ysvqTTnBYeYufFNXTZyIcK85sS
	 5iMCM+AiuM9OJnC11PHj6XZMBKlfIp7TR+S5SbpmBiG6BzL9ZOcU+5PYq/mRKYWwAYYhe
	 hph/b0pR/P8M7qQTHaGnwudIdvfJZQSrIPTCEoUVL+oVjD6+Noxe3Qh7Tf33DRpd8U6jw
	 4FnVXofqDQMXLKrLb3FGKv4a5wycrz3z0MBxZb3/3XLkcvQnORo8v0iRZ2sZRqCjfhQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315971;
	bh=Z7Pk9jBqzy8HkyXnXLHLh/6bWYsAZkU+slswMBvvVVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KOeMSOTkdTUxXGyHycBci9qCVi4A3cxu0Bk5x23JpvbxJDIP9R9DyRglLMOTZzQiv
	 1J4lMND+0fjWxxW4IUHeCVWmSxwQcVJ+hMNAfUoIgg7lE+PEgMxpCzemfoPfPo/xhJ
	 yLwqOycDw4KdoUNrx6HPYfUpwDw2EAVAP6yGVVPpnETLwFMbKURYIQPYZ249PPxC51
	 4D9v5sKh2S9z/IXSdZcyRNtsg8NCTB0nzCINqSeIUaXkDw1wLBfc4ROAsM/tnbC0mz
	 hRe+lMVUtpTB3aME+G+xT4BWlz1Z5tHy5UMb+KsJetYqp16nSOykEpFmKOwfzfj0a1
	 eLDfq5fhIJcbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01F7D81332;
	Tue, 10 Nov 2026 13:06:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 00C11CC4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA51840098
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52uGml_FDtGk for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 07:58:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E012B402EE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=bGEXJV+a
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E012B402EE
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:04 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 08F613F9C8
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794297483;
 bh=Z7Pk9jBqzy8HkyXnXLHLh/6bWYsAZkU+slswMBvvVVE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=bGEXJV+aefwLBZDoXc0fiSR0NX7H8plkYqCOxac8QwN6ndWH1FUey1O3IiK7OqX5O
 qUUeUQ7MunK1Bk8yRIX9a6qeb1SkgJVpaKMQFCUc0Jvhd4KdtwEvorqtzrh9uutqRq
 a3cZMsZnbrEllCzwODd/nEQmLYJicemiBVLnFyB33wabeGkeFhsd1Lqwd6NOyNScIb
 NHgw0x5gniGXTCI9kXe6qetZ6woheoWcO2g2QjfXjk/0sEnRXB9EbX4JBA8ZMmQMpq
 1W7UW8d4sUKZBtaXYG9TjCvdVmw4Q9Tn/56+EXa5cclFk7+UjtXskompGo7MERT/yI
 whHMXUWF7B7VH4vbycqIKyfQiQmVq/zukaukFLF7nNUmXorhdpqw63CBWWpwNksPHc
 /TS85NTXi8JglaZWIsv8jg7pPbqydjec7OmxrO3yZVx8mjUtoupxdkaGMV+t0OG8c8
 2WByIRdSmvk/NO3RbjuJ/Ok+XBP61Ti57lopVlmffu+4SYuoFcWoJGJ2Dj1dHeBO8e
 bzOSoP7S7cMIdFnpetlZ85am8mTTob4elIFd5sqfUWAQFQSdYBny+zEY0a1dSWtAE3
 ALS7n5CFUMK8UgmUsFg2itJZda09wIpDmqsP17awTZxyEjq6sXVfrgY3ms0PI7GHDv
 2IiCjUP7efmllIAqI8Jm1N50=
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36de26cb4b3so2325207eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 23:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794297481; x=1794902281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z7Pk9jBqzy8HkyXnXLHLh/6bWYsAZkU+slswMBvvVVE=;
 b=HBxn59mBiO5637hiQeQMek0Vh0wpOKFGVhOTykZmLXIClufg8yGwbY9qAX688FekF0
 Q/Ffv5azx4wLMexMo899K9OlYgZ3xtNgKIBiUZHJuOA3K8cLAukX/iXHhAtiqZ6F0wMT
 Ikzm2OsMj8SHPCEJjpbaND5C2TYFhR6EeCotr9sJG1O5dfNoF+BYYfGtzZXU+pS2JH0z
 OSc2RNe/t3E0JMsMXsHEk5x2iRIpf2GZthCq5ECW6RY/1QZ7Lowhep59CZckvkseZbOc
 FcKMNcR3vvneRt04fS9l561MxTFcHPsABA9gvl6Qsien2+1bN1fDwcGHTVwxZBdEh/vl
 26DA==
X-Gm-Message-State: APuU4Z9nBz6AnwsNNzxa6SV4vTf93lYheMtyiiK2Q+aWs4QOIEeHeud2
 yIAivuVg7npc/zdgmCPXaZh1ve+iaACvyPHaKR39HMqgDziOhUhT70OlN+atA3pSYeaFtmZR9O0
 4uxU2pPr3i+f41n1Ve2vsK5g6glspruwtyjQgbZS20n4qOySZ+Yf+dd5nCFoq7LpP7CTkRWpD5x
 jEZrlE50AyoWqsOueraWUP
X-Gm-Gg: AYBFou1M0QLvu1p0P7lTSpimxEQzPkuiRVIXkE4LEO9iAIiK3rkfYFFYZCkicx7lbtP
 CkC3FOq/BVUyXLGCEfVVSZHNFqXOcvti8TeBz0kIBLiu8IjYNWTU0/N9L2pberpwSL8MKPKyrK6
 dHGdAGzQsycGPgE4uGabEWKkQ1mkv2EupfPs/MKpJAufdealH2jw95vvnAclJwWhpvFQ5jHFl0F
 uADq11sogEn8RIF1qNbGXq9M0cxLg0EwoSL7eGx8fgSItgp0dnk3tn6ArkOOh5m4+SqKW+HdKZJ
 2DEdbgNseYUC+v6sVqurD8lbIaDviySusn1NAH9JGbVbhNpohy4CrhrWVeg4sWVrhVwx+blMUGP
 qb7DfyKfnTU2pQSIAPQJYmBy8Wzt6sQXQ3LyrUkavHA8jDDu0Cu0PDoc6Z6uXL8r4czA2dGvvbl
 7M4ff0XluzRijOr7n4CMSiHCSO
X-Received: by 2002:a05:693c:8843:b0:370:d6e4:e8aa with SMTP id
 5a478bee46e88-37520d02832mr2369781eec.41.1794297481052; 
 Mon, 09 Nov 2026 23:58:01 -0800 (PST)
X-Received: by 2002:a05:693c:8843:b0:370:d6e4:e8aa with SMTP id
 5a478bee46e88-37520d02832mr2369736eec.41.1794297480265; 
 Mon, 09 Nov 2026 23:58:00 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe3261csm4212914eec.4.2026.11.09.23.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 23:57:59 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 5/6] cmd: pstore: find the user space zone where Linux 6.2
 puts it
Date: Tue, 10 Nov 2026 07:56:41 +0000
Message-ID: <20261110075707.1409824-6-aristo.chen@canonical.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pstore display and pstore save expect the zones in the order dump,
console, ftrace, user space (pmsg), which Linux used up to 6.1. Since
commit 6daf4e82bd54 ("pstore/ram: Move pmsg init earlier") in 6.2,
Linux puts the user space zone before the ftrace zone. With such a
kernel, U-Boot shows and saves the user space record as the ftrace one
and does not find the ftrace record, and when the two zones differ in
size, it reads both at the wrong place.

Use the new order, but keep the old one for older kernels. Linux writes
the signature of each zone when it starts: plain 'DBGC' for the user
space zone and 'DBGC' XORed with LINUX_VERSION_CODE for the ftrace
zone. So take the old order when the zone after the console zone has
an ftrace signature, that is, 'DBGC' XORed with a plausible kernel
version. The order only differs when both zones are used, and a zone
too small for a record is left alone.

Older kernels with per-CPU ftrace zones (RAMOOPS_FLAG_FTRACE_PER_CPU,
which the device tree fixup of U-Boot does not set) can leave a few
bytes unused at the end of the ftrace memory, which moves the user
space zone. As before, that case is not handled.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 cmd/pstore.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/cmd/pstore.c b/cmd/pstore.c
index 947be2b9327..51d9ed93c38 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -162,6 +162,26 @@ static u32 pstore_round_size(u32 size)
 	return size ? rounddown_pow_of_two(size) : 0;
 }
 
+/**
+ * pstore_has_ftrace_sig() - Check whether a zone has an FTrace signature
+ * @addr: Address of the zone
+ *
+ * Linux writes the signature of each zone when it starts: 'DBGC' XORed with
+ * LINUX_VERSION_CODE in the FTrace zones, the plain 'DBGC' in the others.
+ *
+ * Return: true if the zone at @addr has the signature of an FTrace zone
+ */
+static bool pstore_has_ftrace_sig(phys_addr_t addr)
+{
+	u32 *sig = map_sysmem(addr, sizeof(*sig));
+	u32 version = *sig ^ PERSISTENT_RAM_SIG;
+
+	unmap_sysmem(sig);
+
+	/* LINUX_VERSION_CODE of 3.0 to 255.255.255 */
+	return version >= 0x30000 && version <= 0xffffff;
+}
+
 /**
  * pstore_get_zones() - Find the zones where Linux keeps the records
  * @zones: Returns the zones
@@ -169,7 +189,8 @@ static u32 pstore_round_size(u32 size)
  * Lay out the zones like ramoops_probe() in Linux: round each size down to a
  * power of two, split the memory left for the dump records into as many
  * zones as there is room for records, each rounded down to an even size, then
- * put the console, FTrace and user space zones after them.
+ * put the console, user space and FTrace zones after them. Linux 6.1 and older
+ * put the FTrace zone before the user space one, which its signature shows.
  *
  * Return: size of the largest zone, which a buffer needs for any record
  */
@@ -193,8 +214,16 @@ static u32 pstore_get_zones(struct pstore_zones *zones)
 			  (phys_size_t)count * zones->dump.size;
 
 	zones->console.addr = zones->dump_end;
-	zones->ftrace.addr = zones->console.addr + zones->console.size;
-	zones->pmsg.addr = zones->ftrace.addr + zones->ftrace.size;
+	zones->pmsg.addr = zones->console.addr + zones->console.size;
+	zones->ftrace.addr = zones->pmsg.addr + zones->pmsg.size;
+
+	/* A zone too small for a record holds none, so its place is moot */
+	if (zones->pmsg.size > sizeof(struct persistent_ram_buffer) &&
+	    zones->ftrace.size > sizeof(struct persistent_ram_buffer) &&
+	    pstore_has_ftrace_sig(zones->pmsg.addr)) {
+		zones->ftrace.addr = zones->pmsg.addr;
+		zones->pmsg.addr += zones->ftrace.size;
+	}
 
 	return max(max(zones->dump.size, zones->console.size),
 		   max(zones->ftrace.size, zones->pmsg.size));
-- 
2.43.0

