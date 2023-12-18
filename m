Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A7EC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 22:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69ACB8715C;
	Mon, 18 Dec 2023 23:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="m7A1o4oq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A7F4870AB; Mon, 18 Dec 2023 23:16:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6843D874A5
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 23:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702937756; x=1703542556; i=xypron.glpk@gmx.de;
 bh=FiyRn8zjWP5YwIjZre6RW6TcanSRGIXCo9wuq4Ti/kk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=m7A1o4oq9YahSKjD1jAcRTPQsYjEGkKC8AxVvl5QmuIQZdrbYu7JNnYRmNsiBKPG
 1ERbj9+/+Scfym6Uw94JjanwE5dP3Fd+aDIrOFcdvmGYbrDgXNFP/f+m+zAW94mk9
 BOuReUREc3taa0zzOi+yVbu3y+u1dBFmz/IVenYynk6CCXxxAEWH1vVDt4cNSrRyf
 eznQaUsG0VUhldCdugGFxFP6+ss3JPvBF6tVuS9cgP0CBuV9cvJoQ5RBRIWhcMuKX
 sO/5jsNZ7EsYm4jAY/sHovOEQE7bMxbLQL+Rjshk8bzImOEhyFhfcF3LKDre4qlrL
 9GdJBn8d/PD+RgKahw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1r4ixy2mk6-00y9Il; Mon, 18
 Dec 2023 23:15:56 +0100
Date: Mon, 18 Dec 2023 23:15:55 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
CC: trini@konsulko.com, ilias.apalodimas@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH v3 4/4] fs: remove explicit efi configuration dependency
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ0vq6kxiBNOwbi1JyMxV44S46uKXd1vbPNHFX5nwYLVtQ@mail.gmail.com>
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-5-takahiro.akashi@linaro.org>
 <CAPnjgZ0vq6kxiBNOwbi1JyMxV44S46uKXd1vbPNHFX5nwYLVtQ@mail.gmail.com>
Message-ID: <14EA5E9B-23EB-4BD5-ACA9-7CEA6BC35453@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s8WEsvfhkqgj78MSEfECvqHkHQImi3nj9aY+2JMiut90CjkeaIy
 xUbjk2eNjE6r1Cu7H98qqcnK7ZUwk98dlco9tSTi3qlnrIsjMGqqYxomqDq7M1agGk3W46C
 MtQ1XsxxgMuj5vg+fgFCng2WLW0fKP7gQM12BI6YZn+jdCItzTQf/sjOn1WWZ7PQ7I8N6UX
 0vJhp68F6q7rK3avO55MA==
UI-OutboundReport: notjunk:1;M01:P0:Hh2QObj3vmQ=;2fPg+2Jvdu1A15Q5tXlhORjd2N/
 mz1XqcqVz8XLey71uvenS0vrCEmyKsk/DnjcZQmf9DS3Q9G7BPhbnAQMET1sdKOHKimXpJH+5
 vw/43lXDrKX+6E+fKSJmonB+Z4cES+KySCZyxjkLOzFkUlXDjgNTCjaENyDXb9qWkO9yJ4w11
 ebo1jUp2UhLSn+/Y3sozw7MI0DDBHbn1yu8G0lD+YAfuO9TBFuBC0ag931L4hucOu92PCHYTW
 8/+ALNcUe3Ab65pIahMHWtZIWYSeDbro0AzxXEgworDCLWDzFHrqs9XYilCLlaVs4gZxa9FIr
 K2DUu6XDNwwWiO7ew3poTItagsjEYKW5VhgnftUUw050sV5IcZ5t4ZKPpJvUDSRF3rtQ0AYYT
 kogSk6mJtVkO1wFOT4fIITOAcZSSfK0/Xrcw9VaSfBOd7pCmGzsi4caSyJlREs2SFot17vb9y
 XskgthUXym7U+XiKCburRXmFgvNLIAEgy48n5mspFWGKLofBBrw5Rv3/T7OnxRK5BnCOZkrJJ
 Yqk4rkE6maZvsXSF3wAgNlxv/+6uXmXRfSr8+40ZaoDMLJQWBkwkcdqYYWzVKWY4aOVqRWCkS
 nH8YDWTi1DZ1pDHtHP0I2wFwKJn3GyS+akmoeJ3OLYigvnC1EaJIWQV//cwyBZNOzLnPJTzVi
 24nXe+GgX8hJAxac6CCF2bzGs8CSx3ihTlCmT7P2jT0cIZfq1PmEgDr7Sw0hGwEfQ7VDJ5ODL
 4kKnh+WC9RncVWqKch9jHiVNM+b+ml9m53LZ6f13OwJsBOfSAIWzO6wYtkYoeAl1ypBszYQ0k
 sKMDBzsiD2eIKXytnaVd1T0nw1t2g0ezLRIBzkj37tZeBX4um/CXV8ZGYweSB9uZ2Xcwm1y6I
 NScvrxIFLZCjH1+4X9m6wUSEhAoFs56GXl64BCFB2IRYHrSWURYjKrHod/jaJOnqiDD6274sZ
 jZMnZbmd6xE1TaKkRIICVvFOBBM=
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



Am 18=2E Dezember 2023 16:01:40 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi AKASHI,
>
>On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
><takahiro=2Eakashi@linaro=2Eorg> wrote:
>>
>> Now it is clear that the feature actually depends on efi interfaces,
>> not "bootefi" command=2E efi_set_bootdev() will automatically be nullif=
ied
>> if necessary efi component is disabled=2E
>>
>> Signed-off-by: AKASHI Takahiro <takahiro=2Eakashi@linaro=2Eorg>
>> ---
>>  fs/fs=2Ec | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/fs=2Ec b/fs/fs=2Ec
>> index f33b85f92b61=2E=2E82ee03b160e9 100644
>> --- a/fs/fs=2Ec
>> +++ b/fs/fs=2Ec
>> @@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int a=
rgc, char *const argv[],
>>                 return 1;
>>         }
>>
>> -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
>> -               efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
>> -                               (argc > 4) ? argv[4] : "", map_sysmem(a=
ddr, 0),
>> -                               len_read);
>> +       efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
>> +                       (argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
>> +                       len_read);
>
>As I understand it, this is setting the boot device so that (if it
>happens to be an efi application) it will know which device it came
>from=2E But this is a hack=2E For bootstd, the device is known as it load=
s
>the kernel=2E

Please, consider what happens when the user interactively executes the loa=
d and bootefi command from the console=2E

>
>Also it does not deal with memory allocation (nor can it)=2E
>
>Where are we using the 'load' command to load a kernel? The distro
>scripts are deprecated=2E

Some users use boot=2Escr scripts=20


>
>At some point this code should be removed=2E Is it too early for that?

Yes, as long as we allow users to invoke the bootefi command with an addre=
ss pointer=2E

Best regards

Heinrich

>
>>
>>         printf("%llu bytes read in %lu ms", len_read, time);
>>         if (time > 0) {
>> --
>> 2=2E34=2E1
>>
>
>Regards,
>Simon
