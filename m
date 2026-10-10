Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670C0CA9ECE
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37BF260A44;
	Sat, 10 Oct 2026 22:32:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8VjCCcPubBlL; Sat, 10 Oct 2026 22:32:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2AFB960702
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791671550;
	b=EC3ky3TpWRGJAz7aEwBoo02YyGTBO9ImIvbHQUoxtDMX2edmigpgUgKwzgmCTS4rTz/E
	 jY3hhOIJqKQld0hrhtCsjvABbACiEsdqK5hg2TtFmvXsNs6Ks7UlxDfyWXW/Mo/4rq7sv
	 HzhtbVOci26s/UeAXjITUdSETz/I6LcswZ1Av/4f2BD3FYGNl8i7TaLE/Zqxp4OWx+QJM
	 vPF8cgifKamJV2ojj8PjhT86bdIaJfYPM6VZ+a/cHC/spmBUa1DouFaEYArXYv8WIS+cJ
	 kTu6Qx6sy9ON2g4wO5sbv3TCuyj8Vtk4J4bNwNd6rHD6i/koPqKe0t9WASTisNhT7yQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791671550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=f6czWl/9KXlkpCEnFRyYWuvof6fd/ddUetakSqb9cSk=;
	b=dY5aVyRnad73IFWIpsbh+e8Lhd3sX8o4R94ca6qHJHJlTYVdTDpTRUQForOlXNg1lVHV
	 ys0yYD9VR3JX4zXaEA8wxXHoTbdsIrXqnDVjhhzwzzwmnffuNGURjERF0BEs8uM0Su8O9
	 cmtwM4WmdYqOUtnuw+M2z7wRltN4fLIofMjhOiYlVGhilzOprB22ivE1Q5797bHFupf7p
	 GOppRMZc73vnAxCR2rvBnx2jwNNbgvu4g7M/QAR15TAIdLzlYH75N6RLYdKJGfhyesRlR
	 hRI3lZBANIrLHotrbnhqVRmBiJXQdArU/bJZjY0Gw2Tu1zAxj9VKki6ftSjyZaIDlfg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791671550;
	bh=f6czWl/9KXlkpCEnFRyYWuvof6fd/ddUetakSqb9cSk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=UXp/nmM8lFGPn/jY+K/wHKdNs4UNCHMmGXiTzG9hr81Ric/PJ2DlmbpZkV2VlfxGe
	 KfoHs+qAR+/zYP2MB8d1sBGBdCvzhYSScdvJVPknrco3j7G4IZd97OKl02MxTueVCe
	 zLHPT7aNQaTf5TbGghG3qlkG8dqB0AASeHpuGohksa39IoyPtuh63GgoDbJaCOVZLV
	 8k4+UsivLmkSDLDr9e5dfkGU3tu0YrnuhEg5vYDpNXn38gUxGKCSzETCRKzd7Aar1Q
	 g935+UVJr1n9vee3slEdXN9N672QdQH3ixZW7t41ci8RaBV62i+dUbPN3ZdB/f/2q9
	 6nEahvb31vyBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AFB960702;
	Sat, 10 Oct 2026 22:32:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B2E1B356
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A543A4082C
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uuDLAdj9iSNy for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CEF844082A
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791666490;
 b=QWz3GOouzFFGDXCjY5G+mFSfKRtyhVkdCiz+4ezPOy95wvl69FK3wv+yqvzRqUkKayMq
 5nokaQ26snj5MX0a1mcZVCG+IErH6abKtAcB9769VeqBE03Lhw/Lifd0mOnIuLobOlrsg
 SAY7jbmSeOv1Z3MrO//kSZ2f9311SaCkHFnCQmuK85WNB0kB9o5VGdjYhh5Zlqmbpauty
 cAfgVGgztkK20LO23wJfdBY+ew7ATaFWOZbgiJheHVMEXRvRKvZupruWZh0MWwsbpDU1q
 BOu0bgjUpDXaQ5cle+DRQf92MtEzGx6gGm1r+kcGqqmryTNyM06zwhxKo9c2m4/+3vQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791666490;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=f6czWl/9KXlkpCEnFRyYWuvof6fd/ddUetakSqb9cSk=;
 b=rfwb7aUTjrMdy+2j9Y0CZ7bXF+zE/6fAFvHWw4v8VsAGkbxkh5bvOKU7ud3ALNQ4UdNs
 iJRrM5+18t7KScnmSuXW0Gi4fPFoWG+keFI8fXSCGSO+wbG7QfrAow6GlDhRhKBiL4qXK
 krAnuh0DmYKxKqf8ad0N8pgcC8/OJMTgzUA4XB23VySfG/lUEPV0YwiXHnkNL1IZN3BzA
 cpKr799ygVY+0I04i50+4iTYEtK7OQEUTQh/Ofo4Dtf2sos2IDYNu83ahjFchCLAjkRUM
 rTYN61NRJKQGD9BmHvmBnhN4oET1spIfGhmQlS1PPmXt+8aRfoQiutl8/cZNm8dN8SA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=N5wKjA9x; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=N5wKjA9x
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEF844082A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A2BC06053B;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 581C4C2BCFB;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791666487;
 bh=coKEoZ5d4mrzTmZoVC2FvC0JOpQAMboHhDBtatFRxhA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=N5wKjA9xs8PAUnabHM0qTwdAxlqEhzHOPXlcxygCiqoucWNeAFmEhDWfrK1ASvjKn
 4RHiUK2uynk/wt+nbhUMA5I2tI37uI7on9Q2aUBPKJVEghqoictdrIBQTIInj3oiel
 8HQI1lNAJTvyDifXE1ipNj2QJ4EWkU0HApQLKL3ZZ3iKd0dng5j46WwGmk7cO0ishj
 CogkTqmWZRaq6V0MyVSdWe/8YifKAAs8+y9IhTMERTTbVqV8aaW0CtHpmA98ScNy74
 iOQdSPT2xuVjF6aAsWgbiaGeX9OmJ3FtPpSk7c6MPA+0yRTzNiIb5+SlkjWlZhBa4w
 zqO8rU1kpLSWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4903CCA9ECA;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 23:07:54 +0200
Subject: [PATCH 06/11] cmd: phonemenu: read the A/B slot on Snapdragon
 without "misc"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-phonemenu-series-v1-6-bfa23de6eb0b@protonmail.com>
References: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
In-Reply-To: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Petr Pavlata <petr@acrux.cz>, 
 David Heidelberg <david@ixit.cz>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791666485; l=2210;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=cCQTs89iJndVMQmPdK8pwsF9GljpgofHT26OXllY6lI=;
 b=+739HSpKLV8UKpSy7KMnYpX1O2S5PBZTxQ/mHHwiXUzxt8/ssqELItCeRprsm037cxxHAniwJ
 R51AEke2zfCC9IQjZhja4vc+t6B/8zkLs5vxR4Lhwd2knDmsVL4nBVd
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 22:32:12 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Snapdragon keeps the slot state in the boot_a/boot_b GPT attribute
flags, handled by ab_select_slot(), so no "misc" partition is needed.
Override phonemenu_ab_slot() in a new Qualcomm specific file so the
generic code does not require one.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 MAINTAINERS          |  1 +
 cmd/Makefile         |  2 +-
 cmd/phonemenu_qcom.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8734a683221..e4c108a0412 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -689,6 +689,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
 F:	cmd/phone_util.c
 F:	cmd/phonemenu.c
+F:	cmd/phonemenu_qcom.c
 F:	include/phonemenu.h
 F:	configs/qcm6490_defconfig
 F:	configs/qcs9100_defconfig
diff --git a/cmd/Makefile b/cmd/Makefile
index 913d94abdb2..2fb613228f6 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_CMD_BMP) += bmp.o
 obj-$(CONFIG_CMD_BOOTCOUNT) += bootcount.o
 obj-$(CONFIG_CMD_BOOTEFI) += bootefi.o
 obj-$(CONFIG_CMD_BOOTMENU) += bootmenu.o
-obj-$(CONFIG_CMD_PHONEMENU) += phone_util.o phonemenu.o
+obj-$(CONFIG_CMD_PHONEMENU) += phone_util.o phonemenu.o phonemenu_qcom.o
 obj-$(CONFIG_CMD_BOOTSTAGE) += bootstage.o
 obj-$(CONFIG_CMD_BOOTZ) += bootz.o
 obj-$(CONFIG_CMD_BOOTI) += booti.o
diff --git a/cmd/phonemenu_qcom.c b/cmd/phonemenu_qcom.c
new file mode 100644
index 00000000000..d8a295c10dc
--- /dev/null
+++ b/cmd/phonemenu_qcom.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm specific header information for phonemenu.
+ */
+
+#include <android_ab.h>
+#include <blk.h>
+#include <part.h>
+#include <phonemenu.h>
+#include <linux/errno.h>
+
+#if IS_ENABLED(CONFIG_ARCH_SNAPDRAGON)
+
+/*
+ * Slot state comes from the boot_a/boot_b GPT attribute flags
+ */
+int phonemenu_ab_slot(void)
+{
+	struct blk_desc *desc = phonemenu_storage_desc();
+	struct disk_partition unused = { 0 };
+
+	if (!desc)
+		return -ENODEV;
+
+	return ab_select_slot(desc, &unused, false);
+}
+
+#endif /* CONFIG_ARCH_SNAPDRAGON */

-- 
2.55.0


