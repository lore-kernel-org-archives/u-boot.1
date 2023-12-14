Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BB2C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 07:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D04887A25;
	Thu, 14 Dec 2023 08:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sxWHFHaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6E4B879DC; Thu, 14 Dec 2023 08:21:06 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5636487922
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702538457; x=1703143257; i=xypron.glpk@gmx.de;
 bh=7h187Q8TLQkZFM2RUSlag3DUuklPndd7XQRENhVuw1w=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=sxWHFHaScLFViBrQ4ztIul/hh0XVeygE7BwScEB/F5QtYjmw3YPXsGCpYb3ZEJA3
 XAvhrFuOUcXfE54m7OQDiLuMoGkmc+Q+ab8Pl/DWfj/q22uIXj9KVY8Q6BS5CWmrf
 s1fojjLxySb2zsa/vW+jG3MzKCJa2qEjT2ieERCmzOu8aEfiZOgNhgtSqe9jxPx9p
 oELe6jWX0f74gxoAlP1YN3TEnAqfwZV+Rn3Gazk3lSdG4UTpUy2s2P7IzlYgv6N2S
 mZYKJTBUTFYAjJ/SQEDvAzY8O/OnVqojycWjuMwAhwxvvdA66Hi6kutuC1Hwq1zbt
 IKwz//JJHBHQd25Dpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1ql6Wn3CQ4-00Sh3f; Thu, 14
 Dec 2023 08:20:57 +0100
Date: Thu, 14 Dec 2023 08:20:56 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/7] doc: Update documentation URL
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ26LAiG47chsk0swBhYZj9JZ9dSiOBbYy+zudVbZz3ydw@mail.gmail.com>
References: <20231119153611.639252-2-sjg@chromium.org>
 <20231119153611.639252-1-sjg@chromium.org>
 <CAPnjgZ26LAiG47chsk0swBhYZj9JZ9dSiOBbYy+zudVbZz3ydw@mail.gmail.com>
Message-ID: <69562B3C-2811-4A62-8A8B-FE2D22FE3EAE@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Y1MzlbRwDHcLLlCODuSYwYC2lQgjNWrahKIjmVZjCTYI+DWLUo
 mjFmzWNW1vvMTBijyGWC04vmFUfucS76gH3NdSQbbBAwAlLdWZy3z9pWRuPN0bXoTYARm4P
 ypkzvM03aoZ1mblmPYwRgowNBUwaixdCwkeWaEVYIx0p+vy0yqLoKB9FbLHoGiJ8xNehM7H
 LJYNxxKFfxYACM8bCu53Q==
UI-OutboundReport: notjunk:1;M01:P0:TUkNvd1UU3s=;bVfc8E64wLg4Rg40c8QVaYxhPEx
 yPqJb47OQkeuX174vhCVNuX3fD++GLWK2bG+GBcpZrc7yXHKiTEP2WhjKIx7unKphbHwWZZoe
 8pSQqQ3qsZOW2Syae8y+k2tBFcMAI9wMbFBZO/HiQAY3cGxWyD7yyGPdxAONrCU5iGW3IO8Dz
 M7cWuIthB5pTAfESxmQmHUPQKUUUcXxfju//NMVbdA7g7tZYMSqZNQ7T0mUWoF39s2JYL0+BE
 hzTy1wcXpzgVAY5YeNaEXbksUP6e8XULTAD6siBBk5IRTzgiX1hp3UfXxJz3f9ouTpd0RcE7/
 4ufMK+RPErG3BelIRdqudRO2nmVyvzO/aU/C2UOrxugG/7e9Rl1mY6bnBur7E5yqrREynpS9W
 v45WdPQmfPN8KFAfQECo+uSixcq6uWPy7cKFWYBdX5fEXG0tp2WAdbpzs/Qb46WN3nzFyrd1g
 RWuZS39MzX7JkUpTMEe6CGWmHX0ZWGgxiVOO6GztBiaBPNzzEj62mMEG/83HC/mVIKYATRhH9
 0WDplixHahP64hWXJNA9z1PvxbV8+ym7L9bEHwODI/WCSDt40dqY0bNeFZEZVfvV9puhAD8Bf
 s6W/zLMPTTQeNkekv5eXYvGYfjIKfXJmrTHlsPTiQxpsvsuxssx+q+BZiulCs74NWCRkDhbQf
 kyEDAP67fyrRdAnvljUMurk41jjj3KKHz2j64UiP/u8PlM5iGX/TnE38er6lOQuDAEc5dwzzV
 kwRzHfcHHbgbm/2/WHCGZIe3nVJOYbNe8yigiQNWiYr07QdJHmwCR0u2z/Mpy8LvuWXZ5t76A
 perx2HrA7BCNGfmSLpxSG908J3TjpFnut9Ek4YJY2ZmRBLyeuaStPvVsw+qHitsq7/5s2WF+0
 HICazSYGU5sfByuPjTZR5WcbuFN/kvp5Q7h9o0M+dgs4tdbu/qv2xiKxNX+Q1T3Vucb1NzZfn
 y1jSHg==
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



Am 13=2E Dezember 2023 21:39:12 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Update to use the new docs=2Eu-boot=2Eorg URL for documentation=2E

Who owns that domain? Can we let http://www=2Eu-boot=2Eorg forward to  htt=
ps://docs=2Eu-boot=2Eorg?

Best regards

Heinrich

>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> MAINTAINERS                       | 2 +-
> README                            | 2 +-
> doc/build/documentation=2Erst       | 2 +-
> tools/binman/pyproject=2Etoml       | 2 +-
> tools/buildman/pyproject=2Etoml     | 2 +-
> tools/dtoc/pyproject=2Etoml         | 2 +-
> tools/patman/pyproject=2Etoml       | 2 +-
> tools/u_boot_pylib/pyproject=2Etoml | 2 +-
> 8 files changed, 8 insertions(+), 8 deletions(-)
>
>Applied to u-boot-dm/next, thanks!
