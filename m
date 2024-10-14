Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05FACF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 07:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CA8D88FC8;
	Mon, 14 Oct 2024 09:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jCchjO5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F71A88FDA; Mon, 14 Oct 2024 09:00:47 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C87E88FB9
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 09:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728889244; x=1729494044; i=xypron.glpk@gmx.de;
 bh=mYhEdNBaGKC204I8jZBZZYKxSN2SOvUzdFiOV60e6M0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jCchjO5L66hs5cUukd0pPi0ZfmfkYUzC6BmzN185kcImtKbXCEQ+wKK162wkOS4O
 fd7wjF/g7BlpYTicEJQCUokMpKmIMuVcOeVY2JuCMhTa3BTudLWQTs4sbzzEAFSaE
 MXttkKPUMTjsZZlT39OfCZTACLYG3nzJWFuixvCOcb1kWxU15A8wuE96fuRwLOebJ
 Qp844dYs5tWAfHvCFsrWe3w4O2h/Bj69IFYxv2nfNflg5W9s7+AgnmNDh9VIjs43B
 xr9NoByimcSPenv4TN7RC42ZgtiiwySTL2fQ5OUmcgy27vxGkFFeLKx63AdbzdrpG
 cTChl4b4eTKGg0BUDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.111.177]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCbB-1tVIU62cSX-00S7DA; Mon, 14
 Oct 2024 09:00:44 +0200
Date: Mon, 14 Oct 2024 09:00:40 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v6 12/12] test: efi: boot: Add a test for the efi bootmeth
User-Agent: K-9 Mail for Android
In-Reply-To: <20241014035122.GE53053@bill-the-cat>
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-13-sjg@chromium.org>
 <20241011223227.GA630742@bill-the-cat>
 <CAFLszTgoxND_qi8WzdgC8-mQLf0e14Mt=KgXy=bqWkqo4svG9Q@mail.gmail.com>
 <20241014035122.GE53053@bill-the-cat>
Message-ID: <A7089CFC-AD83-4F62-B477-17D65B066A4B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JqAgN/a+oq02IEo7QBdz6UOL4wCgu/m8QXLijkqCbzHpjO/YpCA
 prFnX6WHRp4eLHCw1nMpJgSPWe4zkIsRpy1rfwiwgwCVLioJU+IVBa/XUu6rO1px640u2M4
 vn5KZyFw37+vBGAAtYtCeuL9m5qJn/grtmhrvMj7gMxjGZb/ddt+PKe6Wpmwd4hKeRQ0mat
 iLyRNZYm6pn8JJSn03AYQ==
UI-OutboundReport: notjunk:1;M01:P0:kTJpaTJFjFI=;oq+uZD67dh7oN0jreTAqp7CxkT7
 ZfRyPjLTNvm7+ylxD6AT4X5KqCOUT+XNFXK1pQtz452Ca2Hjzvh1ItmVigZ9hfFnq4COiWFYQ
 RbdRGYXgHGQnQlHsN9KNZsZwH6sHQrTv+TUnLjrfNSqANb8H6lSZocV2+yEDuSG4Yqv/bo1pG
 sy/HShSBDRiidWYh/GPX4MbuvwZf3dYMNS8zjoPcSmNqHHjEIwYt0sH6Uvqcds6zBpGsZE7F9
 4P48J0R1wFJA7d4+R7dtxRbvHLGSwRn1oeYaDjakvDw17m9SNXyLcqCOJvQMTry6T2MMgudF8
 Af8q05qZFgVarOnRNj1ekdEboiWsQn+f7Ot07RMdILXH6+oqAv9GMa8dczaAgxVzIY1wrjr6f
 ylhpE+G6Z/cUjuuqVixom7LNBka61KKFvMVloOU3dy5TSlKVHT5FoSstfY7i07N/XR5Fi3h6B
 m2I0UjfyBu9H0RV2PadQyP0Z/OyRTTLv/1POqUFdF2iz1vI0KIaza4Zffi1gVMnzavObaAT00
 y0VEmD7EUwwSVCsu8Bp/tCV9ZYDBmYOIPI3hSnpO1Y2LZcRQDSsoRV0NJ5vDz8F2vJ1FfBj7u
 Y+sMhPsBiA+RARxVdTdsMmxE2tNpL88gXULrEXo8HtY2wYU4C4kKNWzhFjprQXDokgwcDPEL6
 r9pZggtsnNJqILePZ9F/0n5SAc6IPuxllQTHBJIRlnPB2R+wOh2/u/Ndal+q6oVrBp7YIdI+g
 9fqG5AKdbkhyE4YoQes+zIbdlvrxEjHQgK9bXbC2Hy9g+0MqwOB8xRuSsuLqZuhxAl+9S7XrZ
 LI8A/4K3BTTgBgNGPW/pAm3w==
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



Am 14=2E Oktober 2024 05:51:22 MESZ schrieb Tom Rini <trini@konsulko=2Ecom=
>:
>On Sun, Oct 13, 2024 at 01:33:23PM -0600, Simon Glass wrote:
>> Hi Tom,
>>=20
>> On Fri, 11 Oct 2024 at 16:32, Tom Rini <trini@konsulko=2Ecom> wrote:
>> >
>> > On Fri, Sep 27, 2024 at 12:02:23AM +0200, Simon Glass wrote:
>> >
>> > > Add a simple test of booting with the EFI bootmeth, which runs the =
app
>> > > and checks that it can call 'exit boot-services' (to check that all=
 the
>> > > device-removal code doesn't break anything) and then exit back to
>> > > U-Boot=2E
>> > >
>> > > This uses a disk image containing the testapp, ready for execution =
by
>> > > sandbox when needed=2E
>> > >
>> > > Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> >
>> > So lets go to the problem point=2E What asserts here fail due to ANSI
>> > escape codes being in the output and needing to be filtered out?
>> >
>> > [snip]
>> > > diff --git a/test/boot/bootflow=2Ec b/test/boot/bootflow=2Ec
>> > > index e05103188b4=2E=2Eda2ee1ab345 100644
>> > > --- a/test/boot/bootflow=2Ec
>> > > +++ b/test/boot/bootflow=2Ec
>> > > @@ -13,6 +13,7 @@
>> > >  #include <cli=2Eh>
>> > >  #include <dm=2Eh>
>> > >  #include <efi_default_filename=2Eh>
>> > > +#include <efi_loader=2Eh>
>> > >  #include <expo=2Eh>
>> > >  #ifdef CONFIG_SANDBOX
>> > >  #include <asm/test=2Eh>
>> > > @@ -31,6 +32,9 @@ extern U_BOOT_DRIVER(bootmeth_android);
>> > >  extern U_BOOT_DRIVER(bootmeth_cros);
>> > >  extern U_BOOT_DRIVER(bootmeth_2script);
>> > >
>> > > +/* Use this as the vendor for EFI to tell the app to exit boot ser=
vices */
>> > > +static u16 __efi_runtime_data test_vendor[] =3D u"U-Boot testing";
>> > > +
>> > >  static int inject_response(struct unit_test_state *uts)
>> > >  {
>> > >       /*
>> > > @@ -1205,3 +1209,62 @@ static int bootflow_android(struct unit_test=
_state *uts)
>> > >       return 0;
>> > >  }
>> > >  BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
>> > > +
>> > > +/* Test EFI bootmeth */
>> > > +static int bootflow_efi(struct unit_test_state *uts)
>> > > +{
>> > > +     /* disable ethernet since the hunter will run dhcp */
>> > > +     test_set_eth_enable(false);
>> > > +
>> > > +     /* make USB scan without delays */
>> > > +     test_set_skip_delays(true);
>> > > +
>> > > +     bootstd_reset_usb();
>> > > +
>> > > +     /* Avoid outputting ANSI characters which mess with our asser=
ts */
>> > > +     efi_console_set_ansi(false);
>> > > +
>> > > +     ut_assertok(bootstd_test_drop_bootdev_order(uts));
>> > > +     ut_assertok(run_command("bootflow scan", 0));
>> > > +     ut_assert_skip_to_line(
>> > > +             "Bus usb@1: scanning bus usb@1 for devices=2E=2E=2E 5=
 USB Device(s) found");
>> > > +
>> > > +     ut_assertok(run_command("bootflow list", 0));
>> > > +
>> > > +     ut_assert_nextlinen("Showing all");
>> > > +     ut_assert_nextlinen("Seq");
>> > > +     ut_assert_nextlinen("---");
>> > > +     ut_assert_nextlinen("  0  extlinux");
>> > > +     ut_assert_nextlinen(
>> > > +             "  1  efi          ready   usb_mass_    1  usb_mass_s=
torage=2Elun0=2Eboo /EFI/BOOT/BOOTSBOX=2EEFI");
>> > > +     ut_assert_nextlinen("---");
>> > > +     ut_assert_skip_to_line("(2 bootflows, 2 valid)");
>> > > +     ut_assert_console_end();
>> > > +
>> > > +     ut_assertok(run_command("bootflow select 1", 0));
>> > > +     ut_assert_console_end();
>> > > +
>> > > +     systab=2Efw_vendor =3D test_vendor;
>> > > +
>> > > +     ut_asserteq(1, run_command("bootflow boot", 0));
>> > > +     ut_assert_nextline(
>> > > +             "** Booting bootflow 'usb_mass_storage=2Elun0=2Ebootd=
ev=2Epart_1' with efi");
>> > > +     if (IS_ENABLED(CONFIG_LOGF_FUNC))
>> > > +             ut_assert_skip_to_line("       efi_run_image() Bootin=
g /\\EFI\\BOOT\\BOOTSBOX=2EEFI");
>> > > +     else
>> > > +             ut_assert_skip_to_line("Booting /\\EFI\\BOOT\\BOOTSBO=
X=2EEFI");
>> > > +
>> > > +     /* TODO: Why the \r ? */
>> > > +     ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
>> > > +     ut_assert_nextline("Exiting boot sevices");
>> > > +     if (IS_ENABLED(CONFIG_LOGF_FUNC))
>> > > +             ut_assert_nextline("     do_bootefi_exec() ## Applica=
tion failed, r =3D 5");
>> > > +     else
>> > > +             ut_assert_nextline("## Application failed, r =3D 5");
>> > > +     ut_assert_nextline("Boot failed (err=3D-22)");
>> > > +
>> > > +     ut_assert_console_end();
>> > > +
>> > > +     return 0;
>> > > +}
>> > > +BOOTSTD_TEST(bootflow_efi, UTF_CONSOLE);
>>=20
>> Thanks for taking an interest in this=2E
>>=20
>> Nothing at present, as I added ut_assert_skip_to_line() to skip it
>> all=2E But it really is just wrong=2E=2E=2EI get gibberish showing up i=
n the
>> terminal after I run tests! This is what I see with this series:
>>=20
>> ** Booting bootflow 'usb_mass_storage=2Elun0=2Ebootdev=2Epart_1' with e=
fi
>>  7 [r [999;999H [6n 8No EFI system partition
>>=20
>> ^^^ strange output there but I'm not sure if it will come through on em=
ail

It seems you are not providing a video console=2E So the EFI sub-system is=
 asking the serial console for its size in query_console_serial()=2E

Set CONFIG_VIDEO=3Dy and let vidconsole be your first output device to avo=
id query_console_serial() being called=2E

Best regards

Heinrich

>>=20
>> No EFI system partition
>> Failed to persist EFI variables
>> No EFI system partition
>> Failed to persist EFI variables
>> No EFI system partition
>> Failed to persist EFI variables
>> Booting /\EFI\BOOT\BOOTSBOX=2EEFI
>> U-Boot test app for EFI_LOADER
>>=20
>> Exiting boot sevices
>> ## Application failed, r =3D 5
>> Boot failed (err=3D-22)
>> Failures: 0
>
>So we're finally making progress I think to see what the problem you're
>trying to solve is=2E I think the next thing to figure out is if you use
>picocom or screen or whatever on console, the codes are handled
>correctly, or no? Specifically, picocom? Next, is this perhaps just
>another strange artifact of how oddly (and as you've noted before,
>slowly) pytest consumes the console input? It feels like maybe we're
>doing several layers of wrong there? Because to be clear, this is not a
>sandbox problem=2E Looking back at the log I had posted about the watchdo=
g
>reset not counting banners correctly I see that same escape sequence,
>now that I know what I'm looking for/at=2E
>
>All of that said, if it's not a pytest-consuming-the-console problem
>(and it's not a picocom problem, like I was just asking about since the
>board failure in question was via labgrid-client), maybe it's just a
>thing to note about making sure tests understand=2E And perhaps document
>somewhere why it matters (and I'm not saying it doesn't!) that we know
>what the dimensions of the console are, for EFI, and so that's why we
>init them when/where we do=2E
>
