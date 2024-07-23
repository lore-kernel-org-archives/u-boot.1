Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261D2C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 923B488732;
	Tue, 23 Jul 2024 15:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="YCaOaX54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C7E88756; Tue, 23 Jul 2024 15:44:13 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89AC80C58;
 Tue, 23 Jul 2024 15:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1721742246; x=1722347046; i=frank-w@public-files.de;
 bh=fB636DguVieCgXLuhgn7WOUnOxZbTZD/TtW4jzRl9c8=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YCaOaX548wg9eWjfXmV3JQ/jM1naEdL2ybRp4LEAqnsSGMvNwdKdY307dQgMl7iJ
 4Ot2Nt89ZlBJNvVJj3HsvmBVDMLCu1BQGc/In4czeqvGIq4W/aXYx7XCry6WGne6D
 s+I1Vp8Gi0vRvYdUJwl7nXsgdbUsQnlj4k4XylrOUROmrXvufFuyakyeODFBmaXSR
 lvEesJodck3UONm4KZwNvvn8S2Z4sVZy6UyNp4Azi0ZeXoeMI5FXFEgQuiWt1tQAN
 LW+jXPto3g4bbTDXl4pYeNYB2rCIkOQCQtmuEPLvsqd/RPWEI2+q57cCYJBeld1Td
 UQe4qLbScnv+q1WH9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.159.58] ([217.61.159.58]) by web-mail.gmx.net
 (3c-app-gmx-bap35.server.lan [172.19.172.105]) (via HTTP); Tue, 23 Jul 2024
 15:44:06 +0200
MIME-Version: 1.0
Message-ID: <trinity-430de174-6a75-482c-b8dd-fde586286c63-1721742246830@3c-app-gmx-bap35>
From: Frank Wunderlich <frank-w@public-files.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Aw: [ANN] U-Boot v2024.10-rc1 released
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jul 2024 15:44:06 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20240723015555.GE989285@bill-the-cat>
References: <20240723015555.GE989285@bill-the-cat>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:MRYV7RP3YmhbAgvHKgmTpsmIvaIdjeNkYvr7Ss8FNXouK41kp96vJgjbq6A37X7+AzunG
 9pOaZudxxh6Kjzbucc5E9iAlYwwXnVqPTHLtiz6LUYPR+zkXZT4ZYoN7y9AjJcqB3KamDP+RGr0S
 x7ssSoGI5zSlBh6c36chpsHkxzQ1rr/uq9HhhPbcsPzLfoHyWLcCR9TtIMr9GomUyANcymoDwIle
 U7EQt4EcOwuCnaPk1fPoLrHyf2EyNi3+t6ZibySzZ9Isf+57T90PVzuskOf1uXqEr/lHoR+Glg8s
 q4=
UI-OutboundReport: notjunk:1;M01:P0:JNf4LJBV29w=;3kWOaBrN+AP7GkTvhtmQ2yPE6/n
 Gb++V+nz03xp8o1Mn28kln7gd2CA8Q6AYv8o9jtv9mKhGwh1u2lG+/WExWlBnplGuklomCzvP
 YTwgiwH8s1D8b4qkDe+AIQRU5VNWEirKzoOeJAfh2nbC7sgtKBKDksbSlLny3hdMgdgywgJPZ
 lBASl9WUSorvsMK6wgLjW20XEAdFqLVRke4xbh0n7fpFuQ3RWZ28yDOOAhXUFBxrvEBrVJuZa
 zu19qML3RYpzAx8/4zJW0FYudxZLlavmRgSvtlg3I4fTJ88XL9jD5nO72Z3/C6NDkYnSsafeQ
 dRNh4xrpK9EfUtbjih3lEfiYtMqnsCpLj1NChYZ1aRUE2n6D3mGFiX7cWQbO19odHeM0jtzM3
 UXntXPMN8TuogogDpt++PCH1h/Y5z9nKTeM1CEtVqMDoKK8b/v4FFGarzQpAiKCc3ly1u7dAg
 6yx4PAm+xT9XvCS9R0VioDZZ6skfrN8BsKtcmw7pKbNomGrzKkjU8an5vC1/38/gG7X09X6bc
 xkOfoFJSc3abfJGsW0ouFpvtqqTe7J8YG2PAotuNzNZ0YlECOj+d3EqIwaH4F63aE4LgacaNB
 25xPh62eDDkvmckhMziiexDWE22rSVsG6PtksF9dUTrFKnc8mmIGJJR87OC7/u3BgpsdP9KmD
 ZURgB9lDqbCiurhMsClXXPNGEN1i1ENjDVqQILPPGA==
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

Hi,

i notice build-error because of CONFIG_TOOLS_MKEFICAPSULE is set automatic=
ly and does not find an include

https://github.com/frank-w/u-boot/actions/runs/10059612312/job/27805232284

tools/mkeficapsule.c:20:10: fatal error: gnutls/gnutls.h: No such file or =
directory
   20 | #include <gnutls/gnutls.h>
      |          ^~~~~~~~~~~~~~~~~

solved it temporary by adding CONFIG_TOOLS_MKEFICAPSULE=3Dn to my configs/=
mt7622_bpi-r64_defconfig

commit: https://github.com/frank-w/u-boot/commit/2640a8881d3c6a232575f46b0=
f2b8a0217b6d639
fixed pipeline: https://github.com/frank-w/u-boot/actions/runs/10059965071

breaking commit seems to be

b7a625b1ce49 tools: Build mkeficapsule tool by default if EFI_LOADER is se=
t

i have EFI_LOADER set to y,but it is unclear where the header-file should =
be...i do not find any gnutls.h in my tree

regards Frank


> Gesendet: Dienstag, 23. Juli 2024 um 03:55 Uhr
> Von: "Tom Rini" <trini@konsulko.com>
> An: u-boot@lists.denx.de
> Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx=
.de
> Betreff: [ANN] U-Boot v2024.10-rc1 released
>
> Hey all,
>
> It's release day and here is -rc1. Looking at my own queue, I think
> it's in OK shape, but there's a few things I want to take still, and I
> need to check some other areas for mature changes to pull in as well.
>
> In terms of a changelog,
> git log --merges v2024.07..v2024.10-rc1
> contains what I've pulled but as always, better PR messages and tags
> will provide better results here.
>
> I hope to remain on schedule and that means the rest of the rcs every
> other Monday, and with final release on Monday,  October 7th, 2024.
> Thanks all!
>
> --
> Tom
>
