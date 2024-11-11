Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D86D2E9DD
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 11:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F2A888FCE;
	Mon, 11 Nov 2024 12:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="E8doERfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F6DE88FAF; Mon, 11 Nov 2024 12:33:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB5488FCE
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 12:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731324834; x=1731929634; i=xypron.glpk@gmx.de;
 bh=AIAaLPUOQ8kLeZ+XtPpXm/Y8/piMeT+h20p0nuxOvPo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=E8doERflQjbHP5e1YUnGZP58Vmp7aXBIW86kUA+rpSeLaXKDUXNUtZdCVbY7hvcy
 a4l1o+TWpkjz40aGYw3rBB8DB9FQBPQ7Msd7Mtzq2kA4RnfHfJZxF4uzZ5UKYqIEB
 Z+/CuZJaxhxTsfJDZelsjxdXycij1yHjEPzApQvZwHjK7SoCHl0OWWLu7eu9iS5ew
 NKkFsZbNy3AFRFvK87WQfaWn/G4aeU9Gp24gYk+QyR9uaCThuDBy26h9e3MaIR5RH
 PDPD4xEMmfxcx+5UhpDI37u2dRHU3ADAIIYR/JoC0Xd+3LH4epY5UPtBuogCiB7wb
 IyQFrVE0X5wTSFabUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJhU-1tbn8g1Wbs-00lkyD; Mon, 11
 Nov 2024 12:33:54 +0100
Message-ID: <4fc7c91c-d228-4711-ba87-e8436736ae2e@gmx.de>
Date: Mon, 11 Nov 2024 12:33:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] efi: add helper functions to insert pmem node for DT
 fixup
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-5-sughosh.ganu@linaro.org>
 <22d941ba-3452-4e10-ae59-642786f3d92c@gmx.de>
 <CAC_iWjL9QDD55xiSzSYgb5FB7mBfP=m+KLOGAC5JGA_y4O1LUg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjL9QDD55xiSzSYgb5FB7mBfP=m+KLOGAC5JGA_y4O1LUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w0a7dSDoN1MP2kb3s5gV2WzxQxQqK9e0dlX7MfBL6rzAZZYOyHV
 +R76mJ2DBotKtz+4OqSOpeBTIZyk+BcWOAEaDFEDGxRFhQRWL4ajJkd7wcwbF1NVYYa0bOW
 N7eJCavEglfKUDpvEUR1eMKjOwGXJI5VwhkJ6Cx5Gv97lMQAm6+nizinu02voEyozbF3J7d
 ftmjzA0Jt9KbY76+4UhGw==
UI-OutboundReport: notjunk:1;M01:P0:8ylmd6RBmww=;vy2d0HTIq/MtRYs0Gd4RebRUNbY
 RP6GpyLT2lyES1hXCjQB1KTgjhAf76960jl7R+xkISM4MnTCt2bhrBVBVw7YE63Pasmbpbbcr
 3EsaBHrhc58gir2kLjVz7OnhGnkQqYJ7L9v0B6dri2lnK+IeipI2nedsohXDbpx1fHReApFXm
 W53XqeCZq2T3Z0lLp1CbaObpkUBq9HLnY44RJgAslbeTG7WB1QviHVXr/81HD439Jywx7JB9n
 Xa03Ly1pUBEZ6333A6TP2IXVxZBV06OW8zw+L33/1w3AwlgxyvzeN9LLwLfFFMHcXH8GnTRHV
 WStazFNdHHOW7PPYXR0+bHMg/0F3A5fkg/b8ZzhtnJDmZ11NcST8sneZFkYbFkxr1lyGVAwle
 BhXrYcX1+GlFgDeTbcr/ixm8jfOIUa8i97ter1XmlmrcCoua5bmh9YhaMdfnIbBXKzgpvPHCQ
 RMR3NW5UHbkekevOD4J3vbuoDGKjHpl43n5AcCwsHLQY7P8EVNyc8MzM+YrrLu39tCMahmiOT
 J7yw8E+ZpoY4xW7a2R3IOsBchd8eKl3Ck2fPC/uFJrnXN/nILqfqD1WislrVkR4zZUn20/hTS
 q2zR5gOyP9nnnPpfGw6yZ+Nq1YS/FS19lwYhCYDy/2DXpuoaiTHUTQOdQcZxXRX6isk50OeKC
 7ybd+xmKgcgpuNtYRBl/xx14c14862wglLYvgG2xepZuXsosYZOE5h7HA7JuXKW3SL0TwnKW/
 zn3qXQlpiuUWVDC0DLzDpC0Tyxd1eSKuTdBBB3kXCu6W4h7Snguqm9zrm48mkC0UkrBNlzD6K
 llBIePLgbz5WulRrV5uzF3TuZw0OyQlWyabClPhilVEFUyth+A6VEXKt/yYuZczCGOIugo5LP
 qOCCrmd5DcldOHsVu7h+wiG/KrzsOgY+G9OL72wcbxe0MtvkjMUkVoesVYiyyfYE2C8mmarw7
 aPOnYsysLEwf5V2XRLHuGVkGGLY=
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

On 11/11/24 11:45, Ilias Apalodimas wrote:
> Hi Heinrich
>
> On Mon, 11 Nov 2024 at 10:08, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 10/25/24 13:14, Sughosh Ganuefi_bootmgr_pmem_setup wrote:
>>> The EFI HTTP boot puts the iso installer image at some location in
>>> memory which needs to be reserved in the devicetree as persistent
>>> memory (pmem). Add helper functions which add this pmem node when the
>>> EFI_DT_FIXUP protocol's fixup callback is invoked.
>>>
>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> ---
>>>    boot/image-fdt.c             |  9 +++++++++
>>>    include/efi_loader.h         | 17 +++++++++++++++++
>>>    lib/efi_loader/efi_bootmgr.c | 21 +++++++++++++++++++++
>>>    lib/efi_loader/efi_helper.c  | 12 ++++++++++++
>>>    4 files changed, 59 insertions(+)
>>>
>>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>>> index 8eda521693..b39e81ad30 100644
>>> --- a/boot/image-fdt.c
>>> +++ b/boot/image-fdt.c
>>> @@ -11,6 +11,7 @@
>>>    #include <command.h>
>>>    #include <fdt_support.h>
>>>    #include <fdtdec.h>
>>> +#include <efi_loader.h>
>>>    #include <env.h>
>>>    #include <errno.h>
>>>    #include <image.h>
>>> @@ -648,6 +649,14 @@ int image_setup_libfdt(struct bootm_headers *imag=
es, void *blob, bool lmb)
>>>        if (!ft_verify_fdt(blob))
>>>                goto err;
>>>
>>> +     if (CONFIG_IS_ENABLED(EFI_HTTP_BOOT)) {
>>> +             fdt_ret =3D fdt_efi_pmem_setup(blob);
>>
>> I can see no reason why pmem setup should depend on HTTP boot.
>
> The reason is that we *know* we want to preserve image on HTTP
> installers. but we should only add it if that image is booted, not
> unconditionally if EFI_HTTP is enabled
>
>>
>> It should be possible to pass a memory block device to the kernel no
>> matter how it was created.
>
> Yes, we can. But how do we know we need to setup a pmem node? In this
> specific case, we know http installers need the image.
> If we can find similar rules (or perhaps a command line option), we
> can preserve it for all images

Simon is working on patches to track loaded images. I guess there we
would need to add the detection of image types including bare kernels,
EFI binaries, and ISOs.

>
> Thanks
> /Ilias
>>
>> Best regards
>>
>> Heinrich
>>
>>> +             if (fdt_ret) {
>>> +                     printf("ERROR: HTTP boot pmem fixup failed\n");

Please, use log_err() and remove "ERROR: ".

>>> +                     goto err;
>>> +             }
>>> +     }
>>> +
>>>        /* after here we are using a livetree */
>>>        if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
>>>                struct event_ft_fixup fixup;
>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>>> index d450e304c6..031de18746 100644
>>> --- a/include/efi_loader.h
>>> +++ b/include/efi_loader.h
>>> @@ -748,6 +748,15 @@ bool efi_varname_is_load_option(u16 *var_name16, =
int *index);
>>>    efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
>>>                                    efi_guid_t *guid);
>>>
>>> +/**
>>> + * fdt_efi_pmem_setup() - Setup the pmem node in the devicetree
>>> + *
>>> + * @fdt:     Pointer to the devicetree
>>> + *
>>> + * Return:   0 on success, negative on failure
>>> + */
>>> +int fdt_efi_pmem_setup(void *fdt);
>>> +
>>>    /**
>>>     * efi_size_in_pages() - convert size in bytes to size in pages
>>>     *
>>> @@ -964,6 +973,14 @@ efi_status_t efi_set_load_options(efi_handle_t ha=
ndle,
>>>                                  void *load_options);
>>>    efi_status_t efi_bootmgr_load(efi_handle_t *handle, void **load_opt=
ions);
>>>
>>> +/**
>>> + * efi_bootmgr_pmem_setup() - Put a pmem node for UEFI HTTP installer=
s
>>> + *
>>> + * @fdt:     Pointer to the DT blob
>>> + * Return:   status code
>>> + */
>>> +efi_status_t efi_bootmgr_pmem_setup(void *fdt);
>>> +
>>>    /**
>>>     * struct efi_image_regions - A list of memory regions
>>>     *
>>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr=
.c
>>> index 16f75555f6..1d9246be61 100644
>>> --- a/lib/efi_loader/efi_bootmgr.c
>>> +++ b/lib/efi_loader/efi_bootmgr.c
>>> @@ -41,6 +41,8 @@ struct uridp_context {
>>>        efi_handle_t mem_handle;
>>>    };
>>>
>>> +static struct uridp_context *uctx;
>>> +
>>>    const efi_guid_t efi_guid_bootmenu_auto_generated =3D
>>>                EFICONFIG_AUTO_GENERATED_ENTRY_GUID;
>>>
>>> @@ -423,6 +425,7 @@ efi_status_t efi_bootmgr_release_uridp(struct urid=
p_context *ctx)
>>>
>>>        efi_free_pool(ctx->loaded_dp);
>>>        free(ctx);
>>> +     uctx =3D NULL;
>>>
>>>        return ret =3D=3D EFI_SUCCESS ? ret2 : ret;
>>>    }
>>> @@ -443,6 +446,23 @@ static void EFIAPI efi_bootmgr_http_return(struct=
 efi_event *event,
>>>        EFI_EXIT(ret);
>>>    }
>>>
>>> +/**
>>> + * efi_bootmgr_pmem_setup() - Put a pmem node for UEFI HTTP installer=
s
>>> + *
>>> + * @fdt:     Pointer to the DT blob
>>> + * Return:   status code
>>> + */
>>> +efi_status_t efi_bootmgr_pmem_setup(void *fdt)
>>> +{
>>> +     if (!uctx) {
>>> +             log_warning("No EFI HTTP boot context found\n");

Are we writing a warning here when loading grubriscv64.efi from disk and
executing it?

Best regards

Heinrich

>>> +             return EFI_SUCCESS;
>>> +     }
>>> +
>>> +     return !fdt_fixup_pmem_region(fdt, uctx->image_addr, uctx->image=
_size) ?
>>> +             EFI_SUCCESS : EFI_INVALID_PARAMETER;
>>> +}
>>> +
>>>    /**
>>>     * try_load_from_uri_path() - Handle the URI device path
>>>     *
>>> @@ -472,6 +492,7 @@ static efi_status_t try_load_from_uri_path(struct =
efi_device_path_uri *uridp,
>>>        if (!ctx)
>>>                return EFI_OUT_OF_RESOURCES;
>>>
>>> +     uctx =3D ctx;
>>>        s =3D env_get("loadaddr");
>>>        if (!s) {
>>>                log_err("Error: loadaddr is not set\n");
>>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
>>> index 00167bd2a1..33cd8b9a50 100644
>>> --- a/lib/efi_loader/efi_helper.c
>>> +++ b/lib/efi_loader/efi_helper.c
>>> @@ -242,6 +242,18 @@ int efi_unlink_dev(efi_handle_t handle)
>>>        return 0;
>>>    }
>>>
>>> +/**
>>> + * fdt_efi_pmem_setup() - Setup the pmem node in the devicetree
>>> + *
>>> + * @fdt:     Pointer to the devicetree
>>> + *
>>> + * Return:   0 on success, negative on failure
>>> + */
>>> +int fdt_efi_pmem_setup(void *fdt)
>>> +{
>>> +     return efi_bootmgr_pmem_setup(fdt) =3D=3D EFI_SUCCESS ? 0 : -1;
>>> +}
>>> +
>>>    static int u16_tohex(u16 c)
>>>    {
>>>        if (c >=3D '0' && c <=3D '9')
>>

