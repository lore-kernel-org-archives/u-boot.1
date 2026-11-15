Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C2606A31A
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J2mXZsvq;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=taEFpJad
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC18B60762;
	Sun, 15 Nov 2026 16:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W88ZS0hfgxd6; Sun, 15 Nov 2026 16:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F183A606C6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794758567;
	b=M+CwAjOkDZGMq7CC6NCEiyEhev8BpB1xviIFi/gw6yX/nciMkM0cxRpJ8LnIyI34yS0d
	 /kHePajDdIsSywYpo7eDQJdi1l9t0CXjJie4kJ7EvZWGPa5kFXxr3ZWghewE94nFfq8oU
	 R4mR63Ov/QoCM21rVY/CEopERO9jpxpW/PEG/bKcl/4fQLBePKlu9zid/kuBf/+SsK/bx
	 dKiJkhFlhAlvCU04v7f49zKVWpRFRH+CVIormHynSb0cWBxcXdH7FCPed0Hj6U7EOHDir
	 8BhndbQLe4Idv0JSM+faHIaL0z2Di+MaXal5wqkgFq8ch1FqVHt5omaxoozftUNSKEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794758567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O4XkGcf9gEV3KOt6f31Ayo+1HYjdH+fiEox0RhkyO60=;
	b=ZkgyxhVfAWGaK8AnK+Q+aidy+SHRzZ8req4JTiTkVGPDKFz/uy4i8xl+tbtH3OUYHUSK
	 Z+zFNfg4gURW4oj7s+HcB5aHbTtfPNcru4bIyOtvn5o+US46hF/c6bCUQ/X/H2SA9O0A2
	 kwElscfbvHabBKm6EKQ5VLM7nRjtYL5bQBmA87QwNS5rVVWEzKJ6hVFk569/R3Ksr6Ic3
	 5ksPwGrlnWZqFP4lnE+Fa1iLrzVKMGY7RaTuF3DKYIR2JBAyvpI/D51nnkmuAk9/PQDSG
	 rlSLAKPFMKYWrP4e3Dj7uoY/b0jeYJ8ngtBvesDVBmL7pXWjOGj/sdYabHA1hnyT77w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794758567;
	bh=O4XkGcf9gEV3KOt6f31Ayo+1HYjdH+fiEox0RhkyO60=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J2mXZsvqjBzj9ag8UF6mFXklCAU9bMUzwmOR78zjHhX1vKw3Sbsnqt/CjUtlyR4rP
	 rMSdUShQHAH0IyFXdN6qQa3Xg8sGw2zJ/D/FXqYYNP7rt/hrng+f2/KURF5RdT5N5a
	 gRrza5XKEkHkES557eif8Iy4hB9L0MaUL5ubheXKrGsTmx+842OgfMvOuVy3Oh5wI/
	 Jzr1V+QzOi7ZTdZ66wfQoS2GHVb64Fvf/29LjEuCFX8EPvCKIt/Ioca1Jn77dKTW3i
	 2HFiE49F3Kt6eiXri3oVu6iaTZ4tFbYrZ2SkE74sRgFi8mRsLdyow+fuJQonpNnKpK
	 6M2p1Rea2qpOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F183A606C6;
	Sun, 15 Nov 2026 16:02:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 96A86109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74B9A40061
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:31:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yPD7pqzw5wNZ for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 14:31:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B293340050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=taEFpJad
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B293340050
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:31:56 +0000 (UTC)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 096E63F185
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794753114;
 bh=O4XkGcf9gEV3KOt6f31Ayo+1HYjdH+fiEox0RhkyO60=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=taEFpJadaHkMw04MVTZdi//9R7ZKVNSO9Fn3gZrlmucPNsWaerb+seR93PJTsrrTT
 cPXBOsWDtWRGzZZgS8G5V1oq63Q7iWt9xsuNjrq/FdI+eTME5cpsDnQTLy23xl3YVR
 Vc1khoSEdGTc+QGAWk+JxI+9J4nJM1HZwjNVe4hJLnoaLaUXlzNexjvYHzVyCFMxrn
 EioxE+0LyLQaAqJQFzPuvTp1H1tjr82btA0IQb7/U8BUjo3MxwbgJ7lEowfAAfWjCl
 J96bhSNwk9c2NF3Xu+nHVzzZhKu66/Vuz2tVqhJMdU7fSkxuyya/Mz4FSmDOX1Opel
 ZcMdzaVP9519xkOyl0GkV63dJl2uyBkxLTnfG7M3uKait+dG51+bXlFoN7p+Xor1ur
 JGpyoNhGlMXItt1B9t/dtfBisJ/q/tCEdOrNVZqFgZOmeTrEE3rIV86iji7SZO3V6B
 BSlFlsclrSuYSDVG8LoNLdh2cxyCXnHClK6W0+963G2IGJXGXpgCoP7uWruCnTVhJ0
 9p4SadSjRh1+Nz7/6AFqNWwCGjjIKKfq7HFQT2gSzRnt3gdyEfLR7lffUUvDhP4QzH
 wbArS3wIKz116IbJWVWZoNOHKzt1m9me7ehLa4zUFJqN3UPNnHJO2sm+Q2JU7BnJIq
 73JAOTK3HsTvOIRT4gyvZyMc=
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd66551e02cso2993288a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794753112; x=1795357912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O4XkGcf9gEV3KOt6f31Ayo+1HYjdH+fiEox0RhkyO60=;
 b=sdhapRPG1ZShtfpU3qQorchJMO1vPfacOGg/8k3gsbjuxGKvQfk58fk/MLP0fEA2UB
 H2vGZYmXRSHGGdR9K4jUORMhYFjHhx3hoCM12bFNvECHeChCrLQFgVOFWXipLUt9W++t
 F9mTyN6lukTM7zK2SltUFfWdl30W1PEHclw/Oen21ROCeSfhAd+D1j1Nw4lENoE/w8G/
 qIWkUBqeGLCpW8nVqXO7/3v6luurCUAjZH2hTK/DI21mFgbqYQrDJWp176I6Xwi4aag4
 XFNdx0qtidWP1kmYoXTZItuenDJtY+2bmolJa744R5hzvsWzGEksHlQiBLXx9YdT8gZe
 h1EQ==
X-Gm-Message-State: APuU4Z9AEa5/ASzWOjABeQ4RKcPXVn+XISQiJ8sVyeXoQ9oQQsKRzijc
 9dWIx/FWAUnKzgbLpAKANpUuKVHsU04xQdTIjOJZ2k9AODNO8f5uFjwgk279bCN7bh51XaaVTdL
 yQJzxD3LYX4bjuE3BGyejPXsNb8/Lx8uVaZAnsUA9lmPJnso+ZtxsaJy/NomrenRazsL4jqtwhG
 OCYfj4XDMujz2dD2br5Q==
X-Gm-Gg: AYBFou0oo9SRyIeN7hZazjWquVlGUWh2cgGI8eRV0ZCKXO3KoUmX2QjFbE7p3pk1x6n
 6n197ED4STsA4XdzRNvaoHSM1V8WnBmq6LhmtYuDrc/EPlXsphsonjYOOx4fbQjelgfZ3ixsrDC
 ImICqYJaUocn0/05c8plxgYfK3nrbQWxlcivPvzTAMu5r9bhEZ6OTqlXKN8GsKHfSbUCUinXHRa
 IH1bDFVvmD56vY41UG+wAhX0LQtIa6lsPEnUjscPV8fZjQCWylA9kgYAizunlBVOETStsxlLLvN
 VbqeDrVJH+o5v2lEES+Lgwi6WcUDVThJayXKoQR0OJ3nehXMyKUSOPlQ7O368L4UP8A0gDImFk7
 wFvDBa1RH5USM3AO2BYua/0lby/Er58TID/2FoAuBqMgaS7gVAgCVRAHniQZecF/qes1ZY3CB2j
 L7R8aq0diPI9LQRthnjgv8ObnuMV50ejgvMKidhNc61/E=
X-Received: by 2002:a17:90b:390f:b0:3ac:8446:c1b5 with SMTP id
 98e67ed59e1d1-3b1b0a0fdaemr7824129a91.31.1794753111993; 
 Sun, 15 Nov 2026 06:31:51 -0800 (PST)
X-Received: by 2002:a17:90b:390f:b0:3ac:8446:c1b5 with SMTP id
 98e67ed59e1d1-3b1b0a0fdaemr7824104a91.31.1794753111446; 
 Sun, 15 Nov 2026 06:31:51 -0800 (PST)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1bfb607e7sm4297670a91.3.2026.11.15.06.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 06:31:50 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/2] boot: fit: bound the external data size on the
 imagemap storage path
Date: Sun, 15 Nov 2026 14:31:12 +0000
Message-ID: <20261115143134.25791-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 15 Nov 2026 16:02:45 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series bounds a read that the FIT loader sizes from unsigned
metadata on the imagemap storage path. It addresses Coverity CID 661899
from the scan report in [1]. It is partial hardening rather than a
complete fix; what it leaves open is described under patch 1.

fit_image_load_storage() in boot/image-fit.c reads an external-data
sub-image from the storage device with a transfer sized from the FIT
data-size property, and fit_image_load() only checks the image hash
after that, in fit_image_select(). data-size is in the exc_prop[]
exclusion list in boot/image-fit-sig.c, so it is not covered by the
configuration signature and stays under the control of anyone able to
modify the boot medium even when FIT_SIGNATURE is enabled. For an
uncompressed image with a load address that the caller asks to have
loaded (a ramdisk or a loadable, for example, but not the kernel, which
bootm moves later) the read goes straight to that address, so an
inflated value writes past the end of the image before the hash can
reject it. This is the same problem that
commit 8f71d7170f5c ("spl: fit: bound the external data size before
reading it") dealt with in load_simple_fit() for SPL.

Patch 1 rejects a data-size larger than CONFIG_SYS_BOOTM_LEN with
-EFBIG before the read is issued, the ceiling the SPL commit uses for
loads to a memory region, and prints a message that names the option.
Two consequences of that choice are spelled out in the commit message.

The ceiling is not a tight bound on the destination. On such a direct
read, a size inflated to anything at or below it is still written to
the load address, and the hash only rejects the image after that. What
goes away is the much larger overrun, limited until now only by the
32-bit data-size and the end of the partition. Removing the write
before verification altogether would mean not reading to the load
address at all (read to scratch memory, verify, then copy); this series
keeps the direct read and matches the SPL path instead.

The ceiling is also a new limit. On this path CONFIG_SYS_BOOTM_LEN now
applies to every external-data sub-image that is read into RAM, ramdisks
and loadables included, where so far it has only been the default limit
bootm applies when it decompresses or moves the OS image. A filesystem
image that is left on storage for dm-verity is not read and is not
affected.

Patch 1 also makes CONFIG_SYS_BOOTM_LEN available when IMAGEMAP is
enabled, since an IMAGEMAP build with no boot command and no legacy
image format enabled would otherwise not define it, and mentions the
new use in the help text of the option.

Patch 2 adds a sandbox unit test to test/boot/imagemap.c. It builds a
FIT with one external-data ramdisk whose data-size is far beyond the
ceiling, loads it through a mock imagemap device with verification on,
and checks that fit_image_load() returns -EFBIG and that the mock
reader was never entered. Without patch 1 the read is attempted and the
test fails with -EIO. The test is skipped when FIT is disabled, since
IMAGEMAP does not depend on it.

No in-tree boot flow hands an imagemap device to bootm yet:
imagemap_create() is only called from the unit tests and
bootm_info_set_imagemap() has no caller, so the new limit does not
change any in-tree boot flow.

Verified on sandbox: each commit builds, and the imagemap and bootm unit
test suites pass with the series applied (15 and 7 tests). The series
also builds with FIT disabled, where the new test is reported as
skipped. With the boot commands and the legacy image formats disabled,
boot/image-fit.c compiles with the Kconfig change of patch 1 and fails
on the undefined CONFIG_SYS_BOOTM_LEN without it.

The series is based on current main and does not conflict with the
imagemap series in [2]; that series applies on top of this one, and the
two test suites pass with both applied.

Link: https://lore.kernel.org/u-boot/20261109221650.GA3741582@bill-the-cat/ [1]
Link: https://lore.kernel.org/u-boot/cover.1794614777.git.daniel@makrotopia.org/ [2]

Aristo Chen (2):
  boot: fit: bound the external data size on the imagemap storage path
  test: boot: imagemap: reject an oversized data-size

 boot/Kconfig         |   5 +-
 boot/image-fit.c     |  20 +++++++
 test/boot/imagemap.c | 133 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 1 deletion(-)

-- 
2.43.0

