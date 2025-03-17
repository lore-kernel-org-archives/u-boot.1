Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A935C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 14:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60D79810F4;
	Mon, 17 Mar 2025 15:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bKLefw7i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7A8810F5; Mon, 17 Mar 2025 15:16:47 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 274C080F70
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-30bfc79ad97so57645511fa.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742221004; x=1742825804; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BCaJ2oDQgOLRTkThNwhau17UCfuTTmLHNEhqblcsESI=;
 b=bKLefw7inGYscKWIibc8GtX29dgQJ/nYzKiO6g9xBsd224qIdr/epOFZ7t74ahajM/
 h8Gb5NYuGyy/pT4UeoRpr74ciu7v/HU1XuhxU2R7ertEw0jFQ6VURb663OCRUv0eaans
 WX/9UdBFF2tlmaUQ3iIOGeWhPODImCczAnlX7yOBqyGoRBoQChsJ53g3ltFIsKSghhcA
 WLXiMj6Myo2myUAfJXU3Jg+SQ5FW9p43SszwhdKx2QzAFbwlL2vj9VQK5fp+oHdk/6U6
 AHQkQK+wIACQfqdircoI4DnehBMhIHmYJsruOZ/uE20ph5ZoROnCAej8eExpSH9eKbAU
 HpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221004; x=1742825804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BCaJ2oDQgOLRTkThNwhau17UCfuTTmLHNEhqblcsESI=;
 b=YVyInQkA8eVytRKapR6/YS6JXn2uOPFyPiNw5r7aZMpEGwf5IcpKBivyfxJnoF4r7J
 highz0QklXhY6K1+UcetIOpMT52W3eg+YHdu+zbptM4tc2N5wwecTrIsWNJ4trgT5xf7
 nUSCWkWxQuROXkic15moiJlz8aIPA0EZZ5HVpy13aqy+j9T2QvKBnh2m3yqDjwZUAUiC
 B0tHW5ud7FiIiQxJA4ypizLI9FuE+f85y3XOpfIpZ8GiM13lKoTrH2rnryiahHpdVE/q
 a+15U0/gq5jimhR8cylIx1B2Ww1gfGokQBzFulmYq4vHXs9J9sgdY3ij5awVzOuCUahJ
 sU5g==
X-Gm-Message-State: AOJu0YyDzsx40g5fle1aJVSVWEqsECXHZmJtlnwzGij6ikL8I2boNxR4
 qRSrZkgtGrJkAIMpBM4rMkxH/3OnL2qOcWpkkTQtsf+NDqzugvx0ASuk2lHkuvRtM4ZuPmz1kTT
 9aY99Ju1J2UA4B2jhgZkLCE4vrRs=
X-Gm-Gg: ASbGncsL/N4IFTyli0ULwNQT1hI27i0gzcYoJJWHfzZsAdqR5UzxTPfSiG/T6SWXMTS
 BnUJPcKUG134f93RYXz2qv0/xFyaJzOuZlYgz8b+NIItBCvHR6pKE8Sf9o//OgLOewndwp7RtvM
 osfVTPPnIEPgW32tVexWY+NObAoc0KcKmD2TJncDChpimQkJSAqhiEK2T0kg==
X-Google-Smtp-Source: AGHT+IFtTmELKpREsrAOVJI7fTS4boIL9nsLtsssrKzmum7sRC+paA2bcGW/aD5WP+V/lSFarAhL39vVD/XHZT28gzQ=
X-Received: by 2002:ac2:4c47:0:b0:549:7c5f:d961 with SMTP id
 2adb3069b0e04-549c3f94061mr6462553e87.17.1742221003986; Mon, 17 Mar 2025
 07:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250312003041.110023-1-aford173@gmail.com>
 <CAOMZO5DRn08Q58PeHqi=1V8ZRv6B1+L_CB0NA=arQ2u6XUyi8Q@mail.gmail.com>
 <CAHCN7x+grtVs1JDvfth+7VdT1Xm=_GSBsr0PD1XQSPxpRBZcfw@mail.gmail.com>
 <CAOMZO5B0MgkAoBww0pPVnv4TAyqRmGJSn6hBwivgc2ZtpF+fyQ@mail.gmail.com>
 <CAHCN7xLi+MHsQaG=vyOcyM5d5ontn=+W1kL0op1HedmkbDt=oQ@mail.gmail.com>
In-Reply-To: <CAHCN7xLi+MHsQaG=vyOcyM5d5ontn=+W1kL0op1HedmkbDt=oQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 17 Mar 2025 11:16:32 -0300
X-Gm-Features: AQ5f1Jq1JbSset6JXMgI4yA7-xUB9hU5U97B3TEeuDje43yCy7853YQsVgSCbSc
Message-ID: <CAOMZO5AqJo7NgwxxonBfFDHU=C-5ksk-opRSzSXkWy6pur8kJg@mail.gmail.com>
Subject: Re: [PATCH 00/10] clk: imx: Use Clock frameworkt to register UART
 clocks
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peter Robinson <pbrobinson@gmail.com>
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

On Sun, Mar 16, 2025 at 7:18=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:

> The doc you referred me to states:  Currently, we support running
> GitLab CI pipelines only for custodians, due to the resources the
> project has available

Correct, so you should use the Github method.

> I tried pushing my branch to Github, but I don't have permission.  I
> tried pushing it to my own github account, but it doesn't appear the
> CI/CD stuff work.  I looked at the log provided from the pipeline, and

You should clone U-Boot into your local Github repo. Push your series
into your repo and then create a pull request at:
https://github.com/u-boot/u-boot/pulls

Not sure about the problem you got.

> I have been able to successfully build for that machine along with a
> couple others that I have manually tested.  Are you OK if I submit, or
> is there something you want me to try before I do it?  I have a second

Feel free to post your updated series and I'll get it to run through CI.
