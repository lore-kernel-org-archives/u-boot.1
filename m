Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D75EC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0A6A87E70;
	Thu,  8 Feb 2024 15:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XardtmlG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A64A87E36; Thu,  8 Feb 2024 15:34:38 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB8287E70
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29593a27fcaso486104a91.1
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707402874; x=1708007674; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/d50bz8sOEcLtZR4KgMIXRVRCShwz1ZQudHA2LI25A=;
 b=XardtmlGit7X5wgkGTKEqPR/EVO+M1i7PLzFb+VuBwV1HFKkb7hWLA2kwRBR+UL4rj
 DXowKTkubuAxq+NccCmyCQdjJyiWnMV5OFc96N6fSJQ9Lk+AivOswTmunms3oqUvGqps
 +qRMNyq/oL58E4/TQ9+2AIuoa4NufrWSiLxtwWovQLayi4bsio1pn1jEw1fQU2X+FKl/
 3200/uh5WI7yzcFLqPb9V1zfF739BSeOge/98n6sAzyN7VR1mQPnyL6WD4MlShXozoLP
 89myAY//LLiExJkZlbSUdbnqF6HgOBA9h1UFw2D8fIhwAg8/zWIKUiAB/rKPIj2fSgPp
 AtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707402874; x=1708007674;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/d50bz8sOEcLtZR4KgMIXRVRCShwz1ZQudHA2LI25A=;
 b=OPnhzDIp7Xq/nIvc24M4/EKMKLrhTo7WFp0I5Hy8T6WAULbOn0uky5YlIds3lBI0nF
 VX7uFxsJjraMaSHzbV19e134UGZBpZimxFwMhKocmXZY4nu2uIrzFa5iZ165D7zZrYaP
 bzufwsgU9OHc2VdYXDwDDtEBj1/fD58V2h+asbLIKzdD1cKOqEoSb5+vqTEj0uCzZ00R
 KqenTpiTldX68D7jvobqFIn4arip89cmlty0K6W0yMpEZ295wEO05d8zUCMHtlaRLf3f
 IFLzfWc6JxvYuojGD9JkXIWD7AQYvubmoW4xTR73uMfKRpVlgI1PEYaSCpOGZM1fnGKe
 xtmw==
X-Gm-Message-State: AOJu0YzN3/I84p/Vt4XNyOyLaSR/RNad2qOBeWBZRo4+q3vSMeGXJfMD
 0RWz+u/BvTkxtbfcS81m+G4W0ewCvWR1o/m3Fpt9J2YpiEIbBjZKVWnDZ0grg6tbYm2o+lEs/U8
 S4UrR4bRLdvB+KSikc/u4LHt8nic=
X-Google-Smtp-Source: AGHT+IFt13uHEAMYcteInuXM/pgRURePURspNHxG8HhQ7Qfs+JufAlhgigHz0F72h3ouWz6XzBKOhi+yUk3AgF6Jp0U=
X-Received: by 2002:a17:90b:1b0f:b0:292:e812:19e8 with SMTP id
 nu15-20020a17090b1b0f00b00292e81219e8mr9088322pjb.0.1707402874278; Thu, 08
 Feb 2024 06:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20240131124926.222556-1-igor.opaniuk@foundries.io>
 <20240131124926.222556-2-igor.opaniuk@foundries.io>
In-Reply-To: <20240131124926.222556-2-igor.opaniuk@foundries.io>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 11:34:22 -0300
Message-ID: <CAOMZO5BK0zuWF8DDqEHTk41_5eNVyFcVZA=snZd5u1FDONAxKA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] imx: imx8: print reset cause
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
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

On Wed, Jan 31, 2024 at 9:49=E2=80=AFAM Igor Opaniuk <igor.opaniuk@foundrie=
s.io> wrote:
>
> Add support for printing reset cause during boot.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>

Applied, both, thanks.
