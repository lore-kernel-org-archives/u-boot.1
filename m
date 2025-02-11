Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD21AC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 20:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA21809D0;
	Tue, 11 Feb 2025 21:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GhCCH117";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15F9D80A55; Tue, 11 Feb 2025 17:26:53 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87DC3806FE
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 17:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathanbaror@gmail.com
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-520349fc3ddso988725e0c.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 08:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739291209; x=1739896009; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wi+ump/MfCur6IZzFvvLwGZPl6m86RL9j0ArclMdnEY=;
 b=GhCCH1178THJbepodfnKd5uvQK9y0xDRUglXMdA5OMROlE7H++0ZA6S65qY/AJ8P7p
 uR/w+lS11IvXiEzH1lDAC6H9Wp9b/aOLyXeR0tcICpXpe1z5ZqejXwFh8H0Bd42eQl8x
 A1EbCsz9YR6duvJbvd+y81Hzy/eFUmld5NAQWgmZwPmGvIAgFgjjSGuSNOoxfXUgiXp5
 4TQ+mwpHE2yqXpamJH6jJq6ojQmRBla23MSKs4qmAkvJA3ppcY+DiGEDMxAZcNlWj+tA
 wKoKxlKClRXwNizsIKKD2RqhJwi6pBDoKJqInqPwG3Oa7bx/GUA1KgiUuSZtiE93sc8O
 v6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291209; x=1739896009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wi+ump/MfCur6IZzFvvLwGZPl6m86RL9j0ArclMdnEY=;
 b=q2iQf5XzW1bmJ2ya+r5bhka0hwSL6+WEOI/bj/ziK9ybLsS4PoKM/MzwPfYbMavvUr
 ClQfupzVwDSMRIDTO8WWIta5TA+BdFvhyUpu8GwzWxmFIve/g7qNfLPWYpO19nlq1GVH
 7Wbv3W5plnP6DYhtLlYkPiyRhng+GLAALKBm8+AhOaXAY1inQ6YANsuXO2aDajFEc3hS
 c3GeM92KZX6whf0tlQ1iwrhUrsINJdCQofmx1CfOf5rjCVnSRULQIUUGqZpBWA3z2gYV
 VhnjGeClhRHaqFPmNaC6483mYoF1eY8OlThAz4ppDSPnwPQis1n8BzhKNdj7I9iP6369
 Hvlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6RGLp1M5RzPq6CIcZcLgDqdBtvAOY0n3YqkvXIJcDuchR87XzS1iTzyX8UikpM3a9MyU+kVk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxwxgz0rAMOa7KmetHlWcb8PRAwASW79bMVniWcLm2UrNOvMR1L
 jWRZGm0aN9wfe9GPdEFuYI9Vw1Yo2SMVyHjCEQfhl6UO8OHf7VlWyJCQ7FYAv6+04P5aIYc5zuS
 dvjP3QvrksBT2/5/6kWbzSokWqo8=
X-Gm-Gg: ASbGncsmMbwNvVR8lx/xc3J1haSnXDBzdJkwervDUpVWOsK8t/NDL6Ks4nAs2f3KV5F
 xsWQHf7m4jMkV1hH2BLnbCPEmd/U4v33oP8zsvotUTnk0G7vH01htbj3ONP4//NiBzrswXqRKQ1
 xJt0eP/hJ8wmCJoJJ2D33JSgPVB91U
X-Google-Smtp-Source: AGHT+IG7ldC5YdinnSrhBGWmb37qbqOZ+zAj0J+/Ta93EcOW2DuNgQbXwZHkgroISIVsVimtpH5D4kkMhxWVkkd/LBM=
X-Received: by 2002:a05:6122:1d8c:b0:520:5a87:66eb with SMTP id
 71dfb90a1353d-52067b755c1mr215494e0c.3.1739291209303; Tue, 11 Feb 2025
 08:26:49 -0800 (PST)
MIME-Version: 1.0
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
 <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
In-Reply-To: <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Tue, 11 Feb 2025 08:26:37 -0800
X-Gm-Features: AWEUYZmF5t_mzkCXCoy_PA9qmB_PJgoYreUfTd2BwD0dYWohRtUpZjbdtVChG9g
Message-ID: <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Tom Rini <trini@konsulko.com>, Huang Jianan <jnhuang95@gmail.com>, 
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de, 
 linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 11 Feb 2025 21:26:06 +0100
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

Hi Tom and the rest of the team,

Please let me know about fix time, whether this is acknowledged and
whether you're going to request CVE IDs for those or if I should do
it.
The reason is that I found similar issues in other bootloaders, so I'm
trying to synchronize all of them. For what it's worth, Barebox has
similar issues and are currently fixing.

Best regards,
             Jonathan

On Mon, Feb 10, 2025 at 7:51=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Tom,
>
> On 2025/2/11 00:41, Tom Rini wrote:
> > On Fri, Feb 07, 2025 at 09:53:01AM -0800, Jonathan Bar Or wrote:
> >
> >> Thank you.
> >>
> >> So, I'm attaching my findings in a md file - see attachment.
> >> All of those could be avoided by using safe math, such as
> >> __builtin_mul_overflow and __builtin_add_overflow, which are used in s=
ome
> >> modules in Das-U-Boot.
> >> There are many cases where seemingly unsafe addition and multiplicatio=
n can
> >> cause integer overflows, but not all are exploitable - I believe the o=
nes I
> >> report here are.
> >>
> >> Let me know your thoughts.
> >
> > Adding in the eorfs and squashfs maintainers..
> >
> >>
> >> Best regards,
> >>              Jonathan
> >>
> >> On Fri, Feb 7, 2025 at 7:50=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> >>
> >>> On Thu, Feb 06, 2025 at 07:47:54PM -0800, Jonathan Bar Or wrote:
> >>>
> >>>> Dear U-boot maintainers,
> >>>>
> >>>> What is the best way of reporting security vulnerabilities (memory
> >>>> corruption issues) to Das-U-Boot? Is there a PGP key I should be usi=
ng?
> >>>> I have 4 issues that I think are worth fixing (with very easy fixes)=
.
> >>>>
> >>>> Best regards,
> >>>>              Jonathan
> >>>
> >>> Hey. As per https://docs.u-boot.org/en/latest/develop/security.html
> >>> please post them to the list in public. If you have possible solution=
s
> >>> for them as well that's even better. Thanks!
> >>>
> >>> --
> >>> Tom
> >>>
> >
> >> Filesystem-based Das-U-Boot issues.
> >>
> >> =3D=3D erofs
> >>
> >> =3D=3D=3D Integer overflow leading to buffer overflow in symlink resol=
ution
> >> In file `fs.c`, when resolving symlinks, the function `erofs_off_t` ge=
ts an `erofs_inode` argument and performs a lookup on the symlink.
> >> The function blindly trusts the `i_size` member of the input as such:
> >>
> >> ```c
> >>      size_t len =3D vi->i_size;
> >>      char *target;
> >>      int err;
> >>
> >>      target =3D malloc(len + 1);
> >>      if (!target)
> >>              return -ENOMEM;
> >>      target[len] =3D '\0';
> >>
> >>      err =3D erofs_pread(vi, target, len, 0);
> >>      if (err)
> >>              goto err_out;
> >> ```
> >>
> >> The `erofs_inode` structure's `i_size` member is defined with the type=
 `erofs_off_t` (which is a 64-bit unsigned integer).
> >> Thereofre, if supplied as 0xFFFFFFFFFFFFFFFF, the `len + 1` input to `=
malloc` would overflow to 0, allocating a chunk with 0.
> >> That chunk (saved in `target`) is later written with `erofs_pread`, ov=
erriding the chunk with partial data controlled by an attacker.
> >> Therefore, we will have a heap buffer overflow due to an integer overf=
low in `len` calculation.
>
> Yeah, it's a corner case, I will try to address it later.
>
> Thanks,
> Gao Xiang
