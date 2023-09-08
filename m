Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92184EE8012
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 15:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A276D865D0;
	Fri,  8 Sep 2023 17:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="fJ3kd1Pu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8480086A27; Fri,  8 Sep 2023 17:00:41 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2078185E44
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 17:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ab244ef065so1475871b6e.0
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1694185236; x=1694790036;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L85S9NQ3m+FfLdfozFY6qxuhPUNSlb8jB4R6NZURyAE=;
 b=fJ3kd1Pu4L+4s7YujJcOPIH5uJog1Qk9ME/6PXVbHQlVGef7At9tnk/t0df7XtCLdE
 2IZAjEgoaHuJkIS1O3ztoRLXy1iNQmxKfaODlgCnvG7OfASdlCMLS3iTvXiJrhcQXkT0
 WvTpX5nMLQujs4q1douYgv0fZcxaPccrK/88wa+YDpl0PyAh6GphgB3bWBZYo77kaVt7
 YJYCXJpQ+uhu0JA8oZ7jbAhYw+OQI4gy571C+3miD5BboNFhHwJ3XO97rd0hRvfS5MTE
 qXeZfpONQSOh+dyFIWKRnK8iBvHr/zB5jo3rslCG7/hjZ28ZcQGoGgQeT/fAIiUl6WWu
 DHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694185236; x=1694790036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L85S9NQ3m+FfLdfozFY6qxuhPUNSlb8jB4R6NZURyAE=;
 b=ZBUH3ZYIUDqESueYGvM9ee/UVowFfhBS9ripkbBO06/PFzXPPDJk8LPe37AS9sM/5+
 0STA0Ru6UMm5yPr5vegW4uTXDUmCejbVN41U51E7dPdMTp5RROQjQalx5b6dc0M4WO2e
 9pWHtbGjYGaRRgY0jOSN/WGu//QyfTk6mcdoiopJu/0vRd+7x1Vyl/dhRX2EwvIuGvXC
 ipKmp4JDTfyizlfWf/no7okI9/F5rEYGjDHD95uhVbCgwGKVq9ijn7ZQi2fHXl3p8bv5
 01wCpCOZaWBjAeC94Gc29xi5XbsgMWMnv7UsiX3jQ2JpW0CmYd7nmU92f3W65f4bxC4b
 qgyw==
X-Gm-Message-State: AOJu0Yyvy+XmjdaIpXaNggfcHREF4JvMABxaRp59ZLvAcZua1HPr9t9w
 mnbn8UVLFHx+8D3l4cGzILdYxQ/9ZaFz9hqukWzVJw==
X-Google-Smtp-Source: AGHT+IFphx2goOCp1BMu1eyOCJJuSASv2AvIcZiqOeMdmZMNergaVouRswi5aBlXvehXRlJdpjeYvJWZYAmb6QD+EOo=
X-Received: by 2002:a05:6808:19a2:b0:3a7:2598:ab2c with SMTP id
 bj34-20020a05680819a200b003a72598ab2cmr3391809oib.7.1694185236551; Fri, 08
 Sep 2023 08:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <7d128f4a-b972-0535-ac06-bd600ba2e37c@monstr.eu>
 <20230907181411.GX305624@bill-the-cat>
 <9d45165f-fc88-4615-969b-0aafc7d43f13@monstr.eu>
 <20230908133415.GA305624@bill-the-cat>
 <fd3a2682-0215-4026-a51d-de6364e06a69@monstr.eu>
In-Reply-To: <fd3a2682-0215-4026-a51d-de6364e06a69@monstr.eu>
From: Michal Simek <monstr@monstr.eu>
Date: Fri, 8 Sep 2023 17:00:25 +0200
Message-ID: <CAHTX3dJW1JHGnn15YxWH2Fe2CDdLK0KYBbof_ww79vepY=x_oQ@mail.gmail.com>
Subject: Re: sandbox trace errors in CI loop
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

p=C3=A1 8. 9. 2023 v 15:42 odes=C3=ADlatel Michal Simek <monstr@monstr.eu> =
napsal:
>
>
>
> On 9/8/23 15:34, Tom Rini wrote:
> > On Fri, Sep 08, 2023 at 12:24:10PM +0200, Michal Simek wrote:
> >>
> >>
> >> On 9/7/23 20:14, Tom Rini wrote:
> >>> On Thu, Sep 07, 2023 at 05:30:03PM +0200, Michal Simek wrote:
> >>>> Hi Simon and Tom,
> >>>>
> >>>> I am preparing pull request and I see that CI loop is reporting issu=
e with
> >>>> sandbox trace and I have no idea what's going wrong here.
> >>>>
> >>>> This is the first problematic commit but have no clue what it has to=
 do with trace.
> >>>>
> >>>> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/commit/=
8c5f80d11b29536979ac41a6087fb8938f45bbf2
> >>>>
> >>>> If you have an access you can take a look at my queue to see that on=
ly this
> >>>> job is failing.
> >>>> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelin=
es
> >>>>
> >>>> Thanks,
> >>>> Michal
> >>>>
> >>>> collected 1152 items / 1151 deselected / 1 selected
> >>>> test/py/tests/test_trace.py F                                       =
     [100%]
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>>> __________________________________ test_trace ______________________=
____________
> >>>> test/py/tests/test_trace.py:292: in test_trace
> >>>>       check_function(cons, fname, proftool, map_fname, trace_dat)
> >>>> test/py/tests/test_trace.py:117: in check_function
> >>>>       out =3D util.run_and_log(cons, ['sh', '-c', cmd])
> >>>> test/py/u_boot_utils.py:181: in run_and_log
> >>>>       output =3D runner.run(cmd, ignore_errors=3Dignore_errors, stdi=
n=3Dstdin, env=3Denv)
> >>>> test/py/multiplexed_log.py:183: in run
> >>>>       raise exception
> >>>> E   ValueError: Exit code: 1
> >>>> ---------------------------- Captured stdout setup -----------------=
------------
> >>>> /u-boot
> >>>> trace: early enable at 00100000
> >>>> sandbox_serial serial: pinctrl_select_state_full:
> >>>> uclass_get_device_by_phandle_id: err=3D-19
> >>>> =3D>
> >>>
> >>> I don't get it either since I see this on master with trace options
> >>> enabled per CI:
> >>> $ ./u-boot -T arch/sandbox/dts/test.dtb
> >>> trace: early enable at 00100000
> >>> sandbox_serial serial: pinctrl_select_state_full: uclass_get_device_b=
y_phandle_id: err=3D-19
> >>> ... rest of boot proceeds ...
> >>>
> >>> So the test should be failing already if that was the problem.
> >>>
> >>
> >> I don't thin it is the problematic part.
> >>
> >> When I look at
> >> https://source.denx.de/u-boot/u-boot/-/blob/master/tools/docker/Docker=
file?ref_type=3Dheads#L225
> >>
> >> clone is done from
> >> git clone https://github.com/rostedt/trace-cmd.git /tmp/trace/trace-cm=
d && \
> >>
> >> https://github.com/rostedt/trace-cmd/blob/master/README#L5
> >>
> >> we should be using
> >> git://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git instead.
> >>
> >> I installed the latest version on my PC and run it via pytest and this=
 is
> >> what I am getting.
> >> You see that trace-cmd report is returning "failed to init data".
> >>
> >> Are we wired to any specific trace-cmd version?
> >
> > Wait, no, what's going on exactly? The github repository is a mirror of
> > the kernel.org one. So yes, we should correct to point to the main one,
> > but the top of tree in both cases is commit
> > 354dccca52e805ce1b22e2b62cbae8c265886c27.
> >
>
> I dig into it more.
> What it is happening is that when sandbox u-boot is bigger trace.dat file=
 is
> placing information to different offset then it is recorded somewhere in =
header.
>
> Wrong placement
>
> 0005b000  20 70 65 72 66 20 6d 6f  6e 6f 20 6d 6f 6e 6f 5f  | perf mono m=
ono_|
> 0005b010  72 61 77 20 62 6f 6f 74  20 78 38 36 2d 74 73 63  |raw boot x86=
-tsc|
> 0005b020  0a 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |............=
....|
> 0005b030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |............=
....|
> *
> 0005c000  89 df f6 1d 00 00 00 00  dc 0f 00 00 00 00 00 00  |............=
....|
> 0005c010  06 00 00 00 01 00 00 00  01 00 00 00 af e5 0a 00  |............=
....|
> 0005c020  00 00 00 00 ef dc 09 00  00 00 00 00 06 00 00 00  |............=
....|
> 0005c030  01 00 00 00 01 00 00 00  af e5 0a 00 00 00 00 00  |............=
....|
>
> Correct placement for trace-cmd
>
> 0005aee0  75 70 74 69 6d 65 20 70  65 72 66 20 6d 6f 6e 6f  |uptime perf =
mono|
> 0005aef0  20 6d 6f 6e 6f 5f 72 61  77 20 62 6f 6f 74 20 78  | mono_raw bo=
ot x|
> 0005af00  38 36 2d 74 73 63 0a 00  00 00 00 00 00 00 00 00  |86-tsc......=
....|
> 0005af10  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |............=
....|
> *
> 0005b000  36 f8 92 3f 00 00 00 00  e0 0f 00 00 00 00 00 00  |6..?........=
....|
>
> And trace-cmd want to decode data available at 0x5b000 offset in both cas=
es.
>
> It means I expect proftool is not correctly generating offset where data =
is
> present. I don't understand how it works but I clearly see based on trace=
-cmd
> that it points to incorrect location.

diff --git a/tools/proftool.c b/tools/proftool.c
index 101bcb63334e..815e01efb5d1 100644
--- a/tools/proftool.c
+++ b/tools/proftool.c
@@ -1500,7 +1500,7 @@ static int write_flyrecord(struct twriter *tw,
enum out_format_t out_format,
        tw->ptr +=3D fprintf(fout, "flyrecord%c", 0);

        /* trace data */
-       start =3D ALIGN(tw->ptr + 16, TRACE_PAGE_SIZE);
+       start =3D ALIGN(tw->ptr + 16, 0x4000);
        tw->ptr +=3D tputq(fout, start);

        /* use a placeholder for the size */

This is the problematic code. In flyrecord section in header there is
the calculation where data start.
And there is tw->ptr +16 used (not sure why +16) but actual flyrecord
is much bigger than 16.

In my case start of flyrecord is 0x5afc1 + flyrecordX + 16 (mentioned
above) is 0x5afdb.
Then there is page alignment which gives 0x5b000 which is recorded but
actual size is till 0x5b021.

The actual size of the header is 0x60 not  flyrecordX + 16 (based on
location where tw->ptr is taken).
Simon: Do you agree with this logic?

It was introduced by commit be16fc81b2ed ("trace: Update proftool to
use new binary format").

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
