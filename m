Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092A9C5B572
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 00:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8D9760E17;
	Sat, 15 Aug 2026 00:52:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zoa30BmntyKi; Sat, 15 Aug 2026 00:52:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70BF360DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786755157;
	bh=u61JgbExgvdpbDFrEKSqRBA0wHIC9BJgqYcdI6uBG8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0+JJlCPLARDJLBR7ZduLvMA1tFO+b5gs59zUaKpEee0Vh5cWYiPxMnP746W29Josc
	 gp3uvfQun065AbudUfVv503nst+ag6kxtUccpDKr6CIFYROEwKxW6t8Ioz4GfVF4IX
	 P21sHCqdEcEVtT38/TyUVxmpg4OaVlw3wmY+q6LlKRd2ao/iBH74zWcrQwdQAMZ4eL
	 ZU/215FLcrKkm68qJlNhcWk14nd9e44LtvqimcQM60qtUrLtWjxrxKelsCmZN6T6WL
	 B8g+3tq+FGGWoLUj8LoBT7n0RMwbRTVOaouybO4PSb4632sXI30ISKPOZPiVVHxY6v
	 tKTF9ayB6jJMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70BF360DE8;
	Sat, 15 Aug 2026 00:52:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DE10194
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 00:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FC2460A50
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 00:06:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VbpMSXDX0ICZ for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 00:06:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=dmanlfc@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9B88F60738
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B88F60738
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Boo2ddW6
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B88F60738
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 00:06:35 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4b21f09ec76so850918b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786752394; cv=none;
 d=google.com; s=arc-20260327;
 b=bbrJuykRDukU1YBCCotLHOMNSoVIXyypPQ+SWbWjgUF4qA3sY5cFrSF9M/5fJKF9Oh
 8ntODoQY2RLHtyfXPaWbcIVNN4/MDWL0F+nzO1bHqC5TYeBWgFm/Bfne2IQUo7cWSkAZ
 X1D6b0/Y6MvuvrgtAY87gnvOa2IJ7sLV6hZhKM9XUuzMmRsVs9O6aUWBSQsSs6AV14RP
 ZyHJj6GHabp07t90KCTpIwO31gxNgmskmuGvYVlNenpGRYJjBb2/FHvldVH+DDfK639g
 GQ/w47ATJrF3fqEy04wTsnauGJ8YyLtBG4Esn8N0bNIjvi7CbLzcNyCzxBmsu2XcaeVo
 f40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u61JgbExgvdpbDFrEKSqRBA0wHIC9BJgqYcdI6uBG8E=;
 fh=/zQg2PAzuyeK8caZDFOZj8Z21rYh149OSxPPdvlKo8A=;
 b=PI2PAmKGCP0lNdgZhRI0kMuwEFOgZFxRjVNtQDaB9NYRuIFV4im+umlDiaon1np9X+
 8r3OcVGgkHva9kDQf/oIgB0Fk/H799Js4lMgst3qsJCpT4fcOwKk1Gqx51XJFqhrmAi0
 +nCqO/V0KSKCr5SRmWfMs5yRYA+99XthTbv/EhpOkcBerXWaN+EwDAu4FDDg9qHcnDeI
 BSQmfvXsm0nLP7cG3EP5Ig9FbiLv3IJ1O0FX3ucUxxLB1Y3eGrlmZbCusch2t2XKbHY+
 YceZVwTbJ+C5NrGxR0f29sGaMi3PHZRPRhYK+aBdKo0D+0/jFHtGniALYGvXXE7EM5DX
 J9cw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786752394; x=1787357194;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u61JgbExgvdpbDFrEKSqRBA0wHIC9BJgqYcdI6uBG8E=;
 b=Boo2ddW6wg/cQOZXnj7aKuPS7CRlXX+0qE6sbmE8JOcIXKK9PwxBQdii4Lt80p4MB+
 TSr6MEcPnGF5yNlEfh3jWPzTezMS53QXEuGgYT7mN8cLmgjyqNBTdWUfnCAxI4lNqPZG
 k7mdwGDCOxX+IAJZS/zWt0mnPmY2xiiGH00hU+wivDwJLBfnDwSggPI+vvE4PbvUAbIl
 xDdP61BE77g9D2pSVBybzAngPw1xCuHiHr13Q+Pc2qMzB1qE+12xEWCKrwJozzCgPaGi
 qdjNdb/2j/bVxMIcC5EBjdyZKyGV0ciFWdlM6z7iH+k1vtuYA6V7maf+axg3EhNaKGWB
 oeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786752394; x=1787357194;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u61JgbExgvdpbDFrEKSqRBA0wHIC9BJgqYcdI6uBG8E=;
 b=fsbLgedA8/Ev08+Y/DDQkP0Aqa6i9jsCog1gB5O8jpH8DCggBeD4qsLq2jXMijIfLj
 RhTDKUtCw4sdJ3AnY58t8LxR+BdF+vf3Y+81wk24ho3T3gr0K/4CfqVHCetqCx7Rddc7
 WHmfE3NT7nglCEaypXdccsxqraJK0nuxlpCCQHQ+aEiJk7pG1dl24R0Y75SFiXjI0ndR
 miPgjNeUqMNj2Fv1d0nZseFgVZujVnhgJmfyaqR/ltAEhAikhI+0PEVw75vheo1wcp2V
 X9l4GRPak6lXrcK8uAKmz2bOsLLssuBEs6dlqo+dQ5M2rI1hVl8QGvZk9L86TBzYIlhl
 JUpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzH5kAbYBdmUguH5E2hlqsBJKTdzXwSbRdSVnWGjaU76Jil1sB2D43k9ciyFj9ZKcN2AGyHqk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyAOXeION2d71MhRz24vwpb8Za+wCh0QcoMjdjfswi6VgIHmMLg
 HF9/APbF33uw+cUQ/oNzwUh0X6+M4bbcueb6xuvG71L26EuOyIPW1zLC+quxACRPtUeJSd4j1L6
 664RYscYX3zTIPsx+b5L2znYFaVrTOhg=
X-Gm-Gg: AR+sD13s7aVO2qcEfX12b0pTatJ8bN0XiufTyQsg73Y8jVP1dBWjYVJzqbDahaSMLdZ
 mTErPaH3j576umc/Pu/XrxV6fj0LG6iuDYbGCA9OLM9UZ/pGQYe61JGhrfvDXuqo4J9qYeDEBz7
 Tlpdlg9VwSjjnqeW31rbPlW37a/Tl484nedANYB3z0gXkEFG/VTgstPvQ4dg8JzS+Z4k31zXPbq
 W7MHbgczPzzsBO4M1XGU1VCHHli+xoCS3HFXc8VSDU92ifRzYhtx/LOAAW8uUiVwetHsUWSGLLa
 2hmdOiBT1bfIdKgyYArzrIiX2EgyZZnV2SOvT3PUQsfZ/A==
X-Received: by 2002:a05:6820:2228:b0:6a3:e297:2f14 with SMTP id
 006d021491bc7-6b0d611ec87mr7957263eaf.8.1786752394407; Fri, 14 Aug 2026
 17:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyTmd13R7_fan-iB8qK55AFZoba+RCi4VT-GOa5ot+OZD__Rg@mail.gmail.com>
 <38c0d683-46bc-42b1-86a1-345b2070084b@cherry.de>
 <PH0PR19MB997338FA72B2980A64B4194127A5DA2@PH0PR19MB997338.namprd19.prod.outlook.com>
In-Reply-To: <PH0PR19MB997338FA72B2980A64B4194127A5DA2@PH0PR19MB997338.namprd19.prod.outlook.com>
From: Daniel Martin <dmanlfc@gmail.com>
Date: Sat, 15 Aug 2026 10:06:23 +1000
X-Gm-Features: AUfX_mzf3iJKJXAyd031AZER3EgK8Xsyhxxs6AMYGL0RykgPMNaaq3icKy4cYJk
Message-ID: <CAOyTmd1JvBqRiuBPcLxkhF+x6yws6uOQ7z6vZqq3jrZkgj7+tg@mail.gmail.com>
Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3588S)
To: Christopher Morgan <macromorgan@hotmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 15 Aug 2026 00:52:29 +0000
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

Thanks for the further details Chris,

It would indeed be great if we could move this device to mainline end-to-en=
d.
Let me know how you get on with v2026.07 and if possible, test your
DTS with the stable kernel (7.1.8 or similar).
When I reverted uboot, I encountered inconsistent I/O issues with the
latest stable kernel, therefore I ended up going back to the BSP.

Thanks for all your work, we appreciate the effort.

Dan


On Sat, 15 Aug 2026 at 07:40, Christopher Morgan
<macromorgan@hotmail.com> wrote:
>
> I'm having trouble with my usual email client, so I'm sorry if this messa=
ge is formatted weird.
>
> I have tested the device most recently with 2026.04 with the default defc=
onfig options. I am using mainline Arm Trusted Firmware though, not the Roc=
kchip versions. Using Rockchip's A-TF should work, but again it's not somet=
hing I've tested. I can note that if you're using mainline A-TF along with =
mainline Optee, you need to pass CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3DN, othe=
rwise the device will fail to boot because it won't protect the Optee regio=
ns. (For mainline A-TF CONFIG_SPL_ATF_NO_PLATFORM_PARAM is optional unless =
you use Optee, for Rockchip's BL31 you need CONFIG_SPL_ATF_NO_PLATFORM_PARA=
M=3DY).
>
> I'm going to test the device next week and see if I encounter any issues =
with it. I'll report back if I find out anything weird.
>
> Thank you,
> Chris
> ________________________________
> From: Quentin Schulz <quentin.schulz@cherry.de>
> Sent: Wednesday, August 12, 2026 10:22 AM
> To: u-boot@lists.u-boot-project.org <u-boot@lists.u-boot-project.org>; dm=
anlfc@gmail.com <dmanlfc@gmail.com>
> Cc: Chris Morgan <macromorgan@hotmail.com>
> Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3=
588S)
>
> +Cc Chris who maintains this board and may be able to help.
>
> I somehow didn't receive this mail in my inbox, here's my attempt at
> quoting text from a mail I didn't receive (and it's also not available
> on lore.kernel.org...).
>
>  > Hello,
>  >
>  > I am experiencing a total boot failure on the GameForce Ace handheld
>  > console (Rockchip RK3588S) when trying to run mainline U-Boot
>  > v2026.07.
>  > The device fails to initialize or display any output during the
>  > initial handshake.
>  > Unfortunately, due to the tightly integrated form factor of this
>  > handheld device, it is exceptionally difficult to break open the
>  > casing and wire up a UART serial console to capture early boot logs.
>  > The target operating system (Batocera Linux) environment is running
>  > the mainline Linux 7.1.5 kernel.
>  > Given the complete lack of visible console output, I wanted to check:
>  >
>  > 1. Has the GameForce Ace board target been actively tested with the
>  > v2026.07 release?
>  > 2. Are there any specific or updated build instructions, BL31/TPL/SPL
>  > combinations, or proprietary Rockchip firmware binary requirements
>  > (rkbin) needed for this release that may differ from previous
>  > versions?
>  >
>  > For reference, the build configuration used was: gameforce-ace->
> rk3588s_defconfig
>  > TF-A / BL31 version: rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.21.bin /
>  > rk3588_bl31_v1.54.elf
>  > Compiler: GCC 14.3
>  > Linux 7.1.5 uses the rk3588s-gameforce-ace.dts
>  >
>  > Any guidance on known regressions regarding this target, or
>  > recommendations on how to isolate the stage where it hangs without a
>  > hardware UART, would be greatly appreciated.
>  >
>
> If you have a known working version of U-Boot, maybe start a bisect with
> that commit as good and 2026.07 as bad to isolate a commit that broke
> the board.
>
> Cheers,
> Quentin



--=20

Kind Regards,

Daniel
