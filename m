Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A80E7E36C
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 10:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EAB78382A;
	Fri,  3 Apr 2026 12:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b/veZnUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2BF583CF5; Fri,  3 Apr 2026 12:38:55 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35EC38341A
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 12:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7982c3b7dfcso16764657b3.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 03:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775212731; cv=none;
 d=google.com; s=arc-20240605;
 b=cDqYsogj/dZ3GrHCh72fpxwLoMckK2dSWhmVE4u7tji7MuRsVomwfEXMgxUvbijvhv
 Jm5ZFE7JQPPtNhgCJoIGcWJrf4rCcvsCZiQS+7Resft5UamiAZna28Yk+sra48ReybJB
 n1kvlaF8DoeVw+1Lc3KfY3rYWtluEdeIFXFRKhOSuVKFy+siWs4EyRjQ8Vk4RdkZLirr
 rJiKKZqcXmLynLTr8HB6SWRE7lJOPgzN9kZOlAvDLX5POlFpAit7JSSBYmkeHJyCGi2m
 wZY+kBl8BTLfq0eBArtkK41KhRekfa/1cZ4P+lQtRREagtbIgeyP3ulM28VmGabeT/LZ
 KXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LFXFo2j3wCWNcOfaxqjH7xcOKj11n69xpXFWOWFynR0=;
 fh=IWuYNzG2k4tuL9tbJotFS213vGbD+VOv8VShiovKyNA=;
 b=NwHqWGgGmujb7dzmbNeI4i1mBH8anoO+L3Iq62CCuxxNYEX9YKxpMhU6jicdfvLxkZ
 qlm7Md7jxXJ6XoKEspsRPIGYOJBlreJwT2CtxoPG8yBRe+i6TYbyfeUcG0v552MOHGQE
 v2v7+OhcokLCkwUWwHcnzJZwzJgU75OZUjakg74Z/qzAKLa5rnkAXY8t6nn3zs5h1sTI
 0szkbZ/Y2uLjRupEDZlJhMoClkx+Us/vF4tXkbo0F9Yqb4vVZirQoOOnC8ekChflOyJL
 GjuzfJuuhy2y8818Mz+Uf+8qhxu9AhYwRBDpYOKy+SeVEZMroX46TRfOZ7J9IyGcl89t
 Zc2A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775212731; x=1775817531; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFXFo2j3wCWNcOfaxqjH7xcOKj11n69xpXFWOWFynR0=;
 b=b/veZnUq/CK7nmS385FacEBq3W3VqjU6yNooKdYeJJyKgQmPitLFG2Jz+/SeEJvuv9
 EGk9d5RRJCm+kcq71T4aNgtjrqkTT3rjgYySdcmxrKH9YbJdP9u+qfth/1VSkpmEoMxw
 iOxE8q6NQq7UuO73Fohdxafl7onjpCVPKxZzfTuZmBGQqTwQ4r/rXy5AQA0v0hkoTl/X
 NeccUxTG8JlgAJRY6j6iV14wPF/jpSOKBIzrimm2IF27GHEHjSe9ZZ9egr5aZdYIMzPC
 ekI0+J43+5z9ed1sMN/dDrgLbTacgFgKmXUWLDPdeQzRj+/LIh4Vi1iydrh6sy93ve1V
 /pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775212731; x=1775817531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LFXFo2j3wCWNcOfaxqjH7xcOKj11n69xpXFWOWFynR0=;
 b=LaxwzqERXFh6d5NCpAMt0tG5xj3lclhdMi2sewYe/ixtj2pTzStv79zT1RDPXwkTn5
 ABseo00OGjcr1KcfCne0TVGtKyT8ZiFp9wB79RH4RD1jEmvAzFjV5i7C8D7tTiHdIKt/
 aLYv6U3EU1BKeGeac28h9/q0mE6dBzYEeg2ynak/0UYhs+/U1BPWZp93aShJe/4ogIru
 kfWZgeAX9mcC6LEe6hzvLd/N4M19zFKhtiTYHtWf3Cyd6/60WH0VrzHWmlETdvqZKFme
 pu/cvWTKCS4R60FXRxfvj9KcYPUs5/z/Vxep8v6JtiaopSlm+2CWUJ2OB0lUsflWLQec
 FqjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgKLB/fQxlMaIpAmOXOGmlFOAus5+AD5oOK0prVHJLknQjNTNaLtE3AvshPq7RRun18gQddSY=@lists.denx.de
X-Gm-Message-State: AOJu0YyxifXQa7zhLk7Qs6LhuDQlY6PsvNXsy1DjXPyY9jpLruyJtbOG
 ax1Mpiqt8NW+kiIWkltHfJRgM3hx1cAXgJBvE+Y9uMfzdnsJyU8kEUfwA1ukHpqQ6QjE2pmksLT
 vlGvjLpG4k+JwJ0sBAT2HzgDyadY8BuGlna1ygxyosSppZWUPdb65
X-Gm-Gg: AeBDievT1R3bQkFaKxH3zsNgPMyvMosdtQmL/8m4a8JMG37sqc1sVpgv8+C2olraVkW
 G88MNPgbUqKUtk04urB92L0kvTncQCgcNxTTUdgnP01iwVElkyI3/D1kBB41Nf6HrA7IObr0zrN
 DRhr3ANILSWOJy/Yxg+j6KJ/iNX9sqASqbSMfiCTthxEe5u5IfObtO+LmadxgST0WOuDHvSXhSA
 ITVRrBpoWvaFUIF5RqKOZAeTuJ1t26JDQuGBjGfsV49256u+pd/as+cO3m7Qojvxq5rS+IFwz6p
 05N8Ol9FPY9x1aO64F8oBcp4r0he3LP8yrPR8h9DjxO8AEAr8PCv7VbnOmr3LunjPaK0MQehppi
 m0DfHa0dGCH2H4laa4BQuztYRThjq0zA1G1gX9/uCda5RZtCR7SdqY64HWIkbD36xYdwI5vs+gA
 QEJEg9z6bj5TKk2agb/MVvh221s8L9eVKfsfqQ//XTriLdFU3zpAWUEPGdCEcHjO/9fm34bGCua
 lstvR6w/W2wndwF8m1Ud8EkFc1iAnWbCxKVp8+HPiozzeMHRFsoGzt08rRLxXOmnHI8J+nTvrkG
 Tly5qAOLsCfjBLOGIdoAozPtKvCDq/a6KEPE1RLqC8Bg
X-Received: by 2002:a05:690c:dd6:b0:79b:cf31:9767 with SMTP id
 00721157ae682-7a4d2ff0c6bmr25760397b3.3.1775212730856; Fri, 03 Apr 2026
 03:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260331191853.44549-1-gary@garyguo.net>
 <4C76330D-3EE4-4505-AB3B-9E89A3A4B18C@gmx.de>
In-Reply-To: <4C76330D-3EE4-4505-AB3B-9E89A3A4B18C@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 3 Apr 2026 13:38:13 +0300
X-Gm-Features: AQROBzBUhgeuV2TADVhZewSzEQpnfZInwQhVK_Y29VHDGyo1dnQrZWCxBMrLr9I
Message-ID: <CAC_iWjKeYzBNnoAS9N1T923w7SHgryeQu4kYyxa6EB843Qd1OQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Gary Guo <gary@garyguo.net>, Tom Rini <trini@konsulko.com>, 
 David Zang <davidzangcs@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Javier Tia <javier.tia@linaro.org>, Martyn Welch <martyn.welch@collabora.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 3 Apr 2026 at 13:30, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote=
:
>
> Am 31. M=C3=A4rz 2026 21:18:51 MESZ schrieb Gary Guo <gary@garyguo.net>:
> >EFI variable OsIndications have a bit EFI_OS_INDICATIONS_BOOT_TO_FW_UI
> >indicating that the OS (or next stage bootloader) requests booting into
> >firmware UI instead of continuing autoboot process.
> >
> >Support it by having autoboot.c asking EFI bootmgr if boot should contin=
ue,
> >which checks and clear the bit (so the next boot continue as normal).
> >
> >With this change, systemd-boot will show a "Reboot Into Firmware Interfa=
ce"
> >option which will be able to drop back to u-boot. This can be useful if
> >bootdelay is configured to be -2.
> >
> >Signed-off-by: Gary Guo <gary@garyguo.net>
>
> Thank you Gary for the patch. I am currently on travel and will have to l=
ook at it once I have returned.

On vacation here as well. I'll be off next week as well, nut I might
have time to take a closer look

>
> @Ilias
> Should we preferably integrate the detection of this bit into efi_init_ea=
rly()?

Which part? This patch also touched EFI variables, which are not
initialized in the eraly code.

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
>
>
> >---
> > common/autoboot.c            |  4 +++-
> > include/efi_loader.h         |  2 ++
> > lib/efi_loader/efi_bootmgr.c | 45 ++++++++++++++++++++++++++++++++++++
> > lib/efi_loader/efi_setup.c   |  4 ++++
> > 4 files changed, 54 insertions(+), 1 deletion(-)
> >
> >diff --git a/common/autoboot.c b/common/autoboot.c
> >index 1783ef92c94c..b889407612dc 100644
> >--- a/common/autoboot.c
> >+++ b/common/autoboot.c
> >@@ -11,6 +11,7 @@
> > #include <cli.h>
> > #include <command.h>
> > #include <console.h>
> >+#include <efi_loader.h>
> > #include <env.h>
> > #include <errno.h>
> > #include <fdtdec.h>
> >@@ -503,7 +504,8 @@ void autoboot_command(const char *s)
> > {
> >       debug("### main_loop: bootcmd=3D\"%s\"\n", s ? s : "<UNDEFINED>")=
;
> >
> >-      if (s && (stored_bootdelay =3D=3D -2 ||
> >+      if (s && !(IS_ENABLED(CONFIG_EFI_BOOTMGR) && efi_should_abort_aut=
oboot()) &&
> >+          (stored_bootdelay =3D=3D -2 ||
> >                (stored_bootdelay !=3D -1 && !abortboot(stored_bootdelay=
)))) {
> >               bool lock;
> >               int prev;
> >diff --git a/include/efi_loader.h b/include/efi_loader.h
> >index 3e70ac070550..449697ad13b3 100644
> >--- a/include/efi_loader.h
> >+++ b/include/efi_loader.h
> >@@ -583,6 +583,8 @@ efi_status_t efi_bootmgr_get_unused_bootoption(u16 *=
buf,
> > efi_status_t efi_bootmgr_update_media_device_boot_option(void);
> > /* Delete selected boot option */
> > efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
> >+/* Check if autoboot should be aborted based on EFI vars */
> >+bool efi_should_abort_autoboot(void);
> > /* Invoke EFI boot manager */
> > efi_status_t efi_bootmgr_run(void *fdt);
> > /* search the boot option index in BootOrder */
> >diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> >index a687f4d8e85c..39f255ac9de4 100644
> >--- a/lib/efi_loader/efi_bootmgr.c
> >+++ b/lib/efi_loader/efi_bootmgr.c
> >@@ -1290,6 +1290,51 @@ out:
> >       return ret;
> > }
> >
> >+/**
> >+ * efi_should_abort_autoboot() - check if autoboot should be aborted pe=
r EFI vars
> >+ *
> >+ * Return:    true if autoboot should abort
> >+ */
> >+bool efi_should_abort_autoboot(void)
> >+{
> >+      efi_status_t ret;
> >+      u64 os_indications =3D 0x0;
> >+      efi_uintn_t size;
> >+      efi_status_t r;
> >+
> >+      /* Initialize EFI drivers */
> >+      ret =3D efi_init_obj_list();
> >+      if (ret !=3D EFI_SUCCESS) {
> >+              log_err("Error: Cannot initialize UEFI sub-system, r =3D =
%lu\n",
> >+                      ret & ~EFI_ERROR_MASK);
> >+              return false;
> >+      }
> >+
> >+      size =3D sizeof(os_indications);
> >+      r =3D efi_get_variable_int(u"OsIndications", &efi_global_variable=
_guid,
> >+                               NULL, &size, &os_indications, NULL);
> >+      if (r !=3D EFI_SUCCESS || size !=3D sizeof(os_indications))
> >+              return false;
> >+
> >+      if (!(os_indications & EFI_OS_INDICATIONS_BOOT_TO_FW_UI))
> >+              return false;
> >+
> >+      /* Clear the BOOT_TO_FW_UI so next boot returns to normal */
> >+      os_indications &=3D ~EFI_OS_INDICATIONS_BOOT_TO_FW_UI;
> >+      r =3D efi_set_variable_int(u"OsIndications",
> >+                               &efi_global_variable_guid,
> >+                               EFI_VARIABLE_NON_VOLATILE |
> >+                               EFI_VARIABLE_BOOTSERVICE_ACCESS |
> >+                               EFI_VARIABLE_RUNTIME_ACCESS,
> >+                               sizeof(os_indications),
> >+                               &os_indications, false);
> >+
> >+      if (r !=3D EFI_SUCCESS)
> >+              log_err("Setting %ls failed\n", L"OsIndications");
> >+
> >+      return true;
> >+}
> >+
> > /**
> >  * efi_bootmgr_run() - execute EFI boot manager
> >  * @fdt:      Flat device tree
> >diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> >index f06cf49e4435..0ad02e9fe0dd 100644
> >--- a/lib/efi_loader/efi_setup.c
> >+++ b/lib/efi_loader/efi_setup.c
> >@@ -156,6 +156,10 @@ static efi_status_t efi_init_os_indications(void)
> > {
> >       u64 os_indications_supported =3D 0;
> >
> >+      if (IS_ENABLED(CONFIG_EFI_BOOTMGR))
> >+              os_indications_supported |=3D
> >+                      EFI_OS_INDICATIONS_BOOT_TO_FW_UI;
> >+
> >       if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> >               os_indications_supported |=3D
> >                       EFI_OS_INDICATIONS_CAPSULE_RESULT_VAR_SUPPORTED;
>
