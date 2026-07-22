Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92710C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 11:50:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C24C480C3F;
	Wed, 22 Jul 2026 11:50:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Za1O2TRnXu_9; Wed, 22 Jul 2026 11:50:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8A7480C45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784721001;
	bh=YrZJEPFFueSu4kifYaOI+3zENCm1QybQkX0dg33HHrs=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=fZOOCRUuFbl7wj2peiX7PB7I6lOQmYs5rOnJlzg6ovJPQQWFD5GwmRFnLvPoGutGw
	 5Pa4SuYVXJyS+5wDenaGnsM2V8uplwLQ3r1CihNoEiEDQPqBOvodnRAGPGgldhdQDx
	 BeiuiV7Sj32Kw0yZ7WaAfjZZxxNlpke2dsLgPxjfe3HFM4+CbYpbtyLZTTjDn4BuTU
	 SAMFDnCasA1xMczd624j46YTRaSgecHxGM6i/DDy/8iROArWnNI1gzESaLYUh9torr
	 xrqlO2DybQsrCCHf/P6rQIhJC7jrMJ9TUNNJC6OEzLWd+MQ12QnDwMXKAmjDg0U/Z3
	 Jq0XUmJpa7yTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8A7480C45;
	Wed, 22 Jul 2026 11:50:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5145C224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42E9B6063F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:50:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id drEJkQKZwHX9 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 11:50:00 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=boogiepop@gmx.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C95C5605F4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C95C5605F4
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C95C5605F4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:49:57 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC01848BA; Wed, 22 Jul 2026 13:49:56 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2017E803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 13:49:54 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO6C-1xJLF60p3o-00lVBc; Wed, 22
 Jul 2026 13:49:32 +0200
Message-ID: <4ca92082-7d8a-48bd-8f23-e448d4b59210@gmx.com>
Date: Wed, 22 Jul 2026 13:49:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: Johan Jonker <jbx6244@gmail.com>, u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.denx.de, quentin.schulz@cherry.de,
 Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at
References: <de3c0d84-8490-4bc9-8702-12c060eeb329@gmail.com>
 <fdb929d4-19f9-4aad-ae2d-9d15e2552242@gmail.com>
Content-Language: en-US
In-Reply-To: <fdb929d4-19f9-4aad-ae2d-9d15e2552242@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/wDXO0w3NZ9JmQaGLJkv0GLw/cL5POGuqfAOOhdI3hsF+lFKhgq
 HE0nI0NJfLgmxUe4V1FR2YCFioZOnx6t1DPe4oQ29FWHOa+icDTIrNMARqnxjhb/MS3i0XA
 rg4dAjv4rMD3Y91g3Tvk0u6LLAHw9VxGpHUwbsR6MxERcBvWo2FvftJwpqvSYynTr9PXlq2
 gCI3BrbnQlaNFdiaum9XA==
UI-OutboundReport: notjunk:1;M01:P0:R9cc152Op6w=;nuMI+XV7Yp8qN+/sRgv4/mRFfNu
 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
 =
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.com; 
 s=s31663417; t=1784720972; x=1785325772; i=boogiepop@gmx.com;
 bh=YrZJEPFFueSu4kifYaOI+3zENCm1QybQkX0dg33HHrs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=N6CfUvScu9oLeJbmrXfTPaqiggZF39Taqjc0jxiJenVwQrEIGWKKLaeNnmEaYd0S
 hgFxXLPDC/rjGV/tKnuPajqSqRbpYCKBifePDppm6DYWgX15B6GjaD4OAxNx9Fu4w
 66K7gTdeZH7Y/tzagCxNSiy46yuPQ3boWzwgb5aNjCfB0MvLeHW1JcaA0OqQfvuk6
 NRX0R60odxpx0WyQ8e8qtRX6H+lu7nrkv5628l6E3g7Ca6o6lytT2PmFt55lmVnWP
 aIpsmc/aLC1gUDr/JSbgFhQUa0fJhGwIvZ4g0wG8J16CFA5r/c+n51GIhO1El+kic
 buQW4ibAOmZvrqxP0A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmx.com header.i=boogiepop@gmx.com header.a=rsa-sha256
 header.s=s31663417 header.b=N6CfUvSc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=boogiepop@gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.com header.i=boogiepop@gmx.com header.b="N6CfUvSc"; 
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

Hi Johan

On 7/22/26 11:16, Johan Jonker wrote:
> Changed References:
> Added Linux MTD maintainers. Question below.
>=20
> Hi,
>=20
> On 7/22/26 00:56, Boogie wrote:
>> Hello Quentin
>>
>> I had reported this bug to Johan so i can give detailed explanation.
>>
>> The bug was really the lock of "&& nfc->selected_bank =3D=3D 0" not exi=
sting for write_page_* variants.
>>
>> When rockchip nfc was reading, it required bootblks to be a part of the=
 first nand chip only with the condition "nfc->selected_bank =3D=3D 0". Bu=
t when writing it interpreted 'all' nand chips first boot_blks as boot blo=
cks.
>>
>> The practical problem. I had mentioned this in V1 and give more explici=
t details here.
>>
>> I have 2 nand chips, and a partition (linux below) starts in nand chip =
1 (CS=3D0 in below) and ends in chip2 (CS=3D2 below). And i am using UBI o=
n top of that mtd.
>>
>> nand@0 {
>>  =C2=A0=C2=A0=C2=A0 reg =3D <0>, <2>;
>>  =C2=A0=C2=A0=C2=A0 label =3D "rk-nand-0";
>>  =C2=A0=C2=A0=C2=A0 nand-bus-width =3D <8>;
>>  =C2=A0=C2=A0=C2=A0 nand-ecc-mode =3D "hw";
>>  =C2=A0=C2=A0=C2=A0 nand-ecc-step-size =3D <1024>;
>>  =C2=A0=C2=A0=C2=A0 nand-ecc-strength =3D <40>;
>=20
>>  =C2=A0=C2=A0=C2=A0 nand-is-boot-medium;
>=20
> This property was introduced during review, but can't find the reason.
> https://lore.kernel.org/linux-rockchip/20200426100250.14678-1-yifeng.zha=
o@rock-chips.com/
>=20
>>  =C2=A0=C2=A0=C2=A0 rockchip,boot-blks =3D <8>;
>>  =C2=A0=C2=A0=C2=A0 rockchip,boot-ecc-strength =3D <24>;
>=20
> Describing 2 nands with 1 node also exposes properties to a second nand =
that result in reduced ecc strength in both.
>=20
>>
>=20
>>  =C2=A0=C2=A0=C2=A0 // block 14 - end
>>  =C2=A0=C2=A0=C2=A0 linux@1C00000 {
>=20
> The binding puts the partitions under 1 nand node, but says nothing abou=
t a partition across 2 or more nands.
> Could the MTD maintainers inform us the support status of this 'feature'=
 in Linux and U-Boot.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree=
/Documentation/devicetree/bindings/mtd/mtd.yaml#n39
>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 label =3D "linux";
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x0 0x1C00000 0x3 =
0xFE400000>;
>>  =C2=A0=C2=A0=C2=A0 };
>> };
>=20
> I would like to produce a patch with "&& nfc->selected_bank =3D=3D 0" fo=
r Linux.
> Not sure if they are willing to merge.
>=20
> Depending on the output/feedback put this patch on hold till I know more=
.

This current version in mainline linux (and your patch) also works, may=20
be it is better to leave it so (at least for me), because adding "&&=20
nfc->selected_bank =3D=3D 0" will break existing devices, which is not=20
always worth it specially for legacy devices like ones using this driver.

>=20
> Johan
>=20
>>
>> When i create the UBI volume the middle of this partition where the blo=
cks are at 2nd chip block0-7, will be written in boot block strength [ECC:=
1024/24] but will be read with normal strength [ECC:1024/40].
>>
>> This causes first UBI creation to be successful, and next scan to fail =
due to written strength is different that read.
>>
>> You dont actually need to use UBI at all, any time you write those sect=
ors, you wont be able to read them. A workaround it to mark them bad, but =
this is not nice, since the blocks are completely fine.
>>
>> Rockchip NFC technically as minimum needs to know rockchip,boot-blks, &=
 rockchip,boot-ecc-strength props only. Currently the checking condition i=
s rockchip,boot-blks & applied affect is rockchip,boot-ecc-strength.
>>
>> The bug is this is only applicable to first chip not all chips.
>>
>> NAND_IS_BOOT_MEDIUM is actually coming from mainline linux. Similar boo=
trom tricks are also available in other socs. And detection of boot rom bl=
ocks is not always straight forward as rockchip's rockchip,boot-blks, they=
 have to do some "if" case acrobatics to detect those. For simplicity reas=
ons mainline linux introduced a global flag NAND_IS_BOOT_MEDIUM and it is =
applied to other socs as well.
>>
>> Since this "&& nfc->selected_bank =3D=3D 0" fix is exactly at the same =
line with mainline changes of NAND_IS_BOOT_MEDIUM check, i think Johan als=
o integrated both at the same line.
>>
>> In u-boot only mk808 is using nfc with boot blocks and it is already ma=
rking the nand device as boot medium, so the code change should not break =
existing devices.
>>
>> Additional note: Linux mainline also is lacking the "nfc->selected_bank=
 =3D=3D 0" check, so i think similar patch should got to linux as well.
>>
>> @johan if anything i am missing feel free to correct me.
>>
>> h=C3=BCseyin
>>
>> On 7/20/26 20:25, Quentin Schulz via U-Boot wrote:
>>> Hi Johan,
>>>
>>> Resending because the ML rejected my mail sent from my other address..=
.
>>> I have to figure out what I set up wrong to trigger the spam filter :)
>>>
>>> On 7/14/26 8:39 AM, Johan Jonker wrote:
>>>  =C2=A0 > The Rockchip boot ROM only checks for NAND chip 0 and with
>>>  =C2=A0 > reduced ECC strength. Currently only the read page functions
>>>  =C2=A0 > have this condition check added.
>>>  =C2=A0 >
>>>  =C2=A0 > Fix by adding the same condition to all read and write page
>>>  =C2=A0 > functions by dropping the existing 'selected_bank =3D=3D 0' =
check
>>>  =C2=A0 > and use the NAND_IS_BOOT_MEDIUM option that was introduced t=
o
>>>  =C2=A0 > U-Boot more recently than this driver to behave
>>>  =C2=A0 > identically to the Linux driver.
>>>  =C2=A0 >
>>>  =C2=A0 > It is now the users responsibility to apply the device tree
>>>  =C2=A0 > property "nand-is-boot-medium" to only NAND chip 0.
>>>  =C2=A0 >
>>>  =C2=A0 > Fixes: b12dc5d6fa76 ("mtd: nand: NFC drivers for RK3308, RK2=
928 and
>>> others")
>>>  =C2=A0 > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>>  =C2=A0 > Tested-by: H=C3=BCseyin BIYIK <boogiepop@gmx.com>
>>>  =C2=A0 > Reviewed-by: Simon Glass <sjg@chromium.org>
>>>
>>> You don't explain how the bug can be triggered. It'd be nice to provid=
e
>>> the usecase when this is an issue so that other people looking on the
>>> Internet for bug reports could somehow stumble upon this patch.
>>>
>>> I'm thinking the issue is that we currently verify all NAND chips use
>>> the boot_blks and boot_ecc from the boot medium whereas they might not
>>> be used as a boot medium (they are missing the nand-is-boot-medium
>>> property) so we cannot actually make use of them. Is that correct?
>>>
>>> Considering boot_blks is 0 if rockchip,boot-blks property isn't set,
>>> we'll never be able to meet the page < pages_per_blk * 0) condition
>>> anyway so we would never enter the if block... or can page actually be
>>> negative????
>>>
>>> To be clear, I don't disagree with the fix, I just am missing a lot of
>>> information that should be in the commit log.
>>>
>>> Cheers,
>>> Quentin
>>
>=20

