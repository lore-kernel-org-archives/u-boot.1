Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054D3C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2989980EC9;
	Tue, 21 Jul 2026 15:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBh3BtHagFhr; Tue, 21 Jul 2026 15:55:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D580680EB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784649342;
	bh=WrYXTJtR+sWU4ZyC4gBOLFjkWOncdyTeGJzZPaL2QEw=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=b8TJZAhAa4yuL5dv5Ifhetygrb7lZyz3uyGfyRoA/zwe+YZTWTZWTqTd83bZVMvcM
	 EcNFnB4sATRhKu0Vdhr8CCu4Rp51numlqxestkml9d7ut7YdBW4uiZGiEev3ieqpnw
	 GXyFbtf1YJOQsoOKRmou31orKq3KyAYM+vONHKl0HbduEZq0PtPlEuQ3ycUkFiGX5k
	 9tKpSzcVy+Wg4t8LxBmkNREF0AS2W0AEyyQn7mBeZOF7oqHYsKHVESf2kVtzklUv0C
	 L2lQhVT5bilb9Ck0TsaHFDYbXpelLQolINqZmPNfh4j3ZPO07wNAmvXd3hV6S+j3Ic
	 5EFNkurh9dfPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D580680EB6;
	Tue, 21 Jul 2026 15:55:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76CF81331
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 650266084A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8geuZW7uzkDE for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:28:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A00196062C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A00196062C
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A00196062C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:43 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9E3B73FC0C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:43 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccafc5e82cso107735315ad.3
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647302; x=1785252102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WrYXTJtR+sWU4ZyC4gBOLFjkWOncdyTeGJzZPaL2QEw=;
 b=C8dURFug5ybLnUqZ8j8986knlVsm5Sjl5+SXuSd41meKnVa2N8oux77pojM1go0YL9
 /fV2yWFbZ9K9ls6jLLll8R47f5F347bq704EwTQ/mc0isTn3WT59vnaJotktIks3GwRn
 wOfjNvhtQu4AlPmKB849HhTb7oMkY/7Qr0OZLZCZFCS39aaInhkVsh6x0mGQBU6v/255
 6CWBvgNmFp0xjLSMiJanzDMQag6P0PUdatEDQY1389DBzX7F4idvBJZaOSMz5aGSQ1ex
 3fZJXlbYoz41mz/5nScMtS+ukSDvNNgxsXsrl2CE2giq9Dkc1sYw6DZwRA080ygyM7JL
 RBxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXgldGkGL2FZgjMpUk8zl4/LMWxRczxr8Xvr4RwKoAH8D/JzbgShtstBvO6+dvwE/oUkKRxEs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzX9GSkTVSTkwL3BZXNIjvlImkRM8uFtLgD3zpbQ6M6m8UKnRvy
 K5x6j6IPTPsxDpzkyMzGNOETigXhTK1dpE3Pgf5KhQQX4AMZmGu5skDQS1QcX72YHKFlnEjSJrf
 suwG7i7zkvYP0aD8pcbKASA+c/vOjXgHmGGJKeoTX/8m1PiMgSTljGN2GlVOKEbzfRcbrIZ/lp7
 Kx9Wx7+Hk1uw==
X-Gm-Gg: AR+sD10D8Xp+wzj6BDdD8KpvYHGMl9a6CG6e1XZXmXub1BspEaTY69OBMxB0bhJh9Pv
 lOPHqGJy+u2miKBSotxDpMuUSoXs9dsm//4ROWdy3zMyrTWN5R3Tv21y7IcSJORpaCcP/Mzn8j4
 n/tOesAOmNqW2/k+H55z97n96rk/v9bmON98AW/28bVYl8t6Oicmo6Q/wV1mwh1heAwaEp6oJaS
 XYkhP/k6CLmI2HfcN4BzcrPV11lecCWx6YE8g0vo0K+CWYptO+16KSY7y+zvrtSpAIzStw9394w
 F/84Jyd6bXdcv5UoNoSMmhZeEaLxHjtFrjmbPxZCuSSIWbYuhP8v7AO/zc+7qkIgpLAA81WakjI
 TIPzHbLqKO9WgqUKzWg7p2Kvxs5Oxuaj+HEjvh3o4W3jSU7QhYyEC8I6vGs8wdT+i0a0=
X-Received: by 2002:a17:902:ebc8:b0:2ca:f21a:a6c5 with SMTP id
 d9443c01a7336-2cf34850b53mr218761335ad.1.1784647302054; 
 Tue, 21 Jul 2026 08:21:42 -0700 (PDT)
X-Received: by 2002:a17:902:ebc8:b0:2ca:f21a:a6c5 with SMTP id
 d9443c01a7336-2cf34850b53mr218760765ad.1.1784647301511; 
 Tue, 21 Jul 2026 08:21:41 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf347119dfsm77733775ad.56.2026.07.21.08.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:21:40 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 7/7] binman: fit: document how ELF load addresses are
 determined
Date: Tue, 21 Jul 2026 15:21:06 +0000
Message-ID: <20260721152110.283998-8-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721152110.283998-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 15:55:37 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1784647303;
 bh=WrYXTJtR+sWU4ZyC4gBOLFjkWOncdyTeGJzZPaL2QEw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=XKhbLuh3kheQymKwiSdoRvs/ThjwwNtgWLgzz1QOxVrS2rCzvCcNGOQQ+YEu4aLmI
 dlqlseIzZ3aOkVcLGNh6PX8MLv5Wcm2bJzhESM2p407Xpeiy56KUBl6+jAajKzREx2
 m7JpB+NRbslhRKISShJdyAd5PKqUea1ACcv4DVjxaNpYFddSV599qSlyFrLurdiewS
 q9FEKrJ63lgSRQ0f3j/uDYAlKnFE+OFp+LYEn5puBu7ABA/BZ/WLOPR0fW9bd48MUW
 a9/uHSGu2L+p4IU+6rivTjxwTaat7H6lH+/3lHxn+5xzfWRQ/A+Ab/kMnqqOeDKgAI
 xzLYD2aef1IAbtqN2y3xdUSKd1nbjVKQ9DP4QeJJpSWG/lkzWBXItlutSLbFWXd4T9
 yhU87DN2XSQ5zZ87VCua3bJvI8tYqHnqqsh4weUQGwmLCqIOH2oKreNSjB7iXCIy5/
 AI+ZjrUf1n+hB2Giupa49rxbAHw7DdfmkPT4ESnmr9zSPwKQQVQYxQ/aQvypOrUJVV
 PHiT1uaLAFJcu8yuzxdp5IjDkZLBHbRKqYeiRuEtaWmzROTNw2t5CvR7TdjDFEdqYa
 EBLGLxV9pvfmzAbsZ7h/5di397Et42by67ehQPHy2P+o3elKhckLDo+uPvtlcRH4ij
 YMtRH4BXtGmvQQjwNHFFyqqY=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=XKhbLuh3
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The fit,load property confuses users because the load address is
taken from the ELF file rather than being specified in the binman
node. Document how to inspect an ELF file to find out where its
segments will be loaded, using readelf, the linker script or objdump,
and point at the elf_sections and elf_sections_tee test linker
scripts as examples of two components placed to avoid overlapping
memory.

Compared to the previously applied version of this change, the text
now lives in the fit etype docstring. The entry documentation is
produced from docstrings by the binman_docs Sphinx extension at
documentation build time, so no pre-generated file needs updating.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/binman/etype/fit.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index f28b1e6b4cb..68999481d2b 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -317,6 +317,24 @@ class Entry_fit(Entry_section):
             Generates a `load = <...>` property with the load address of the
             segment
 
+            Note: The load address comes from the ELF file's program headers.
+            To determine where an ELF file will be loaded, you can:
+
+            1. Use readelf to examine the program headers:
+               ``readelf -l your_elf_file.elf``
+               Look for the LOAD segments and their VirtAddr (Virtual Address)
+
+            2. Check the linker script (.lds file) used to build the ELF:
+               Look for the `. = <address>;` statements which set the location
+               counter and determine load addresses for different sections
+
+            3. Use objdump to see section addresses:
+               ``objdump -h your_elf_file.elf``
+
+            For example, in binman tests, elf_sections.lds sets the ATF load
+            address to 0x00000010, while elf_sections_tee.lds sets the TEE
+            load address to 0x00100010 to avoid memory overlap conflicts.
+
         fit,entry
             Generates a `entry = <...>` property with the entry address of the
             ELF. This is only produced for the first entry
-- 
2.43.0

