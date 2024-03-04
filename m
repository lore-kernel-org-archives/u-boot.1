Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F5AC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0C6C875FA;
	Mon,  4 Mar 2024 18:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iOCc/zNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7C4787DFD; Mon,  4 Mar 2024 18:55:24 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AAF686F6E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso1794994a12.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709574921; x=1710179721; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X29qqKfiDX6FvXXgfNMJgVXLTeI4n0MC9kOnoD5ZVrc=;
 b=iOCc/zNx7WJcNL8CUKyzOMSzhyiWapmF8Kv9ak9nsYtSJ7uTsbc+pwQkqani6lzTCd
 YAWCN2JVwC3xWkhZSEY9N07SpqtMp42QrHWHCUFRJp/38PQ0HxWWwZuz1yHcgXWMLaaS
 yDwOBW2zjnMlBHlHjX0DWNlzuABVuo4BP56BERe0mz15j3DdCSWYIuHC3BDdLGcO0b/1
 rINwA2x1ylMXtZSs0f5Sld4iCMEpVzsA8Es4P+V8EPlWz8A31IMwrHXyG9FqNz+xFESW
 gzo0BgdxqfsEjrWGcKYFlE4GmqDeODnkhpE9tv/lmC/l9kKl/kkAolOtmauXI7SrBeS5
 1O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574921; x=1710179721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X29qqKfiDX6FvXXgfNMJgVXLTeI4n0MC9kOnoD5ZVrc=;
 b=qZWCx0Jc/v6WwijxkurPF+ug5YaRnYRrN1Mc8+SuOaaz0BaUqpG64SCoOoyMl///eF
 wZs/56JcImDOQje/mgFLHgg6yCeiOS2YwnHiX+Q8oxp9c6QEmJhSHY3PkVp4oIlE+QDj
 89O0a0++Ngq4uKKUZRs6z4VtYT4TFfSo2nswGm5UiNVoSwCmGWVJWIot/mmWvuMw1vu4
 z9dJua7f7F3hkRwOnpJOkm8rbnuwJZF0Ojpq1mnL12L6f6hw9/8h+o0VSZ/ZswFXyNxe
 D47/3bnwkDqVSH/P90nkelXsGZiemLW2OfBP0VbCcu/YFdf7aSAvVjCZNaLnrJn4JUlH
 xWSQ==
X-Gm-Message-State: AOJu0YyPZGcjrOssyLqpWjKQExmc4voYdMc/AXhA9Tw424SmRZyvO8qD
 V/k7OqbVWyI91KirRoh9trYM/aGwBO6JGaJOvjGYjsGS8lgt7Ef+/cYWSf0abMPw/WVo+LAHMZh
 CZR8AaysqvhVO9Fh/K3G8khtCGww=
X-Google-Smtp-Source: AGHT+IGvDadM/JVztE09no6ZUqiL1wFNiiDzVjbZCdEA9kP2HeVZFLPabCJ6z12szLfMEENJ3RmXU9j9qLMqcnuzNZE=
X-Received: by 2002:a17:90a:5985:b0:299:3258:fdfb with SMTP id
 l5-20020a17090a598500b002993258fdfbmr7956854pji.4.1709574921009; Mon, 04 Mar
 2024 09:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
In-Reply-To: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Mar 2024 14:55:09 -0300
Message-ID: <CAOMZO5Dsq3x=8e8QOAz5xg4gZP6XBNX3eL1tSb4vCx+ssM3-XQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
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

On Tue, Feb 27, 2024 at 12:40=E2=80=AFPM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
>
> Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with
> linux") removed the display timings from the board device tree whereas
> they are still needed by the mxsfb driver.
> Add the timings back (the correct ones) in the
> imx6ul-opos6uldev-u-boot.dtsi file and remove them from the
> opos6uldev.env file.
>
> Update the opos6uldev_defconfig file so that the LCD turns on at boot.
>
> Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with linux=
")
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com=
>

Applied all, thanks.
