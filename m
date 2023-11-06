Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF74BC4167B
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 09:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C374086FE9;
	Mon,  6 Nov 2023 10:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qaFHwFwj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8838F868BF; Mon,  6 Nov 2023 10:18:31 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B447B86FE5
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 10:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699262301; x=1699867101; i=xypron.glpk@gmx.de;
 bh=eNY7+8RcPbJL8vdS9zzLo+VBMIDERO6/XY32M+L3IxQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=qaFHwFwjuxYbREjWr8qUyfXRHJ60w0P8b1r5lQM0WbpB90T3St/h4CP6hq+OFrMO
 /IW+M1iiPGrlK6PS0DcIX8U0TnRcY71S44wb89DIu/0OBEKvQhZAF3GGQNvit35vu
 0VayEjNSulrHp8BhRUf6Fs4cJup8j/oT62gwnlApa4C8hg8v012+4HqSUIHKT3zzd
 eutPXgvjC1IZZMZmpPIOhjs0TydBEo+MocCyVFhR7BZ11/LIq74Ux4BW6COECc82x
 vLv3ZFf2eSNtPFapKx5AUcQRwfHg60s1YM7sApX2/ZlYmzY9trXnysDL7Rpf+kMqc
 RCS8wpYxKljIZR48JA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.20.5.50] ([4.28.11.157]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9nxn-1r5iVE0CzV-005rL1; Mon, 06
 Nov 2023 10:18:21 +0100
Message-ID: <da4dcf4a-faaa-4759-90fd-a9142f288736@gmx.de>
Date: Mon, 6 Nov 2023 01:18:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/25] spl: Use common function for loading/parsing
 images
Content-Language: en-US, de-DE
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <marek.behun@nic.cz>, Marek Vasut <marex@denx.de>
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106074905.pgrdj6zhsgy66a2e@pali>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231106074905.pgrdj6zhsgy66a2e@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7pT+u8W5N+v92I82ITu2EYBR7+HVrMo7X8I8LoeJkQ0sxhkaUva
 tmjtqrhR2p3mOk3MG0XT+vNW8FNMOISjtueJVP/ntFibb1rbxVhZAjL77B5NAD/cxjU7b3Z
 Zf2OnQ8Igy4mt72ZACmWl7ycqkfV01LTMR/IE3f6QBG/XYBPX1cImD2rMNShe6JOb/nw1tU
 pATtmqwFIAr9Iq6b1n9bA==
UI-OutboundReport: notjunk:1;M01:P0:CeyIowO4Z3g=;Aiu4Q0gSCJE7ywBIu7Lln6a20+j
 WVic+e7LhZ1yDKTKRFle8DocvCzYm3sbBqP2NTnhMw1tRYWr8d+60asM60YHE0xEp3AD7hDaL
 m2/h2toGxKmlPyEE9RNEscHn9SatEOUXyE72FiJmdZHlq94yWj+26gvXiyvCmPj6kdXljN/5a
 mjuj288RPzVqvu0eVjrI5B4m2ldfV/2k9bSzXKoKgkfPT7z991Y7DBqYVCkvjSiRy25NGAQaA
 8ENIi/kCUyhG3YQYX+4xfykIoH+nOKCj7loY0ca0o0xpMFZhzlypeLwRDAN/nFo8q/3kPVSEy
 EUQjT1PixrUih57lNJMQhVRbzwcvSMAApSO8ocOAgHvkUIF9Lzei2fJ+Hp83u9G3yp9DVfKjD
 /htYaF9bXwKn6psluY66CJHsWnyvviHUVe3ZequHlTApoEffdz+wOC9HjCL9qwombibLl8T/N
 QDXRQixKanlTrEdQtQcPf6EliumigG+yBaEIv9h/aZR0okSF29jMDMVbt7l948zyQDPfqyyPR
 r43qeByvrhxpkPho2f1O7v2YfxEjl0Njh41BLVaWKNrIc/pYyq+LGZ5k9ceO5LO7rmizkheTs
 CVus/b4spg2oroUqRBhMnizkwPd4fY73zMue8KqixgA5DTrG9CmSXZt4cLEyq4YtaW607te6Z
 npI/PRq2CHo21IGEiIKYmWIYl35v4w2dpXtdRtrIRZy4CoQMkg83r3NB3s96HgOa9oJzEPMhG
 5uD5mI+ahgInXMnRpRbdU0SRbwwBjl7opWekNzG8W6KpMXUk3VamHIdFQL5V7BI3PhLsTXWm7
 amx7g1kOiUQHrUolBfOXKFTbTZebG4FXG1HG6YIGe7zhSIIY0iakzA85ZEANUaUqscB4NYUKd
 vRt1+MXaOA5+J00y+0DhaYVkz6UUYHgnx73+B7HlfRGc3sb+t9J59ff3wdMEByZcP34R8HZHX
 J68VXw==
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

On 11/5/23 23:49, Pali Roh=C3=A1r wrote:
> What you are doing is the worst thing in the world. You have been
> ignoring all my changes which I have been sending for one year, then you
> wrote me that I'm not competent to do any kind of programming, later you
> wrote that you would ignore all my requests and stop responding to any
> questions, then you have removed all my code from u-boot and showed me
> as the worst person in the world.
>
> But seems that this is not enough for you. You have to continue
> attacking on me, and making everything even worse.
>
> WHAT YOU WANT FROM ME NOW???? WHY YOU ARE CONTACTING ME??? IS NOT IT
> ENOUGH WHAT YOU HAVE TO ME?? Or you do think that I forgot what you have
> been doing with me last years? Speak up!

I have created a patch for .mailmap to avoid sending Pali any further
"unsolicited" mail.

[PATCH 1/1] .mailmap: map Pali Roh=C3=A1r
https://lists.denx.de/pipermail/u-boot/2023-November/536392.html

Best regards

Heinrich
