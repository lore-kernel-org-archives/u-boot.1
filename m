Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4F9C83F10
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 16:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A246E86199;
	Sun, 27 Aug 2023 18:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mGkyPVlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221C086199; Sun, 27 Aug 2023 18:32:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77DBE84B20
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 18:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693153934; x=1693758734; i=xypron.glpk@gmx.de;
 bh=pGdkQHjlCjgbNcwy9LCdxiKU4JICsdmIt0YeWXL/FdM=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=mGkyPVlfn5NSt2MpJ4bksdpZtRuQdKRg25Jw7khmuvRqrDrljM9H/vpPq4MaQcljpHy4pkj
 9OG0hhlrz1n9cRHeQCXrCi5RKPJkkZwNVHUd7OWMEPYYXSXbBE2z/BLqo3caVsNOAvX/UYFmx
 UEUBRbqwYUN3Sq0NFj+vCsU0lAnXFGrm9z9o5O42TirgBUt0/1IdhnbWhnTgZt+CqD27LT813
 Fbp6iRFcRGIiBfoNklrzc12vy2lJI+ha8g6HBHUqCLZsgZ4E9DLKRtwm/mosRXBEuyvZixbm7
 MQnRL9tkZyAvsK0S/njVd/i7foFQ0BzUXPDSmpn8F9Vjcz3Hlagw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryXN-1pxcQV0uv7-00o2Ur; Sun, 27
 Aug 2023 18:32:14 +0200
Date: Sun, 27 Aug 2023 18:32:13 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] efi: Correct handling of frame buffer
User-Agent: K-9 Mail for Android
In-Reply-To: <af866d03-d097-48b9-994a-450ac4702d34@gmail.com>
References: <20230825192842.1957055-1-sjg@chromium.org>
 <af866d03-d097-48b9-994a-450ac4702d34@gmail.com>
Message-ID: <274DFE38-4A70-4181-9725-EE7BC5A0483B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Onh3PfpQUagTOxoEvg7dm9myhizsVi7Fp5qy4Tkn3+C6bQaeQ6G
 /m4gXIBB7VX/uZpimVYovWiVCKlGEJ3p5xOz3iLXNVm9f4T0vBI+BL0VAaFFc/hStS9Jfc5
 UD1cJO/4LX8df0VJ46c/Es+H67xK6GTqd81RPcClNd8UjYzcWOgg3uJWUvJtPskoVoZgCPl
 f9HG3hqjvLboFBkhd8XJA==
UI-OutboundReport: notjunk:1;M01:P0:GHUqJXo/p60=;ogvnroTv/rvCAEAWqDr5tEO9KyI
 HR0368n8vkKGQbi57vencCWvnec5ZqkGHI7BT3BHJVZW/yym5b0EORyWEYsRa+UXuBxOjlzGP
 /sOox61ViA+H3EwGwz7zGVK17ktTBxda01YgR47OIMfQvUUaXzMsEo8xF0NFuddcBLq0FVWSq
 PRMHgdmXcTyv4MK/rzrwqJINKq39G0W6p8+DBWYpUq5hFfnpzd3ZPd8oW31CI6hunT8BCxZMe
 J4qLRUWQkuhSlOtGgv36ytW0M5TK+TeF2GFv82TlsxarVhQ9keLMBYnO0dBDU3YKHgATnhUOs
 UMKSGsdan2H2fJNcffrXqIoCUAH0Xj3exQvm+o/HRNcar6abAT79bU9hdOG90DIFPJxfggZrR
 VHFLm/JbmvrgeiEBLt7kKrtC3XNv5aiCjQhFtI02rmrA33eII7U32/K4MYpBvOIuoZKMQ3Z/t
 qJUpvwJiMnu3nsT9q07beDxBgH7jGw8KSqDFjCXORYIGXMjWKDtFF/ISsvjAgp26q3xXW18sv
 ggVrTQPij3DApofSm0++bNWQwcDdTDpLFz1vAaW5KvyuiJcyc6T+iOO+sTRjmXZFe2wPgoR71
 +VlNuAlnW/y6FN1/gYvay7DMjhAL/q2icUK0NUrzNs/voaiu0qkhu2Lep8W05i4P4pUyhe9QK
 7zumP5Rwf9V1XLnXbTZ6TnuNl/yfJjDbVUQJd5Tl2IFAv0Lf0b9hqVxOFUXHQZ5mAipcWH3t9
 1iYaIvllqba5cf+bCO38CfWjXdGcUgkNqqvKFd+ahuyXcBSd6qUI+UGnbh4WmWhpmB1Ctw7Gb
 MPk1oPXl8N0soykz8Ri77VESYn84LWGLSWhHZmwIjBBO+iZkfmK7E+ii53VqMWxuSzOczFkPo
 aoJtYlLwxAA94uto4DGItKFXVKDv7//lPVkU/3esmxoWdYuCCrF74oWzFk0jiNqyifs9nvHe8
 oR7/KlK+rQFtMBjxb7xd3sG/5AY=
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



Am 27=2E August 2023 16:56:51 MESZ schrieb Alper Nebi Yasak <alpernebiyasa=
k@gmail=2Ecom>:
>On 2023-08-25 22:28 +03:00, Simon Glass wrote:
>> The efi_gop driver uses private fields from the video uclass to obtain =
a
>> pointer to the frame buffer=2E Use the platform data instead=2E
>>=20
>> Check the VIDEO_COPY setting to determine which frame buffer to use=2E =
Once
>> the next stage is running (and making use of U-Boot's EFI boot services=
)
>> U-Boot does not handle copying from priv->fb to the hardware framebuffe=
r,
>
>So far this copying seems to be done case-by-case like calling
>vidconsole_sync_copy() any time vidconsole does something, but the video
>damage tracking series moves that to video_sync(), so this change is
>incompatible with that (it will keep overwriting copy_fb with fb)=2E
>
>> so we must allow EFI to write directly to the hardware framebuffer=2E
>
>If you want a fix independent of that series, I think the proper
>approach here is having EFI draw to fb as it already does, then copying
>from that to copy_fb at the end of gop_blt_int()=2E

An EFI app can write directly to the framebuffer and mix that with API cal=
ls=2E

blt functions causing a full copy would be much slower than what you get w=
hen eliminating the copy fb=2E

Best regards

Heinrich


>
>> Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> ---
>>=20
>>  lib/efi_loader/efi_gop=2Ec | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/lib/efi_loader/efi_gop=2Ec b/lib/efi_loader/efi_gop=2Ec
>> index 778b693f983=2E=2Ea09db31eb46 100644
>> --- a/lib/efi_loader/efi_gop=2Ec
>> +++ b/lib/efi_loader/efi_gop=2Ec
>> @@ -10,6 +10,7 @@
>>  #include <efi_loader=2Eh>
>>  #include <log=2Eh>
>>  #include <malloc=2Eh>
>> +#include <mapmem=2Eh>
>>  #include <video=2Eh>
>>  #include <asm/global_data=2Eh>
>> =20
>> @@ -467,10 +468,10 @@ efi_status_t efi_gop_register(void)
>>  	struct efi_gop_obj *gopobj;
>>  	u32 bpix, format, col, row;
>>  	u64 fb_base, fb_size;
>> -	void *fb;
>>  	efi_status_t ret;
>>  	struct udevice *vdev;
>>  	struct video_priv *priv;
>> +	struct video_uc_plat *plat;
>> =20
>>  	/* We only support a single video output device for now */
>>  	if (uclass_first_device_err(UCLASS_VIDEO, &vdev)) {
>> @@ -483,9 +484,10 @@ efi_status_t efi_gop_register(void)
>>  	format =3D priv->format;
>>  	col =3D video_get_xsize(vdev);
>>  	row =3D video_get_ysize(vdev);
>> -	fb_base =3D (uintptr_t)priv->fb;
>> -	fb_size =3D priv->fb_size;
>> -	fb =3D priv->fb;
>> +
>> +	plat =3D dev_get_uclass_plat(vdev);
>> +	fb_base =3D IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->b=
ase;
>> +	fb_size =3D plat->size;
>> =20
>>  	switch (bpix) {
>>  	case VIDEO_BPP16:
>> @@ -547,7 +549,7 @@ efi_status_t efi_gop_register(void)
>>  	}
>>  	gopobj->info=2Epixels_per_scanline =3D col;
>>  	gopobj->bpix =3D bpix;
>> -	gopobj->fb =3D fb;
>> +	gopobj->fb =3D map_sysmem(fb_base, fb_size);
>> =20
>>  	return EFI_SUCCESS;
>>  }
