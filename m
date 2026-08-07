Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE25C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 08:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D04A5409CA;
	Fri,  7 Aug 2026 08:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FclTuMMG1ZzU; Fri,  7 Aug 2026 08:12:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A4AB409CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786090356;
	bh=Fo3Ck4rvBPzTQ40+1WYiRjbhlvwiQyus6fIYcQO79S4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KOxFD3HAZQ5CIYSCefto41F1MJIHP9u+LnK5OTCd409YVwh+cUttQXlJkb0zkJXSu
	 jqv/KCCX7C3wENjoc/fUjRA66Dz3ROVDbW8Z65SChH9TzykySfl1290IslCJFdDrdd
	 ls8O6OeoZUTiXoo7hfyItF5ZH46tMfX3AYskFUDYH0cTIKvrvxQc5xPmvAcAItaL+Y
	 gMzrhTJ7czssDYbsgUAaX535kV0p2ZtuWYUCx+fLYGQXtASAsv+TAVamLKzUj9xxp+
	 dH1TigBIr9u57wLccXY0kjL58ECYybDsWwGTxGyH7KKUvT9InDv3V7B6Pc6TtOJDT8
	 0xOhsG2HquloQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A4AB409CE;
	Fri,  7 Aug 2026 08:12:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EF572218
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5A7B409A6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:12:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bW3dy9edmq5S for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 08:12:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.154;
 helo=forward203b.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 41656409C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41656409C9
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net
 [178.154.239.154])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41656409C9
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:12:33 +0000 (UTC)
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
 by forward203b.mail.yandex.net (postfix) with ESMTPS id 9C9D2809A2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 11:06:34 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
 by forward103b.mail.yandex.net (postfix) with ESMTPS id D5779C0038;
 Fri, 07 Aug 2026 11:06:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id L6FKBuIeKuQ0-pEWzqDpN; 
 Fri, 07 Aug 2026 11:06:25 +0300
X-Yandex-Fwd: 1
From: Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH 0/5] RISC-V SPL: fix OpenSBI FULL FIT loading
Date: Fri, 07 Aug 2026 11:06:37 +0300
Message-Id: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrB3ID1TpVYoLGyd2imiYSaQg3
 r2pXX6L9w5QEiaFe3OA0M7K21ph2wbCa1xnQp6qwRl3M523KKxhx1iWBSNn1JLSJhm9M5PvY++
 tJahxEor8ucaP4W8tzzeF/LvBeX4BErS18noAAAA=
X-Change-ID: 20260731-riscv-full-fit-support-320d38f8311e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786089998; l=2372;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=OXT+SdlO04WIKtER5D88sg4fRcBsMvsY5v2wIGikeuw=;
 b=7O87Q5G3OBwCmZvoS35tZ2mqDI5tDwq0wx71SkKZlye04Bjjegn48wJvVG6Z8ZbF3avkysON7
 6GsT1+iB7k3AvElBfLyWDXU62hVRN1JXfXcoxXnGLCOu5yRo11Kx9re
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maquefel.me; s=mail; 
 t=1786089985; bh=Fo3Ck4rvBPzTQ40+1WYiRjbhlvwiQyus6fIYcQO79S4=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=IsgMyyooWxPGRKTYdnm0vsh1KNdg3QJX1YC4vGLp46QaYcptEwv+iPUPf2eRyPdxM
 JVkFCThvIbZudwPAaZZrLW3X6aYawkPt1PFYbqwPCrku8AjwJULvuv5WVbkf36V5VI
 9d1gEL4T0wNX48JYrcX6tTR+FG23B+ONryauS1dE=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=maquefel.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=IsgMyyoo
X-Mailman-Original-Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi all,

This series improves CONFIG_SPL_LOAD_FIT_FULL support on RISC-V, primarily to enable loading OpenSBI as firmware and recording loadable images (e.g., U-Boot) into the FDT passed to the next boot stage. This aligns spl_load_fit_image() with the behaviour already present in spl_load_simple_fit().

Patch summary:

1/5: Allow IH_OS_OPENSBI in fit_image_load() so OpenSBI firmware can be loaded without error.

2/5: Enable spl_load_fit_image() for RAM boot when CONFIG_SPL_LOAD_FIT_FULL is selected.

3/5: Use map_sysmem() for FDT address handling to keep the code sandbox‑friendly.

4/5: Record loadables into spl_image->fdt_addr during FIT load, providing the entry addresses needed by subsequent stages (e.g., OpenSBI).

5/5: Add a unit test to verify that loadables are correctly recorded in the FDT.

Tested with provided sandbox test with a grafted FIT image containing OpenSBI (firmware), U‑Boot (loadable) and a DTB.

However some issues still present:

- This works only if FIT Image contains dtb blob, spl_load_simple_fit() on the other hand relocates gd->fdt_blob to the end of U-Boot;
  It's currently unclear to me if spl_load_fit_image() should do the same.
  
- I am not sure if sandbox test is a right thing to do, still i think it's better than relying on QEMU for testing in this case;

- We require grafted FIT as u-boot.img doesn't contains anything than U-boot Proper for sandbox;

Please advice.

Only one patch remained fro previous RFC series:
Link: https://lore.kernel.org/r/20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Nikita Shubin (5):
      image: fit: allow IH_OS_OPENSBI in fit_image_load()
      common: spl: ram: Add LOAD_FIT_FULL support
      spl: fit: Use map_sysmem() with buffers for fdt address
      spl: fit: Record loadables to spl_image->fdt_addr
      spl: fit: Add test to check loadables

 boot/image-fit.c      |   1 +
 common/spl/spl_fit.c  |  48 ++++++++++---
 common/spl/spl_ram.c  |  12 ++--
 test/image/spl_load.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 241 insertions(+), 15 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260731-riscv-full-fit-support-320d38f8311e

Best regards,
--  
Nikita Shubin

