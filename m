Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DA9C36005
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 00:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCCE78186D;
	Wed, 26 Mar 2025 01:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XNXTc+zb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088AC8192A; Wed, 26 Mar 2025 01:08:45 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B651F810E8
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 01:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so8219803a91.1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 17:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742947721; x=1743552521; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dk1xxVZe7pKhSWpNEJ9MX7OcDw47+WXQn6Xju6k0LtU=;
 b=XNXTc+zbtS+nf+twYssWsK++Y8M15CGKJjKXnP+WzWVx6r7X59UPJizDLotgWN1f1M
 m2dl1eORG6HNCAm9y0CrDH4q+F7LctfkgqOd6P6PubjN/6enwKFQxnpAYS7sJPdqlPVb
 wa2G/trcclJpMQvnTGbB9qwmXonBPqNQtK+WGcpP69F6cpkFiLGUgxDSmW/WSoqAHKX2
 D3qNKEhW9BX5AjJXcPxrKmIU7xHee8limjx6vi0V5Ee7NG6uDRF2pf4wuiC7JQOCW4kb
 VVdNSUg9UWM56dW0yJQ+tkDJr4ZkZlSyJBFJMH9Zy6VnJsydyQgDYPf1Hc+JlwWxRi3O
 ZVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742947721; x=1743552521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dk1xxVZe7pKhSWpNEJ9MX7OcDw47+WXQn6Xju6k0LtU=;
 b=TvEZunzed1DNtVc/pc9gZ3hoUi9q7bBBIYmldQnJz+aqjTWKUyyPu7XC0gW6CdUEjo
 96ViliknnxcqpqSRI7O4ktzt2C/K+XLnd+5NCQjPeR0jqPNl1k9XJHXts1e7pQtjzvoZ
 LWOyJQluLn6PY4YT+vazYPrjM1zOYB+0OW2AENok1Cwe93YQwY034iI3dOsU5b9y7MwB
 wSumTsl+lODTdqHkus6cvm6Z0s59d/cE7Lllo9fHLzxDU/5jXnYmMrCOO8imfZLTXcj2
 K0hcIntnOTiagvcQZdPoW++qrO+juy6DVHQcKmnKYisR4Cx18yWXMt8cymeN830mcRHi
 q7Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUeb6UXFmYqpKQCEwOTmO24fVUFsQdVifoPeDH+Xwr8uHYfGmGiXfgB2OdTg3YWgXXsGc+ayc=@lists.denx.de
X-Gm-Message-State: AOJu0YyJI7zdu/H1gkvkEkVFRN4s2rZWfpWAL9ROyX6dhlG7fZemjPtn
 YmITfymecbzhNu06bSmOa7v5SZa8Bp6JOkMU2dHm1X+QlhXQ9WQZwWfkKi8LI1NqVmxPgkOFt3X
 wVDyiD34t+OtiNUFBXKfaO9h+PHA=
X-Gm-Gg: ASbGncsUomYlwjnHWUlzR4KwrzQkiNX2dfvMykFYUhHQOQZ0R8zmS8c/woaZPOrdeIB
 fiUIgHf6xwSeM+uXitWNdGVpf6rmK9AIfTzAWBn6IvRoHsNYbuA+ze9fcIsWgsGn5PBCl0QAwcN
 KTp6DQQ5tbGmg8nFfTOkyANObNnQ==
X-Google-Smtp-Source: AGHT+IHF1yI70rJx3OS+ToaWS03WUH5/cA6RluwTaC2Obu2QAYtSQ0ueE1BYuJajXMIqpLhI9YqX/hRdPaAD/yETa3c=
X-Received: by 2002:a17:90b:554e:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-3030fea0d35mr32799668a91.15.1742947721057; Tue, 25 Mar 2025
 17:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250325025452.950303-1-aford173@gmail.com>
 <20250325025452.950303-5-aford173@gmail.com>
 <6f58a557-d5b4-4bc7-87b0-6ed626ec534a@mailbox.org>
 <CAOMZO5CT0uevQaPWPAHM0qVULy+f6rsbwE72Kkph48ghpOSKkQ@mail.gmail.com>
 <CAHCN7xJoJYmZCG7e+zv3cJc8B460kqWpz8v-KibsVsHJzbpjUA@mail.gmail.com>
 <CAOMZO5DxKOF4qD7zknYxz=UihHSQrH=OBX3ZqUO6-vsdZoNGmQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DxKOF4qD7zknYxz=UihHSQrH=OBX3ZqUO6-vsdZoNGmQ@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 25 Mar 2025 19:08:29 -0500
X-Gm-Features: AQ5f1Jr7-JijRr0ldxee_s3SZXUdQ_J8evFJD6yfDjHE_zr5X-1VRun6hhHF-7s
Message-ID: <CAHCN7xKsqPDEb_zkF-dTWRRJPre6Q+=FNHFuWmGBE6g0e6F=iQ@mail.gmail.com>
Subject: Re: [PATCH V4 4/7] cpu: imx8_cpu: Print Speed grade if IMX_TMU.
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 aford@beaconembedded.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, 
 Enrico Leto <enrico.leto@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Yannic Moog <y.moog@phytec.de>, Gilles Talis <gilles.talis@gmail.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
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

On Tue, Mar 25, 2025 at 5:00=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Adam,
>
> On Tue, Mar 25, 2025 at 9:37=E2=80=AFAM Adam Ford <aford173@gmail.com> wr=
ote:
>
> > Once this is complete, I'll have a smaller patch series which shrinks
> > my 8MP SPL code by around 4k by #ifdef'ing out dead code.  Hopefully
> > it's not too cluttered, but that smaller series depends on both the
> > UART clock and the CPU_IMX updates.
>
> The two series are present in the next branch now.
>
> Feel free to post the additional improvements.

Well, I am not sure if it's good news or bad, but after rebasing my
changes on top of U-Boot-Next,  the SPL size delta goes away, so I am
not sure if I even have anything to push, since it makes no difference
anymore.  :-(  Part of me wants to bisect it to see what made the
difference.

adam
