Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74890CDB470
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 04:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF7C8460E;
	Wed, 24 Jun 2026 06:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kudzu-us.20251104.gappssmtp.com header.i=@kudzu-us.20251104.gappssmtp.com header.b="pe2eHrIi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7099A849CE; Tue, 23 Jun 2026 21:03:53 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 303BC849BF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 21:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=jdmason@kudzu.us
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-44748131f58so789327fac.1
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 12:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782241430; cv=none;
 d=google.com; s=arc-20260327;
 b=RBqJjZU228+GGMoLTf7JCmPYkD50flCgEtrWAQQe0jsOdJ9yv9tssmgPOE1uqlsjty
 Hc5Klc3HCBo3y3n9RNB35YXjNNGT8d1J6Sx6QYC503p7JOzmDWu0KtIMRgupfmB8X0AJ
 hIXPpGUt3PkpGdXfgikRswX9RhRv5Zt5V9SWK33rGW4lVk7idG1cu2TXV4jeWn0IAjm9
 dtVInLG73wUQpKYmULl/TkHDjnBTtt8eprAY3qpg5y0OWS03TAkj1FRa67hk2M1fqZ+O
 BkfkAYQW6mWIc4eHm2Ic+lEYL+usc280rfmQ5zvoinb9wUalKf8iDOlqFv4Lw6hq1loR
 prVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CUq1KRDvZQy2wmHqeKAMiIdfEjL6uH4Tn7M2IrtO5mw=;
 fh=U/S4rzFgNMUwn8iPYnrtNIJ8B7S5qJ/RAodxROmakPs=;
 b=iEFYLtgutywcGTAReXNh1LWRK5mcdhXtRrYqoBTST5bg2qTpvUziu7+FfYyDyEBYCG
 eszH7vPGGRWeXvQHwtLhDlzLZ1/rrTE27336GNdDR3r2mJSwyv5L20W2z1iQPkoUOn6R
 i5BbPsk4LLUXUKToFG21xa9pTH8bBa3JvN6vlztEidfL+QaGqfjHRvVFts3CnX4H7jSJ
 RLEK0c2/75jBUpmHTd/IDyvVZTvY56Zyo4eEPlJNDYxtw27bcl6UpqEnbnTiLvWJzGZ+
 e8qoTfBTixcZqdLD3ylIOXu2yN+rSLy6han/Cp4XQrX7Dl7tgd45hortyFEqYbRcCQeL
 OQfQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kudzu-us.20251104.gappssmtp.com; s=20251104; t=1782241430; x=1782846230;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUq1KRDvZQy2wmHqeKAMiIdfEjL6uH4Tn7M2IrtO5mw=;
 b=pe2eHrIinGMge/GHGbl77Eq7mPevgmu4T8fwoHgn8dJxt8tBOEttwF4GVRD6IwvXJv
 e7JM1cQhh6mxHDLL73bxI1cgyGMFTGlORb1d85fBYlKmALZ/GTSPz70yxCjyFy+Lucar
 O02/NMTCDZyODWdALHH0aVJwGwSODsjdY0V9TPjInhlsvuhUKvjdNhxIJXIh8jli6uFI
 kwgWBzd6MNMmzB2Sxb/nJCFQk+HAnCwRzYfGXbVk9LcSF/gDw++PI7y4OY/IeMo70OUQ
 ibJ+FWGDnLOsO9urRn+HT5He2gAG274iXIH+oK2KNl3VuFh38qv5Giu8mlZbSGWFfzLX
 gnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782241430; x=1782846230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CUq1KRDvZQy2wmHqeKAMiIdfEjL6uH4Tn7M2IrtO5mw=;
 b=knFoZxEKL9L/IfQGPBDMFQGRpkM3+IKKtwuHWHc3yARJOmkp3Sqc3n0jRJ+SvUtBoR
 B7NexM8jLGkDqMsEQhM9VK1C06Rw9SJRFhkEljnhtjPsWgKkcOhL3quKkashkJfdPq9y
 adVLtoOJwYJc40+HbJbGaIDtUa6KlGFqAFETYJ4oHNyu1TjL4zisT1ARX7hn7KKA3Jeh
 wKB6TRBcePoRr6OO8zNYMGesYRKwj7Omn9fKHd2iA3xt3dHflfRskUFtnBEdq8qvQiWL
 ALHK0vOOa/dmcW6XX92MVfwe6iF/DJN+cW8f7EP/J/XKCqyx3NxJQB8URnfiSnK3bavf
 ZhrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zUpJL9LzhP6YYAKPdrfLZEidMx155A+gES99l0fJZuUDwYJxrEswwe0Wcfp9usm5RvFDIYG0=@lists.denx.de
X-Gm-Message-State: AOJu0YwmvMOrkSPHMIa5xM2HYMyf+FdPAbv5s4OW/40XKzBGhvldRpRn
 u8cPmT4N5JEZVZQOxBMZjEVNOZ/KkxtQy95YMyipX5wXhvfHuJafaABENzzC1RT2IKVvhOO/bUV
 BsDD0GJLbh1R1dEguqRHRlSjSuOL7blnAEdSbh7AF
X-Gm-Gg: AfdE7clO7kiC+ksEiUfiD01u4HACK42G/1NTsO82kCo6sSN2ArZ2v+Sw2i8dphMToeO
 y50PCUF7shBshOCEpGeOd3H+6jf7vZHLJBPFXl7vf4f8Yz+vhDza9YUmAhx00auJP1/61K51exg
 3+p+Wydz029C41ix/1LKhFe7DfAtYpuK/MqQ3wNyqZt+1U/ZxECDM/VjOFTG3mCeEG/1Q6mNEHf
 9N/Y6PO40kzZQQIAJIf+utoo9J+795yL4qWdcMfItmbL80Y93KJrxFnOXhhDNo/AmEtKnqM
X-Received: by 2002:a05:6808:e58b:b0:48f:46fe:ebd1 with SMTP id
 5614622812f47-48f46ff1cf5mr1471137b6e.9.1782241429660; Tue, 23 Jun 2026
 12:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260619155857.9665-1-jon.mason@arm.com>
 <FC600559-0FE9-4EA3-B047-F69CEAB64795@gmx.de>
In-Reply-To: <FC600559-0FE9-4EA3-B047-F69CEAB64795@gmx.de>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 23 Jun 2026 15:03:38 -0400
X-Gm-Features: AVVi8CezvL-NrD3fbtQMNNAJnsmmvYBNw8qCYVcJmVt1w-uore9deZQkgxCc234
Message-ID: <CAPoiz9zGJuhZjGgWTV1dz1mh9KET6zBaL62LB4upooUSNYyj5g@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: move efi_var_seed.o to objtree
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jon Mason <jon.mason@arm.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 24 Jun 2026 06:48:40 +0200
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

On Fri, Jun 19, 2026 at 12:46=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> Am 19. Juni 2026 17:58:57 MESZ schrieb Jon Mason <jon.mason@arm.com>:
> >With commit bd3f9ee679b4d1456d0d3c261ab76788950e6096
> >(kbuild: Bump the build system to 6.1), there is an issue when trying to
> >build out of tree, where efi_var_seed.S wants ubootefi.var to be in the
> >object tree, but lib/efi_loader/efi_var_seed.o wants ubootefi.var to be
> >in the source tree.
>
> Ubootefi.var is an optional file with the EFI security database. Why woul=
d you ever put it into the build directory?

I didn't know that was a limitation.

Would you prefer that I make a change like:
-$(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
+$(obj)/efi_var_seed.o: $(srctree)/lib/efi_loader/$(EFI_VAR_SEED_FILE)

This seems to work for my use case, and still keeps it in the src directory=
.

Thanks,
Jon

>
> Heinrich
>
> >
> >If we change efi_var_seed.o to look in the objtree, then it should work
> >in both local and out-of-tree.  However, it would require anything
> >previously working to put ubootefi.vars to the objtree, but it's broken
> >now anyway.
> >
> >Signed-off-by: Jon Mason <jon.mason@arm.com>
> >---
> > lib/efi_loader/Makefile | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> >index f490081f6542..9c836f6ee237 100644
> >--- a/lib/efi_loader/Makefile
> >+++ b/lib/efi_loader/Makefile
> >@@ -74,7 +74,7 @@ obj-$(CONFIG_EFI_ECPT) +=3D efi_conformance.o
> > obj-$(CONFIG_EFI_DEBUG_SUPPORT) +=3D efi_debug_support.o
> >
> > EFI_VAR_SEED_FILE :=3D $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
> >-$(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
> >+$(obj)/efi_var_seed.o: $(objtree)/$(EFI_VAR_SEED_FILE)
> >
> > ifeq ($(CONFIG_EFI_CAPSULE_AUTHENTICATE),y)
> > capsule_crt_path=3D($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE)))
>
