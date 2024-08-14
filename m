Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA64EC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 14:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C4888967;
	Wed, 14 Aug 2024 16:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j1Tb7QDz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E42998899D; Wed, 14 Aug 2024 16:25:05 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E253087C69
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 16:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e01a6e5da1fso1105470276.0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723645503; x=1724250303; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMj33RJhEXycnLopncvAMyq1yVneKu7kxfKGk1A+n5g=;
 b=j1Tb7QDzboQ6XMSx2QuzhBBouW++sYwRosBpAImsMgAQQAQbH3VO7rOdRE/DORk92N
 QEytkGoohWpdJ2Dv23cOY9C4Md02/jXJxkfI3/n+QTw1RTu4Q9Q8LvWHs5Vr0KNUVbZT
 EXcIiduemEqMAF/UOKFJIT2saraRTOVmVbliZy9/ezMORBktHZ+eSFuCm4wPfi1LlW38
 DfwHYKWeGfexijqBRZziB2QLLXesR0zt7h7uhn1u9KA19P2Iu3sQ9mfrXrWbnGeq4MK4
 NouAfdeCyqP8YoBMS4fyijV0sCS+aQPn2V0+J57RrM2lWdy2RG3dP9v66AC/CgIJfVye
 CktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723645503; x=1724250303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMj33RJhEXycnLopncvAMyq1yVneKu7kxfKGk1A+n5g=;
 b=Y8TL4yJpYg6IUG4A0gQBgXOU+ZcX8sWOGizZSPgxfHZ2trVLdiNRFOLZ7l8tlhl6C7
 PMv37bcMnTwF9zFV1cvtweBsjpC5s/8GAhJ0m1jhwnMc70heJzVdKWThetkaMMdfugHn
 +mTX/Wnz67xncxz554qX3ZrDtQXkFMLB8FOR0/kGT2h5wQfO6KYVrX8Oy0cv75229yNK
 IdcTg3X83ZIPTjj5SBMaSoxiuGRmv/7ASpbdPk6mFE7j7YMz4Kj+WLU1lBgCSSdm0CFw
 BD+/8lkJAqTqRmWaUFw2FCEcWZEp886gc3S9NrDsxQmamV4gAZLzRsL0yK4yTm5ZQ9Px
 28Lg==
X-Gm-Message-State: AOJu0Yz18pVn5Tp5y8mz9INgE1mEmQv0SgaCUqAOwcbiwSNK4B6RB0EC
 hc9lV9OS41IZ+6tPe0f0zg8twuwegmiPz1HLBv4WEra3pVcgfkKrXFsMonKIqza7OzmTCC9vh4H
 VgDIpbjAqfAuEOo74hpE20zgDs3h6MA==
X-Google-Smtp-Source: AGHT+IHAa7j7b+yEKS/hskgiLKLJtq8Zl7gXmBXXUUM2EDygqk/gNLcuwuZ0R1mdSlpQjuQPAoTTY4JkT1cos2YxLhk=
X-Received: by 2002:a05:6902:1389:b0:e0e:c869:693 with SMTP id
 3f1490d57ef6-e1155c37b49mr1378820276.9.1723645502472; Wed, 14 Aug 2024
 07:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <1285791895.63856.1723639264510@webmail.liwest.at>
In-Reply-To: <1285791895.63856.1723639264510@webmail.liwest.at>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 14 Aug 2024 11:24:48 -0300
Message-ID: <CAOMZO5BWsChAJnVDGV2sfSCXtm=Xsb5rp8+1V-eq6mMDphOVdw@mail.gmail.com>
Subject: Re: u-boot does not detect and correct bitflip when loading kernel
 from NAND
To: jackie@liwest.at
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

On Wed, Aug 14, 2024 at 11:19=E2=80=AFAM <jackie@liwest.at> wrote:

> Phytec pcm052 (Vybrid vf610), Micron MT29F4G16 =E2=80=A6., U-Boot Timesys=
 2013.07, Kernel 3.13

That's super old.

Please run U-Boot 2024.07 with a modern kernel and check if the
problem still exists.
