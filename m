Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA287CCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 791B680D56;
	Mon, 19 Oct 2026 13:15:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vDQgR6OvRYM5; Mon, 19 Oct 2026 13:15:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C83AD80DB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415728;
	b=L7QVCT+vjIAf3pLGZyrrGoEOSkY8PrSNiTGuK5xt/TDPuEB3ZRmG5VMDCSkunv78Rl4H
	 tm7jltNem7Qs1gFFc8G5aATBWtBVtv2B+Esl9L8Uieh110hDrAwpbRViuR8uvWXw8i5IW
	 Qd7/iD4tx+M43weX/zkurk9aR6kG7XDlOHPwRyTFZph9HzBYzHMZhYD3ufgfeOSVhqMAy
	 E4EhaMDZg0aw+IDgZ5Fvn9tfA2V4vngobwPBsWOj87RqzjNswsSQ4lVL6JiX70swrBHZr
	 dRea+BDGBRQwRHEJh3VGTEMNY9w7AOpDY+XXHEO3dgvH52WnKcRwiJihXwd1FfIQAhw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792415728;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NadFwaJmWjUnYFRvhovnjA4XPHnu8+u8BImrZwwCRI8=;
	b=gsL2GJ7UAsgfc55WH1JYMyKNqFtYC244Eh9Z60O9ajPJZC03YaUY9CxeyE8UmdPlghwS
	 rAZMJj92JsaWrw0BJRDdl9jv7uUTZDq+IWs7Gzkhim5saMev37U9u2xoZbhR7WSkAFxpK
	 5xIw2sR9lxOjgpERixItNLKrbcYnBt0uB0WNWu4Lg5De7ng/OPOctJ9/L+UPhI1ZHFr2B
	 vwviyF1XNg+pJENKSwrWqUC+zMgcpaUDuBIJLuners36nWQnL1SmZA4zWb5jnLFsSFX/N
	 j/RuZG564nlIDgPNhzIhV+JzNJy7Vy45u8zWt97nm92gMdrjY3lnCBGCgYHsOuNP9Kg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792415727;
	bh=NadFwaJmWjUnYFRvhovnjA4XPHnu8+u8BImrZwwCRI8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZMgEudhnX+kmBX/hL6NrjoH9Lox3wHeL4QtiAUb8UOpoAmFa4WwfmjSKoqXp1UxQk
	 ZimUsI+L9yr1fnvgMwjdSRpsh2GOhVK5aTRXfVjo1hjzGUQYWZzbd37PcnikkB13Qx
	 z0gp13DsvjYa0qg88z1xUxofbZ+VHs8lVYcX2T92g6lMNUAb9m5cg9nD160E2/U2OG
	 e19hai3HWbi76W+vqqBlwp1U8231ZBirbsDdhjOLyM69/PH2dHCf1k2uU7TDhEBCIa
	 SVmX3SOkJ9+mvT5sGy5eziqunSXh1lzLw7YxAQzG670PwmOYEs/Y0eSr2+UjCJlq/w
	 6AVZYRHvGu32Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C83AD80DB0;
	Mon, 19 Oct 2026 13:15:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9394523A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 855A26063F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f8lhOkeu7b0u for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:15:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 66A0F605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415725;
 b=CaXa2j7Ge/9f0CPtDBdtozUI470/hwWyblUFbSN61HFln83sM1eQdweN30FkUgP9gjcD
 nuTTHz3VMmIK95SphmdkQzYzl84rGI2TdIHTdTLIzPSBqH6qP+Ndk/omAEyvbYErvGmWs
 lUW9uPfwSM9v3drSBInCTsz8Ui7L4y1iPUPOS8fIGD1f+fw4a0eneETs+xkVvZuJeSmgg
 FqgfpZ5SEqwOUJrmzgsipXc7VDCH3T0/2d8PiaMsPADzz56ZIkzzx77cTXaVSuQxHPNZy
 OHPHxxgPldfWByF4XT4Q0YMWKIKqkbnxdRv/mExaj4MQUaWZxijSwxZCeTdyGwy93Ow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792415725;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=NadFwaJmWjUnYFRvhovnjA4XPHnu8+u8BImrZwwCRI8=;
 b=oKvE9dJfa2F4eqLZOgGQxM21tRNU3niAuMFNoUf2081842qC1x0ZGpe5919fGxVvgIXI
 GQctjR6zzECZKtBEaRc0O6YH7OLAWXzBkQ6yJ5/SmzbfmUrqGvLVst0bF8cXJLt3s8vK8
 SQgcHHLHKCcBkH+V9fLM76GAUBmgaIePEm1JGu796EeBUcGLIDLgObOrnvD7sNAQu/Tig
 W+5y5+A7YHTja7ckE0qIQb6J/frKPb1EHbJHk7RfJXQUtpJ2UyFufLh0em0WQS56YvzRJ
 OtzRitXhSU7x/Mv4LhCRmhqT3Zi+d4KpqjILTGJMkDF816BZJ0WkopU1ap8QFhtMYMQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lY1FtZ5Y; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lY1FtZ5Y
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66A0F605FC
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:25 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so2790527a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415723; cv=none;
 d=google.com; s=arc-20260327;
 b=Z+qhRlqX6rSVP3OV1tQQsfuYtR4HWwVx7t/iiv1Ls7RwPfHgjhtqMZsI8TpFhCUMzv
 /6Q+Kk3/D4LuYnj82752UVTRLRzGxWxjJ+vOc6FHBbb7300W+w2R2aVCJNchtX25YBdh
 im5tBV0+peZVAawzlm/GbqAAIZwYr+dEU21Y8dB+F2O4gT0Bqan4J3VO++5omaQSjk5C
 hByvn9jY/Jzzi7x54HesPxTE+h/2cxV0sYLNJu9IblKF4jdi6X/PXMPwiE6cr+FFfYeR
 gv+j5khZ3nzCJqWWNyd4J1Os/l97e2GaRHLkAJvkeLDC0JYBMhtId4s+U91xnqn9z2Yk
 86HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=NadFwaJmWjUnYFRvhovnjA4XPHnu8+u8BImrZwwCRI8=;
 fh=m5aePGnK2oaM4BvWd3DCf6R4MYQUqgAuQb/iThKGZUk=;
 b=salsCo2BjpU8o5JTvSfi77v5qOYXyv0hEuW5ZzjrEopo1eXkEBU41NP3g5fyGXVg+X
 +OfPXfX5/tc3ZJPkqA6cd2Km6qBwT6k4jo1Snzua6YF4v1SnTgrJVxK6fFQHAcOTABph
 JvchOhYoM80T+Xbe5C+S+dVHkfbcRqNUFadQWcTFhy89sFvA7sT1sWRoul1zPsug4+Hf
 VbiZAuDr9d2deRje3PI7SfmtBZmdY9TxrhbDB4e2L0ciA6dsuH/oUGkGN799xNT69ZOJ
 OlrRpih2WSGCReLMTOwxEuvkwTmDKOP08t8jcvcO1dFi0CnIT+l+K3qbtf+oynof9ijk
 UI2Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792415723; x=1793020523;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NadFwaJmWjUnYFRvhovnjA4XPHnu8+u8BImrZwwCRI8=;
 b=lY1FtZ5Yf8lv05xvLydhJT6ppRKfKYCd/+8I93fVvsGlbHLR0gUdmssaUCX9WSX3HG
 Dlzc9Fz0UVCVo4AwaIeG9GRTyR8HEpIF4cDAaXye2W7SMLZBIAJbmA/em/I0UCdpW9jb
 DphtLbQZHpPkpEywIB1xzD5PUnSphAEvAhWOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415723; x=1793020523;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NadFwaJmWjUnYFRvhovnjA4XPHnu8+u8BImrZwwCRI8=;
 b=erqSxm/+o4YTGGuh21FEX1sLYPRMdi6m7mFuYuCfHewUqrCdFVG5KdoF/kiAZFDe2Z
 2ernEaxigC+PxmWXGxzJOQeJiBS99OBFkc4bAT2GutNaF9Wt2ajcOIcL2VpyFGX7RAW1
 peIhbm0ZARfWA3/Rua8FoD7UpkQvD6LPb1IH38iYQFHHvSGJ27zPgXKdK9k2otngvqwg
 bVzgn2zv0V5MxCNRXA9OOrUhdRDqmbMFLVcD2sUmPjCDUq893Ol4voDbDznO0d6/rVYn
 Vd1jTo9JCaYJZ52YUKYqMe5LasaQnKX5aGuTyD7KAvjqog26ontdbNLUrjoCuyZ6XiTr
 RWLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/I5JHY5G6bWdVGpqcqT4Gzy37fMlZOvcczjyU6neDg1fMrVOEBTEZeCQtFeTfWWv3kdvh+oo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKXBgW07jTexatIFv6WIJ6wSvOSALCiW8JZZWki5k4/oZkXqoTR
 54iyjyVMdt2r3DXrFbpyabl/LKW/h35sERbaP/eAW2gZoYx4xzvpzWUOOeomNxqYpocxUU6tEqm
 WFoVHN1LQ7APzQCFI4yYZs++Q9EGeNCSkSIFl0gjF
X-Gm-Gg: AYBFou3LKzmSWuN7vxVOE5q9uOV5sQxQqz7zdgKClgQrq2Rid9uUd732A3cqreml9pp
 oztRcw3N0flQsf3KEiwB1wcpobo0z+RA404L1Cef7j4v3ZSY3G7NesjmhY8MOaK/ZEfaMoy1Z1x
 MkQ8uYXhIgn/CpqwFBz0PQQbHbBBCoK3cTJE/B9YZrm/hrD8zZlYJ88V3HGyuFJcseBWM/BI6SW
 dQw/UBMukuUIdpmO5VTSOMg2j61kCJyvP7/b54ONK4+HNnqMqlGoQvlA/qBqxi4sslvSwvgaDmW
 ff9btpc4t0CTnuzY4RNJYXEf+NgJOO+J4Ii59md0RQx6maXvUSTV3A==
X-Received: by 2002:a05:6402:4604:b0:6b1:c1e5:a85b with SMTP id
 4fb4d7f45d1cf-6b3a80ff577mr3585971a12.3.1792415722989; Mon, 19 Oct 2026
 06:15:22 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 15:15:20 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:54:46 -0700
MIME-Version: 1.0
In-Reply-To: <20261016065500.137544-16-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-16-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 15:15:20 +0200
X-Gm-Features: AclHuK-lCaZo8OuYv2K2BICx0N7r8CWCO4l3d-LyKl6fpFa4UZbVitxkQ4_LHZk
Message-ID: <CAFLszTjL5MbJDNJEzOhTdcZn6wa69Qq8cqRiB_rjN4=Tux=__w@mail.gmail.com>
Subject: Re: [PATCH v5 15/20] board: emulation: Add qemu-loongarch
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 2026-10-16T06:54:41, Yao Zi <me@ziyao.cc> wrote:
> board: emulation: Add qemu-loongarch
>
> Yet another generic QEMU VIRT machine.
>
> LoongArch QEMU splits the main RAM into two parts: the first 512M is
> placed at 0x0, and the rest is placed at 0x8000000. FDT locates at
> 0x100000. BIOS is mapped to the first flash mapped to 0x1c000000, where
> U-Boot starts execution.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  arch/loongarch/Kconfig                            |  4 ++
>  board/emulation/qemu-loongarch/Kconfig            | 68 +++++++++++++++++++++++
>  board/emulation/qemu-loongarch/MAINTAINERS        |  9 +++
>  board/emulation/qemu-loongarch/Makefile           |  6 ++
>  board/emulation/qemu-loongarch/qemu-loongarch.c   | 67 ++++++++++++++++++++++
>  board/emulation/qemu-loongarch/qemu-loongarch.env |  5 ++
>  configs/qemu-loongarch64_defconfig                | 35 ++++++++++++
>  doc/board/emulation/index.rst                     |  1 +
>  doc/board/emulation/qemu-loongarch.rst            | 39 +++++++++++++
>  include/configs/qemu-loongarch.h                  | 17 ++++++
>  10 files changed, 251 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
