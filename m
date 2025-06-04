Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7F5C5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77862801BE;
	Wed,  4 Jun 2025 21:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cZfkCjTo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5BF803DF; Wed,  4 Jun 2025 21:45:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2219A800D7
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1749066306; x=1749671106; i=xypron.glpk@gmx.de;
 bh=PE+XErRw/2tjg4XOlMqdQN/TGnQzhEle7HGdRc8mlgc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cZfkCjTocXnebGiwKZV88OLm58dBlhvtacVLjYkqqfcZXJBN73XZiYGOBa6vKW+o
 4toPGni9877lc/eCNIxC5Nf39Imwezs8YL9VRmJwuPfzTrrJhJr/6zveXs+mHf3xo
 6fbIH457peFAUwja0BAD9DqmiXT0vEjNV4EYJtL1vFHkeg5GEl289+qkXdSXoJC2Y
 ChgVhdB3Ga0AzJecvj4ZBR/0gnM964bWHSa/TP770qCWM+L4mRqpoLnIp5wcK5yTk
 m2+Ta3IoKz6dXVQwFqHNMswRCBxVbtt1/crZ7gpXuku9nRmpCIA2TarFxwaaaJJRQ
 28BMkywYvI8fqE/Beg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.0.66]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGRz-1uDNW837M5-00NsqG; Wed, 04
 Jun 2025 21:45:06 +0200
Date: Wed, 04 Jun 2025 21:45:03 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, ant.v.moryakov@gmail.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: scsi: fix: memory leak in do_scsi_scan_one()
User-Agent: Thunderbird for Android
In-Reply-To: <20250604182401.GA1941822@bill-the-cat>
References: <20250516174020.118229-1-ant.v.moryakov@gmail.com>
 <20250604182401.GA1941822@bill-the-cat>
Message-ID: <B4EBF800-B5F3-49E1-A270-67BF8E998841@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7YwsZOQT0LnYzkLSo5skXfha0UF6vPE5JtlmOGH4jfNjAItBZA2
 qb+jBcTLQ9m+15em/o2NLntt0dr9rV7e2llKSEXTrNde3J2l+c5gesNgLHQQB7L++CKBlDN
 5v0eojiF/la4X23eRh2f6BTbwoD8pfqfElgbfQ9fxwL4gg/ATD87sn+jyo7z7N/try1b0qN
 5lfL6y6AcjOnak1Ax0awQ==
UI-OutboundReport: notjunk:1;M01:P0:T/0fYARpr2Y=;jt7Pjtg892EklBjzVLEbpc3bc4i
 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
 5pm9WAcjqqUCUVV3kTOTtG3si3eKpwoZs5+6cQ==
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

Am 4=2E Juni 2025 20:24:01 MESZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>On Fri, May 16, 2025 at 08:40:20PM +0300, ant=2Ev=2Emoryakov@gmail=2Ecom =
wrote:
>
>> From: Anton Moryakov <ant=2Ev=2Emoryakov@gmail=2Ecom>
>>=20
>> Free allocated name buffer when blk_create_devicef() fails to prevent
>> memory leak=2E After successful device creation, the name ownership is
>> transferred to the device structure and should not be freed manually=2E
>>=20
>> Signed-off-by: Anton Moryakov <ant=2Ev=2Emoryakov@gmail=2Ecom>"
>> ---
>>  drivers/scsi/scsi=2Ec | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/scsi/scsi=2Ec b/drivers/scsi/scsi=2Ec
>> index cd0b84c0622=2E=2Ea9e364d3fdb 100644
>> --- a/drivers/scsi/scsi=2Ec
>> +++ b/drivers/scsi/scsi=2Ec
>> @@ -522,8 +522,10 @@ static int do_scsi_scan_one(struct udevice *dev, i=
nt id, int lun, bool verbose)
>>  		return log_msg_ret("pro", ret);
>> =20
>>  	ret =3D bootdev_setup_for_sibling_blk(bdev, "scsi_bootdev");
>> -	if (ret)
>> +	if (ret) {
>> +		free(name);=20
>>  		return log_msg_ret("bd", ret);
>> +	}
>> =20
>>  	if (verbose) {
>>  		printf("  Device %d: ", bdesc->devnum);
>
>Your commit message and code changes do not match up=2E The free() here i=
s
>at the end and not by the call to blk_create_devicef()=2E That said,
>looking at blk_create_devicef() and all of the callers, what we really
>need I think is to audit all of the callers and update/correct them=2E Th=
e
>third parameter, "name" is only used to print to the next string that's
>created, so an on-stack str[X], snprintf(=2E=2E=2E) is fine and what's us=
ually
>done=2E The places calling sprintf(=2E=2E=2E) not snprintf should be upda=
ted for
>safety=2E The scsi case of allocating on stack and then strdup'ing that
>should be changed to just on stack=2E I would check with Heinrich and
>Ilias about the
>lib/efi_driver/efi_block_device=2Ec::efi_bl_create_block_device() case to
>be clear that there's a good reason it's not on-stack=2E Thanks!
>

We should start with a proper documentation of blk_create_devicef() in blk=
=2Eh describing the intended content of name and how it is used in the func=
tion=2E=20

Afterwards we should fix
efi_driver: use blk_create_devicef()
<https://github=2Ecom/trini/u-boot/commit/640c6c6cbaafa1b049118d431cf218d9=
dce3cdd8>

Best regards=20

Heinrich

