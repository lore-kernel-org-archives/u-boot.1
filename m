Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000B3C5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D395B8397F;
	Wed, 28 May 2025 10:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kONJFQYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A675E83984; Wed, 28 May 2025 10:25:58 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F1EE8397D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3dc9e3bd2e3so12825815ab.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420755; x=1749025555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ziww9AwVKyj3X81aLjtFRLEchzmGpEe3nJbEamArpgs=;
 b=kONJFQYG4r2LK9GQDo/RfZCsFimL8JGw7shazIKuvHd4370HI8W2DdgY/pH4hk+4+5
 Nwqaf/VCP8McEtgAfgs0DoDvTsYb3pOSM6zwSZtDtCMu43DcCbArfz6x0XBLWb7nfI+x
 xkC407APvcx51vRVK+LESyo6alffoJ46Axyig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420755; x=1749025555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ziww9AwVKyj3X81aLjtFRLEchzmGpEe3nJbEamArpgs=;
 b=hupyusxiWywHho8Vpe+q2hioc6cAOwvCbe0mf2+GB55BXcD3L63WuUvRHXsJrXUuac
 1HU6BHhw+P7Ir2nqYFlrCyfukK9P27jvYMrQ9QyH87xQsgmH7Mp50cIzk9kd55Rc/dHk
 dDyiOMf9b7yJjK/P26nIYdmqIVVPpxOYRgt552ToDw88O9NjckVMjfWCNDoH3FcVFNnV
 dSq3dRjsylAGVJxkn+pY+Kj6mJD0iYwk7qXyvoT5yjvlnCtkPnNdJ+CC/wvGNos6ISe7
 rb4Qje1BjqqucdunaRSUA9MkRKvlSkAKuOsINNSTrV4C/jMIbbxsoSOajb+sCRJk7Npe
 1Kvg==
X-Gm-Message-State: AOJu0YyOjIPaFmHIJHPjvqgF6vxIFeMO+Qpl0xvzPj841z2PJa9zkneZ
 mOA5Xs/RDvesqUZkbRaEVq06RAAKAoD1zgaWcWIiis6XDuftSvzabDMGHG9pUywilsmOlOfcdgE
 GFgz89pxv
X-Gm-Gg: ASbGncsV1c2+aSYehtcu98M2pbcBlBP0l5GdZPiq5Kpz2ANR4M0AcSYnKKWy5HLT3C7
 Uq4KIYQTmKrNgKGXiu0KNrhI35B6bqWRDkFmlXKIKOoPL1GepA9HyBURzGbE5y2ahufr++63Tr8
 MHu+fuLkUynPeiS3WcY5i8R8hI09/vxHeRepte3orf4AqAMoCy3cHUpMsPDEtkZso64/WBvMycs
 2u3PyaBzMnye5mBmKDBvg84K3GXM5oiM050Z6Sie+AdfwKNhmbPnB/IdR3OdaMHBBsofOfGQQ+x
 RByBRgoF0EJ1kiSUSiPaBppIRKpA0IyUWQrIe8qFtBki2CKhPw689bTUZXHbEtohcI1iXUZYuUy
 ccqKO2BWGXn5Q
X-Google-Smtp-Source: AGHT+IFiwjuEbxsUqExAjwdMPIFPP0PU4Zt+BvC3m+QqCKp3QD0jfSoI0O9O0b/vtWvMpXPDmgL6eg==
X-Received: by 2002:a05:6e02:2589:b0:3dc:804b:2e74 with SMTP id
 e9e14a558f8ab-3dc9b706a1fmr125694925ab.19.1748420754578; 
 Wed, 28 May 2025 01:25:54 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:25:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/27] scripts: Update build-efi to support passing a root disk
Date: Wed, 28 May 2025 02:24:32 -0600
Message-ID: <20250528082520.152391-7-sjg@chromium.org>
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

Add a -d option to specify a root disk to boot with.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-efi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/build-efi b/scripts/build-efi
index 4eb3a76d1a2..5a6eef450d4 100755
--- a/scripts/build-efi
+++ b/scripts/build-efi
@@ -42,6 +42,8 @@ def parse_args():
                         help='Run on ARM architecture')
     parser.add_argument('-B', '--no-build', action='store_true',
                         help="Don't build (an existing build must be present")
+    parser.add_argument('-d', '--disk',
+                        help='Root disk image file to use with QEMU')
     parser.add_argument(
         '-k', '--kvm', action='store_true',
         help='Use KVM (Kernel-based Virtual Machine) for acceleration')
@@ -142,10 +144,19 @@ class BuildEfi:
                     '-drive',
                     f'if=virtio,file={os_path},format=raw,id=hd0,readonly=on'])
 
+        img_fname = Path(self.args.disk) if self.args.disk else None
+        if img_fname:
+            if img_fname.exists():
+                extra.extend([
+                    '-drive',
+                    f'if=virtio,file={img_fname},format=raw,id=hd1'])
+            else:
+                tout.warning(f"Disk image '{img_fname}' not found")
+
         print(f'Running {qemu}{serial_msg}')
 
         # Use 512MB since U-Boot EFI likes to have 256MB to play with
-        if self.args.os:
+        if self.args.os or self.args.disk:
             mem = '4G'
             extra.extend(['-smp', '4'])
         else:
-- 
2.43.0

