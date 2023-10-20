Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BFBCDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 03:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87BA871DA;
	Fri, 20 Oct 2023 05:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OpimjgF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A16871DA; Fri, 20 Oct 2023 05:17:55 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C332487033
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 05:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2739c8862d2so87671a91.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697771871; x=1698376671; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JlYbI2KFCLRDJu87JGHAuPHHmzvo1KSZ6O/AvLi/yy8=;
 b=OpimjgF3SapS9oF95HgkahY4iUEZTDz2VLnnVUT+fnRVQ34FMvM+nqpLvpc/5zjoZO
 qWQPylnw4EEz+VjPqK8LiiOI/9Qcy0BLKu5ckDkit3B6UH5PjUP1paoECtR9uH5Jyyg7
 Wk20jemniJ/N7vEG+CQ/vftQZQxEDVlX90cSYOX9qDuYKDpbHb7de2hq6Ul8E3FcZUDb
 Nw9Jh7Wg/7KKpu2665XH8kQPx6eNjMvfF8HupWbSUhjiPEQkSH/vc6ty8ox/bA4jTpsv
 82kmGUxuNEJ7sXkhwc+F4yj0jf26MpxDFvyVJplPvppGIzD3Wj0VA9XRkbVfzBUpGHqb
 O7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697771871; x=1698376671;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JlYbI2KFCLRDJu87JGHAuPHHmzvo1KSZ6O/AvLi/yy8=;
 b=P6keKEcKAhI0ReHDNTOjjQc++0A+H/shdJd7f8MyZVSlUvkThq6rxKUb34bC/ks3pJ
 /BR5uTProov5zrpvm0dmz+aUheIAvYW80Q6MM/jO4Pc04RFBU69JP0b81T3PXOO1Wn6o
 1VG8sEl3lWV10dbwYruEGyiiAumsvD4us8kVH6uS2JZcZqoDa5n8qiD9NWgDcnYKHrQe
 r9Q9TbkSUmPyAFEqctgWDcYUYWHftS0f7W0O2BWO8iqDdetxERjT1v1Xy28SKtUZ5k8W
 NXNx/Y2FdpXzfwXWjukZ/X7MjfRWaQEiXQ4j2tdaJ+HpSEDnTQm8k6CZ7C3Z/tjhX0Zo
 EVhQ==
X-Gm-Message-State: AOJu0YzB/XP43mxG5dTaAiaT8g6026evH7dNKVDTLf12B+1EV4LQFDSM
 2BERnvPAVzGZg8IJD5xfGaj8nBFETBDEs5FS8cs=
X-Google-Smtp-Source: AGHT+IHLQD6xtOHB6BJUTjmNcvB8AixRD4P6geGVhJQZmXVBXKCDyiMsLOgd649deSs7aTHUIcQIYbZGplFBsm1Nm2I=
X-Received: by 2002:a05:6a20:c188:b0:15a:2c0b:6c81 with SMTP id
 bg8-20020a056a20c18800b0015a2c0b6c81mr763767pzb.3.1697771871089; Thu, 19 Oct
 2023 20:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAMwbjeWur3uKY0fV89PqdrSB7t_e=3Osot6DAocrhA57PCf_UQ@mail.gmail.com>
In-Reply-To: <CAMwbjeWur3uKY0fV89PqdrSB7t_e=3Osot6DAocrhA57PCf_UQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 20 Oct 2023 00:17:39 -0300
Message-ID: <CAOMZO5DL0C0DPhwU51gcxGq163pyZ5i+Wp0+WLORH4nvgxn-7Q@mail.gmail.com>
Subject: Re: Branches in uboot-imx
To: Grzegorz Borowiak <gborowiak@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Grzegorz,

On Thu, Oct 19, 2023 at 11:58=E2=80=AFAM Grzegorz Borowiak <gborowiak@gmail=
.com> wrote:
>
> Hello!
>
> I just cloned the repository:
>
> https://github.com/nxp-imx/uboot-imx

This is a U-Boot fork maintained by NXP.

Only NXP can help you with this one.

> and I encountered a rather large amount of branches (listed below).
>
> Are these branches somehow described, so I could read what they are about=
?
> Especially I'm interested in branches whose names begin with "imx" and
> "lf". What are differences between them, and how are they different from
> branches here:
>
> https://github.com/u-boot/u-boot

This is the mainline repo, which is developed by the U-Boot community.

i.MX SoCs are well supported in mainline U-Boot, so give it a try with
mainline :-)
