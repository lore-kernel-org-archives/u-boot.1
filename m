Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18362C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F25688533;
	Mon, 12 Aug 2024 12:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BvPafKid";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 130E2886E7; Mon, 12 Aug 2024 12:35:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0658A87F19
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723458931; x=1724063731; i=xypron.glpk@gmx.de;
 bh=C20/bXnAnNKKA+IusQ53kpPGOCMOj/m2Nm4LXCGTqys=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BvPafKidy/EyKLF/tOJJFl58ZRCF2yyUzDuVuqqNYffu9nGC/PyLndmKv1cBza+b
 C7qNbtJdZXan2kkuCvieKm3350OggAJaVRfpkDB2LTRWKS/WmcEJQrBR+AxthPbIL
 J0Yl1Or3V2MF2s3jQnKzX6o2WUqraOMsMeXzS5Fovw2DR1SRnqa+1HwVCcBeXuH1P
 6roEOxoJoZXFdPM4RpGTcNEtj90gH9ao4POxWKjVcxyO4crl5qLdztI2Mh5beMlmg
 AFUdVHLKDzLyfHq4A2PplXl+zjmfelV5g31UfQWSNnVg0c7zw1gyUWlY9ZFFh6yCH
 ZAs53UXkcLj8ZWkP8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.210.207]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulqN-1sLvc13VxL-00tAnk; Mon, 12
 Aug 2024 12:35:31 +0200
Date: Mon, 12 Aug 2024 12:35:29 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 31/40] efi: Show the vendor in helloworld
User-Agent: K-9 Mail for Android
In-Reply-To: <CAC_iWj+DtHbghAqJWiwm8ZVCXf3mCOOm13YpLSQGGBPcpgnWiQ@mail.gmail.com>
References: <20240811145209.4191404-1-sjg@chromium.org>
 <20240811145209.4191404-32-sjg@chromium.org>
 <CAC_iWj+DtHbghAqJWiwm8ZVCXf3mCOOm13YpLSQGGBPcpgnWiQ@mail.gmail.com>
Message-ID: <4D176BE3-6F0E-4A7B-A550-18C8954CC844@gmx.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:0+av8VY1NsKKSJULEk5b+aZ5q1Gxu3UkARs+9A3ZkRBW5Pjxzw8
 UfwK0d76pqHNtN3Un596DNIBxqoZTr39V++tWQFJcWj1iIf6dmVRuoIsXnNCibAN/rGa0Y6
 1ELBgpnbg6A4aad+TSUV7S/yWVEPgXjL7R6YzCQI+cHaxtqyHF8E+P1dIB6El39EaBRDI2i
 wwJ41y/w74EjS2mAOrV5A==
UI-OutboundReport: notjunk:1;M01:P0:uYp7oMiDquk=;5VecqPq3Ve9t5UyvNqDPaIybFk8
 1uF9ieGOiIQ3Fe4lcln0oZXieG4/+kA74WSxH1KP8B2GF5nj0O6Uj5xONlbJuXSuP/n6DvRDP
 xS1u+MLgbDTXBCuRfzlSIrTl/0kHFSc+Rvjhd8Fbp4nG9VTQ3hMeWqGoumiALvuNcKtO11ml4
 YLLrioOP4TX8HfPwHlNfu6VyBqJ/R+X1hh7EwFh8kgOtz7Jx4IW8H5ftSF+Et1uTbpp/2tG7K
 P6ccOtPgQ4JI2MYnsl9r6cm4EJKhzaF3puvLLR3GTdL5iBwls9423q3KdlT+9DQAl/QMyS2VY
 t0vCsh6ArF2kMqAkBw5pVLC/ImmclB6gpZmjF81HfpR4Hr98eq6Ci2peZGesjkHuIJY4mnC+R
 osOaxsXtMiLF6EsLC5R7olhfRs/zzFA3Agb1Nl7NmdYaILoAivzogTEbEzEDKhmIbfj/7TZi5
 MLKEzQHPZg92iyMjK18tb1YSQH0syy5VSdE6F+M8+vt8wKs0rlEENFuUxWeDSNXFgomO140DD
 TfWnT1FGjTR1nCLZ8WNodArFpQhAB/I7UUSRjlUvlCws770VQyr/62NsQ2j9f1jat1xjLwgg/
 j+3i84VfKQSlL6XGp8/oMLJ1kT3AebOty0Jf5a4cdAPKAxAT1QrpMgSwRimUFcaLSX4nlYlYq
 hWkhOMsevSu3mXKn94CUXEq4sIYrgh2NfdnaJQZYdV9rgpgjkdUV0AqFTJB43pDYBiKn/oAG1
 h04AAO1kxICByVZZyJXLj9J7IUuqF4ZJCNCP+/GA2/2HJiSaX9hYA3zyi9O7OGmuYxhh+Y5Ib
 /n74L2/JG0XTrOcVOb4kqwKw==
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Am 12=2E August 2024 09:58:28 MESZ schrieb Ilias Apalodimas <ilias=2Eapalod=
imas@linaro=2Eorg>:
>On Sun, 11 Aug 2024 at 17:52, Simon Glass <sjg@chromium=2Eorg> wrote:
>>
>> Show the vendor name so it is clear which firmware is being used, e=2Eg=
=2E
>> whether U-Boot is providing the boot services=2E

I never had any doubt about which firmware I am using=2E

Originally you expected "U-Boot" to be printed on any device as indication=
 of the copyright=2E

Why is this patch needed? Are you checking the output anywhere?


>>
>> Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> ---
>>
>> (no changes since v2)
>>
>> Changes in v2:
>> - Reword commit message
>> - Use 'Firmware vendor' instead of just 'Vendor'
>>
>>  lib/efi_loader/helloworld=2Ec | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/lib/efi_loader/helloworld=2Ec b/lib/efi_loader/helloworld=
=2Ec
>> index 586177de0c8=2E=2Ec4d2afcb40a 100644
>> --- a/lib/efi_loader/helloworld=2Ec
>> +++ b/lib/efi_loader/helloworld=2Ec
>> @@ -237,6 +237,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
>>                         (con_out, u"Missing device path for device hand=
le\r\n");
>>                 goto out;
>>         }
>> +       con_out->output_string(con_out, u"Firmware vendor: ");
>> +       con_out->output_string(con_out, systab->fw_vendor);
>> +       con_out->output_string(con_out, u"\n");

How about FirmwareRevision"?

Best regards

Heinrich

>>         con_out->output_string(con_out, u"Boot device: ");
>>         ret =3D print_device_path(device_path, device_path_to_text);
>>         if (ret !=3D EFI_SUCCESS)
>> --
>> 2=2E34=2E1
>>
>Reviewed-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
