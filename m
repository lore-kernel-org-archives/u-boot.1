Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FD6C9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BFFC80D7C;
	Mon, 28 Sep 2026 12:21:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xh8uYxDjI7Jl; Mon, 28 Sep 2026 12:21:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EB8D480D9C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790598079;
	b=TuZa0FkZ5awpz8fJDCTUYgqGdZ3V5er+/1wEiWW133mYJ65LY3EcjTIEJbVme1h1zNel
	 cqE0HhbKw0sbnZU95OWSY5MGwBd1PGBfOTPbLlGJ7UJuRzcSLmGxqpgBb/rogPNyC8xmM
	 0GXf8Jks/SVHxKaUFJVZCaw21/s9BCs1xOpkUX0CnIGeTcrpSUqMeuLRYahheWyYhvPkg
	 ioYbCDxOvtfb3lUP48baujQy6VT4CDIcsPdAKIjggfRdN9Fx6xK0XKYosCErphSCb2O2O
	 W2ZBFxPCNTd1E0FvJYZPxyR/2ee18XiR1f0IelIApFOztYflBtCnanR9eO8MR+ULXMQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790598079;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TEW4fnt+Q38eDb3uYqakaHMAOASowrDz2mHkmJMBUqg=;
	b=Mp1sQRt8kYzKeAqlKtDqUZKbuYKFM7DzuqevJR9sdp/Ccm8kql80VRIt7RbL3Ko//IJf
	 j0o09s4iZrkHs02UWeAOusV3eI9YUwTqsLZdRJChhS5TWEp936WBJHKG61s3reXIxllEJ
	 ckYHIokeOwHPWUfPt9sIJZPBG0Gnu5HdK4T1a0/kmRY9fH2zs9iZWGEj1/+Q5J2KIvsFi
	 bGX7A0SxHlXag7iB56StOD+k+k0bf8ocg6ov4oY8wqYl2sZ1+v0kS6rZdSa2a7PfEA8K0
	 s9W+GaQ3mAwVTDKBdOY2rh1N+6BjuS0hAbkfZ9TI/VK4sGXHXhzET1av/D+0DZrjM/A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790598079;
	bh=TEW4fnt+Q38eDb3uYqakaHMAOASowrDz2mHkmJMBUqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yGXX9X0zh7YszUpuYzBR2z1TqckxhNd22ALeM/SK5N5Xxd61N/F9KUo7fvWsJ01rz
	 t51qg51BLIAOQSInXP3nhvhEI49OtVU5A3rK06ZbK0buHKtQlzxWBUPr2Iu9pOr2Xo
	 qszBxwvDj7oI9v73kuSNz91f+l9g02XVYqfAiMd9HQCHPp+g9c4qFMyb9FeJ1177NQ
	 uCgFq/7NuAfcBTxWKz0gEk/EkOUkAfDfExe8UIYVxo8PNfu/Rvq9ZwlwW6FtUJXYw/
	 8LnbPemLZuw+sRJqh0draUkMh8eXaz213Uzmg1rc+xiNEaFm8R8r618LHQcTPQqL59
	 gqepzKAKh+3yQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB8D480D9C;
	Mon, 28 Sep 2026 12:21:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 410B12B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 323F660661
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JXHqRuz-OJL1 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:21:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 42477605E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:36::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790598076;
 b=iaWfZ0NoWqsLXo5m4BOB1Xh+P8lSmrHHbN0GqBagHgmuxi6lUqgWwZkiBte5kjZBF8dH
 81kSMtpxxZ9trYUG7ydjjiio3dEgWs95K4YNfQE4Qs4c5Sdi6+C6RwNQrUUlyUevJ1Hr9
 MEae6o7+fgu1/7ejsDyeqQ3CwuJr06E7OCcfU6dI3ulLxtPX7y2sreRVZ6q1W+7+WCxYw
 1cflmeIqn+0xjjT58RtBy9lpkpEy6/Cn8vl4UCm0V2A1J0vclm6yqYPNPEA3gQODiTB0S
 9wYlTqXrGTzCe7lCIZ4AMNDWf+/r/ybaC7HLI96tPdT9YJBZiUglQdfHb8N5zIbVRdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790598076;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=TEW4fnt+Q38eDb3uYqakaHMAOASowrDz2mHkmJMBUqg=;
 b=JiXzJQDOTMlCkRkGaQ0Y4uj1iLnJQnzmW4IrmZL7NpE0W5FTAYt/vDRq4lfz89d64HNB
 Hf8OJf21JuQW8veT5cPTbSYEffu22jLI3uFeeR0YcybwtpU7Mod/6+gNSo+GaBGDZMZan
 7wfFkyfIvpPXu847ecvyBSKVFNNEzp1SwJsk+1QMxD1yS+Gkj0n2hwgJTafFNB9O3oVEx
 WUfkM118IsvHKCDDEwVp4ElBrjil9Vm3JQ8nn+Fq6en8f5N52lQo2GNcYhbh0NXSBCj3i
 CLva6kr5cna1jriWqEFTX4YGCi60IDYnCZahKMygN9+Cn61mRkIXE7ttucGN5S6V4pQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fhGDROMr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:36::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::11; helo=mail-lf2-x11.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fhGDROMr
Received: from mail-lf2-x11.google.com (mail-lf2-x11.google.com
 [IPv6:2a00:1450:4864:36::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42477605E1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:21:15 +0000 (UTC)
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8eb15037aso991112e87.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790598073; cv=none;
 d=google.com; s=arc-20260327;
 b=GdELnu8H/4RjmLIaK5Jyv7fyxy7cHo2/sUE02MuWpJOUnPrJPZo2zDEmvD2ixn89FF
 9jaMT4d4Zc8ycfhYC9PftxgsNpfv0V/wQ7PEzVclxhNzkzfaiBNTB39LkJ1lEXzHQyiK
 6dn2shNtTwSTCbySP7z0ri1FRTspKiiglmIEbqWd33yn2nUruTkFHWVeZYGJAuXCecSa
 M58VTSuWqT51Iqcw2VOHb3qXzlHVxb0ab3IqsscZn53VOuDSJAU1QQvEVyA5RucxLFVv
 YoCBqsfQUY7fiQ/s9e4ulbX3LENO1E7vjrpb9cMNRwKX3OyAct+jjMp0OBd86lHRSwC4
 A09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TEW4fnt+Q38eDb3uYqakaHMAOASowrDz2mHkmJMBUqg=;
 fh=QwJHIE5fulogluZTKR1R6q869bB38CimCRPyRfuZ5nc=;
 b=JxZzZInLbY8H0eD7z3AKoaFc+6JDeFIBLUlMSf09EKZOMzQNpLYm44A0nP5oO3f0ps
 w8vValNN84asmVM+eA9ixai8tjXVy/7DnujNqe8SM34iel9SgqZPzRADJN2ekZnIkWZs
 dfwlEiwjNJ8B2TFqoKZTVHSeiHM9jFo/2o80pteFvqN5MxOOkudsjtUQUFF62B8rFGsa
 +kj07j6cLgbnTJuOBXdhhUrcg03mSRvg0gkngocwcu1AtQqOfAZMWO/EONdNiRObLPMo
 eriTSvIbha9BocKaQMtqatpfCmQOFaClv38TXIapvvk0UKvr9Mmk7TjZ9A5voBYzLgFw
 5hsg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790598073; x=1791202873;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TEW4fnt+Q38eDb3uYqakaHMAOASowrDz2mHkmJMBUqg=;
 b=fhGDROMrFKj2TxYhDTOhIHcKw+czcHfWDg9lKDUNkc6apUH3oAIKtAcUhz1QMz72h+
 fyweHJULO/9YMmAge12XxRF45TTDq5SdOC/XTQ77XIin9TsdgkxX/vbL8znh+Rszy5Hc
 jUs+JhNI+KL2nUEYhGX1Xacwx0H7ply5xchRnq4rTs+F1JKr+TqpMlCKNhVN3agwMF1m
 9MFKKcNMS0N8xeuwMX4XRvQvARZnHY6p5yQRKgVBVNDq5iBmHHDSAs77yYknzqI0HNxm
 9Zv9u4O2KeCG9PLOXklvzEcn/V4yF0Tkw/E4+BBn8CBTCfA9YPXkDJfsm5EXl5Iz6di+
 2YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790598073; x=1791202873;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TEW4fnt+Q38eDb3uYqakaHMAOASowrDz2mHkmJMBUqg=;
 b=D9LKzVMzaO0g/qoh8NS6KayUCbl4dnVUX9ikirafWOpbOB8+COaQdvObwNwV/Iyt4Y
 IzsLXGZxcbh/2dZrSLKtj6q1GTUcLAU97PpGJvm648gnAWOK4s0isEKUIjlOgJLvTW/L
 rc4y4ra4zK7qVyi8ik9ZbJe47fwg7VJdbzupq29psqgS8GPeloS9qycLrKES/vP3vuT2
 qN544srkUpqO4k2XRpKHy4AQqkTdFZw/LGN5Tu0W5HAvRKaonBdjumPvjOnpAltNESOD
 0ggm0eGFYnIOrEI8OxVYdyE9j0ty3s9K4oeX4f8a9KomTapQW8mUU1OPGMkEbetl0xTH
 NsMg==
X-Gm-Message-State: AFq9FYKJ+yct8yyLOsM2TqTGBpH9Aguz+xTA1dIHCrE0QfNasY4KNKd9
 iPld0/8kxt5IFMpzujRrPSwNjqhz57ohFmFmRH8sGSPfjkEuGcU2REQ/aaJtVs0vR9D4aKOCyaN
 dP9oP/OM8sf3BqV59lES9FEpmeHjM6Vo=
X-Gm-Gg: AYBFou0U8C/uXLP8N4M7z2T35phlw6JmPKywqg35xOfzfsra2iBYWJa1adOU+1ASgny
 k/Z+FmJACWmN/2vIzOdNlxUj5pnlmBjVcOWG2V2cSMPF/QJFg9y2KwwZEVO0zsA5j+0Rk8sK2/3
 ZX5BR22sfePaiuVW1jj53N2uorB787tEyvFOQJkakvHUnFjTNu9SNQaWa350oo6K9tezJvw0V6B
 NUH6iA8c8RWxbxbQ6800O72cyx2d9xxyIDXw6l5KJ2TqFlIPa3V2YKxUQ8MdNejWCKOr788jtfz
 bUOMLJ4LwFvCkeu8o52Tllr5Kl5Yrecws45XKZsfyyxR8elNtLIj4vB3XV5TkOF88AlJYJ4hYJJ
 w4SZ+IpH7n6ieg8QPBEDB+GQ0A4BY4LoVUYARYbIT8Hc6
X-Received: by 2002:a05:6512:b88:b0:5b8:f573:35ea with SMTP id
 2adb3069b0e04-5b8f573373cmr1059558e87.16.1790598073043; Mon, 28 Sep 2026
 05:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260922052700.528451-1-hs@nabladev.com>
 <CAOMZO5A25F+JPPPYgCSUOV27=auCbrsdHqCJ+6PVvzV9SPx-pw@mail.gmail.com>
 <3286955f-614f-5238-b1c3-1c5807dc21e5@nabladev.com>
 <CAOMZO5C0oaKnmOpnZF-NwMV=HyZUvdYTMbxqKZyYdAp9xVYAnw@mail.gmail.com>
 <ff7025de-4efd-cbd5-28bb-c78d2f302b43@nabladev.com>
In-Reply-To: <ff7025de-4efd-cbd5-28bb-c78d2f302b43@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Sep 2026 09:21:01 -0300
X-Gm-Features: AclHuK_Zs8BvzmeZDc63HBUo6bPLQYQjvdWzHi4VE6qlWj4sxiFVRpISL3pO9wA
Message-ID: <CAOMZO5D7BN=RaL58-=S=T7Lu9K8F2vKPatt7r6RMmibwXfrycw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] imx: deal with the RNG self test of the i.MX6 boot
 ROM
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Gaurav Jain <gaurav.jain@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>, Peng Fan <peng.fan@nxp.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Tom Rini <trini@konsulko.com>, 
 Utkarsh Gupta <utkarsh.gupta@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Simone CIANNI <simone.cianni@bticino.it>, 
 Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Heiko,

On Mon, Sep 28, 2026 at 2:01=E2=80=AFAM Heiko Schocher <hs@nabladev.com> wr=
ote:

> LTO is already active for that board
>
> configs/imx6dl_mamoj_defconfig
>   15 CONFIG_LTO=3Dy
>
> builded without it locally, and LTO saves 3328 bytes.
>
> I builded locally with another toolchain (Fedora-provided ARM Linux
> cross-toolchain), no size problem.
>
> I see only 2 options:
>
> make the new Kconfig option not default on, or disable it for this board
> in configs/imx6dl_mamoj_defconfig

Let's disable it for imx6dl_mamoj_defconfig.

Regards,

Fabio Estevam
