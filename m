Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75126606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y/IBpMHd;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gJ/VqzFs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C304605F4;
	Mon, 23 Nov 2026 14:05:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 31mFDmc-R7ds; Mon, 23 Nov 2026 14:05:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81BB7606B1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795442743;
	b=RZ6EZU9A0Hqkg5v8eWU36oXwv3X4wk98374TV4IsXcTfafODcPWh78NKbqX6swOhwH5B
	 AEKREa0NMvTx3tjaxzhIPndq4J7c3b/2UQnevne2BgFsihC8ikGVz4E2Flh7KAH0KHlrI
	 JrQYtojNb2jdoaQogkv9gnNFArEIvLlMfH1M2z/OFKRoV9Of42yfweXXsnRYJejuS4JJJ
	 4tat3aO/PK+p5K63nnutppeE2g+xhvtz87UeYH9s27olVyWAIzzEyTMcm0Wd0g9to5qxR
	 oDXoIYZYyA/Zxu3VxnfZ7kRl3JdvakfMSKM4nwBYZ+k0nt6PnIr49Sxxf93J4Pqt7bA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795442743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GVDzqCW9089E0L/gC3ApKVnlJnxr/5w7ON0v9fBTH2s=;
	b=I6Mlvx+pyxzJuYRRNgTPM/wh8dQWZxel2NbXJkTIl1+TOmugzWEcVZvYcTl7dfVBmsTe
	 mzK+0u583AtwFX43oivRrpD3EmY5edwlR5RJDUM2pMYP/I5pziBkha2dU/7KiWlcarheL
	 FHJeOmaVv3OV5zvz7KQ7kvkFjPKPBoU895Coo02iBEwp8/n5gzk2iZCyRYYTDn0unbv88
	 9QpR76U8xLxEEtfkL7QJE3vgQ+lYEEOR6g61IprDTMvHYIJLjEYN5l41tyiETubRXHcQZ
	 RMk5jjX2z1jsq2T19NhShueVvwKpkPSN70LVBEgWlDqc8LYPaXD5716ocs1Q9RYZX+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795442743;
	bh=GVDzqCW9089E0L/gC3ApKVnlJnxr/5w7ON0v9fBTH2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y/IBpMHdl2siSxXWgbmJkEIpMNHJ3iCzhtCJK8MmQqd3AGPuQ0+MALnitwpKhjSHQ
	 scagOMVEqM+Z96KWEJg6831B/6xUDN5e8RezPmZcO1DUwGN82XXCyqCk+A5ToKBUbc
	 VI0Nicch35y9YbqVq4wuUJf9mFFPsNUEOMG2duaTD4VfRXWF006ngR053vibAHWMYp
	 pK7zJmAQS+0vex+frROOFARD+iJEbrEeilInuRkRXz4VUdYGhaDQrhS3pPVonaFn2d
	 lRnczrLTZD7Oc7poCUrVkIQNxaKn99NedwY280WuxzpsWzQMnG/68JCmdZgrqCPahK
	 KXuIsi1xIZkYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81BB7606B1;
	Mon, 23 Nov 2026 14:05:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 32AB73A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:05:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1838780D9E
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:05:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UI3LL3L_vd6n for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:05:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E169E80D8F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=gJ/VqzFs
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E169E80D8F
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:05:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE546841F2; Mon, 23 Nov 2026 15:05:38 +0100 (CET)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9795883108
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 15:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-3863db981d4so4440850eec.0
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 06:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795442729; x=1796047529; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GVDzqCW9089E0L/gC3ApKVnlJnxr/5w7ON0v9fBTH2s=;
 b=gJ/VqzFsg3zk8HoEKkGezRRxONZl5Jk79ctV6anPslquD30WDXwrUjlBZWUCBpQ2Cj
 98o0jDVlNFxZJIRH0c3HGhNQ77mXl/HxAuKdYbcJWVNBcGT+VpTiGVHUE+gDqHlvV25k
 4VhnuBMxqnzQHDQRHk376TP49KmPFcb4LxQn7ZoZP9krf1YMN6VPD1CAIozSOHArFvjX
 5RqanuoX8AgwN2NO173uxFUb3OEteiWnTdrDZ2t1nkqjRY7UQOE8AQ0fn04sOEPBja/C
 DGGCFL+1BxJsO/8o+9HmEFJeCGMuhL/9Pj7V33nndiW9lWmY+4ESqViR0tHV3r0Ae01g
 egtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795442729; x=1796047529;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GVDzqCW9089E0L/gC3ApKVnlJnxr/5w7ON0v9fBTH2s=;
 b=tGx441pvRb4OTjceBhYIORrxrCjaPdDgGW0KgCOU3XqX6CFQB3zOeLgGdl9LTnsgyN
 JZ74Llr+FE1EeMVIDSQt0iz9vBE2tqFQOUER49UTnot/1dLvhDoOILehX7tW6Xyf+K+t
 HbPV2gZYE+0ruz4uUQ2VvT46TAcKJ/nZA9oo4gcjzp87UDdGuvOnxXEX0jV+cjcXnryv
 CLVKTx5t0V6OkdC7yh49muxA06I+G9sebqeMNWxx5LDyxESV0ksz1UHP8mpk6viuYjjA
 BUH0HM7IrEufMUhtRqeL9f8z0n3VIjdoeF50xoMwBvLO34Bz0jIa+tPY6QQazBesak/+
 oFAA==
X-Forwarded-Encrypted: i=1;
 AL+hErG2omK0ZHIgeKDIlsUOaEu6IOuB4fW91+rnR7IYBkb6pRY2H7HbURv1bIP+twPSbrqY3Ue5ISU=@lists.denx.de
X-Gm-Message-State: APuU4Z8f1YZfb4hInM+n/GN/eTcI+X28EIhNYTA3HsdofLMzDDEHVsPK
 w3tIs45J/eBGkMA/uw0SA/U8Jceht1Tc0zZmGYDElfcINF9xJl+Qfo82sJFDePvVxeLqxym8xWr
 /euj8S42MBPgLlUJQuJwO75OrpR5Yu7I=
X-Gm-Gg: AZFdTZcROmp/zrVUnHYaPhSkTp62buaVidtWdzEa6rHduPCJCQymTLvSmvvZkN7wfTJ
 hJ/fqwHhsvk8cG+P2SP78L77x+FGMASmoqahmXpovTQ9tbAKtg1VV0ESDlyEALkrwq3S0+Z/fBs
 YG0xr/lV4OI2WfttpcpIaXKLunYYGSvVUIc9NIloeLtJff5NnQi5cOX2XSoipVq1Zgup6dl3K+y
 CiwW5BpQeOXHsv+DbhFUSqjOpPXDjAtU0HO+LmxyT8L8xJDd7+qGlQRGo5sNCBThlX5gqypEJIQ
 os8WrzgegLdHYj2H7gX8SCUYRpaCM7Yoxm2ZqGDTO3qhwSqNFllVMP2jBQb5y8lROa9lDTMADD8
 ZGCM0kYkqircoIFEPdYNW9hJmqpY17JDg0ro1ahuJlRksTooIUBgbeE12K0z89WVwJKPElJlvC1
 Q+jjEJM3vvoPyYXAqTP0reCOCE6QO9fQ==
X-Received: by 2002:a05:693c:87c8:20b0:386:ac97:f661 with SMTP id
 5a478bee46e88-386ac97f9cdmr3553702eec.9.1795442729251; Mon, 23 Nov 2026
 06:05:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930075527.92697-1-clamor95@gmail.com>
 <20260930075527.92697-2-clamor95@gmail.com>
 <xhkdbfqy567t3.fsf@mkorpers-koolstof.csb>
 <xhkdbcxt65btd.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3HUqT+TqyRrkyc83r-sDXMcMEXpqPPYxhinvp1rs8pDQ@mail.gmail.com>
 <xhkdbse0ypi3o.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3NSBJo+n7=Km5+GmyuQ7QQ=FhKydXP=dqBnJC7w4K=4w@mail.gmail.com>
 <CAPVz0n0e1r42peR3nv9ma-nFmhsiXB+cZCa6EdN35MA_U8K-SA@mail.gmail.com>
 <53169c72-64e0-4ffe-ad62-a5d7f988bc68@baylibre.com>
 <xhkdbse0rslbw.fsf@mkorpers-koolstof.csb>
In-Reply-To: <xhkdbse0rslbw.fsf@mkorpers-koolstof.csb>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 23 Nov 2026 16:05:17 +0200
X-Gm-Features: Aa3M54rbirtPf9kt3d8GHKW1RvgPdAGZoX28oTYbjUN3zeJnRyOravvZpHwxpIU
Message-ID: <CAPVz0n0yxcNWZEyZJUX6aeXYU3FX-9i2u=U=rbFFvZ9a-+xcLw@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] fastboot: Add
 board_fastboot_flash/erase/get_part_info hooks
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
 Thierry Reding <treding@nvidia.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Ion Agorria <ion@agorria.com>, Peter Geis <pgwipeout@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 23 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15:5=
6 Mattijs Korpershoek <mkorpershoek@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Mon, Nov 23, 2026 at 14:37, Guillaume La Roque <glaroque@baylibre.com>=
 wrote:
>
> > Hi,
> >
> > Le 18/11/2026 =C3=A0 11:45, Svyatoslav Ryhel a =C3=A9crit :
> >> =D1=81=D1=80, 18 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE=
 12:44 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>>>> You are mixing up. This patch does not add any vendor commands. It
> >>>>> allows using native commands with vendor quirks seamlessly.
> >>>> I know it's not exactly the same thing. I'm just worried these extra
> >>>> hooks will make stuff less maintainable in the long run.
> >>>>
> >>>>> For example. Tegra devices require bootloader and bct to be encrypt=
ed
> >>>>> and bct to be updated every time bootloader is flashed.
> >>>>>
> >>>>> $ fastboot stage bootloader.img
> >>>>> $ fastboot oem board:write_bootloader
> >>>>>
> >>>>> Used has to stage bootloader, then write is with some custom vendor
> >>>>> bootloader flashing command which we have to make, document etc etc=
.
> >>>>>
> >>>>> This series allows intercept native fastboot commands of flashing s=
ome
> >>>>> partitions and apply vendor specific adjustments directly. So I can
> >>>>> flash bootloader, boot and system with native command `fastboot fla=
sh`
> >>>>> but bootloader flashing will be performed with encryption and does =
not
> >>>>> require from user any additional movements.
> >>>> I understand, that it might be easier from a user experience point o=
f
> >>>> view (just fastboot flash <whatever partition>)
> >>>>
> >>>> But adding extra vendor hooks also means having a specification of w=
hat vendors
> >>>> should do in these hooks: adding docstrings, adding documentation in=
 the
> >>>> fastboot.rst page and such.
> >>>>
> >>>> I'm not NACKING this series, I just wish to discuss in more detail w=
hy
> >>>> 'oem board' is a wrong idea.
> >>>>
> >>>> For example, do you have a closed-source userspace that forces you t=
o
> >>>> use 'fastboot flash' on tegra devices?
> >>>>
> >>> On production tegra20 and tegra30 devices bootloader must be encrypte=
d
> >>> with aes engine before flashing, and bct must be decrypted, updated
> >>> and re-encrypted before flashing. We decided to use hardware boot
> >>> partitions to store bct and bootloader, so we do not have traditional
> >>> boot partition. Hence we are using fastboot flash to intercept
> >> boot > bootloader (typo)
> >>
> >>> "bootloader" or "ebt" and "bct" commands to flash partition and use
> >>> our own implementations for them (for emmc and spi). All other
> >>> partitions can be flashed by default and need no special handling.
>
> Ok, let's go ahead with this. It is indeed a more elegant solution on
> the user side (just using fastboot flash <partition> and let U-Boot
> handle complex cases (like bootloader/ebt/bct).
>

Perfect.

> >
> >    I'm rather ok with the patch and with intercepting the native flash
> >    command through hooks, it's already done this way elsewhere in fastb=
oot
> >    (fb_nand.c, fb_spi_flash.c).
>
> Please also look at how it's done in fb_nand and fb_spi_flash to see if
> we can have similar return codes (if that makes sense)
>

They return 0 while you asked for -ENOTSUPP

> >
> >    Some small comments for v2:
> >
> >    - board_fastboot_flash() returns 0 when not handled and
> >      board_fastboot_get_part_info() returns 1, it would be nice to have
> >      the same value for both .
> >
> >    - When you rebase: flash() now starts with flashing_refuse_if_locked=
(),
> >      please call the board hook after it, otherwise a locked device can
> >      still be flashed.
> >
> >    - A small update of the fastboot doc would be nice too.
>
> Please address Guillaume's feedback (as well as mine I posted
> previously) for v2.
>
> Thanks for your patience
>
> Regards
> Mattijs
>
> >
> >
> > Regards
> > Guillaume
