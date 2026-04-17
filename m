Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636E4F8DFD0
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C88C6841C2;
	Fri, 17 Apr 2026 10:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Tde9XrzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E5584214; Fri, 17 Apr 2026 10:29:40 +0200 (CEST)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC26F83FC0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso354591eec.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 01:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776414576; cv=none;
 d=google.com; s=arc-20240605;
 b=UJjrfFUO/Ct4KK2jyopcOLgcAieqIVLiuk3B9TcpkL1yE6qn7g326po0lf031KTylr
 H5fqBB8cmhGW37OrvhRCu46pFS/eqSldnbzyzjf0i8fk97WAkEYE7blUWRS2nIARECQB
 Nvw58y/mhcIdtdQfkTHR/5GLb5YMEacF8IWh2xP7jeaK/McVd2HtcWC0UeEIpB9owgZb
 7WNWcBmhunh0ME7BFStalqH3hSjN2yTO+uqdXz0nmKzl/gz5Xfyo+szxrU3kFI6dNIRr
 2iUvOM5yGU70ViL4z9oUXzz0pjzx68pBITq7MBKeZIyGfVQUfuRVysxUbZOG/DnhDi+d
 SHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eDm8KInerMmbDPsmOGlM6WcH4hPfTZ+MxNvIKggxC7s=;
 fh=/pYQyQ1wEEicRxeCV1k+3L35gTnZEw975RXPNRULxBQ=;
 b=DlQdVSknmwNDGc98BBWaG3FvEe8A4vH8SRT/6lMpLe6PPFsMYuD+RWkOmjP9t+HqcL
 LOucKjX45W55B5ip7eJ5s+R4q5Y/0vEFsKRg8LcAQTqg9F/4rK/Og6hpO4Hp9Q8sakoz
 6qesCiCWZhpQlfNFgFunr6xSeLPcdju+DNRPpdvMZQHVJwW5QFmXmgSao2UQm9CSCfIa
 CghAnBchesuRe+W44pdJScZ0sQ5YGLDuj+U8nuQGsHCchvRwu7hOQPAL+zMvri8kSYwL
 0I5nk9Tw06K0yykw0dswzGPKKmSBWIGWW+p0Bs6g50i+yUUEl0I3CbiYiJfyfq3zh38O
 3cDg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776414576; x=1777019376;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eDm8KInerMmbDPsmOGlM6WcH4hPfTZ+MxNvIKggxC7s=;
 b=Tde9XrzR9U0wyvm+lQ69v2wRLJ0tO9sMMhwnz6nR4nWDp9xYo8bP6votwCdywje9C0
 +Opvn3/R0Wx9VjRF6/jk3enYoTIy324RNu73gbsJ4h9toIMDPoWgXr9K72+eiuvA0zVq
 M2AapnXgD968hnNVibS6LHsZzG/5o1JVlybHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776414576; x=1777019376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDm8KInerMmbDPsmOGlM6WcH4hPfTZ+MxNvIKggxC7s=;
 b=T2IS9BruQG2bCxH1yl/YbSPZFo9eerEpUI+HINZOC61UxCAiTnIgYzLKTu6XaTkhdd
 zFc4fxUqoxIBfGFfMrPUpAGKIQyhg+bMO9uQJYgdU/lmg4YDf4J7w9JEQD3ajM+TXBnB
 llxloXEwQ66Lq5p61dr2AOUHqeRXVOCVI2GEjR2hBS8dFl5DN9e46s/CCXsp50+oiIgm
 elt81uTRXfnflbnVRUFSfGKskwuTmurFuwMITqYIAMIsuLT1g3e+uttgy247+ZdQBZED
 MWDgqxBnCZbG49w64/WHcugZJU6uHq0XOgJHkC0EUpXiPmOGyb8/HxplHIdle4NidH+l
 t+WQ==
X-Gm-Message-State: AOJu0YweZRlMAb9J+b1YfVu+xWU6Gvwe7DIv3TmlVSrz3j/4aFp7YRtQ
 j54coWqMYaIZ4rMR6lP+J4D+3JoFVaWoI8h3NZZd9ETf70zutitB+PQFhGKB4vMoAnHkf7Rptd+
 MVZSu1iNZFBANLAyZoAnp/99ijaEF6dviILBJbjNVE/yEX+CvU6Ayx/Aavg==
X-Gm-Gg: AeBDiesT34dHSfx9ybBUVl9RvQYu0XMj6HHwWOx3MN9oz/8ZJCQpVjCD9AHgM7P99Bh
 5CWOP/lHGEXIHMjqQHuWGMue5a6G2ahY5MZvzliU5ypeiBcrXAlAk6hN4LT6apVRBoe00H+vTmF
 NvxjYCwoZgaWf4x27vn+ncBxiyS8H8oPlWERNdcVGjCEAHXy1S3MvNzexP7A5tc6wMyhZ0DXehR
 wBKhguq1T1lMgP1OEQyP7d/S6pLLmIuSqtVqARz8hWBy0M3vy2NLLFFIsrfV7GuJXwxZL5wLbC8
 Om8e0d/qgVhWFu68XKZSRav0DoJuImtnmhYrfX5mo4KsmJV8
X-Received: by 2002:a05:7300:a191:b0:2c4:4363:3742 with SMTP id
 5a478bee46e88-2e464dac917mr903139eec.9.1776414576174; Fri, 17 Apr 2026
 01:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231128105611.488906-1-miquel.raynal@bootlin.com>
 <CAOf5uwnP4O1cop9_CcBYN0YauvQQ_A0cuhno+PDOQzr2=h=UaQ@mail.gmail.com>
 <87ik9qc7ud.fsf@bootlin.com>
In-Reply-To: <87ik9qc7ud.fsf@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 17 Apr 2026 10:29:24 +0200
X-Gm-Features: AQROBzBpolbtz8jTPCDbV11Ryy5HFKPlJoTPOWY-lVcD4YC7yFL9KCQTYqV-2cw
Message-ID: <CAOf5uw=tWuuhx9R6AqpACKsidgWjqeTXzhiwm6Aaka2iHA_EHQ@mail.gmail.com>
Subject: Re: [PATCH] nand: Add a watch command
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Miguel

On Fri, Apr 17, 2026 at 10:24=E2=80=AFAM Miquel Raynal <miquel.raynal@bootl=
in.com>
wrote:

> Hi Michael,
>
> > On Tue, Nov 28, 2023 at 11:56=E2=80=AFAM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> >>
> >> This is a debug command to monitor the retention state of the data on
> >> the array. The command needs a duplication of the mtd_read_oob()
> >> function to actually return the maximum number of bitflips encountered
> >> while reading the page. We could write a specific implementation for t=
he
> >> Sunxi driver but this is probably enough.
> >>
> >>     nand watch <off> <size> - check an area for bitflips
> >>     nand watch.part <part> - check a partition for bitflips
> >>     nand watch.chip - check the whole device for bitflips
> >>
> >> The output may be a bit verbose and could look like:
> >>
> >
> > I have rebased and I will take a look on this patch tomorrow. I think
> having it
> > is ok.
>
> The patch has been in the mainline tree for quite some time now, but I
> see today that the authorship has changed:
>
>
I have problely rebase to adapt to be mergable. Yes is definilty a big
mistake

Michael


>     commit 1fac577207196e12932c2c733b58e3b14013b1ce
>     Author: Michael Trimarchi <michael@amarulasolutions.com>
>
>     nand: Add a watch command
>
>     [...]
>
>     Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>     Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>
> It is probably a mistake but please be careful in the future :)
>
> Thanks,
> Miqu=C3=A8l
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
