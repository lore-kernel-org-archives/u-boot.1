Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A20E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 15:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58E0280295;
	Fri,  3 Jan 2025 16:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="o1ekFh48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102B68035E; Fri,  3 Jan 2025 16:11:23 +0100 (CET)
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64686801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 16:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=waldoalvarez@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1735917078; x=1736176278;
 bh=KFD5TnFixrkOAdZZ0oZ0yB4eThgwnxIxAlLlDVweH4A=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=o1ekFh488yyvkJOs+vn8HIVCavmRD6jSORLypFulm2AjkaDRFJO7+E9w/HnLofS/n
 Rh4z6QkFTAKfXDwBAvqEwhNbW+abZmQ8U7Iznmc6tBaXedVgyZO2EN7VI888UcdOS7
 3Xy+5ijiBPNUknHbllAvbW2OtTRIk5iucIFNJFHVwBle7kJBc3fUARKNgXYCnb8mRZ
 oB1ZbT1RmHeTyADoLZH6SGaUHgyjMCYc7v30o6S3nOxZLMjTcaBd0ft+C8wEQ6uIqA
 KuN9Z9nwo3nDb0PTWOBurC7LIhaHJnat0nTrnlOT2BbEMWk4yzMZbo/M4prUX6szNo
 1NZNrNp+D/A6Q==
Date: Fri, 03 Jan 2025 15:11:12 +0000
To: Yixun Lan <dlan@gentoo.org>
From: Waldo Alvarez <waldoalvarez@protonmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Secure boot on Milk V duo 256
Message-ID: <EtgkzJ9LZ53ghiuWhgd0M120sfs9VP1anNhH8ejhiuD0qdu56ao8cDBwNYETH9_09IFDkDBWIKM12Cephb-ZAVTyVnjaP4ss2lX3cyV4AE4=@protonmail.com>
In-Reply-To: <20250103054049-GYA2264892@gentoo>
References: <9gGp0Bj5BodfZFh9cs_TfmuEpCjka0pg9zw_0jHrGSgVaMRQWbjoI7rDHQ4tYsa3IIzqC3gYozVRk5s_wdiCTp5IuAb7A1wccavJbQxuLAI=@protonmail.com>
 <20250103054049-GYA2264892@gentoo>
Feedback-ID: 1984973:user:proton
X-Pm-Message-ID: 06cb060ef8a123fcbf37a1b233a4822b0fdbf4f8
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

Hello Yixun Lan:

Thank you for your reply.

I was reviewing the source tree and came across some OTP/Efuse code for oth=
er boards located at:

/drivers/misc

For example, I found files like rockchip-efuse.c and sifive-otp.c. I=
=E2=80=99m still working on understanding how this integrates with the rest=
 of the codebase. Some of these implementations set the device serial numbe=
r as an environment variable. Interestingly, I noticed that some include co=
de to write to the OTP.

I wonder if someone could derive a public key from an existing one by overw=
riting certain bits. For example, by flipping zeroes to ones and then brute=
-force the remaining bits to generate a new valid private key, to subsequen=
tly subvert the boot process by sigining new code with that new derived key=
.

Looks to me like a possible attack vector. Just a guess. I would comment/di=
sable that OTP writting code to be on the safe side.

I could find this regarding FIT signatures:

https://docs.u-boot.org/en/latest/usage/fit/signature.html

For the Linux kernel, I was considering using the dm-crypt module alongside=
 IMA (Integrity Measurement Architecture) as a next step.

It seems that Sophon has not yet released the eFuse controller documentatio=
n for the SG2002, according to their latest Technical Reference Manual. How=
ever, for the CV1800B, the eFuse controller is fully documented. Based on t=
he technical drawings, it appears that the SG2002 includes the same control=
ler or a very similar one. Both SoCs are quite similar, with the main diffe=
rences being the addition of an NPU and a selectable ARM core at boot time,=
 alongside the RISC-V cores and the 8051 core.

Regards

Waldo Alvarez
Desarrollo de Software / Software Development
https://pipflow.com
https://tradingfuturo.com

Sent with Proton Mail secure email.

On Friday, January 3rd, 2025 at 1:40 AM, Yixun Lan <dlan@gentoo.org> wrote:

> Hi Waldo
>=20
> On 13:28 Thu 02 Jan , Waldo Alvarez wrote:
>=20
> > Hello:
> >=20
> > I am figuring out how to proceed on secure booting the Milk V DUO 256. =
Likely in this list I can get some help. It is ARM/Risc-V board with an SG2=
002 SOC. The SOC has OTP memory and some bootrom.
> >=20
> > The current distribution uses u-boot and linux buildroot but doesn't do=
 secure boot.
> >=20
> > Therefore I am trying to start at the first part. Verify digital dignat=
ure of u-boot and have u-boot verify digital signature of the kernel.
> >=20
> > Can someone point me here in the right direction no how to proceed.
>=20
> I'm no expert of secure boot area.. but you can search first,
> there are quite a lot docs/articles about secure boot of uboot/linux
>=20
> for the initial bootchain: from bootrom to bootloader, there is indeed
> secure boot feature which documented in vendor datasheet, see chapter 14
>=20
> https://github.com/milkv-duo/duo-files/blob/main/duo/datasheet/CV1800B-CV=
1801B-Preliminary-Datasheet-full-en.pdf
>=20
> > Regards
> >=20
> > Waldo Alvarez
> > Desarrollo de Software / Software Development
> > https://pipflow.com
> > https://tradingfuturo.com
> >=20
> > Sent with Proton Mail secure email.
>=20
>=20
> --
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55
