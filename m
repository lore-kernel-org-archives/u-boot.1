Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C944C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 15:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01538608BA;
	Fri, 14 Aug 2026 15:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zExvpjNnpgct; Fri, 14 Aug 2026 15:31:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73EC1607AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786721501;
	bh=ncBq3kW5C3dill0RMwtW1LeWEOhRrkXezHW92O/Ugpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wj+Bv7du2CU3aZbpH4Az2kFFpTTT+Sw99FX6abx6VwVCrisQ36+nxkQj8OoTLR16p
	 zImghSaRyC6Jz6PlOX+GrwMhF9jrBD2aCbnvJKy7UZMnJF305FdBy5y0qeYYtddk1h
	 1U4k1smyTJY4Dvm5SR0P1DB/PA42AEZPm+KrZKgesQUQNaZza12zKqcLRKdL3uY09/
	 yME6+tnv7dXDZ6awACQyeyPUpfgzeTaP5p16ZiYEQhK8TDrlYJkR52tONhdRProapM
	 HbQp1dYU3CcKfGjE0DXKUozRWPcAYivZ2h14QXZCYtre7LvjwnlVmKIXu8N7Agrs+s
	 EDCvDxT58lD5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73EC1607AC;
	Fri, 14 Aug 2026 15:31:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B830B2B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E58D814BE
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:05:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uG7E31YpO0j2 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 15:05:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com;
 envelope-from=prasanth.padarthi10@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E7BF68148B
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7BF68148B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=LQ4RGEZE
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7BF68148B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:05:36 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7dbcb505578so11244917b3.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786719936; cv=none;
 d=google.com; s=arc-20260327;
 b=qPgaL4DFVuwb2IoK8DxhvC1CLr5tVP8kiM4e8FSWGi3ZvpS8ErM+JZGhNeW84Luc6P
 f/Gf4yF4g5bDwa87iiBNBto2qvAKEsBv/6+GhjC5xY13hEhIaPPwY0tJa/A5iH8lMDEv
 twNYvELGwqmog6zRmd/u963FdSUCubOsqgDWnbueIpv7ZlAAEfoQ/mXhXKCaKtRhoaC3
 ba/X6+FqQtLBpNXcSg+XtlpHmPx+jx7pGEZmi97f6MgM7uanpXEfUDpZTsqtjISGlPDf
 0mIuolGbyMW17WZvCxsckehkKXLjYX8Y0kqRUPzNTnRoRjx+Ep0mgAEzfzECyLH5aH+N
 5R9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QHhHh4EJlYK7NSLZuIENBGHdlmDealZsdZlAfXl481s=;
 fh=/Y6WkI3YnD8q2/457D1rgtM5m8yHDIvzfy13jLUbG0A=;
 b=pcuoqz0D1ZghQ64Y1iQeFqcH970u5VQaomsJcLtuEewEXCHT3Jq/KWuBpXrRRsYafR
 Qp3Y+fWHLz+Gd6Zx0mPYhztU9CKl2y4Z8KQdTcsrOVGdC6HvVLJbBoIjlpBM4quS+HOe
 BAzITprO5KoNVPdnK4d5anQTugUXwkmXO4ZLZYocrJuvhrvE3/yhgY5mVa9p3av74EFI
 5A7gDGYc0Q4CoAm/baNN1Gzy2WM+gSVYVUobPQqL4ZwnlKLKpVav0849jGjcLqK0JMVG
 bt2Y687QgDZrZaaGtd9UUcRPlNl8JAemd2YxHe7OV/RJzr2oNHfzjsDIjQVkFc1WBAEw
 MwJA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786719936; x=1787324736;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QHhHh4EJlYK7NSLZuIENBGHdlmDealZsdZlAfXl481s=;
 b=LQ4RGEZEOzVQsAsn1RYsapWn1mBqlFCHN0Bz8m68rpTiZBCzJ2mFKwTRXPge/fhQJw
 eJ8dxLtFy8CydMvhlvdOlYpfx5mXCUnZCbmn5DLYurInmZc/bAPSlJQfcKdV2Mz0Ackc
 ejPWxozEFncbD5eQmaXQroFYnu5ncNEY0v2SpBxdHQ4cYC516pTjfaeqBAZLsoJfRyp7
 HWNRkyu+T2cFUlVqoQ2pL0TjjMjcdR45BbZoUZ7Zx754CmAIBKYU6H4uI5xfn/P/Azs6
 fdiIkCSgXG4JyEuoRMbRPwo7WwzERqnVK+2XK8QvjpPcIoJySwPe6tKpqHdYRgf6T/vr
 ALpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786719936; x=1787324736;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QHhHh4EJlYK7NSLZuIENBGHdlmDealZsdZlAfXl481s=;
 b=pQWqsMz1ak6FEXF7BRTfzcyIFTTN0gp/3mmzgDNbdDXnytrBSlChm6bUAj1NtzBVDv
 t8fuaRJCjiglGMjdJ8OQLpA0arRR2e1kxWnh8a2XtvY94I2/AvpNe+l4QiAoI1Ztq+7p
 vVnXDUdc6UAYNPFCgVjN86NjupAtbn9Vl+KzsKqTjTQSmrXRJWfx/2TNFJD1NL/XGbVw
 XB0yAhAUo0qnWrCVei9P1P9F4aeEU71BiLr+KCpJRWCOu0e9byZ/wxrK5zqu1Zt14nVR
 GZu9Q4gzCvOcI1VqspXrG59L957KHMUfW7946RYSnpK+uZt+YVx9oTiKaCexJLR4lKvn
 V3Wg==
X-Gm-Message-State: AOJu0YwoIokHKrewYjSzoz1qUZ5tchrQlLTclMyeJ907Lfn01FaQS+at
 AGYttoO6KqSxE3hpj6xZsGXoNKDhmqLc+5Hg5dWo4Nz4Fb5SujZFOsz4RW8IICzIpGJT4TL/NqH
 E2KQPWvBPE0vzoFL+W4sWzX5mn7Bmf3I=
X-Gm-Gg: AR+sD11u7L07EvIgjNHBLEF2etpqiAY/QABs6Y2SvF9TAlParzQryCFJzHC4egZZWbl
 uZlG0Yzfh/SVqx1ywfmhk/6gfCu9gZdeddlUS+pPOJy17IMiDqypQiXr9fX4SRiAbm+XRKeNvfb
 4qEBwiXWzhvqO2RMbF46u+oPYCT6CQOEvq8Hvk89V5becN5Z4QImBHoN+S8HGd3fqTy0xxFTIbB
 /I+iNuCpwJKGyWIm2WLigfKAZCko0DrMkJn7Hf+QNrNnwvIFkNzQiwQEA3JHZhqyo8b4rrNxlb2
 hHQFY4e7kfc15SKAZKLXxGmdUhyxB/VbIy4F8qAQWxbQGYqagbtENVd2e+wmrA==
X-Received: by 2002:a05:690c:c6cc:20b0:80d:15a3:7b1c with SMTP id
 00721157ae682-8370c93d2ffmr19351157b3.4.1786719935085; Fri, 14 Aug 2026
 08:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260805160443.181600-1-prasanth.padarthi10@gmail.com>
 <20260805160443.181600-2-prasanth.padarthi10@gmail.com>
 <178671547316.3828101.7691547056094343416.b4-ty@konsulko.com>
In-Reply-To: <178671547316.3828101.7691547056094343416.b4-ty@konsulko.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Fri, 14 Aug 2026 20:35:14 +0530
X-Gm-Features: AUfX_mwjzVDPENmcnkbv6io7AjygfF6vQrauRmTHPAJJdjQxlWMZ3jsMscRQyRo
Message-ID: <CAMFFDGjfowdct2AQp8mjepTH77EM36YFZctX40Tm3b81gqCbbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm: aspeed: Add ASRock Rack B650D4U BMC support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, ilias.apalodimas@linaro.org, 
 chiawei_wang@aspeedtech.com, ryan_chen@aspeedtech.com, BMC-SW@aspeedtech.com, 
 joel@jms.id.au
X-Mailman-Approved-At: Fri, 14 Aug 2026 15:31:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Thanks Tom, really appreciate it.
Glad to see the B650D4U support applied to u-boot/next.

On Fri, 14 Aug, 2026, 7:21=E2=80=AFpm Tom Rini, <trini@konsulko.com> wrote:

> On Wed, 05 Aug 2026 21:34:43 +0530, Prasanth Kumar Padarthi wrote:
>
> > Add U-Boot support for the AST2600 BMC on the ASRock Rack B650D4U.
> >
> > Describe the 512 MiB DRAM, UART5 console, watchdog, 64 MiB SPI
> > NOR, RTL8211F-connected MAC0 and RMII/NCSI-connected MAC2.
> >
> > Use the existing AST2600 EVB target infrastructure and a
> > board-specific defconfig.
> >
> > [...]
>
> Applied to u-boot/next, thanks!
>
> [1/1] arm: aspeed: Add ASRock Rack B650D4U BMC support
>       commit: 8eb951f779925a1809a6fd173ed57bbbd6d7db9d
> --
> Tom
>
>
>
