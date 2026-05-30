Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC47CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 19:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539EB84671;
	Sat, 30 May 2026 21:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JfeioNCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32D9284693; Sat, 30 May 2026 21:52:52 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A6FD80077
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 21:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-660323f7b27so3662383d50.3
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 12:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780170769; cv=none;
 d=google.com; s=arc-20240605;
 b=FGUEagKXYSZ/njuzSGZHE22QZhEyMUt24drPGCaYQiRscyRC3wChEErwHw/6jxoB3l
 YeFdhCAFHY//2KAuzpK0PFCdeunBYr9bCmSC5wXPTL3hY4toVUpwt5lUM4+nfpla6LQ9
 IOJEG74QfwjDEgacic950P0sYHLmH6loklo50oU3jvgVD27MdU58rTp/mdrT522uukdy
 zK7u7YB+3TNcZ+vlPi3jFBfw5vi+BpTLgQd+ElYwDpcu9VxBHacQSt7MXCZgnbcKegYq
 s4L90xJ0Co6nGRHS+hNTe9zb0SUFwUn12q8wQ465en9tXZiR19ukKDNH80vKkLhoQWLq
 yTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NoVE1bpw1SBPwb2pzt2/nN4MFzIlR848q3oqOF2pJR8=;
 fh=5XZqZdu8YSBlaMStg9k2z8E9z2pJhFJsKOZvkbYsY28=;
 b=YPHfW+mgKmi1AsU/bDtazzYKc+1Qr6zDS9onyfEeiuxzymtnAX+Y9YDf2gVoGsIFVi
 XeQgkbLt7e85XKDUxJDr589D562EYLhL8O/0NOQyE9zcrtMEGeoYvnRvbhkpcJfgDyx5
 Zy48wQYA49FRTm2qcsylT0ck2v7k7dwkQeRtY9UQzg4KGyg6oxZM7NnBdlm5KpSgxEG0
 WGIc7pBuFGVyjQAzAYQvad9x89oeiILkHMRjQehIwxQTf70a1aTxpPNi9obpf6eKEQwY
 rSk9o8bFb8HLjmsUXoRX+93CkxPKrFNUZY/l+lORcCWnnDGYKoUGtoEckm7Xsz0zW5Lh
 nEmg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780170769; x=1780775569; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NoVE1bpw1SBPwb2pzt2/nN4MFzIlR848q3oqOF2pJR8=;
 b=JfeioNCqRpn2HdZKI9gGAvJN4RIbmYo1X8KZfZM1whET/ZtAmhT1J3Yc0KNhq0mj1C
 LnhaE7bi4KO5KkS8ePg3G/YcUXJjXxv9HE5OQqYIBQtBKe/Fd6L1jp9pXvLuKnT0IZtV
 DevbMjfIdFXRKvSZhj6HMgdKbOWEORsyn2XAUgh1J3q6itqkbC+GPwFqkleyHzj/c6VC
 /ITPkfA9imtseDP+eSKl9Fz76w6mdRhcQrYw2aiS474GPapJ406VPD/hOgVbv1MYrvm7
 Zab2uzGHDVSdd6kxwNHAqor5OLbFNMwi3152HcqY10vOZVzud4MJKVZeEAy8S5dawsOI
 9pEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780170769; x=1780775569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NoVE1bpw1SBPwb2pzt2/nN4MFzIlR848q3oqOF2pJR8=;
 b=a1t0pn+mvU0nvetASSi6/pT0NMsi7u5ALPNN1WUjn8Aj+e8QMKSOp7fO7xKHNfXbZX
 TeSE4QX30uqDvUPkGCRICLUebWOHhHVrfKLbrERGTPBuqp1+6VfsdUmJ9zzW11oF8F0T
 zPzcXqL4U2/HbTgTLDNhgw3cJ8+gm8HxXigvxZQ6WA3SHOi/FjMJxmlGsAJWaQX6ZbgS
 lb8aiyPPZT0YRZBxQZQXaa3kbG8Nzud3uspPnwZAMksytX1DVpJhx+xB4lOMuTjMhW4n
 xi6XuNPTdisQIo1ytLItxQEAJ2gz+tcY52utiWUNCLAKPBIbWincDamrjpvjalbNeskb
 nrWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4uHDSHQAnrR+kwIBm1L5XsJleHa5uuZNXiQD1hV9EujlrhIFvQJhhXMHT5LJ8aYrzEWCH6zQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8EQXn4Hc4AaGh47kmAzW3a+fv50aBX0p4W3gD6JNp3g96S6CQ
 PYv1zJ+98hYELsHD8CGc+b2hsC57QX6VELZBivAMiDZ6H4dJszMqEG12C+DhFpSSuKLkAV2xlv7
 KhVbH2279OMNfhSc/zzkBFQkJ8wpLrKA=
X-Gm-Gg: Acq92OEAaEowZX7nPzarwIBnzHD2HRlDayN3E3SwOLCqSWYKE6+wf0/FBf7PDXbSDeO
 P2gO6yJ6JenQ+g8EScTbR62n3b791fWy3neGv+g2JkFYSNV/107RTtVzYvDkRCmyqabbAgElZGd
 k8SrANguqVgo+3oh1seZo5udZCntt3Rbrmp+9nyZhDXipaFUHXRS5zS/n27hX7hDFjfzIl1kK+e
 MD1vAbZT47fBY7pszD5hy0O1FFtqXIB09cPh3jhzeiT0dJ8mDy4DN/blTodAn8NVj86VQDVtBo5
 GzwYX9LeJkf+ntuWDg4=
X-Received: by 2002:a05:690e:4182:b0:65e:49e8:3425 with SMTP id
 956f58d0204a3-6605f939a53mr3699667d50.64.1780170768961; Sat, 30 May 2026
 12:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260529205728.17491-1-mibodhi@gmail.com>
 <1724b93b-6987-46f6-b5e9-3ab35a743307@mailbox.org>
In-Reply-To: <1724b93b-6987-46f6-b5e9-3ab35a743307@mailbox.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sat, 30 May 2026 12:52:36 -0700
X-Gm-Features: AVHnY4LXMq8h-k0lrYmYSa98BKNiaB_8turjta5hkikYPA5v7BQ2sfL-bj33sRk
Message-ID: <CAJaLiFz2FUzW7jBy0cPZbJ9dMzjLa1o3igmyyG-PM-BN=ZeBsg@mail.gmail.com>
Subject: Re: [PATCH] arm: mvebu: usb: enable Armada 375 in XHCI driver
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Marek,

On Sat, May 30, 2026 at 6:27=E2=80=AFAM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 5/29/26 10:56 PM, Tony Dinh wrote:
> > Add armada-375-xhci to the compatible list in XHCI MVEBU driver.
> > Tested with WD MyCloud Gen2 NAS.
>
> [...]
>
> >   static const struct udevice_id xhci_usb_ids[] =3D {
> >       { .compatible =3D "marvell,armada3700-xhci" },
> > +     { .compatible =3D "marvell, armada-375-xhci" },
> Do you also include the space in your platform DT ?

Thanks for spotting that, I need new glasses! Will send v2 patch.

All the best,
Tony
