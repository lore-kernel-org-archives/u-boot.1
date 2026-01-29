Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735EDD46C19
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 02:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F12183BDD;
	Thu, 29 Jan 2026 03:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BDYj8rgx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD5283C02; Thu, 29 Jan 2026 03:58:35 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3441183A8E
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 03:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d19d3c7208so12587a34.0
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 18:58:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769655512; cv=none;
 d=google.com; s=arc-20240605;
 b=dzwS40PK+syDM3AAxH0nMKcBO5s53TVcv98fXgkOFzEdMMEuPWRSA6PvLrUNuqe2bA
 Al3xzfU1BKTQ+Y+tGv5xXCdVjU6hatRtpzV9jiJ31N+v+b/RD1eZLtR7NOatSy0o7X29
 XgEzI/UsUdA16f1Zci25JA6+Lc5SkZYl61xBTlRJa6bxgsyhZls8q9bUjwPjowklkw3k
 upxw3Q/Ph5FCtbOU4VL+Sw9YzpHylXgBnAzO6e68XlS7PZe9xs2q3mn7VmsgY4yiyuQr
 3ePJPyDDD0qLMaMklnQyU1JmwmNW0+D+yDuhq3bqLXZOixGrRsMXInVOxlpAj3E+62/A
 hMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ko2IUomL8hWi8sPz8lWdE7MPiZuRiY7apHVe+1XU7xg=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=diMJXBdeG0RUP6Q+Cf6SD8RRrou69kzXnbrg/D/2lHNgnEPF0Swf/8Tzd3MjdalsRh
 UN62KIVC7Id5Z8z9+D5JLk+luhtmRgCyy5ZFOdVxIVqoA6+EnYQoEUDtsb/SuQGz4aTf
 R+6gdktJgiJz2Hz+CA9zcPrqcfzBnnLpg72rj0SUj+y4UFPaNWs/he0kkWyBMVFg6sTG
 MH2uT9/7FLUH7At16SVpdGpMPs1G2YWz7y57xX5mMau6UUv+NxhGv0yHZqd+KSQ41+pc
 sGM2Mf+mClyoSUYzhDc2Pf9wuTPHLo43y+zlJyrye/UDar7cU2B7aZJAZ3qRTc9T/V15
 A1QQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769655512; x=1770260312; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ko2IUomL8hWi8sPz8lWdE7MPiZuRiY7apHVe+1XU7xg=;
 b=BDYj8rgxJ1obO92i7TjwmDScRZX5BTnpaMvZJNpwi32dyneBtbyjCReGh1hthpCxDI
 u691f88JZGf+tjMlJEo8JbUVv5f9wdy4U/dqyfSdaeA5MNf0jl1ViE2T+ABG5B1JECYG
 rKPmBpu89i8Ic3e5CdyGz6oAwOa96NAjYWYg6B5FIirB+RnfEAUSBC6d3/PG/ScMfG91
 mW6qiDRxIzUtY942c7/4//CfrYoXBRRakWyVikMZI4HJFNJU1BNTcvuGErJrDhRZ1RdM
 0XQ3SyTrRGJBfzhyStIkYrD8xHszdfzBWfcl4wzXJClpRywWkQG7n0CxXfsZf5gh53ps
 z18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769655512; x=1770260312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ko2IUomL8hWi8sPz8lWdE7MPiZuRiY7apHVe+1XU7xg=;
 b=A46pxZWYa130jYiR/gKM3MjNpZZiP2bLJ3D8qc66o4f9S4/fT+GFF8jo10Z8eNHaEx
 SuCb9NYHiOH0SHqPLyBEGTdHlxVCPkat8+8ZkgnWGTSZFmZDHnbSPaItyXRYdVjJ9FET
 q0h2Y2F+7nDYMQHEbYJABZCNiZMxYT6PJFlQwB4KO7PDqgh7zObuI3mTWlxgeK7c4FV/
 O9xmt5gBmskxNFz09Xwv3lC24cSrKZe12f9ZD80EMbZQ4kVoYhMPp7LsbCZHKc4tObz/
 D9vNB2hQ6A2C1L269IfoTkrMO9pFL0wRymfIyNd+stvwa7Od7TFDpWhloYIKi5n6JIG2
 jNHg==
X-Gm-Message-State: AOJu0Yw5mdTPBLKNXQneEGOfPw5CF/QwtHAyXI5/4RQ81Suq59PEwZVQ
 j6hZtY8kfVZHPkYdTcMskmlpXQKjKj2IKGO2tMEA5HnBlC62Gvv1AhoEHcRqrgJXtZ3iLySYVun
 zfMV6TP4BbG8fUKhqdQ+V98RLfgRvh8qiUDEjXNDWNA==
X-Gm-Gg: AZuq6aIRc8hXl1cjcMOFeUvOckP/402Pp7/pK8SvqvrWKf2StktFf609vyM5OO/s+x8
 PNws37FFP2bOyxZDBKZA3eTz+6MsfY8DzXUwnv8FCtU296DMn/D6MiQH8vYm/ZWX12HitX9oxAY
 ZZnA6ljRp/kT1qFLYwxDPiAhEvrv9EGceqWXwoIfWQN3UO9y3HOpS4Uhmd1rMpOH7ADMLQX8irS
 Ab2GQKPF540wiGiOoXSBHNuXVIt6Mx0ejxRzcsJCkgsOFkd/ryKcd/+9aq9E2AMnKxrYNw/
X-Received: by 2002:a05:6830:6310:b0:7cf:e4a1:8a9d with SMTP id
 46e09a7af769-7d185006f90mr5334427a34.14.1769655511888; Wed, 28 Jan 2026
 18:58:31 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SA4gFg8zxqs8aT4_ng9wTFLHdMO=C9b8LdtszMkcp0aWw@mail.gmail.com>
 <20260128145118.GJ3416603@bill-the-cat>
In-Reply-To: <20260128145118.GJ3416603@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 29 Jan 2026 10:58:21 +0800
X-Gm-Features: AZwV_QgV-_3_QVgSCFSoE-6acHKWiVUmvd7c9c1rABu1RIYTfKzfJy88yyg5VZo
Message-ID: <CAN7C2SBq+=xFH_doVfQqNFuVtjqVDCZUt3DVoB2MJJ6RMEhGgw@mail.gmail.com>
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

On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Brian wrote:
>
> > Hi Tom,
> >
> > The commits after c08da5d03c2a0b72e81a11ff7ca507e3a6414db3
> > All Cyclone V boards are unable to boot, not sure this patch is the fix=
?
>

Hi Tom,

> Yes, those commits were unintentional and have been reverted.

Had tested the last commit 6a1bdb7e952d5841f42742fefa907cae5dc8d50a
Same situation that the boards are unable to enter the SPL phase.
The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec works properly.
After that things are broken.

Thanks
>
> --
> Tom
