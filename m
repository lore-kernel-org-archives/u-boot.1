Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6771EC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 08:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAC2E608C5;
	Fri,  7 Aug 2026 08:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B5Yxgzp9Gseu; Fri,  7 Aug 2026 08:12:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58952608AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786090326;
	bh=jiGDhjgKZKkI1/yXS8F5v1PO5UpPOMmXlBbD34hIcos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zlTj3MPVLGaZUsNTpqTSgu1zRJ10XAItKBpxmRi5+zD3EKSaCwZ/Mc1BCI3HU+EZz
	 /HZSCjnEdliTFZAGgIgeM9QWRzUr41Tlxs9zobWV1RqUp9bYLeB+LKVlw7R1qtRD1B
	 xljRWJ8qVbVHxuy8VLt64SKaDzXlSGtknVmnjGlX86OocUL2NHCyKqL02v3B0zPFdi
	 JiwMw+3djiHuHZVYcrVGjCO4TRT0IOKPFsDdZ+IVy2LJQcLpzpXG1VJdEqqMs48TNN
	 AuXmNtwMH5Xc4oeAAtmZxhoqGKrA2ftwtrAouhc6MJ7gQw7qGVVeRzPigTWlDbO+4s
	 W4oE+lYGoA6qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58952608AA;
	Fri,  7 Aug 2026 08:12:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AFA2B397
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D28E409C9
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:12:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EIECLi5XDKob for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 08:12:03 +0000 (UTC)
X-Greylist: delayed 332 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 07 Aug 2026 08:12:01 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DECB2409A6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DECB2409A6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.153;
 helo=forward204b.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Received: from forward204b.mail.yandex.net (forward204b.mail.yandex.net
 [178.154.239.153])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DECB2409A6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:12:01 +0000 (UTC)
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
 by forward204b.mail.yandex.net (postfix) with ESMTPS id 283408516F
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 11:06:36 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
 by forward103b.mail.yandex.net (postfix) with ESMTPS id 93E86C00A0;
 Fri, 07 Aug 2026 11:06:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id L6FKBuIeKuQ0-ECfiJQTX; 
 Fri, 07 Aug 2026 11:06:29 +0300
X-Yandex-Fwd: 1
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 07 Aug 2026 11:06:41 +0300
Subject: [PATCH 4/5] spl: fit: Record loadables to spl_image->fdt_addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-riscv-full-fit-support-v1-4-21a34f79c350@maquefel.me>
References: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
In-Reply-To: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786089998; l=2871;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=OpsnRY8U7fWkjzf2X0YHR/GkI91IA8DKxdRFrmSi9FY=;
 b=5R1vXE4KGvFfsbfGBXRZ1CajrlzsVg4385jm6dGqSmhI2UHmMjdICQvZs66jfOBZtup9j/E54
 ZXiLLhCXUqiB/Wn6Veg9POrHTPGB8Gkm9w7CqVI5DnPEVOAZ71jyZwB
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maquefel.me; s=mail; 
 t=1786089990; bh=jiGDhjgKZKkI1/yXS8F5v1PO5UpPOMmXlBbD34hIcos=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=s7Y/AMDCB5sizASorYFuXpW/P/N0q6VMBBnTCERhQpRWD3dTb+QQb9qYWMMhnFl+e
 ejj1KLsUKLxY5fho0KGosSuu1KrrkI8r6zSxr17xma2Agms4qJE/N3WozFOAHw7GOT
 OWwpxuBdfSnz13+EdPIXb9sG034LuXgPsu0cemis=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=maquefel.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=s7Y/AMDC
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

Record lodable to FDT passed to next boot stage.

This is required for spl_invoke_opensbi(), for example, which requires
u-boot/kernel load or entry address to fill opensbi_info.next_addr
entry.

spl_load_simple_fit() does it, make spl_load_fit_image() also capable of
recording lodables.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 common/spl/spl_fit.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 4d4a96d1c4c..07e387ac7ee 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -991,7 +991,7 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	const char *uname;
 	ulong fw_data = 0, dt_data = 0, img_data = 0;
 	ulong fw_len = 0, dt_len = 0, img_len = 0;
-	int idx, conf_noffset;
+	int idx, conf_noffset, noffset;
 	int ret;
 
 	images.verify = CONFIG_IS_ENABLED(FIT_SIGNATURE);
@@ -1048,17 +1048,43 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	for (idx = 0;
 	     uname = fdt_stringlist_get((const void *)header, conf_noffset,
 					FIT_LOADABLE_PROP, idx,
-				NULL), uname;
+					NULL), uname;
 	     idx++) {
 		images.verify = CONFIG_IS_ENABLED(FIT_SIGNATURE);
 
-		ret = fit_image_load(&images, virt_to_phys((void *)header),
-				     &uname, &fit_uname_config,
-				     IH_ARCH_DEFAULT, IH_TYPE_LOADABLE, -1,
-				     FIT_LOAD_OPTIONAL_NON_ZERO,
-				     &img_data, &img_len);
-		if (ret < 0)
-			return ret;
+		noffset = fit_image_load(&images, virt_to_phys((void *)header),
+					 &uname, &fit_uname_config,
+					 IH_ARCH_DEFAULT, IH_TYPE_LOADABLE, -1,
+					 FIT_LOAD_OPTIONAL_NON_ZERO,
+					 &img_data, &img_len);
+		if (noffset < 0)
+			return noffset;
+
+		/* Record our loadables into the FDT */
+		if (spl_image->fdt_addr) {
+			ulong entry_addr = -1;
+
+			fit_image_get_entry((const void *)header, noffset, &entry_addr);
+			debug(PHASE_PROMPT "record_loadable: %s entry addr: 0x%lx\n",
+			      uname, entry_addr);
+
+			/* Try to make space, so we can inject details on the loadable */
+			ret = fdt_increase_size(spl_image->fdt_addr, 256);
+			if (ret < 0) {
+				debug(PHASE_PROMPT "record_loadable: couldn't increase space " \
+				      "for fdt: %d\n", ret);
+				continue;
+			}
+
+			ret = fdt_record_loadable(spl_image->fdt_addr, idx, uname,
+						  img_data, img_len, entry_addr,
+						  fdt_getprop((const void *)header, noffset, FIT_TYPE_PROP, NULL),
+						  fdt_getprop((const void *)header, noffset, FIT_OS_PROP, NULL),
+						  fdt_getprop((const void *)header, noffset, FIT_ARCH_PROP, NULL));
+			if (ret < 0)
+				debug(PHASE_PROMPT "record_loadable: couldn't " \
+				      "record loadable: %s\n", uname);
+		}
 	}
 	spl_image->flags |= SPL_FIT_FOUND;
 

-- 
2.52.0

