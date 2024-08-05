Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6B6C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 10:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27DFF88884;
	Mon,  5 Aug 2024 12:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mBealkmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24B8D888C2; Mon,  5 Aug 2024 12:57:54 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD9988884
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 12:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so12895468a12.2
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1722855471; x=1723460271;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38kOsfUEk+YYaZe6QzZ0JPxxz9qSnI+icbykqiWXYpI=;
 b=mBealkmETbBfur+0oeH+90hDRzjXhm3xGn6HB3PJkEMPKiB2LNUassxrdE7lgusjfe
 VwN4x7zOK4ETTobwRRP4AawRaNg/l83te2EbhoJOQvH94dtzJ4R4o500z9JXhYjzfxos
 N8aUi/LkgVqnbfkMosG3OlBspeORfAEAi1Ovk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722855471; x=1723460271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38kOsfUEk+YYaZe6QzZ0JPxxz9qSnI+icbykqiWXYpI=;
 b=oGCa0lq6UrIV8WnAsZPO2YzfWJaW+NHj91YaGIsPPjiXlqyD01omA47uUa8PerdzVg
 Jp6+JrVin/r2kmCiN99XAWrR5dACOZD28F4jMKP2UrNlXCBR3lP2bagVfdkiM7ggJ57E
 jNK5PGW9g19ERHcoipGZstpHMJDDM56kVvstbIGGecEypZIlsSYNmt0i45bJaHjeDC7d
 3+mAtbiZAwO/jjvEH3STQyYJhExDSRDL1YPedqUl/qEt3SU1JU2Ij87eVAqzRsrUC7ed
 OExSWDbkd4/MyktiofJ8Fw57uKvUuzVyZ2yYIBC0Mwy4ieIittPKPTYyiGzQDMlx8cXX
 jm/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxsRbHwShIKJPOBkyyXORa9839FNwxOuWMxc2A1ffYTieLBFW7RMrEqNfJz+iai0j4EaFEkpcWRFZeD0fp8cnhCaBfRw==
X-Gm-Message-State: AOJu0Yyye4mV26FOWDfvGi6tUauWEci6wwqysel6WREt/a0AtCXitk28
 pv2K04EeRddSJ4Rls2lp4SY4ZPbvBd8i/jpevjabVR9y9ezC4K0pO/Ko4qL90AOwijBYjsu1cKD
 3m4S8/X1iE9lKhrQXwTbLMvgP81mm1dHu1WPGFw==
X-Google-Smtp-Source: AGHT+IGMPAMaHnzlMoa6W8nfD3WroZPjQ3UDKwkZsmZXlF1MvNjndPWrmzO0ujp7HC5x0Agwv5U2VJfoMr+6wajcFb4=
X-Received: by 2002:a17:907:2cc7:b0:a7a:bcbc:f7ee with SMTP id
 a640c23a62f3a-a7dc5080174mr919634566b.37.1722855470620; Mon, 05 Aug 2024
 03:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240703101258.1670825-1-ada@thorsis.com>
 <8f3a7059-6330-f332-8e9f-729b853e001e@denx.de>
 <20240704-goes-grape-25a9f1d14c24@thorsis.com>
 <20240801-wham-entertain-15505d61f84b@thorsis.com>
 <e0c3e3e2-1c7f-e244-5b1d-0498b5771deb@denx.de>
 <363c73bb-54cf-3800-bb31-9af83fbaf33d@marvell.com>
 <44ca37d8-5d8c-80f7-1151-6a77732433f7@denx.de>
 <20240805-outlook-dollhouse-e2d93213b174@thorsis.com>
 <CAOf5uw=LbRAvDvG5_50OF0bUiL1TVfALwMBonza9s2x99tHoBQ@mail.gmail.com>
 <89972a73-b9b6-2ea4-960a-49cb4727cdbf@denx.de>
In-Reply-To: <89972a73-b9b6-2ea4-960a-49cb4727cdbf@denx.de>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 5 Aug 2024 12:57:39 +0200
Message-ID: <CAOf5uwmiA0ZESu=zQEKJsM7Oye2MPTnDtAQ6UEjvGJ5zUr54tQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH 0/4] fs: ubifs: Fix crash and add safeguards
To: hs@denx.de
Cc: Ravi Minnikanti <rminnikanti@marvell.com>, u-boot@lists.denx.de, 
 Stefan Roese <sr@denx.de>, Hans de Goede <hdegoede@redhat.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kyungmin Park <kmpark@infradead.org>, 
 Alexey Romanov <avromanov@salutedevices.com>
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

Hi

I found few places, but I can not test changes against my code. Nice
if someone start to commit and split by file this changes
so we can test everything

Micahel

On Mon, Aug 5, 2024 at 12:54=E2=80=AFPM Heiko Schocher <hs@denx.de> wrote:
>
> Hello Michael,
>
> On 05.08.24 10:58, Michael Nazzareno Trimarchi wrote:
> > Hi all
> >
> > On Mon, Aug 5, 2024 at 10:49=E2=80=AFAM Alexander Dahl <ada@thorsis.com=
> wrote:
> >>
> >> Hello,
> >>
> >> Am Mon, Aug 05, 2024 at 07:28:19AM +0200 schrieb Heiko Schocher:
> >>> Hello Ravi,
> >>>
> >>> On 01.08.24 21:39, Ravi Minnikanti wrote:
> >>>> Hi Heiko, Alexander,
> >>>>
> >>>> On 7/31/24 23:54, Heiko Schocher wrote:
> >>>>> Hello Alexander, On 01.=E2=80=8A08.=E2=80=8A24 08:=E2=80=8A50, Alex=
ander Dahl wrote: > Hei, > > Am Thu,
> >>>>> Jul 04, 2024 at 10:=E2=80=8A18:=E2=80=8A55AM +0200 schrieb Alexande=
r Dahl: >> Hello Heiko, >> >>
> >>>>> Am Thu, Jul 04, 2024 at 06:=E2=80=8A28:=E2=80=8A31AM +0200 schrieb =
Heiko Schocher:
> >>>>>
> >>>>>
> >>>>> Hello Alexander,
> >>>>>
> >>>>> On 01.08.24 08:50, Alexander Dahl wrote:
> >>>>>> Hei,
> >>>>>>
> >>>>>> Am Thu, Jul 04, 2024 at 10:18:55AM +0200 schrieb Alexander Dahl:
> >>>>>>> Hello Heiko,
> >>>>>>>
> >>>>>>> Am Thu, Jul 04, 2024 at 06:28:31AM +0200 schrieb Heiko Schocher:
> >>>>>>>> Hello Alexander,
> >>>>>>>>
> >>>>>>>> On 03.07.24 12:12, Alexander Dahl wrote:
> >>>>>>>>> Hei hei,
> >>>>>>>>>
> >>>>>>>>> filesystem handling is different in U-Boot and beyond that UBI/=
UBIFS is
> >>>>>>>>> different from other filesystems in U-Boot.  There's UBI and UB=
IFS code
> >>>>>>>>> ported from Linux (quite old already now, maybe someone wants t=
o update
> >>>>>>>>> that?), and there's "glue code" or "wrapper code" to interface =
with
> >>>>>>>>> U-Boot scripts, commands, and filesystem handling.  The fixes a=
nd
> >>>>>>>>> improvements in this patch series are for this U-Boot specific =
glue
> >>>>>>>>> code.
> >>>>>>>>
> >>>>>>>> Yes, the linux base is very old ... patches are welcome!
> >>>>>>>
> >>>>>>> The last sync was back in 2015 from linux v4.2, there were 800+
> >>>>>>> changes to ubi/ubifs in Linux since then. :-/
> >>>>>>>
> >>>>>>>> And for me it is not that easy, as I do not have a hardware with
> >>>>>>>> current mainline U-Boot running on it... I want to update a hard=
ware
> >>>>>>>> I have to current mainline, but I had no time yet for it...
> >>>>>>>
> >>>>>>> Besides the custom hardware here, I used Microchip SAM9X60-Curios=
ity
> >>>>>>> lately, which is coming with a raw NAND flash and can boot from i=
t.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> I'm no filesystem expert, but after days of debugging I'm quite=
 sure the
> >>>>>>>>> bug is in U-Boot since UBIFS support was added in 2009, and it =
was
> >>>>>>>>> repeated in 2015 when generic filesystem support for UBIFS was =
added.
> >>>>>>>>> So please review carefully!
> >>>>>>>>
> >>>>>>>> Which bug?
> >>>>>>>
> >>>>>>> The memory leak and double free fixed with patch 1 of the series.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> The crashes were not easily reproducible, only with boards usin=
g the old
> >>>>>>>>> distroboot _and_ a boot script inspired by (but not equal to) t=
he one
> >>>>>>>>> proposed by RAUC [1], which basically boils down to:
> >>>>>>>>>
> >>>>>>>>>       ubifsmount ubi0:boot (from distroboot)
> >>>>>>>>>       test -e (from distroboot)
> >>>>>>>>>       ubifsmount ubi0:rootfs1 (this time from the boot script,
> >>>>>>>>>                                triggering a ubifs_umount)
> >>>>>>>>
> >>>>>>>> So, you have a special sequence you execute to trigger the bug, =
good!
> >>>>>>>>
> >>>>>>>> In special 2 ubifsmount in a row... may not often needed for boo=
ting!
> >>>>>>>> (I ask me, why that is needed? Boottime is not good than...)
> >>>>>>>
> >>>>>>> Using distroboot with a script here.  The script is in a separate=
 UBI
> >>>>>>> volume ubi0:boot, kernel is loaded from ubi0:rootfs1 or ubi0:root=
fs2
> >>>>>>> however.  So there is 'ubifsmount ubi0:boot' from distroboot and =
in the
> >>>>>>> script found, loaded, and run there is 'ubifsmount ubi0:rootfs1' =
(or
> >>>>>>> rootfs2) later.  ubifsmount calls ubifsumount internally if some
> >>>>>>> volume is mounted already.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> BTW: Is this really a good bootcmd in [1] as on *every* boot you=
r
> >>>>>>>>         Environment is saved? This is not good for lifetime of y=
our
> >>>>>>>>         storage device ... why not using bootcounter?
> >>>>>>>
> >>>>>>> Well, I was not aware of bootcounter, but I had a look and the ac=
tual
> >>>>>>> counter must be stored somewhere.  Possible are:
> >>>>>>>
> >>>>>>> - pmic =E2=86=92 has no storage possibility on my board
> >>>>>>> - rtc =E2=86=92 soc internal only, volatile in the end (if batter=
y is empty)
> >>>>>>> - i2c eeprom =E2=86=92 missing
> >>>>>>> - spi flash =E2=86=92 missing
> >>>>>>> - filesystem =E2=86=92 ends up on the flash
> >>>>>>> - nvmem =E2=86=92 no other nvmems present
> >>>>>>> - syscon or some cpu register or sram =E2=86=92 volatile
> >>>>>>>
> >>>>>>> So none of these are possible in my case, I only have a raw NAND =
as
> >>>>>>> storage and thus I have to use U-Boot env, which is stored in UBI=
 here
> >>>>>>> btw to not stress the flash too much.
> >>>>>>>
> >>>>>>> I could investigate if it would be possible to let RAUC use the
> >>>>>>> U-Boot bootcounter infrastructure, but currently RAUC depends on
> >>>>>>> U-Boot environment variables for tracking boot attempts.
> >>>>>>>
> >>>>>>> btw: documentation of bootcount is sparse, I only found the very =
short
> >>>>>>> 'doc/README.bootcount' and it's not even migrated to recent U-Boo=
t
> >>>>>>> sphinx based docs. ;-)
> >>>>>>>
> >>>>>>> But from what I understood the concept is the same, U-Boot counts
> >>>>>>> something and Linux userspace has to reset it.  The counter must =
be
> >>>>>>> stored somewhere, for example in U-Boot env if no other storage i=
s
> >>>>>>> possible.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> Crashes can be triggered more easily, if patch order is changed=
 and
> >>>>>>>>> patch 2 (resetting pointers to NULL after free) comes first, or=
 if patch
> >>>>>>>>> 2 is applied on its own only.
> >>>>>>>>
> >>>>>>>> Hmm...
> >>>>>>>>
> >>>>>>>>> The fix is in the first patch, and on my boards I see no crashe=
s
> >>>>>>>>> anymore.  I also tested all kinds of combinations of calling `u=
bi part`,
> >>>>>>>>> `ubi detach`, `ubifsmount`, `ubifsumount`, `ubifsls`, `ubifsloa=
d`, `ls`,
> >>>>>>>>> `load`, `size`, and `test -e` and got no crashes anymore after =
the fix.
> >>>>>>>>
> >>>>>>>> That sounds good! Hmm.. test -e has nothing to do with ubi/ubifs=
 I think.
> >>>>>>>
> >>>>>>> Oh it has, 'test -e' calls file_exists() which calls fs_exists() =
which
> >>>>>>> ends up calling ubifs_exists() which is one of the functions caus=
ing
> >>>>>>> an immediate memory leak, see patch 1.
> >>>>>>>
> >>>>>>>> On what hardware do you test? Is it in mainline?
> >>>>>>>
> >>>>>>> Tested on custom hardware, but I'm confident it should be reprodu=
cible
> >>>>>>> on any board using ubifs, especially after applying patch 2 reset=
ting
> >>>>>>> pointers of freed memory to NULL.  This should trigger the bug wi=
th
> >>>>>>> the simple sequence already described:
> >>>>>>>
> >>>>>>>      > ubifsmount ubi0:anyvolume
> >>>>>>>      > ls ubi ubi0:anyvolume / # (or load, or test -e, or size)
> >>>>>>>      > ubifsumount
> >>>>>>>
> >>>>>>> ubifsumount will call ubifs_umount() which calls
> >>>>>>> ubi_close_volume(c->ubi), that pointer is either invalid leading =
to a
> >>>>>>> double free inside of ubi_close_volume() and it will crash only i=
n
> >>>>>>> certain conditions or the pointer is NULL after applying patch 2 =
of
> >>>>>>> the series, then ubi_close_volume() crashes right away with a NUL=
L
> >>>>>>> pointer exception.
> >>>>>>>
> >>>>>>> Note: without patch 2 it very much depends on the sequence of
> >>>>>>> commands, but after the first ubi_close_volume() triggered by
> >>>>>>> ls/load/size/exists the pointer in ubifs_sb is invalid, but acces=
sed later
> >>>>>>> by the second ubi_close_volume() triggered by ubifs_umount().  If=
 you
> >>>>>>> do something in between those using the freed memory by something=
 else
> >>>>>>> again, the second ubi_close_volume() access might get corrupted d=
ata
> >>>>>>> or access things outside of RAM.  Patch 2 redirects this on a cle=
an
> >>>>>>> NULL pointer exception you can easily trigger.
> >>>>>>>
> >>>>>>> In my case I got a pointer variable actually containing a string
> >>>>>>> "ng.." aka 0x2e2e676e which looked suspiciously similar to a vali=
d
> >>>>>>> pointer on the platform somewhere in RAM between 0x20000000 and
> >>>>>>> 0x28000000 so it took me two days to realize it's not a pointer. =
;-)
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> The three additional patches (2 to 4) are more or less safeguar=
ds and
> >>>>>>>>> improvements for the future, and come from me trying and my deb=
ugging
> >>>>>>>>> code done on the way, more or less optional, but I think nice t=
o have.
> >>>>>>>>
> >>>>>>>> I will look at them .. but give me some time, as I am in holiday=
s the
> >>>>>>>> next 2 weeks ... Hmm.. and it would be good to get some Tested-b=
y
> >>>>>>>> from people with hardware...
> >>>>>>>
> >>>>>>> Take your time, no need to work in holidays.  Would appreciate a
> >>>>>>> Tested-by by anyone else though, maybe some of the raw NAND folks=
?
> >>>>>>
> >>>>>> Well, apparently nobody had a look in the month of July, I add the=
 raw
> >>>>>> NAND maintainers in Cc, maybe I should have done in the first plac=
e.
> >>>>>>
> >>>>>> Would be happy if someone could have a look at the fix, maybe read=
 the
> >>>>>> patches first before the discussion? ;-)
> >>>>>
> >>>>> I asked Ravi and Alexey (added to cc) if they have time to look it =
they
> >>>>> can reproduce the issue and test your patches...
> >>>>>
> >>>>> bye,
> >>>>> Heiko
> >>>>
> >>>> I tried to reproduce with CONFIG_SYS_MALLOC_LEN reduced to 1MB and
> >>>> calling ubifsls in a loop, logic below:
> >>>>
> >
> >
> >>>> ubi part ubi0:rootfs
> >>>> ubifsmount ubi0:rootfs
> >>>> setenv i 1
> >>>> while test $i -le 200; do
> >>>>       ubifsls a/b/test.bin
> >>>>       setexpr i $i + 1
> >>>>       sleep 1
> >>>>       echo "Loop count: $i"
> >>>> done
> >>>
> >>> Thanks for testing! But it is not exactly the same sequence Alexander
> >>> described ... but you also trigger a bug.
> >>
> >
> > diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
> > index 048730db7f..33df4ff51f 100644
> > --- a/fs/ubifs/ubifs.c
> > +++ b/fs/ubifs/ubifs.c
> > @@ -557,6 +557,7 @@ static unsigned long ubifs_findfile(struct
> > super_block *sb, char *filename)
> >
> >                          /* We have some sort of symlink recursion, bai=
l out */
> >                          if (symlink_count++ > 8) {
> > +                               ubifs_iput(inode);
> >                                  printf("Symlink recursion, aborting\n"=
);
> >                                  return 0;
> >                          }
> > @@ -568,6 +569,7 @@ static unsigned long ubifs_findfile(struct
> > super_block *sb, char *filename)
> >                                   * the leading slash */
> >                                  next =3D name =3D link_name + 1;
> >                                  root_inum =3D 1;
> > +                               ubifs_iput(inode);
> >                                  continue;
> >                          }
> >                          /* Relative to cur dir */
> > @@ -575,6 +577,7 @@ static unsigned long ubifs_findfile(struct
> > super_block *sb, char *filename)
> >                                          link_name, next =3D=3D NULL ? =
"" : next);
> >                          memcpy(symlinkpath, buf, sizeof(buf));
> >                          next =3D name =3D symlinkpath;
> > +                       ubifs_iput(inode);
> >                          continue;
> >                  }
> >
> > @@ -583,8 +586,10 @@ static unsigned long ubifs_findfile(struct
> > super_block *sb, char *filename)
> >                   */
> >
> >                  /* Found the node!  */
> > -               if (!next || *next =3D=3D '\0')
> > +               if (!next || *next =3D=3D '\0') {
> > +                       ubifs_iput(inode);
> >                          return inum;
> > +               }
> >
> >                  root_inum =3D inum;
> >                  name =3D next;
> >
> >
> > Should we not free inode_iget?
>
> Yep, that patchsnipset seems valid to me ... We should check
> all calls from ubifs_get() ... so I think we need to correct also
> filldir() fucntion in this file?
>
> and
>
> fs/ubifs/recovery.c ubifs_recover_size()
> fs/ubifs/super.c ubifs_fill_super()
>
> ?
>
> bye,
> Heiko
> >
> > Michael
> >
> >> +1 =E2=80=A6 thanks for testing. :-)
> >>
> >>>> It crashes with or without patch. With patch it takes 4,5 loops more=
 to crash.
> >>>>
> >>>> Log:
> >>>> UBIFS error (ubi0:0 pid 0): ubifs_iget: failed to read inode 85, err=
or -12
> >>>> "Synchronous Abort" handler, esr 0x96000004
> >>>
> >>> -12 =3D -ENOMEM
> >>>
> >>> So it seems, we have a memleak...
> >>
> >> If with my patch it takes more loops to crash, this suggests we have
> >> more than one memory leak, and of them got fixed with my patch(es).
> >>
> >>> Yes, ubi/ubifs linux base is very old, but I tend to think that probl=
em is
> >>> in U-Boot adaption layer...
> >>
> >> I would also suspect the adaption layer.
> >>
> >> However, although my patch fixes one memory leak, that was not the
> >> main reason doing this.  The reason of the crash in my case was the
> >> double free, and accessing invalid memory afterwards.  So from my
> >> perspective the patches are okay on their own, and looking after more
> >> memory leaks should not be part of this series.
> >>
> >> Greets
> >> Alex
> >>
> >> P.S.: not sure what's causing this, but I only got the mails from you
> >> all through the mailing list.  You can keep me in Cc, so I won't
> >> overlook your answers easily.
> >>
> >>>
> >>> bye,
> >>> Heiko
> >>>>
> >>>>
> >>>> Thanks,
> >>>> Ravi
> >>>>>>
> >>>>>> Greets
> >>>>>> Alex
> >>>>>>
> >>>>>>>
> >>>>>>> Greets
> >>>>>>> Alex
> >>>>>>>
> >>>>>>>>
> >>>>>>>> bye,
> >>>>>>>> Heiko
> >>>>>>>>>
> >>>>>>>>> Greets
> >>>>>>>>> Alex
> >>>>>>>>>
> >>>>>>>>> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gith=
ub.com_rauc_rauc_blob_master_contrib_uboot.sh&d=3DDwIDaQ&c=3DnKjWec2b6R0mOy=
Paz7xtfQ&r=3D3apjoJolwzwH82pd_c1HzSLzzrwfu9x1lSm802edgOg&m=3Dlpy642UhqtTXHV=
0dd0xnOtQxkQSO5RC6FwcUbzt-FsNwd3QSXZsulfqC6dP9qV7G&s=3Dwbnw_T9_r6taMKIFqJ2-=
wtj9Zv02OD7mbIy-ZZFRjRE&e=3D  <https://urldefense.proofpoint.com/v2/url?u=
=3Dhttps-3A__github.com_rauc_rauc_blob_master_contrib_uboot.sh&d=3DDwIDaQ&c=
=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D3apjoJolwzwH82pd_c1HzSLzzrwfu9x1lSm802edgOg&m=
=3Dlpy642UhqtTXHV0dd0xnOtQxkQSO5RC6FwcUbzt-FsNwd3QSXZsulfqC6dP9qV7G&s=3Dwbn=
w_T9_r6taMKIFqJ2-wtj9Zv02OD7mbIy-ZZFRjRE&e=3D>
> >>>>>>>>>
> >>>>>>>>> Alexander Dahl (4):
> >>>>>>>>>       fs: ubifs: Fix memleak and double free in u-boot wrapper =
functions
> >>>>>>>>>       fs: ubifs: Set pointers to NULL after free
> >>>>>>>>>       fs: ubifs: Make k(z)alloc/kfree symmetric
> >>>>>>>>>       fs: ubifs: Add volume mounted check
> >>>>>>>>>
> >>>>>>>>>      fs/ubifs/super.c |  8 ++++++--
> >>>>>>>>>      fs/ubifs/ubifs.c | 31 +++++++++++++++++++------------
> >>>>>>>>>      2 files changed, 25 insertions(+), 14 deletions(-)
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> base-commit: 65fbdab27224ee3943a89496b21862db83c34da2
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> DENX Software Engineering GmbH,      Managing Director: Erika Un=
ter
> >>>>>>>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Ge=
rmany
> >>>>>>>> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@de=
nx.de
> >>>>>
> >>>>> --
> >>>>> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> >>>>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germa=
ny
> >>>>> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.=
de
> >>>>>
> >>>
> >>> --
> >>> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> >>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> >>> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
> >
> >
> >
>
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
