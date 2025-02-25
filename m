Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A221C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 13:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB0F80F53;
	Tue, 25 Feb 2025 14:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gFgserWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2238E80F56; Tue, 25 Feb 2025 14:04:29 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E65F80977
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 14:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so11029784a91.1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 05:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740488664; x=1741093464; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lhiTwvSSKOeU3ty9uks356HryUKe4sao5tOJZ/kxs2Y=;
 b=gFgserWwMNTyfkNTfQfYu1aqQGd09cnz5zUxLo+dnZ63hjshzSSz+XNX6bxpD6/T/z
 sxp9DRxmfB+8xuP1W7Twj5MIAtH3Rnogk7Sk/cBD7yIfbLdzCQV1vZEO0XYhcWj551uA
 xj0f2HGVg7VWbESkcUcjSXBAJpL/Bzjg2Pzpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740488664; x=1741093464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lhiTwvSSKOeU3ty9uks356HryUKe4sao5tOJZ/kxs2Y=;
 b=ZIith4erQox8iv5f9CbXEEMz2oUGedUgk9AsIm7ult4+JPGIHeiEZHfT2EqAuoPn1S
 p1/GRaZB0cWofkByYfDwxS7mQuDu54oNpCRb4GOaLV4r2ES44EIlyFYuKGFTHrFLc+9q
 2VvkXRYUtmjq2I11dUVwkxoCjRR1Uui28AvCfL7Ooqqh2WDFWiUFwKvpgm44gYaNAfqo
 Yeu3pOXi7bBhePLB5VfFRXOP6pT0LJ62cQsUiH3umAixqtITu0ROuXyw0As3fA8CdahT
 K3zz0BD3H06wGaZ9TXrc3lx7iwbBRpf7zR8L20uN+2WKhSJuFr1n2nrKBmThxdv0LCse
 KyoA==
X-Gm-Message-State: AOJu0YyISEdSR3ITS12LBzQglH+cW8LiffW6HTyvcMlaSpTNwSDxtELH
 NBHg0Ga7mvWXR7g6pJadjRQYjb8RUJ5ZsJD6z46lO8GItV19TXZCPPQXtAU2ovDzjfC9LM5dLUZ
 3g1v2knU1IWnHA0G8RiBTYu7YHil09dYuMlyW
X-Gm-Gg: ASbGncs85CHEjLzW9iaKo/3IMHq3ECZVwrpsl1bswtskkI/Tzaf8dQwkFtkrDbl1cbE
 DtyiqYKFvANkQhcBN91jSNxrUNUvkOiFClVAhcWmlbti5wCxvfpwXlr40LXyhQ+ejWw97WNOqLH
 qADbWMuJCE
X-Google-Smtp-Source: AGHT+IEcZ/RwkxGw+xKoobwTc6pHu4qolLQx/Uw2nUXaoPj6PxPq8c1Qr16n0XwI4xn+uoO/WZlzx+1rPLVt4U9LcAY=
X-Received: by 2002:a17:90b:4b86:b0:2ee:ab29:1482 with SMTP id
 98e67ed59e1d1-2fce86cef44mr31613095a91.16.1740488664524; Tue, 25 Feb 2025
 05:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-8-sjg@chromium.org>
 <EF141676-AFAA-4E88-925D-D504426DDBCB@gmx.de>
 <CAFLszTiC1V3D+WeZStvjwRKhQv6xeGWHPC7xnFBrPn2NTtWMNg@mail.gmail.com>
In-Reply-To: <CAFLszTiC1V3D+WeZStvjwRKhQv6xeGWHPC7xnFBrPn2NTtWMNg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Feb 2025 06:04:04 -0700
X-Gm-Features: AWEUYZkwLGwhMGUIgpMDOZgyxXSkVpfcSgAt8SuulYsKjrhnzQe7wcNZG9JSgPw
Message-ID: <CAFLszTi2nCgCkzB52JR6yy9bcup6Nyq+TJ9Xs7D8DuojvN3zcw@mail.gmail.com>
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

On Sat, 15 Feb 2025 at 05:05, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Sun, 9 Feb 2025 at 12:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > Am 3. Februar 2025 18:42:00 MEZ schrieb Simon Glass <sjg@chromium.org>:
> > >Provide a -A flag to select ARM instead of x86. For now, only the app
> > >is supported and only for 64-bit ARM.
> > >
> > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > >---
> > >
> > > scripts/build-efi.py | 49 +++++++++++++++++++++++++++++++-------------
> > > 1 file changed, 35 insertions(+), 14 deletions(-)
> > >
> > >diff --git a/scripts/build-efi.py b/scripts/build-efi.py
> > >index 3a1bf180ade..1ba37e86e88 100755
> > >--- a/scripts/build-efi.py
> > >+++ b/scripts/build-efi.py
> > >@@ -48,6 +48,8 @@ def parse_args():
> > >         epilog='Script for running U-Boot as an EFI app/payload')
> > >     parser.add_argument('-a', '--app', action='store_true',
> > >                         help='Package up the app')
> > >+    parser.add_argument('-A', '--arm', action='store_true',
> >
> > Why have a flag per EFI architecture?
> >
> > Please add a parameterized flag instead.
> >
> > --arch i386
> > --arch x64
> > --arch arm
> > --arch aarch64
> > --arch riscv64
> >
> > and get rid of the bitness parameter.
>
> Tom has rejected this for the tree. I'll apply it to my tree and then
> deal with this comments with another patch. But I'm thinking a
> contrib/ directory would be better.

I've updated this here:

https://source.denx.de/u-boot/u-boot-extras/-/tree/master/contrib/sjg?ref_type=heads

>
> >
> > >+                        help='Run on ARM architecture')
> > >     parser.add_argument('-B', '--no-build', action='store_true',
> > >                         help="Don't build (an existing build must be present")
> > >     parser.add_argument('-k', '--kernel', action='store_true',
> > >@@ -131,26 +133,43 @@ class BuildEfi:
> > >         """
> > >         extra = []
> > >         efi_dir = self.get_setting("efi_dir")
> > >-        if bitness == 64:
> > >-            qemu = 'qemu-system-x86_64'
> > >-            bios = 'OVMF-pure-efi.x64.fd'
> > >-        else:
> > >-            qemu = 'qemu-system-i386'
> > >-            bios = 'OVMF-pure-efi.i386.fd'
> > >+        if self.args.arm:
> > >+            qemu_arch = 'aarch64'
> > >+            extra += ['--machine', 'virt', '-cpu', 'max']
> > >+            bios = os.path.join(efi_dir, 'OVMF-pure-efi.aarch64.fd.64m')
> > >+            var_store = os.path.join(efi_dir, 'varstore.img')
> > >+            extra += [
> > >+                '-drive', f'if=pflash,format=raw,file={bios},readonly=on',
> > >+                '-drive', f'if=pflash,format=raw,file={var_store}'
> > >+                ]
> > >+            extra += ['-drive',
> > >+                      f'id=hd0,file={self.img},if=none,format=raw',
> > >+                      '-device', 'virtio-blk-device,drive=hd0']
> > >+        else:  # x86
> > >+            if bitness == 64:
> > >+                qemu_arch = 'x86_64'
> > >+                bios = 'OVMF-pure-efi.x64.fd'
> >
> > Not a filename used by EDK II or by QEMU.
>
> How best to handle this? The edk2.git-ovmf-x64 package has
>
> /usr/share/edk2.git/ovmf-x64/OVMF-pure-efi.fd
>
> but I cannot find similar packages for arm64. For ARM, the file has to
> be extended to the correct size.

I'm still wondering about this.

Regards,
SImon

>
> [..]
>
> Regards,
> Simon
