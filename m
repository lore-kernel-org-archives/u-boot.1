Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7A3C021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 13:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 002AB80C77;
	Sat, 15 Feb 2025 14:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eLvRpKHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C96AC80C6F; Sat, 15 Feb 2025 04:17:46 +0100 (CET)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94DC8806FE
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathanbaror@gmail.com
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4bda3ea7076so92446137.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739589463; x=1740194263; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ep1uV0XvA+u1EySwtiVo1WfO6GzO6jq/jVXel/Xzo5k=;
 b=eLvRpKHvqJEAu12KfcC7VpWqFPS/YJQkPo3kXEXhcMbKCmb5d2YKVEw1PMd2tZNjhw
 oSp5jdBt0UmG8FMraFXhiIeXFtTIuSOWtI74dDQlqyTZw2c6dew1ew7xffWsnPdaUsbI
 5Yebt/79wqmBuoQlhN9+CwbKVWP6JXRGd4ykfo9qWrhdDthikA0TbeKoIBTJT7fZCTXY
 Tduw6Dk+sk/P7Psnf9z6orBwbcLgAmHpXiPpzZjkCcMzOjSRLa5f0dlkpqCI3QjVhf6p
 d7ojHrq6CYo6YxXTGqyew7aECmTMASxE7UMULJpWZ7C4Xmzor804kXtYKKHjvXOtMWKi
 iyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589463; x=1740194263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ep1uV0XvA+u1EySwtiVo1WfO6GzO6jq/jVXel/Xzo5k=;
 b=mwwlgg9efqwubeh6lpPoBZOOnIVQAoymKpAZsIXNw7gdxPOVI74bmh7zM6msPrQy9N
 TyFpuOgtOWgYj+2knW5kybXY0ZqjyglQIX+GqCp4pt/zUpQ8IOK6UaPMzJswJiFJzA5o
 fDByBnNzkt8f/D2pwhqJEb2JQCBB8wlDK5veXYIGlMNGnBN1M4gUFtQpCV9IybtwaHFz
 7o++tEQ3R6ksik7Bo9bHKW3jHcUijeEtpeDkqb5x0qme69nFfEugWUxCIKqIu/9KHM7J
 5aisgoWCif/ZHHB9dcXS9kqIvMVexdGykP+DjkrCwmnTZt1x8bCP63ekh3wvX/FLpyvY
 RCig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU96SxrE0Tf7kGmSpTInEZpACztjvXcVXN+Ye0JzppA0n1yiegF8vI4MRziLKGEA0JF7ppY2oA=@lists.denx.de
X-Gm-Message-State: AOJu0YwolZwIgwGOKIBFbCk2ssxdCzMZHzz86zMmc6nuYRKmQQ39GwtL
 BwOEfwHV6bo4i3Z3dPNEzFsMVQlIdg4kh9WDe+NNfMatBSNRBch6r1tLfGqnH2C6IjoThz/RO9+
 /v1oroqi0eVCEITaYAALOpt17DBs=
X-Gm-Gg: ASbGncsmSFlJSPlaZssEECOsqo7803vjrJMdIzs1THaecDxdSjizxS9+71wyQWWihMG
 E/43ExnZj4Yuni8P29q/cEagXs4nDd8sIwoI3/hijYGxGcacAAsePfOKY23EMFQrCo4ZHtah8w0
 nPi1onrtJgbTX2GxMmdk3eEqUfqZjH
X-Google-Smtp-Source: AGHT+IGmij/nIE3//5YAloMHfJYlVRVhH9/e1wlUHKTIyjnds/Q9+lqWEX3nB34Po4E0fkf7/VYz4U2Zn6zAbjtSEuQ=
X-Received: by 2002:a05:6102:50a4:b0:4bb:ceeb:eaca with SMTP id
 ada2fe7eead31-4bc04dc0ad2mr7162447137.1.1739589463452; Fri, 14 Feb 2025
 19:17:43 -0800 (PST)
MIME-Version: 1.0
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
 <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
 <20250211212909.GI1233568@bill-the-cat> <8734gjsh8t.fsf@bootlin.com>
In-Reply-To: <8734gjsh8t.fsf@bootlin.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Fri, 14 Feb 2025 19:17:32 -0800
X-Gm-Features: AWEUYZlFt_bIGmF42tVBXDR0Ph3awnQVuj_ERE9ZXi_WNh2uZfW2tnVP6kXGKkQ
Message-ID: <CABMsoEGq+s2qudAHVwydpwXw_ROVfgw90yU7+VKYO6x27AWdew@mail.gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, 
 Huang Jianan <jnhuang95@gmail.com>, Joao Marcos Costa <jmcosta944@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 15 Feb 2025 14:08:21 +0100
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

Hi folks.

Here are the CVEs assigned by MITRE:
- CVE-2025-26721: buffer overflow in the persistent storage for file creati=
on
- CVE-2025-26722: buffer overflow in SquashFS symlink resolution
- CVE-2025-26723: buffer overflow in EXT4 symlink resolution
- CVE-2025-26724: buffer overflow in CramFS symlink resolution
- CVE-2025-26724: buffer overflow in JFFS2 dirent parsing

Best regards,
           Jonathan

On Wed, Feb 12, 2025 at 12:24=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hello Tom,
>
> On 11/02/2025 at 15:29:09 -06, Tom Rini <trini@konsulko.com> wrote:
>
> > On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
> >> Hi Tom and the rest of the team,
> >>
> >> Please let me know about fix time, whether this is acknowledged and
> >> whether you're going to request CVE IDs for those or if I should do
> >> it.
> >> The reason is that I found similar issues in other bootloaders, so I'm
> >> trying to synchronize all of them. For what it's worth, Barebox has
> >> similar issues and are currently fixing.
> >
> > Yes, these seem valid. We don't have a CVE requesting authority so if
> > you want them, go ahead and request them. You saw Gao Xiang's response
> > for erofs, and I'm hoping one of the squashfs maintainers will chime
> > in.
>
> Either Jo=C3=A3o or me, we will have a look.
>
> Thanks,
> Miqu=C3=A8l
