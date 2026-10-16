Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381FDCC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0203361168;
	Fri, 16 Oct 2026 13:24:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJdFswhjKi0B; Fri, 16 Oct 2026 13:24:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 07A1461106
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157049;
	b=iBz3Ey+EQwCevDedSUt8txJaES4XaFxONvg7NhbL4Y/nMRFW7pE7EaX6oteqDOnBdkAw
	 2c1UlN1Q7ADwvcFwVlHOqDwqj6u6LyRn7JYfwFwvq2qewfBImIzLpUlfxaxN3L0jonub8
	 5fPebYEl62qEK64HT02up+oN+8cDg0lG8nGHDSS+CdWqVpds6/jjLEI0NWx4PGNi6QsHO
	 t4JI5YSXHtvQq05tZpG1/WGlUaxhtO5QDaaV7LoSrqerd9wEvl61W7SSgom/Vbc+yhNmu
	 7sIxFsrmTayWBx5qRizkwK5PUiG8Acj8Z2YdKixtjWdObhz36DUSewvLpzRAu8y7HCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157049;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ClzbKaGmRGquw3jsXntfNglgB03NYLFGClP7Mq1kK3U=;
	b=JAU+YR9M0ozWR9wv+3VIj6iZoh9ljX2x2jjIq7H7TyBjhAzIMCKHL8jpNQNYyFe4hFOJ
	 nPpXA1SqpgBlHtaGPl5mXYHQyBOVURxp77j8mW1TIqmN3h7Q7w0gBq0Dt5JZznBHUtbw0
	 GB4Q6Tw1pmP+k3Oe5Ep6SkyFmiA6NVE7ZOq1q75T5KQsTW6hCZ7PomnS2JEvlVl/F+4PA
	 It8tQWLbAgWQlrPYoznatuochfSguUYyyACf2YZsbCveaZTd1LgD+/sYECBOcgj3VkEv4
	 eOPPiD37CyLbaBlCf4/fbjiD1XP7cWJUmNLMKwKEaCrt1SSYuZjV8iB3eTIELyfzILg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157049;
	bh=ClzbKaGmRGquw3jsXntfNglgB03NYLFGClP7Mq1kK3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BYn0gv8+FUKGfkJfu5qIaNIalZronz7H9rqGqYYkvVAnYkf9/yviE43pbeJVN0OhL
	 2cXYT2SS82XjRzUJfgACjIyh/uA3D6iHo63MXVmcwb8Cg8wwSCqfPhkV3sPgBBU62K
	 I16GpEm9TNYNmKRiNwQN6p+Jkt/UkX3T3szrZ/iKk+472n4DXEMZRgt5JI4kUskMNe
	 R77FNZv6G748O4iTYe85BHTF2onUEIXEAknr7Jk2Kd6mwNq0TB81DsUiYgss6vss9N
	 GilZBUOfrGLww3AXOKwXJpXzRIuvATZe1g/Lgjq/zzm31I9a+UNQ5zzo8YwJ4eJNLo
	 1qFbTucNV1Jrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07A1461106;
	Fri, 16 Oct 2026 13:24:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65617362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 574A340974
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4TYh0cw9JE9h for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:18:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A9EC4096F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792138686;
 b=jhpxFNmpztAawXGjz1a3qy93jYfAR0suuDa4Fx4lT7CDKAo5wfYweo/bVvymO+cPRe8X
 xakQ+Y3JCPD3PTt/wPnxCJTxPFZZrr/EQKWUHtCTgMk9Qtsh5O+Ui2/b/L3xubbhuK4bs
 cIotPS0NB9kQlT1s2oEa0mo+5kW3od60AFCFdfjiFv0iecx6lhNIzKPa4AwBuNvtNlcsL
 oyphI3ldtQERnyxw4oC2Gu/f1KqWsaqGlNNMdE4j3GxRgZkfSAvT5GOFjMxKuD9SLFqn8
 RgzjmaYPB13taXMDfZ+aUu60JgXQgqnUmME1q00s6tag9Trz4Vsa7Oip/dBLrDFVMLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792138686;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=ClzbKaGmRGquw3jsXntfNglgB03NYLFGClP7Mq1kK3U=;
 b=k55wyDWtlNh1Cj63CRptVD+GUcB0igPhAJUr8qCzuhEj9ycjw+iBavKS2SK9CziHkQEQ
 Fe+CTrmVI2SCCIfJ0lgIzEjqOI89rfzD9yNivLd8SXAOLR/BbzeyetwBIXK5R80CMMMyi
 UTmVqVpvLtM+23qr9pc8ct8NDsbpGVMqECiRUOmZpH5WkG+NbpenauXSe6aQvf07s8RhA
 oZtSdNdd1SwhFJWeJ7OeeG0zuSQ10MSU8l1Bn3Yz9MNfPGLuj6g7dYpc1mFyGtYyV4XsI
 gvXnHZEdL1ueIV1en9tVtR0ZzYNdKOD16WyhiQIXdsN/bjlVYmTfYzuhGcUH5EOb1Mw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=TXjZ+olc; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=TXjZ+olc
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A9EC4096F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:05 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D3D3540315
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792138683;
 bh=ClzbKaGmRGquw3jsXntfNglgB03NYLFGClP7Mq1kK3U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=TXjZ+olc4kDbfo3noMDhCQE42mpwoOw5l7PMZ9wmxZSUqiI/pveOAwj6x9ToqyGli
 HFAW7ipfDB+MF/3S7KZ+MSWxXAvJrBlXXw57k6N+E4Gekw1AmdjqKU+99HIY3JJbya
 0uYdCYgxB/QJAoJCtd2JyTWd0vUBQvVkxedA3+Sj4OkzRTmzZz2WZoJmEF/ZgR+nJD
 Sj6mhIqLKfiDfnGJSMey8gGtT/ueussCBE+kHP2+Qs06OpfkSdp3TDJDzF7GqDiMJq
 aE7ftfQrDzdqpOVWf6jLG8vf+jrEQbdFTxkhQO3ova/BgUYPnIYsoW2atNdtkdHKaF
 wgzPB+IixJ7wyXMpwaNDIolinMiFG8OAiuZ1COwl1fKw7dyunUl8aaKZxv6eb6RcRx
 KsoUmF1hEr8xQQEXWfnAfXwb2an/ctgs5tDHMemMOA1AbnSQCtGLHARgrBXg1oMiMc
 c2pZz2Aa9JNArSOpZhqeU+xwKG+gUO6hVF/vZJwpBpqziZ6hcsWxlULODZyz3TvnQT
 KZlD3mXywGfuD34xnciJDA6BUXEStjoYa/W19DMohob+m2l9V9UK4x67KfjjO6/w0A
 xBICJImUNFxM8+Egvzuq7upumS+4Y+u3KeJY20SmVSvHCiOgExIr2a+l3w/Q0QwDIZ
 1QNVezLedn4ENGZn9KyhjmFM=
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac450b74b0so4969781a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792138682; x=1792743482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ClzbKaGmRGquw3jsXntfNglgB03NYLFGClP7Mq1kK3U=;
 b=k7P8WIwfCrhQDwCqcP9xF2HP4BuZ8cg40uj15ERfp+vQ7QGqXwzDvIEaK9hJNg0ycF
 EogpfVepjgLtjgq9KBt+CaalzsDKQZsAybOP0DBb7Yeh4uhyeh4v3xcWWpOAZ2AlBk42
 57+JrDCEMKe/t7PDkZb/fZLZeZ1I7EOfLrWiTLJANfYYW9yHBwHG3jXsr4Cxmi87/ClW
 xKVQzyBbaZ4aGpFx8R6v42z7/TsP/fYbnpd3wqAtceb7WDUx8vZMAWMUPQEoK7HmDDPP
 fzIE1VURcAoMUZVO876eWJ/C+eaI4VN1U5doIcT24peW6mL58H/EIc2rL9j5xS1+Grz1
 hKHg==
X-Gm-Message-State: AFq9FYIt1iYqZUQv+uaQZ0k+tYWVeiSSBQP/6zeXQm0sDxVD3+b/cgTl
 xD66yDEMlCV5F6uw4KgnblbUFDZWxV+ktVQjjepbnKqdmkIsnqYe/hS/RWqHb9QPk65oVzKWwOa
 shen9ceYcZJrdT2JXlz3N4aek6pfkmlp82FSvMIogO5LzaD/tlmIRQxioy6RlmD6rkaFWyigxhE
 GXDqWgaRbxktG4rGdqZA==
X-Gm-Gg: AYBFou3jlzzFgs2TCTwGsNGh+URqxGsnN3cYxxu4+Cgk7j6cYY9vBn/J6HFNkJNr3TQ
 RpbZlarHLHQWK/a6ZK+DTmkbmYl0tOrMKZjqc7y5dsezbzEPNQ4oXSBLXXrJoNrSmRzWg8y73UX
 iRQWIsyA7JikTfy0Ucf5tHkRZz5Fsul5fvkXINK+WYEQ7QHARwMKJdBYS7vA3kSSDONqQe7ZKom
 o1eXRh+Zl0FdWnVus7KGd1r0W0MXhHncmBW3J4fJLf/OYz1B2gixHoe9rYBbcesn/wmpoMr3MZY
 S6+MwXkITnGRpqS9/kdpGm7nph00jMT3y5CtnLaSP/wfEY1UStTkkQ5wBENtDmKJhAAx4XqVaTX
 oHyZcGNcI67Uohs2yYeGjze5WMEiE3cpT5uJ/cI61004X2svysy2oVbotWJlIN/fuHQ==
X-Received: by 2002:a17:90b:3b4f:b0:3ac:7556:8ed9 with SMTP id
 98e67ed59e1d1-3ac7556a40amr6909490a91.10.1792138682153; 
 Fri, 16 Oct 2026 01:18:02 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4f:b0:3ac:7556:8ed9 with SMTP id
 98e67ed59e1d1-3ac7556a40amr6909468a91.10.1792138681655; 
 Fri, 16 Oct 2026 01:18:01 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9474b52fsm9149405a91.9.2026.10.16.01.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:18:00 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, anton@binarly.io,
 pranavkasthuri@gmail.com, Aristo Chen <aristo.chen@canonical.com>,
 James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 4/5] tools: mkimage: bound external data reads in
 fit_import_data()
Date: Fri, 16 Oct 2026 08:16:26 +0000
Message-ID: <20261016081719.814357-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016081719.814357-1-aristo.chen@canonical.com>
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261016081719.814357-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
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

fit_import_data() reads each image's external data from the mapped FIT
file at the offset and size the FIT itself declares, without checking
that the region lies inside the file. A data-offset or data-position
pointing past the end of the file, or a size reaching beyond it, makes
mkimage read outside the mapping, crashing on re-process or silently
importing unrelated memory as image data. An authored .its that
declares external data properties hits the same path, since dtc
produces no payload beyond the device tree.

Read the properties through fit_image_get_data_position(),
fit_image_get_data_offset() and fit_image_get_data_size(), which return
u32 since commit c4d81d062790 ("image-fit: Use unsigned types for
external data properties"), so a value of 0xffffffff is no longer
mistaken for a missing property. They fail for a property that is not
exactly one cell, and the import then skips the image as if the
property were missing, as it already did for a shorter one. Compute the
file offset in 64 bits and require the whole region to lie within the
mapped file before importing it, with an error naming the image and the
offending values. An empty region reads nothing, so it is not checked:
mkimage -E -p places one past the end of the file when every image is
empty, and such a FIT must still re-process.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2: no code changes, collected Reviewed-by

 tools/fit_image.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index b648e3e2514..f0f30e06bd9 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -1033,9 +1033,9 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 	     node >= 0;
 	     node = fdt_next_subnode(fdt, node)) {
 		const char *ext_data_prop = NULL;
-		void *data = NULL;
-		int buf_ptr;
-		int len;
+		uint64_t offset = 0;
+		u32 val;
+		u32 len;
 
 		/*
 		 * A source file must not combine image-data with external
@@ -1059,22 +1059,39 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 		 * FIT_DATA_OFFSET_PROP and FIT_DATA_POSITION_PROP are never both present,
 		 *  but if they are, prefer FIT_DATA_OFFSET_PROP as it was there first
 		 */
-		buf_ptr = fdtdec_get_int(fdt, node, FIT_DATA_POSITION_PROP, -1);
-		if (buf_ptr != -1) {
+		if (!fit_image_get_data_position(fdt, node, &val)) {
 			ext_data_prop = FIT_DATA_POSITION_PROP;
-			data = old_fdt + buf_ptr;
+			offset = val;
 		}
-		buf_ptr = fdtdec_get_int(fdt, node, FIT_DATA_OFFSET_PROP, -1);
-		if (buf_ptr != -1) {
+		if (!fit_image_get_data_offset(fdt, node, &val)) {
 			ext_data_prop = FIT_DATA_OFFSET_PROP;
-			data = old_fdt + data_base + buf_ptr;
+			offset = data_base + (uint64_t)val;
 		}
-		len = fdtdec_get_int(fdt, node, FIT_DATA_SIZE_PROP, -1);
-		if (!data || len == -1)
+		if (!ext_data_prop || fit_image_get_data_size(fdt, node, &len))
 			continue;
+
+		/*
+		 * The offset and size come from the FIT itself, so make
+		 * sure the region lies within the mapped file before
+		 * reading it. An empty region reads nothing and may lie
+		 * past the end, as mkimage -E -p places it there when every
+		 * image is empty.
+		 */
+		if (len && (offset > (uint64_t)sbuf.st_size ||
+			    len > sbuf.st_size - offset)) {
+			fprintf(stderr,
+				"Error: image '%s': external data at file offset 0x%llx size 0x%x is outside the FIT file (size 0x%llx)\n",
+				fdt_get_name(fdt, node, NULL),
+				(unsigned long long)offset, len,
+				(unsigned long long)sbuf.st_size);
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+
 		debug("Importing data size %x\n", len);
 
-		ret = fdt_setprop(fdt, node, FIT_DATA_PROP, data, len);
+		ret = fdt_setprop(fdt, node, FIT_DATA_PROP, old_fdt + offset,
+				  len);
 		if (ret) {
 			debug("%s: Failed to write property: %s\n", __func__,
 			      fdt_strerror(ret));
-- 
2.43.0

