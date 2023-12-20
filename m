Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC78C46CCD
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 09:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066EF86FFE;
	Wed, 20 Dec 2023 10:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hhqQ2UIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD64487480; Wed, 20 Dec 2023 10:07:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44FE786FD5
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 10:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703063260; x=1703668060; i=xypron.glpk@gmx.de;
 bh=v1L/0pO1HP+Hr/C63N5T0WKpxS+2ui26qq45eJgVJXE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=hhqQ2UIEWqxaVI/ZAyv/tB/fLTB/Bo8UrrjJSTI48o7t5aXyTWGAwtOGkp86AktV
 NKzhH4wVcQ2zab1HCafIibAcmZ1LuOLLBKany9gjIZiH/8l3Jgterpd2FfffLeRXi
 Tq8Aa18704PNv/lt4xRkWCvwmd/bidgsAqPpMRQ7W2RTgQ25UoEkDRlcaReSGgqh4
 QfqXTWfKhLkvLIHpniSchIP6sCaTRE8roVm46N2HooixxvEaucWFI8oJH2cWx1w/h
 qA0uJsgkP+m+k7Q23hgJy3BOW20LPD7iRcwpyCPN5eOmfGBSRJdPeUCsZPM3b81sB
 VasAfvPjJV8zW1M2JQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXpQ-1rgJMy1mRU-00QVVw; Wed, 20
 Dec 2023 10:07:40 +0100
Date: Wed, 20 Dec 2023 10:07:39 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH v3 4/4] fs: remove explicit efi configuration dependency
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ2n=yoL3GwUMsiL9dm-w8P88d_N5MUxMEHx+J9q666w0Q@mail.gmail.com>
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-5-takahiro.akashi@linaro.org>
 <CAPnjgZ0vq6kxiBNOwbi1JyMxV44S46uKXd1vbPNHFX5nwYLVtQ@mail.gmail.com>
 <14EA5E9B-23EB-4BD5-ACA9-7CEA6BC35453@gmx.de>
 <CAPnjgZ2n=yoL3GwUMsiL9dm-w8P88d_N5MUxMEHx+J9q666w0Q@mail.gmail.com>
Message-ID: <AB97A043-AFAB-4814-AA62-AB8514ED51C2@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j9KS37dN2NsmuIRwkIrtLdhlIA9Mtkndj7r3X6G2YaFIcTSVTgE
 KTRFM0HIhoYaDam9sGMK0F6c8iLtKatr3S8GvMWKog7JZ9G0pRFWt2rJvEd6sHySuDneT6M
 WwFwwG8963RwZocbMBxz7U1cUFtb8PGtg+e6RS33ABO6WWZMXjXctU6vKxmlWdtuG23aeip
 0eku6osIIDCB/ymNn8V/Q==
UI-OutboundReport: notjunk:1;M01:P0:oTr4NG0+AxM=;hh1/l08ziyNNFcJ0NM08BrAdCng
 +VfK3h3f2wwoBapYJ32mW4d9aDrK7mFs9dcHtQYq0bcJEfN1cfvVgQccM0AZ5mIUJwemgZpc8
 XhCvQgTITI7f3uAnT9gB39WAM8y/SNJBXnlWLYO+n3LGC9qB6TszKtN/QlkcLNfz4tcK1LceM
 px9ZYcsnDpk6/zOAygDncHRy6JFyZJ35h1ikvlvOe3HT3SToQwdSrK1YHkjWs75Rezntiz6DP
 stt+Kqj9OLbXxrT4fMu4n7lm0k2m/9XbZaCFhqQh+zHCBL3L8Nf6AFxeClZKmNV8o0q4yba8s
 EFLVhzeX0LTzP/y+3lPqAjUoXhXFt3vFbaTbhShqr8RI6qpDuKQKvfIW+7FK+EKyYiTKz2r4/
 zqqvQ4NaaY4E+K0+Ut1ykGBH+cNxAVmol9kPii4ATfaLA852ZKnSaTjsLxc9Qu1KMQ+Q+HFRB
 nyRibKis37Mha2Qi3D7SeVurRDVbX5akF11/WPGhnL0mzvcxnlfyc0j4CffLa41MDC4BnHafe
 RJbEe74g+mtyx6SS6r2cWVdruK7GNkYIg9IiXPYzXGzrHEcWX4M5WJbq9kXwvj2YBUPblzBU0
 tLVqb7O8lf82L8OPeh0ZLQWPWRKTOprCHcVYshFUEoXvqbH/cz+VTXcf8/Zf8cGccIXcO+8MX
 XQHfeEglB994aNWnJpApGmKc+Fp80CEfsvqJ7gubo3x5QC3v+vki3vh/IQ10IDIhPDjmT6SRi
 wzTmOklsuZNF6wZQ5/XF73iHJJd4MvezjhjBy0cp+jopLt5L23nY/SBDi0ztzKjQCQPgyfKzH
 BaMrPuAlS+mHhAGseWcwEN1NRRQX7sbV6l3XBKDsndMC0hNocrgK1+Ohoafd5WDff/Au16MqZ
 mACeu5UbBhlDanhnN0mLGfpuqe7jw7oIpGH4fjHvpdU5YLGkmY2Mq4IUe8rVBcgiE6U/TJFO1
 Z84ALQ==
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



Am 20=2E Dezember 2023 05:46:27 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Heinrich,
>
>On Mon, 18 Dec 2023 at 15:16, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>>
>>
>> Am 18=2E Dezember 2023 16:01:40 MEZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
>> >Hi AKASHI,
>> >
>> >On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
>> ><takahiro=2Eakashi@linaro=2Eorg> wrote:
>> >>
>> >> Now it is clear that the feature actually depends on efi interfaces,
>> >> not "bootefi" command=2E efi_set_bootdev() will automatically be nul=
lified
>> >> if necessary efi component is disabled=2E
>> >>
>> >> Signed-off-by: AKASHI Takahiro <takahiro=2Eakashi@linaro=2Eorg>
>> >> ---
>> >>  fs/fs=2Ec | 7 +++----
>> >>  1 file changed, 3 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/fs/fs=2Ec b/fs/fs=2Ec
>> >> index f33b85f92b61=2E=2E82ee03b160e9 100644
>> >> --- a/fs/fs=2Ec
>> >> +++ b/fs/fs=2Ec
>> >> @@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[],
>> >>                 return 1;
>> >>         }
>> >>
>> >> -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
>> >> -               efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
>> >> -                               (argc > 4) ? argv[4] : "", map_sysme=
m(addr, 0),
>> >> -                               len_read);
>> >> +       efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
>> >> +                       (argc > 4) ? argv[4] : "", map_sysmem(addr, =
0),
>> >> +                       len_read);
>> >
>> >As I understand it, this is setting the boot device so that (if it
>> >happens to be an efi application) it will know which device it came
>> >from=2E But this is a hack=2E For bootstd, the device is known as it l=
oads
>> >the kernel=2E
>>
>> Please, consider what happens when the user interactively executes the =
load and bootefi command from the console=2E
>>
>> >
>> >Also it does not deal with memory allocation (nor can it)=2E
>> >
>> >Where are we using the 'load' command to load a kernel? The distro
>> >scripts are deprecated=2E
>>
>> Some users use boot=2Escr scripts
>>
>>
>> >
>> >At some point this code should be removed=2E Is it too early for that?
>>
>> Yes, as long as we allow users to invoke the bootefi command with an ad=
dress pointer=2E
>
>So how about we create the new path, with the info passed in as part
>of the bootefi call? Then we can remove the call from bootstd, at
>least=2E

Hello Simon,

Do you see a problem merging the current patch? Or are you talking about w=
hat we might do after this patch?

Best regards

Heinrich
