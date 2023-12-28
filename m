Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C831C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 17:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD25587B30;
	Thu, 28 Dec 2023 18:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VQxWpDET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D8F687B31; Thu, 28 Dec 2023 18:31:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53688879F1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 18:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703784674; x=1704389474; i=xypron.glpk@gmx.de;
 bh=Lhm/Fvj6EMY2M3obuAJcoqzFX5VUlNquvI62kEUGNoU=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=VQxWpDETi9f3K1T4vs7a/Tn3jThin9diRKpDC8+kD4/ILPxo1uk1RrfQtL63vftn
 RJN6TTgpPuBZRex3+ftP/IecUDxGEC5ZpVbgGyN3zZmuQWXp+pq9Ku7QguUPz4gQH
 wrd68i+Cz0tRTUpEn/q7DAjVgSZ/36H91ICaFWRt/HntwrJ4M6s6xLWVe/or1gl/g
 1QMfdGi0vGLzDMMFqDlWN3bhlwV7VOMlTjPpbe0L0ooPrFEthAWltOqwOkaxGquRw
 X8lVawfMv9AyD40pUKAfZq3Kx7+g0DGBvJHnSm2UlOp6UbRiWais4Mn602TmLmW8D
 enPI3lBqZeTsNp2Npw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.110.217]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17YY-1r8MaB2k5C-012YYp; Thu, 28
 Dec 2023 18:31:13 +0100
Date: Thu, 28 Dec 2023 18:31:11 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_7/7=5D_smbios=3A_Require_?=
 =?US-ASCII?Q?the_caller_to_align_the_SMBIOS_table?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTgko0C42Zc8wHJO5c20SSR-1pcCotEHi7AcuYEOacCGQA@mail.gmail.com>
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-8-sjg@chromium.org>
 <CAC_iWjK1pYu7YnQ09V3V=dngtOFpwFd3jFFA_+hkO=Zd7-oR9Q@mail.gmail.com>
 <CAFLszTgko0C42Zc8wHJO5c20SSR-1pcCotEHi7AcuYEOacCGQA@mail.gmail.com>
Message-ID: <690A2210-C523-4A53-8E1A-DF565F183630@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SNKxrZP3nhVurmfHZJrkh8f+JoBkH9eW5Ht5C2eyf+5nkW+hNYS
 O2E+ewjgIeVVQQWwhKbtSDhgtSlIA8/F7FF88bJ5X4Ku6Qyyr1oSUNCGDs7rm3Vs2/uQPEU
 ZdRuvN6angv44gI+ChGzZSl8i4u3xb7kcgU227LCRO2eMLf/GTEauPODDpvM4YRrZFn9nkI
 o4EGrUSgP9meTd637GfmQ==
UI-OutboundReport: notjunk:1;M01:P0:VAQmrt4jQPM=;A1vAdn/KYn+Uk+/ZQj2ErY0Y4ll
 FEsRoHrUg3mmvVVQT6nPzr5ofNyt5vN38/pfSFSRqdP+N+gArQl8vmbmdvnsyHFORhegSvvUP
 J9zDt7Jrvr6ELcXllkRG9c0Ylop7XaNeXYR7S26thiqqpOe+2PWl8swJ4ZPB6biWu2izsY+5P
 PmHFhcO/Bg3qMDIC+ro5i0L4Y1fLpU4XtKbHiOfLWWyHeQ5McNiIE+YFM+KCjowK5BRe2rwQi
 LCE9qN2J/Z7nMBLa104ZMYudC7SOuP/+6BZXC6i+gHRBdrrrnoE40skYq8jriCDI2NKN+i1NO
 ERdrxJCFnTNViMBiA/MQRiTGYrH4EeopMknIkv8qQOZ+itANb6pMHlF3C4dC8uv3nmEHQBDSv
 XojFZLTMUYYCaQ2/W+IfSQy3LHplOYQ0dJnghg6I3h8rj2LRM5CO1Mz7ck6vV4+ul0Z7MxAQ5
 QphyYsN0BBnM5iULk4h8TZHERJktQKy29ThP+TTuzBRnEV+N1tFLNkILbdUJZPYSdMNEYAyd7
 VMMBnqEJGxJcdGIQyKEboyVSjAo15mFEurTZBECbaoPZmIz5UmzXaMb7n1wVYyvxKO9spctqq
 w0vBceMhqSlfCU9bekC03ChUVLBko5ApEnSw8hFq1G8uTlJ/SUP7z2ODWOyXe4D+0H+awa/0m
 Mj7NVfOWhTirABYa6aWpxbDICYvHH1lS9p4qRlNFjGz39Pvyn9QSfo3wp05DFZdLVb9oroRtM
 wVXYdkUFXQjiqTDSlx1fpHfJqGcMgJ5Tv7DpKeHPWEFc/O2SsOO7k/UIxO4O0nldqZM4bctwD
 QAoJ9gV0j7iJtkeIYlBypQscz5Gw6F1Skx+zTAr9i1Um6P61XUfHeRlqbUafYW4zDvNMM4PJd
 KJmbBU0mN8tzYd9uBLCFfaut9zw/aatkAEeyKnbKe4l2dzn6SGbPWmR5VBeiFgNjEO3A7OVeK
 Kb1GGTZ4uOWiGr11l7QAE264QDA=
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



Am 28=2E Dezember 2023 14:37:19 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Ilias,
>
>On Wed, Dec 27, 2023 at 11:12=E2=80=AFAM Ilias Apalodimas
><ilias=2Eapalodimas@linaro=2Eorg> wrote:
>>
>> Hi Simon,
>>
>> I commented on v3 as well, but in case you miss that
>>
>> On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium=2Eorg> wrote:
>> >
>> > All callers handle this alignment, so drop the unnecessary code=2E Th=
is
>> > simplifies things a little=2E
>> >
>> > Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> > Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> > ---
>> >
>> > (no changes since v1)
>> >
>> >  include/smbios=2Eh | 5 +----
>> >  lib/smbios=2Ec     | 2 --
>> >  2 files changed, 1 insertion(+), 6 deletions(-)
>> >
>> > diff --git a/include/smbios=2Eh b/include/smbios=2Eh
>> > index 77be58887a2=2E=2E879b8a814b8 100644
>> > --- a/include/smbios=2Eh
>> > +++ b/include/smbios=2Eh
>> > @@ -258,12 +258,9 @@ static inline void fill_smbios_header(void *tabl=
e, int type,
>> >   *
>> >   * This writes SMBIOS table at a given address=2E
>> >   *
>> > - * @addr:      start address to write SMBIOS table=2E If this is not
>> > - *             16-byte-aligned then it will be aligned before the ta=
ble is
>> > - *             written=2E
>> > + * @addr:      start address to write SMBIOS table (must be 16-byte-=
aligned)
>> >   * Return:     end address of SMBIOS table (and start address for ne=
xt entry)
>> >   *             or NULL in case of an error
>> > - *
>> >   */
>> >  ulong write_smbios_table(ulong addr);
>> >
>> > diff --git a/lib/smbios=2Ec b/lib/smbios=2Ec
>> > index 7f79d969c92=2E=2Ecfd451e4088 100644
>> > --- a/lib/smbios=2Ec
>> > +++ b/lib/smbios=2Ec
>> > @@ -563,8 +563,6 @@ ulong write_smbios_table(ulong addr)
>> >                 ctx=2Edev =3D NULL;
>> >         }
>> >
>> > -       /* 16 byte align the table address */
>> > -       addr =3D ALIGN(addr, 16);
>>
>> I think this is wrong=2E  It will break SMBIOS on a user error=2E I am
>> fine replacing that with a check instead and error out if the address
>> is not 16b aligned
>
>Well this is why the comment says it must be aligned=2E This function is
>not called willy nilly, from code we control=2E Checking for alignment
>at runtime creates confusion and adds to code size=2E

The SMBIOS tables themself have no alignment requirement=2E Only on non UE=
FI x86 system presenting a UEFI entry point in the range 000F0000h to 000FF=
FFFh this copy of the entry point has to be 16 byte aligned=2E

Best regards

Heinrich

>
>>
>> Thanks
>> /Ilias
>> >         start_addr =3D addr;
>> >
>> >         /*
>> > --
>> > 2=2E34=2E1
>> >
>
>Regards,
>Simon
