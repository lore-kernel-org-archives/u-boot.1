Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC30CD3447
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A1E86AEA;
	Tue, 19 Sep 2023 09:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M7YlJOqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B69A486AE8; Tue, 19 Sep 2023 09:20:20 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD9B986AD9
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c00df105f8so27307241fa.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695108018; x=1695712818; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmlibWxzW4v9fA+Ssx2b3DieUxRctOSlf0dH75zLBJg=;
 b=M7YlJOqIcoP3s2WkYY8CXrGIowHQcTulwDocySreYPwsdxcKGg4cyLnmoHkhbZ7SuY
 pCNvrVzet+c8hCK3hIOT0gHl8IwukXm+CspHEVIsRBiZxiNurd44SvESkAaHzQkV7WLE
 74jo1v7yHk58ldRD//8PihBFdMCdfVn265YsVQ0ITgck37elmyXkAbVTs7FMYMkGspf8
 jo1CSkPi3c6qBT6WFonISgm5h0YpC5xT/d5v/SN32VyoEWSr66Rqfr3SM5ojNQtJRNeS
 6bggR+BYbqzGZqrqgHUE+GUr7ef9tViN0yneqLqINwTNS7N5MJ9goGAts4HRLXFd1jTH
 pGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695108018; x=1695712818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmlibWxzW4v9fA+Ssx2b3DieUxRctOSlf0dH75zLBJg=;
 b=AwCHVtm5FjqgqGMv42p3sOS0GHiPZrGokd6M+y6eoDEySVmDL/952SU5UMB5zGbKLS
 IyH7c56voTBZC65TS/Jmuorj120cHf/GGtbQWILz0KENYTWy4R/n0mOUzVEam+87JUw3
 0yJI2pKAdpdqfRZRAlR6sNn5LOyWDlGz9GhwMo60ErR2w3B+nahSj5rZ2wERZERUtBHG
 BC6L4pGaGB4RxyGJ4fLeLRvxqSbNtnW3ia+pFK5aiVG2frLTerE9fyfU17jCXTUmuSM7
 nb8k+o2xjUTFMxC2I5bH4C2aeOo9cqG5HtTQpegsmV6SLxOlw2op4vpBhis4DKFhdIds
 MokA==
X-Gm-Message-State: AOJu0Yzy+n2DMZLoovFHKH4T/GhWPI83nDN8vdk7/08ndIjmJn0h0ES9
 5d+impbLAJ//DJQyv5DnHAyxKTd0YxcyYR6lXpE=
X-Google-Smtp-Source: AGHT+IGdZFgPVRU4mBYOtnBq2w2GQS/GGCReV9TWxTzSmgFj6fwKIfne3wDvUo3EX9jMFJLXsX+BxGwtSym5D9vxgg8=
X-Received: by 2002:a05:6512:709:b0:4fb:780d:2a49 with SMTP id
 b9-20020a056512070900b004fb780d2a49mr8579731lfs.5.1695108018195; Tue, 19 Sep
 2023 00:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-19-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-19-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:20:02 +0800
Message-ID: <CAEUhbmXHAjbFmnm55T3ppChwChroTNHK46XFU4Mx2uyuNvTD4g@mail.gmail.com>
Subject: Re: [PATCH v4 18/20] x86: doc: Update summaries and add links
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Refresh the summary information so it is more up-to-date. Add links to
> the coreboot and slimbootloader docs.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add new patch
>
>  doc/arch/x86/x86.rst | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
