Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D812C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 12:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E660980F4C;
	Thu,  6 Mar 2025 13:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F5ZTllPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F0980FE1; Thu,  6 Mar 2025 13:38:44 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C7B6808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 13:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-307bc125e2eso6400781fa.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 04:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741264721; x=1741869521; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ITbBpIrgJwubn3JwKu3KxSc3TrtYlCxK/ZbB1PJ7hM=;
 b=F5ZTllPCCeeVYX5Z4gI7WtK+QWpp2akfj+rJ7fhXAtMxpqTjgbKFcaMDLQLZtLie0H
 oMy125kCDx74nH/sQr33bXjvQB1GYUn4WbBDh1KKDDrgrJA/9KRw8vh+542L86XNREfZ
 1iR4hft3KkmetWY3rA4+7Uy6YvhlIhKh2QK8xDtCobcs33ndp9/adhf/YtzcSwGzvf2e
 vhxhwgtEAzBfjXjMzryl5PeY+932YDQQLxlv4haqzzAV6ZSDDRQx8myMEuHF2A36PqqE
 ff9niUsau52FV9GbXgLeRSsfpZBQ/C3VPf2jxqsDAtcJbtlQFCujbWTvZ0WOpt/8Bf9z
 L1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741264721; x=1741869521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ITbBpIrgJwubn3JwKu3KxSc3TrtYlCxK/ZbB1PJ7hM=;
 b=N2albAvgmdVmmaXgjLcgnJUCCS79pimBQAW6u91AqVV1A+0mOhS0imHF2ieV9s9Qg5
 Txz2o1NEK53Upy5LHDY9XHJpU5Z8ma14I6JK/v9Ij/ZYdSIxIkO3DJLZ2QpawTfCpeQJ
 dsEqcPBDVRkQSPxdZWszuzD1j0d8H5OP/tjF2QGRQVVUSpGQ9UTHsLaFghWWJUVLHuqu
 T8HJgHPYorY1gAxt00qiyt7oB5d8su7Qn7XhorTlra0vujrPYRJD8KSNMGXJZDz9qI5d
 Z8/MgYilMkrMZpWDSW3v6Bbue5VRvAXVfGZLcaO8XcdYROERiB6xeSRQR6btC/jscxci
 pOpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCNGMuMI9nRIBw88pUdml3xFmelB+acpRcpg7Rmg55DYZ5m6pzRk9TUWYXwxXNKO6HmcCmcno=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/l7JZHk4bZ+LMCnrkCYf81PkeASqiy8wV6YQ29IVlX09a2CSl
 2tfZ3iU0g9Ke83bP/xKES2O7oGaWMPM8XiEP7ydx2fts/syEvcMkMHj6x0+GRXLsuXsEcKtdzG9
 uZPElUJnAeNG0I12hwPVeytgLU1k=
X-Gm-Gg: ASbGncuwTZfiiXTDa36KnrGkoSSesTAOcLuan9rC0G87FUwz8m4FpzZ5FPamo7iEr03
 yHyliZvPhGm+9j388eMX/J2JEUiAEfTtLOSnYLSCl/Rm5lphfdqjCqcxATaEMne07RJ0SVDDYq5
 XFS1hOHKG/W+9U/FheG858BKAaJk0ONYfP1DSfRWZxQ4USYwPdSKlTu/Dg
X-Google-Smtp-Source: AGHT+IHcnCSesxNRn91tS1Fh0U9PBHnkzpjV5R8w5IWnev8VRtBpmh4Ow2Z4ACipjgnlIWCbPDyDiNUD9CtJdFMSm/I=
X-Received: by 2002:a2e:909a:0:b0:308:e8d3:7578 with SMTP id
 38308e7fff4ca-30bd7afc8e5mr25573631fa.35.1741264721167; Thu, 06 Mar 2025
 04:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
 <CAOMZO5BTCir859QDcR9XEDTnc4JnMHdCSLXTe94Z9z_FY5bwbg@mail.gmail.com>
 <20250305181703.GW2640854@bill-the-cat>
In-Reply-To: <20250305181703.GW2640854@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 6 Mar 2025 09:38:29 -0300
X-Gm-Features: AQ5f1JruN9m2UNKfKFO1vgji-I8R2GqTHPOzrtS9kO_X7UeBd2F4epSnaqP7k6w
Message-ID: <CAOMZO5D_WeB+iv3YzVeBbfL3o1Wr250aM3+phGe7i9Luus9uzQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
To: Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

On Wed, Mar 5, 2025 at 3:17=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> The series is delayed until someone has a chance to look harder at
> what's causing the handoff test to now fail.

Ok, I marked this series as "Changes Requested" in patchwork.

Miquel, please make sure the next version passes CI.
