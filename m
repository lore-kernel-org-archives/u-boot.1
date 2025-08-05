Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFA0C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 16:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB1184166;
	Tue,  5 Aug 2025 18:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lpVuVhxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 618BB84167; Tue,  5 Aug 2025 18:29:01 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F358402E
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 18:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7e7fb58425cso339595285a.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754411336; x=1755016136; darn=lists.denx.de;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qziT046YMZ02XhMjVGvkkxVy3L6RTmRcQYplflo+eA=;
 b=lpVuVhxUBYZnYJGoitsAp/7QkIK4ptZc8R3EboUErxOSkgSt9mvxpxEm1vkqd/ID6v
 3xoEq077UskKwjpT9mV1bOfoMx9jGbOj8qyCiaFW6E6LLQw85eSlEJjyz8U54cgDLkhr
 1dKCDfOdq/X4qc3cUsf1iUYMbFm5Q6sPbrwXMuJbBoDLEwifAGWM/GKJSBPCyJOqD5EZ
 Eurd/RDGacU12DzSY+Y8isq2247VvcIPidpP9r03TwkUn26nvOjBDlqhrnlpJJp4IrYK
 +9wG4A+QFY8+LkahEhdGx6HzAVgeWrFFYVWxmw8PNOtpX2Qat+a1mzLvxM4fNUQAvq7m
 csvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754411336; x=1755016136;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8qziT046YMZ02XhMjVGvkkxVy3L6RTmRcQYplflo+eA=;
 b=mxplKi1Gd/d6Dj0oJ050H142GHRKRWV/xcINgrFL1HJ3Ghfbwde0luzTlllJdnLVfd
 fT0rr3Vo1IM7CQr1SIeQqJSTOsVvQ5zbdOjZ8y3bhe2w243QGTuFB8k8WVMDIUP7aTaB
 wWI87i3dqEaMMyTI5bvanrsj+g3uYm+k/DlrD3pJMzNj5HYV5u7aaDGUJHYWLW78dT5R
 THwiGGZUMSb9NOd1gnfoJhXiG5xW7R6GylCGveP6oKsg3Hv6lwEbZQRNce2EvuQjUEWj
 1pgRZqveS/MJlzjOKWcc9ySzGAb4aJ06lMEBKi+b63L6M0LOYumrSgZlxBKQFMPtFmTB
 tviw==
X-Gm-Message-State: AOJu0Yy+P7k7tjqEyw3HrLLUnUSTxPw+GNavywg3tSYjJS4BWXOF5GwZ
 Jc3LGGxTxW8o5bG9BbrVWRuD0aedbdopc4r1Wj2kX0gIkDAhnKMyFFErvULjBwzQp14=
X-Gm-Gg: ASbGncvfZXM+1cuvPfju1gN+oYRMlj7MLhGVRFk7D47nO4P7Tuf0oeeT7Is4tUBZMgh
 CNPoxEMFHnbNVGHIytYQw8Ooz69Mi8ZdYRurH7geBk4TBQtFY3h13gsmVaK++iSh9dyW7wuSTV+
 AgFX0vuhjm484WI1/IUgYKZT+MbYPEc+p4ZDWqrqUUVsYehuAYu8ZNLFxb7Xl/EI4UZg6nPiG/7
 cDdNuJLY5Y1Tw0+MWsBVsfei6oC56VHZd/XLZ8iSGP8glB6uHKY6J2vTkJgw5wG0p0cQr6mh+DU
 DvQfZCAyJ0AephY1yKE3+wEDyb1Tk+6ZMvepzqU5SeDMhhBR9uSXfymtPQtDOrQT5J3DITGdOhp
 Xt7m3XWYYBmhMkZ9u4v4IbnOi1IlNBUjztmsa2sbg0AO+YOblsY3WMccsnWX7oBszvy+hgnQnO/
 0XEjjVJk73SUT5iGTY7cb5ONUeY44epvkCJ18=
X-Google-Smtp-Source: AGHT+IHrTAqzNDArvuAQUAzNHuiA4t9CwggxkiwOw3WG5YdptadSstv34NLLNfP30it5bcTd0cTcfA==
X-Received: by 2002:a05:620a:4e2:b0:7d4:2c9:e0c4 with SMTP id
 af79cd13be357-7e6962c16c4mr1378652285a.28.1754411336428; 
 Tue, 05 Aug 2025 09:28:56 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com
 (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f594353sm674940085a.17.2025.08.05.09.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 09:28:56 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id 9CDE6F40066;
 Tue,  5 Aug 2025 12:28:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-05.internal (MEProxy); Tue, 05 Aug 2025 12:28:55 -0400
X-ME-Sender: <xms:RzGSaIKYYpRMbUB4xJ71K0TDz751WBHi5Mbxql9Uudg_ziFABr3hrQ>
 <xme:RzGSaILXzV4HOhsuoEX2oEmDVhYMR1_MpLv07rYhZh2l77sIkz_4RikAaydVIEn5g
 pZFm_bdSM4rgJ7QuXc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehieehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfgrvhhi
 vghrucfvihgrfdcuoehjrghvihgvrhdrthhirgeslhhinhgrrhhordhorhhgqeenucggtf
 frrghtthgvrhhnpefhfeetvdfhgfeifeeuudefudeuvdfhueehteeftddvkeehtdetveei
 gfekhedtkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrvhhivghrodhmvghsmhhtphgr
 uhhthhhpvghrshhonhgrlhhithihqdduhedvkeekleehkeefqdefudefieegvdeliedqjh
 grvhhivghrrdhtihgrpeeplhhinhgrrhhordhorhhgsehjvghtmhdrmhgvpdhnsggprhgt
 phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeighihprhhonhdrgh
 hlphhksehgmhigrdguvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtgho
 mhdprhgtphhtthhopehilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorh
 hgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:RzGSaMR5eSds0X1iqr16c6b524rwxiyRTetLUVlolR-mGUg0dp-Ixw>
 <xmx:RzGSaDMmENjVx_E0081DY_yNhRY0kNhrfTWm245vY6b7eg3joRpESw>
 <xmx:RzGSaJZjzEAw3MpkMfwI7sJwE-nZLEg3oMbk0zc52LZO9_wSKK-1iA>
 <xmx:RzGSaFw-sqKix4XA_77mF3J-ribCqSHy1wWcpThRlSGZOzEEw2zAdw>
 <xmx:RzGSaMIb6MnB6IQiPY9R7NPhqIORNBaxlSOA2gdT-J7tvUGBtp2SAEBv>
Feedback-ID: idd3648b2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 750231EA0066; Tue,  5 Aug 2025 12:28:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T1e633cd8cd6b782a
Date: Tue, 05 Aug 2025 10:28:35 -0600
From: "Javier Tia" <javier.tia@linaro.org>
To: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, "Tom Rini" <trini@konsulko.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Message-Id: <e621f945-5ff3-42e4-b5b6-26269c9ce375@app.fastmail.com>
In-Reply-To: <CAC_iWj+YzzLnw5eHQaVQaS6+rAo2YjhARQDzYspwW2VtjvXWrQ@mail.gmail.com>
References: <20250731213547.654823-1-javier.tia@linaro.org>
 <CAC_iWj+YzzLnw5eHQaVQaS6+rAo2YjhARQDzYspwW2VtjvXWrQ@mail.gmail.com>
Subject: Re: [PATCH] disk: Use part_driver_lookup_type() to valid downloaded
 image
Content-Type: text/plain; charset=utf-8
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

Hi Ilias,

On Tue, Aug 5, 2025, at 2:25 AM, Ilias Apalodimas wrote:
> Hi Javier
>
> On Fri, 1 Aug 2025 at 00:35, Javier Tia <javier.tia@linaro.org> wrote:
>>
>> The part_driver_lookup_type() function was made public to be used in =
the
>> EFI loader. This function is used to look up the partition type for a
>> block device.
>>
>> This change allows the EFI loader to detect disk images by using the
>> partition driver lookup. This replaces the previous method of checking
>> the file extension, which was less optimal.
>>
>> The EFI loader generates a temporary block device from the downloaded
>> image, employs the part_driver_lookup_type() function to verify the
>> partition type, and checks if it corresponds to a valid ISO 9660, DOS
>> MBR, or GPT EFI disk image, subsequently performing cleanup of the
>> temporary device. If the downloaded file does not constitute a valid
>> disk image, an error message will be logged, and the function will
>> return EFI_UNSUPPORTED.
>>
>> Signed-off-by: Javier Tia <javier.tia@linaro.org>
>> ---
>>  disk/part.c                  |  3 +-
>>  include/part.h               | 18 +++++++++
>>  lib/efi_loader/efi_bootmgr.c | 76 +++++++++++++++++++++++++++++++---=
--
>>  3 files changed, 87 insertions(+), 10 deletions(-)
>>
>> diff --git a/disk/part.c b/disk/part.c
>> index 66e2b3a7219..adc24976624 100644
>> --- a/disk/part.c
>> +++ b/disk/part.c
>> @@ -63,7 +63,7 @@ static struct part_driver *part_driver_get_type(int=
 part_type)
>>   * @dev_desc: Device descriptor
>>   * Return: Driver found, or NULL if none
>>   */
>> -static struct part_driver *part_driver_lookup_type(struct blk_desc *=
desc)
>> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
>>  {
>>         struct part_driver *drv =3D
>>                 ll_entry_start(struct part_driver, part_driver);
>> @@ -855,3 +855,4 @@ int part_get_bootable(struct blk_desc *desc)
>>
>>         return 0;
>>  }
>> +
>> diff --git a/include/part.h b/include/part.h
>> index b772fb34c8a..3fc3186f4c4 100644
>> --- a/include/part.h
>> +++ b/include/part.h
>> @@ -727,6 +727,24 @@ int part_get_type_by_name(const char *name);
>>   */
>>  int part_get_bootable(struct blk_desc *desc);
>>
>> +/**
>> + * part_driver_lookup_type() - Look up the partition driver for a bl=
k device
>> + *
>> + * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each partit=
ion driver
>> + * against the blk device to see if there is a valid partition table=
 acceptable
>> + * to that driver.
>> + *
>> + * If @desc->part_type is already set, it just returns the driver fo=
r that
>> + * type, without testing if the driver can find a valid partition on=
 the
>> + * descriptor.
>> + *
>> + * On success it updates @desc->part_type if set to PART_TYPE_UNKNOW=
N on entry
>> + *
>> + * @desc: Device descriptor
>> + * Return: Driver found, or NULL if none
>> + */
>> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc);
>> +
>>  #else
>>  static inline int part_driver_get_count(void)
>>  { return 0; }
>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmg=
r.c
>> index 662993fb809..f6729a40462 100644
>> --- a/lib/efi_loader/efi_bootmgr.c
>> +++ b/lib/efi_loader/efi_bootmgr.c
>> @@ -17,6 +17,7 @@
>>  #include <log.h>
>>  #include <malloc.h>
>>  #include <net.h>
>> +#include <part.h>
>>  #include <efi_loader.h>
>>  #include <efi_variable.h>
>>  #include <asm/unaligned.h>
>> @@ -407,7 +408,7 @@ static efi_status_t efi_bootmgr_release_uridp(str=
uct uridp_context *ctx)
>>         if (!ctx)
>>                 return ret;
>>
>> -       /* cleanup for iso or img image */
>> +       /* cleanup for disk image */
>>         if (ctx->ramdisk_blk_dev) {
>>                 ret =3D efi_add_memory_map(ctx->image_addr, ctx->imag=
e_size,
>>                                          EFI_CONVENTIONAL_MEMORY);
>> @@ -452,6 +453,17 @@ static void EFIAPI efi_bootmgr_http_return(struc=
t efi_event *event,
>>         EFI_EXIT(ret);
>>  }
>>
>> +/**
>> + * cleanup_temp_blkdev() - Clean up temporary block device
>> + *
>> + * @temp_bdev: temporary block device to clean up
>> + */
>> +static void cleanup_temp_blkdev(struct udevice *temp_bdev)
>> +{
>> +       if (blkmap_destroy(temp_bdev->parent))
>> +               log_err("Destroying temporary blkmap failed\n");
>> +}
>
> No need to add a new function for a call, just call blkmap_destroy() d=
irectly.
> If you want to keep it as a separate function, just move the if
> (temp_bdev) in here.

I have addressed this comment and the two below with:

https://lore.kernel.org/u-boot/20250805162158.117876-1-javier.tia@linaro=
.org/T/#u

Thanks,

>> +
>>  /**
>>   * try_load_from_uri_path() - Handle the URI device path
>>   *
>> @@ -466,7 +478,6 @@ static efi_status_t try_load_from_uri_path(struct=
 efi_device_path_uri *uridp,
>>  {
>>         char *s;
>>         int err;
>> -       int uri_len;
>>         efi_status_t ret;
>>         void *source_buffer;
>>         efi_uintn_t source_size;
>> @@ -516,13 +527,55 @@ static efi_status_t try_load_from_uri_path(stru=
ct efi_device_path_uri *uridp,
>>         image_size =3D ALIGN(image_size, SZ_2M);
>>
>>         /*
>> -        * If the file extension is ".iso" or ".img", mount it and tr=
y to load
>> -        * the default file.
>> -        * If the file is PE-COFF image, load the downloaded file.
>> +        * Check if the downloaded file is a disk image or PE-COFF im=
age.
>> +        * Use partition driver lookup for disk image detection.
>>          */
>> -       uri_len =3D strlen(uridp->uri);
>> -       if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
>> -           !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
>> +       struct udevice *temp_bdev;
>> +       struct part_driver *part_drv =3D NULL;
>> +
>> +       /* Create temporary block device from the downloaded image fo=
r testing */
>> +       temp_bdev =3D mount_image(lo_label, image_addr, image_size);
>> +       if (!temp_bdev) {
>> +               log_debug("mount_image() failed, will attempt PE-COFF=
 detection\n");
>> +       }
>
> It's a single line in the if, drop the {}
>
>> +       if (temp_bdev) {
>> +               struct blk_desc *desc =3D dev_get_uclass_plat(temp_bd=
ev);
>> +               if (!desc) {
>> +                       /* Clean up temporary device when dev_get_ucl=
ass_plat() returns NULL */
>> +                       cleanup_temp_blkdev(temp_bdev);
>> +               } else {
>> +                       /* Use part_driver_lookup_type for comprehens=
ive partition detection */
>> +                       part_drv =3D part_driver_lookup_type(desc);
>> +
>> +                       /* Validate partition type */
>> +                       if (part_drv) {
>> +                               if (part_drv->part_type !=3D PART_TYP=
E_DOS &&
>> +                                   part_drv->part_type !=3D PART_TYP=
E_ISO &&
>> +                                   part_drv->part_type !=3D PART_TYP=
E_EFI) {
>
> Why does it have to be one of those partition types? The EFI spec does
> not require the ESP to be a FAT.
>
>> +                                       log_err("Unsupported partitio=
n type 0x%02x for EFI boot. "
>> +                                                       "Only MBR DOS=
, ISO, and EFI partition types are supported.\n",
>> +                                                       part_drv->par=
t_type);
>> +
>> +                                       /* Clean up temporary device =
*/
>> +                                       cleanup_temp_blkdev(temp_bdev=
);
>> +
>> +                                       /* Set part_drv to NULL to fa=
ll through to PE-COFF detection */
>> +                                       part_drv =3D NULL;
>> +                               }
>> +                       }
>> +
>> +                       /*
>> +                        * If it's a disk image with supported partit=
ion type,
>> +                        * prepare_loaded_image will create the final=
 block device
>> +                        */
>> +                       if (part_drv) {
>> +                               /* Clean up temporary device, prepare=
_loaded_image will create a new one */
>> +                               cleanup_temp_blkdev(temp_bdev);
>> +                       }
>> +               }
>> +       }
>> +
>> +       if (part_drv) {
>>                 ret =3D prepare_loaded_image(lo_label, image_addr, im=
age_size,
>>                                            &loaded_dp, &blk);
>>                 if (ret !=3D EFI_SUCCESS)
>> @@ -545,7 +598,12 @@ static efi_status_t try_load_from_uri_path(struc=
t efi_device_path_uri *uridp,
>>                 source_buffer =3D (void *)image_addr;
>>                 source_size =3D image_size;
>>         } else {
>> -               log_err("Error: file type is not supported\n");
>> +               /* Clean up temporary device if it was created but no=
t a valid disk image */
>> +               if (temp_bdev) {
>> +                       cleanup_temp_blkdev(temp_bdev);
>> +               }
>> +
>> +               log_err("Error: disk image is not supported\n");
>>                 ret =3D EFI_UNSUPPORTED;
>>                 goto err;
>>         }
>> --
>> 2.50.1
>>
>
> Thanks
> /Ilias

--=20
=C2=BB Javier Tia =E2=9C=8D
