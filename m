Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E77CEB2CA
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 10:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 806E583EE8;
	Sat, 15 Nov 2025 11:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FpyfTp6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A0C83EF2; Sat, 15 Nov 2025 11:54:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AA8E83EE3
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 11:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763204038; x=1763808838; i=xypron.glpk@gmx.de;
 bh=/5rOtpie++akUqD42OFjr4bIy7cEsBcdHvDuzauAcKw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FpyfTp6l10dgZo13BJtvL1QWQvpd/YDbljZz4rpwiaTXuQfeRQhCPSukRmejCDbl
 HIMv9wNKDGY15CsYNGQUGima+GQJSGeC4ggXezYC/z/GQ6JHrzwWMOAUcPyxxwrWB
 QqqyXZPhXAlque8IHremWaL6V4RWUEw1bp9R/oQD65EbLrEosOQ2CemTjRd6GXzdf
 rZ/9p9HbcQ0Hbkt+svHSr5WHqQUtOj3acFoDyRedvmrJll2ON1bS5X6DEv3T7BOPy
 kzeI1tlxKwg4dbh7fGW917IGdSe68cjYR1OBDs2//u1TG29cSAlTUvmwsYbXTLhi3
 coF1I/W1OP+nBOlTww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO6C-1vvlbZ3rzs-00gr2W; Sat, 15
 Nov 2025 11:53:58 +0100
Message-ID: <cfe88d39-dd5b-4fe2-9d2b-d52bc4f1f327@gmx.de>
Date: Sat, 15 Nov 2025 11:53:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Assure fitImage from capsule is used from
 8-byte aligned address
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>
References: <20251113115558.947903-1-marek.vasut+renesas@mailbox.org>
 <CAC_iWjJE1meO7UonS2-hUSkkcnxQWCerqdN4mb_wcR7rpVXy+g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjJE1meO7UonS2-hUSkkcnxQWCerqdN4mb_wcR7rpVXy+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H3YcJOKU4xYA6O/sDyEF6RD46sGGbkaj7wiFBul5atW3GtTLIxo
 l/favtoVAykU6MnOP0vRkW3c7xLjk8nbtBf5c1VL5bbs/vc+ip4sZM18A4dGx/uxLqwwpmC
 XheF4QDUqkP/4hApoDO8G/P9fVi8/dre1Oh8rxeaTra/KLLGL9KxpWZL/ErhNz5lTgYu+wg
 AT+5WAmfcb9aagQHJsI5Q==
UI-OutboundReport: notjunk:1;M01:P0:tfuK9OlKgk0=;UfczGrrccm6+uzUFSu2g/B9IsDQ
 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
 lbydsMGt8s6jwOKfgneIyyVf+jq/+
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

On 11/14/25 08:03, Ilias Apalodimas wrote:
> Hi Marek,
>=20
>=20
> On Thu, 13 Nov 2025 at 13:56, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> The fitImage may be stored in EFI update capsule at address that
>> is not aligned to 8 bytes. Since fitImage is a DT, new version of
>> libfdt 1.7.2 rejects such an unaligned DT. Patch the code and copy
>> the fitImage into aligned buffer in case it is not aligned. This
>> does increase overhead for unaligned fitImages in EFI capsules, but
>> tries to keep the overhead low for aligned ones.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>=20
> At some point I'd prefer getting rid of FIT images for capsules
> overall. It was implemented as an alternative to authenticated capsule
> updates, but since then proper capsule support has been added. The
> patch is ok though for now,
>=20
>> ---
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Jonathan Humphreys <j-humphreys@ti.com>
>> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Wadim Egorov <w.egorov@phytec.de>
>> Cc: u-boot@lists.denx.de
>> ---
>>   lib/efi_loader/efi_firmware.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmwar=
e.c
>> index 216df83de67..953a310190b 100644
>> --- a/lib/efi_loader/efi_firmware.c
>> +++ b/lib/efi_loader/efi_firmware.c
>> @@ -651,6 +651,7 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>>          efi_status_t status;
>>          struct fmp_state state =3D { 0 };
>>          char *orig_dfu_env;
>> +       void *img;
>>
>>          EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
>>                    image_size, vendor_code, progress, abort_reason);
>> @@ -677,7 +678,20 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>>                  return EFI_EXIT(EFI_DEVICE_ERROR);
>>          }
>>
>> -       ret =3D fit_update(image);
>> +       /* Make sure the update fitImage is properly aligned to 8-bytes=
 */
>> +       if ((uintptr_t)image & 7) {
>=20
> Can we replace this with IS_ALGINED?

I will fix that in my pull-request:

      if (!IS_ALIGNED((uintptr_t)image, 8)) {


>=20
>> +               img =3D memalign(8, image_size);
>> +               if (!img)
>> +                       return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
>> +               memcpy(img, image, image_size);
>> +       } else {
>> +               img =3D (void *)image;
>> +       }
>> +
>> +       ret =3D fit_update(img);
>> +
>> +       if ((uintptr_t)image & 7)

     if (!IS_ALIGNED((uintptr_t)image, 8))

Best regards

Heinrich

>> +               free(img);
>=20
> Initialize img to NULL and make the check a bit simpler to read (or
> get rid of it overall)
>=20
> Other than that LGTM
>=20
> Cheers
> /Ilias
>>
>>          if (env_set("dfu_alt_info", orig_dfu_env))
>>                  log_warning("Unable to restore env variable \"dfu_alt_=
info\".  Further DFU operations may fail!\n");
>> --
>> 2.51.0
>>

