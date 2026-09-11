Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC51C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 12:06:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEFFE6068B;
	Fri, 11 Sep 2026 12:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LkPlXIE8g2_B; Fri, 11 Sep 2026 12:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 69C8F60665
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789128373;
	b=bDGrn2GXLo2g1BcX+rkgvG7bV4kfv6u2II8atJZKPq2IqG7OTTtFeEvsZ0d1g4+UKuR9
	 u9/CU/uGC2Irw3YW7KsQTu5LylCTvysKS3N111vkpxzSVk+obwXm85YPVUfYlnPq9W9us
	 eqfdM0aRSxTr51jexoRi9AxW9oO4aAkEvYuR2CKg8CIaoeket0p5BH6CceeQt2t+Ayhyh
	 PupGf2QqU8amKeXmdN9vT2ule7xBm1n5bBz3LIaa2RH9vSzsOikwFhYhriRDXQq2G1wmm
	 G08leALs8GOcIbdSOj/+dR4YUq/QhLV8+hupFGhA7gwWoDS0oYTaPOPu4Iz508PraZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789128373;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LB7xm+MyDqo3S1IzZOWLNwa1nLh86j6ZGfyL6F/Ly9w=;
	b=nVRdnfr8LAd8s1yxj4vrZPWLAUkOj7e6XDHkNwfvCeYzsOCbawhEiMxCg9faDbDYlqcz
	 5SMDD6i4fAkk2ByjMm2It+pieEDFenWc7C5VKGAiX09+5cZqgWj2klrQr/X/JnuB3wFi6
	 oW8X4Kw4hZEFmtJumuvVJhCqbhdywLNubINxMGRQayJagJaA7vjnqfDgUfKW4xZ6wVtUr
	 Q0HjhuJokwoTFYvVQbOlip8ZnUuuCU5w/xnZabjFhmGdAW3JVeGKt/MhneOkdjURwxR/n
	 ubIoUAFDyz3Jby073c+9qqnliYKIcE1cbmTwqHdNpEkdhfYwqXYGku3ype0GkTH8qNA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789128373;
	bh=LB7xm+MyDqo3S1IzZOWLNwa1nLh86j6ZGfyL6F/Ly9w=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pno+D6hpcShqvivObnGwuYs7Bokai/OWPUqlbmvN6oxI5Au64/izuB3wxp404xH/H
	 9OAMUXRkFS1fzaou0+3GnXFHF3kP9sIYjrykzrtfizTSyOhgQv2gRbLbRMDg57ny7m
	 ilQsP2kraqKWKvKGIVM1CHo8qpsGlO+ruYquwa1kggEaHCsFsvxDXU4LeWqSA0cswt
	 VG18Y0g70q61tbpsEaTeT7gp41LZ0kuIpcXEwtysJ1TMzPpf5V5aHGoVoBE/oRt03W
	 XJFtrHJIMkge0lUSnmDa15DaVVEKOls8sd+lsR49sN0sRp862aEMZ0hNBOJ1D57Tvv
	 UUBu08NmbfSDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69C8F60665;
	Fri, 11 Sep 2026 12:06:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 99DEF3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B87A407CE
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:06:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6rx7JunTMZl for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 12:06:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CCE3F407CB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789128371;
 b=RnZC+Ndr1RqUKNHQG+vfDPravVilRMSSB44rJoXuN+epPfeNcERWUctEE7faYzxGB3wz
 tWhqtlX1ZjGBmSxvoPZqA0rSYMxj1EK0pNMOOMINSWbhu5BDMbL5Fspw2L/dH1MGfeQC4
 grN0fyVNARftQ4uCWmuqeftJQ8Sa4KKao/fHryu5+oF87ueXi+xoh/4Xjg8BoI/OG4NqP
 fYCo33ER+CQO3icZ08gT5UnCPzu5jyJxLoj0G3NYmK1PCMfQAt9xNyH8xA2d1TzpeTD6W
 72epGplzUcc8pCI3O9xSutZWFLg/kLh0cZ/gGt98Rx327H/4wdT6cXe2WoZVfm9QpQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789128371;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=LB7xm+MyDqo3S1IzZOWLNwa1nLh86j6ZGfyL6F/Ly9w=;
 b=TxJsAcYLTrxXeJYvTe/MQyOGACmZ1YOTgEHM47g2LsLfDkbuTKD2xoImOYZkOhlGlv/8
 nfIjs+Yn7fNRqOLbEwShiMyOW0W/rYNdbTR3jIR85FUdYN63Hz4AMNxshkzvUA/88TMmc
 fpDTiNA6n+J3EKZKXGOcRXiUHkCAPaU5qf5qnjix3rn4ciGeiuUTLYCgGfOplIBE00M5H
 rCiZmLqRJ3VS0VgTPH6maNQMnxXhGP8BtIjDk/lvEs3xJy+xR6RZq9fkDMcpvSj7g9R1r
 aLMGf5JDmfCsuITj8HPNBJVLXOxyILVgFrwQgWCgt3bUlucANREe/CjVxDOd2e5p2AQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NX7Q2vJH; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NX7Q2vJH
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCE3F407CB
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:06:08 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48589798dbbso773770f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789128366; x=1789733166;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LB7xm+MyDqo3S1IzZOWLNwa1nLh86j6ZGfyL6F/Ly9w=;
 b=NX7Q2vJHvcVs9jOcSB6nh+AYYBI7BesfcDQ2slPVbunJZs2PH0qOTpIMwKEtDlZ0MQ
 EvZG+UdGorFXRGCYAvjZp9b09bBR+VJquB5Apx++fSuQ9TzKpvmzLxc210REEjrx9l8A
 6Gr+5a3HrGR5E86oFPqzotTVQZE7muI3B7qKTVUsJqDhd3F8auRLm0fDpHAHTolJgGZo
 bag7ojbwkKRcwORVFqkCMiKQwArOZn/bN1Z5AQyz8cxQAb3XTzEXJlCIrukRZ7HLhBXI
 4CNIOiqAgnjkJBP8Nn1cvJfrXDv2K6ecwENY9f+UIpbXF1+0tAGMsI62J5BOq5q85add
 3zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789128366; x=1789733166;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LB7xm+MyDqo3S1IzZOWLNwa1nLh86j6ZGfyL6F/Ly9w=;
 b=g5lVqwTRv0MgeWZRXn+2sVENRhKXY7K/NXD1Pd52eN9euxPdf/xjhLudEORkJUOlDo
 TyBhYmHlZLh4nLhqO1HN5SVFTBq57EadjR1stfOSqhyXj8xg0K47wtXn0fKylZRYifwI
 /xycxGeJmo+P+D0UIy1jFjJ8sAVFST0WLyX1VZ847eN3X4eWsfow3vMhYbbblcIOpK1a
 aQGYx+RvusUDyokdjKYBB7uzRUmyzhcxbb2UaPrTkS9tu7xKrqIprWcnD4dcL0pl64Sq
 yhaNjoUPCWtUPOjl0ZhB85hdxKz/+4kskfq/2H0Jbx7T3IX70triHYUqPUdACSOwGq35
 LVZw==
X-Gm-Message-State: AFuF++lW5Yi1KOQLFzOA+HN9QTtkCSHmxYwpp/6/Ry3XrGOOa5D7GSFJ
 iSkkJzecJFf97B/sMsSNI4UlPJSAy0Q5tU4XTgBPem/GbbJ9Vqa2sgrbTrVHuACosw4=
X-Gm-Gg: AYBFou0d2ZEZy9TXpy5pcVM5w8+e/SEx98wpsaJPMwJL/X6sJ9ehmamRv4QA7rHK17L
 6JJYHYkOrzr1eK4WH2z+hoVMtNW7i+AHjo2q4ndv7U2K/pS7ZplCaFaGyOKcuKZ9IcfQRJv5zKP
 hG0574H90/KYPo9hHUX9R3+hnYe/Hd0RNXWcKdI3emKQ/YQ2Lj6xKvYiIzaaMqvfRe5lMPc9Pgn
 OmrQESq6Izsny5XwqXCRiYK20+LzsfCCjUXrknJeh01dfA4cJNjSlhFNSXkzoU4Y5BYQ5jU4Q2U
 4kWv6Jw3XVJh/gOnTuoLpMRdUVbHMFqEK3qMKQhnYhSWDrwgP4JVAEE8FJjfhArrM+J/RdmXVvC
 rmdsmgKzH9VjKaTAW0bmxmTGaGUCOyzZ/0iZEpX3vxfHz27F0I0+RXuXMx6b4Km7zb0OO1Pdu0Q
 Y55GPB2zBwEURoCCcy6df2d3gmmnjDNLJLeWMi1r48ARqPOAE2GQwleBBLWpBa8B+rrOH3fDTu+
 swPm+G+oRPVmUDr2yumrLPyfBiMOUict1Ihi2Q41p6uK+rkV8dgkjY+OP//oM/AIEn3dcrWP5cy
 3DMvKCX/hSBtec4=
X-Received: by 2002:a5d:51d2:0:b0:483:3695:6ea6 with SMTP id
 ffacd0b85a97d-486eb2feb47mr3456276f8f.20.1789128366458; 
 Fri, 11 Sep 2026 05:06:06 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb36e4a6sm5824487f8f.37.2026.09.11.05.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 05:06:05 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v2 0/2] Support board-selected raw partitions
Date: Fri, 11 Sep 2026 14:05:57 +0200
Message-Id: <20260911-ccaione-upstream-part-dynamic-v2-0-295fefc9a3c4@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw6CMBBFf4V07RhaGmNd+R+GxbQdZYw80hYiI
 fy7Bd27PMnJuXcRkQJTFJdiEYEmjtx3GdShEK7B7kHAPrNQpTqVpjTgHGaFYBxiCoQtDBgS+Ln
 Dlh1oJ40i5bW1J5EbQ6A7v/f+rf5yHO2TXNqim9FwTH2Y9wOT3Lzfliz/bE0SJFRnqaVGb7DSV
 4vzi22go+tbUa/r+gEsaQXy3wAAAA==
X-Change-ID: 20260909-ccaione-upstream-part-dynamic-4c192e2d4bb6
To: u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

Boards may need to read on-device metadata before choosing the raw MMC
partition containing the next boot stage. This series makes the existing
partition hook usable after MMC initialization and adds an explicit
runtime-selection option within raw partition mode.

The board hook owns hardware-area selection. A failed dynamic selection
stops the current MMC load attempt without filesystem fallback; other
configured boot devices may still be tried.

Out-of-tree spl_mmc_boot_partition() overrides must accept the added
struct mmc * argument; the in-tree STM32MP1 override is updated here.

Changes in v2:
- Reuse spl_mmc_boot_partition() instead of adding a second public hook.
- Pass the initialized MMC device and boot-device ID to the hook, and
  defer selection until after any raw Falcon boot attempt.
- Keep explicit partition loads independent of next-stage selection,
  without splitting the MMC loader into preparation and loading functions.
- Make dynamic selection an option within existing raw partition mode,
  select its partition library and hide the unused fixed partition number.
- Restrict STM32's fixed hook and MMC2 partition setting to fixed mode.
- Keep a weak default and diagnose nonpositive dynamic selections before
  filesystem fallback, while preserving fixed-mode behavior.
- Link to v1: https://patch.msgid.link/20260910-ccaione-upstream-part-dynamic-v1-1-381414ad9a34@baylibre.com

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Carlo Caione (2):
      spl: mmc: select the boot partition after device initialization
      spl: mmc: support dynamic selection in raw partition mode

 arch/arm/mach-stm32mp/Kconfig        |  1 +
 arch/arm/mach-stm32mp/stm32mp1/spl.c |  4 ++--
 common/spl/Kconfig                   |  9 +++++++++
 common/spl/spl_mmc.c                 | 22 ++++++++++++++++------
 include/spl.h                        | 21 ++++++++++++++-------
 5 files changed, 42 insertions(+), 15 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260909-ccaione-upstream-part-dynamic-4c192e2d4bb6

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

