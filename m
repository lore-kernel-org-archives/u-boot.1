Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F753D374BF
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 16:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFA088B0C;
	Fri, 18 Oct 2024 18:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Hw29Aqpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC6088C3E; Fri, 18 Oct 2024 18:52:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B3888995
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 18:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1729270319; x=1729875119; i=xypron.glpk@gmx.de;
 bh=xVu3boEpqqZMHF3+l0X3votwWTf8+MpQWA4Tv77aayk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Hw29Aqpro3o2I4mmPyC4VPf+Rs/OjsNrl0bR7yvh1lZob2hyguFVoDRIZT8+Eb60
 y71C7d5hm+Z4q2MuTSrSj0As238uFIkjyWqtFiomkiEMm5kHsx9Hg+ljiaLdsayFl
 lNylNo3uFQTu/ZvudPnNP5p7paCXnItiI0eGQYGBpPqRVa+cfgBA0mgwEvWYQWV5v
 YwdJA2cLfZ3wb5ruInmLmxOXBS790rzw5khur52WYMlV5i8IC+J1IwHItDNHf9pLx
 YlMbV2xoIyJe2FSD3mMhWBON4wf48Mw0SnFPRl1TMgwTvTRX8dlrHQXFrPdeCQAhO
 2qDUN1ZLTr/ccSyvJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.105.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4Qwg-1u1xIe3FW2-011SIc; Fri, 18
 Oct 2024 18:51:59 +0200
Date: Fri, 18 Oct 2024 18:51:56 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_06/12=5D_efi=3A_Use_the_s?=
 =?US-ASCII?Q?ame_filename_for_all_sandbox_builds?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszThoC_wQwx_VYDF+86gp6YByZdvaPrfugwpKi94oCxK=vA@mail.gmail.com>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-7-sjg@chromium.org>
 <56ceb77c-efcb-40cb-a497-0952a8457950@gmx.de>
 <CAFLszThLt96h=+28HaD3LmUk-wgj6mnQFav40ndxTxXVZDQw7g@mail.gmail.com>
 <20241018001734.GR4959@bill-the-cat>
 <CAFLszThZY6fOOYovYV2KdQHpZ-1q9RK1HyZxrCY8AJ8MYceeXA@mail.gmail.com>
 <F7608772-31A8-4F25-9FAB-3D4E194C0E88@gmx.de>
 <CAFLszThoC_wQwx_VYDF+86gp6YByZdvaPrfugwpKi94oCxK=vA@mail.gmail.com>
Message-ID: <570AC7AC-7F3B-4585-9449-D27DDDD57084@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pIhUDXaY2B80H6kvpCusUXbfFpaW8xIcwq4XvZyC0gLON6w8nTM
 hrDPeqYxgPxKEW9f6HN8XdoKtnEfhsCQbgXwPbOgv7npk314lNU9AbTZN/hJw04o98qtsfo
 N5CJhIZ25Z3pURLqwGBkRes7NVlurfotCOmxsvqRm0VfiY6f7a0WGMw6xfYdVfVDojepHEC
 hV/y+sbC8B3j5FmAPZcOg==
UI-OutboundReport: notjunk:1;M01:P0:j26tnfDpbAo=;lIQL+6ZfBgnKtNANjWDCXv2lZ/Q
 S4xKseQqom9dpqtSBpuTNjJf/R6fpO/5eIoa2H94JIg1Qu/vfyGsPVhbHj5F7IX1Lbj6sVoUd
 wFRYnJu/UCkZqvE51M+Nj0x5yNnJhHPpbNoqKvXmcLkaOKfM3VRc5fHYHbnhWOPntlw2CmI2W
 gZcusGqN/TpZWFT5npui9mORnH6xL63DHwpWSR6Hvqyi3Dr7RmPB+qWEqdhZef5N2dMvyoR0J
 fZ3N8YQ+VTHqifNuUz+kpEhvOu66xOsgAvCkgMVG37vQ52fbjr+ej7So1IMqF8sd7ELOD0biW
 c6hCKY3wa84IRrOed9oVtwA3BOhhEvDAGSGa9WYmCRPSM+kuf0LTGu/4N8CctxNWY5/205yGX
 66YYL6cL5LNhgaPsMsK8lq++Q+K13fEmnKFGCce3f7WwMPrh+bFU+TUsWZZLRLnl5oPEvRUe3
 ocfwQd1QWovt4r8cMU/sEXVp8qsq6p4qPM2i25XuuNe/3sx7c6LMGSVvBOsG9+PZqd19R5qk0
 nTCi8gng/JU+/7lVTTU5kDSLQbmusLA10Ve3eicGEgVMfIibLN9zCAAmT1ehv918E2iCSFUMt
 prsyq8E1lSw1AX9JofsOFyxD9CU48GMs8uY7Cin3P/6dmmXIyarTqTR/qcWsgttKuswE3Q/LM
 TQ3sihw+iG+cFPaEjmgYDCav9hmEqvHmFgCbgSxicc/9vzilPvIvAli/ptCvnS/gYDrg8BxJg
 obMrfeqMzl2VE8KOy6cZGMSvUWWkFQJIDZJELZHq9U+FlqjbTyRsHWH5HQ0IIovSGDhLXNxpq
 mbk9cfgxQ9ZDmcxsrJYJvbBg==
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



Am 18=2E Oktober 2024 17:02:47 MESZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Heinrich,
>
>On Thu, 17 Oct 2024 at 21:45, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>>
>>
>> Am 18=2E Oktober 2024 05:05:08 MESZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
>> >Hi Tom,
>> >
>> >On Thu, 17 Oct 2024 at 18:17, Tom Rini <trini@konsulko=2Ecom> wrote:
>> >>
>> >> On Thu, Oct 17, 2024 at 05:23:19PM -0600, Simon Glass wrote:
>> >> > Hi Heinrich,
>> >> >
>> >> > On Mon, 30 Sept 2024 at 17:23, Heinrich Schuchardt <xypron=2Eglpk@=
gmx=2Ede> wrote:
>> >> > >
>> >> > > On 26=2E09=2E24 23:59, Simon Glass wrote:
>> >> > > > Sandbox is not a real architecture, but within U-Boot it is re=
al enough=2E
>> >> > > > We should not need to pretend it is x86 or ARM anywhere in the=
 code=2E
>> >> > > >
>> >> > > > Also we want to be able to locate the sandbox app using a sing=
le
>> >> > > > filename, 'bootsbox=2Eefi', to avoid needing tests to produce =
different
>> >> > > > files on each host architecture=2E
>> >> > > >
>> >> > > > Drop the confusing use of host architecture and just let sandb=
ox be
>> >> > > > sandbox=2E
>> >> > >
>> >> > > As I already wrote in
>> >> > > https://lore=2Ekernel=2Eorg/u-boot/ae1cf1fa-766e-46a0-8ef9-2c2c7=
af73d9e@gmx=2Ede/
>> >> > > this patch should not be merged=2E
>> >> > >
>> >> > > bootsbx=2Eefi does not exist in the UEFI specification=2E
>> >> >
>> >> > If that is of concern I can get it added=2E Let me know=2E
>> >> >
>> >> > >
>> >> > > Without this patch I can test that shim work and grub are correc=
tly
>> >> > > loaded from a distro image=2E This patch makes the sandbox misbe=
have=2E
>> >> >
>> >> > Why don't you do that with QEMU?
>> >> >
>> >> > If we want sandbox to do this, I could add a way for sandbox to se=
lect
>> >> > its architecture=2E But this patch is correct, sorry=2E It is basi=
cally a
>> >> > revert of your patch:
>> >> >
>> >> > 3a0654ecd0d efi_loader: correctly identify binary name
>> >> >
>> >> > Let me know if you would like a selection mechanism and I'll see w=
hat I can do=2E
>> >>
>> >> I'm confused=2E It sounds like Heinrich is using sandbox to test on
>> >> various hosts, how U-Boot behaves, without relying on "just test in
>> >> QEMU"=2E I don't see how this disconnects from your usual request on=
 how
>> >> to use sandbox for further testing=2E What is breaking for you, Simo=
n, by
>> >> us saying that the host instruction set determines what we load and =
run
>> >> (and so, is portable whereas saying "sandbox" is not, between x86 ho=
sts,
>> >> arm64 hosts and riscv64 hosts)=2E
>> >
>> >This:
>> >
>> >Also we want to be able to locate the sandbox app using a single
>> >filename, 'bootsbox=2Eefi', to avoid needing tests to produce differen=
t
>> >files on each host architecture=2E
>>
>> As I wrote before:
>>
>> The UEFI specification prescribes the naming of the default boot binary=
=2E Deviating from the specification should be avoided=2E
>
>As I said before, I'm happy to get this added to the spec, if it
>helps=2E It is a real use case=2E

Do you really think that the UEFI organization should care about your test=
 preference? This is just absurd=2E

As tests should run on all devices including but not restricted to the san=
dbox we have to support different names for the default file anyway=2E

This patch has no virtue in this context=2E

Best regards

Heinrich

>
>>
>> Anyway you need different images per host architecture=2E Writing a sin=
gle switch statement to derive the default EFI binary name from the OS arch=
itecture does not look like an undue burden=2E
>
>Yes, it is easy, but it is taking sandbox in a strange direction=2E It
>becomes a hybrid of a host architecture and a U-Boot architecture,
>which is then going to lead to all sorts of strange conversations=2E At
>present it is pretty clear=2E So I want to head this off at the pass=2E
>
>I did not get a chance to review the original patch, of which this is
>essentially a revert=2E It has actually bitten me in a few areas=2E
>
>>
>> The sandbox should remain able to start GRUB from a distro image for th=
e host architecture=2E
>>
>> The sandbox is not a fake architecture but can be considered a valid te=
stbed for host native EFI binaries including GRUB, the kernel stub, the stu=
bs of UKI images, and the EFI SCT=2E
>
>I have to say that I wrote sandbox and I know what it is for=2E It
>wasn't designed to run binaries built outside of U-Boot, or anything
>of the sort=2E That said, as I mentioned, I should be able to make
>something work here=2E
>
>To help me come up with a solution, can you please send your workflow
>/ commands for the testing you do? Also, what architectures do you do
>this with?
>
>My approach to U-Boot is that code needs to land, one way or another,
>perhaps with some changes for the use case that is thrown up, or
>perhaps done another way=2E But please try to consider this approach to
>Open Source too=2E
>
>Regards,
>Simon
>
>
>>
>> Best regards
>>
>> Heinrich
>>
>>
>> >
>> >The idea of using sandbox to run native EFI apps is new to me, but it
>> >sounds great, if it will get us more tests in this area=2E
>> >
>> >But sandbox is sandbox=2E It is not (x86, arm, riscv)=2E It is a fake
>> >architecture that we use in U-Boot=2E I've offered to create a way to
>> >get the behaviour that Heinrich wants, so let's see what he says=2E
>
>Regards,
>SImon
