Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCA4C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 20:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6272D87A08;
	Thu, 28 Dec 2023 21:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BoawBrqp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A231787A09; Thu, 28 Dec 2023 21:55:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A972287945
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 21:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703796908; x=1704401708; i=xypron.glpk@gmx.de;
 bh=VpZJ89W93wQYHQEjYQPelUTA6vVHbkYnicc3fiF7cJk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=BoawBrqp2HJJ6YTGW4iRQ7p5sYu7ecvXjvWVhbLVgsK1y0cwHaen23pbENMULK24
 9Pv3ajp9eRfCpSuCNbEl4BVd+lSnCqaORhbIBvb9kWqmQghaSke4b5sSlmC4Nnw6l
 6xcVY7v6Svy72IlPxKV7QUlcToWhXTKoer7VJgtWohjo0YXEdszJH8U9IUYsH2jBL
 uGuwSu8AsK7rJ/H1C9vylXUkDBwAth5yDNngZfiUFPKDH5P1twXMbGVHbS68QfhDu
 b9IY++UgmfpJt1vbYIWvA0fce1kYxW748VUg6vKvHZi2UKJph1dbSGeMTzW5tyI/q
 BUmFNpVxMwQQqchr+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.110.217]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHQh-1qpvAj1L9l-00kj3j; Thu, 28
 Dec 2023 21:55:08 +0100
Date: Thu, 28 Dec 2023 21:55:07 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_7/7=5D_smbios=3A_Require_?=
 =?US-ASCII?Q?the_caller_to_align_the_SMBIOS_table?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTgxgJM9xm_-RXG64SD0jsg5cRh=OVOVfgy=23Wu0hZ8Yw@mail.gmail.com>
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-8-sjg@chromium.org>
 <CAC_iWjK1pYu7YnQ09V3V=dngtOFpwFd3jFFA_+hkO=Zd7-oR9Q@mail.gmail.com>
 <CAFLszTgko0C42Zc8wHJO5c20SSR-1pcCotEHi7AcuYEOacCGQA@mail.gmail.com>
 <690A2210-C523-4A53-8E1A-DF565F183630@gmx.de>
 <CAFLszTgxgJM9xm_-RXG64SD0jsg5cRh=OVOVfgy=23Wu0hZ8Yw@mail.gmail.com>
Message-ID: <73A02AD8-46C5-4BB1-BF8C-3361F01A8D5E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CuydlMcvhtmBbS8sBhU7nahq6PLolIuP4jVpMG50w2HUGgL8ef/
 f/ivy1TKGNa0uLoe+2NRyDECgqtCItKJfYL5ynZdmFvclyxp7vmx8s6LHvwrtHMfF7bPwl3
 PDWj0C2wprdYcvGV3z0Bfm/JwsLlz/xfAO+BHyn0zjJ6XGcwGXOM2ABFYbBTRZkcqcTKKDn
 Flk/JYakpzVMJgcnhqO2A==
UI-OutboundReport: notjunk:1;M01:P0:bt99VSIYXao=;xZ2fYGOC/hFmKZjJIzMv7+W+IkH
 jcWrwzzeFyqfPeKXx0uBjuKrdvghw313dRJ1hD5h7ceFzhIjMZSd1LTRPlcjOxSKOWkKig1Wx
 JW+aukeYpakdcUQ2Oc8d+8SyBcCArVB/QrygBpyn8KTh9+W9w10Tt9uxQbNj06/WZAJ0zUOZ3
 2nx7MI+RZVPlsZpFc6SPgd6LXwXXC9sXeY3cw2qxGBKDpS5RsMVGJtXIrb2PaGnlMCY9SQaQX
 JnVsGqieia3da2QAsBKt3SQ4S4D+Av8Hb0n+oikIfq16jVkFDGM86FbgEjLRbudBhy77W0Jg0
 lv9Gri7WPUAnHgmihjDA2/EVE5hSHnMhUj+k9QS1EEpCgp1+njtipzvZgbesUuhYF76jM24FI
 5Dn9vk5GLoSA2cskIhCGPpTmdqQCJ1wmOa0FpwrMG4Q/q535keCf5Ql6nxLC93FsnndXHALWG
 +/FixV2eCLwLjBwjt3aFOcmrslJiakY+rN47/LsJZoWkaaW02E+XyQ+5c70CFxMUDzwC+vgiU
 jv/0MkThdjc0rGhA5QW6ccDubBYQ6Zy4rYQH7jtiv/Q9G1bbxic2VntbmtWNZoyQiuAHIN5hV
 DsHhByOPAEJyRcBbK5U6+cPpNk9HTs1nN0hirfmeIF1cjbpRcp/b8A+fvszlvJ8Em3db+s1g8
 Bti1RF6/XQjnNL1xnNLM/YkU5PU2OW/cuXyPIGI9ToHW9bjor6JHzJ1BjhNyXfF1OgZ5ilq+3
 HvGGXHr59iHaX5S0BXPpKSzBsYG9XHo3SBxb8yx7czQ/t4O9Pm37VboL8PqYOUNxeEHkMAjci
 mmJdy5/YloZ7ftR4IijV+f8zt2cNu9lT10Yp57Wz6JwZoWLDz6D/cVdSnJ+QS9aQheNqVhrzV
 BPXFcUt1wjlktFGyZfI3VHFFSLqxwxt8v1agZi5OmKrAH0P+HGS+qQINdWIJOyWixZhctyjHo
 7zD5v/+jPGKtpRNK+0zGT61lLrw=
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



Am 28=2E Dezember 2023 20:48:04 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Heinrich,
>
>On Thu, Dec 28, 2023 at 5:36=E2=80=AFPM Heinrich Schuchardt <xypron=2Eglp=
k@gmx=2Ede> wrote:
>>
>>
>>
>> Am 28=2E Dezember 2023 14:37:19 MEZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
>> >Hi Ilias,
>> >
>> >On Wed, Dec 27, 2023 at 11:12=E2=80=AFAM Ilias Apalodimas
>> ><ilias=2Eapalodimas@linaro=2Eorg> wrote:
>> >>
>> >> Hi Simon,
>> >>
>> >> I commented on v3 as well, but in case you miss that
>> >>
>> >> On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium=2Eorg> wrote=
:
>> >> >
>> >> > All callers handle this alignment, so drop the unnecessary code=2E=
 This
>> >> > simplifies things a little=2E
>> >> >
>> >> > Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> >> > Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> >> > ---
>> >> >
>> >> > (no changes since v1)
>> >> >
>> >> >  include/smbios=2Eh | 5 +----
>> >> >  lib/smbios=2Ec     | 2 --
>> >> >  2 files changed, 1 insertion(+), 6 deletions(-)
>> >> >
>> >> > diff --git a/include/smbios=2Eh b/include/smbios=2Eh
>> >> > index 77be58887a2=2E=2E879b8a814b8 100644
>> >> > --- a/include/smbios=2Eh
>> >> > +++ b/include/smbios=2Eh
>> >> > @@ -258,12 +258,9 @@ static inline void fill_smbios_header(void *t=
able, int type,
>> >> >   *
>> >> >   * This writes SMBIOS table at a given address=2E
>> >> >   *
>> >> > - * @addr:      start address to write SMBIOS table=2E If this is =
not
>> >> > - *             16-byte-aligned then it will be aligned before the=
 table is
>> >> > - *             written=2E
>> >> > + * @addr:      start address to write SMBIOS table (must be 16-by=
te-aligned)
>> >> >   * Return:     end address of SMBIOS table (and start address for=
 next entry)
>> >> >   *             or NULL in case of an error
>> >> > - *
>> >> >   */
>> >> >  ulong write_smbios_table(ulong addr);
>> >> >
>> >> > diff --git a/lib/smbios=2Ec b/lib/smbios=2Ec
>> >> > index 7f79d969c92=2E=2Ecfd451e4088 100644
>> >> > --- a/lib/smbios=2Ec
>> >> > +++ b/lib/smbios=2Ec
>> >> > @@ -563,8 +563,6 @@ ulong write_smbios_table(ulong addr)
>> >> >                 ctx=2Edev =3D NULL;
>> >> >         }
>> >> >
>> >> > -       /* 16 byte align the table address */
>> >> > -       addr =3D ALIGN(addr, 16);
>> >>
>> >> I think this is wrong=2E  It will break SMBIOS on a user error=2E I =
am
>> >> fine replacing that with a check instead and error out if the addres=
s
>> >> is not 16b aligned
>> >
>> >Well this is why the comment says it must be aligned=2E This function =
is
>> >not called willy nilly,from code we control=2E Checking for alignment
>> >at runtime creates confusion and adds to code size=2E
>>
>> The SMBIOS tables themself have no alignment requirement=2E Only on non=
 UEFI x86 system presenting a UEFI entry point in the range 000F0000h to 00=
0FFFFFh this copy of the entry point has to be 16 byte aligned=2E
>
>OK=2E So perhaps I should reword the comment to say that any
>arch-specific alignment must be respected by the caller?

Just mentioning the requirement from the spec in the function description =
should be good enough=2E

Best regards

Heinrich

>
>Regards,
>Simon
