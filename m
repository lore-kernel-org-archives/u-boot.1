Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB4ED61021
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47DA083F32;
	Thu, 29 Jan 2026 16:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BDiRgwXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA1A83FA3; Thu, 29 Jan 2026 16:07:14 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3748483D9C
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d18d0e6d71so570243a34.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:07:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769699231; cv=none;
 d=google.com; s=arc-20240605;
 b=MdJxQ2658f4j6XVByn2KysQXkaSg6JHCUvL0E0JU90/QUqeS93K3QvoJzaPiOCjVF2
 6efwhFuUaxet5FtWQzOFawRB/4gvfLYXcPUp+VkmVig5ZQlrpSLNbATYF+IjVLp0Xj25
 yeHWpnsL7vaTa9+PcOucY0+qzU0dWHXXQqoy5pu/N3WFUSoKfrw7GWZhEG0sOMMvQNHb
 MuOv4DuV1y7+YbYQy6HbbPPeT5hXKivt6aMzbiFmpCMnRtc0IgEliCjR675yUil5ItR3
 r2FWF7Tgi4OFQvNArTZ3PWIieTZ2xMMAtgldBCKTPtYbeyG5oRKGITM2zeYBCYFfT2JK
 zFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QH4u0fgncQyYzo/hl5mZH63UpGNqQBLq5n0MV0xGayY=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=fHrtkOITP3blspMzPIntLjjbP4ESJOWuMbZOdKh9vjCYQbjRi2aQDVOfgFdVkXn9GT
 4V3yov8kBkErBMcpETX8JU6X51D5G7xULjeyNVrVEHIh61bjogwnhRrSWL2OJKfIeBuu
 W8j5JN86GJ9nSxg3VLRJPROFoMzp8m92GiRvEmZhdXffozymQi/ursPS0d+N82+n+d8B
 j8vjeAcsQkAV5UvhgfOkVo9q9J3J+a8A7L44rOsnv4hPdQ37d6eTv6Ho9f29PSAY4etj
 vbCGJOOIKllTpqllLQMbEqEQXDqHu+SSqeBFDlQdkDZL4QHxzlS/o1kzanIDTjry4N05
 1tVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769699231; x=1770304031; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH4u0fgncQyYzo/hl5mZH63UpGNqQBLq5n0MV0xGayY=;
 b=BDiRgwXdSSxwXt+sFxMYU0g2ZMMZzy5SI636K6r4qfrpFyMnVC7rEV0mxRZNTJQLWY
 irujf0YL6rhaDSIXydAZ6sOD3oeRt85YbS7CiKujFuP6fdrcbHgEXR5H7aFAwV+jeA7d
 1SB3qSI981fP8fM5DsNkjJPyExxWScgDnnWa4yyV6eKv+4GY2C+LYmFeY/6F/Val1pwe
 cOAWsjR/XHpkva17hag128gtt7YP2GPYX+M2YeaH0wAWCHL4pklGZyw3LLUyvvNgbGVT
 tTgz5O/iqivHSSdWMg0TOFmVczy8kH+cvbIDSaDs4OjW+O1LHGJ3CTCeh9q8NC3Eu5UX
 BUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769699231; x=1770304031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QH4u0fgncQyYzo/hl5mZH63UpGNqQBLq5n0MV0xGayY=;
 b=H+Za9TWBFsCoN40pZ1ptLLtDDaqbUWq7dBOCqhkWxiR/vxJIPoFpAM+azbU75awG7X
 OYEqinOz/BAT28KPFuqm0oPTr4ln1shqPaqyrrLvcGVPqC+pZEDYQFdE0n7+BY/6jDA/
 0D84vZAmyiPzQQ8QUdNgSShhLXjSRQjicRsiARCO8qXBdfPA4hXZuR8Sj5asNZV28ryk
 2j53i/x19Me4z7PussMi3dunnkEiMlPsgqoyqi2vkB7MMCHpnIfu8cWlpSXyBEFGX6Dy
 GkOpZbv3pSZJuxLL4LZ3h68bdWWwkg5T3OCvgLxfWmZW4hYc2c59CaE5JWnw9xjHn3CY
 c+og==
X-Gm-Message-State: AOJu0YzohR7reuGUI8IxAWqJYGuAPPLV4lVJrUCiuF6eU10FtSs7Ct9q
 cOys2F09FR7mDuF6Ty3NQlq9XdRQdmVjKq2sK1vVjoxIW5Ak0Da4nNU90+XZq8A/vgWtB1+ugGr
 qlA39NAz78L8FPYH33T8XDT6QcHAKoOINzhd9TKlLyw==
X-Gm-Gg: AZuq6aJdhxsrcx8Q+c5p5TQ4gBqKeVBVdLGfCFbRK/7DXLp8iwz5zfswFIRndz2szP5
 uHCHVqqfdm+CymSNGpcMGsEHqpnAoMUT7TylF7Sb7gtNN9z8oVAJu8M7qN3UYzhBk+XcQtQ/JBd
 5hN89yqxQrePZSy6OjJ3EYcDIDVjHqHJy8q59jPPk31nqixfxbW4Z6sKa93tBriS05ohWCYsMIO
 2EdhfcZDS982NeCAvU9BXnY7aUYtzMsKvGKDYa9Ad7VHjz8fQIX6mrmQor6levX4PfMy/O8
X-Received: by 2002:a05:6830:906:b0:7d1:9522:17b9 with SMTP id
 46e09a7af769-7d195221a3fmr2375210a34.22.1769699230881; Thu, 29 Jan 2026
 07:07:10 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SA4gFg8zxqs8aT4_ng9wTFLHdMO=C9b8LdtszMkcp0aWw@mail.gmail.com>
 <20260128145118.GJ3416603@bill-the-cat>
 <CAN7C2SBq+=xFH_doVfQqNFuVtjqVDCZUt3DVoB2MJJ6RMEhGgw@mail.gmail.com>
 <20260129145416.GR3416603@bill-the-cat>
In-Reply-To: <20260129145416.GR3416603@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 29 Jan 2026 23:06:59 +0800
X-Gm-Features: AZwV_Qijd5o4_JiFUJ2xMLXdiRCCBI9bdqCW_UEXsxfblkBk3l0cUVMgNSTgnMQ
Message-ID: <CAN7C2SC05Gv_WKmNA-3JpEzPUBW27KuZrMOgXdMeL1vQXS_v1Q@mail.gmail.com>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Brian wrote:
> > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Brian wrote:
> > >
> > > > Hi Tom,
> > > >
> > > > The commits after c08da5d03c2a0b72e81a11ff7ca507e3a6414db3
> > > > All Cyclone V boards are unable to boot, not sure this patch is the=
 fix?
> > >
> >
> > Hi Tom,
> >
> > > Yes, those commits were unintentional and have been reverted.
> >
> > Had tested the last commit 6a1bdb7e952d5841f42742fefa907cae5dc8d50a
> > Same situation that the boards are unable to enter the SPL phase.
> > The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec works properly.
> > After that things are broken.
>
> Please give
> https://patchwork.ozlabs.org/project/uboot/patch/20260129035512.639362-1-=
marek.vasut+renesas@mailbox.org/
> a try as I think it might have been working before by alignment luck
> rather than design.

Hi Tom,

It is the revert itself that is broken.
I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2


U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 29 2026 - 22:56:17 +0800)
Trying to boot from MMC1

Which revert is correct.

But once dc2d8423b19d30472b02e02b41504226908a4291
And revert to 431f1ce46bbffff0db8f03437a34400b11b30175

Then all these broken I don't understand why even file diff cannot
show any changes.

Do you mean the revert is broken and fixed by alignment?

Thanks

>
> --
> Tom
