Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4355CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B5FA83FF5;
	Fri, 12 Jun 2026 14:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j9ZtM0jI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8917684664; Fri, 12 Jun 2026 14:54:13 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F10F8056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 14:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-396775c2720so8582951fa.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 05:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781268851; cv=none;
 d=google.com; s=arc-20240605;
 b=eWrtsy8RHFXVhN0Z8rsnaZh43x83g5jp/xL/Ye10FgkH937MKC4bCt6u8FpBwHiVUP
 eVcm0P1tjU18ebMW0u7pKkX2eqtImslRi3gtTJOVGCDPgsLpN6q4QL6r2zTXaWV1jzot
 gtbfQTS+MOIQoRGPBXZy1jFT0HieFZMG2Rbf4O05qUkzU2/R6GvwzffZYSG8JMZuSQo0
 Kl3A/h59XB6Mr6LedPZkEWLsfdxjms8yUtlH5cyUrg7Dw9SKpwE9eRnh1zXJ7ImW2gNk
 7A2zCgGbIlz+5LudvOr9S1/sSj1VEk6FVBch0brAQaZDKd2MRjpJOyMEIgy784l1/lXJ
 OJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q6QJu9Y1hAOPKcjREKB12J9DnEwMd97qpts70r3lkGE=;
 fh=Vpi6q4idWyRDptJbJQM/inoXD/NHpqcfgnOAQiyxf2E=;
 b=PX6kV3UlPyP5FaUAkt++7Pml8Hz4ME9cmD+aCnjEKQYw8JX23mN9EBUj1VI8VlVyhb
 ALYtL7MTEP83luwmrvXTTJn0SoWQm8a3Xv+2/Kot8I3j1/9sHHQGJIGIbEHG/w/9jW3E
 9i02qJ/Z5ia8AZ8JEae/BowI1NbzF2iSgYNLNXLXYu0Afp5CDbWdHEzC5Vyzu4Jor3Py
 1xvmh/3+XFyLSwKMCQ2ZZmJASAbBSW8BS7hLJGwJWneivdPW6sDeZxLu5rM4U/1P3c45
 udqq3dSkMiro/vut9d4r7Mfb08b8EjhjwjOih0id/ZwSBp60FJmKpHW++VkcgX/JIw/e
 AIlg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781268851; x=1781873651; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6QJu9Y1hAOPKcjREKB12J9DnEwMd97qpts70r3lkGE=;
 b=j9ZtM0jI2JEA4AbtZOkadBN8y3Notlc/GCprTcaO/HSGuPgXQSW+SvkjpdSjiBXc+y
 ya/EIx/ZvcuRRrxjqXxVVDbcGdXo3HOtIqfQUsfB/3adUJoS7jijHzvDxpnyTbXqw8hh
 5C0uDhwWkn8xj6VKjM5kHysmbfZDsmv4S15ZAHfruiVIMRIho3Hr6rqxqWOicwFVMpTh
 08TTL1DyEKl7PgkY3yQvjPvCpLSRb6UJHjOOPciV0hh7v4H9HQYr5PVRPqb16tv3Xeb1
 ECRWZfBIfPrx5/+gkiXJt2jdUgAjMctK4eEoRZgR1JUYGr3b+n+7+FlvJaz0kBm4AzTg
 GBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781268851; x=1781873651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q6QJu9Y1hAOPKcjREKB12J9DnEwMd97qpts70r3lkGE=;
 b=qmu0JC9OWZZ6SflyXGWKXSQASH9AKId8r2hBBffulBWnLfgzxyARQc9ap3PETWZnXZ
 Or36KhUpjYwVY/bKYUgTE1DOxpsd+sOZVK4F835Tr/JlXSkEx8eFEWC4huBWbHSJMV8K
 +FwSYlfjGXiSMQR1Zy8fOf1Dhp6eaqzT/UKGxXnemNEkXdX0f6UDjO9RlwJwaCdikvGP
 Dr2NNqB87L7YgIhfZr51LWPqDCNHS+kcIGp6mCP+rOHmkBDAHn4KgKVhZiCqe0IIR0QX
 ayUutfmj/ZCB8tuOLKSTSH5qF7RVlC4kRBNW02VGyQcUqyCjZ3H6sAX4+B24C7KsC3Z3
 WCMA==
X-Gm-Message-State: AOJu0YwD15Uc2hl9zrOQIJrfitkxtlGis5ZnE8MwYwqbBYnIuN1ta5rP
 lh0awXCecYyQVk0FqM/7ImUOJMMnQswIM5LD0g6EG3mSBafxVUmbVDXYtl1kkePmBNZLSafoaeb
 Tcd1UNs7tJ0CURl+sRXMr5meB1fyYlLU=
X-Gm-Gg: Acq92OHaCG+ZcfNUQZdaHGo7gc9GKEdR+vCcEbB6b6SThgifgyst2TDwkQPe///sK94
 CXtOfBzzXwCq0vm5O1a8gJQNepX7eimGrV6fbsvxojWZfNCCS983mxcxvtFLRQ7aQwD+LUDk3Cw
 qEbWSjv3A37LbtYFuHfxuFjZ3N1LPkzdFFzmY1PVxWSONjkC9arffQVD2gb/JCZB2+1o7qi2pXU
 Yubyb78RJs5P2Zmb+5vJbZvZTRP3mL/s0y1cEF5CQ04Pf8UiMGU+RQoEYZBGn5w7CJR6MY1pQIf
 llPsxfB2DQY+QW+5WVfAWN8Swy/jSxYsis0pqeoa0MNKD3bxriOWlv/BtaWwnllBQnXfCi7qwEe
 s8Z0+p5Q=
X-Received: by 2002:a2e:a99f:0:b0:396:95eb:160e with SMTP id
 38308e7fff4ca-3992b286699mr9667701fa.23.1781268850473; Fri, 12 Jun 2026
 05:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260421225111.218951-1-marex@nabladev.com>
 <CAOMZO5AgST4gobvq=2WYG5cPL94inw9XQ5zPoaf8AHWpf687Zg@mail.gmail.com>
 <e789a554-ff0e-4eb3-8604-d9410ebdd9f0@nabladev.com>
In-Reply-To: <e789a554-ff0e-4eb3-8604-d9410ebdd9f0@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 12 Jun 2026 09:53:57 -0300
X-Gm-Features: AVVi8CeGXm6A6QLgTrBNEE0PASZkmPtKy05L2BWIY6HQkYxfIaNKohDv_pewNTg
Message-ID: <CAOMZO5CrpUg13jZ5PCaOhA_oUfnBbJaGoSH1Thi3TF6aeth-BQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Use N: for NXP entry
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Thu, Jun 11, 2026 at 6:48=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:

> Can you please pick this patch up? (I noticed it is still in my tree
> after rebase)

It's already in the next branch.
