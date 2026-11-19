Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F12D606A332
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WCoPfNb7;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWbYSuju
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CCA340ADF;
	Thu, 19 Nov 2026 13:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VzURxqqyZHKv; Thu, 19 Nov 2026 13:33:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ACDF340B28
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095219;
	b=DWw5zQiEcDNBpRTN/gyklNo1S+o1/0DmWhpGwMarLEScdHhnq1nzqabE8jvCQmta7G7L
	 DlZQrw/Uz2Ag0QjAyW9//dT3nK/ZJNJTMYtu9HU5jcc6/cSiYpdRoaoKnwgGN0hZ15yM6
	 peOd3C9loW/6yqSvG5wvYd6HjWXwePBGKNQuaVNiDKy7x0TiD3KsXPzmulh2ZJYHklX3Y
	 eUdMlNMoDU3/1rRl9sNJPSkl+Vbo76Nnp7WCh34SoKD/IzfsEcS0er2HRx+sCujj+dTuT
	 ibSmPNglbnE6rK3DLQiW1Ktt0KopwMhXffm3OxWCignvF1iUf5riO5kEU4jrDVjou8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095219;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=U+XyFTdlD31UVzA5BKcRAPLv6UsP0mplUQKt2MR36DU=;
	b=OYA00x277QsLE7RelCMKz86qha2ytlMMfldOXoBa1vMp3c7DjjxDszOtPBwIvn5L3Ngp
	 gKAP9O5P7/20zrbBs14EsbyTJ0vIY4NXHWCYpWMc7JOQa/Sh/FZpPp1hzPLo8sS58qWgO
	 SDZJpkj9sXojQVonsvgOd8hfAAwfYUtvKnI2ylHHo4fZf3sdk3za1RMx6ctBlnRFIOO1Q
	 BBe9YlUpIpt0K6BcDhPPYcR23RIzXels0CK2rsYIv2PZRLnt5yUR6WOVOjschjZFweHkE
	 knnt1jPOYH8WvG1Ptm5XOd0XpCAFC8hU4TiWo2AWEh2hY4exDXQ0JtUob7/bNHp59Mg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EWbYSuju;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095219;
	bh=U+XyFTdlD31UVzA5BKcRAPLv6UsP0mplUQKt2MR36DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WCoPfNb7R3OuCUeh1VytDXHcDwOKj9j0Xr1rx7oinXuwZOvS/OQbDEFuUUSsC0bmD
	 ilyejk0gFVXQ57QBBgt/dFn578/MoFBQi+OWqk9fpOX6/ABIBbAREW/ROeRIG21lJI
	 LPcP38zvxsWaPGcJVPzAcSCskFkKPlTAGvnb+WTCHCXDJh4EXl+80klBDvGUgE1wgw
	 oOu8POq94ChSChFq9yzASwMV3z4F9BlBfYOzy50HFmYYgjgobzIXVAkpHqRxYNt/e5
	 FuMDBoNFSjiaUirWrOufFnDj9yx3vCK2bDG1tqCvil1tawTsrxaMO+UrDSP5f80eNy
	 dqSdXTwat6bGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACDF340B28;
	Thu, 19 Nov 2026 13:33:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E2B2E4D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 075FA40AC6
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vj5mWyMbuOTm for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E0DC440B00
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=EWbYSuju
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0DC440B00
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:22 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so2053864f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095201; x=1795700001;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U+XyFTdlD31UVzA5BKcRAPLv6UsP0mplUQKt2MR36DU=;
 b=EWbYSuju03jqWRrUGdrgXeT98TRIxVP/svjUlNqr/TFp3oXSNrZkjvfxOs4R+KjwnR
 TDYBefn8yhnWsVH0tlb4bqbHBarKI0EZuAMzFQv6I1u2CnYpiGMx2d0T+AYR+LS/lVBW
 ip9bHgh2k9VDYKWkLX8j6OMKCX5s1foIKGe4hRvRUuIGU+hyC+mNuUTIuR8xYTHgtj8j
 Pip3NiE8WP+1RtyODTC3L8RN658zOz5wOXRzlkU+tJaaV6kLey/HHODlVsAzd7uxBsOu
 hPKk5lvx8naNzwtsXZCNV7bXlh4JGPJ1F14OfZ0ShAjdFZyFQ33m9aZGO7KhxKgHnTxe
 ltGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095201; x=1795700001;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U+XyFTdlD31UVzA5BKcRAPLv6UsP0mplUQKt2MR36DU=;
 b=AERNaAIh4Q7sesMiLSaVVlNt/zyDUBJj7GiMD1A79uAmVhxh9zmIHCMuAftLFEEEu+
 vrNajfTzMR5eu2jUht7yzKN/MJZXTJhJ6ZkIxWocJFej8ZH6U28o/ppdGN/p0TYf07S6
 awAkHRXnmcrWk6koT5vmX4vf46zRxSmcEvcNsPLgqE2JzpiBlf2LNG1fMmSoB1mCR0OC
 y2J6iFSLp4yYMvuiBkjsmWFUTMPbHE3BGRlD//3iMkgSAygMQT6DdhQZBSTZSDRBBwNv
 HQbjxbdmK5veNcdiP9K+Q9JuQ2fpiTxmteN1ycPqCSrzIMheDNS265g0QURd3R7v6H5H
 DZZA==
X-Gm-Message-State: APuU4Z8d6S79pZ84/xpMe/X6IgrpmswEmATuvEE9cGQgDE7ZXc/qUrPN
 tQ6CvbgrNToMRBtAQHqc+TpqrEaG3LS29nRiK5eiPRfnqs7dEiJ0uK0a3qyqwAsc
X-Gm-Gg: AZFdTZe7oYwHV/OjAAdNypag89oCml2+6TR6VCAOTquXhGE5gmdqwKztZyKz5dKnaEj
 Mx2T/0fp6kfrko8U/HQaUXmBNpcrJZuM82zDu5dL+oKquzMmb+hWZ1LBKCXp0P3p9s3n0b+VDqW
 NcsmpZs6og0Ub8ZoAIik02cNwppzEhv2nnkOw9SnJPk+JtcYNBFjY0k93VeQ4MB6llsnxBPZd/h
 oen3tGDoUwltUR3vigUkGKQp3ld6bQFXqV8wUV3iKbjJvtGJlDIHHPjXiE20RLzomUOoeMNA1EY
 JpFM24qaYCyOAMNUBxXbDaIAcMZXCsIfsaZwTRVO4EV7nXW3V69aXX1v7cQdVRBv3QQWdCE88rj
 sA+hcOqiD+YMARD9ZDJFsYB+BN64jlVyCfPjAi+TQvQoRxKlF0VpBJ2IqU/Vckcm2gc/onJXFPP
 5SBFRchCL02KdLimV5xvDQKcPI8kbJsO806u/1RrLqOU69EOWl4Pe2472vXFAWgkZLt2Ul/RAD7
 jUMtfu4xVSxpiewbH0gNAZtNv8K92ijVEz1CfexGAP8gcAPzuOnwOoq7BCQ80CSr/Pffec6gF8I
 SEbELO1sCcB9s2DHgmhbBE2GHoWAkGyA/3caKzSU4dbkNxLWeYZB3w4oQTffz/qxVUxX/BuVTO8
 hGxqPAFZYQYwdC3B3EvCzZl8lyRw7SHJYPMW3O2fd4RT/PWslT07zodtMDBdMSGcehuY0fdH0lp
 vBpqnIXoP6wVHcSgWqOaXKqQ16iJbQpkP85wdUXvHPPtAgD813EMnVAfykLtaxIkxXfxdbgtDhO
 8o=
X-Received: by 2002:a05:6000:2602:b0:48e:824:f0b9 with SMTP id
 ffacd0b85a97d-4a63ae5678fmr11598609f8f.45.1795095200767; 
 Thu, 19 Nov 2026 05:33:20 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:19 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v3 06/14] powerpc: mpc85xx: Discard LTO keep-syms sections
Date: Thu, 19 Nov 2026 14:33:02 +0100
Message-ID: <20261119133310.22732-7-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With LTO, keep-syms-lto.o puts pointers to linker list entries in
.discard.addressable to prevent the entries from being removed. On
mpc85xx, -mrelocatable creates .fixup entries for these pointers, and
the linker scripts keep all .fixup input sections, leaving
.discard.addressable in the image.

Discard .discard* sections and the .fixup entries of keep-syms-lto.o,
which point into them. Otherwise, ld leaves zero words in the fixup
table, which start.S treats as addresses to relocate. With them, the
Turris NOR build with LTO hung after the DRAM message.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Cc: Marek Behún <kabel@kernel.org>
---
(no changes since v2)

Changes in v2:
- shorter commit message
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

