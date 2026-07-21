Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE838C4452D
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 22:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A3D480E53;
	Tue, 21 Jul 2026 22:57:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9dcryirePbAl; Tue, 21 Jul 2026 22:57:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11EEF80DEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784674626;
	bh=v/bY+sButImudml1oXDKR2T0B/I7EoXIcDEsRV6s5S8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=CbDJIrxcgh9PIS5VrXGjQUJHi6pKhE3xhzJH2QIKkvpejd6NZyKAGcTyBtOKSMiF6
	 HXmnjc7UfgZHQ2Sxp1WUco7meXqD/nAPvwxdjT5yGwAJcJD8uy2CAIv828z2iJj3pw
	 DQtleJziCrTAj8/OfsjIMW1KSE5DHqVbBkeukZx4eMVu7eZUZK6jfR1SqITnIYSww2
	 WSMRvXrVTNhmBqrIAAOnF+7mvIr/69gKJP4c4954LJ1ZQSQSeZd1Gw4q8nTT7GRt6Q
	 4k+DILw+g19SK4B/RUJ6R52Uestk4LuptILSc6UBAsgA1DS5CaB6wAynAVX+2KOBkO
	 RpiUnMNcKCoQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11EEF80DEF;
	Tue, 21 Jul 2026 22:57:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 11886109C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 22:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBAA080DEF
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 22:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BNO6kdLchRuU for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 22:57:02 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=boogiepop@gmx.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 11DAB80DB5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11DAB80DB5
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 11DAB80DB5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 22:57:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC749848BA; Wed, 22 Jul 2026 00:56:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F55803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 00:56:55 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MowGa-1xLruy1lfS-00cPQg; Wed, 22
 Jul 2026 00:56:54 +0200
Message-ID: <68f9f2bc-485e-4cbe-9ed7-8f34efdd8440@gmx.com>
Date: Wed, 22 Jul 2026 00:56:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: u-boot@lists.denx.de, quentin.schulz@cherry.de,
 Johan Jonker <jbx6244@gmail.com>
References: <e108fe69-533a-4734-8728-b17b172c4be9 () cherry ! de>
Content-Language: en-US
In-Reply-To: <e108fe69-533a-4734-8728-b17b172c4be9 () cherry ! de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YHhve3AhW+aJDL25LquXv6PFtIrFI44VmZxTWTNHUCBGlw02rA7
 E0AnPAXKTu4EqC8mJXiFNGHSgofpJu4vBjnQsyL80r5gLduy7gUL+vKioAqZkfu2uondmH/
 4pRdk/FnxbSDiesBMJBeSffteoPpPlPL9AMlDACRsU+CiDJ1J2QZ88KMDg2zdl+XkouE4kd
 Hm1MefVl3OB80km9BukUA==
UI-OutboundReport: notjunk:1;M01:P0:dkbYoBx+g30=;q6DP+VZ9bQwvYCOoXSv21zn6V7A
 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
 =
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.com; 
 s=s31663417; t=1784674614; x=1785279414; i=boogiepop@gmx.com;
 bh=v/bY+sButImudml1oXDKR2T0B/I7EoXIcDEsRV6s5S8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GEaWTnCfV35IdzigI+qWUlRfSoy+AuR3YmU8SJ5lCBLL606vwntahdKYM1JNTCB2
 x+EyXz1xsLDExhXu0aMXna9pjrgyrOjTmigRv5q69wQ6kM9FHD5KLK7gHjihMycHB
 tYGjPq8k+YWOcdNlgvZjUV8SFpAUsvQTuAQ45KOF1IZoWvJ26ZMeD7cNYNV9plZhu
 KE5V+gGpneJhftGWJbziM7emN32wT+pAmyARzglqkvX9hst257uhVgRywPayG4EtT
 6AK0wrDQN2saqkRdhFWzVFAh7bVEqS0IPdv/bVzrFN7HseNPR+tl5Aih2TlB9pUcT
 Qttq9Y+9lbjrsFv4nw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.com header.i=boogiepop@gmx.com
 header.a=rsa-sha256 header.s=s31663417 header.b=GEaWTnCf
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=boogiepop@gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.com header.i=boogiepop@gmx.com header.b="GEaWTnCf"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Boogie via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Boogie <boogiepop@gmx.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hello Quentin

I had reported this bug to Johan so i can give detailed explanation.

The bug was really the lock of "&& nfc->selected_bank =3D=3D 0" not existi=
ng=20
for write_page_* variants.

When rockchip nfc was reading, it required bootblks to be a part of the=20
first nand chip only with the condition "nfc->selected_bank =3D=3D 0". But=
=20
when writing it interpreted 'all' nand chips first boot_blks as boot block=
s.

The practical problem. I had mentioned this in V1 and give more explicit=
=20
details here.

I have 2 nand chips, and a partition (linux below) starts in nand chip 1=
=20
(CS=3D0 in below) and ends in chip2 (CS=3D2 below). And i am using UBI on=
=20
top of that mtd.

nand@0 {
     reg =3D <0>, <2>;
     label =3D "rk-nand-0";
     nand-bus-width =3D <8>;
     nand-ecc-mode =3D "hw";
     nand-ecc-step-size =3D <1024>;
     nand-ecc-strength =3D <40>;
     nand-is-boot-medium;
     rockchip,boot-blks =3D <8>;
     rockchip,boot-ecc-strength =3D <24>;

     // block 14 - end
     linux@1C00000 {
         label =3D "linux";
         reg =3D <0x0 0x1C00000 0x3 0xFE400000>;
     };
};

When i create the UBI volume the middle of this partition where the=20
blocks are at 2nd chip block0-7, will be written in boot block strength=20
[ECC:1024/24] but will be read with normal strength [ECC:1024/40].

This causes first UBI creation to be successful, and next scan to fail=20
due to written strength is different that read.

You dont actually need to use UBI at all, any time you write those=20
sectors, you wont be able to read them. A workaround it to mark them=20
bad, but this is not nice, since the blocks are completely fine.

Rockchip NFC technically as minimum needs to know rockchip,boot-blks, &=20
rockchip,boot-ecc-strength props only. Currently the checking condition=20
is rockchip,boot-blks & applied affect is rockchip,boot-ecc-strength.

The bug is this is only applicable to first chip not all chips.

NAND_IS_BOOT_MEDIUM is actually coming from mainline linux. Similar=20
bootrom tricks are also available in other socs. And detection of boot=20
rom blocks is not always straight forward as rockchip's=20
rockchip,boot-blks, they have to do some "if" case acrobatics to detect=20
those. For simplicity reasons mainline linux introduced a global flag=20
NAND_IS_BOOT_MEDIUM and it is applied to other socs as well.

Since this "&& nfc->selected_bank =3D=3D 0" fix is exactly at the same lin=
e=20
with mainline changes of NAND_IS_BOOT_MEDIUM check, i think Johan also=20
integrated both at the same line.

In u-boot only mk808 is using nfc with boot blocks and it is already=20
marking the nand device as boot medium, so the code change should not=20
break existing devices.

Additional note: Linux mainline also is lacking the "nfc->selected_bank=20
=3D=3D 0" check, so i think similar patch should got to linux as well.

@johan if anything i am missing feel free to correct me.

h=C3=BCseyin

On 7/20/26 20:25, Quentin Schulz via U-Boot wrote:
> Hi Johan,
>=20
> Resending because the ML rejected my mail sent from my other address...
> I have to figure out what I set up wrong to trigger the spam filter :)
>=20
> On 7/14/26 8:39 AM, Johan Jonker wrote:
>   > The Rockchip boot ROM only checks for NAND chip 0 and with
>   > reduced ECC strength. Currently only the read page functions
>   > have this condition check added.
>   >
>   > Fix by adding the same condition to all read and write page
>   > functions by dropping the existing 'selected_bank =3D=3D 0' check
>   > and use the NAND_IS_BOOT_MEDIUM option that was introduced to
>   > U-Boot more recently than this driver to behave
>   > identically to the Linux driver.
>   >
>   > It is now the users responsibility to apply the device tree
>   > property "nand-is-boot-medium" to only NAND chip 0.
>   >
>   > Fixes: b12dc5d6fa76 ("mtd: nand: NFC drivers for RK3308, RK2928 and
> others")
>   > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>   > Tested-by: H=C3=BCseyin BIYIK <boogiepop@gmx.com>
>   > Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> You don't explain how the bug can be triggered. It'd be nice to provide
> the usecase when this is an issue so that other people looking on the
> Internet for bug reports could somehow stumble upon this patch.
>=20
> I'm thinking the issue is that we currently verify all NAND chips use
> the boot_blks and boot_ecc from the boot medium whereas they might not
> be used as a boot medium (they are missing the nand-is-boot-medium
> property) so we cannot actually make use of them. Is that correct?
>=20
> Considering boot_blks is 0 if rockchip,boot-blks property isn't set,
> we'll never be able to meet the page < pages_per_blk * 0) condition
> anyway so we would never enter the if block... or can page actually be
> negative????
>=20
> To be clear, I don't disagree with the fix, I just am missing a lot of
> information that should be in the commit log.
>=20
> Cheers,
> Quentin

