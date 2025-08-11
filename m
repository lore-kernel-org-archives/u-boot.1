Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F637CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 22:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59DC4831C2;
	Tue, 12 Aug 2025 00:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="R+C+hLXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E60C831E1; Mon, 11 Aug 2025 23:14:34 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E86831D8
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 23:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=david.regan@broadcom.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76bf3e02db4so269359b3a.2
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1754946870; x=1755551670; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HU9UJywVBhjcJUVh9qsmio5VGpUlo85ZKArhFjoVOXs=;
 b=R+C+hLXSLHBgsHWfG5yzQMFWjp+wehn4SbJM7D+BmtalbXtSskLAE9J78TfKLhVmCn
 awQ9Sm5lqVhcldcqsRlvCMRdCl2vs4465X/r8ISYME1SMmu71fKaQeff/ARy6KDP+eb0
 4SZJju8Gu2k3ovMgTN4LWLcYnKuIOV/G2uSV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754946870; x=1755551670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HU9UJywVBhjcJUVh9qsmio5VGpUlo85ZKArhFjoVOXs=;
 b=QnlrdI3/DOxBr0zARtb/ugVdyY7DeUf1/6A/Ji2zONWSerKf9yz9yCR2+L3ElcX2ll
 N3iykOkqN6RMoNeAAwKkAItnkzqEiYdI9RSFAL8LK3a0GDb+Uu9PmChFpJJ1n3xaL6cb
 s01ioGgomMUO34yaEvt0Q6ZdhRdO04nh+9owSbKbU3qzs0Ba2qW8V+PAwfRo1GFsdDA9
 fnlkjuIQXaEb5dvEESAhiUhGfsQlaHwgKuxmirEO8QMJ/fxXRsQSH9gmgXFihaq+TrjP
 GB1v8Hsd5kF5Yggq3eq2sTBfsNkrLRkmkN74s81HSpwJmrwPn84TYX/2Pqg50bMxEZDq
 21sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE8N6V4RrZgZDedeoeR8rw1x5U3dPXsgQDeFW1KQ8Om1YrmclkMwafcZqwfKDNjWEZNfeg8BM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxf4z0mhr1si4rMFCErDNCiaU7IohBmMUq+iiM8XE0oBRXBTkSk
 igwu9zF8eYsskf+OIyeYJUbqQAmbfU961Hp3a9QcVT2fKdn0/gt8NP3Etyyi0p7yXHHMDnnqG57
 SitDpCxzQVIfgeRmx0Di7T/e8/QGS1dw3LICzmcU3
X-Gm-Gg: ASbGnct8dTSZMDQbRKvBjjvmvV6mjKukbOmx4aqvDNP17Cr5X/bXNl+0+aroU/7m2mb
 nYbf6wLx5zs71XwHRdBElDjQaVztTfJa4WMECcTrVjzysBmSTnE3oN7PUeKOl3+KUpCfQkRwjOO
 L/gCzpnmnGVc2LUzMa0RzzG7uUZqaK4lZcER1L7/SXi0xsW+a/fIfOLdRfPlDxHENK5dYc4NO9r
 Gjext6T
X-Google-Smtp-Source: AGHT+IFo73U8Xk8jxEsvkNGVSQFRc53yYR4dhaDvQTsg1vr9WcZT+q2gmsWjKO8O99yVucdYShhPFbrj+MLk836mdZI=
X-Received: by 2002:a17:903:24d:b0:240:63bd:2701 with SMTP id
 d9443c01a7336-242d6ca0cdamr62929675ad.6.1754946870497; Mon, 11 Aug 2025
 14:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250806181450.2324488-1-dregan@broadcom.com>
 <20250806181450.2324488-2-dregan@broadcom.com>
 <1b0c1d33-8d43-457d-b81d-702a9f7e7bee@cherry.de>
In-Reply-To: <1b0c1d33-8d43-457d-b81d-702a9f7e7bee@cherry.de>
From: David Regan <dregan@broadcom.com>
Date: Mon, 11 Aug 2025 14:14:13 -0700
X-Gm-Features: Ac12FXw_SrLzX8ZqtgjriR2F5Nfj_9vf2Y7tpNXD5U_XtJ3kg0q2v8XWwF9KS3s
Message-ID: <CAA_RMS7+zVD1fi=CGSnNOK=ug0SjiFoLK=RUp5==g+8UN5gLcA@mail.gmail.com>
Subject: Re: [PATCH 1/4] cmd: nand: bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: david regan <dregan@broadcom.com>, dregan@mail.com, 
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 12 Aug 2025 00:17:01 +0200
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

On Mon, Aug 11, 2025 at 7:08=E2=80=AFAM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi David,
>
> On 8/6/25 8:14 PM, david regan wrote:
> > bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB since MTD_OOB_AUTO does not ex=
ist
> >
>
> There's also env/nand.c which uses this, can you also fix it?

Thank you very much for checking on this and the tag, I'll fix in env/nand.=
c
as well.

>
> Please also add:
>
> Fixes: dfe64e2c8973 ("mtd: resync with Linux-3.7.1")
>
> To the commit log which i believe is the commit that introduced the issue=
?
>
> Only a 12yo bug you just found, nice catch :)

Only 12 years? I can do better than that ;)

>
> Cheers,
> Quentin

-Dave
