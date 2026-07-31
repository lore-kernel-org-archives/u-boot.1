Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8468C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 00:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F3DF606EF;
	Fri, 31 Jul 2026 00:15:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVTz0nvVO8D7; Fri, 31 Jul 2026 00:15:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98F1F607BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785456957;
	bh=00x3c5SOppaBtOvU9QdjvmL1y6WkK6FoSXWlwth5Rhk=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=frgNJ0RNINLteXastovX55aoabcUMq7qATfuIEj/niDWxYTQPuMal9kODXiMOuMkO
	 OldWPodItOVIBMiOKAaE/6VB/ve/LfT60FuudX5mC1UUj93ogHWrZETQjni17WdIEy
	 oP0Km/jaez0N0OvOfNyFByhA/M/gr+uwOoDypaS864r9/kuc0AY4vw87fa5fDXJfSf
	 EZ+YM72EypNddo4SPLZ7IIhjUaUbQ50O+XP7/NoE0EupKzWHl8ur49kYBDgRu1GJMe
	 dTHzRsAMVHhLJMjfGZ+FSl4npe+8qRWHrHebkogDV8qbDynNOKIMxEG/ueQcnkHWrf
	 8W9p8EuAJYiYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98F1F607BC;
	Fri, 31 Jul 2026 00:15:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 86E0A27C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6659660674
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mgHCsxZ8btRc for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 00:15:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5C38860648
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C38860648
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C38860648
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:15:03 +0000 (UTC)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B1C773FBF9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:15:01 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-848568a6f62so924142b3a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456900; x=1786061700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=00x3c5SOppaBtOvU9QdjvmL1y6WkK6FoSXWlwth5Rhk=;
 b=gLvrJkgwHHlzu2t9vL5R+3KdkXIR41jrbqg39r0r0W5kTG+aXVPWcrlH1UtB4btZGf
 UpDIfq2E3LWZj++RagpJoGXMm/LkF+3jw1DGKqmTFl3HDYIg7q0U00dhb7AHSxkeBIms
 7GgGQ+j+WEBHiaWhfzo+JZmvhPWDsLckSOxb/Xu6+qAeAkwaYAl2yXLO0fjVI/gO35c4
 BbMoImHo6fdr8PAaWSnZS6yHczXQqXROyWhpP/FNo6BTnzdKtF3xwdCEJLbTXCkB9Kaf
 Hdg4YNccthblZRsBAnVqeBWp0ferXkxyohzVDdGOqIgOhaIPC1BNFHCGk51FPEpQA38R
 6B3w==
X-Gm-Message-State: AOJu0YzyVK6dRpIGsJzYR/lOCXv5Ib4NoHCZNunWKXAI4glC1gWCRrlV
 vUtinLKM82jY2NHZ0GS6NbisckK22fa83OqGOL85H+z2uQrNFcBma1J2L/BjzxtSOLF2fhXIRNg
 18vz1sN0byMiuTduAdlQMKkh18G/aJH4q88kknBSsCZsVAMXlok62zcznIz94bl4ICfcl40clPZ
 rSZnmyNLBAHw==
X-Gm-Gg: AR+sD13KWlESaw09EjTbo8jFlzKWa1n22XFgakp5OmYfiTLhxWD1AjQRypN8gxhQrA+
 DijwHtr+X23UIkzz7tA0mJ7wSSTJMDp0pcQMMk07DZK/tyAGYw5Nv0NIg1TDUWk8bE5+A0Aimqi
 Uf62C46mZEjP6FeuDz1WYl8ZBSRZCB6kXuaNkeBoJtrqsHo87cufIAGE5IvNPB8wpmtMI3GrgwM
 OBaobWjarNdrOKfsYUjrtZ2fTp/hEYr39AqGbwVPMCQ6vJpR9w8s+VjM34hkpJxARk8B+LRyPYV
 5iHk7hCDlw6/n7VLRG9lseTS1v3Ho7Vj5sF4o4uU4WhAtjNvbBg86x5NtJwIMChL5gkCXlKuc0u
 zzLw922sKdHE7fTih0gtniBDx5QVSmtmbS2dOaI1Sk9NTPUDWIH+pZu3P59ThjBEelk6luw==
X-Received: by 2002:aa7:9067:0:b0:848:4d1a:9554 with SMTP id
 d2e1a72fcca58-84ebc3dd004mr3992110b3a.38.1785456900210; 
 Thu, 30 Jul 2026 17:15:00 -0700 (PDT)
X-Received: by 2002:aa7:9067:0:b0:848:4d1a:9554 with SMTP id
 d2e1a72fcca58-84ebc3dd004mr3992095b3a.38.1785456899824; 
 Thu, 30 Jul 2026 17:14:59 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea02f8461sm3695718b3a.28.2026.07.30.17.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:14:59 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org,
 nm@ti.com, bb@ti.com, n-francis@ti.com, d-gole@ti.com, e@freeshell.de,
 jonas@kwiboo.se, Aristo Chen <aristo.chen@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v4 7/7] binman: fit: document how ELF load addresses are
 determined
Date: Fri, 31 Jul 2026 00:13:41 +0000
Message-ID: <20260731001347.35624-8-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731001347.35624-1-aristo.chen@canonical.com>
References: <20260731001347.35624-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 00:15:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785456901;
 bh=00x3c5SOppaBtOvU9QdjvmL1y6WkK6FoSXWlwth5Rhk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=MLRgau1BllC73xHqYfjXWNUUHPBkyRLlIjUM6M9p2ShXn3opiF+8KijrPoZ91zfiH
 wRRf7DHTCYiN8DVN80UnMsKiMRKZ/ENv10RqVJjdeQbi/rXlKRjjSpaiZ+Hh6czCF/
 Bai0vBYOV1YIi+IUoHd4Cawol3QdlI8nfgUp53S2+qgjfPsYYLfRbd+Txus7p+rtTM
 sHfyzskOgyyr27umuMVAAOmYCVdT/iEzIXxyRoOZlPZ2t6TznmZur0V3/ZOaV5KKLK
 HO2TFP3OztPSHkQKPjFLLa37MkodgVIgnVC2OZ5y+jcVPcYxxl5/9ROPA/Ncg5hGnK
 q6N5vMllXcK7wqMySwYsDxeIycX6qf1F6PMN8uPQYUDmNMy7OJltJ6SML6bdHw9l+x
 c5BfZN+cpn+wKb6cXJoGIdUVN1s1ZtI7VPeZssU6nyl5rmlwp/TgxQ0hfm+kcaph6P
 P8JLjphkDUYWNDP+LwTkdLQj/ht44+K5MmUDA+QeChZw7GBKpOtPr/Fzcx1vQXXIaJ
 0YrKMYxeu2gzqd0uh8sFZUMoApz840YNUnoAKEZkw35G203nAKn21wU+8EFGdeNQGo
 mrAUUyNbOS+9K5xLkT7sBEvWcV0MiEmlWJl3GtcXwjq7Jjn1j6kqs2xNlg/TfQ+Ddf
 HgNHHB1zut82RWIMsQv0IAMg=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=MLRgau1B
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
memory. Also note that the mkimage load address overlap check works
on packaged data sizes and therefore assumes uncompressed images.

Compared to the previously applied version of this change, the text
now lives in the fit etype docstring. The entry documentation is
produced from docstrings by the binman_docs Sphinx extension at
documentation build time, so no pre-generated file needs updating.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/binman/etype/fit.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 32caa03a7e1..4657ed1fd76 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -319,6 +319,32 @@ class Entry_fit(Entry_section):
             Generates a `load = <...>` property with the load address of the
             segment
 
+            Note: The load address comes from the ELF file's program headers.
+            To determine where an ELF file will be loaded, you can:
+
+            1. Use readelf to examine the program headers:
+
+               ``readelf -l your_elf_file.elf``
+
+               Look for the LOAD segments and their VirtAddr (Virtual Address)
+
+            2. Check the linker script (.lds file) used to build the ELF:
+               look for the `. = <address>;` statements which set the location
+               counter and determine load addresses for different sections
+
+            3. Use objdump to see section addresses:
+
+               ``objdump -h your_elf_file.elf``
+
+            For example, in binman tests, elf_sections.lds sets the ATF load
+            address to 0x00000010, while elf_sections_tee.lds sets the TEE
+            load address to 0x00100010 to avoid memory overlap conflicts.
+
+            Note that the mkimage load address overlap check compares the
+            packaged data size of each image, so it assumes uncompressed
+            images: a compressed image occupies more memory after
+            decompression than the check accounts for.
+
         fit,entry
             Generates a `entry = <...>` property with the entry address of the
             ELF. This is only produced for the first entry
-- 
2.43.0

