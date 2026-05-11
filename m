Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B82CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 19:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA2D583C2B;
	Mon, 11 May 2026 21:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IikzIGAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D619F8394E; Mon, 11 May 2026 21:45:25 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3ED983EEF
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 21:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65dbe04fc1bso1562305d50.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778528723; cv=none;
 d=google.com; s=arc-20240605;
 b=RhE1EWIw83XiAvjU50hXJsp6fkG3O3RDmWN9jf9T5TJv63A3J2ePEe0Eo64Rnb44VL
 r9qWzS7N8vmrYDQzc+xDweEpoTPkovVd8lBiSq7oeogM6xsc5IlwUvxXdpDFyBgYoxbt
 M7X0/8a3Kn3Drmi0GfukXrau0f+XsiS3d4DobOI+PbAec1yumBMA8H4RkR/B8xBUGzMY
 F2qtzAuMJWNbBcdnzTVPIAqOFG5/cN9u87L/ZoVmNxyqULU5vSXFDE8XBaHiw3+6SOOJ
 PnUoOLJaxLtARKM6cfBC+PGcP3zCrrx5zcqndZ/MpHwYTjVzU6E9meyVRtjC9jy+8dqH
 L9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EUXGDletql+ZMxXpc+2aofOK5kyvG7BGOKPpjo6pNnQ=;
 fh=EkvgZc92EwSt6OIziN63ob2qiFrjjyv7tzogS+E708A=;
 b=UfCO+Lfh4Y81uZIvaq+tmqMam9CK743L+485rtKWsAOskFyqQ8dYwEnzIVDZnDjCyM
 hr+bgLp5uNMS2HjYpPLULOZiweNzJvccAG5xN8rrIjglSw8/R2IEK0cHfQgRy64MgT2I
 e4sI9QJvDPAO9lALaYxCGJ8K1VF/uiO5qUm/GM70+rL74FJ1fKSVjAZsuAdDurm+CLOA
 InNGwQ9EmBrggmhSFVTTqEZ7Pn68dqWPTIZwrAcBg6XlCHPGraL+dopQHeWvhGy+l6xs
 fcLJ0E2yX4eyfQfu+5Hp3EjsqQF3ZpYQqcTasYOrI7bl8Y1iEyQuwHMudhwOEe0cDB6E
 /ikA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778528722; x=1779133522; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUXGDletql+ZMxXpc+2aofOK5kyvG7BGOKPpjo6pNnQ=;
 b=IikzIGAFi4+qDT8POkPwxN81OAikhIy0SpcgwUxsTAEuoG0HIW9YGw19x2agAAiC1c
 WNh3PI91hwLHwSJJsKTj8vARODzgZ3qz0GyiKtEMBkFfzAgpFbSDI0Xzi5kBu1vGzLdL
 DkDmbcnHXrnASt+KN68qZX9lt8FEDXpv/4nRLYPn9yFH7RWjkZXJRTWW+luHEGb1RZS3
 q/eROTdmGQ0+vlLhwrmj1U5bHRmfkAWoy5fAKj77esgxnAYFjBC4cfsXEE1fT13ZH4Vb
 x3iVE1LSKtk3WchbLutheO09xPg/VPcYnmzscDdbFHa01x5y2inBKpJnonOCBSn8TnN7
 l+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778528722; x=1779133522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EUXGDletql+ZMxXpc+2aofOK5kyvG7BGOKPpjo6pNnQ=;
 b=TknX2DAi0FglQqWfNtokMl4OTDwoZiFXxU5pq0ENaJKIhpzOxX/jY46TAt55r3+IOm
 isAGKzJc6rsoPLo5ggZS8aVtgdud2wm3uYNxBOguFDDkVihSV07SWbvtcjssFJBy4zC8
 2hEXHWPX4Hq6/EEQkZjQ/xIlV204V1+jgARjB7MXojaswB26rpnMe0LnDD0sCIP2Q1su
 ppUA3AAKZbVTUHIfw2ay6eWnY/O98YMAVk0J64uo6xA10sUS+/VN3MrmTJQ4W9nbLZot
 t7ugse3IcvUqtAmu3ri9wujA7uRnR2PGamqHwPq1d6K+Hyxb3oyX9A3WiMB8RTb49yeb
 Ou1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+s280cZ/XWl12q8586zsM0dy6+PJN444PLVUy42hoWtB2MsfqJg1kL/UTeinTDcJ3N5h0MNT8=@lists.denx.de
X-Gm-Message-State: AOJu0YyCKv//kIVhHrljNh+tLi5VRFikpCJG7RjP9W7zW6o6ui4nwmAd
 mvi1mtuoxME3iHcgydWhSLq0xUvhU1BYp8EoGeLZ+NQJgy56wILPRBHg2LCs/OpISyL6CrsrubK
 Af62AXiPgLcEGOs38v1ixSwCINzjiWMqguQ==
X-Gm-Gg: Acq92OF4f16xQS+LiQUclxXuok+Q6cfTtBnxrKIFyZsPOLWyntWdFZXVqZjGOizYHBS
 QkIxTS3Xi5V1lzS8/0eCqgNdCYgu2HEqXaDj1l1br8sSFIBfHCWM78xxHPxHQUdASfp1R3v7J2M
 nlNqswetqHaBnvbAkPc1uGNHta89jcYHuZ5HomYGPJMhgacBfNTLuwv4rdNpI2DX5ftVORSUuQl
 m+N5dAQW9hLOtjEZWLc11ApBlBExJX2HQy8m9l90x9zCjlEbpmuXrlLUdyG++qBxHg+HHBHXH4I
 txXNwBmaKXT8Ahv1Tuo=
X-Received: by 2002:a05:690e:b4c:b0:656:ad2e:98b5 with SMTP id
 956f58d0204a3-65d94c4c72emr15866539d50.35.1778528722439; Mon, 11 May 2026
 12:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus>
 <9b0f2989-5c78-4e74-a691-b873b9bb2649@cherry.de>
 <ZJ8GNZXD-fYDaXZ4MCGrxvVAtJfaDjWWHRt6LlXWpQJpg3evBb4F-T9KO5yGvmFM3j643wz9PQa4ROK62TL6kKSnBW65XJmBep6yuxh2qUo=@bens.haus>
 <CAJaLiFzyOUV1r0gUAFpgGcQUGzmz_zneiC=AVbAnxKDcOMCvqg@mail.gmail.com>
 <so1abs7pAg9MrPZOVyW7dGcSFp2m4Tf47UW6T_QYYtgqkQ8DqrHNCfPLytOKux86LMpRM9t3fcv_I1uIYIOkdKGFkH5OZ8cEpueoLEK7iwU=@bens.haus>
In-Reply-To: <so1abs7pAg9MrPZOVyW7dGcSFp2m4Tf47UW6T_QYYtgqkQ8DqrHNCfPLytOKux86LMpRM9t3fcv_I1uIYIOkdKGFkH5OZ8cEpueoLEK7iwU=@bens.haus>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 11 May 2026 12:45:03 -0700
X-Gm-Features: AVHnY4IeSBIv5xGtDSOoyittJJuBUfeecm8JgcEfJDVekgIcxmHuJIWElrLOA-4
Message-ID: <CAJaLiFzGYZ89B7LD7z6Mese0iH3-KqM8TFbn5Vkx11Zjr-7MrQ@mail.gmail.com>
Subject: Re: v2026.04 crashing on Marvell Armada 3720
To: Ben Schneider <ben@bens.haus>, Stefan Roese <stefan.roese@mailbox.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Added Stefan (MVEBU SoC maintainer).

On Sun, May 10, 2026 at 6:16=E2=80=AFPM Ben Schneider <ben@bens.haus> wrote=
:
>
> Hi Tony,
>
> On Saturday, May 9th, 2026 at 4:06 PM, Tony Dinh <mibodhi@gmail.com> wrot=
e:
> >
> > But indeed, it's strange that commit 284e1a0 would affect ARCH_MVEBU.
>
> That's because I wasn't being careful. The first commit to cause
> problems is actually 217cf65 dm: core: Default to using DEVRES outside of=
 xPL. That change sets DEVRES=3Dy via
> many other options including PINCTRL_ARMADA_37XX=3Dy which makes
> much more sense given my device. With the previous commit, DEVRES was n.
>
> Thank you for your help. Let me know what else I can provide.
>
> Ben
>
>
