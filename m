Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5BF10F92E0
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 16:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF5183E7A;
	Tue, 31 Mar 2026 18:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nWAOLRjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B65F384010; Tue, 31 Mar 2026 18:13:50 +0200 (CEST)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B04D483DA6
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 18:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-1274204434bso27427c88.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 09:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774973626; cv=none;
 d=google.com; s=arc-20240605;
 b=Dl3kvE6fjtVMiIUq8SAFFFrgM4uIC5xnmeo7mEDaOEhf/T397Hg0DLik+rgGFnR+lK
 i8ybk6I688+P4s4m8SA93hwrfZtUjg2DwdamQx9NRiQv7aJUzlxU+MoAzbQAZlxAlZt5
 H92ukHCD1Owyit2mo8ztEtJNVROY9IDAM/YPfvGx0ArNKI4QoyKDck5+vfJtHqikA54u
 1tui1OQG7gnictSlgYNMtkde96M5KUINyRlkHZCArP51KvvrtVvRsuuC7JnJVy3pt9q9
 k891In+73BzB5mTadllABlNdnYN3V+RtkjiAbap4RTvAqcbJTcHCzGYgExfuKwP/FnTT
 Apng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UOxnN9jUTz+r6zG+3jZw0qu7ODYXXhjPZt5IrAougy8=;
 fh=LObbwW4JGpDInngAlISVP9WwdUsKxdl9fuxqvKSlRS0=;
 b=aRrv51uC2fd/qxLoKtka2op4DSNQQEbE4dGeN6vXIq1Og5k9RxTyCHjgnlYU/JirTh
 G5O424E/5/ORvhuw/uMOiv833+XUETW8EuDcLr8pGHxaLnsz61vRJZkeaZRwY5OhJhYM
 rTS4PmJ5N6yKX/a/C7DO3Rq2DIfubj+p2ueklcs2FZ9Y/A27TokRIiGZRhLlZPXH1pLW
 +Bg8M8WJzOIyuJHnJxzn0VdghcM2Hu//2SFYuqme6P6q1yjxS+By/O6vVfqbFU6kzIlj
 6caQBy3rbsW3DSMi2oGyQdlfs+8Bix8AjVyez3+s8MciXOm7G9Heu6xpO0dWo7supDkn
 untQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774973626; x=1775578426; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOxnN9jUTz+r6zG+3jZw0qu7ODYXXhjPZt5IrAougy8=;
 b=nWAOLRjKVaRLR69kMVZMJBzdBvXgcnygbpNpPk3eYWsMP79wvI3c0e5WHnVKQs62nV
 /yS46vfcKaznxLucxsvMgsfcPw/CMHd5kK7LiSvdQkOUnZzCj7SqfBD7R1+CZ6mBCAld
 J0TUCFOFZncXSk22fvjsMNfLQb+tFjhi1lLdaU7OsUwemHZcjSZjCcybDWa10NadsSE4
 nyNEvUdvSjBNNvUTwyh1bO0/dnwqrEzxOF9as2TkFx4RUPcn6dxDnoYG8JSqosEAKwzi
 m4erNg9W+tIjtnA5FDqBnypLOvpJxkjev0D402VNN+GmkFT8KrLjQbgU2vqasOc3mbHY
 WluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774973626; x=1775578426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UOxnN9jUTz+r6zG+3jZw0qu7ODYXXhjPZt5IrAougy8=;
 b=IIbN0DigIrBv/pTMY3QfUfnGf/trlUtKCb7uLhwIDXw5Vw6aEjiM8+H/H0lf25Fd9X
 LghSEQ9NFNOXbMP1sr3Hf6h++uXevZ58cM0wNO1M6iJxs85X1gppXft0ZWkogHSvwoB7
 exqNbFx1x8c8rlmCYPecJwLUy2dxTgL1jMxlS7jToONPSiQgPZKk5kxVG31T5/xzwtDP
 E5Wf4PmHEH0NDaCkQGaAaPEfeG+3ibv84/CUYS/oEQVY0okEqT5VTHhnxXMOQWJyueg6
 bH5FoVDfWWC2tvLnxp8J11ULzyUpWmneyhXP5yP3Sr7ZirwTaRIMyDQRH8GHy6JLojWD
 w5Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSH+XIbepwK/GUWl0bj7AFN4atbDoEWmi7NC4owLNovnXBL4Ys+nj8uA/kjtPVswOyk2y4KwI=@lists.denx.de
X-Gm-Message-State: AOJu0YyMm6YPR9LVX/Ucr6zx0yYEDzAHCK2GvuUea4REKdd4vRLQojRP
 6SfHeH4592VXO00V6WGrxH9CGqqk3oG+q27lO6P2eQhkw+JbfCvIQdhaFXjY7IhygRnrW3Ux2WI
 /4kaeygWt1C9AfZlU/suZun5fw3l8I1U=
X-Gm-Gg: ATEYQzxsU2r70mjecmzzuKmhcorpUNM7HBtQIIEr6EOaSors0CNzl0NA+r0mQFspXla
 eCNEHHcK5umqAwhOJnuCGeoXc2+9mwtzEOVu6QNj40jSLhmm6XqKUDp4fILlFWy65pGLYuEvy6j
 3THqH4OaU31BK7LSq/vMCNMvHqVjhs3OnO6D0c57TVtxupJHofqbOj0G4yQj5aSTQdYFakph4s3
 K2KB+1voTKQx5kS03xJCtZKo9Z0bRL8B6XcWXkw8LtzRd8+aTo+sB6CMGUTn2laEwiDgt+PkEUT
 bULqC7c25eN1GlkP9Xfa8XBfMnoqLXHaZ1Nv4uyla6aSvpKW7qoz2apiG1EJ0wCBwHtJhDD1lqh
 kXQeK/rngHL2xE1GdA4FhWRWTx0E=
X-Received: by 2002:a05:7022:1284:b0:123:3c24:b15 with SMTP id
 a92af1059eb24-12bddf0c8aemr1930677c88.19.1774973625538; Tue, 31 Mar 2026
 09:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-3-rs@ti.com>
 <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
 <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com> <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com>
 <DHGIV5UK2POR.T98MMILTXQWC@ti.com>
In-Reply-To: <DHGIV5UK2POR.T98MMILTXQWC@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 31 Mar 2026 11:13:18 -0500
X-Gm-Features: AQROBzAasojMyXHLvajfo1FsysPNfleQMnzPWE2h05EB4E0J_nsoxfmUezXCvbk
Message-ID: <CAOCHtYjF2f2UNbwC=ph2GSWZ6ZKWZKiAAXqXOM2RmrGrarRBxA@mail.gmail.com>
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
To: Randolph Sapp <rs@ti.com>, Ayush Singh <ayush@beagleboard.org>
Cc: Erik Welsh <Erik.Welsh@octavosystems.com>, Anshul Dalal <anshuld@ti.com>,
 bb@ti.com, nm@ti.com, trini@konsulko.com, afd@ti.com, u-boot@lists.denx.de
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

adding @Ayush Singh   too...

On Mon, Mar 30, 2026 at 6:57=E2=80=AFPM Randolph Sapp <rs@ti.com> wrote:
>
> On Thu Mar 26, 2026 at 6:23 PM CDT, Randolph Sapp wrote:
> > On Wed Mar 25, 2026 at 7:34 PM CDT, Randolph Sapp wrote:
> >> On Mon Mar 23, 2026 at 2:46 PM CDT, Robert Nelson wrote:
> >>> On Mon, Mar 23, 2026 at 2:37=E2=80=AFPM Randolph Sapp <rs@ti.com> wro=
te:
> >>>> On Fri Mar 20, 2026 at 10:32 AM CDT, Robert Nelson wrote:
> >>>> >> > +++ b/configs/am62_pocketbeagle2_a53_defconfig
> >>>> >> > @@ -6,11 +6,11 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> >>>> >> >  CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> >>>> >> >  CONFIG_NR_DRAM_BANKS=3D1
> >>>> >> >  CONFIG_SOC_K3_AM625=3Dy
> >> [snip]
> >>>> >> > @@ -120,7 +115,8 @@ CONFIG_SYSRESET_TI_SCI=3Dy
> >>>> >> >  CONFIG_EXT4_WRITE=3Dy
> >>>> >> >  CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
> >>>> >> >  CONFIG_LZO=3Dy
> >>>> >> > -CONFIG_EFI_SET_TIME=3Dy
> >>>> >> > +CONFIG_SYS_MEM_TOP_HIDE=3D0x4000000
> >>>> >>
> >>>> >> Any reason why we are using TOP_HIDE here instead of just moving =
OPTEE
> >>>> >> lower in DDR like we do on the 512MiB AM6254atl EVM?
> >>>> >
> >>>> > Sorry, that is now a legacy setting before OPTEE finally got moved=
 in
> >>>> > v2026.01, as this had been developed thru v2025 u-boot releases..
> >>>> >
> >>>>
> >>>> Well, it's worth noting that this change was not done in the usual w=
ay, and
> >>>> involves user interaction during the build beyond selecting a defcon=
fig.
> >>>>
> >>>> https://texasinstruments.github.io/processor-sdk-doc/processor-sdk-l=
inux-AM62X/esd/docs/master/linux/Foundational_Components_ATF.html
> >>>> https://git.ti.com/cgit/arago-project/meta-ti/tree/meta-ti-bsp/conf/=
machine/am62xxsip-evm.conf
> >>>>
> >>>> Robert, are you alright with me making the requested changes?
> >>>
> >>> I guess as long as we document it. I know the Octavo OSD62-sip @Erik
> >>> Welsh  will also be building on both am62xxsip and pocketbeagle2 base=
d
> >>> on the 512MB and then larger memory sizes (1G, 2G, etc.).
> >>>
> >>> Regards,
> >>
> >> Oh boy, adjusting the memory maps kept getting me out of memory errors=
 in the
> >> EFI flow that I knew should not be true. Found something fun: LMB rese=
rved
> >> memory regions do not match EFI reserved memory regions. EFI's
> >> efi_carve_out_dt_rsv is setting regions to be more strict that LMB's b=
ase
> >> requirements. When this occurs and an allocation runs into this discre=
pancy,
> >> that allocation and all future allocation requests in the EFI flow wil=
l begin to
> >> fail as they are repeatedly given the same LMB start address in the un=
approved
> >> region.
> >>
> >> Randolph
> >
> > Alright, looking into the allocation helpers it seems that
> > EFI_CONVENTIONAL_MEMORY can be remapped in efi_allocate_pages so long a=
s LMB
> > agrees that it's free. This aligns with my understanding of the UEFI sp=
ec as
> > well. I dumped the EFI memory map and noticed there were 2 fragmented s=
ections
> > of EFI_CONVENTIONAL_MEMORY that it could still use.
> >
> > Wired up efi_allocate_pages to go to those regions and attempt to alloc=
ate from
> > there in the even an LMB_MEM_ALLOC_MAX or LMB_MEM_ALLOC_ANY start faili=
ng. Seems
> > to have worked, but now I'm seeing the following reported in the kernel=
:
> >
> > [    0.048167] [Firmware Bug]: Unable to handle paging request in EFI r=
untime service
> > [    0.048246] ------------[ cut here ]------------
> > [    0.048249] WARNING: CPU: 0 PID: 1 at /usr/src/kernel/drivers/firmwa=
re/efi/runtime-wrappers.c:341 __efi_queue_work+0xd4/0x108
> > [    0.048270] Modules linked in:
> > [    0.048285] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G         =
 I         6.18.13-ti-00636-g30182cf3ac7d-dirty #1 PREEMPT
> > [    0.048296] Tainted: [I]=3DFIRMWARE_WORKAROUND
> > [    0.048299] Hardware name: beagle BeagleBoard.org PocketBeagle2/Beag=
leBoard.org PocketBeagle2, BIOS 2026.04-rc5-00003-gf1dace477fb8-dirty 04/01=
/2026
> > [    0.048305] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [    0.048312] pc : __efi_queue_work+0xd4/0x108
> > [    0.048318] lr : __efi_queue_work+0xc0/0x108
> > [    0.048323] sp : ffff80008003bc80
> > [    0.048326] x29: ffff80008003bc80 x28: ffffad05b176bad4 x27: ffffad0=
5b16b00ac
> > [    0.048336] x26: ffffad05b1622e60 x25: ffffad05b1953000 x24: ffffad0=
5b1749050
> > [    0.048345] x23: 0000000000000004 x22: ffff80008003bd1e x21: ffff800=
08003bd20
> > [    0.048353] x20: ffff80008003bd28 x19: ffffad05b19cd5d8 x18: fffffff=
ffffe2f20
> > [    0.048362] x17: 0000000000007000 x16: ffff000001c065a0 x15: 0000000=
000000000
> > [    0.048370] x14: 000000000000008a x13: ffff000001cf8090 x12: 0000000=
000000001
> > [    0.048379] x11: 00000000000000c0 x10: 00000000000009f0 x9 : ffff800=
08003bad0
> > [    0.048387] x8 : ffff000001cf8a50 x7 : 0000000000000001 x6 : 0000000=
000000001
> > [    0.048395] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000=
000000001
> > [    0.048403] x2 : 0000000000000000 x1 : 8000000000000015 x0 : 8000000=
000000015
> > [    0.048413] Call trace:
> > [    0.048417]  __efi_queue_work+0xd4/0x108 (P)
> > [    0.048426]  virt_efi_get_next_variable+0x5c/0xac
> > [    0.048434]  efisubsys_init+0x148/0x390
> > [    0.048444]  do_one_initcall+0x60/0x1d4
> > [    0.048457]  kernel_init_freeable+0x248/0x2c4
> > [    0.048468]  kernel_init+0x20/0x140
> > [    0.048478]  ret_from_fork+0x10/0x20
> > [    0.048489] ---[ end trace 0000000000000000 ]---
> >
> > U-boot itself doesn't report any errors, so I want to assume this is pr=
obably a
> > configuration issue regarding something else I've forgotten to add.
> >
> > Anyone got any quick/obvious comments before I start digging through mo=
re of
> > that? Was my assumption about EFI_CONVENTIONAL_MEMORY incorrect? Is thi=
s, as
> > unlikely as I think it is, actually just a known issue right now?
>
> Ugh, that took longer than it should have. Alright, what I did would have=
 been
> correct if there weren't a few issues with other things. Primarily, this =
memory
> map for the am6254atl. The U-Boot stack overlaps 2 regions we carve out i=
n
> device tree. LMB doesn't actually inform the user of this, and just keeps
> trucking, thinking that the general u-boot reservation will be good enoug=
h.
>
> Eventually, when some of the stack can be reclaimed, we will put some use=
ful
> things in these regions that were never properly reserved.
>
> What was driving me crazy was that the efiboot selftest reported that eve=
rything
> was okay except for the device tree region. Fun, what could have changed =
that?
> Well, that's just efi_carve_out_dt_rsv going back and trying to enforce t=
hings
> LMB never did.
>
> Somehow we got it perfectly where copy_fdt would place the device tree sq=
uarely
> in a region that was reserved by the device tree itself. Anything else wo=
uldn't
> have been exposed to the user.
>
> So, I assume that kernel warning is actually a result of some EFI regions=
 being
> reclaimed by efi_carve_out_dt_rsv and the runtime blowing up because what=
 it
> thought was a valid address is now in some reserved region.
>
> I've checked and am6254atl is also not able to reserve the
> wkup_r5fss0_core0_memory_region (0x9db00000) at startup due to the u-boot=
 stack
> size. A ram top value of 0xa0000000 doesn't work with these reservations.
>
> Adjusting the CONFIG_STACK_SIZE won't help here, as it u-boot naturally e=
xtends
> into the wkup_r5fss0_core0_memory_region on it's own. I was seeing a stac=
k size
> of 0x22184c0 locally at the time reservations were being setup.

Ayush is dealing with Zephyr fallout too. I'm wondering if we are
doing too many dynamic memory moves. Do we need to start hard-coding
some of these memory regions in device-tree and then load the 512MB or
1GB memory settings starting in A53 SPL?


Regards,

--
Robert Nelson
https://rcn-ee.com/
