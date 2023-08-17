Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A847C2FC29
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C6BA86B63;
	Thu, 17 Aug 2023 15:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Ev2ubF/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8230486B67; Thu, 17 Aug 2023 15:42:56 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FFD386B6C
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-58de42f9f05so9047547b3.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692279769; x=1692884569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VEcLkfAPWS5c8X+MHzEaeypA56SJkQ4ct6LfLNsA8U=;
 b=Ev2ubF/bQLEc9AutKW6TmfdUaCvTWf+4PQCmmljy75vPLKCYkZ4VlAyDPkqKqhSMke
 O09JCQSaKBQP70DYZezVyd1ri+36dK5QQlxEv7fn1yA1dkQFFtuyaf4bNDph4se2Gj1S
 Cnt00WSrJa+bKWL2OQBaAcmeLrQ4PlsYWdXTkYxKLHnR9m97A+/7UGpvgFAPjih5HBJ8
 YEV/T6dSec6HG3+i50qIr8tWqSYrNZtUdiFri/J+eIAABJaFgq+K9Qylw1MfVxBwY3JT
 axOyupJb5Zb3/vuFg6WLJpYHAcVjRkT4fzAsS8Nvctyu1Sietvp/vewjAvqnCz+OwSpM
 pz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279769; x=1692884569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VEcLkfAPWS5c8X+MHzEaeypA56SJkQ4ct6LfLNsA8U=;
 b=XdzrgHxQ1qKIb/KYjIYu+LFA7t9cv9b2K0d32zOmILgyQv2yfgIhbxeaiR1TTSavBr
 OU/Oa3rnLPBnYBwaaqfYJwpjVGN5oaUq6YdVQLdQusdYbLEx1jjgcjg61PWze6ezIXZv
 Us90fEHBdVoO1bksRtGyZCrNiBPML9zAkvzIU5t2POFXUfweRFEt1eiEVgck/d8/R3la
 A3POLD4vCbfD1BYWA7J74JbW2tydfRDQ6xsbkDtwfWdA1FuTKe8ofNm9aWzLPCEt/9y1
 khtKfqZqvpiYamPiftn5R8vrP8nx+RoS1dZEB2ZceRi4h8hArTQHtsEsn7ry5rq92QlT
 6xUQ==
X-Gm-Message-State: AOJu0YyZuN3XUQh1gDXlVPTbUkC466M0WjqsEw9X6YKJU7Ovp3s9ecv0
 cwaXZ8kiczPJ8SAJc/FU9CelanQ66qLSA3nXr3zHJQqOe2jqeN1kHds=
X-Google-Smtp-Source: AGHT+IEtDcqICquowWtnrc9Yfp27c64SO/1JxqHG2T0dXmm3WXnCBRdJU/AxtqgMd+2zdmpMpq/+tQ/EDZqOMaoHm0A=
X-Received: by 2002:a25:ad82:0:b0:d4e:8780:8bda with SMTP id
 z2-20020a25ad82000000b00d4e87808bdamr5002775ybi.52.1692279768676; Thu, 17 Aug
 2023 06:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230712023303.1969966-1-trini@konsulko.com>
 <CAPnjgZ3irbbr0_Gb+BKJk=-rjG0s6aVUOeCekJxB3pTy=0n9kA@mail.gmail.com>
 <20230712170859.GA2066889@bill-the-cat>
 <CAPnjgZ0iWQiBA376YYON7fJO=+guSsy7CpFO5=BnDce9cGf=Gg@mail.gmail.com>
 <20230712203839.GJ2066889@bill-the-cat>
 <CAPnjgZ3_2fFM_8EpPWv7ou+TYwFKMtEE6WRsxQh39O+6gRb0sg@mail.gmail.com>
 <20230713215740.GP2066889@bill-the-cat>
 <CAPnjgZ0g5u2FzZPNPKFDe2XRkDhy=Vj5KBM9j46He5rc=xmrkQ@mail.gmail.com>
 <20230716181758.GT2066889@bill-the-cat>
 <CAPnjgZ3O6L_EyfUgPVaatR99ZV=irUroqnyKDywJgmFfiLhLZg@mail.gmail.com>
 <20230727203515.GN3630934@bill-the-cat>
In-Reply-To: <20230727203515.GN3630934@bill-the-cat>
From: Simon Glass <sjg@google.com>
Date: Thu, 17 Aug 2023 07:41:36 -0600
Message-ID: <CAPnjgZ1uMCrhrMS_jaPwnUdFAAwvo+eCK8Jr16sQXHaO3nDQvQ@mail.gmail.com>
Subject: Re: [PATCH] CI: Add automatic retry for test.py jobs
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, 27 Jul 2023 at 14:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jul 27, 2023 at 01:18:12PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 16 Jul 2023 at 12:18, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Jul 15, 2023 at 05:40:25PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 13 Jul 2023 at 15:57, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Jul 13, 2023 at 03:03:57PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 12 Jul 2023 at 14:38, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Wed, Jul 12, 2023 at 02:32:18PM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Wed, 12 Jul 2023 at 11:09, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jul 12, 2023 at 08:00:23AM -0600, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Tue, 11 Jul 2023 at 20:33, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > It is not uncommon for some of the QEMU-based jobs to=
 fail not because
> > > > > > > > > > > of a code issue but rather because of a timing issue =
or similar problem
> > > > > > > > > > > that is out of our control. Make use of the keywords =
that Azure and
> > > > > > > > > > > GitLab provide so that we will automatically re-run t=
hese when they fail
> > > > > > > > > > > 2 times. If they fail that often it is likely we have=
 found a real issue
> > > > > > > > > > > to investigate.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  .azure-pipelines.yml | 1 +
> > > > > > > > > > >  .gitlab-ci.yml       | 1 +
> > > > > > > > > > >  2 files changed, 2 insertions(+)
> > > > > > > > > >
> > > > > > > > > > This seems like a slippery slope. Do we know why things=
 fail? I wonder
> > > > > > > > > > if we should disable the tests / builders instead, unti=
l it can be
> > > > > > > > > > corrected?
> > > > > > > > >
> > > > > > > > > It happens in Azure, so it's not just the broken runner p=
roblem we have
> > > > > > > > > in GitLab. And the problem is timing, as I said in the co=
mmit.
> > > > > > > > > Sometimes we still get the RTC test failing. Other times =
we don't get
> > > > > > > > > QEMU + U-Boot spawned in time (most often m68k, but somet=
imes x86).
> > > > > > > >
> > > > > > > > How do we keep this list from growing?
> > > > > > >
> > > > > > > Do we need to? The problem is in essence since we rely on fre=
e
> > > > > > > resources, sometimes some heavy lifts take longer.  That's wh=
at this
> > > > > > > flag is for.
> > > > > >
> > > > > > I'm fairly sure the RTC thing could be made deterministic.
> > > > >
> > > > > We've already tried that once, and it happens a lot less often. I=
f we
> > > > > make it even looser we risk making the test itself useless.
> > > >
> > > > For sleep, yes, but for rtc it should be deterministic now...next t=
ime
> > > > you get a failure could you send me the trace?
> > >
> > > Found one:
> > > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D6592&vie=
w=3Dlogs&j=3Db6c47816-145c-5bfe-20a7-c6a2572e6c41&t=3D0929c28c-6e32-5635-96=
24-54eaa917d713&l=3D599
> >
> > I don't seem to have access to that...but it is rtc or sleep?
>
> It was the RTC one, and has since rolled off and been deleted.
>
> > > And note that we have a different set of timeout problems that may or=
 may not
> > > be configurable, which is in the upload of the pytest results. I have=
n't seen
> > > if there's a knob for this one yet, within Azure (or the python proje=
ct we're
> > > adding for it).
> >
> > Oh dear.
> >
> > >
> > > > > > The spawning thing...is there a timeout for that? What actually=
 fails?
> > > > >
> > > > > It doesn't spawn in time for the framework to get to the prompt. =
 We
> > > > > could maybe increase the timeout value.  It's always the version =
test
> > > > > that fails.
> > > >
> > > > Ah OK, yes increasing the timeout makes sense.
> > > >
> > > > >
> > > > > > > > > > I'll note that we don't have this problem with sandbox =
tests.
> > > > > > > > >
> > > > > > > > > OK, but that's not relevant?
> > > > > > > >
> > > > > > > > It is relevant to the discussion about using QEMU instead o=
f sandbox,
> > > > > > > > e.g. with the TPM. I recall a discussion with Ilias a while=
 back.
> > > > > > >
> > > > > > > I'm sure we could make sandbox take too long to start as well=
, if enough
> > > > > > > other things are going on with the system.  And sandbox has i=
ts own set
> > > > > > > of super frustrating issues instead, so I don't think this is=
 a great
> > > > > > > argument to have right here (I have to run it in docker, to g=
et around
> > > > > > > some application version requirements and exclude event_dump,=
 bootmgr,
> > > > > > > abootimg and gpt tests, which could otherwise run, but fail f=
or me).
> > > > > >
> > > > > > I haven't heard about this before. Is there anything that could=
 be done?
> > > > >
> > > > > I have no idea what could be done about it since I believe all of=
 them
> > > > > run fine in CI, including on this very host, when gitlab invokes =
it
> > > > > rather than when I invoke it. My point here is that sandbox tests=
 are
> > > > > just a different kind of picky about things and need their own ki=
nd of
> > > > > "just hit retry".
> > > >
> > > > Perhaps this is Python dependencies? I'm not sure, but if you see i=
t
> > > > again, please let me know in case we can actually fix this.
> > >
> > > Alright. So the first pass I took at running sandbox pytest with as
> > > little hand-holding as possible I hit the known issue of /boot/vmlinu=
*
> > > being 0400 in Ubuntu. I fixed that and then re-ran and:
> > > test/py/tests/test_cleanup_build.py F
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > _________________________________________ test_clean ________________=
__________________________
> > > test/py/tests/test_cleanup_build.py:94: in test_clean
> > >     assert not leftovers, f"leftovers: {', '.join(map(str, leftovers)=
)}"
> > > E   AssertionError: leftovers: fdt-out.dtb, sha1-pad/sandbox-u-boot.d=
tb, sha1-pad/sandbox-kernel.dtb, sha1-basic/sandbox-u-boot.dtb, sha1-basic/=
sandbox-kernel.dtb, sha384-basic/sandbox-u-boot.dtb, sha384-basic/sandbox-k=
ernel.dtb, algo-arg/sandbox-u-boot.dtb, algo-arg/sandbox-kernel.dtb, sha1-p=
ss/sandbox-u-boot.dtb, sha1-pss/sandbox-kernel.dtb, sha256-pad/sandbox-u-bo=
ot.dtb, sha256-pad/sandbox-kernel.dtb, sha256-global-sign/sandbox-binman.dt=
b, sha256-global-sign/sandbox-u-boot.dtb, sha256-global-sign/sandbox-u-boot=
-global.dtb, sha256-global-sign/sandbox-kernel.dtb, sha256-global-sign-pss/=
sandbox-binman-pss.dtb, sha256-global-sign-pss/sandbox-u-boot.dtb, sha256-g=
lobal-sign-pss/sandbox-kernel.dtb, sha256-global-sign-pss/sandbox-u-boot-gl=
obal-pss.dtb, auto_fit/dt-1.dtb, auto_fit/dt-2.dtb, sha256-pss/sandbox-u-bo=
ot.dtb, sha256-pss/sandbox-kernel.dtb, sha256-pss-pad/sandbox-u-boot.dtb, s=
ha256-pss-pad/sandbox-kernel.dtb, hashes/sandbox-kernel.dtb, sha256-basic/s=
andbox-u-boot.dtb, sha256-basic/sandbox-kernel.dtb, sha1-pss-pad/sandbox-u-=
boot.dtb, sha1-pss-pad/sandbox-kernel.dtb, sha384-pad/sandbox-u-boot.dtb, s=
ha384-pad/sandbox-kernel.dtb, sha256-pss-pad-required/sandbox-u-boot.dtb, s=
ha256-pss-pad-required/sandbox-kernel.dtb, ecdsa/sandbox-kernel.dtb, sha256=
-pss-required/sandbox-u-boot.dtb, sha256-pss-required/sandbox-kernel.dtb
> > > E   assert not [PosixPath('fdt-out.dtb'), PosixPath('sha1-pad/sandbox=
-u-boot.dtb'), PosixPath('sha1-pad/sandbox-kernel.dtb'), PosixPa...ic/sandb=
ox-u-boot.dtb'), PosixPath('sha1-basic/sandbox-kernel.dtb'), PosixPath('sha=
384-basic/sandbox-u-boot.dtb'), ...]
> > > ------------------------------------ Captured stdout call -----------=
--------------------------
> > > +make O=3D/tmp/pytest-of-trini/pytest-231/test_clean0 clean
> > > make[1]: Entering directory '/tmp/pytest-of-trini/pytest-231/test_cle=
an0'
> > >   CLEAN   cmd
> > >   CLEAN   dts/../arch/sandbox/dts
> > >   CLEAN   dts
> > >   CLEAN   lib
> > >   CLEAN   tools
> > >   CLEAN   tools/generated
> > >   CLEAN   include/bmp_logo.h include/bmp_logo_data.h include/generate=
d/env.in include/generated/env.txt drivers/video/u_boot_logo.S u-boot u-boo=
t-dtb.bin u-boot-initial-env u-boot-nodtb.bin u-boot.bin u-boot.cfg u-boot.=
dtb u-boot.dtb.gz u-boot.dtb.out u-boot.dts u-boot.lds u-boot.map u-boot.sr=
ec u-boot.sym System.map image.map keep-syms-lto.c lib/efi_loader/helloworl=
d_efi.S
> > > make[1]: Leaving directory '/tmp/pytest-of-trini/pytest-231/test_clea=
n0'
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > FAILED test/py/tests/test_cleanup_build.py::test_clean - AssertionErr=
or: leftovers: fdt-out....
> > > !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! stopping after 1 failures !!!!!!!!=
!!!!!!!!!!!!!!!!!!!!!!!!!!
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 failed, 6 passed in 6.42s =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >
> > That test never passes for me locally, because as you say we add a lot
> > of files to the build directory and there is no tracking of them such
> > that 'make clean' could remove them. We could fix that, e.g.:
> >
> > 1. Have binman record all its output filenames in a binman.clean file
> > 2. Have tests always use a 'testfiles' subdir for files they create
>
> It sounds like this is showing some bugs in how we use binman since
> "make clean" should result in a clean tree, and I believe we get a few
> patches now and again about removing leftover files.
>
> > > Fixing that manually with an rm -rf of /tmp/pytest-of-trini and now i=
t's
> > > stuck.  I've rm -rf'd that and git clean -dfx and just repeat that
> > > failure.  I'm hopeful that when I reboot whatever magic is broken wil=
l
> > > be cleaned out.  Moving things in to a docker container again, I get:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D ERRORS =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > _______________________________ ERROR at setup of test_gpt_read _____=
__________________________
> > > /home/trini/work/u-boot/u-boot/test/py/tests/test_gpt.py:74: in state=
_disk_image
> > >     ???
> > > /home/trini/work/u-boot/u-boot/test/py/tests/test_gpt.py:37: in __ini=
t__
> > >     ???
> > > test/py/u_boot_utils.py:279: in __enter__
> > >     self.module_filename =3D module.__file__
> > > E   AttributeError: 'NoneType' object has no attribute '__file__'
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > ERROR test/py/tests/test_gpt.py::test_gpt_read - AttributeError: 'Non=
eType' object has no at...
> > > !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! stopping after 1 failures !!!!!!!!=
!!!!!!!!!!!!!!!!!!!!!!!!!!
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D 41 passed, 45 skipped, 1 error in 19.29s =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > And then ignoring that one with "-k not gpt":
> > > test/py/tests/test_android/test_ab.py E
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D ERRORS =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > __________________________________ ERROR at setup of test_ab ________=
__________________________
> > > /home/trini/work/u-boot/u-boot/test/py/tests/test_android/test_ab.py:=
54: in ab_disk_image
> > >     ???
> > > /home/trini/work/u-boot/u-boot/test/py/tests/test_android/test_ab.py:=
28: in __init__
> > >     ???
> > > test/py/u_boot_utils.py:279: in __enter__
> > >     self.module_filename =3D module.__file__
> > > E   AttributeError: 'NoneType' object has no attribute '__file__'
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > ERROR test/py/tests/test_android/test_ab.py::test_ab - AttributeError=
: 'NoneType' object has...
> > > !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! stopping after 1 failures !!!!!!!!=
!!!!!!!!!!!!!!!!!!!!!!!!!!
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 908 passed, 75 skipped, 10 de=
selected, 1 error in 159.17s (0:02:39) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > These two are the same error. It looks like somehow it is unable to
> > obtain the module with:
> >
> >         frame =3D inspect.stack()[1]
> >         module =3D inspect.getmodule(frame[0])
> >
> > i.e. module is None
> >
> > +Stephen Warren who may know
> >
> > What Python version is this?
>
> It's the docker container we use for CI, where these tests pass every
> time they're run normally, whatever is in Ubuntu "Jammy".
>
> > > Now, funny things. If I git clean -dfx, I can then get that test to
> > > pass.  So I guess something else isn't cleaning up / is writing to a
> > > common area? I intentionally build within the source tree, but in a
> > > subdirectory of that, and indeed a lot of tests write to the source
> > > directory itself.
> >
> > Wow that really is strange. The logic in that class is pretty clever.
> > Do you see a message like 'Waiting for generated file timestamp to
> > increase' at any point?
> >
> > BTW these problems don't have anything to do with sandbox, which I
> > think was your original complaint. The more stuff we bring into tests
> > (Python included) the harder it gets.
>
> The original complaint, as I saw it, was that "sandbox pytests don't
> randomly fail".  My point is that sandbox pytests randomly fail all the
> time.  QEMU isn't any worse.  I can't say it's better since my local
> loop is sandbox for sanity then on to hardware.

The way I see it, terms of flakiness, speed and ease of debugging,
from best to worse, we have:

- sandbox
- Python wrapper around sandbox
- Python wrapper around QEMU

Regards,
Simon
