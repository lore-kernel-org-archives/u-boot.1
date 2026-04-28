Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3CCFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E72698426E;
	Tue, 28 Apr 2026 16:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MJcNIzuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967FE842C7; Tue, 28 Apr 2026 16:34:05 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD2E84255
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbe437b072so6555424a34.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777386842; cv=none;
 d=google.com; s=arc-20240605;
 b=aFNunH+4nW6Zg0Xa0oir4lqEai5xE7QJ7gokqdW+pJhJboHLDhJKf4MxMf4k5PlYd+
 dHCd0TrXqZW2mIsWJU1+2wOe55A1059vYCzIOhW46/nZaDN0JUtJNoWgKRi4JeaoXFmG
 ADxVghjsNj/98e1tx4lxCTgqwkt4Shmrh4zBKCDruzCZuYvECxjN7xdeRGIQh5g3Dkx5
 fwQHUJTPyopXKjEFfBfb3fNHPRVgLpnKBsNksO/JAi3hSMaccLmpE76l6U255P4tQkyR
 ta+wxYOLzWdlUXGaEzIKaf23pyZ7qKOwrhvXYD81cnVeDoJgFrxVE5fPu0sHFvVpTy5H
 xIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ex3pL7sstC6XQWeR9NibKcG1hxhEdJJ9DoIshOMOmEo=;
 fh=hxgwr6lottpQV6gabjiqtX7m958ne43urJfyaoL4cZk=;
 b=XTnswy2tLziXgKeie0jUtXs3PD8MqVN5NcXubTkZb+I+MeM808ZFXWyeDxQkpPqiuD
 YVewSupHvw5FIQqFJz0JBzJ2AfAsvPK+TJd/yQTnKuRG4L6vkr0+D+9d61/CUv041sFU
 b7prh3JYXKEutwQfI/xLQOGHRSXjbROOZz5PpRxSdu1ZYMUzIBf2ZySQ+/yHwZuRscr+
 E4tXOQGheinXMaF2LDGB7qUtfUquTmIzYqAtUpSwU+6c/D/Va0BZ0QMlUYmx4FcfbgzI
 jK0AEdOQanNHbmdd/2ZLH5VeyAgumcKn5R1XJblrUJfqGlzAEM+SZ/wDVYbNcoulyxtl
 YPbw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777386842; x=1777991642; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ex3pL7sstC6XQWeR9NibKcG1hxhEdJJ9DoIshOMOmEo=;
 b=MJcNIzuNAkq7GYV5MtJcMWWIt+0utm/U3M6Uahcj8lCLZVjYLr4Gz/3790dVhJgZY2
 qZPMI+EHD0Ia3f0xlG+6WxTNSJPtfFB4YzPm2i1HgQ+zYE4Uy0Ll57xNhJVI7lshPQns
 iF6cdwIvStQB1PABz00nnT7oPBP3gr2rtVvkDCc3W7QrC/79CqhhiQJ7zHf0dk+AQO+9
 ubJQn99H+HdSXi3K6uVznYCK/MfWYHlr3SgMTchEold4Y5eNh1yLEB1v0SxDUb3Yf+IR
 XE3vfpJaXs8REHneqJXQkIfmbimN5Ejd3IAd8t0AdLAs3r4etQqDeQQpg5cCJB5Lm/hG
 OKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777386842; x=1777991642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ex3pL7sstC6XQWeR9NibKcG1hxhEdJJ9DoIshOMOmEo=;
 b=JZlsxDREa23JJWY8TY+2jKZTyfL9eoDZAtREF1kpu7fWN+lMcBFKjOm3VeZLlTh2hk
 egBxKBFFkK9hFp2DcRVHSyVPYM8d9W0p12Ys63Ai1IoU/60gRI+z1vXZ0duUhRImf3S2
 3t4rz+LBf3zNgOgjOYjb5XXiGHzl2TFBUdJybq31SSF296iZ08/Hm25dJ3mLJUimzMam
 zvwb4E3yQJ54SehymuG3R5gFmrXcBYLsTni4zw4C6Cre1eq0Tf2u1U2NQ7i7/vwcgDKT
 6SpMqdeomDJbx+bfiaNa3Z+hjXti6eLV82xdcmxiUftuWKPW+2wYgvPqIQg0XHAF6bos
 z3Gw==
X-Gm-Message-State: AOJu0YyjQu4j6ZB3iunsvWXB5qW/yNCJ6JvZfpJwDPzF6NrGwKBrbJjm
 3g6ea+QnYgXqkKkQxFCScGh8wkMk9+/wliYQOsz+CQDH0gIBw2bDEYolcZ+3+ixXuM7yloM+KsJ
 B6i0Tf5fOuA+u3K10Ikx3SYAF7N//9GQ87GPG2+w=
X-Gm-Gg: AeBDieu+VYHFTDwqd/9YeSsPoDOszikKyjmbksSHJZL+iWDpIeiDP0Dw+qGRUIQTy+P
 kACDYg8Hi0G7b8sGeoR1zvnG8bXuXxZGqgMZKwB/w57cAO1TYaFCWOwtajbX5rJaa3g2bjS65Mz
 wmyleOdEIea1JMrUDpa2ggzMMUaQ5O8+IXPMF2RAHWbcRSOYVujUPtk+mg1LqBsF/uh2n78I7zN
 869BeXD6/ugGkDH6E/AgzRxryhzoGjZ8N6F3w3lvavFINfP73dtpiaFwal/5mE5rPeMCN98CaNh
 Jr/LvEWqg4Fw3TBzAc8=
X-Received: by 2002:a05:6830:264a:b0:7dc:c7aa:22c7 with SMTP id
 46e09a7af769-7de99c5261dmr1980267a34.0.1777386841464; Tue, 28 Apr 2026
 07:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260423042824.3480-1-briansune@gmail.com>
 <CAFLszThg=EamyRohxNA7V+nk+OMVK356nUjAVSbu4+kokOJpdA@mail.gmail.com>
In-Reply-To: <CAFLszThg=EamyRohxNA7V+nk+OMVK356nUjAVSbu4+kokOJpdA@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 28 Apr 2026 22:33:49 +0800
X-Gm-Features: AVHnY4LVI_lrJV14Y91ulvIU4tsnepHMmwwJpibvB3I5mIMrda9T-l5oVOQ3kXY
Message-ID: <CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNwsHAhdmY3Q@mail.gmail.com>
Subject: Re: [PATCH v6] Improve handoff prepare on SoCFPGA
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Chee Tien Fong <tien.fong.chee@altera.com>, 
 Tom Rini <trini@konsulko.com>
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

On Tue, Apr 28, 2026 at 10:04=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Brian,
>
> On 2026-04-23T04:28:24, Sune Brian <briansune@gmail.com> wrote:
> > Improve handoff prepare on SoCFPGA
> >
> > Ensure qts folder header files are properly updated by isolating
> > the Python execution environment. This prevents partial or failed
> > script runs from corrupting the target directory.
> >
> > Changelog v5 -> v6:
> >  - Clean HANDOFF_KEEP comments.
> >
> > Changelog v4 -> v5:
> >  - Change HANDOFF_KEEP condition to if [ '$${HANDOFF_KEEP:-0}' !=3D '0'=
 ]
> >  - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
> >
> > Changes:
> >  - Implement a temp folder for Python script execution.
> >  - Clean temp folder automatically despite execution failures.
> >  - Gate the file replacement process on the successful exit of
> >    the Python scripts.
> >  - Execute the replacement (with or without keep) only upon script
> >    success via the NEW HANDOFF_KEEP=3Dxxx variable.
> > [...]
> >
> > arch/arm/mach-socfpga/config.mk | 39 ++++++++++++++++++++++++++++++++++=
++---
> >  1 file changed, 36 insertions(+), 3 deletions(-)
>


Dear Simon,

B.C. the server is down and I don't expect Google to have an auto fail
mailing recovery.

> I see 6 copies of this v6 patch in patchwork, so I wonder if I got the
> right one?

I will try to respond to this email as politely as possible.
Please reference from "patchwork.ozlabs.org" list.

> The per-version changelogs belong below the '---' separator, not in
> the commit body. Also U-Boot convention is 'Changes in vN:' rather
> than 'Changelog vN -> vN+1:'.
>
> You could try using 'patman' which will get this right for you automatica=
lly:
>
> https://docs.u-boot.org/en/latest/develop/patman.html
>

1) I only do basic software
2) I used ./script/checkpatch.pl There are no errors, warnings etc.
3) There is nothing to do with the patch itself either the software
nor the file itself.
4) I am not too familiar with patman
5) There are many better things to do rather than complaining about
the patch headers.

So forgive me I really don't give a damn on whatever the header requirement=
s.
If you feel this is not passing the patch standard simply reject or
label all patches to
"Changes Requested".

With all respect,
Brian

>
> Regards,
> Simon
