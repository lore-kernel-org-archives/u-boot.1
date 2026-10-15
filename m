Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51145CC6B38
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 18:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCB36810A8;
	Thu, 15 Oct 2026 18:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qz-oWmI4pbeT; Thu, 15 Oct 2026 18:29:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C663681080
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792088981;
	b=GO70YUrP5H8NsDyhkd7QFZy1/6lVX6QtcnIpk7scIrJSzIZbgDHRxFufrnicEE+Lni3E
	 TlS0X1b2KIblFQgP9n9A7qWy0Nppnysmj3j2z6FVUPebjkTsMuAbo5WY23XldHExMGueo
	 ElBwdZFemleh+mQgbbM/8pagtUIhU/bKrpyapzArCD8N4pkfD+QXnWGnXk1mb23A8fZ0P
	 0FIH17z1MJGBro6C9p3sLjli5JqL82wWrYXDDntcC40S5LSfm78/x60CCV98BvERBO9W0
	 5r2ZIw2G1jNBDyA4dAAK1z4H2VwXvl/abUFEn9SRppMZTETiS064PeaKFwtA8k5oXpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792088981;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D1GeowOKMQDHMZjJywFcqSjXsfnD+FGy9FLNOUjVncE=;
	b=ZVdyaBlyqe41ROasRoKFfzUO97i9zrPbgoKnjkOrnY5/RmTSjWwX7C72sNORz1WcHqkH
	 Idd0ZMPPX/ri/Kj/jjQuW7wCgz1/1R4RSAVNLVIqxhX1A7gsQhnyvHV8uB+KrEiGBNylC
	 HmJG9gd1grVbMtJVc4JuOJbiDNeBUAzuZ9uBTYpSGZmYiMfy6MVj4uXrf459D3BNpnzuz
	 c7DB6qCjcXHcsahKeLe1JedJO3cZfTiYxnI40hD7ABgERJocd/dM1sVVmNz3VJyjmyA2r
	 L/a+dw54LEgKLT6PQJMmDbVog8KTmvQv2/7I1TOZ1KTjq0xscBbtI4VB3XNxvlud5Dg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792088981;
	bh=D1GeowOKMQDHMZjJywFcqSjXsfnD+FGy9FLNOUjVncE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zY7sjjfLhhv233KbzOmoVYsCZ50yUqx6mXifn4cyHm0CMy1lsW454nU//sWfEVU+0
	 H+Ix4atyihEdaFQSet98rlOPq0jpcKQ0FTbHUtZ85IJR1tQlhTvhSKScqasZHVRXR1
	 Jlv3s17hruG/J3o0ennw/HjBIBzVy6ZqfAksBmfgMfKZGWIU7kX/pZP5et089MKxES
	 BAQfCZeBbMFxuoR/OJkk+YkJr+jLodQ5Tn6WWuVKKAYJYB9OmKHlfHaKlsq/2sUWmz
	 VWmiowOlUizhBnPDRPHhelcZVVFRM1fhcy2M5pBkWkjQqRD2uqYujHcwUqRanIRUPw
	 0tGmFz0cWyyXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C663681080;
	Thu, 15 Oct 2026 18:29:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 352392E0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 18:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B46040420
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 18:29:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRqyCuTs2C3C for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 18:29:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CF4324006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792088979;
 b=f+MelyNBqwXmmZL9OtG0+oUyf90kxSNlKkO8+1iAFuCzjZQPC6aM5U1vOtrBxTcvqRX6
 k7vlqDp8A6RyH6EmOryPfmWZAvV/oYMNfHOQb/zuf7BbeFaUhlyDJcuP4Sp/aP4n2Y5yp
 nxNTlsyoLg8Gf9Eh2D1LeeJYEA5RC7SwNbNDWW4a0PNA1nd84eKlePBktGXBaisalrPqy
 ApJI5ldSW3C64mLk/I1WqTF1rmdPM7xoVGRwr30II2Hxc1I0PFufU/qwhB2/ukrU0Eest
 /AyByrh1YMll9carbKOoIFdyM/hfIaocX2hyyCr8xMeWU/pV8wuB57ojiR013k7SPsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792088979;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=D1GeowOKMQDHMZjJywFcqSjXsfnD+FGy9FLNOUjVncE=;
 b=d0gwWURkcYjmimrXpyWAWJZjKv2CUbbNkLVUb4ATPtdht3+klGxN+nQy1Bnf6yiNK0OR
 VbQlrMjG+HCZXcuLkhudMjNJ0vaoiljnEg9b27/yiyrzHTmf6t+XbqNxKJEML+6TR4adH
 3spzk6869bU3CWEz3a4RcRsEp6J/OupDCXrCDcLO54xOsBhM7LOKJmZxH3LUyfCaK6XNx
 V/cSQm7KCs/MXmy9OZsfmsnA6+rMzDKh+r/CzQGfEIjvRf2kBfnxQl6Ve8NZEFvta7eRd
 i+9C4etDgEPcO39EY2vIeels1eeNUafN1u8nuU1K4dV01YUVuGBew5nB/tNxBR+MgtA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BNsTZ8I4; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BNsTZ8I4
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF4324006F
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 18:29:37 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1ad2e2391so24845805e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792088975; x=1792693775;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=D1GeowOKMQDHMZjJywFcqSjXsfnD+FGy9FLNOUjVncE=;
 b=BNsTZ8I4U/FpC0OjIq0HL7ZQY8jwmcGCgHGH0o9pbyn7mpUDIB8Q9C4qV2PgxBE/tt
 4sIp/m1kGBHeDvMWZyKukMEzdB5JSDr9R0w+fu2MxAj7e9Cr8ZCMivtk+sSUXSI5YZyT
 izUU4AQ7qeygJI0KOipla1FlzUAaWtS0VtxBqadRX3TgzmESmhyJfUJP7m2l6qYzzblI
 r9l33qIoztXpWYPURoNNxVwZXHuZY4LPBfFrhxurQWNjKRdVXfH4x1ICpK6GVHUF0ltf
 HTe+uz0qYwtfhweXfiUf6J+BG2GxgrnYzH57NbL5qmIbBqpTYg8BGzcCDhTuhN/UCfH1
 kCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792088975; x=1792693775;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=D1GeowOKMQDHMZjJywFcqSjXsfnD+FGy9FLNOUjVncE=;
 b=jgkP9UL+J8dY0ukwsvrCmtMe65AKjJWLOprqEmAiDcGOcInxVQFiRWHS0jn1cgHQ30
 UD8m/JZh7LlHUL27uLt9NYzKz+rqvjay8HEVsQzfsFWMqdt/rv1EPtkf1EhcJ8KI8hKC
 yW1PH2tCzNus1zadV+iQRmWI+swGOkut0wbC5OiQeH/e+RCpDampgKHtOhK3mexwY9nW
 oj4/JOf/h4Jdvm+i68fgQSD1227+uHkG12Uh0z6QC29G2B5nL8+ZjwZKpFAxXD8PxCDY
 HIQsprrYRJqpOhqvuG8zyhjpAHVDFoD/08LCfThU9pMdQ6doSc/qqCrsUaUFoSsIXO7L
 k4RA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnHOitoCtxmN+nrQHqz4bRRaLA6Uc6uUpYuWPp2Hl/nQzzxCu9DF5l9eVJ8FtcK6wDS+iHN1I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK0hhaBF+gkNarqMYdFEqAn4zVD+uV/PFfZOYC04S3iokiYugPZ
 7N+ObY4tbZyv14wMP7vfcRbHC2XWLCqLVzzaCO19i89s2kGpl9VR5xnCKrL+YsMQRfA=
X-Gm-Gg: AYBFou2siXRi2XNljQrNWRlxe6rh8LrnvY0u3H7kiKzvxbYjvSO5SJ53VCO94zCYkdw
 wuRd4MDEC+cD3EYFj6lklWsbkv+d02CBRbXgOlSEDJKLvEfXGUh/V/kjYyaCKIJVo5YrYrQMNdE
 tivQGbXrMMj59Sng2fAe1quDfOqd5T0gPbS0Pt7LSaKuXTpVRqM9vaOnugINUvjLTefiAsOSKmd
 BRfAkDRmB1HXPeatpIixrgmFmWJoCl8nZFCkZy/tGK+0W+9Y4Xvz5rJSxsUDO2CALEO50S9FJ+L
 P/OfY4I85WqVhds30R6uJJ6fD1ZvOdkH2G3fhpVbYcecRbYkyMU4c3u6l+j9q465l+o+QBVKUJx
 p5OfvDQ+YFEMDe84Gn5LdiAFodDSiJ29cngcraMSQyYs/rn9Twerg6wzgtS6ePV66/e6ouovWlb
 flkw6ct6Vt7l4aY51bteypcU1iaM7yY6ACyBVF/ESBj+sJ8Q71Rt4I7//6KMKOoEea2VgJSUwRb
 fdgFEpuE4eqQPbDlEHaUQWlxI0WnGdng9+PCLuEBfWdVyQ4RK9Hs7/k0NYmlvMP
X-Received: by 2002:a05:600c:8a09:20b0:4a1:9687:bbd4 with SMTP id
 5b1f17b1804b1-4a19687bdcamr253151015e9.31.1792088975032; 
 Thu, 15 Oct 2026 11:29:35 -0700 (PDT)
Received: from [127.0.0.1] (host-82-63-151-127.business.telecomitalia.it.
 [82.63.151.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc50e0sm27221269f8f.49.2026.10.15.11.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:29:34 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 15 Oct 2026 20:29:28 +0200
Subject: [PATCH] efi_loader: bootmgr: preserve a passed devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-ccaione-upstream-efi-bootmgr-passed-fdt-v1-1-d0811f40c6e0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywqDQAxFf0WybqgPtKW/UrrIjFFTcEaSsQjiv
 3dsl+dyOHcHYxU2eBQ7KH/EJIYM1aUAP1EYGaXPDHVZd1VZteg9ZYVxXSwp04w8CLoY0zwqLmT
 GPQ59wqHxd3fryqZpCXJt0Sxuv6fn68+2ujf7dOZPw5ExOqXgp3OKKqOEa+AtwXF8AQIy7SupA
 AAA
X-Change-ID: 20261015-ccaione-upstream-efi-bootmgr-passed-fdt-f3c8b760335a
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Scott Moser <smoser@brickies.net>, 
 E Shattow <e@freeshell.de>, Carlo Caione <ccaione@baylibre.com>
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

An FDT explicitly passed to efi_bootmgr_run() is currently replaced by
the FDT referenced by the selected Boot#### load option.

A user running 'bootefi bootmgr <fdt_addr>' should be able to try another
devicetree for a single invocation, for example while debugging, without
editing the stored boot option. Boot#### still selects the EFI executable;
the explicit argument only overrides its devicetree for this invocation.
This is an input-precedence rule, not a distinction between user privilege
levels.

Only consult the load-option FDT when no FDT was passed. Document the
resulting precedence so the explicit call argument remains the
highest-priority source.

Fixes: 39bac24a48bb ("efi_loader: load device-tree specified in boot option")
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
This fix was originally submitted as patch 1 of the EBBR V2 series [1]
and carried forward in V3 [2]. It is now split out for independent review
and merging, with no dependency on the firmware-devicetree work.

An FDT explicitly passed to 'bootefi bootmgr <fdt_addr>' should override
the DT referenced by the selected Boot#### option for that invocation.
The boot option still selects the EFI executable; its stored settings are
not changed.

The C change is unchanged from V2/V3, retaining the Reviewed-by tags from
Ilias and Simon. This standalone version clarifies the commit message,
documents the selection order requested by Heinrich and adds a Fixes tag.

[1] https://lore.kernel.org/all/20260728-ccaione-upstream-ebbr-v2-1-4efb529140d6@baylibre.com/
[2] https://lore.kernel.org/all/20260903-ccaione-upstream-ebbr-v3-1-016658d0b6ba@baylibre.com/
---
 doc/usage/cmd/bootefi.rst    | 29 +++++++++++++++++++++++------
 lib/efi_loader/efi_bootmgr.c | 20 +++++++++++---------
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
index 8b237fd75fb..7cbf28e8b07 100644
--- a/doc/usage/cmd/bootefi.rst
+++ b/doc/usage/cmd/bootefi.rst
@@ -28,9 +28,9 @@ The *bootefi* command is used to launch a UEFI binary which can be any of
 
 An operating system requires a hardware description which can either be
 presented as ACPI table (CONFIG_GENERATE_ACPI_TABLE=y) or as device-tree.
-The load address of the device-tree may be provided as parameter *fdt_addr*. If
-this address is not specified, the bootefi command will try to fall back in
-sequence to:
+The load address of the device-tree may be provided as parameter *fdt_addr*.
+When launching a binary directly without this address, the bootefi command
+will try to fall back in sequence to:
 
 * the device-tree specified by environment variable *fdt_addr*
 * the device-tree specified by environment variable *fdtcontroladdr*
@@ -84,9 +84,10 @@ initrd_size
     Size of the Linux initial RAM disk.
 
 fdt_addr
-    Address of the device-tree or '-'. If no address is specified, the
-    environment variable $fdt_addr is used as first fallback, the address of
-    U-Boot's internal device-tree $fdtcontroladdr as second fallback.
+    Address of the device-tree or '-'. For direct invocation without an
+    address, the environment variable $fdt_addr is used as first fallback,
+    the address of U-Boot's internal device-tree $fdtcontroladdr as second
+    fallback. The boot manager's selection order is described below.
     When using ACPI no device-tree shall be specified.
 
 Note
@@ -109,6 +110,22 @@ option to execute next. If no binary can be loaded via *BootNext* the variable
 The values of these variables can be managed using the U-Boot command
 *efidebug*.
 
+When using a device-tree rather than ACPI, the boot manager selects it in
+the following order, from highest to lowest priority:
+
+1. The address explicitly passed to ``bootefi bootmgr <fdt_addr>``.
+2. The device-tree referenced by the selected *Boot####* load option.
+3. The distro device-tree loaded from the filesystem containing the EFI binary.
+4. The address in the environment variable *fdt_addr*.
+5. The address of U-Boot's internal device-tree in *fdtcontroladdr*.
+
+An explicit address overrides the stored device-tree choice for this
+invocation only. This allows trying an alternative device-tree, for example
+while debugging, without modifying the boot option. *Boot####* still selects
+the EFI binary to execute. If a load-option device-tree is selected but cannot
+be loaded, the boot manager returns an error instead of trying a lower-priority
+source.
+
 UEFI hello world application
 ''''''''''''''''''''''''''''
 
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 8938b214ceb..6b5dad21b06 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1294,9 +1294,9 @@ out:
  * efi_bootmgr_run() - execute EFI boot manager
  * @fdt:	Flat device tree
  *
- * Invoke EFI boot manager and execute a binary depending on
- * boot options. If @fdt is not NULL, it will be passed to
- * the executed binary.
+ * Invoke the EFI boot manager and execute a binary according to its boot
+ * options. The devicetree precedence, from highest to lowest, is an FDT
+ * passed in @fdt, the Boot#### load-option FDT, then the distro/ESP FDT.
  *
  * Return:	status code
  */
@@ -1305,7 +1305,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	efi_handle_t handle;
 	void *load_options;
 	efi_status_t ret;
-	void *fdt_lo, *fdt_distro = NULL;
+	void *fdt_lo = NULL, *fdt_distro = NULL;
 	efi_uintn_t fdt_size;
 
 	/* Initialize EFI drivers */
@@ -1320,11 +1320,13 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	}
 
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
-		ret = load_fdt_from_load_option(&fdt_lo);
-		if (ret != EFI_SUCCESS)
-			return ret;
-		if (fdt_lo)
-			fdt = fdt_lo;
+		if (!fdt) {
+			ret = load_fdt_from_load_option(&fdt_lo);
+			if (ret != EFI_SUCCESS)
+				return ret;
+			if (fdt_lo)
+				fdt = fdt_lo;
+		}
 		if (!fdt) {
 			efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
 			fdt = fdt_distro;

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261015-ccaione-upstream-efi-bootmgr-passed-fdt-f3c8b760335a

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

