Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3610DC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 18:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9B7878C6;
	Wed, 17 Jan 2024 19:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KsPnBOHW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A2C8878DA; Wed, 17 Jan 2024 19:49:17 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7543286DC3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 19:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-28bae84fc2eso2153115a91.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 10:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705517354; x=1706122154; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctSkJpVZQRM7jfOxofKKOWJBZP4TjejrZDt0gxGzp4M=;
 b=KsPnBOHWb1k+U4d92WbFrIrcxS8d5gXFBpPxXjW89A60NC6CLUAk2NCllUBBtCAQ3X
 5+dhkbLNc6PJ0Kcr+bWINN1Qw3XjOuTtdyeVWs7q2DYrBTKUYh621Q5oTcn528m+p87T
 JuYre7llFpRON/ZpcofYpjIVRPd8SwM3BKIhEFEqYyu0iynsr3JiKwH2E/fsEhhWVT9M
 riYjfitX6ZT8X88mojF5nHThWDHDmQhISNYqzsZBBVKw4YPYuj5mwhhJpADXjob4Kr9F
 mNPUKU97wllpSQ+Rf4A47Go6VVADe5nlXaSS+R88Xjp8biTmj7komhVj4lp/NKZQlNtx
 aZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705517354; x=1706122154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ctSkJpVZQRM7jfOxofKKOWJBZP4TjejrZDt0gxGzp4M=;
 b=U1UUCWmPfJAgYQZ0gKKyoQpiMwJSFFMByAxn9W6WUeCfSOYvlZxUpwKhQLvUEe1Fvr
 WKz33qHAMZrblbo/n0Zj7tOP9azn6GtsnZqvyI5PZWEkpWKsYbgzpUgfAnblv771JS6r
 a2ZDv4/Ft4GzRdI2Qc7c8JeSHARO+Jvmk6J1z5R4ZVVAp59HVyo5FJ3LKPGaxzLExTS6
 d7HJU8aXMi2uYPqdJP64MKQJ16oiKHUCnBK5rz5H47kwpdyusJBupVguDkY4tVTGFdWM
 bSgnr0OWAt4/zTEQ4vAtk4e15XYEi4f1bHJj95P4kRWSd+H2Tx//BjbncxBaxLLUiXAl
 +3/Q==
X-Gm-Message-State: AOJu0Yz8V0rJmSVub+d2vlLp3lGBXY38o1lMTqv2j0In8HQP2d8aAhvi
 /3t9GPLbJ9FwHBqC+sVyOZ0fnOBuuM674COZMkmh1UmZq2U=
X-Google-Smtp-Source: AGHT+IHufdE8sSe3kj5RMYrumQ4BWWuI1Qv3TSkuAk6V3r7ek6sZ0WvebHjUIoe8yFmVeeVOYLuhii2OpGZW+OdfQL4=
X-Received: by 2002:a17:90b:4d8e:b0:28e:8e5b:73fd with SMTP id
 oj14-20020a17090b4d8e00b0028e8e5b73fdmr4149171pjb.4.1705517353609; Wed, 17
 Jan 2024 10:49:13 -0800 (PST)
MIME-Version: 1.0
References: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
 <CAOMZO5DTw2uU+uEmVLR9nbFkR4QPgmhuY9VUAz-sgg+GppMG9g@mail.gmail.com>
 <0934648988c9444aaf85f2e3163c0f4b@supermicro.com>
In-Reply-To: <0934648988c9444aaf85f2e3163c0f4b@supermicro.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 17 Jan 2024 15:49:01 -0300
Message-ID: <CAOMZO5Cy8as7b_cup6J+PYbN-stkj4Vz2wsLB_1=NN3vx5SVWQ@mail.gmail.com>
Subject: Re: Could you please help me in resolving the
 "arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset' ?"
To: Liu Wang <liuw@supermicro.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Wed, Jan 17, 2024 at 3:25=E2=80=AFPM Liu Wang <liuw@supermicro.com> wrot=
e:

> 2. You are right. I have not exported the tool chain.
> Could you please share me a link to a readme in setting up the tool chain=
 for Ubuntu cross build environment ?

You can do like this:

export ARCH=3Darm
export CROSS_COMPILE=3D/usr/bin/arm-linux-gnueabihf-

make cse_ptjob_cb3_r102_defconfig
make
