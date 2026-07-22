Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E83C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 11:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2D0880D7C;
	Wed, 22 Jul 2026 11:39:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6sDC_IresdfX; Wed, 22 Jul 2026 11:39:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBDFD80D92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784720391;
	bh=6tkWS27aQv5uZNJQwhKbz+7xsl6uV19noeZ4l1IGwwc=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=VXTZNObisJzMt+ikjrlA8LswHKFF1nUAVsJyXlxUr3UIyF2VxkAhQkvVHdJGY9MZo
	 RyEKH4n9HYsVE6NbNP2A7dgXXjU9yGvAUNM4ptbKF41l4OUsiMlXh99stBCeKtnVQp
	 8qnlee8a/UIilQxg+8y1fg/y7TJUF+6I3yE1GESN3Qcu32T5dovSFEhpkog7pBcEJr
	 LEG+ieh7bzdBY4CsNQW2AQwF+MzqDhD7745Vyb6m1FMq/lSwJCY0Aste3QxqF9EUdD
	 /Ju534xP3Ly5Uhleq6nYsHlnJR5WwQhFHlNt2/HDEayfIRZxeulN93r8/Gg7Kf/zQf
	 Jq0jVpFcaAJFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBDFD80D92;
	Wed, 22 Jul 2026 11:39:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DC8B224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4324180D92
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:39:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vd84ZPgyc73g for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 11:39:48 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=boogiepop@gmx.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 86F7B80D21
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86F7B80D21
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86F7B80D21
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:39:46 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46C5848BA; Wed, 22 Jul 2026 13:39:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D78F803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 13:39:41 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VD8-1x2M4n0QZO-015s2A; Wed, 22
 Jul 2026 13:39:39 +0200
Message-ID: <48672330-0a41-46a9-83f3-031d5eea8e06@gmx.com>
Date: Wed, 22 Jul 2026 13:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Johan Jonker <jbx6244@gmail.com>
References: <e108fe69-533a-4734-8728-b17b172c4be9 () cherry ! de>
 <68f9f2bc-485e-4cbe-9ed7-8f34efdd8440@gmx.com>
 <e9100f97-91a0-4166-b62e-d639d41f6ac2@cherry.de>
Content-Language: en-US
In-Reply-To: <e9100f97-91a0-4166-b62e-d639d41f6ac2@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W0cxXUFAMS6zsfSVW1c/CmlPG2YaI7BqeWH2RI0krysbRuuR391
 3tFyTLBEgolAYk+UBfMR4q1298JXvZ3MSCEXH4VMjRnLaztmVvkWfdFBVAXlTkqv+3BLpc5
 eGZp0Xq03RCoG0AWJxrTrT7l3gCIoLMUij+vVUSNYgBWztmqyjoplgVA9hr6uZS8Ewb0XKa
 4GdgqwES/4BViQ/TZsoaA==
UI-OutboundReport: notjunk:1;M01:P0:DRdUeETyYZY=;AJG7g8utoWcmGRizLBKj7Khv3l3
 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
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.com; 
 s=s31663417; t=1784720379; x=1785325179; i=boogiepop@gmx.com;
 bh=6tkWS27aQv5uZNJQwhKbz+7xsl6uV19noeZ4l1IGwwc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WGTlwvR6wZ63Px7GSKOhrGNBGY/jFkE7fOnoFEaq5zDOQMknKJmYEjWMJKbF6hL9
 ivNWa/5Nqm+UqRRYpA8Kh/Xcessd7tFcWGtIP2p9+tmHTxI458j/C59G26NOglg5e
 zIENj4CVCx1cvzniEwwAxKk5ccAWccfK1gmNyzy1hnvmUGI1juXlQ4FBodRTcRHgu
 +ZTUAgkVTc+3kdvmOxcZJlFQJFsliab5AlKPAQVlP0kXMO0CML3VXATzEbsiURIC5
 rGsbF93JSE8WsD3ZigRQYNl2UPtYlE/XSXAiC5MOzR9ckErymR7UU5v5MqyaphLxj
 m0lDjA2mIp8ZUL4yMg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.com header.i=boogiepop@gmx.com
 header.a=rsa-sha256 header.s=s31663417 header.b=WGTlwvR6
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=boogiepop@gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.com header.i=boogiepop@gmx.com header.b="WGTlwvR6"; 
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

Hi Quentin

On 7/22/26 11:28, Quentin Schulz wrote:
> Hi H=C3=BCseyin, Johan,
>=20
> On 7/22/26 12:56 AM, Boogie wrote:
>> [You don't often get email from boogiepop@gmx.com. Learn why this is=20
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hello Quentin
>>
>> I had reported this bug to Johan so i can give detailed explanation.
>>
>> The bug was really the lock of "&& nfc->selected_bank =3D=3D 0" not exi=
sting
>> for write_page_* variants.
>>
>> When rockchip nfc was reading, it required bootblks to be a part of the
>> first nand chip only with the condition "nfc->selected_bank =3D=3D 0". =
But
>> when writing it interpreted 'all' nand chips first boot_blks as boot=20
>> blocks.
>>
>=20
> OK ECC strength mismatch between what's written and read.
>=20
>> The practical problem. I had mentioned this in V1 and give more explici=
t
>> details here.
>>
>> I have 2 nand chips, and a partition (linux below) starts in nand chip =
1
>> (CS=3D0 in below) and ends in chip2 (CS=3D2 below). And i am using UBI =
on
>> top of that mtd.
>>
>> nand@0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0>, <2>;
>> =C2=A0=C2=A0=C2=A0=C2=A0 label =3D "rk-nand-0";
>> =C2=A0=C2=A0=C2=A0=C2=A0 nand-bus-width =3D <8>;
>> =C2=A0=C2=A0=C2=A0=C2=A0 nand-ecc-mode =3D "hw";
>> =C2=A0=C2=A0=C2=A0=C2=A0 nand-ecc-step-size =3D <1024>;
>> =C2=A0=C2=A0=C2=A0=C2=A0 nand-ecc-strength =3D <40>;
>> =C2=A0=C2=A0=C2=A0=C2=A0 nand-is-boot-medium;
>> =C2=A0=C2=A0=C2=A0=C2=A0 rockchip,boot-blks =3D <8>;
>> =C2=A0=C2=A0=C2=A0=C2=A0 rockchip,boot-ecc-strength =3D <24>;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 // block 14 - end
>> =C2=A0=C2=A0=C2=A0=C2=A0 linux@1C00000 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 label =3D "linux";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x0 0x1C00000=
 0x3 0xFE400000>;
>> =C2=A0=C2=A0=C2=A0=C2=A0 };
>> };
>>
>> When i create the UBI volume the middle of this partition where the
>> blocks are at 2nd chip block0-7, will be written in boot block strength
>> [ECC:1024/24] but will be read with normal strength [ECC:1024/40].
>>
>> This causes first UBI creation to be successful, and next scan to fail
>> due to written strength is different that read.
>>
>> You dont actually need to use UBI at all, any time you write those
>> sectors, you wont be able to read them. A workaround it to mark them
>> bad, but this is not nice, since the blocks are completely fine.
>>
>> Rockchip NFC technically as minimum needs to know rockchip,boot-blks, &
>> rockchip,boot-ecc-strength props only. Currently the checking condition
>> is rockchip,boot-blks & applied affect is rockchip,boot-ecc-strength.
>>
>> The bug is this is only applicable to first chip not all chips.
>>
>=20
> "is only applied" I think you meant here instead? Or are you implying=20
> that you want chip 0 to have rockchip,boot-blks and rockchip,boot-ecc-=
=20
> strength applied to it, but NOT chip 2 even though they are listed in=20
> the same node?
>=20

Yes boot-blks and rockchip,boot-ecc-strength must be applied to only to=20
the chip CS=3D0. This is how the bootrom works, bootrom does not look for=
=20
an idb image [tpl/spl] in a chip which is not CS =3D=3D 0.

>> NAND_IS_BOOT_MEDIUM is actually coming from mainline linux. Similar
>> bootrom tricks are also available in other socs. And detection of boot
>> rom blocks is not always straight forward as rockchip's
>> rockchip,boot-blks, they have to do some "if" case acrobatics to detect
>> those. For simplicity reasons mainline linux introduced a global flag
>> NAND_IS_BOOT_MEDIUM and it is applied to other socs as well.
>>
>=20
> rockchip,boot-blks and rockchip,boot-ecc-strength properties explicitly=
=20
> require nand-is-boot-medium property to be set in order to be used=20
> (though they don't enforce it via YAML/JSON schema; although it is=20
> enforced by the kernel driver). So a device tree that doesn't follow=20
> those restrictions is deemed invalid and we are not aiming at supporting=
=20
> them. This means that the last sentence in Johan's commit log:
>=20
> It is now the users responsibility to apply the device tree
> property "nand-is-boot-medium" to only NAND chip 0.
>=20
> is redundant, as we already expect the users to set it for the=20
> appropriate NAND chip(s). (just adding this piece of information here,=
=20
> not disputing anything either of you said)
>=20
>> Since this "&& nfc->selected_bank =3D=3D 0" fix is exactly at the same =
line
>> with mainline changes of NAND_IS_BOOT_MEDIUM check, i think Johan also
>> integrated both at the same line.
>>
>=20
> @Johan, can you please reorder the condition in rk_nfc_write_page_hwecc=
=20
> and rk_nfc_read_page_hwecc to match the order in the Linux kernel=20
> driver? (the NAND_IS_BOOT_MEDIUM is last).
>=20
>> In u-boot only mk808 is using nfc with boot blocks and it is already
>> marking the nand device as boot medium, so the code change should not
>> break existing devices.
>>
>=20
> Correct.
>=20
>> Additional note: Linux mainline also is lacking the "nfc->selected_bank
>> =3D=3D 0" check, so i think similar patch should got to linux as well.
>>
>=20
> Not sure what you mean here as Johan removed both checks in the patch.

You are right, sorry for misleading, we had discussed to put a lock to=20
with "&& nfc->selected_bank =3D=3D 0" for both read and write to uniform.=
=20
But now i noticed that this patch only syncs with mainline and=20
downgrades the ECC to bootrom strength for all chips first boot blocks.=20
This also works, but of course the side affect is reduced ecc strength=20
(if your current one is higher, and most likely is).

>=20
> [...]
>=20
> As far as I could tell, Johan's patch makes U-Boot behave the same as=20
> the Linux kernel for a multi-chip node, so with the reorder I asked=20
> above and a much more precise commit log providing the usecase and=20
> misbehavior, and also pointing at the Linux kernel doing the exact same=
=20
> thing as this patch, I think we're going in the right direction.
>=20
> Cheers,
> Quentin

