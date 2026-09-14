Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D44C88E73
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 20:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ADB480AE6;
	Mon, 14 Sep 2026 20:44:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ernVAABxcV0V; Mon, 14 Sep 2026 20:44:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 608D680AD0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789418694;
	b=C63mhYyWyBbVgU+uBrqSA4qvBnY9l00konTjRKaFctx9b5yjrflr+roLY3gvC46imRwj
	 dKEpPHwQiSqVwWQtm0CvA8q0/ca4Id/Im9NLe8EjcKZd8gGFw87B5l9nD1PGBKk46VaMt
	 B4NBeR1BwZcqrxnBDAH7MXTz25AEPhmqdAc0Hx/DVe8eXeSI6UwPm4/6TTltGd/btTJyH
	 JzEI8P5zdCyL5L4H06UcwJWo2pYLJJgmJDdWKDnECSFBDB9in5pZLiEPfBSckASpQMx+C
	 aZcP1nZTgG9NZtPAEmiFRysgA7NFF9UU9P2BHl5/OSfw/xcjR1JDh4FNgjhWD9eqaAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789418694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6aJhCqjTOqAu2+ww/ibsRAvEEshULnERqEkBcn6NeVc=;
	b=r/7wIENZaELKlsFoUpn9tu9ueSAlD6VmNyDPI9PJtH3TvTqe4qLfRqP3CQ9gR7C8stf8
	 /GjIZioB2syi2TJdFAcNeQnn660P9N2euAPi/O1KiYLasHSD08YJqOkkCpITTpQrUEJPe
	 qI0Db0dxsXNH0Eie4eqiMYpfIdDd7LOjn1um68oCXKld0XGg3HebfFW1LGcgZZ83eyQMn
	 qpVbaVQ5jjE2R/8euiSxXajcp+di2PH85DcuyYCTNkP/t0qouTcsdLIZqGKcRLnHeVcAS
	 YDUM0zjVHrdQjRJ/RrqLkNX9HrODuUgCD1RYZJswnjEm3O37wA2J957N/O7lvaAgViQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789418694;
	bh=6aJhCqjTOqAu2+ww/ibsRAvEEshULnERqEkBcn6NeVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bI5yyT2vaKLL/0MOEJ8JgCzYv3AzZPBeN50IeVj56hJNeBlvXOmQPgXvxJsljBrtZ
	 FTj9OlWdqfqE76lnL0iaeCVQZQoEKsSOcbit7VVqbxqAgTv+TY9jzWU2D5KjHfSiI3
	 cc7mlNC4/aYBw0NRuTTfgIkxK6ifqQ8GGH5g/KW2eM6pnjIEaj/hY2JY5wzOjBTFuq
	 FujvlsYBnJSe1lB8a481WozET4RX4PDE3732BMHPcFHJP4PNZr2e6Ps9ID5aDF5Yz4
	 yv+xsFhXYcGzIO0UHbQ/iA3MIDXq3pZpPtLUcr/1NZ92IOtc4Ype80f9/5YR4E1wuC
	 Q5SxyXjVCivtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 608D680AD0;
	Mon, 14 Sep 2026 20:44:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CD1FEB
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5EA3C40099
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:44:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rdti-U8JLwic for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:44:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C253340076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789418691;
 b=L8z5IE5LNqLSoHP1YIuYEt3dX9A3zm6D7V19dcXLLVXT42oIVr9zMmh8wRbBts6mx1Kj
 ODHdS12xL0OEGAD9Cq0Kd+tRgXwDiGRIU2h0V/lu1jO7TiX7JYUDtnn4ItDaQHWs3nAkt
 8BAMWn0NCtFJfqAihEbXWmZQfcGxNAWzICM4lrf028ox5lBUQ9dA6GGe6XA6+8wLxcClO
 +s0Qj+G6GXB+rGVXPqewJKkp5p0qY5a+VzkZEhrWkkjxBlfVs4U2TenLSN/pk0VruXnf2
 0vrbPbYe3ZMWkms8L333Y+Rim32jj5Mqi+RKo7ylddAcnNEU4sOaNdNVOeFh+kWTKrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789418691;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:
 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=6aJhCqjTOqAu2+ww/ibsRAvEEshULnERqEkBcn6NeVc=;
 b=bHsNQ6uK1afWNtZTD8nCX23YLhueDx7YJJx1sjemZqpUNX+fRgXa089kt1wB5kWzVeO+
 JMaoulpIoRBwj0NddMLnWzGpa88ZQuZnXrDJCIkKSSv1ixp3ZqwTBr/gfy3deOlHW0hcd
 GoDyI7czXcwWYEHxmyZ63a2aV7Tn8TsQOmcFfRKyGD42xhM5BmSeUPVpIlUt5JACFA/Nr
 OtF84lJiPrhH3YvCWyJUEkgTyGqm//S/aLt/eK256UGKuhOliQ2xCWGNLQEz90O/hfywz
 vNBZquXJ+bpzLPJg3g2ROY8i2EewxuxKovZxFUGDTAF8kRKa56nw4pAuhUK0uxar/ag==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jaeQPpVJ; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jaeQPpVJ
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C253340076
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:44:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D78F43C30
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C661F0089A
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789418690;
 bh=6aJhCqjTOqAu2+ww/ibsRAvEEshULnERqEkBcn6NeVc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=jaeQPpVJi6pNAqdszImCGlbkrB6CirrgksDM4AcYhlgB2khL/3dreZlk2FV1dgQhk
 8NXhd1p1bwk5rq8w0trhUluNEQeMNBZhyGeMg+Sgr8u/F7hsRtKj1h72DEKMMFpxb6
 CLJJLaQx+UP1YSEUg9g0j4/JTxB3q6cOagC7Imr8zbvRNPlH8Ubfucf90+U6ghfNxr
 2O1Y6oUD4ymiwCMjts6r6XZ+mt5QCF+tABrXc5qbLN0jHxIwNDRBIipO9jbTsUTN+U
 Ft7DQLN1ZzYbpGwC9NVXjtJGNV8QORsbLZsZ1c7GJbWhz3vRixyQLi+5RG5KHFAcJ1
 Y0UAdcnBaadFw==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f17450so2150145e87.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:44:50 -0700 (PDT)
X-Gm-Message-State: AFuF++l5ihOpIZSQRLNnlNsHXjBdGVr70iA+9mU59xJsP3ZtREUNLJ66
 7too4HuHHV96+JvV+2t01NV3tGepgv9leZV/HtMeztsEGGKihr4SUNkdvgzlqlmvNPvvC1dix3k
 XGvVdPAObBt1L8/TJnoOnRn12IEjuGFk=
X-Received: by 2002:a05:6512:3ca9:b0:5b6:183c:5c94 with SMTP id
 2adb3069b0e04-5b8ae69f54fmr983569e87.50.1789418689091; Mon, 14 Sep 2026
 13:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
 <20260914204231.GA632314@bill-the-cat>
In-Reply-To: <20260914204231.GA632314@bill-the-cat>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 22:44:36 +0200
X-Gmail-Original-Message-ID: <CAD++jLnkohAa7Lh0HdPpm=jUs+BOwTWK07GSQDtM+uaFGZCusA@mail.gmail.com>
X-Gm-Features: AcwNN1UtON--QoCgEa7vuxEVRY4PTSO7etC8U-R5Kj3vn48f-HNl-ohbHVLbdJY
Message-ID: <CAD++jLnkohAa7Lh0HdPpm=jUs+BOwTWK07GSQDtM+uaFGZCusA@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] arm: u8500: Enable upstream DT based SD card boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Sep 14, 2026 at 10:42=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:

> The MMC changes least to a failure to build on at least vexpress_ca9x4.
> You can see what boards use drivers/mmc/arm_pl180_mmci.c by doing:
> $ grep arm_pl180_mmci drivers/mmc/Makefile
> obj-$(CONFIG_ARM_PL180_MMCI) +=3D arm_pl180_mmci.o
> $ ./tools/qconfig.py -b
> ... wait
> $ ./tools/qconfig.py -f CONFIG_ARM_PL180_MMCI
> 11 matches
> stemmy stm32746g-eval stm32746g-eval_spl stm32f429-evaluation stm32f469-d=
iscovery stm32f746-disco stm32f746-disco_spl stm32f769-disco stm32f769-disc=
o_spl total_compute vexpress_ca9x4

Thanks Tom, I'll try to build a bunch of them and see if I can reproduce
this and fix it up.

Yours,
Linus Walleij
