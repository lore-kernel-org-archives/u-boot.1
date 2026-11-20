Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664D606A337
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cNQ6UCCw;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ZvFw3cJc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63FCD60E90;
	Fri, 20 Nov 2026 13:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Auar3haqX8vp; Fri, 20 Nov 2026 13:21:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 312DD60E61
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180906;
	b=ASJcm/Pqt8tYO2psW7JhO+fHt9ZxVCs78j69IWiJTpawtZxwcLO3ZAJsVPcdv/k0Vl9B
	 WRoXXqZYgPMaE9BGTDbbbWnT9WfVz0Z+9ECBh2QkOCDkuyxjTgKWL/WMBG6Tp8GrMtEQd
	 6lWasvbKJX8q72d3ra47Pxi0xb+YWWKUqcBpwk/diSSP6tv/C8yY43C1NBMkE6ilcHxZh
	 bhaEthz24VeaWdA4faOwKxocI5suFAjjvtGv+7ItKvgSW8oXsgUyHHt72h/eaprCrfVeF
	 aX/ZtnTww5CxC09g6PO/pqxNl3riOMVbgX4RwMXpjgOSVTmNcqvTfGUGvWUNb9z5mLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180906;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BF7cQQ5H6yatCwAkfYs7jH2NY7ERLXSSarmL04k1LOQ=;
	b=stlKCs5vTC2EMiPEMGkBShO7QLD3E48OqMSTKwdCVbBLEyBoUH2v6pOtvhH2zmCdVIlP
	 kAr99UrqLWnXJBiE059bPXoVltYu4hpglhCQ43eejBPt1sFGJMCniAcbKWPCX+rn1H7nc
	 aalBhxXwP6JoFJUzKNPmMsUO/JEJDimLdUZZEQU+hrcJZDjIceqnZmDIocCBU4TzHN78u
	 wo9yndeQ7BaT3doBvCK0CHL/RIVawEpUrYHiGBnhrWABIHbg8T/q088paSHROzEeg7XKj
	 sfi5zxgvIU1iVv5DuYMJfdMQLKGFXoPgkbAdKYvp0RnT7DH4d2G1ZQvBVjTT5Wvoi7A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180906;
	bh=BF7cQQ5H6yatCwAkfYs7jH2NY7ERLXSSarmL04k1LOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cNQ6UCCwNWkJa6P0uGlAcucHqWjzYiDcf2HUZiu3HRheQp7DJ3ldad+HMm/SY27pB
	 VslAQtL4x0acKBJ+HgOVwVwG5e2kKgMF1GG/i0EjW5GjK7r9rzbO71KRwQgk3uBbTJ
	 co6IrJdHWHBuOn5ZcWO33wWNodtIBgdnGSBNKO3sHBFompT4eGsFQY4YrUXRMDyXql
	 FJ5sehwtjbyevVolLgAf1w4JyOWl9j+/MMzLKrwvAikBhyhprVusN1i+XpbvO3KfDs
	 36s9nX5z6epfyQvmh/QxufH1ccNVwq7tiNWiqwUocu3t8T4xJsBTC10YtE0ChVONZG
	 w448R6yb72GKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 312DD60E61;
	Fri, 20 Nov 2026 13:21:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E7A8A1E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D958E40A30
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:11:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fefYVeW1tRJV for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 13:11:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2529F40208
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=ZvFw3cJc
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2529F40208
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:11:37 +0000 (UTC)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9DF123F6ED
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795180295;
 bh=BF7cQQ5H6yatCwAkfYs7jH2NY7ERLXSSarmL04k1LOQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ZvFw3cJcrcLvlzwiBvlY9M4NBHYhxW6j89vzmY1H8RipCz1XYw9gBNJvu2WO9eew8
 1QzSlXzxqX8gOUV0Uw+D3sgsC4l5BQk2kffpXUJfETxrZvGSqjAQzR5xGrkdxfXmyb
 Zz9bOzRAZ47z/cAkScz3G11L6cfWXLOKv99HjNSZHcwR5bsW/EQFg4MNIGL1jbQV2+
 pMKcLFwP7pX6PXlKIpXWYaEZaWV/EWHjEeJ6NnZ87chkYXSbMitCNNYcC2sbxIo4yf
 AFFlSEQe5P8hciY6QpTfMbhiuXysfKXdQ0l0F7giL8E5RR9KCZyUwb2ixhsOS0HBFl
 guykpv3vp6vB9BQlZy5MP/WM4d7lfHjaApls+OZmng8mPTSePrm3IoFSM21ZGPgjMG
 qgTQGhtQCKyPW8h6bx5OiofdnNp4WLbDeWwlKPzWdZvzNtHdiGcN57Ehn/D+1Fqu5F
 iiTxtaCiMyDrEKN9bKnXEMDoDjwgjZ/5svmxVBHqEzgRvEjWnOYciheaoXFbDbSGz4
 dELTpwxLWUlHLYJhDAkRH9YPTguq1skRpha7EzbTZAffn3tVYmd2eg98rF6Lzdbb70
 +vjlR7Kk2K1ZnCqF1bOOHerKkCqEyM3N3YNulKJHSyZcfYMEa7jsuPYHIQuHtfJEDV
 90xIQeLwrDeN5Hy+vR6I9Eoo=
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cdacb64970bso613280a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 05:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795180294; x=1795785094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BF7cQQ5H6yatCwAkfYs7jH2NY7ERLXSSarmL04k1LOQ=;
 b=yXae4sogct13OMl4SFGbsAYWFAgqzzuzC9GXjP/28jLqGdG6EGQSzIUw6vKzOlmCIB
 dgftCRBoUERDXb9NAXQqdB3yqCOODqv/55jsqYOtPN9WBHFIyxSuClIbxQkfv0r/xZW0
 tTwdemmRwQJDcPsIWTK3wFLVSmwSnsymn1FMBzCmDwn+KtVX1HOetnTIfxy7+8rhJbPV
 Ci4KHmyPh0K/kIZ4lPy8EZh9raMYxHHW4oKqV/NadYEETW+q6LYMvcA7xi8wXGYSV2er
 hIILK90xo6YpT9HjucYkEksc5hhCNMD3/LTXplEVDIgo5ONG4Qbz9rLGJr25JcWxsrue
 PD2A==
X-Gm-Message-State: APuU4Z9huCYu+GyFujn0Gt9ibEfuwYzp25ohmh3PuG6G3R22suHnuCml
 085wm2yrTIRmUVo4eCjEi7MzOZmubZbdNJlWOWxmAXC/ho57kncUKf+Noh63vH5rqNNy6j8jtI0
 7eowBYX9OZJiXqwigE+x7HN2OZMrE9sgsM3cvDFO3uT4I+oXThw9RY4RiZlk+BSb0G6PTR97BMh
 F6r/hEdjnxDQZ2KsSesVLM
X-Gm-Gg: AYBFou2uy+/Nw3T4jsi+LVoV/SUdGRk9hh8YAJlZQsBc15Ih5VwOi30796lcQMVnUI1
 iRHSvRkTeyI5EYp0XPrFa/oaho28Y4ANYtNFXDfRAdPNyMSHH9pGf2z9Hjcm+GNaoPIhGG64vjV
 YHaGSguiw2zyM8SinfyAyRf1VKULlzECeXZLAvSbcqchQ9cCtUo+NmHLc3cjLNT4ANCK0lOacEE
 CSKnKhSi7HME94+xp2BlbJMKSdCH+lPhxMfCt6bpo6q/vEPMB3MZ4CUrOlyJi0rBmlnzx7o8kKZ
 cd9u5CLiBMRpcyCZv/f3a9J+RJCW41N7mA6kk9dU1h7y/SDmfElQhRc46r1q+ENexeSEoiKTr2v
 xkbYbNp3E59HOKBDnd/uaxZrJ8M1Sy6X+u1JjD6OzzyzeZuVQa1jwQQLf8D8jmeRNKTtJvtNyS1
 XlPIUbQ1EWFPg2I/pRxEqGhktFKbVxOZiVnYZTMSKsHXs=
X-Received: by 2002:a05:6a21:7704:b0:400:6229:d6b4 with SMTP id
 adf61e73a8af0-4014dd61d2fmr2414094637.73.1795180293791; 
 Fri, 20 Nov 2026 05:11:33 -0800 (PST)
X-Received: by 2002:a05:6a21:7704:b0:400:6229:d6b4 with SMTP id
 adf61e73a8af0-4014dd61d2fmr2414070637.73.1795180293283; 
 Fri, 20 Nov 2026 05:11:33 -0800 (PST)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6d028a54sm1191896a12.18.2026.11.20.05.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 05:11:32 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/2] boot: fit: bound the external data size on the
 imagemap storage path
Date: Fri, 20 Nov 2026 13:11:06 +0000
Message-ID: <20261120131113.1044702-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115143134.25791-1-aristo.chen@canonical.com>
References: <20261115143134.25791-1-aristo.chen@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
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
reject it.

Patch 1 checks the size before such a direct read: an image whose
data-size is larger than the memory that LMB reports as free at the
load address is rejected with -EFBIG and a message. This is the check
that Daniel proposed in his review of v1 [2]. It replaces the
CONFIG_SYS_BOOTM_LEN ceiling of v1, which had nothing to do with the
destination and limited the size of every sub-image on this path. The
other branch, where imagemap_map() allocates the buffer from LMB at the
requested size, is no longer touched, and neither is Kconfig.

The commit message of patch 1 spells out what stays open:

- Free memory behind the real payload can still be written before the
  hash check rejects the image.
- The destination of a direct read is not reserved in LMB, so a
  sub-image that was read directly is not protected from a later one.
- lmb_get_free_size() stops at every used region. A valid image is
  refused when the load address of a sub-image is still recorded as
  used after an earlier load in the same session.
- The helper has two more edge cases, with more than one RAM bank and
  with a reservation that ends at 4 GiB on a 32-bit phys_addr_t.

The numbers behind the last two points are in [3].

Patch 2 adds two sandbox unit tests to test/boot/imagemap.c. Both build
a FIT with one external-data ramdisk that has a load address and load it
through a mock imagemap device with verification on. In the first the
data-size is 1 GiB; it checks that fit_image_load() returns -EFBIG and
that the mock reader was never entered. Without patch 1 the read is
attempted and the test fails with -EIO. The second checks that a valid
ramdisk is still read straight to its load address. The tests are
skipped when FIT is disabled, since IMAGEMAP does not depend on it.

No in-tree boot flow hands an imagemap device to bootm yet:
imagemap_create() is only called from the unit tests and
bootm_info_set_imagemap() has no caller, so the new check does not
change any in-tree boot flow.

This version no longer covers one case that v1 happened to reject: a
data-size close to 4 GiB makes the size arithmetic in imagemap_map()
wrap when ulong or phys_size_t is 32 bits wide. For that case the
series leaves the behaviour of current main unchanged. Daniel has said
in [2] that he will fix it in imagemap_map() itself.

Verified on sandbox: each commit builds, and the imagemap and bootm unit
test suites pass with the series applied (16 and 7 tests). The series
also builds with FIT disabled, where the new tests are reported as
skipped, and boot/image-fit.c compiles with the boot commands and the
legacy image formats disabled, the configuration that needed the
Kconfig change in v1.

The series is based on current main and does not conflict with the
imagemap series in [4]: the two apply in either order, and the test
suites pass with both applied.

Link: https://lore.kernel.org/u-boot/20261109221650.GA3741582@bill-the-cat/ [1]
Link: https://lore.kernel.org/u-boot/20261115205059.62cd55fdb132@makrotopia.org/ [2]
Link: https://lore.kernel.org/u-boot/CAA=k7=keU0TbGea8vV7Ht9ziL50YZ=tufUrnXDcQOYahJ7tV3Q@mail.gmail.com/ [3]
Link: https://lore.kernel.org/u-boot/cover.1794614777.git.daniel@makrotopia.org/ [4]

Link to v1:
https://lore.kernel.org/r/20261115143134.25791-1-aristo.chen@canonical.com

Changes in v2:
- Patch 1: bound only the direct read, by the free memory that LMB
  reports at the load address, instead of bounding every read by
  CONFIG_SYS_BOOTM_LEN; no Kconfig change any more (Daniel)
- Patch 1: describe the limits of lmb_get_free_size() in the commit
  message
- Patch 2: add a test that a valid ramdisk with a load address is still
  read straight to it; the comments of the existing test no longer
  refer to CONFIG_SYS_BOOTM_LEN; new subject
- Rebased on current main

Aristo Chen (2):
  boot: fit: bound the external data size on the imagemap storage path
  test: boot: imagemap: check the data-size bound on a direct read

 boot/image-fit.c     |  17 ++++
 test/boot/imagemap.c | 205 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)

-- 
2.43.0

