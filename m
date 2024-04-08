Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F59FCD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 01:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A847A87DAB;
	Mon,  8 Apr 2024 03:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mCljDDrt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B6287C62; Mon,  8 Apr 2024 03:22:30 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4729887C62
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 03:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e2ae3a3f66so7490005ad.0
 for <u-boot@lists.denx.de>; Sun, 07 Apr 2024 18:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712539347; x=1713144147; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h54aNGuERwTJll74LC2cCyRYIJmGrqagH92y2y8mA3Q=;
 b=mCljDDrtCpWRRAu4jIvpxvju8QR6ALoviHRWGTI6DeWKNxbajYt/O/zlfKxLCfUG3g
 qcvCQCQ+mA54A/T9LkqG4dEmwoLAczQaBmMsMel2n3K+YScLOojqI3/29nASTqIrNHOo
 REGvhKmlc6JFvggNyvHjGSJ973hZSJ166pmYzkZuohJARQ8Ag1BFdJgosPDufZ2aKKeE
 9ylnYbaq14NlHNOQBsD+buuPrE2qWoB/GFV9IEIJ6g3YWna4l5mJO2J4yR9IchtE1xUv
 aoxaYtugOk7QvKmio2dHpRro6A4/If4kzSMIsm4lUiWhXFwfkTlW4DrcMhE5/iP9X7Sg
 Mp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712539347; x=1713144147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h54aNGuERwTJll74LC2cCyRYIJmGrqagH92y2y8mA3Q=;
 b=I9N1shY3l3NztX1DUISYQZ3UcexwGRst65/2/dY+sHhhm8jQPQe4zKeQkG2m5X9op1
 SfzRAqUduHGJQE+Y4e05FljOlcYzPpG/xMm/3ZrGytrGq3smgDWgM1anbFC7VEjoNYes
 97Sfxcv+YBu89RZkISAWGaujbkikfKg7OK6QWI3ppBWYZsjY5FRcGenRRHJcQIRmn2vT
 ULGczePYNrgUlpp6u3QrW8SqngOvClNn56guSQ+TZIWaN4T5ivdhAcVfr9XaKUUg6x5+
 mn5booBNc3mxX43raF4e7naJKsqrSNVPT9MRCaTAGqUqTo5MLbLBd52ZpYCZ9KYUggHO
 tidw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHCNT6Qn9ocv1GtNSkveZCMDU2GzN3XGbxWWBue1QvCgzryFlTmhL7pcaz5JMWQTtjoHE9XpeRQGP6TlmnxDratZKGqg==
X-Gm-Message-State: AOJu0YwFtm72ntrbdni5c/PBdEeryv4VcJVsIxBSsMkzVR/uTXdXK27N
 jxy7M7UiGbURcloZFC8FxH0QC8/SRdGbp7jlrhf3kHytB3GKj+1OTgikRbuMKEyF4SSLhzmyBNX
 bjEL0f7k+xhVaPqmGcBTgQ8IVVvA=
X-Google-Smtp-Source: AGHT+IEIYrm3I9yFq7fyOvJkHeO9O50xjxPwukE70gAHminxrjd6oTnz7TeBpVIcCDTUdzemuKTZg3nXJP3sSztd/mU=
X-Received: by 2002:a17:90b:2292:b0:2a2:afca:c635 with SMTP id
 kx18-20020a17090b229200b002a2afcac635mr6510247pjb.0.1712539346752; Sun, 07
 Apr 2024 18:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
 <DU0PR04MB94174FB9E94F1F74DA64F53688012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <87v84ta2jj.fsf@gnu.org>
 <DU0PR04MB9417E2AA315B1536D1A1D6EB88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAOMZO5Codo2sBCugD4cgF72rTqzNN3Zo0i_3HJOwNHdKYhKMZA@mail.gmail.com>
 <DU0PR04MB94177F495D562A8183C9745F88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94177F495D562A8183C9745F88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 7 Apr 2024 22:22:14 -0300
Message-ID: <CAOMZO5C1+f-=V_-o56teM65z-Z81qDGM8S2Au5OM2wDY71OQ9A@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
To: Peng Fan <peng.fan@nxp.com>
Cc: Mathieu Othacehe <othacehe@gnu.org>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Sun, Apr 7, 2024 at 8:51=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:

> Ok. But these should not be related to this patchset.

Yes, that's why my first sentence was:

"Here are some comments unrelated to the UART issue."

Thanks for taking a look at these issues.
