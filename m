Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0482FC197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 01:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C2D86ED6;
	Fri, 17 Nov 2023 02:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WjVGJIvB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCDC886ECA; Fri, 17 Nov 2023 02:44:37 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E7986EF6
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 02:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-51f64817809so222033a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700185465; x=1700790265; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJTQYF5c9txoynDkg/qoyzrPYBdfma641VCcHnjoVDo=;
 b=WjVGJIvBA9lZPjgqfGHOIUYDLHVzMpPS3EMzd25Ff701nsaiViILnBLJUn1/R0RedM
 wjBcYJVicH6m43SvlpHOXGsBCkN7L8+bAKry9KhO8N8Ore+HfpyMLGoxrnCpwLiB0VMI
 lzp75tScMPC3m41eNG28DML8l1uHiZ3LX08BjuDhtMsmvGWiAbXZCa0i81P/FEWJX3ST
 lcmJgbWC0Iq+BmhNCiTZ/ZfNTKgz3/siDG3O2iUr2ZKlDASiUgRm5cXeGFmiwoKk0nx5
 T4qXCYJd4ihNuu3sEJ6GxtB6By2AdneF/ipDFYs61b/Ee6oVlL0pAxQ1qKJ6e6hkT3K0
 06TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700185465; x=1700790265;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJTQYF5c9txoynDkg/qoyzrPYBdfma641VCcHnjoVDo=;
 b=xDcLIQcsqHGg25YOoE8VTlpnLgjoDFNlzpkQkO38aTunZMSlsOjPTf3lgq2lIKje77
 vs7hDJLEK6RcYLFrP+9GTnyLo2nT0V/dadnoud9Lq4uxP+Udv4SNH2Ck93m6DhM2r7cW
 rFEZC3hIKjJ6VsGjDCEKbdF10w96MGmVa4usf32Z2ZXcfQlcQUdkpayd8LVgqX75wLet
 GByBo7w1qslKjvReWDbwgdHpXxa48Fbj8t9GCmrwn2g4HbdTbGLFg8DoO4rHO7H+HBZ1
 6tsN3dSaJR1MvicTqL3M2u9zixTlKMzTArIhBlETtBV5MZ6PiCzZLUh8LS84jkSJaY39
 YzQQ==
X-Gm-Message-State: AOJu0YxEqEQ9CVV6+deq6Oeu8bH0wUjNqf1X2TJXSWlP4+qhgUNlL4LP
 fnYV63WK6HKqVc9Bsm7Ibe0ueLi/llhvcB2uRd0=
X-Google-Smtp-Source: AGHT+IEJwLByLHLx3454UYbLjABcXjBBkoJj6GgXmfduapVZtpkl1K4IlDypVnwQNSTcFJpuUHONbvejjfCVSbzWBoo=
X-Received: by 2002:a05:6a20:8412:b0:183:e7bb:591b with SMTP id
 c18-20020a056a20841200b00183e7bb591bmr9887015pzd.3.1700185465385; Thu, 16 Nov
 2023 17:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20231117013153.4299-1-aford173@gmail.com>
In-Reply-To: <20231117013153.4299-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 16 Nov 2023 22:44:12 -0300
Message-ID: <CAOMZO5CGM00kn1QhqOWx2u=Y5GLzXru2wSTA2mPVZrP6hzEf1w@mail.gmail.com>
Subject: Re: [PATCH] arm64: imx: imx8mp-beacon: Add support for 4GB Variant
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, sbabic@denx.de, aford@beaconembedded.com
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

On Thu, Nov 16, 2023 at 10:32=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
>
> A new variant of the i.MX8MP System-on-module from Beacon is
> available which contains 4GB of RAM vs 6GB.  The memory
> timings are slightly different, so a different config is necessary
> to build the different timing file.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
