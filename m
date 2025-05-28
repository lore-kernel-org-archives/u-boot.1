Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0014DC5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507D68399D;
	Wed, 28 May 2025 10:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iwkN5A/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 974D68399B; Wed, 28 May 2025 10:26:14 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B95B18399D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4768f90bf36so35813251cf.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420770; x=1749025570; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iysfxWhIkWbi9PqdLZDdfZFnWZOujV9D2sfDZ4Y4h8o=;
 b=iwkN5A/RPYMdZZjh6m3ebn1LgfT5T6M/TgmmWXffjixWbe1YliWPYqIGhdzVNQnuf3
 OhDUyOQ75EiRwH2MY0ZQiSyCx9V5DTV+fd2AS4o+98Gw4Stdlewtov3t1eozBSdwRN26
 gnfBmiwWbo2+XFA3oZkQP7HMYjG9XiRDK7NO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420770; x=1749025570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iysfxWhIkWbi9PqdLZDdfZFnWZOujV9D2sfDZ4Y4h8o=;
 b=H1mgpkOQYZ4+qchPem2ZT0EflOikSVMjFdGGjJuhkoq0dDTMBAur/IYzHCDCRGohWV
 DRPypy4dGDEDzfnTbg420VsKX1OUan23LkA6ok6nZmulsAI4dHPgray+wbzLTgzH7c4A
 1J5EIkSehp9ji+9IzHKfn2EECQ1WrExjC2eTnu+OTzTP/psmNG9aw0vssMFQioL7FSLI
 mv46RCfKKkGsyHlAwQgtfeKUuDkoJLkyOOQcuU2UcyNhNHB87E13N8hseU4n5NJApaL4
 P3GJk+9IpD9ksv+drLryqC6zL6YjcVJFQhCR0ANvT0eqYfHkjaASYJO2xdLwUoHwEovV
 GKYQ==
X-Gm-Message-State: AOJu0Yw2g5emjAiVd6nPKtAQQdO+xKrBYXXq9wh5AcAV1qmamKCBFC94
 Mz3ypvpToY1tRaKHcaGCe9JXrLLU63FEFbT6ClO8eTw7EGqYZ3r/VZjzWzDUhrMW0boqPkfz8l+
 VCaYywAHZ
X-Gm-Gg: ASbGnctjAzXr87zW+rpOP/NFWrBT7DCxIO65cTVvv4COmQNbUw0L5hjuE8AMcdSwB11
 3ECwz7tXV4D0IbtorQv3E9BVb9kDpvuVfbGSI5GvdBUAamXKeJaKH5OCy4ji5AG8wGlHgShefdM
 lRtPm6mMhZivOpFFBiXjvcPMTcH+Nju+SHkQVCL0N+Us2qreKO72xXeXqh1xTPOmBs19gSIDuOI
 8Ag93eEuAGtnx18AXY1F3C2PYey00B2es7XskBfAxWXgw4tOAaPhdVZi5heu++8RIUvt7AHZdNd
 85tSHABHtCVYgaGWQ0Ne+y1VvMNjcYi4VYvgVIN9Enesa8xLnq0TonwJ9YwNO1MlGQOfPuXYhwD
 qGtA3soe84E6A
X-Google-Smtp-Source: AGHT+IFnAfJWfITMth1ErK3CfwAHnDgx2mMVsTW31oX3+MWRK4W+iWmHrtjE4KFCSOcLUE6bUZvm1Q==
X-Received: by 2002:a05:6e02:2387:b0:3d9:2aa3:fe2e with SMTP id
 e9e14a558f8ab-3dc9b6a6792mr136954215ab.10.1748420759309; 
 Wed, 28 May 2025 01:25:59 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:25:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/27] scripts: Update build-efi to allow firmware settings
Date: Wed, 28 May 2025 02:24:34 -0600
Message-ID: <20250528082520.152391-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

At present the -bios option is used to specify the firmware, but this does
not allow settings to be adjusted.

Use the pflash method instead, with a separate variables file, so that
settings can be changed.

Add a -g option to tell QEMU to stop and wait for gdb to connect.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-efi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/build-efi b/scripts/build-efi
index 33702953c32..b1a6fc8755e 100755
--- a/scripts/build-efi
+++ b/scripts/build-efi
@@ -113,13 +113,18 @@ class BuildEfi:
         else:  # x86
             if bitness == 64:
                 qemu_arch = 'x86_64'
-                bios = 'OVMF-pure-efi.x64.fd'
+                bios = 'OVMF_CODE_4M.fd'
                 os_arch = 'amd64'
             else:
                 qemu_arch = 'i386'
                 bios = 'OVMF-pure-efi.i386.fd'
                 os_arch = 'i386'
-            extra += ['-bios', os.path.join(efi_dir, bios)]
+            bios = os.path.join(efi_dir, bios)
+            var_store = os.path.join(efi_dir, 'OVMF_VARS_4M.fd')
+            extra += [
+                '-drive', f'if=pflash,format=raw,file={bios},readonly=on',
+                '-drive', f'if=pflash,format=raw,file={var_store}'
+                ]
             extra += ['-drive', f'id=disk,file={self.img},if=none,format=raw']
             extra += ['-device', 'ahci,id=ahci']
             extra += ['-device', 'ide-hd,drive=disk,bus=ahci.0']
-- 
2.43.0

