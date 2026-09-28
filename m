Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5017CC9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 162F880EBF;
	Mon, 28 Sep 2026 13:42:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F06bF96z5avH; Mon, 28 Sep 2026 13:42:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1C23280DB5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602947;
	b=TKQaubmK5PmOlbXUAiK4n/oET3JEGmjo7yC0Wymf+Y1Ft+axb0GkKEeSeSK7H9Ffvfym
	 1CD+GW5W4eTjXnfGPlv3nQUeO4h5Zh/Cn30dm+R8LaRCCa1h9vNwKSfJZ69n5ocVlTnj5
	 n5OKIsC9NGZZ0Y8iVHrmN9sLvXn8bdG1ltgl7/Us4ZbwL1yCiCX50ZalT5SA2mkIy5MF8
	 YH4EtZHtL8/kEkxrdR+wMwKH89M2eeXN+55UaedhE7CfwmvNsckWAtjkS14iCkjh2Rmng
	 G7m89KaaYhEFw1f4v/cGWJOfncG81jl5nGFOnoyLit84Prl91fbnriMLZBOfEfGQBiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602947;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SikZQvjPQipcAdbzVFBfjuDCN43yUKUcltIl2jBfDZ0=;
	b=TG32rg52KWp6hnSbJ8o7izOH5dAds1YNKF0bMU/nlVFLGVLxTkvO/Y+MbH0wvGvtRHKC
	 LFkCan2nhHutYGXEK244r1iaCHOc/5H/TVQV2Pj4JQ7aRA9Fs4WSd+Ou2Ui06T/1sNkhy
	 VEljQL1SkDnPl61mhm4yCJGrN0rvR73gxSOyXeYv0JwH7xoZkHUILjIJhlsOtluwh1fRE
	 dpVZj2t+qy1bVa7d20btFIdjQ68EuizXVyelJwAatfA2WUTcNOtnHuwW3bhZCakGOJ62L
	 qyGvoimcbxTzd77c/buZcHx9UGCcFDxXRp4q1VNzh+9ILVRMcky6iaVaOjtA3du0tcw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602947;
	bh=SikZQvjPQipcAdbzVFBfjuDCN43yUKUcltIl2jBfDZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XfuY0BgjMpJlakpAZ2K7vJpR/tdwxhNeXD4ii10aLAmEw8THqT5DFqqRCxrLWrbtt
	 Mtr5Xokn6sGzZQrY7RsGGZjG1TJVqN5HXCPsAQXkDMRkWdNaVAFjj+5NXtL2XiDbFd
	 ysiEtK+mD0yHQGy37gquv+81p4UglOSm/bF9IU483LBpJM06exjDFTSxAhBehV5vFI
	 GmVvCRgbMUy5EZoS8rJRbYdQvyVlwceDk/EFE+gujSwB7+FtKK/S6Ry4HlTt2fcEPl
	 edFjR2LiGltchuJNUJSRvysY4i8t8hqhkp2Qvbr8/W5VValxFwNd1cc2xMmn+tIgmo
	 BT6cKg8lojkDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C23280DB5;
	Mon, 28 Sep 2026 13:42:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 08D7772
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3AC3405C5
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YlacFqx-MNbw for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:05:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F0B6B405DA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593510;
 b=PiaH4qC6XvhOTtZ9+XZKcC/iQ2noXA3ae0e+o+EevI++whJAVKVxqj7AkfbFtE/tzjbZ
 4V+UK/OnPdE4nZeOf9RFP3zYYdZoLMHk0AF/Bbcg7b0Ubp993AeuLAG4LJdDnfBvsfi9T
 VDlcHuybYFqGrb7My8FXSTOg/075SQxziKgoZywcxiwhm4x0KL4p+xW5+S80bfVHB6vYV
 b/cavPw7OFTbGhAD/6HuPPkDg8s3W4h9NCBRwm40guIjyfgCysi1jObEXpVzR5dORRhSv
 7aSyOKCunidyCmOrCci6ni5iidxIkWnI27Xbsg3sGJxYa6uSXbCr8mEPK5JmB8dG7fQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593510;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=SikZQvjPQipcAdbzVFBfjuDCN43yUKUcltIl2jBfDZ0=;
 b=PVJUBwkBc/uKmLHVRqHWQ0OcCrcAsuwF+cRW6nhVlzVK+THwJ/lJCPq8l14Cy9Q+OOdD
 R9h17cXTxHJPfSoMC9YIeqUffrqVTnnzbAv8cv7uNnfBbKFnWcRgQyvWmZsYTkprqXP8k
 dfQANajhWyGI9fEHnB3jJRdLrVcFEPnOe91eiw8JvuNbk9yZsctVCNLB+JOC4CH6ly2lA
 sx7vnjRLDGS2YKpsl+GDahh3/HGNuG2h8Pa7PjrRPhuf5MZ4JoIhd8/z+2aYw1ZiVm6/x
 wqhqpEPr90NLxZyWfJNgBUD7XM4kII2nJOwQKDWJsfoTNRxMAKJ97a/5B+j9uNdLcwA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RvpRaAeT; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RvpRaAeT
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F0B6B405DA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:09 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso27201755e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593507; x=1791198307;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SikZQvjPQipcAdbzVFBfjuDCN43yUKUcltIl2jBfDZ0=;
 b=RvpRaAeTPM+Y4/5YzTzEWjpzo8Syf7dKeJk833BlzK30aSrffnfYr3OaE9KBJ6BX6u
 T/vc+sU7FPVavQwpioCGcjiY6DiJK9ldSJimzwrYrx+UWLvcodiXP1JEnY9VE0JjwZH0
 Jp80kjlhoO0glEZBRGXquOE2h/6ifj6z53Rl50qe3XVp3b1a76RNeDD6mAMOI6j7B42z
 to6yTyzj4Dh4VtIFi6N31Mv0v1+FYEkAk4qctcw0CUetsVNwDPG6L59sQK9MHrPCxy/q
 1fs8a3kKJbCl9330srSwFHLnaqaYM8kmbKSb6f15fCcN+v/oMYRGtBJKmY5ZnzAuQg+C
 KVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593507; x=1791198307;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SikZQvjPQipcAdbzVFBfjuDCN43yUKUcltIl2jBfDZ0=;
 b=A1GEpVNGHlJqj3O3EQjNRVjxKW0+kM0hpKpisEGym4ObZ7vhFZDGQm5eHmfnS3vEhx
 m/XMDqkVRz4wmFqMl/h1QX3c9NEGV+0T2duen6XtgQbXxM9L/EQHZgBye8GBRQhEjrBV
 zXmqqq5VXC66XZMFYDSt/v4YM9+CZ9mw9TOtdsM4ZhenNdNZH55GbG2qLV3JFnh7aYuI
 8gnHPd+VHVtR8tAOWPdI7/uVWXCHklp5aNInGTRrPysnKWmG6VIS2Lhqh6bhT2kXqs7J
 pIWjK+pvaNACA44HrnvdtMG7N5naf1ovH8+DS8tnzYCx9ykHTY00pz1P7OCbjLxA8LxB
 utzg==
X-Gm-Message-State: AFuF++k+YziZG4OwG1y8BrS4vM9EqyJx8v0oKEDQaGUsYE/GaGE/z4LS
 teIcYJOMtxBxoD1uWQcUAe+3VFyvY2+1X0/DNE6vWBVamtCjV4vPA6x9mlHdRmQVAeg=
X-Gm-Gg: AYBFou31KLRLXTI990A2lh9k9dPxbSvm4HO0FPoGmN0uZxgKYI4HDh8oN9R20vBSV7u
 yeCKn0YVF6g7yZhyj449dIx4QPnHqSkPwopGkIY2r5z22SQbfQ0q31UtD3lsuHEFofP8gGngjsz
 A9Em9sApeonhLa8AIZQocg5DxCLWbgF9T5mS0/1epDBZm7Q1XgrtJX5tVamSAthdj33+vtuvZVA
 +gTL3zhUsZ9k1UPND3/rNbFxf37Qc6Tpk+SMTUOntm4xuR1GgWtfaYV0BAoWPK0ECHfruowxRge
 JF2kIz8DZtKXMy+wLVjLsQq+syK1sYc/PlkUR3fxZQOETR6fBIYpIZ8Acn1HNvWlIfe/HSZpMv2
 eG6a8o+FBv0ERJ+50RrFEymxhxsu2GYXOJI/0aQJpAiA42OQtoS5/NOXwxFCsd53+8k6tgtwBOh
 ju89XOmyAGzhvdWzORxfxMM4pMN1IflU+14lQTlYAh1sioLlTIXSgh5CDxyqmoFKyTP9TZgJEfH
 p4R/Z24iLecdSN+4LB22OqfznW0XaN9gP0aBMWg8v6DMtirNSCtzEId7yoSpX2Ix0ZRk9UD7WkK
 xlWR9yVQmFrjBy1tDK9byNvK6XRNnW77VxmI6wo13Q9sm14smOY=
X-Received: by 2002:a05:600c:198f:b0:49f:bd3c:bc23 with SMTP id
 5b1f17b1804b1-49fe6707f90mr227610475e9.30.1790593507363; 
 Mon, 28 Sep 2026 04:05:07 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.05.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:05:06 -0700 (PDT)
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
Subject: [PATCH next 06/13] powerpc: mpc85xx: Discard LTO keep-syms sections
Date: Mon, 28 Sep 2026 13:04:27 +0200
Message-ID: <20260928110434.70686-7-pepe.schlehofer@gmail.com>
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

With LTO, keep-syms-lto.o puts a pointer to every linker list entry
into .discard.addressable, only so that LTO does not drop the entries.
On mpc85xx the section still ends up in the image: -mrelocatable gives
each pointer a .fixup entry, and the linker scripts keep all .fixup
input, which keeps the section alive.

Discard .discard* sections, as their name says. The .fixup entries of
keep-syms-lto.o point into the discarded section, so leave them out of
the fixup table and discard them as well. ld would otherwise keep them
as zero words, which the relocation loop in start.S treats as
addresses to fix up; with them, turris_1x_nor with LTO hung after the
DRAM line.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Marek Behún <kabel@kernel.org>
---
 arch/powerpc/cpu/mpc85xx/u-boot-spl.lds | 11 ++++++++++-
 arch/powerpc/cpu/mpc85xx/u-boot.lds     | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/cpu/mpc85xx/u-boot-spl.lds b/arch/powerpc/cpu/mpc85xx/u-boot-spl.lds
index d918b4395bf..dd4d18bc24b 100644
--- a/arch/powerpc/cpu/mpc85xx/u-boot-spl.lds
+++ b/arch/powerpc/cpu/mpc85xx/u-boot-spl.lds
@@ -35,7 +35,7 @@ SECTIONS
 		KEEP(*(.got2))
 		KEEP(*(.got))
 		_FIXUP_TABLE_ = .;
-		KEEP(*(.fixup))
+		KEEP(*(EXCLUDE_FILE(*keep-syms-lto.o) .fixup))
 	}
 	__got2_entries = ((_GLOBAL_OFFSET_TABLE_ - _GOT2_TABLE_) >> 2) - 1;
 	__fixup_entries = (. - _FIXUP_TABLE_) >> 2;
@@ -63,6 +63,15 @@ SECTIONS
 	__init_end = .;
 	_end = .;
 
+	/*
+	 * .discard.addressable of keep-syms-lto.o only keeps the linker lists
+	 * alive during an LTO link. Drop it, and its fixups with it.
+	 */
+	/DISCARD/ : {
+		*(.discard*)
+		*keep-syms-lto.o(.fixup)
+	}
+
 #if CONFIG_IS_ENABLED(SYS_MPC85XX_NO_RESETVEC)
 #if defined(CONFIG_SDCARD) && !defined(CFG_SYS_MMC_U_BOOT_OFFS)
 	mmc_u_boot_offs = .;
diff --git a/arch/powerpc/cpu/mpc85xx/u-boot.lds b/arch/powerpc/cpu/mpc85xx/u-boot.lds
index bedd2d47472..4bb9b4ecfb2 100644
--- a/arch/powerpc/cpu/mpc85xx/u-boot.lds
+++ b/arch/powerpc/cpu/mpc85xx/u-boot.lds
@@ -49,7 +49,7 @@ SECTIONS
     KEEP(*(.got2))
     KEEP(*(.got))
     _FIXUP_TABLE_ = .;
-    KEEP(*(.fixup))
+    KEEP(*(EXCLUDE_FILE(*keep-syms-lto.o) .fixup))
   }
   __got2_entries = ((_GLOBAL_OFFSET_TABLE_ - _GOT2_TABLE_) >> 2) - 1;
   __fixup_entries = (. - _FIXUP_TABLE_) >> 2;
@@ -107,6 +107,15 @@ SECTIONS
 #endif
 #endif
 
+  /*
+   * .discard.addressable of keep-syms-lto.o only keeps the linker lists
+   * alive during an LTO link. Drop it, and its fixups with it.
+   */
+  /DISCARD/ : {
+    *(.discard*)
+    *keep-syms-lto.o(.fixup)
+  }
+
   __bss_start = .;
   .bss (NOLOAD)       :
   {
-- 
2.54.0 (Apple Git-157)

