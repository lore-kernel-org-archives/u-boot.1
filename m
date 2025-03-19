Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42A8C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 17:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65939815D1;
	Wed, 19 Mar 2025 18:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HssbHQch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8CD8193A; Wed, 19 Mar 2025 18:29:32 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AE1B803CC
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 18:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso9031309a91.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742405368; x=1743010168; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sCFZqQd7eaEP17lG1jShRaWt9oIgU2xmQ5UJlZb7S78=;
 b=HssbHQch8hn2adM/mlQTw/LsHa0/yc7m8KjATkyai6yPlcpRpjMHiTi0QTxDc/sGWD
 O3rL90dFWykITl6S6Ffasg6o3+K2i2Mv3U9XFbnteAT1L3J/5W55v9q9pGq19qeoCHrn
 8dpEV56jILB03RLvd1iXkODVXZBW8VQc9Oia3gpopEyXtD9r9xy4RDE4gKijF8YV2iBa
 McIssGR3QIAbE7cEu+OUsjswgIk020crD79Vj5gS0XxbDbrDhUL1WxliR+gK/Nrkehke
 Wuizs53kphpi+NmoPYaOU6tXaUgfSPt+aYNMFaLFXaW8LLQWiYwKrnJjsf69OkQuO0jQ
 kleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742405368; x=1743010168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sCFZqQd7eaEP17lG1jShRaWt9oIgU2xmQ5UJlZb7S78=;
 b=jmjy+xwFj25R7MfYKlF/BS/XF/2mBB8q7MJK74i9KowpRD1ssjzl/TmwG12YNv0XQa
 Ocw4KYdnvdV2w49CTer0Qkx5gpagGrGPKrXRe/w3Xr991CUfP9awYczs1lD8gFVyhgNo
 obeNHhALTgQqmsS2LlBlubfaFo8dlkfF2/fBomWVtwUSiknqrUhNukSp3F2SCg9NsEfS
 uo3NQCSq9AsFfTapelh6S8FstXIOrkxffmZy8YmDtBB+tve0tEOVCSG84BZGL5/5v1jG
 k2TLyj22eOXs7a6kiwG3xlexBFPsVT8XD2h+mEy6ffNSSqC+aUd442WuB4Qcn9nkf/Ta
 SMlg==
X-Gm-Message-State: AOJu0Yx/sMU7SaPyOc+2K9kgJ08rMiVGZ0ateefsz768Ev7k/UyRGIy/
 F8sGAsreLuNuM+GqjQmv4c77GFchZLClZy3GkR5Jh3rZuegBQXbf44Wn2olT8SKanXMls+oSNLe
 gxQ6aOOvh+j4P6TD5ZCvHoDGyuQQ=
X-Gm-Gg: ASbGncvt9Z6YfQ8+LTWvIk26hPjztB2ISaJ67l1YcCEXGYhgVoqWFEJBu6C9EdWDetb
 GW/3HSw/NHn5JzKsJ0of+PR1dBXIXOy0DWt/3kViVMnssWfifRmF24p3PGxDpP8EuNscJLAMvN8
 RQypUuhUqt0lRONtjBH7Xlpj5CPA==
X-Google-Smtp-Source: AGHT+IHCfNlb0teUJdJFIF87uLOdScDDjyq0g2jhQ5GMyTTN91doqEK0YwRb6KKEGS0lCysfn2MhKOS8HTS9laCJKvc=
X-Received: by 2002:a17:90b:1802:b0:2ff:618c:a1e0 with SMTP id
 98e67ed59e1d1-301d534a003mr102230a91.29.1742405368037; Wed, 19 Mar 2025
 10:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250318233849.587520-1-aford173@gmail.com>
 <20250318233849.587520-2-aford173@gmail.com>
 <CAOMZO5Ah3zG50Do_kGx=63RmX16hFrrgzsBk6Zgm6tQoB-VTLg@mail.gmail.com>
 <CAHCN7xKd2geEkK77kYBp1jQJpiM_NNpTPP43ONNYsUNgEtaVrA@mail.gmail.com>
 <CAOMZO5C2dnenrhcUgRaKYuYPtDbKgvXQO4JQT34GPXfek1Mh8Q@mail.gmail.com>
In-Reply-To: <CAOMZO5C2dnenrhcUgRaKYuYPtDbKgvXQO4JQT34GPXfek1Mh8Q@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 19 Mar 2025 12:29:16 -0500
X-Gm-Features: AQ5f1JpTrcXKtbIIhoKDdiCH70ZZEw_s2ExQaOe8C2VXGjy8Yri8IIgjevj2iDg
Message-ID: <CAHCN7xLGB9_uPsHqjZjD=Uw4D0WKhKecqwk2j9r-wnw6kqcmnQ@mail.gmail.com>
Subject: Re: [PATCH V3 01/10] clk: imx6q: Properly handle imx6qp ECSPI clk_sels
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Tim Harvey <tharvey@gateworks.com>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Peter Robinson <pbrobinson@gmail.com>
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

On Wed, Mar 19, 2025 at 12:27=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> On Wed, Mar 19, 2025 at 1:39=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
>
> > Sorry about all the noise.
> >
> > I think I forgot to type 'git add' before the "git commit --amend" so
> > the fix didn't get applied, but because the same file was shown in the
> > commit message, it looked like the fix was in place.  I'll have to
> > confirm when I get back to my build machine.
> >
> > I'll manually build a few more mx6 platforms and try to spend some
> > more time trying to figure out the CI/CD tools.
>
> I have manually fixed patches 1 and 2 and now CI is happy with the series=
.
>
> No need to resend it.

I am sorry you had to do that.  :-(

Thanks for help.

adam
