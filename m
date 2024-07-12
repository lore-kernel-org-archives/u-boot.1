Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F743C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 17:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B8388667;
	Fri, 12 Jul 2024 19:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="Tfi7XhB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC15B887C0; Fri, 12 Jul 2024 19:07:30 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF8FD88176
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 19:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1720804047; x=1721408847; i=frank-w@public-files.de;
 bh=vN87iGsFVd/uATPbD5D8CJYOBfP1x3jQRm8e+WUnV1Q=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Tfi7XhB2MqAvOwUP7Jc07D8DQlewJOtUBFUZ0TAWpuf9LPH/1tLjdeWKv4SMXMCH
 SIN+23fBUAonreM15w/z/o6V4ketLT9U2WBowF1UWx1KWoVa59awV5+oHxDhWF4sK
 Df2ThBhyW0HnSnFCxEsGHhyNB0ZiyvlgFl+KNBpZbwYUmro5g3D2f2q+OPM4eKwn1
 6vTNT7IUpjRT2rxHfCXTXDl/fFqyC6gWFJ+ER4maKZXBhxS/+lII4Nm9+Yu3Us6qO
 n47vqoYe0++U2xHWfdpU83rUxtZ4QjimNuBzpDYvKtZ29h228LuPNfHm+FGZEgaO+
 o16lOx8dbNC/6vYE9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.158.209]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9Mta-1sGH0t22vk-012nBC; Fri, 12
 Jul 2024 19:07:27 +0200
Date: Fri, 12 Jul 2024 19:07:25 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de
Subject: Re: adding fdt-overlay function - help needed
User-Agent: K-9 Mail for Android
In-Reply-To: <20240712164902.GW38804@bill-the-cat>
References: <trinity-a8e5b1d7-ca6f-4148-a618-95cfb529d919-1720625726767@3c-app-gmx-bs04>
 <trinity-43100c7e-7010-40e5-998f-5fcfe548d29f-1720697012080@3c-app-gmx-bap43>
 <20240712164902.GW38804@bill-the-cat>
Message-ID: <5514F1B6-7F5F-4013-8576-F9BA526091BC@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wSegdEQeQHDaE/f9om9zi4Dd3nMA/nrAiiXLZX/MHhOU62M30et
 M5dciZW8KOkLMFE3Kieum3hjfs9oXgocXEnrcEDOFdW/BpxcyhpL+BYIwFVkgJkC50jLRIz
 dR7yYTfw3cpS3mulKcAGlbKDyu5lasQIPxIHdow41XeUeMghiC6n85Gr63TsE8rrG67oLbJ
 bRPgyLuu6Ts+oyB6cJxig==
UI-OutboundReport: notjunk:1;M01:P0:Cvgu3lr6hxQ=;Cj07Fo8UkWhOlbf8tJLi15kLQbq
 HBDuRiHiNPNaQKw3IY1mElU170JGZ8cwuN/JRULp8oQ85wDwysDIV/FVzY5+q5Kmy8U3LWTYK
 Bkw/x5AvOp76Ng5Oc9OeR1zbVwWjKmBN7CoAQMzjUmdutb9jw89h+OHvJQ4pkpkSHbGO3SXXm
 w1U+2IO2F9sLWBP9rlh/Sonv3WmmxQDfOihbcfCJN2z2fuBxIVZbqRf7O7jbA2v/zHj+dk2Np
 77UCqnBsuW6VuoKTuWwP5sJgcP6PA90+40PQfcHqkv+txe7GIwchBIoEDDBNx6zcH3pgKOR0k
 rXi3PS1HUu1U1ewKIHkzeallE+UZ8Jtq753CZwckC0xL+HsPA8ZgOLM/fY7/r29r8RndLa2cg
 T8wxj67xr/R1x2MEWsf9aXcMvix57Jl4ExvOGhYttNK5C9n3M2GzZ5CjZSIbMKVlZruvwBvvE
 mQbDoFqq1gGL2hXaBuqHpQNDr8YpAX2lWZEToKJvOsCKeZqNZr9xsEwtxfjm6qvukwol7Hce0
 tgAVTo0RnrvZYZGdE4xlBv/mfSmUTOA1JkDP8Yw2Y4wjsmXa90iGrUcNaOcF8Vc8rr8mXuqL4
 XKcsV4rOvFD83Tms+3Vug84+2uiTkuArsftMj+TCOQM06xbkTqjUZurqIsN8MVSJTMGMbCGjI
 7a+EXuBUxFFNfWnOJp2s4FAm9rvEAcHzoqkOU2g+7pwZVtQn0T0GHucTlr7wCxLApOeF7AbX0
 GDtaIpRTIvQsf9k6WDbikthGZREnG1ZJUgeglCV8zRf/u/dW/58VZim4dsT1GBzsGQD7EwjeT
 HOSu83qZ0XTaUSOM1BZP7Hrw==
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 12=2E Juli 2024 18:49:02 MESZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>On Thu, Jul 11, 2024 at 01:23:32PM +0200, Frank Wunderlich wrote:
>
>> Hi,
>>=20
>> i got a bit further and noticed, that required command is not available=
 in uboot=2E=2E=2Ethis is normally part of the dtc package [1], so why is i=
t missing in u-boot?
>> I guess later added or dropped to reduce compile time/make porting easi=
er=2E=2E=2E
>>=20
>> regards Frank
>>=20
>> https://github=2Ecom/qemu/dtc/blob/master/fdtoverlay=2Ec
>
>We're behind on re-syncing with the kernel's version of dtc, yes=2E It
>might be easiest to just cherry-pick what you need for now?
>

I tried multiple things but the only thing worked so far was copying all c=
/h from linux and modifying makefile to build fdtoverlay binary

<https://github=2Ecom/frank-w/u-boot/commit/d01e15acecd4dcf1584e4601c54323=
1d5dbb6379>

But i have the buildchain not so far that the merging itself works (seems =
to need targets for dtbo we have not in linux),but fdtoverlay itself is bui=
lt without errors=2E

The repo i linked before seems to be completely incompatible with the dtc/=
fdtutils from uboot/linux (missing constants and some more)=2E

If i have it running completely i can replace my testcommit with the cherr=
y-pick from linux to preserve author-information,but first the merging need=
s to work=2E
regards Frank
