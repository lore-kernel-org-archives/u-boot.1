Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1874FC3ABB9
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 10:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 587CB81F7B;
	Mon,  5 May 2025 12:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="MsrzOgJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A01820E1; Mon,  5 May 2025 12:09:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1CF480F03
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 12:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746439771; x=1747044571; i=fiona.klute@gmx.de;
 bh=OnAkEYosA0PNu673LF8K5m6y9SZ4gDnn0eYLSZ+96ek=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MsrzOgJLKCqwSfiOy1xTKN4apWQdD5UG1EmApMpoIvU5wVDSe6wP1thuUbXPJRjv
 LIMlvCPp1cm5FRdPLeeJzLp9XPdskRjoQIm1WcCBQFIfUd9iYjEP3XvCr+RjnDMED
 UIAtitKtbQxJtBh+kok0bIvi8gR699VGlJaBaK6hmMb9MIyroZc5hIrB/3I3XAhjW
 Pz1czmDEgcFcvlGw0hLuZT8EeaEEXcAnjBE2iQnfWYfxZmY53Ab2onCSk3BIzFQLv
 enjLhacSooo6j+wjpbmZeFXLsk7YcDZAgzTmzGmQeO5a8wZbPv3DBCISTD41x4gud
 htaUwloiPKKtdTSatA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.125.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1vA3lY1jcB-00tXLH; Mon, 05
 May 2025 12:09:31 +0200
Message-ID: <8b8386f2-7a85-499d-956a-11a22b3cb10c@gmx.de>
Date: Mon, 5 May 2025 12:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Raspberry Pi: copy /system/linux,{serial,revision} from
 firmware
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>
References: <20250211135829.3467088-1-fiona.klute@gmx.de>
 <CALeDE9Oumn2xO0MPq+L5rsv5NEAjL=XM8zRNA38uV+MbqkVrzw@mail.gmail.com>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <CALeDE9Oumn2xO0MPq+L5rsv5NEAjL=XM8zRNA38uV+MbqkVrzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w+hFa6yEhLF4S6ASt506ZzxmtXubBiwzW+gHpu8XIOYf2uygwJg
 AZ+GHsgKDD82hhFRenw1KTdLhv9zX08ellZ9xzfYPtGSTJ1vrQJWE+349CMrSnrCZwGKwVj
 fW38izZaHEhzXr/fBd2x1tkqpXTD8DXwXUotx/6+zC18CJnm1G1Cut1zNLwBiHlxYtMUKPf
 KD1UX9ltvd8lUmebqFbxg==
UI-OutboundReport: notjunk:1;M01:P0:e5NjC8aCaQQ=;AMAyeaBCbB/YQj1b46J2UZsyA/Q
 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
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

Hi Peter, everyone,

do you have any comments? My main concern is if creating a temporary=20
overlay is the right approach here, or if there's better way to create=20
the /system node if needed.

Best regards,
Fiona

Am 15.02.25 um 14:01 schrieb Peter Robinson:
> Hi Fiona,
>=20
> I'll review and test this the coming week and provide feedback.
>=20
> On Tue, 11 Feb 2025 at 13:58, Fiona Klute <fiona.klute@gmx.de> wrote:
>=20
>> Both the Raspberry Pi downstream kernel [1] and some userspace tools
>> [2] use the revision property to identify the board, and the latter
>> fails if it is absent. The firmware creates the /system node, so we
>> need to do the same.
>>
>> [1]
>> https://github.com/raspberrypi/linux/blob/0f292fbb6346b0576615290207689=
5558ac23f9a/arch/arm/mach-bcm/board_bcm2835.c#L23-L33
>> [2]
>> https://github.com/jgarff/rpi_ws281x/blob/7fc0bf8b31d715bbecf28e852ede5=
aaa388180da/rpihw.c#L579
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> Cc: Matthias Brugger <mbrugger@suse.com>
>> Cc: Peter Robinson <pbrobinson@gmail.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>> I'm sending this as RFC because I'm not sure if creating a temporary
>> overlay is the best approach here, advice on a better way to create the
>> /system node if needed is very much welcome. I know I'll need to add
>> more error checks, I'll do that after I know I have the right approach.
>>
>>   board/raspberrypi/rpi/rpi.c | 37 ++++++++++++++++++++++++++++++++++++=
+
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
>> index aa39afa338a..647716127c7 100644
>> --- a/board/raspberrypi/rpi/rpi.c
>> +++ b/board/raspberrypi/rpi/rpi.c
>> @@ -550,6 +550,41 @@ int copy_property(void *dst, void *src, char *path=
,
>> char *property)
>>          return fdt_setprop(dst, dst_offset, property, prop, len);
>>   }
>>
>> +int copy_system_node(void *fdt, void *fw_fdt)
>> +{
>> +       const fdt32_t *prop;
>> +       char fdto[2048];
>> +       int src_offset;
>> +       int len;
>> +
>> +       src_offset =3D fdt_path_offset(fw_fdt, "/system");
>> +       if (src_offset < 0)
>> +               return -1;
>> +
>> +       fdt_create(fdto, sizeof(fdto));
>> +       fdt_finish_reservemap(fdto);
>> +       fdt_begin_node(fdto, "");
>> +       fdt_begin_node(fdto, "fragment");
>> +       fdt_property_string(fdto, "target-path", "/");
>> +       fdt_begin_node(fdto, "__overlay__");
>> +       fdt_begin_node(fdto, "system");
>> +
>> +       prop =3D fdt_getprop(fw_fdt, src_offset, "linux,serial", &len);
>> +       if (prop)
>> +               fdt_property(fdto, "linux,serial", prop, len);
>> +       prop =3D fdt_getprop(fw_fdt, src_offset, "linux,revision", &len=
);
>> +       if (prop)
>> +               fdt_property(fdto, "linux,revision", prop, len);
>> +
>> +       fdt_end_node(fdto);
>> +       fdt_end_node(fdto);
>> +       fdt_end_node(fdto);
>> +       fdt_end_node(fdto);
>> +       fdt_finish(fdto);
>> +
>> +       fdt_overlay_apply_verbose(fdt, fdto);
>> +}
>> +
>>   /* Copy tweaks from the firmware dtb to the loaded dtb */
>>   void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>>   {
>> @@ -560,6 +595,8 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>>          /* The firmware provides a more precise model; so copy that */
>>          copy_property(fdt, fw_fdt, "/", "model");
>>
>> +       copy_system_node(fdt, fw_fdt);
>> +
>>          /* memory reserve as suggested by the firmware */
>>          copy_property(fdt, fw_fdt, "/", "memreserve");
>>
>> --
>> 2.47.2
>>
>>
