Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF85C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 07:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D228860D;
	Fri, 23 Aug 2024 09:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gZFtMIbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF1C88670; Fri, 23 Aug 2024 09:50:57 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E928852E
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 09:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5dca00a72easo1282822eaf.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 00:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724399454; x=1725004254; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GFEMU9lR1Yha7FuFiBaJJB/faj42JwL5wN6nuK2K5yk=;
 b=gZFtMIbFoOXeqS1FJnGI8i1fK41Itc4GFqQwbJRiCFJo2/IKCxA4/9kXkrj6VB/R5c
 uuPy8srUY8h03OG7vsTTh/4Rrt+/sJewM832Pyeakeq611ZZTHfoL7pYRoLAeRha9Hda
 yR6Mv9zgR8e21bBlzu7bMYmCwdSQHnqxmKlA0wikr0fGsq0YLIunQeIlEHPLHYCLVJEf
 WwAHxZAikxCyuXHF/C6Ls25P/UhDEHfg8nSIoj3y3DSpLWZ11A0LLbHwP3KpWeAcnCDn
 GZMGBvTbFhKWBOhxG+VtSMZ8tIX9JrktZxQHtU/HFjDHlq25MaMO+kkgm1WfDJL6jvdw
 duEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724399454; x=1725004254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GFEMU9lR1Yha7FuFiBaJJB/faj42JwL5wN6nuK2K5yk=;
 b=iD3sQlLmjjbXZr3NlwSZWQ/yTuFVxLIIrcqA4qUw4TUl1RZkBbNG5O7P46AC/Kr4ua
 4rqWmnvQcAZoAho09u7JYqIV3jE8Zve9GB7grXO2/ZT6SnzXPe51CB/YHYXhMKaCrwzT
 Qn6CnN9znrLPsX4dRERMqOL6zTnlAk0WXZc8DuV7i7h6YqlvvJcWqYZFpDvTI8t1w0DS
 9GuXYxEEuWsAY1FZsdwVgzYrH5mgCAMiOdzweDi0PaubJSReUp2zZwPZj60TK8deQom6
 +VdDJO3Bo8qbbj4cgd7y1eHbXIi+vSZvA4tWdRa0I3BzxcHhptDkmNdo5hdG2/Vewobx
 uGug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvtt7BTvLuBI8Ecx7T9CYr0p4ucQeRE7eoXYkldOeFduND9Y6aJ9Ufblsr6To5o3at5ROCW7s=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9rAU/NzPCqHMCvDf5L4PrFETbwIp5/gvco9jj2dhWyooNi9GQ
 PX6ncRe2HXHI4MRHpoDYpob+iBj6L9DVvVIENydsCT7fDfg28bANyxVIElg1MGKh9OZOUBTkvWR
 dR9JJFSP69WpzVUU57mEYT3cPLJk=
X-Google-Smtp-Source: AGHT+IFg9egkKyvrAa6gKwHP+COGLJv9hfmbcdf7qq1OC7UgukYr7zTSsXlKCSerskQ5QRhSopRrdIIv9v8ypCLEA9o=
X-Received: by 2002:a05:6871:582a:b0:270:62ba:ff5c with SMTP id
 586e51a60fabf-273e64dfb40mr1546523fac.25.1724399454377; Fri, 23 Aug 2024
 00:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20240822102010epcas1p434e5a447b002e8bdea5423a034c2e444@epcas1p4.samsung.com>
 <118b01daf47c$de3b9620$9ab2c260$@samsung.com>
 <20240822215429.GX1626301@bill-the-cat>
In-Reply-To: <20240822215429.GX1626301@bill-the-cat>
From: Minkyu Kang <promsoft@gmail.com>
Date: Fri, 23 Aug 2024 16:50:42 +0900
Message-ID: <CALrBrZ016Ba7MkA3cYNdg3qyRokuSEAqPWUgT=kujCfUQVrdZg@mail.gmail.com>
Subject: Re: Please pull u-boot-samsung master
To: Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Fri, 23 Aug 2024 at 07:11, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Aug 22, 2024 at 07:20:10PM +0900, Minkyu Kang wrote:
>
> > Dear Tom,
> >
> > The following changes since commit
> d51764417dc37ead471a5597f7815ae455e84ea3:
> >
> >   am335x_hs_evm_spi_defconfig: Add MAINTAINERS entry (2024-08-15 16:07:45
> > -0600)
> >
> > are available in the git repository at:
> >
> >   git@source.denx.de:u-boot/custodians/u-boot-samsung.git master
> >
> > for you to fetch changes up to 25a972368cf926b4d70c22a2de65d959774d5cc5:
> >
> >   doc: samsung: Mention enabled eMMC in E850-96 board doc (2024-08-19
> > 16:09:06 +0900)
> >
>
> Given the point in the release cycle, I've applied to u-boot/next
> instead, thanks.
>
> --
> Tom
>

All right,  thanks.

-- 
Thanks,
Minkyu Kang.
