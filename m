Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D23C54E60
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 12:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FBA387F46;
	Tue, 12 Mar 2024 13:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="W3oX3gcj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D252B87F3F; Tue, 12 Mar 2024 13:30:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE7B87F47
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 13:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1710246605; x=1710851405; i=xypron.glpk@gmx.de;
 bh=4UfY7XcEp0X/np7bcK34b2lJH2KKjKwZwCrpW2zXvoo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=W3oX3gcj/WnXGiWCrA0o4v+zIuuO9QK/uxlrIDSl1sLrd/3pkPTdzPsMYLPyrrnw
 EUfICyIsjkXwDr5GJzcrjH3hCpszCg+phawrW/4u3LBDjEj7IJm/8FkdoiSXxsnF2
 wJi/SQ4kESObP0EH9EpAcewtsXIf0QcZQPhbFI7f13oGmqSH3VumsVROFp2wjovGI
 iNnDbrb8ozA/EWJKQ3vBV8euFj8/RasjpEt5at0igiDLlz+T8apemlP4thHAPXQnl
 qycE/HxUdGx9v6dBPjLnrJnwyX7AziXBJx1UtgXfh2gJBclxjUQ/xzd6LC4W7im7Q
 OQloqOLo93n95am2Vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvPD-1rKy0e0tdN-00RmOo; Tue, 12
 Mar 2024 13:30:05 +0100
Message-ID: <503983a7-89a2-4673-a2f5-1d6396ea63b4@gmx.de>
Date: Tue, 12 Mar 2024 13:29:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Do not describe u-boot.itb if SPL is
 disabled
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
 <Zec-oE2mzj7Pngo3@hera>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <Zec-oE2mzj7Pngo3@hera>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s4KwLzVZQ7Ww+QCVLElOxjCm6HPl5u3duRWTocbACiT9zWLC8+d
 4iCGxiReLHtQdywAfQh+XXbWSAMCBWRuwEu92z059w+E4aenFFBDG/N8MYo7/mBnCoZGN5G
 Ap3yNpXsjxiKzqjChBEowGb5hRfQmdQM/yoTW3NxuWVNAk9jVnJx1cXX8HIYSmlS9v75QrX
 htrI5u2NnGA6L1D9V0ydw==
UI-OutboundReport: notjunk:1;M01:P0:0RVAMOrnjCk=;mifsMa5JOALcI7YafruZKF8i7Us
 cIZaRB+hGW0ja0qz0qDd68JSq7XaelrcskTaSVGGQGaTbkUfaXuLNxzVTG0Sn8mUICrfkR/ZY
 liJLHleBiaxWlcTiiprvqG3QNwK4uqZV+8D8VY220SMv6H5IX1hZHmGZcUH8L/LKE/6maguux
 kjV/o2/qjvjEhNZbFRPhrvNUqJQhWmYiWdKaDH7wWtkD0wHgOTZRV9sREcdjX+5WlwrSmC0TY
 qhku89nAm50LXLzs0/iiZttc2R3zJQDvp02lIlfRihHR2qEcUqCKntcya8/HQHM+xg8QFAAKl
 mJTfbvyaNfWZ4AgFEX3VD4mlcogtoYr2eG2mumu3Mpex/45qr/xAt78bULQGnEi7uQShjvOLB
 VuY1GrvL9BYOItN2HKLHNt1BttKrCjg65XDBdlTMSO0iaZGhRHmzEZ7wcjEIaZreBBLQbQ28g
 P8VWJ0hbh6f19U6sxLgQa6Kkv78HGOPckR/cKgHEQujdgyDpoBbWekLwx0PZ1nX38PNLF17aX
 P9J2rPa9JKvpWhV+7QeYRLt8rOXk3Fzt8MuA+QwDh2rmOhej5+eiCL3ovbSZoKGCRQ4A+Is2+
 C/Q3To8ZCQo+lvmnEMMBoLAhTo3BAOJU6Ja19UYPyUxLEFBnLB70ZK7e9xjm3cj5ugT93E0jk
 Z0q2HNJJOVbOOTDxaznlLPSjLV6ZaLUQaJEKoB9PCGevC92UEAqA5DMp/SHe28E5Q1EWTe4x0
 fD0I3uiuZQghD3/hlCE7IoQwT0oHM7uMCmFB4DDx+FP5gc/e9X1xbT9RkAl6/iRq6ue0ylUj7
 eK/3ue61r9jhmo750JYAeIjkBghvZZXaUeIU3KVAyqU9E=
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

On 05.03.24 16:47, Ilias Apalodimas wrote:
> On Fri, Feb 23, 2024 at 05:18:42PM +0100, Michal Simek wrote:
>> There is no reason to describe u-boot.itb on system without SPL. Pretty
>> much this is cover all systems which are using only boot.bin which cont=
ains
>> all images inside.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   board/xilinx/common/board.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
>> index 9641ed307b75..4f38b7d27684 100644
>> --- a/board/xilinx/common/board.c
>> +++ b/board/xilinx/common/board.c
>> @@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] =3D {
>>   		.image_index =3D 1,
>>   	},
>>   #endif
>> -#if defined(XILINX_UBOOT_IMAGE_GUID)
>> +#if defined(XILINX_UBOOT_IMAGE_GUID) && defined(CONFIG_SPL_FS_LOAD_PAY=
LOAD_NAME)
>
> What happens if this is defined with CONFIG_SPL_FS_LOAD_PAYLOAD_NAME=3D"=
" ?

CONFIG_SPL_FS_LOAD_PAYLOAD_NAME depends on SPL_FS_EXT4 || SPL_FS_FAT ||
SPL_FS_SQUASHFS || SPL_SEMIHOSTING. So it is only defined if SPL could
load a file.

CONFIG_SPL_FS_LOAD_PAYLOAD_NAME defaults to a non-blank name. If a user
provides an invalid name, SPL will not be able to load the file.

What is wrong here is to assume that *.itb has to be load as a file. We
can configure U-Boot SPL to load the itb from a raw partition.

The check might be too restrictive.

Best regards

Heinrich

>
> Cheers
> /Ilias
>>   	{
>>   		.image_type_id =3D XILINX_UBOOT_IMAGE_GUID,
>>   		.fw_name =3D u"XILINX-UBOOT",
>> --
>> 2.36.1
>>

