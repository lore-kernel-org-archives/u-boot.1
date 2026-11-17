Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA367606A338
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=INHpn8qU;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=DuK50ctH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 810384075F;
	Tue, 17 Nov 2026 16:47:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z7qwrIXbW9_l; Tue, 17 Nov 2026 16:47:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F54C408E4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794934065;
	b=Xvowf6Iccj6SKD1fl++N0nGSTVU+zdApp23+ltJeVB2pLaRHnxgf7MKwN9Mdj5kHNZCm
	 eGH5clVS7wUkW4o+7I+2wliCMFFUlxOYaTtYPvnKvEnPcu5C5utisWCvUO/YOHwYmc40G
	 gwcGrDh6s+IdN5udEMKKvIcMuDjk94R6A9xRHNLeed4RPZGIi+hlxS+vwPSWh5vIH+ibE
	 kiKVsR7IJE654kICxqIKqttmPFoH5fzfXLepU2ggDkuCAq54pf4Xu3OBdZY482pBzUZuj
	 opZaoB3rM8iF480m/YB33iDncsIosmCtHL+x+ALVLIbdfrOqkws2q3CyWxc3PF6KLXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794934065;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ql78kZPgJ5y85EdnpmuOro+Z921I14ULlLixvuCOGQU=;
	b=CjZAvBP7wxkC6o8WYSXrE02TtwMLfG/EqtoSOYmvP0fxALcKanVCQP/dNWVAM+v7q/x+
	 4sxRQIbM0ayViwv14iakt/OKf/Jgp2+R7ExTQjET96HJdx9t5MFECnMM5bF+2Kx0c4RaU
	 xHmKGx4laTy60q+w54L8jsK8kFFYHV7LTuE4fpVkhwYqM9eDDzuPD92MNrOPVpLd5UOrl
	 8TuKWN2NRnjcw3iZHZ4baRtFtKwFBz85tPPgw7XZSPkG/k2san6jGmVDcjGCc0Z4zjXhy
	 tLGD1p4v6Jb5Ngvkpc03bl8lgyDbGOXz7jsyW1iC8feh2nyF1RLiGB52EgYbAoRUBMg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794934065;
	bh=ql78kZPgJ5y85EdnpmuOro+Z921I14ULlLixvuCOGQU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=INHpn8qUkVf9qOctuLrnXNw4rX/zickxYzsG56LP9hOWI/36tK7Tx/gDDEfWvWYjE
	 GYkPRFpZgvOmgu9g/3tLsGdUuElwHcUEgPJyEgbMHjp1tzWg5/2sEd3imn82y3IAUA
	 4Eg81zTNUcWG9JSzwfFpRTalcua2bHr41BOVroBAEXO2WH8UqVQ6bk9CKBNLa2vTns
	 c4J39vrPPl1HVU6b3hIAZpSNfYB6T88LxiVdh2Zevx8gg1zOe+m42ocVURYzydeijL
	 f9B/Jr2Cnhs+ed0GOs04oYPhKJMt2Z5U3JN77jHhAYGvacxDJDceoK3wW4MUeaObos
	 UkH710n5uSj0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F54C408E4;
	Tue, 17 Nov 2026 16:47:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E620F1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBDEE60906
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:47:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hd0-ymhSB8RW for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 16:47:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E597260729
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DuK50ctH
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E597260729
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:47:42 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-862df509d48so776054a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794934061; x=1795538861;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ql78kZPgJ5y85EdnpmuOro+Z921I14ULlLixvuCOGQU=;
 b=DuK50ctHAEMSIHDTHQgPagGJXS0yTCWbAb8BJPqozvBF4XXUJMOU6Da1w9CDTgtvCP
 AUvyaDE0GSz8nJJ1lC+Mh4hB15hE9sUBfM5trJVUwZABVxq9uYjzpBitS5Tsq+EXudkl
 wr6bjGnTzA8yHcVoDY4E3yhPh8gBLVK20p+Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794934061; x=1795538861;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ql78kZPgJ5y85EdnpmuOro+Z921I14ULlLixvuCOGQU=;
 b=qsWbPsauqQql1w+vRpjQQkE7AsCPq8MzLO9Lw6a8UeXYjiIkASSNIqBkdKH0j1RVlv
 QVS9rOFnLfZrHNhRp3GtvgRHDDjk6xbc9TgYKJMXu2bZJMP4704O+cL1z3BHBmvzWqaj
 fu8zVesEh2E9VkltyZbbvKQtyf/5u6OXdeO2VvLjQPgKrUHmIeKYtM9OPfT3plSZx9HR
 UfTZ0n4/QH9LUBM/+WM4+jHdFFUMmMYj+ba3rB8NbaljJ/0esi5ZXukpPSdPdglyB1Jv
 r5dtQmG2xJfmTVvWRGGvXs/ksQB+MSKEy0AYZlGDBZL7+pszE+gOGNpshkNLe428kImc
 Y2cw==
X-Gm-Message-State: APuU4Z8VdTg1rQI4Pos9h0DK3wa6mqEGh2pdpY616kcvzIwdbIAMArth
 rytcqCzPBnf1gF/41GAFFt1rYlBelN3urrsb9TtChQAFGlYmpiuGnrmhThdEW0QAT9mJwI9rKKs
 3WOkvaPn+Kg==
X-Gm-Gg: AYBFou3fpwbmZnOXvyb8qSBjBhulFb79Ri1tYQthL0Wl0Y1CFjjcyxdryPLRBgZgCC7
 P4pOymKuUJylytOV/6oIs55eDgyT1XTbTA1M+pqxd1pMiW+vfWevYk1dn1qBMUIqnLJoenu9PeT
 bGrduPe5D6ml0V/E5WYu2WkpcjiTtZsc/86JbwZSVxTrHm3vxsLFYnogoO7gM7B18V3ukSDhzxp
 sT+GF4+RBAOGIxKzz4Zh4pMfxqZD+wXTlml3XcZo45w9zgtWwwF2QDjwnhy1bq7Ulqj5CeNqS2h
 bg2WzCaaPt5b56Sn99p7dLnmheusKU1Oz6g7h8Nx+Zc4HRM+CMyZ/zlSqrwGU4MXSBPiiDHiSCG
 6+snggwVxxIyQxwq6aUnEy29F8Et5A6DVcCHO55WLQ1fwHBe07SNAKzRn0eSNdAYgugBdNADoRt
 h7QwBe4/2Ii6j+aZVJm29MhQa9iJB3WEZcxcNO0+tOn8ZqCemJDtzgDdizHGUdeH5rBBpxABWah
 QaOuur0ZrFAbWqyrmD3NOGeOsEpDN+zZY0d92yCltTjsa1xob+uaE3nInv8qKzrlFhnalHJesLD
 zdDZ7sOTvnSNUG/I4PhtIH8qLz7NrNB0UMD2s+TE0IIYDLxoCocsRVZ7Z+sJKuG3cYcVfHncDw6
 +hs7UX88mZbLQ9sleTv6VWLdUl/5DIqZP+Epbt4azkxlGLwe+sxEybvPEE1qE+ldadTBSmWwpsp
 k/iJ27+gHLxObOsBwe2/6kp9HjP9n5lAC7HQ1G2q1ajXKHl3bhOrevW85eom56VNxnBmA5tyEsW
 SeK
X-Received: by 2002:a05:6830:3492:b0:845:8a98:3f1b with SMTP id
 46e09a7af769-862ddd01700mr2409296a34.35.1794934056082; 
 Tue, 17 Nov 2026 08:47:36 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862a82c4625sm9701331a34.22.2026.11.17.08.47.34
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 08:47:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] doc/git-mailrc: Start updating
Date: Tue, 17 Nov 2026 10:47:32 -0600
Message-ID: <20261117164733.2806843-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The file doc/git-mailrc can be used by git and other tools that read
this file format, such as mutt, to make it easier to email patches by
providing aliases. The file is also long out of date, so do a first pass
at the moment to more closely update the current state of who maintains
what.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/git-mailrc | 47 ++++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/doc/git-mailrc b/doc/git-mailrc
index d6045875864c..f745279bfa58 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -12,11 +12,9 @@ alias u-boot uboot
 # things simple and easy to look up/coordinate.
 alias abiessmann     Andreas Bießmann <andreas@biessmann.org>
 alias abrodkin       Alexey Brodkin <alexey.brodkin@synopsys.com>
-alias afleming       Andy Fleming <afleming@gmail.com>
 alias ag             Anatolij Gustschin <ag.dev.uboot@gmail.com>
 alias agraf          Alexander Graf <agraf@csgraf.de>
 alias alexnemirovsky Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
-alias alisonwang     Alison Wang <alison.wang@nxp.com>
 alias angelo_ts      Angelo Dureghello <angelo@kernel-space.org>
 alias apritzel       Andre Przywara <andre.przywara@arm.com>
 alias bmeng          Bin Meng <bmeng.cn@gmail.com>
@@ -29,29 +27,21 @@ alias freenix        Peng Fan <peng.fan@nxp.com>
 alias iwamatsu       Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
 alias jaehoon        Jaehoon Chung <jh80.chung@samsung.com>
 alias jagan          Jagan Teki <jagan@amarulasolutions.com>
-alias jhersh         Joe Hershberger <joe.hershberger@ni.com>
-alias kevery         Kever Yang <kever.yang@rock-chips.com>
 alias leyfoon        Ley Foon Tan <lftan.linux@gmail.com>
 alias lokeshvutla    Lokesh Vutla <lokeshvutla@ti.com>
 alias lukma          Lukasz Majewski <lukma@denx.de>
 alias macpaul        Macpaul Lin <macpaul@andestech.com>
 alias marex          Marek Vasut <marex@denx.de>
 alias mariosix       Mario Six <mario.six@gdsys.cc>
-alias masahiro       Masahiro Yamada <yamada.masahiro@socionext.com>
 alias mateusz        Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 alias mbrugger       Matthias Brugger <mbrugger@suse.com>
 alias monstr         Michal Simek <monstr@monstr.eu>
 alias prom           Minkyu Kang <mk7.kang@samsung.com>
-alias ptomsich       Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
 alias sbabic         Stefano Babic <sbabic@nabladev.com>
-alias simongoldschmidt Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
-alias sjg            Simon Glass <sjg@chromium.org>
 alias smcnutt        Scott McNutt <smcnutt@psyent.com>
 alias stroese        Stefan Roese <stefan.roese@mailbox.org>
 alias tienfong       Tien Fong Chee <tien.fong.chee@altera.com>
 alias trini          Tom Rini <trini@konsulko.com>
-alias wd             Wolfgang Denk <wd@denx.de>
-alias priyankajain   Priyanka Jain <priyanka.jain@nxp.com>
 
 # Architecture aliases
 alias arch           arc, arm, m68k, microblaze, mips, nios2, powerpc, sandbox, superh, x86
@@ -73,19 +63,19 @@ alias s3c            samsung
 alias s5pc           samsung
 alias samsung        uboot, prom
 alias snapdragon     uboot, mateusz
-alias socfpga        uboot, marex, dinh, simongoldschmidt, tienfong
+alias socfpga        uboot, marex, dinh, tienfong
 alias sunxi          uboot, jagan, apritzel
-alias tegra          uboot, sjg, Tom Warren <twarren@nvidia.com>
+alias tegra          uboot, Svyatoslav Ryhel <clamor95@gmail.com>
 alias tegra2         tegra
 alias ti             uboot, trini
-alias uniphier       uboot, masahiro
+alias uniphier       uboot
 alias zynq           uboot, monstr
-alias rockchip       uboot, sjg, kevery, ptomsich
+alias rockchip       uboot, Quentin Schulz <quentin.schulz@cherry.de>
 
 alias bcm283x        uboot, mbrugger
 alias rpi            uboot, mbrugger
 
-alias m68k           uboot, alisonwang, angelo_ts
+alias m68k           uboot, angelo_ts
 alias coldfire       m68k
 
 alias microblaze     uboot, monstr
@@ -96,39 +86,38 @@ alias mips           uboot, danielschwierzeck
 alias nios           uboot, Thomas Chou <thomas@wytron.com.tw>, smcnutt
 alias nios2          nios
 
-alias powerpc        uboot, afleming, stroese, wd, priyankajain, mariosix
+alias powerpc        uboot, Bradley Morgan <bradley.morgan@linux.dev>
 alias ppc            powerpc
-alias mpc8xx         uboot, wd, chleroy
+alias mpc8xx         uboot, chleroy
 alias mpc83xx        uboot, mariosix
-alias mpc85xx        uboot, afleming, priyankajain
+alias mpc85xx        uboot
 
-alias sandbox        sjg
+alias sandbox        uboot
 alias sb             sandbox
 
 alias superh         uboot, iwamatsu, marex
 alias sh             superh
 
-alias x86            uboot, sjg, bmeng
+alias x86            uboot, bmeng
 
 # Subsystem aliases
-alias dm             uboot, sjg
+alias dm             uboot
 alias cfi            uboot, stroese
 alias dfu            uboot, lukma
-alias eth            uboot, jhersh
+alias eth            uboot, Jerome Forissier <jerome.forissier@arm.com>
 alias kerneldoc      uboot, marex
-alias fdt            uboot, sjg
+alias fdt            uboot
 alias i2c            uboot, hs
-alias kconfig        uboot, masahiro
+alias kconfig        uboot
 alias mmc            uboot, freenix, jaehoon
 alias nand           uboot
-alias net            uboot, jhersh
-alias phy            uboot, jhersh
+alias net            uboot, Jerome Forissier <jerome.forissier@arm.com>
+alias phy            uboot, Jerome Forissier <jerome.forissier@arm.com>
 alias spi            uboot, jagan
 alias spmi           uboot, mateusz
 alias ubi            uboot, hs
 alias usb            uboot, marex
 alias xhci           uboot, bmeng
 alias video          uboot, ag
-alias patman         uboot, sjg
-alias buildman       uboot, sjg
-alias pmic           uboot, jaehoon
+alias buildman       uboot
+alias pmic           uboot, freenix, jaehoon
-- 
2.43.0

