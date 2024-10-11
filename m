Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18753D0EE19
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 18:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94CEE88C4A;
	Fri, 11 Oct 2024 20:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="gF7uiQyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB47A889B8; Fri, 11 Oct 2024 20:17:09 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39519893C6
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 20:17:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from [127.0.0.1] (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 58210206DE;
 Fri, 11 Oct 2024 20:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1728670626;
 bh=ba3KKV6PCUlV6cXhIp5r4fCJfejyNPqPDgMDoSexHlw=; h=From:To:Subject;
 b=gF7uiQyAURkQKkH8EVWgiIFoJ44JBGUs09BegxYNkc0cQR+C2UdA15B5tHkVhWk+l
 dvE2MEjIx2JaBusjXFuwDfPmer0bM7ikFjAcpf89spGuvoSsic/e8kyfnVW3k7M7sh
 SWlEqG+6r8uChtLNOv8NJ2IPv0xikmoXHt7BGblWCOz+S6IFU84oZcNBwYQs+3qTB3
 lFvq/eu/IQp9OE0yvnjet+o6nY1rXoDbA1i6l2B60EETdTtn1v1sYO105waQZSm5RI
 ntNhaGz2WHXOxrxCb1fqgnbf2IHKTu8ca9k6SGmE6DX9q218cRJi6aWA/6vu5NaZn7
 TCwVbXG3mKsaA==
Date: Fri, 11 Oct 2024 20:17:02 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Massimiliano Minella <massimiliano.minella@gmail.com>
CC: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de, Lukas Funke <lukas.funke-oss@weidmueller.com>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Michal Simek <monstr@monstr.eu>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_cmd=3A_setexpr=3A_fix_no_mat?=
 =?US-ASCII?Q?ching_string_in_gsub_return_empty_value?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGS_c3WoCApeh4QVDrG7=tF=wwEsFStKmRphzfVGTtwKT9yJhQ@mail.gmail.com>
References: <20240208145827.3547501-1-massimiliano.minella@gmail.com>
 <CAHTX3dLUTJ=FKyZT1NaWMsGwKpUwy0MBMsra7YwNQCPERYNDoA@mail.gmail.com>
 <20241008172035.GA66965@francesco-nb>
 <CAGS_c3WoCApeh4QVDrG7=tF=wwEsFStKmRphzfVGTtwKT9yJhQ@mail.gmail.com>
Message-ID: <E9E05009-AEA3-49F8-BF73-2864D29BC422@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

Il 11 ottobre 2024 18:01:22 CEST, Massimiliano Minella <massimiliano=2Emine=
lla@gmail=2Ecom> ha scritto:
>Hello,
>
>On Tue, Oct 8, 2024 at 7:20=E2=80=AFPM Francesco Dolcini <francesco@dolci=
ni=2Eit> wrote:
>>
>> +Tom
>>
>> Hello Massimiliano,
>>
>> On Tue, Sep 03, 2024 at 01:06:21PM +0200, Michal Simek wrote:
>> > HI,
>> >
>> > =C4=8Dt 8=2E 2=2E 2024 v 16:00 odes=C3=ADlatel Massimiliano Minella
>> > <massimiliano=2Eminella@gmail=2Ecom> napsal:
>> > >
>> > > From: Massimiliano Minella <massimiliano=2Eminella@se=2Ecom>
>> > >
>> > > In gsub, when the destination string is empty, the string 't' is
>> > > provided and the regular expression doesn't match, then the final r=
esult
>> > > is an empty string=2E
>> > >
>> > > Example:
>> > >
>> > > =3D> echo ${foo}
>> > >
>> > > =3D> setenv foo
>> > > =3D> setexpr foo gsub e a bar
>> > > =3D> echo ${foo}
>> > >
>> > > =3D>
>> > >
>> > > The variable ${foo} should contain "bar" and the lack of match shou=
ldn't
>> > > be considered an error=2E
>> > >
>> > > This patch fixes the erroneous behavior by removing the return
>> > > statement and breaking out of the loop in case of lack of match=2E
>> > >
>> > > Also add a test for the no match case=2E
>> > >
>> > > Signed-off-by: Massimiliano Minella <massimiliano=2Eminella@se=2Eco=
m>
>> > > ---
>> > > Changes in V2:
>> > >  - update documentation to describe the behavior
>> > >
>> > >  cmd/setexpr=2Ec             |  9 ++++-----
>> > >  doc/usage/cmd/setexpr=2Erst |  1 +
>> > >  test/cmd/setexpr=2Ec        | 10 ++++++++++
>> > >  3 files changed, 15 insertions(+), 5 deletions(-)
>> > >
>> > > diff --git a/cmd/setexpr=2Ec b/cmd/setexpr=2Ec
>> > > index 233471f6cb=2E=2Eab76824a32 100644
>> > > --- a/cmd/setexpr=2Ec
>> > > +++ b/cmd/setexpr=2Ec
>> > > @@ -216,14 +216,12 @@ int setexpr_regex_sub(char *data, uint data_s=
ize, char *nbuf, uint nbuf_size,
>> > >                 if (res =3D=3D 0) {
>> > >                         if (loop =3D=3D 0) {
>> > >                                 debug("%s: No match\n", data);
>> > > -                               return 1;
>> >
>> > This patch actually changed the return value from command=2E
>> > In board/xilinx/zynqmp/zynqmp_kria=2Eenv we have
>> >
>> > bootcmd=3Dsetenv model $board_name && if setexpr model gsub
>> > =2E*$k24_starter* $k24_starter || setexpr model gsub =2E*$k26_starter=
*
>> > $k26_starter; then run som_cc_boot; else run som_mmc_boot; run
>> > som_cc_boot; fi
>> >
>> > and this patch actually breaked it because we rely on return value=2E
>> > Changing return value is not described and I want to know if this
>> > patch should be fixed
>> > or we should update our commands to match new return value=2E
>>
>> Massimilano, any comment on this?
>>
>> This change broke also our use case - our board is no longer booting
>> with v2024=2E10 U-Boot=2E I do not think we should change something lik=
e
>> that without a clear reason and I was not able to understand it from th=
e
>> commit message=2E
>
>The reason why I proposed the patch was that I found the behavior of sete=
xpr
>gsub not consistent with the behavior of the same function in gawk, which=
,
>according to the commit message that introduced gsub/sub, both commands a=
re
>closely modeled after=2E Also I didn't see a particular reason for return=
ing an
>empty string or throwing an error when doing a string substitution that p=
rovides
>no match, so IMHO it was a bug=2E
>
>From a quick grep on the master branch it seems that the command is used =
only in
>board/xilinx/zynqmp/zynqmp_kria=2Eenv and include/env/ti/ti_common=2Eenv=
=2E In the
>first I see it has already been fixed and in the second the change has no
>impact=2E
>
>It's unfortunate that it broke the boot of your board, maybe something as=
 it has
>been done for the zynqmp_kria is feasible according to your use of the co=
mmand?

The U-Boot commands are used (also) outside of the U-Boot repository=2E In=
 my case it was a boot script that was relying on the previous return code=
=2E

Of course, I can adapt the script to work with the new semantic=2E And I h=
ave also to consider that my boot script might be used on an older U-Boot, =
so in practice I need to handle both, and I did it=2E

To me it was a bad decision to change the semantic here=2E My own issue is=
 solved, as I wrote, but I would advise to just revert it=2E

Francesco=20


