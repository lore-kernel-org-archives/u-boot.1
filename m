Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B07C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 20:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A04D88578;
	Fri, 17 May 2024 22:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mF04dNqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B8038856F; Fri, 17 May 2024 22:19:00 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89063885A2
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 22:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715977133; x=1716581933; i=xypron.glpk@gmx.de;
 bh=9D5ycF8dnwZX1L0b3n9ofELiei6mGlHgLJhFJEY9838=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mF04dNqCnbwbVO+S8msnwCBEQFJaVI74nObTF34bKulQUcaA81+rLonDPuQZl+7X
 SeFS3B/aIdzk/DFhIceGDC8zh0uj6TgetnlhNKqMcwQuMw6XlV7ZFbD5Cf96cDuXZ
 0Zf/kE6MKmnRXOHDwn3Tep0V1fpDAVJoB5ncJUz5BdvfNJcbW+WGHp90gqfxkp2Sf
 KvvweB5vQW1GMBgWp2jJurSrANmX8gnKRoCZMNzKgEet1EHGCzSHLYJJMvLk43WnZ
 WyxJD9VGz9ZGtn9dgNDci9zt3Tbnw0rQ1504+aT7aTgstKwy2fo6fWy7Ia/iIAN9b
 OdZ7WXSc4CaEHPDPvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([176.1.13.130]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1sXo5P0Iq2-010PcP; Fri, 17
 May 2024 22:18:53 +0200
Date: Fri, 17 May 2024 20:48:42 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
CC: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 4/7] Makefile.lib: Enforce EFI CFLAGS/AFLAGS
User-Agent: K-9 Mail for Android
In-Reply-To: <20240517-mips-efi-v1-4-79096e3ca3b3@flygoat.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-4-79096e3ca3b3@flygoat.com>
Message-ID: <BBB3A7A9-593E-4FE5-BEB9-52C11023754B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k3+f9OzH8bpvb2DaqaSv80OWX1ajjofdWNl4/91k6beDmNkezRg
 uOtOHqg9I37P+j/FnrMR5lJ/FyaEkCf6am15P6YbTvao1W+kbg1B6No+6eevdyPovUcS1GQ
 ZfLlpFe5JZZX1Y0BbXBHcfU79/Pf4wpo8JmxQGlGgDup9VtMvA8uFiE4BSQSlLoopKmPK8Q
 RtLXCE4kZp+tDNCe9gCiw==
UI-OutboundReport: notjunk:1;M01:P0:ju2ec3Wk5H4=;HaAgdXbLw3E51NR+5w3Vr6OtR03
 TZQCGJl+9S7+snL5a7jZnygZSxMNgF8VSE4uqln9CmZo8DvnPd/CNI/Niu2/l3eSpJhS22Mm3
 bBvul8h48W35HAelIRfo7t4kDXaE3Epl+XXFpaILxEXPaS2XINVvh4j/GOXQ+3v6BgXpOuRer
 Am9kEut5upkHq2JYJE8+osOwg/fBtufjB3Vsynbu6o9gFi19EFwiFxbgWD7sC7RkOR8C+UlK+
 Ijktowg7B1jZLx7GGldah3Fj1D1LF2BO+jKjyEQ3oDxNnehwAWQKQooILcKUM+U60j1C7ux9s
 /irTUQYUP/kc5sY34RDTMIrlFquCl0+9XzODPzUAtQqUpGm/HcnkXJx1ohc+QPnmyYPXqLYBa
 z93sszYmL2OHwHMuez0gm5n9VHnsMVW8EYurLlw6gLeldEzdRd7xwak526fuU3iWdx7YDb3Pw
 +by4vXkoQDthIdinONs0cG7qdaGVHi4vG2bdJPCHi6Vtkc9EpaoNhS+T2R2XzGhjt+sEeaL+l
 66vH0T+KkgcOc4f5zKLHKCEXCdpsgtHTs7NUMY+GttmS0LMVwBSiYg2qz5AB+5iwFcoPt5sc2
 uDDGlCYZ4oMeIeDDIMx6FDaVK0TwY4KdLBjpQ1q1/cg6RUcSRc2YCtMtOlo8nfKT8Ue9J/Z6z
 iZskx2NFkFdzyjiVkSdL3wYZMrbecZH8/Es+F9BmJpKdQO/wbvVmdxywrRhgQ1gOB5oGZAO7p
 2iRZncV1I2NtA8WEUca+0+tLW/UrcWoSdu3k1pnfNEk/4ejqt97CZM02jmBrSKrtd/BIMm2q3
 IVot6q03CO6M3cAa/2hrn5GH+UCEMSK4WyOCbVeaGfiLE=
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



Am 17=2E Mai 2024 18:32:55 MESZ schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>EFI AFLAGS/CFLAGS should be enforced for those runtime
>supporting files as well, otherwise EFI applications
>will fail to compile on MIPS=2E
>
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>---
> Makefile             | 3 +++
> scripts/Makefile=2Elib | 8 ++++++--
> 2 files changed, 9 insertions(+), 2 deletions(-)
>
>diff --git a/Makefile b/Makefile
>index 44deb339af19=2E=2E6c9098f5823f 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -652,6 +652,8 @@ export EFI_CRT0		# Filename of EFI CRT0 in arch/$(ARC=
H)/lib
> export EFI_RELOC	# Filename of EFU relocation code in arch/$(ARCH)/lib
> export CFLAGS_EFI	# Compiler flags to add when building EFI app
> export CFLAGS_NON_EFI	# Compiler flags to remove when building EFI app
>+export AFLAGS_EFI	# Assembler flags to add when building EFI app
>+export AFLAGS_NON_EFI	# Assembler flags to remove when building EFI app
> export EFI_TARGET	# binutils target if EFI is natively supported
>=20
> export LTO_ENABLE
>@@ -926,6 +928,7 @@ export PLATFORM_LIBGCC
> LDPPFLAGS +=3D \
> 	-include $(srctree)/include/u-boot/u-boot=2Elds=2Eh \
> 	-DCPUDIR=3D$(CPUDIR) \
>+	-DARCHDIR=3Darch/$(ARCH) \

This change seems to be unrelated=2E

> 	$(shell $(LD) --version | \
> 	  sed -ne 's/GNU ld version \([0-9][0-9]*\)\=2E\([0-9][0-9]*\)=2E*/-DLD=
_MAJOR=3D\1 -DLD_MINOR=3D\2/p')
>=20
>diff --git a/scripts/Makefile=2Elib b/scripts/Makefile=2Elib
>index 52aed7a65d47=2E=2E5aacab32cb38 100644
>--- a/scripts/Makefile=2Elib
>+++ b/scripts/Makefile=2Elib
>@@ -495,8 +495,12 @@ $(obj)/%_efi=2Eso: $(obj)/%=2Eo $(obj)/efi_crt0=2Eo =
$(obj)/efi_reloc=2Eo $(obj)/efi_free
>=20
> targets +=3D $(obj)/efi_crt0=2Eo $(obj)/efi_reloc=2Eo $(obj)/efi_freesta=
nding=2Eo
>=20
>-CFLAGS_REMOVE_efi_reloc=2Eo :=3D $(LTO_CFLAGS)
>-CFLAGS_REMOVE_efi_freestanding=2Eo :=3D $(LTO_CFLAGS)
>+AFLAGS_efi_crt0=2Eo :=3D $(AFLAGS_EFI)
>+CFLAGS_efi_reloc=2Eo :=3D $(CFLAGS_EFI)
>+CFLAGS_efi_freestanding=2Eo :=3D $(CFLAGS_EFI)
>+AFLAGS_REMOVE_efi_crt0=2Eo :=3D $(AFLAGS_NON_EFI)
>+CFLAGS_REMOVE_efi_reloc=2Eo :=3D $(CFLAGS_NON_EFI) $(LTO_CFLAGS)
>+CFLAGS_REMOVE_efi_freestanding=2Eo :=3D $(CFLAGS_NON_EFI) $(LTO_CFLAGS)
>=20
> # ACPI
> # ----------------------------------------------------------------------=
-----
>
