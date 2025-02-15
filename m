Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CD8C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 12:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C5880E88;
	Sat, 15 Feb 2025 13:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M93meQyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ABD380EAF; Sat, 15 Feb 2025 13:05:20 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1047E80B98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 13:05:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-abb81285d33so31693866b.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739621117; x=1740225917; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I+QNzH7WRNz9zqppUgmMSkLY3eRm5qONavQ44kBi2O0=;
 b=M93meQyne1GNxJItCNYnU6Cn/atEUzSz292El6WLMxBDGxjl5BxsgiQdnoMI5N7D1l
 D3W8HLS4lX1QQBfTHvsd4OhYyGzeIzlQNsXPYv5qCdKQjyK1fITYp/e6DNtkmuQBZ5ap
 SejLCwe6l7AWZX289OG9rrdT2brrSfK498WJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739621117; x=1740225917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I+QNzH7WRNz9zqppUgmMSkLY3eRm5qONavQ44kBi2O0=;
 b=ZTgVVLUXByia0aabLW6H9Av1BTW0E/AJKnRd4JIYK5gEUv4zyZvSHJ7HJcHiboib/+
 oAgMulEAhq5GhaqUk140p8NKRyIU16JSj0IprRafI6U7aHiRz0YcmpSjt98a5QMpXUjX
 cWKFGZxMTPIsjT0kQvKEEAOokug+oLUA0JchZdtp7ddNluZCebwqxRR1PEJu53nXqBp/
 aRX2EYCJOvGQlm+2bFhP/d4rFoD/YEcfZSsdPxtbDeLKtB3yiRRfplkvxBpjr1Suyusk
 4lmsu8boH2pbXOBxqvCtyOUIYbFqdoSkU6XYIqUfo6cdJAvy3y6s8O4/TT2cgfwGME3D
 aODQ==
X-Gm-Message-State: AOJu0YyLawzOrEpmN7CUC5Qfxq451X+gkPDSrf1GYe+oFveGRoCVXyra
 TsdDJ9DradHy6/GpF+GRDM1RDSu1zbF35nZJaUi4cgISdxBIL6kL4AprcmhKgHvaL45GtbNuFCY
 xc9Lbmgez181/xFGbbE6j9f0iDdzHxE+tnyhrON4ZfI8Z3hM7PA==
X-Gm-Gg: ASbGncvfnTnM+An+xqGe2FySrW8loV2a6Wyga4RD5GgpPWXvWtUUQPf7aT0Nn4SuCbP
 JHc6SGLC4rmR2udpr7+Hu6CX/ULOQsSF/GXN2GZA2FDjmN0VgmpgAnZci6mxdKGBFJMB5cudrDw
 ==
X-Google-Smtp-Source: AGHT+IEqcllytfhWCK5SJo+VBZg6KPlskEwgjSNnNABFBDdx0mXbZxOmtdxlEEOBg/gH7ky0Knt2+4ecD/QiHBrZJTw=
X-Received: by 2002:a17:907:6091:b0:ab7:a33f:289a with SMTP id
 a640c23a62f3a-abb70bbe0f6mr261843966b.28.1739621117373; Sat, 15 Feb 2025
 04:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-8-sjg@chromium.org>
 <EF141676-AFAA-4E88-925D-D504426DDBCB@gmx.de>
In-Reply-To: <EF141676-AFAA-4E88-925D-D504426DDBCB@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 05:05:06 -0700
X-Gm-Features: AWEUYZmo0S7Ew3-eot7_xgf7tBmboDb4dV7g4nWKhFv36x3PlCk-s6-3u0FBpow
Message-ID: <CAFLszTiC1V3D+WeZStvjwRKhQv6xeGWHPC7xnFBrPn2NTtWMNg@mail.gmail.com>
Subject: Re: [PATCH 07/32] scripts: Update build-efi to support arm64
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Sun, 9 Feb 2025 at 12:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 3. Februar 2025 18:42:00 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Provide a -A flag to select ARM instead of x86. For now, only the app
> >is supported and only for 64-bit ARM.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> > scripts/build-efi.py | 49 +++++++++++++++++++++++++++++++-------------
> > 1 file changed, 35 insertions(+), 14 deletions(-)
> >
> >diff --git a/scripts/build-efi.py b/scripts/build-efi.py
> >index 3a1bf180ade..1ba37e86e88 100755
> >--- a/scripts/build-efi.py
> >+++ b/scripts/build-efi.py
> >@@ -48,6 +48,8 @@ def parse_args():
> >         epilog='Script for running U-Boot as an EFI app/payload')
> >     parser.add_argument('-a', '--app', action='store_true',
> >                         help='Package up the app')
> >+    parser.add_argument('-A', '--arm', action='store_true',
>
> Why have a flag per EFI architecture?
>
> Please add a parameterized flag instead.
>
> --arch i386
> --arch x64
> --arch arm
> --arch aarch64
> --arch riscv64
>
> and get rid of the bitness parameter.

Tom has rejected this for the tree. I'll apply it to my tree and then
deal with this comments with another patch. But I'm thinking a
contrib/ directory would be better.

>
> >+                        help='Run on ARM architecture')
> >     parser.add_argument('-B', '--no-build', action='store_true',
> >                         help="Don't build (an existing build must be present")
> >     parser.add_argument('-k', '--kernel', action='store_true',
> >@@ -131,26 +133,43 @@ class BuildEfi:
> >         """
> >         extra = []
> >         efi_dir = self.get_setting("efi_dir")
> >-        if bitness == 64:
> >-            qemu = 'qemu-system-x86_64'
> >-            bios = 'OVMF-pure-efi.x64.fd'
> >-        else:
> >-            qemu = 'qemu-system-i386'
> >-            bios = 'OVMF-pure-efi.i386.fd'
> >+        if self.args.arm:
> >+            qemu_arch = 'aarch64'
> >+            extra += ['--machine', 'virt', '-cpu', 'max']
> >+            bios = os.path.join(efi_dir, 'OVMF-pure-efi.aarch64.fd.64m')
> >+            var_store = os.path.join(efi_dir, 'varstore.img')
> >+            extra += [
> >+                '-drive', f'if=pflash,format=raw,file={bios},readonly=on',
> >+                '-drive', f'if=pflash,format=raw,file={var_store}'
> >+                ]
> >+            extra += ['-drive',
> >+                      f'id=hd0,file={self.img},if=none,format=raw',
> >+                      '-device', 'virtio-blk-device,drive=hd0']
> >+        else:  # x86
> >+            if bitness == 64:
> >+                qemu_arch = 'x86_64'
> >+                bios = 'OVMF-pure-efi.x64.fd'
>
> Not a filename used by EDK II or by QEMU.

How best to handle this? The edk2.git-ovmf-x64 package has

/usr/share/edk2.git/ovmf-x64/OVMF-pure-efi.fd

but I cannot find similar packages for arm64. For ARM, the file has to
be extended to the correct size.

[..]

Regards,
Simon
