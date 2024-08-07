Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2EBC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 01:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF8288AC9;
	Wed,  7 Aug 2024 03:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pkTj7KOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF4F088B39; Wed,  7 Aug 2024 03:05:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF4688A9E
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 03:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722992748; x=1723597548; i=xypron.glpk@gmx.de;
 bh=LmOhCH2lOLeRQibZG+h1EC/AJwP5uIGr+3A6snGJqXM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pkTj7KOY6qHRlMayyE85JBfRFz3gORmQGPliTxQyi95Om0sretFe0HYsaVFL3qTZ
 BfqSuP8ZLkB711hUsFO3Y24MqtscMFKJBvX/fwZeZRbl5tNkIc7YM4BaF4wCVbvzX
 CKP+mjKBuXmGrn+4+HJSmRY5yRMehPeXrrkcCKsZW+Mni7HrWEsyO/zKTO6TRmKTt
 AeLMoURDKM1CHGoCR3OEB/BLz29zpfXJm5Jhj32t7McXhTlJM/C9432jF7HRUV5mn
 x3bTtk3aMA+w//VH/ZH5CHU8C63YLvBqpQyUkdJghDjgkyJhtKho9pGGTY0iO89qn
 aicGqbbDMP4t5S9I1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My36T-1sIKyh2lPb-013zqc; Wed, 07
 Aug 2024 03:05:48 +0200
Message-ID: <67cbbfd7-e6fa-4f16-a7e8-c2ac3e36d3fa@gmx.de>
Date: Wed, 7 Aug 2024 03:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/39] efi_loader: Shorten the app rules further
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-30-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240806125850.2316956-30-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tm7djg5NohOJa5DKXkXemtCpdSu6omG6ZiKH6F4FmLmLT9gcrRm
 dkwAou2J/xzaCUEnblqdqp/0DP8zj8helOTaTiXP/chjBEiYl+Z38txAvfMb7a9dpeORh4O
 7+UeloZQCqWocQGPNulKQD2j1beFQJhp3JkZG8ZrClOmnepu/Hon2vfYzBLUS4+Dl86UnDz
 +hh2y7W0KZzJyDsvykjjQ==
UI-OutboundReport: notjunk:1;M01:P0:HFfNeF8n4a8=;3lRigfYXG5ThfWxpo0RaJEhaxzD
 YhKYP92Ewoxo+24Gv1u7K+/XDbskmdn1R5dOjHi1L7JfgBH0qELuAMNqpn9cCrYLQiY9J1G9c
 ue8VqDUBue69hgWLtE2TqkWu+o2nQj5pcskyPm3ayvSdkFLMlpgg2/ZpPHx0tLDsTxvc8ygEp
 EwoIe0oB4K//p4VayU+sSoktkf6bafLzBoy0XRXXnkcKrB1dz9GgrlHnMalHn9D2kkRjescY6
 trfyuhLA069ZqaLmSEoP27dW2VWN6UePKhqgUvWnsepqa3Expy3D9Hc4JKgJld4EN9fd7IT2B
 X3BW3ahbRnSfMEbjpkS5kefAiipYAZQhuf1G2dMrCehyoG7oHxsVF5xOWAZoDVYzKvT2NupU/
 MybvD+5igzGmgD+KitSdsfuu7CYzODLg1X4ewraaIAfxmfgagNaVPADfxBXdsBVXEGeMZ0h14
 mtHc0m+y8kg/oDPwal5tm42DevVT100qDEmu5YbVLk0Ox3EpJSQ4HgNp6NKSsmNNpQ4bCVnlQ
 kdP6XkRG9IIz1x0kSWp1ak/JwUbLpmHsWwrtOna00QggRM8C6HabHqE+qpGw0KQVNkZPaU+D4
 f9OJblJpHfxj2LiR8iUQ/z20puTU8y4hjYzMuqUbleaKYuxikMIPxPSdP3xB4qEFGkCCGh8Cy
 CC0NFtETQHFZxRfm9tOOadjGAM7NmcdiAHy/HoDSsigUaiwaoYjiko30U+etuNtcLq5TxkXId
 vjORXu5ScANrvterxFA5e2KZwr4WKPWBEO2E+MuYQhwCCFuIu1HreyQmwX4vAA0jPM/7up1SS
 oSxQuUPz/1TV9zWI0xa6R++iD+FGVQZHgr+AH4fONCWTM=
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

On 06.08.24 14:58, Simon Glass wrote:
> Add a way to factor out the CFLAGS changes for each app, since they are
> all the same.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

The same could be done in lib/efi_selftest/Makefile.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>


> ---
>
> (no changes since v1)
>
>   lib/efi_loader/Makefile | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 660368b9d8f..00d18966f9e 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -11,16 +11,6 @@ asflags-y +=3D -I.
>   CFLAGS_efi_boottime.o +=3D \
>     -DFW_VERSION=3D"0x$(VERSION)" \
>     -DFW_PATCHLEVEL=3D"0x$(PATCHLEVEL)"
> -CFLAGS_boothart.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
> -CFLAGS_REMOVE_boothart.o :=3D $(CFLAGS_NON_EFI)
> -CFLAGS_helloworld.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
> -CFLAGS_REMOVE_helloworld.o :=3D $(CFLAGS_NON_EFI)
> -CFLAGS_smbiosdump.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
> -CFLAGS_REMOVE_smbiosdump.o :=3D $(CFLAGS_NON_EFI)
> -CFLAGS_dtbdump.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
> -CFLAGS_REMOVE_dtbdump.o :=3D $(CFLAGS_NON_EFI)
> -CFLAGS_initrddump.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
> -CFLAGS_REMOVE_initrddump.o :=3D $(CFLAGS_NON_EFI)
>
>   # These are the apps that are built
>   apps-$(CONFIG_RISCV) +=3D boothart
> @@ -80,5 +70,10 @@ obj-$(CONFIG_EFI_ECPT) +=3D efi_conformance.o
>   EFI_VAR_SEED_FILE :=3D $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
>   $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
>
> +# Set the C flags to add and remove for each app
> +$(foreach f,$(apps-y),\
> +	$(eval CFLAGS_$(f).o :=3D $(CFLAGS_EFI) -Os -ffreestanding)\
> +	$(eval CFLAGS_REMOVE_$(f).o :=3D $(CFLAGS_NON_EFI)))
> +
>   always +=3D $(foreach f,$(apps-y),$(f).efi)
>   targets +=3D $(foreach f,$(apps-y),$(f).o)

