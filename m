Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9C5C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB2C3405ED;
	Tue, 25 Aug 2026 16:55:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kPtk647VeSIA; Tue, 25 Aug 2026 16:55:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787676932;
	bh=hhjJRDxui90WRY4BJ0zou3sFm0EGopixiUk3zYVKqwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L2JT9K7m4BK90RbKgSMGU2isNDmS50hciVjLaUkqZ92K8L8uULdO1bz57M2wjeThp
	 3GtDBiUb0K+cIClNu1w67sGS+edRjCA77zWzQnLepflgTPZVGvDorFPCkThZyE9mq/
	 TGVda2XAraO+JWEgN0CUSpLamen3Mf6tx2E4ddrEPKT79lcRAfHP3nILy2CuG4mXx9
	 ryoCR4Lsb/COO3/erpwJV3zGFlhkb1jcjyi5vidaBG2MIxZ9rFLVZ816G7MXlkVLLi
	 vyfQ4SjQBkb4HVbikkMjLhW+WZLh8LzyIw5HzxQzBgRGCiOEuTo9nVyS+d049BuF6I
	 KdPgnV+tVVSxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3B03405CF;
	Tue, 25 Aug 2026 16:55:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2625D3DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18ED740169
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N_ExVCD5bAbc for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 16:55:29 +0000 (UTC)
X-Greylist: delayed 324 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 25 Aug 2026 16:55:29 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=TXSCeNJD
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.170;
 helo=smtp-42aa.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04A094004E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:28 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0Q2jzkzjMJ;
 Tue, 25 Aug 2026 18:50:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676613;
 bh=hhjJRDxui90WRY4BJ0zou3sFm0EGopixiUk3zYVKqwU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=TXSCeNJDA+uYJUXp2HFR5YvYZJCVCpg05KYj8WY0tJP4foK10Et2wbKYY4q0vKHVs
 eZC7y+FdgHdiSfUEjxOuRYxkjwrKLveB7PoZuUte9SD2wA30a5rH5tCoS817vLIehl
 9HxQTcu0Vos05bRK50iLjM8V/yVr0E3MYIicWu2bvGIJdq5RZraxBlGccHLB5git5p
 DUpUoOWxgPNep6yVHZJtBEhpgN5dtOWRqy12weR+Ld0ISPnUYRBhfAt/pzBNit3iig
 VzK5CB6AlGVsGoJR2FvS4bJXh1Re2qsqx70pgOcN1aEuZdx5cTRNdbe2KFsKaz7Su4
 Wp2h0UPMZw3kw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0N5FK6zY6L; Tue, 25 Aug 2026 18:50:12 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:43 +0200
Subject: [PATCH next 06/45] doc: arch/x86: update SFI link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-6-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

simplefirmware.org has been redirecting to various different domains
over the past year and those domains don't host anything. Moreover, SFI
was abandoned by the Linux kernel 6 years ago. Let's just point at the
Wikipedia page instead of a non-existing (and possibly domain-squatted)
URL.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/x86/x86.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index 09d180087fb8..3c61c3058f7e 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -483,7 +483,7 @@ TODO List
 .. _coreboot: http://www.coreboot.org
 .. _QEMU: http://www.qemu.org
 .. _microcode: http://en.wikipedia.org/wiki/Microcode
-.. _SFI: http://simplefirmware.org
+.. _SFI: https://en.wikipedia.org/wiki/Simple_Firmware_Interface
 .. _MP: http://www.intel.com/design/archives/processors/pro/docs/242016.htm
 .. _SeaBIOS: http://www.seabios.org/SeaBIOS
 .. _ACPI: http://www.acpi.info

-- 
2.55.0

