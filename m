Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C831D16261
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 032B989066;
	Mon, 14 Oct 2024 15:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IYe+4xOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 852C388F8E; Mon, 14 Oct 2024 14:17:34 +0200 (CEST)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C65988936
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aibaykaro@gmail.com
Received: by mail-yb1-xb41.google.com with SMTP id
 3f1490d57ef6-e291f1d659aso2172576276.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728908251; x=1729513051; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IP7DT9Js2u6FmG+QYDlcgzF/cm4H6bmp1qf8qWiU+M0=;
 b=IYe+4xObN1HCMTda1C2SgFo0AT6SHl9Giz9bTWWSNp/Itjar6CajhK6xjR1gBm6pyC
 DNMPaB7+gSvK3NsMYF1YOpkVGgUTqcvNOlKCJ8uFGKPOfvCFbCucCwbrZQSRBtrkHPl8
 P6IODXPH3V0iHwIsbBuAINW2E60zowNcQh1i4dq0YEJ18LKRCwaP24qWdkuKmmppGcj+
 L64jO1dx7uZNJVCeuJJD7YMZYbc58nzLGwOQliAeSXM1gLcq542tmvOCvkldO3qZtxxk
 u1I+z3bK6XOBvetZsOWePoORF1B/KRzdSraLtRTUdsOiqUhWNZz1JbacEWEc0WR6LELo
 5vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728908251; x=1729513051;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IP7DT9Js2u6FmG+QYDlcgzF/cm4H6bmp1qf8qWiU+M0=;
 b=b2Mva0L4a4Uf5O/xKg+7DZEE1nBxcvPTdG16BNJZiEBkbQfpgp3KRUd7GCNprNfTpI
 W8L51d3c0SXskHOzeNNorZznM8S366sBJX0AIps9xFrtLAfmrR1sUG+dhZQ1UkDO+x6w
 m2BaKm5QT2EBvUlDaRFRTC3RWAerERyC1WEov6Cs14Ofz1FkuKuEq4efmIYtP2cdnkio
 LLB0CgPHPcZPgnQoNB+cOEpCBc/Y9ISj76XPStlEEVs9lZCX9Qe7JEckPuZ+IyqlKUhW
 Kw69SIiOp0a45GTSlHViDfgxf/+4+52KtG7BEeWRZPcEDJSLiSImDYPDTU4ry90S/Vek
 D8IQ==
X-Gm-Message-State: AOJu0YxrbhDH/UAAEY+nVeclvWE0U+e5vxB2zVeWKFl3ilugdbEsU3ja
 CsiPE4OEm8XnBQM9NPbQBWaVTfx4lC/2+wrDd1Wtl8NwtmPogoqAFNO5hb9+VLTrmckxoylm5bg
 y5SaFudVewywVAN4v9mg8RXei9z12SK5rfnA=
X-Google-Smtp-Source: AGHT+IFiUg4jwb51ryfWho8dEfcbIyNSuxcRzm63ZA7UjgmCAJKLz1BkcpY5llRRavpuNlY2eI/SfvaliMWvRmvsbns=
X-Received: by 2002:a05:6902:1b81:b0:e20:2789:80ae with SMTP id
 3f1490d57ef6-e2931b157c2mr4582475276.10.1728908251112; Mon, 14 Oct 2024
 05:17:31 -0700 (PDT)
MIME-Version: 1.0
From: Osman <aibaykaro@gmail.com>
Date: Mon, 14 Oct 2024 15:17:20 +0300
Message-ID: <CAMhyRsAMfYeMKVjGRLHM3DFymHxnxVO0YNM_2G=CYvGmTJoYNw@mail.gmail.com>
Subject: ll_entry_count returns 0 even though the linker list has 5 entries
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 14 Oct 2024 15:03:22 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello,
After enabling CONFIG_FIT in defconfig the u-boot-spl becomes unable to
detect the root_driver in function lists_driver_lookup_name(). The spl
executes without issues when manually changing the n_ents variable to 5
while debugging so i am guessing the ll_entry_count() function somehow
returns the wrong value but i am not sure why. For reference this is the
section in u-boot-spl.map file that contains the "root_driver":

 __u_boot_list_2_driver_1
                0x0000000080009b78        0x0 drivers/core/root.o
 __u_boot_list_2_driver_2_root_driver
                0x0000000080009c68       0x78 drivers/core/root.o
                0x0000000080009c68
 _u_boot_list_2_driver_2_root_driver
__u_boot_list_2_driver_3
                0x0000000080009dd0        0x0 drivers/core/root.o

(gdb) x /8xw 0x0000000080009c68
0x80009c68 <_u_boot_list_2_driver_2_root_driver>: 0x800091a0 0x00000000
0x00000000 0x00000000

By manually calculating (end-start)/size from the symbol addresses of the
.map file i found the correct value to be 5 but ll_entry_count returns 0
while the function lists_driver_lookup_name executes:

(gdb) s
27 const int n_ents = ll_entry_count(struct driver, driver);
(gdb) s
30 for (entry = drv; entry != drv + n_ents; entry++) {
(gdb) info locals
drv = 0x80009b78 <_u_boot_list_2_driver_2_cpu_bus>
n_ents = 0
entry = 0x80009b78 <_u_boot_list_2_driver_2_cpu_bus>(gdb) frame#0
 lists_driver_lookup_name (name=0x800091a0 "root_driver")

 I am not sure whats causing this but disabling CONFIG_FIT in my defconfig
causes the program to execute without issues again. Could someone point out
what i am missing here?

 Regards,

Osman
