Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6AB606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zFs/wIr+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=TESxsCoi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 241FA81010;
	Thu, 29 Oct 2026 05:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GUkIRt6zotGD; Thu, 29 Oct 2026 05:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1DFE68100B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250704;
	b=mFW1E3rIBd4TwAwToIJP/4qo9ze6epsK2eU8aJ/e4CeAsLG7Qm1CVmiQriiqFr77DLjt
	 aOiAfJJ8Pw6nuIOgD1haPW/qh4d6cGx7h0zbROAI3+ovYZXjdWhF3TEeIAUsVCFpOaBEg
	 Ous/C/qrKqzXWS1LDTmr1HQTV70ysmkOkSIVEmkvP9fRfRoeMl5om8mOT+SkwoSXSPHjA
	 3WZwbsqW1mVNn3TKRGxQ/4tHfv0rWykEViElpw9RXzxtF3tzPv4L4g4N/LvM4MrMDu8h5
	 PA9sBgbxyNM3YfsTqcYdww+oO9FBIHxCbgnyNojUooQvmVpNQ67s7c4yDXqcmASdmvA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250704;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=piI0ugvNqKgNm4ybzy+YiQ/8HeJNLEITPTUqXqGheEA=;
	b=J6Z3pCd+Ylg/h9z4Z0+1AYQjQKyWQfGF1A4+ZWzYhXT6BloNWpN5pYnIWrM4wWXj0AEo
	 jX4NWbfW5iDF0C/Etx6yJUibTf7kpFgk/NH4WfKebBT9uyNcfStFEkbTqyXpO+9UfVvQC
	 Nz6rR2atMoBU68JdBbMBSsBDyEgCFIUuUHbl7wjgl9fbk4taIr2AcW746mbGIrX/Fpd4P
	 om1bxJ1rh6XfoPUP09zrrbrpWyV6Lkaa5SmKztEgqJIuweNFUQvvfCZvTagcfPUgLPzZI
	 UnaJG8kFejLy34KucoKcyUTs4R4y44yXxxnidHWn+RY+INbJkAdwRFqCrPwyBHI2wHQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=TESxsCoi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250704;
	bh=piI0ugvNqKgNm4ybzy+YiQ/8HeJNLEITPTUqXqGheEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zFs/wIr+VGlArXxYQ8OCBhG5YjUgamWJNn7gUXy9LEAWTK435zaSfM9QjGR9wyFRD
	 M3ITaFJIFvREJ16FeytSov6UrV7DDD8EbnQ6lrB6fpI7auOixNmB4uLMMFl/PMnAWs
	 PBiRoFKRt0505vcMNqyjDfHT7Pm90N3G+6cWhD3Srr2Vb3WOiOeXg3DAGY3tnTkSD9
	 966Helip2YJq51iMZPhdUtDfKT0SlOr3SHTFKYDpjCWsWJ6MKC6Jkg5rB1Zd+Zs1pe
	 du9ZEFyaRmO1hFjBNwIz4dc982gNoKyVPyDootLrwl7/0gxySUeITdJJ9+Xo80oQez
	 MgEyvrYH+W1Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DFE68100B;
	Thu, 29 Oct 2026 05:11:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D83812FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDFBF80F81
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qkvxx081vEbf for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:11:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD31180F7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250699;
 b=hm+/4K/VoU+Bgq6TeC26sBhAjsL54D7ubLxNlAk0QLgkIk10GXRBtQHCcegWQDbxneZW
 wrvqqA+LZ/8lWYGgIjq+8oAiCNZqGB0KX6Ia4AF2lKLj3zKW74nCZCFbsetrq5/n+i19e
 RMiuhUGeoxNjlgGY8T/GPdIJ1IkKKr29y4yBNmFaU7i37+wYI8+ibTKU8MIfwWw0sWsCK
 Fzp10i9n0kq1gzU2v5wUEoC4eZpZMlxICCAbnMhz45k93usV+fjZo9EYlQ1yNP9sM5ZIF
 ihuz7h8TnTJdzNP0aHXbPwdYN4gaWeWV9tTe/rFowhrnENs6qukYIvji2cstEx7EkJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250699;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=piI0ugvNqKgNm4ybzy+YiQ/8HeJNLEITPTUqXqGheEA=;
 b=LBj0CoQ1SZzr6o/1yEGmm18Y03ZlsfhadJT2GXZ9rnCT0fsxVpNuFsOykHyzPon5IVQq
 odz20lmpmO5UvERFFXpLFiHuMEf2nwyxVcFY4TGrHYJ40amasUqdA2oBbqvY5PWtgPlNG
 V9QFdg4Xkk1yS3BPgKxlCyLkfWDxLG7v5NvjruFbk388WnSik5HxQXnLR2IPi0Rme++TR
 RpM1IYR/oUx50rYwqItKYYHL0RNujPlDGUhNaC4xuorFdpgQGYLy/1xirVuHymwQ/GxX2
 XKw0TKdMUGfCqLoGa0lv2ucOwF7hEi175lUnA/7Zlkvzr/AAGdwK7BcMZ2CmgQ92k1g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=TESxsCoi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=TESxsCoi
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD31180F7A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:11:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250691; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CTuea0eiwgdbYnSX8KwfrhalwvPaIJXy/F9KzX0zA4KWhXKE1I3ERkaxSgH+4XZLIteMbUQxDhl576OwkGd0MBw8WkevNT+Wkakdr5KaYMVyGG6l/Eo0uCkbN1Pz921oj7h+iNhWqv35ETvfMzh4y/tQnlbz8BUzsO2IhqUbLAM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250691;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=piI0ugvNqKgNm4ybzy+YiQ/8HeJNLEITPTUqXqGheEA=; 
 b=jrulVG1iiUOlp9Xqlp0/+yKPmZ7GN5enFzoO/5Sev82lf+513EKu3OC0gjxM/ZU6iGxCt6aWPEjyDq5PXoVFAe9wwi9CD0cxcsI42kR78B8Horr/fg3p9+uoldpL3/FI7Eic45wgIGJz3pu+d2wYtsf4fc3VqBg4VUX5M1P1qs0=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=TESxsCoild7Kd2G6pGULQPvyFz4I55rIIumAzcHCjJZQAJNUjpuoTCIhljpkzq4gAEzSQTfGglMq3v9w0f2k4HWwLPfEOV8w51MnB83/hnEiOlIGIHEzAuWHTsF72SNwmHid1IFIVRIEJz1uXCAWt+3AE7tdW+2S9aVyhIGFtQY=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=piI0ugvNqKgNm4ybzy+YiQ/8HeJNLEITPTUqXqGheEA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250689749742.6957929836843;
 Wed, 28 Oct 2026 22:11:29 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 18/20] doc: arch: Add documentation for LoongArch
Date: Thu, 29 Oct 2026 05:07:35 +0000
Message-ID: <20261029050738.1107663-19-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a brief introduction to LoongArch architecture, some notes on the
implementation, and the toolchain supporting status.

Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed from v5
- Improve the documentation

New patch, no changes since v3
---
 doc/arch/index.rst     |  1 +
 doc/arch/loongarch.rst | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 doc/arch/loongarch.rst

diff --git a/doc/arch/index.rst b/doc/arch/index.rst
index 60c93b3b6640..10903b806d2c 100644
--- a/doc/arch/index.rst
+++ b/doc/arch/index.rst
@@ -9,6 +9,7 @@ Architecture-specific doc
    arc
    arm64
    arm64.ffa
+   loongarch
    m68k
    mips
    nios2
diff --git a/doc/arch/loongarch.rst b/doc/arch/loongarch.rst
new file mode 100644
index 000000000000..93eed74fe666
--- /dev/null
+++ b/doc/arch/loongarch.rst
@@ -0,0 +1,31 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright (C) 2026 Yao Zi <me@ziyao.cc>
+
+LoongArch
+=========
+
+LoongArch is a RISC ISA developed by Loongson Technology. It currently defines
+three variants: a reduced 32-bit version (LA32R), a standard 32-bit version
+(LA32S) for embedded devices, and a 64-bit version (LA64).
+
+Notes
+-----
+
+1. Currently U-Boot only runs on LA64 variant with the highest privilege level
+   (PLV0).
+
+2. CONFIG_ARCH_LA64=y selects support for 64-bit LoongArch variant.
+
+3. U-Boot requires hardware-maintained coherency of different levels of
+   instruction and data caches. It determines the cache topology by reading
+   CPUCFG registers; L2 and L3 caches, if present, must be unified or
+   instruction-only. This is true for all commercial LA64 hardware. Refer to
+   arch/loongarch/lib/cache.c for further description.
+
+Toolchain
+---------
+
+LoongArch is supported in upstream binutils, gcc, and LLVM. GCC 12.1 started to
+support LA64, and GCC 16 started to support LA32.
+`kernel.org <https://mirrors.edge.kernel.org/pub/tools/crosstool/>`_ provides
+pre-built toolchain for both 32-bit and 64-bit LoongArch.
-- 
2.56.0

