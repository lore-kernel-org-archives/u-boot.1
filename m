Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACBFC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 13:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B10B680F0B;
	Sat, 15 Feb 2025 14:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ApvWAq8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFBF880FF9; Sat, 15 Feb 2025 04:24:40 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22EEC80FD5
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathanbaror@gmail.com
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-868fa40bb9aso385880241.1
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739589877; x=1740194677; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRVyUPsMSzLuveyUCfRMYI1870pmgWGGv9ydJBObdy0=;
 b=ApvWAq8DdPDEMLCt8fwQQENaVmDHXNCE4yUd898a4uuTE11JlCbCdCb3SkrNhhfh8H
 /L6M08LPTDZESTp+zrxjFNmgHSy09WJWKEMJ2GDH/ZcVBA2Ph9pfCApUQjXW3NXwDlnV
 Zay6PnFC7qKPpsEc4AqL7waTbVsKjqBzETZ0U/1uUbCSZkve/rtTfvIJdK78MRtVfStH
 lfRv2Zs5yk391zRNexfEAhbolpLlFmna0I0O0wQLOwVQ9lL6Po/EdEHxKGgrGPTL/lWk
 iht53yALecMQuP7+MJfcZ6gi/R7hWTSbkQklh29aeYgmFYgjnbM5DTUAcnloqCsBCpuL
 5NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589877; x=1740194677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRVyUPsMSzLuveyUCfRMYI1870pmgWGGv9ydJBObdy0=;
 b=VPufhA6OZrZGmpZZd9RHcs7B27+uiJ7xgiMN1mEIpy/zn/W2FuiAImSu2707wnrX5R
 yxmDpxM20iAkbuMnQPoKvlfpJv5Lqko5HLWQ/gkFKIbi1qVC6Bs14XdEp+fITNIkOWNA
 e5shxK9MDovYADVfb2o571VIc17g1n/qpq2Gy2L2knyuNi/cCMyX8Sv3Y8OGl6IeW2V/
 L8hSIipTIV3X3uMSUzjdjuSNgblc0eLaFtmPH62gSY84ZdTLquCWXgReOhAOIj7fh7ko
 P3U53FPJiq6Csa9JKpIR547PddxrlrbcWC0d63xpF4j3qkXrvgSNVUeKd+/bA1e/vMxj
 lVXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyXNEaLR/MYqc6m11KEwce2EJDAjMbqdODCQZh12p/U2y9dMXELgiXDWO21oUzPNa2daWJJ4I=@lists.denx.de
X-Gm-Message-State: AOJu0YyCElu4VCxhGwKwNpVjzDLm/ESB6yab8j3o1oYN8BFuMi80E7pC
 AA2f15xZYM0BPfsnTGP2bW7sJrSLf/wP/gO3e+6y3fnFPOncJbzfvhQhbtvwflJ8y0G/Er2FCIY
 VhzTYAiV7CE4+wB2gKqLgqzWq7f0=
X-Gm-Gg: ASbGncthJsR9/cC5TqGwxa+zSsVnNJBPHsTPJrD2b4wW2NN3J81124NHgJ/T/uycqhg
 G033SV3oNLurs5acYOn826xTv+0vY4JhvaBLH3x7ZV8I5Jf7lWQNRKPzYCG8vij0jFDSwSYj8m0
 OrxXPnWspkgbntgdLFbTR0Dlrp/kDK
X-Google-Smtp-Source: AGHT+IFypluWmnDkKtvIGGiWpbhspJdBkel7BnLRu7j0NgHXyR65z6XQxMfIsFfuxkTxqkTO3P2YcjOBTAtixQ/laRg=
X-Received: by 2002:a05:6122:29ce:b0:520:3914:e6bb with SMTP id
 71dfb90a1353d-5209dc22be3mr1040957e0c.7.1739589876941; Fri, 14 Feb 2025
 19:24:36 -0800 (PST)
MIME-Version: 1.0
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
 <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
 <20250211212909.GI1233568@bill-the-cat> <8734gjsh8t.fsf@bootlin.com>
 <CABMsoEGq+s2qudAHVwydpwXw_ROVfgw90yU7+VKYO6x27AWdew@mail.gmail.com>
In-Reply-To: <CABMsoEGq+s2qudAHVwydpwXw_ROVfgw90yU7+VKYO6x27AWdew@mail.gmail.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Fri, 14 Feb 2025 19:24:26 -0800
X-Gm-Features: AWEUYZnajkda29ArdJ9WH2JXzTaGyLRTusvUnSP1A4A5xHenQgeEim-Q_Q41rJs
Message-ID: <CABMsoEFcL-D2OzJWQM685TfLq20L+d2gNmy4XD7yW6aDwpKb4w@mail.gmail.com>
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

Please disregard the previous message, those are the actual CVE numbers:

- CVE-2025-26726 :SquashFS directory table parsing buffer overflow
- CVE-2025-26727: SquashFS inode parsing buffer overflow.
- CVE-2025-26728: SquashFS nested file reading buffer overflow.
- CVE-2025-26729: EroFS symlink resolution buffer overflow.

Best regards,
           Jonathan


On Fri, Feb 14, 2025 at 7:17=E2=80=AFPM Jonathan Bar Or <jonathanbaror@gmai=
l.com> wrote:
>
> Hi folks.
>
> Here are the CVEs assigned by MITRE:
> - CVE-2025-26721: buffer overflow in the persistent storage for file crea=
tion
> - CVE-2025-26722: buffer overflow in SquashFS symlink resolution
> - CVE-2025-26723: buffer overflow in EXT4 symlink resolution
> - CVE-2025-26724: buffer overflow in CramFS symlink resolution
> - CVE-2025-26724: buffer overflow in JFFS2 dirent parsing
>
> Best regards,
>            Jonathan
>
> On Wed, Feb 12, 2025 at 12:24=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Hello Tom,
> >
> > On 11/02/2025 at 15:29:09 -06, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
> > >> Hi Tom and the rest of the team,
> > >>
> > >> Please let me know about fix time, whether this is acknowledged and
> > >> whether you're going to request CVE IDs for those or if I should do
> > >> it.
> > >> The reason is that I found similar issues in other bootloaders, so I=
'm
> > >> trying to synchronize all of them. For what it's worth, Barebox has
> > >> similar issues and are currently fixing.
> > >
> > > Yes, these seem valid. We don't have a CVE requesting authority so if
> > > you want them, go ahead and request them. You saw Gao Xiang's respons=
e
> > > for erofs, and I'm hoping one of the squashfs maintainers will chime
> > > in.
> >
> > Either Jo=C3=A3o or me, we will have a look.
> >
> > Thanks,
> > Miqu=C3=A8l
