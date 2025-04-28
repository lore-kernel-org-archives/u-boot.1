Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6D2C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 16:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1979B81F4D;
	Mon, 28 Apr 2025 18:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j11jzlUw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA90B82140; Mon, 28 Apr 2025 18:13:15 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DBF78056A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 18:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-549963b5551so5076701e87.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856793; x=1746461593; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuBHbtlPKMBQZ3Ws1Lts4bb0OKpqKv0JL7IJ3CAw5zM=;
 b=j11jzlUwiqsxr5gjDeB5xZSVQt7ORHfkmVaV/77Ck+6/Yrcpg1icqQ2l3p4g6EAh1p
 TWzrJmKpo2qcwFXQsRDtSGt5dlvn0oE9GX+ax5Pg6Ok8uBRKSdZrvXFpnemyvs5HhIYc
 tMbBNyzrDbs3Nr3C3cR2dzLK7guASyYBWxJfVZMMveiX5oADAxY8hP3C1SvP935HSGU8
 5spwUykKufa2y4UzLKJHujaLOIJNVBUrozRVUqFuG3O/RSYHkAJFtvbcRIg/divxJHgM
 FqXvLvDnXhtpWtoxvZ3Pf6ZpPRepjtIbfZ/43MxooA5iccFd4Lxnh+hu8BYjAlu10gry
 2x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856793; x=1746461593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZuBHbtlPKMBQZ3Ws1Lts4bb0OKpqKv0JL7IJ3CAw5zM=;
 b=IIgV5WecCivaD2XOlz/2nTzHFL2OOwLZwkBV05gYscbiFcjMvR2aI9tT3+Brz1zNS8
 YSa2jFg/YUsw7ViuGQgGMgAwx6jEqFmS0E9mP3V4kmhVSkwh6OHuL5mMLsw9YXQFySUw
 PWnXEWTE8PUdqFQR/xTDVFEGO+knjlxYL4TgYVyP70dprA5aJ3x8VNvDtDIlu/ocqlkU
 00ZGsLX12YIpwW70UKXyNHI+jygf4+220GIQg9uqL7xEYq9gJ8JeahaoQbA725Zip0ZY
 DWUNCbF/t0VEztE/2TgMzCCLSvpZIsP27z+LDkiaEIJVNEdk61rTbZyIgXgvOFmYZYXS
 tg5Q==
X-Gm-Message-State: AOJu0YzN6CSxVI+m/bjqrGpfXpik5ZtK1/GV60JtEwA/T2MGWLCQx9Ob
 Wmch0pKangbu5uzN+YWX7DvyGMztZmo1oXVs0v0Iz0MZy/F0/K+43v1otre36oTaw3MzK0SAEpP
 2lx/cdaqQlE4aTBHCZTHXOwO8EqurOA==
X-Gm-Gg: ASbGncuf466lFdgd5r0YMPxNSasaQyOLt19ENZOEKpIfE95/NguA9aHYV1oM/CogVra
 z/umJCW5XP3IljbTWG6hwnYnhdjepP/lQ++ncCU16A7u4V6F5xmRTbyeoYkM79aElHZEh4JhYx8
 tH3srLUKjXq6wC+WI/BGnX0EiX3i1ZuDtHzhh9zr7HS9ewICfRDbEwYQ==
X-Google-Smtp-Source: AGHT+IGIGkr24D7t0b5OQi2KEvEQIYpqmdRft7bSSRxLFxi0Ks51cBlo1U4aLiai0dSpOBhr0T5fBv6gplKTISu+OL8=
X-Received: by 2002:a05:6512:3e0e:b0:545:2ab1:3de with SMTP id
 2adb3069b0e04-54e8cbd5490mr3464555e87.13.1745856792796; Mon, 28 Apr 2025
 09:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250413110138.1027438-1-sbabic@nabladev.com>
In-Reply-To: <20250413110138.1027438-1-sbabic@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Apr 2025 13:13:01 -0300
X-Gm-Features: ATxdqUFKeStu1usShwlhyDw4v0O0y7vLfLK4LoXH2ZgphNsT2KgW1XHv6cjalH0
Message-ID: <CAOMZO5DzZx6h7xaSSk=2f3h6ee1PQKMOBx9-3M7ZUq94Ud4oAw@mail.gmail.com>
Subject: Re: [PATCH] imx: mx51evk: drop Stefano Babic from MAINTAINERS
To: Stefano Babic <sbabic@nabladev.com>
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

On Sun, Apr 13, 2025 at 8:01=E2=80=AFAM Stefano Babic <sbabic@nabladev.com>=
 wrote:
>
> I haven't anymore the MX51EVK board.
>
> Signed-off-by: Stefano Babic <sbabic@nabladev.com>

Applied, thanks.
