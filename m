Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE32EC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 13:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F5084942;
	Tue,  7 Jul 2026 15:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="kfcGcjf6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 993DC8494B; Tue,  7 Jul 2026 15:50:33 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C38C848EB
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 15:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nora.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=KcupdjeCIUirb0Wlal5lP18kO2fk+/eIV3lMy2avCrY=; b=kfcGcjf664MupsnrZER5tQdGTs
 h42lOQozfKAyiDEyUzfDvYo3sQ3KtKrkeBFaRITLYEZG8u+zBDRxrjw/v+9iHVfqRohlith3S666P
 iRnd/NKPMRXXQ6ZdVRL5nXyQe+xJ6+NspX0kVAdT+jE5eHOypmxBx0G/Z+KtIydX/6iDMJz3eLH4h
 LgPTuMmNzOyESdDxrL8B9VlpdP1V1Ucs42zLmZ6BWgh3mC9LIuPwoIH2KyVbJWN7ju0I294jbvVan
 sMFLyjaFj6cEbAlkAMVOxiVvjln/d/Iwj/9cpBro54Y6jFTdGQpkjSMtwVzMA6oZvFALCyLRdTCph
 YEHT1nvA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wh6By-000AqL-0p; Tue, 07 Jul 2026 15:50:30 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1wh6Bx-0009WA-2N; Tue, 07 Jul 2026 15:50:30 +0200
Message-ID: <5bd226211194bfd8bbcc55fe76c39958ff366e3a.camel@ew.tq-group.com>
Subject: Re: [PATCH 1/1] efi_loader: fix building with
 CONFIG_EFI_VARIABLES_PRESEED=y
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de, Jon Mason
 <jon.mason@arm.com>
Date: Tue, 07 Jul 2026 15:50:28 +0200
In-Reply-To: <20260624054819.493294-1-heinrich.schuchardt@canonical.com>
References: <20260624054819.493294-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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

On Wed, 2026-06-24 at 07:48 +0200, Heinrich Schuchardt wrote:
> Since commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
> out-of-tree builds with CONFIG_EFI_VARIABLES_PRESEED=3Dy fail with errors
> like:
>=20
>     ../lib/efi_loader/efi_var_seed.S:14: Error: file not found:
>     ubootefi.var
>=20
> For out-of-tree build we cannot use CONFIG_EFI_VAR_SEED_FILE in the
> .incbin statement of file efi_var_seed.S.
>=20
> * We have to prepend $(srctree) if the path is relative.
> * We must not prepend $(srctree) if the path is absolute.
>=20
> Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
> Reported-by: Jon Mason <jon.mason@arm.com>
> Closes: https://lore.kernel.org/u-boot/CAPoiz9zg4OXgHo5J3WtJHKOEuWOdCDrug=
WfAt6Z+d71j=3D+q8oA@mail.gmail.com/T/#mffaca10a9e812d03eceafad59999a02e5725=
8b9a
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Tested-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>

> ---
>  lib/efi_loader/Makefile       | 7 +++++--
>  lib/efi_loader/efi_var_seed.S | 4 +---
>  2 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index d73ad43951b..567db518a8f 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -74,8 +74,11 @@ obj-$(CONFIG_EFI_SIGNATURE_SUPPORT) +=3D efi_signature=
.o
>  obj-$(CONFIG_EFI_ECPT) +=3D efi_conformance.o
>  obj-$(CONFIG_EFI_DEBUG_SUPPORT) +=3D efi_debug_support.o
> =20
> -EFI_VAR_SEED_FILE :=3D $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
> -$(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
> +TMP_VAR_SEED :=3D $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
> +EFI_VAR_SEED_FILE :=3D $(if $(filter /% ,$(TMP_VAR_SEED)) \
> +  ,$(TMP_VAR_SEED),$(srctree)/$(TMP_VAR_SEED))
> +AFLAGS_efi_var_seed.o :=3D -DEFI_VAR_SEED_FILE=3D\"$(EFI_VAR_SEED_FILE)\=
"
> +$(obj)/efi_var_seed.o: $(EFI_VAR_SEED_FILE)
> =20
>  ifeq ($(CONFIG_EFI_CAPSULE_AUTHENTICATE),y)
>  capsule_crt_path=3D($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE)))
> diff --git a/lib/efi_loader/efi_var_seed.S b/lib/efi_loader/efi_var_seed.=
S
> index e0a40cf46c8..008a505d19e 100644
> --- a/lib/efi_loader/efi_var_seed.S
> +++ b/lib/efi_loader/efi_var_seed.S
> @@ -5,13 +5,11 @@
>   * Copyright (c) 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
>   */
> =20
> -#include <config.h>
> -
>  .section .rodata.efi_seed.init,"a"
>  .balign 16
>  .global __efi_var_file_begin
>  __efi_var_file_begin:
> -.incbin CONFIG_EFI_VAR_SEED_FILE
> +.incbin EFI_VAR_SEED_FILE
>  .global __efi_var_file_end
>  __efi_var_file_end:
>  .balign 16

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
