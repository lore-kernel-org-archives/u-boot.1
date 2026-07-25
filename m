Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E81C531D0
	for <u-boot@archiver.kernel.org>; Sat, 25 Jul 2026 15:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED2FB60671;
	Sat, 25 Jul 2026 15:58:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klDKvL6M9TCZ; Sat, 25 Jul 2026 15:58:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3533960658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784995103;
	bh=uY2khNQmHl2j8FoPz8tORA3SQgjlLAMetLpKclCeyhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LgKLFXmV7rwp82aqtUnZv74bq+ZHe8ahn6UuDKOaN/+5CXGUxuHwC+akyC9FEHkAt
	 xST4TRdSCyBf7n6HN0ykKk34vPaCa98OEMETET3cRHsajy3pSOH91QDMTz+SaWThCH
	 oTo7RsO+vIVDgIvgYmPfWlAo99Y2c6eE0E7MMxxS7q++SOkbAMpBJVBdcMmIHDK8CZ
	 /OHM3cWTCnPBvpLqTlRccuftBskkPbECpaQ5yFIoHKh2uARzEd055ipw2d9xylks/q
	 PuhfzRdHEUS8siQbaw1U/xZT5s8YOQ/mshbtMaEAt9dnUxccruPb2uBb1ytLxGP41G
	 Sqvr/7EsMi/9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3533960658;
	Sat, 25 Jul 2026 15:58:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BCCFA490
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 15:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE99E80F27
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 15:58:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xtvwEuKqj1tA for <u-boot@lists.u-boot-project.org>;
 Sat, 25 Jul 2026 15:58:20 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=boogiepop@gmx.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1E0F980F26
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E0F980F26
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E0F980F26
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 15:58:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB55800AE; Sat, 25 Jul 2026 17:58:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5520F8005D
 for <u-boot@lists.denx.de>; Sat, 25 Jul 2026 17:58:10 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlf0K-1xEVKk1EMU-00fhm0; Sat, 25
 Jul 2026 17:57:52 +0200
Message-ID: <54236315-5694-4dd9-b1b1-389c794558f9@gmx.com>
Date: Sat, 25 Jul 2026 17:57:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.denx.de, quentin.schulz@cherry.de,
 richard@nod.at, Johan Jonker <jbx6244@gmail.com>
References: <de3c0d84-8490-4bc9-8702-12c060eeb329@gmail.com>
 <fdb929d4-19f9-4aad-ae2d-9d15e2552242@gmail.com> <87fr18sppr.fsf@bootlin.com>
Content-Language: en-US
From: Boogie <boogiepop@gmx.com>
In-Reply-To: <87fr18sppr.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E5BZ4y9FRpnPYxlTDh9lg3wj3rxk6v7YiR32jNueNudCJ6/rU0W
 jEOSdbl+yurz1oaHEdh2VDLCSjsF87Dhw7Aul+oLdbnAgExgIaXwfQcD4efMzETZwvfZU0C
 4NbbT6a3KTSeGUZprXRWvz69hpfNT+PGCQLq+LRvVbJmyIYoSjlB1V+bNneoXrvEmFvu60K
 pNavZhJ0qj+K++yIt11rQ==
UI-OutboundReport: notjunk:1;M01:P0:Veu3Zl94Fl4=;ozuvIGN5VdjyToz8JDe3NA5mGYf
 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
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.com; 
 s=s31663417; t=1784995072; x=1785599872; i=boogiepop@gmx.com;
 bh=uY2khNQmHl2j8FoPz8tORA3SQgjlLAMetLpKclCeyhU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Ub2jCoQVoOPZQXl/AG6HrV1fOZCCBcYsWHclrABBX49lLSjpLpX7Ir0f0MrvL3fB
 2mAx6cEvMZw9FO5+QHEtUi5w3HKZruHvlYSU8vaauinbxSHPbA8KVJHhVggSV06h9
 OY8a/D1DRqNcg9PhwXtMd53DsFLUlsNBtOmtBTS2DqU/I4xpgUJAcI4OuxE2qJhQp
 B5UUoZbpWNfirQRXJlqEZku7pp+ounXNmYbokxQ5uPbEe61NZKSw3dwoiEaM31hAo
 UmlEtIMJDzXvGrxX9yEoMiKJsAmn5ZppEnlqfZDduNp55aQJKtA/c+U9qC7DeujlO
 owagdQVbokCPlh6/aA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmx.com header.i=boogiepop@gmx.com header.a=rsa-sha256
 header.s=s31663417 header.b=Ub2jCoQV
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=boogiepop@gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.com header.i=boogiepop@gmx.com header.b="Ub2jCoQV"; 
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hello Miquel

On 7/24/26 11:26, Miquel Raynal wrote:
> On 22/07/2026 at 11:16:20 +02, Johan Jonker <jbx6244@gmail.com> wrote:
>=20
>> Changed References:
>> Added Linux MTD maintainers. Question below.
>>
>> Hi,
>>
>> On 7/22/26 00:56, Boogie wrote:
>>> Hello Quentin
>>>
>>> I had reported this bug to Johan so i can give detailed explanation.
>>>
>>> The bug was really the lock of "&& nfc->selected_bank =3D=3D 0" not ex=
isting for write_page_* variants.
>>>
>>> When rockchip nfc was reading, it required bootblks to be a part of
>>> the first nand chip only with the condition "nfc->selected_bank =3D=3D
>>> 0". But when writing it interpreted 'all' nand chips first boot_blks
>>> as boot blocks.
>>>
>>> The practical problem. I had mentioned this in V1 and give more explic=
it details here.
>>>
>>> I have 2 nand chips, and a partition (linux below) starts in nand
>>> chip 1 (CS=3D0 in below) and ends in chip2 (CS=3D2 below). And i am us=
ing
>>> UBI on top of that mtd.
>>> nand@0 {
>>>  =C2=A0=C2=A0=C2=A0 reg =3D <0>, <2>;
>>>  =C2=A0=C2=A0=C2=A0 label =3D "rk-nand-0";
>>>  =C2=A0=C2=A0=C2=A0 nand-bus-width =3D <8>;
>>>  =C2=A0=C2=A0=C2=A0 nand-ecc-mode =3D "hw";
>>>  =C2=A0=C2=A0=C2=A0 nand-ecc-step-size =3D <1024>;
>>>  =C2=A0=C2=A0=C2=A0 nand-ecc-strength =3D <40>;
>>
>>>  =C2=A0=C2=A0=C2=A0 nand-is-boot-medium;
>=20
> What you may want is to declare the NAND using two different nodes, then
> use mtd-virt-concat to generate one bigger MTD device spanning across
> the two devices.

Thats also an option but i prefer this way to be more straight forward=20
since entire partition layout can be kept in dts.

>=20
> The driver should not blindly check the 'cs =3D=3D0' condition but inste=
ad

I think my statement was also not accurate, i think the brom at least=20
for 3066 should check only the first chip which has the least cs so=20
nfc->selected_bank =3D=3D 0. This could have been validated easily by=20
erasing boot blocks in both chips and writing an idb to 2nd chip=20
deliberately and check if the 3066 would boot or not. But i think i=20
burned gpios in my board while messing with the shorting nand chips, 2nd=
=20
chip is RIP. so i cant test this anymore unfortunately. In any case=20
current working way of rockchip_nfc in mainline linux is also fine. If=20
somehow those low eccs create problem, they can be marked as bad anyways.

But thanks for your input.

> also take nand-is-boot-medium into account (which would then only be
> required in the NAND chip with the said boot partition) to make sure the
> special handling is only applied on the boot partition.
>=20
> Hope that helps.
>=20
> Thanks,
> Miqu=C3=A8l

