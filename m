Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08789F5A8C9
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916F5842B7;
	Tue, 21 Apr 2026 00:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="E1Z1BzsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D50842E7; Tue, 21 Apr 2026 00:47:04 +0200 (CEST)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2DFA8425F
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=ltl4tnn2fjhpbpfypo4sa3be4q.protonmail; t=1776725216; x=1776984416;
 bh=EpoImTI8KWlLelNZ9rbDeaMwEaPoboODjWbEG4D8pZ8=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=E1Z1BzsGxzChar7qSrRfYsxEpEccIf3FT9n26njQYxBmsxloEcGNZb2h8YzRMZkYy
 sCOoEToti571P5rWVOkjLxnXEwBJt1sZeWjF5Z3iUDCAxZge/ywQXp9ODpQhuzAML4
 4O9ErB/9vDZSJpcE9TNf3DS+BR7pvzFuf9ob6Cnix/zQ5E6T3p8jzA8TUMZU1DaTgZ
 dP25U3ejUBy8nuYGE6Xh9smc1jdU/w3ufwmcitCS9EHpei/iYYOPbiKDr+S/+MB3uL
 w0mbkNjkl7fbReRKJ2GVXStOR0klJRAupKpdMZyHjE/VR2lrLOFhkEt4w4114/7cxm
 57QPPv+emB9+g==
Date: Mon, 20 Apr 2026 22:46:50 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <krotti83@proton.me>
Subject: Re: cmd: fatload: command doesn't update $filesize after next calls
Message-ID: <8a095db9-46a3-4d66-bec4-5901a1990a85@proton.me>
In-Reply-To: <7ef8cbf4-9b58-42b3-b8dd-0dd337529ebb@proton.me>
References: <904e82be-40df-45d1-afc9-bb658ac9be8c@proton.me>
 <7ef8cbf4-9b58-42b3-b8dd-0dd337529ebb@proton.me>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: bac6505cce748774e80147ce5a7eb9a07dc56739
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hello,

This thread can be discarded. Have misunderstood the command
'fatload' fatally.

'fatload' works as accepted. Have used a non-official U-Boot
description from the command...

Sorry, for wasting your time.

On 4/20/26 3:20 PM, Johannes Krottmayer wrote:
> I have forgotten:
>=20
> Also the content of the loaded file seems to be the
> same data from the previous call.
>=20
> On 4/20/26 3:15 PM, Johannes Krottmayer wrote:
>> Hello,
>>
>> I'm figured out an issue with the command 'fatload':
>>
>> Here the file list with the command 'fatls':
>>
>> ---
>> StarFive # fatls mmc 1:3
>>   3048997   firmware.itb
>>    149225   u-boot-spl.bin.normal.out
>>      3184   depp.efi
>>     12318   hello.efi
>>     44122   jh7110-starfive-visionfive-2-v1.3b-8G.dtb
>>
>> 5 file(s), 0 dir(s)
>> ---
>>
>> As you can see the files have different sizes.
>>
>> First invoke of the command 'fatload' saves the correct size in
>> the variable $filesize:
>>
>> ---
>> StarFive # fatload mmc 1:3 $loadaddr u-boot-spl.bin.normal.out $filesize
>> 149225 bytes read in 9 ms (15.8 MiB/s)
>> StarFive # echo $filesize
>> 246e9
>> ---
>>
>> When trying to load a new file with 'fatload', the variable $filesize
>> still contains the old size from the previous call:
>>
>> ---
>> StarFive # fatload mmc 1:3 $loadaddr firmware.itb $filesize
>> 149225 bytes read in 9 ms (15.8 MiB/s)
>> StarFive # echo $filesize
>> 246e9
>> StarFive #
>> ---
>>
>> Has somebody noticed the same issue? Noticed in U-Boot version at least
>>
>> v2025.10 and v2026.05.
>>
>> Kind regards,
>>
>> Johannes K.
>=20


