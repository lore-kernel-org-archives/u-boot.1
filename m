Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103D8EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 22:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2A886D0E;
	Mon, 11 Sep 2023 00:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NyAGXqTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E22BE86CF9; Mon, 11 Sep 2023 00:37:09 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F8CD86CC0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 00:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so564444f8f.2
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694385426; x=1694990226; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=blN2AoMG+LqeB4tIY/xZE/FaiJ2kUQEJ1Z8G83vmkLA=;
 b=NyAGXqTOnJz8/jtlqistIdfApra5sKqqmTmJw21wk1IUqDuKlSABEp/s/E6imTreaw
 /VDxfpIhuCyaEpjqFmFhSBT+sqAoTDf3lTW7PYxczxAuT7JsRuAc4A6lh6Ro4Q1Cf8GC
 l/pCwsPeVFqBGTV943KTWSX+toAJTtNj7Loh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694385426; x=1694990226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=blN2AoMG+LqeB4tIY/xZE/FaiJ2kUQEJ1Z8G83vmkLA=;
 b=ma+lnayD8WtrDYhf5cP5bDB5s7/uJBsTgDJw3VmNiszbYsxpxz/3gP5BWxDCKmg784
 m+eV+wLId7mQufBBG84OAGktbZNvlK2Z+VPATXa0CrDbU/EkOKw0whR1U6r4zOLiyE5g
 DkUR0eMwIBVe7S7xbnUpOe8H1+Eiehqu5p+PxAS3DpcFpXSkMDNUTAV8GjN8hsU9NV63
 TY/58DOda6zqiaYE88UGu4Z3XlhTRXlj7mSdQP6q5HKQeLjy0jMVrbCjY/EDbNSHLu9k
 ysMPRGl4HLd6DTz1wkIaoxbg2iSpY0t4SsVAM/VdT48pf6G03rBxm/oWcf3uxsyOLSIH
 pqYw==
X-Gm-Message-State: AOJu0YwSHcdJAZKaS8sgylbADqYvE/eNLOL4C/b8W09LNWPm/OHTntNi
 fRtB+ABotkkPX/+9HqSQud5H/pB5+Xylel2RH8k1dhZdD1nPxPPHGKY=
X-Google-Smtp-Source: AGHT+IFx/pKKd88pz1zTwrYH4ApZ6fc9hV1It7vpgJgISt7uUV+xlYHrJo946ozpPdOxWb2HK4gNvYTcTd/4sQZVVg4=
X-Received: by 2002:a5d:5103:0:b0:319:731f:748c with SMTP id
 s3-20020a5d5103000000b00319731f748cmr6534054wrt.34.1694385425801; Sun, 10 Sep
 2023 15:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <7d128f4a-b972-0535-ac06-bd600ba2e37c@monstr.eu>
 <20230907181411.GX305624@bill-the-cat>
 <9d45165f-fc88-4615-969b-0aafc7d43f13@monstr.eu>
 <20230908133415.GA305624@bill-the-cat>
 <fd3a2682-0215-4026-a51d-de6364e06a69@monstr.eu>
 <CAHTX3dJW1JHGnn15YxWH2Fe2CDdLK0KYBbof_ww79vepY=x_oQ@mail.gmail.com>
In-Reply-To: <CAHTX3dJW1JHGnn15YxWH2Fe2CDdLK0KYBbof_ww79vepY=x_oQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 16:36:50 -0600
Message-ID: <CAPnjgZ1RLD2Z+-YW2FRtpkWe4CUuYM8e_jXk2u6dcy4+NtT8JQ@mail.gmail.com>
Subject: Re: sandbox trace errors in CI loop
To: Michal Simek <monstr@monstr.eu>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Michal,

On Fri, 8 Sept 2023 at 09:00, Michal Simek <monstr@monstr.eu> wrote:
>
> Hi Tom,
>
> p=C3=A1 8. 9. 2023 v 15:42 odes=C3=ADlatel Michal Simek <monstr@monstr.eu=
> napsal:
> >
> >
> >
> > On 9/8/23 15:34, Tom Rini wrote:
> > > On Fri, Sep 08, 2023 at 12:24:10PM +0200, Michal Simek wrote:
> > >>
> > >>
> > >> On 9/7/23 20:14, Tom Rini wrote:
> > >>> On Thu, Sep 07, 2023 at 05:30:03PM +0200, Michal Simek wrote:
> > >>>> Hi Simon and Tom,
> > >>>>
> > >>>> I am preparing pull request and I see that CI loop is reporting is=
sue with
> > >>>> sandbox trace and I have no idea what's going wrong here.
> > >>>>
> > >>>> This is the first problematic commit but have no clue what it has =
to do with trace.
> > >>>>
> > >>>> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/commi=
t/8c5f80d11b29536979ac41a6087fb8938f45bbf2
> > >>>>
> > >>>> If you have an access you can take a look at my queue to see that =
only this
> > >>>> job is failing.
> > >>>> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipel=
ines
> > >>>>
> > >>>> Thanks,
> > >>>> Michal
> > >>>>
> > >>>> collected 1152 items / 1151 deselected / 1 selected
> > >>>> test/py/tests/test_trace.py F                                     =
       [100%]
> > >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > >>>> __________________________________ test_trace ____________________=
______________
> > >>>> test/py/tests/test_trace.py:292: in test_trace
> > >>>>       check_function(cons, fname, proftool, map_fname, trace_dat)
> > >>>> test/py/tests/test_trace.py:117: in check_function
> > >>>>       out =3D util.run_and_log(cons, ['sh', '-c', cmd])
> > >>>> test/py/u_boot_utils.py:181: in run_and_log
> > >>>>       output =3D runner.run(cmd, ignore_errors=3Dignore_errors, st=
din=3Dstdin, env=3Denv)
> > >>>> test/py/multiplexed_log.py:183: in run
> > >>>>       raise exception
> > >>>> E   ValueError: Exit code: 1
> > >>>> ---------------------------- Captured stdout setup ---------------=
--------------
> > >>>> /u-boot
> > >>>> trace: early enable at 00100000
> > >>>> sandbox_serial serial: pinctrl_select_state_full:
> > >>>> uclass_get_device_by_phandle_id: err=3D-19
> > >>>> =3D>
> > >>>
> > >>> I don't get it either since I see this on master with trace options
> > >>> enabled per CI:
> > >>> $ ./u-boot -T arch/sandbox/dts/test.dtb
> > >>> trace: early enable at 00100000
> > >>> sandbox_serial serial: pinctrl_select_state_full: uclass_get_device=
_by_phandle_id: err=3D-19
> > >>> ... rest of boot proceeds ...
> > >>>
> > >>> So the test should be failing already if that was the problem.
> > >>>
> > >>
> > >> I don't thin it is the problematic part.
> > >>
> > >> When I look at
> > >> https://source.denx.de/u-boot/u-boot/-/blob/master/tools/docker/Dock=
erfile?ref_type=3Dheads#L225
> > >>
> > >> clone is done from
> > >> git clone https://github.com/rostedt/trace-cmd.git /tmp/trace/trace-=
cmd && \
> > >>
> > >> https://github.com/rostedt/trace-cmd/blob/master/README#L5
> > >>
> > >> we should be using
> > >> git://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git instead.
> > >>
> > >> I installed the latest version on my PC and run it via pytest and th=
is is
> > >> what I am getting.
> > >> You see that trace-cmd report is returning "failed to init data".
> > >>
> > >> Are we wired to any specific trace-cmd version?
> > >
> > > Wait, no, what's going on exactly? The github repository is a mirror =
of
> > > the kernel.org one. So yes, we should correct to point to the main on=
e,
> > > but the top of tree in both cases is commit
> > > 354dccca52e805ce1b22e2b62cbae8c265886c27.
> > >
> >
> > I dig into it more.
> > What it is happening is that when sandbox u-boot is bigger trace.dat fi=
le is
> > placing information to different offset then it is recorded somewhere i=
n header.
> >
> > Wrong placement
> >
> > 0005b000  20 70 65 72 66 20 6d 6f  6e 6f 20 6d 6f 6e 6f 5f  | perf mono=
 mono_|
> > 0005b010  72 61 77 20 62 6f 6f 74  20 78 38 36 2d 74 73 63  |raw boot x=
86-tsc|
> > 0005b020  0a 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..........=
......|
> > 0005b030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..........=
......|
> > *
> > 0005c000  89 df f6 1d 00 00 00 00  dc 0f 00 00 00 00 00 00  |..........=
......|
> > 0005c010  06 00 00 00 01 00 00 00  01 00 00 00 af e5 0a 00  |..........=
......|
> > 0005c020  00 00 00 00 ef dc 09 00  00 00 00 00 06 00 00 00  |..........=
......|
> > 0005c030  01 00 00 00 01 00 00 00  af e5 0a 00 00 00 00 00  |..........=
......|
> >
> > Correct placement for trace-cmd
> >
> > 0005aee0  75 70 74 69 6d 65 20 70  65 72 66 20 6d 6f 6e 6f  |uptime per=
f mono|
> > 0005aef0  20 6d 6f 6e 6f 5f 72 61  77 20 62 6f 6f 74 20 78  | mono_raw =
boot x|
> > 0005af00  38 36 2d 74 73 63 0a 00  00 00 00 00 00 00 00 00  |86-tsc....=
......|
> > 0005af10  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..........=
......|
> > *
> > 0005b000  36 f8 92 3f 00 00 00 00  e0 0f 00 00 00 00 00 00  |6..?......=
......|
> >
> > And trace-cmd want to decode data available at 0x5b000 offset in both c=
ases.
> >
> > It means I expect proftool is not correctly generating offset where dat=
a is
> > present. I don't understand how it works but I clearly see based on tra=
ce-cmd
> > that it points to incorrect location.
>
> diff --git a/tools/proftool.c b/tools/proftool.c
> index 101bcb63334e..815e01efb5d1 100644
> --- a/tools/proftool.c
> +++ b/tools/proftool.c
> @@ -1500,7 +1500,7 @@ static int write_flyrecord(struct twriter *tw,
> enum out_format_t out_format,
>         tw->ptr +=3D fprintf(fout, "flyrecord%c", 0);
>
>         /* trace data */
> -       start =3D ALIGN(tw->ptr + 16, TRACE_PAGE_SIZE);
> +       start =3D ALIGN(tw->ptr + 16, 0x4000);
>         tw->ptr +=3D tputq(fout, start);
>
>         /* use a placeholder for the size */
>
> This is the problematic code. In flyrecord section in header there is
> the calculation where data start.
> And there is tw->ptr +16 used (not sure why +16) but actual flyrecord
> is much bigger than 16.
>
> In my case start of flyrecord is 0x5afc1 + flyrecordX + 16 (mentioned
> above) is 0x5afdb.
> Then there is page alignment which gives 0x5b000 which is recorded but
> actual size is till 0x5b021.
>
> The actual size of the header is 0x60 not  flyrecordX + 16 (based on
> location where tw->ptr is taken).
> Simon: Do you agree with this logic?
>
> It was introduced by commit be16fc81b2ed ("trace: Update proftool to
> use new binary format").

If you can fix it then yes that is fine and please send a patch. The
test is there to catch things going wrong. The intent of proftool is
to mimic the flyrecord format used by Linux. Your analysis seems right
to me.

Regards,
Simon
