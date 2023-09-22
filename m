Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BA8E7D0BB
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 01:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF42985894;
	Fri, 22 Sep 2023 03:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M2vYDx1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFFD68477A; Fri, 22 Sep 2023 03:14:39 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F05D5863DE
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 03:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5042bfb4fe9so2225350e87.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 18:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695345277; x=1695950077; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfVys3fE+DSPe7FK70Ne4/HSWHePQ8XiYD/BuHDPXxQ=;
 b=M2vYDx1Ea4dYzy+3xUhy4bfebWr3jeXVkt/X1s1YD67/QDegM78Jmnhj/3X4jAYlbY
 ZQnnmwShDMS8awuq03LhbMkcSpdM/5iL8YTN7LH1o/ewoB89vjIg0sFpeZFtDy+AdNvS
 4r14P2+8z6CEi8wG2I5Q+T5W/pjKXX0Ue4HGO2HRT7HjaylotezvTLBrGtpivKixS6Tn
 FVS9NkQxulCaclHGzf6SlBNvLVW/GTrwJPnf0Dfm4zVUrikLkYszWSfNMfeOZ9J5meT+
 26ilPU8M0P8J+3CYgW6l71+8z17QFDWixY4tyx49/XqIuhx9BfGVsuXk6lElF0MRJ2gu
 v/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695345277; x=1695950077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qfVys3fE+DSPe7FK70Ne4/HSWHePQ8XiYD/BuHDPXxQ=;
 b=Dcd3I8OeQtxppveG1aTLgmhk5ZFW3Z8SGVvhBF7lwuqIBswxHZAlgXzLpgXfw2YPWW
 v8V+zXqP/QO9y98CiKHw0Hcpup/uZbTIZ/sgziYMD3T7uv+/0u7iGAskYy3idza9DlZa
 SVv3XlKBtfT2aE7/jDP7BIM/2zCd5dJ9XJ17t3UI2sCDPaDltyQL8qGqXUEiXqZ+o5As
 jTtXOvwgh6KVxT5n8fzXVRibv1jaHcwNq+rhz0wmB3WSOD9wCGLGqmm02xWPdM3Ekpsf
 HBrMQ0rA9Ty2BxiptnJ1t7ofH3NLXRnHDTyyFmaCnqxhQbaWt1AwA5nOSdLFcnuBQ7RV
 bZ0g==
X-Gm-Message-State: AOJu0Yy8TS6F92fblBqo4xDTSpv6B3AvS0ACpPCj/yTaVHcKzwLLsZFu
 3A157qkKuFav/y1WD9zj++9m6rukaXdL3+tJ/wA=
X-Google-Smtp-Source: AGHT+IH1RBvSMlz0bMB1+k23UbiBHxVrCc+HGCPyx3VN2qbbOlhgL13jtS7Apln59JHVYSTzRSJa0YwZTxLuX0SGvVo=
X-Received: by 2002:a19:651e:0:b0:500:9a67:d40e with SMTP id
 z30-20020a19651e000000b005009a67d40emr5112240lfb.60.1695345276830; Thu, 21
 Sep 2023 18:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <SJ2PR07MB971186693F591659C4758AC381F8A@SJ2PR07MB9711.namprd07.prod.outlook.com>
In-Reply-To: <SJ2PR07MB971186693F591659C4758AC381F8A@SJ2PR07MB9711.namprd07.prod.outlook.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 22 Sep 2023 09:14:25 +0800
Message-ID: <CAEUhbmXhNJ4D9wZv6TV1cqB_hyQv9R9Ynad5Dp4YwHG-7Lda=Q@mail.gmail.com>
Subject: Re: [NEW FEATURE] RFC: Add Intel GMBUS support
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>, 
 Simon Glass <sjg@chromium.org>
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

+Simon

Hi Eric,

On Fri, Sep 22, 2023 at 6:10=E2=80=AFAM Eric Schikschneit
<eric.schikschneit@novatechautomation.com> wrote:
>
> I have begun working on adding support for the Intel Graphics Management =
bus to U-Boot. Currently the x86 bring up process (as explored on the Baytr=
ail series of Atom SOCs) relys on the Intel Video BIOS to do all setup and =
configuration of the GPU. This method of adding video support works on earl=
ier versions of the silicon. With later versions I have found that the OEM =
BIOS needs to capture the monitor data over the GMBUS in order to initializ=
e the GPU properly. I have logic analyzer captures available for anyone who=
 is curious. My purpose for this patch is a skeleton placeholder that I wil=
l be working from, and I am asking for community collaboration with this. I=
 have hardware available for testing as needed, and some details can be pro=
vided upon request.

Would you share the documentation that describes the Intel GM bus, if
publicly available?

Based on the info you provided, did you mean with later new revision
BayTrail chips, the video bios initialization is not enough in U-Boot?
AFAIU, the U-Boot BayTrail support relies on Intel FSP to do any
chipset-specific work, including the video bios setup.

Regards,
Bin
