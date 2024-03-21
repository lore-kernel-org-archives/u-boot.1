Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE92C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 12:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B9687D02;
	Thu, 21 Mar 2024 13:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XKPD8fNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 765B787D02; Thu, 21 Mar 2024 13:07:22 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8741187B77
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 13:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5a4930d9c48so70186eaf.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 05:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711022838; x=1711627638; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8kri3azyUqVhHNgMPVrh9C/xOl43RBsmDe+JLCAxDs=;
 b=XKPD8fNn8N3Pc7QCdI0VwQBiuhQVfCkL331OArx77sTtp/O+cpz0kmn2fZSXaob1FK
 EfbjQSmq+TFDw7NpmLMyf+MGUU5dPCfDLtDvGAE5Jl4B4yuEh5ksaDVG4DrD8eeySJb+
 omGxot58kiv6Ax/yX3zamRINh5C9m+ybzv5Ud1V+GhpnEQbh1g2MQyHL6T6WowoQb6DZ
 Z/R+vdEG1bSP9E8UOT8YP0/MqXnLI21VoeW70q6BhMo1GUxroH6Ob1k7QpT3Le0JLyTb
 4SqNagcJBzKe3IczybY7s4p+2/ZJuM35wBv4X0zJ3jJicfRFbLS8bPd1sH52wiQm5wYE
 H14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711022838; x=1711627638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8kri3azyUqVhHNgMPVrh9C/xOl43RBsmDe+JLCAxDs=;
 b=nUluChQu5l3/JFBhpXDtHWG9GCGbH775sP/bwQDf4RbUnmlvKDuqLZNpPS5T4sTeUL
 IrLhv91sNaphh/YIgUq3zTXCK28cUWh6Pzoz1xjbfvwkRhVBXBIN7Xb0jYrrwJnYIaVb
 2Yyts02PaRXTbd1r7RwBvErpCiJC9CCmglp86L1wXo5lPoGswT72EmL9HrDZTusevO9G
 u+vf+ClU87Q8VEWZOVLGKQD+6pk5Catolq0AWMxw1RweYwp8g6C/OqKxwPdUZUHoPcav
 vGYKto+ZF0uh6nJD3t5EXMHXq0TabkEQnO+gQKRD+6h3S9gTqtXJF7+rbfBHgl0t9UKz
 iNgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5npOHMU3xH5R7v3rxByctOofTAWILa3vyeessVilYszup0jiIViAkrMAcSi5uumUPeymAjnKsT9l7gZzBq0G6TM6khg==
X-Gm-Message-State: AOJu0YzPQEkFYhG4Nr6D1PvTHB8ZRLdwy7TyEodWNjjqkX9MbauG1wAk
 WMn7LxX4j+49M5SJdR5FaLgST1nmnPBDpGLc627TesOWqk9RVSHeW9mBoQEMjv0gwdutdLAmy3N
 Bh+A57zBbQ+zd4LXmNES7XdW7l8CIchPrCDo=
X-Google-Smtp-Source: AGHT+IFKuAx7lSDisG6dJx8eW8q0vOo/Wi9tyVSv0zJR4D7JoofUL+7aa8wGafDyY2pmjRXkJ9bZDYLYZY0/O7gHDls=
X-Received: by 2002:a05:6a20:da87:b0:1a3:6f98:f3de with SMTP id
 iy7-20020a056a20da8700b001a36f98f3demr9100079pzb.1.1711022526399; Thu, 21 Mar
 2024 05:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240321065742.32441-1-othacehe@gnu.org>
In-Reply-To: <20240321065742.32441-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 21 Mar 2024 09:01:53 -0300
Message-ID: <CAOMZO5DeXdRTMazHqK4T9-=jvoRSQBZgjiPMY8_9E25x4w6sEg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] imx93-phyboard-segin: Add USB support.
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Simon Glass <sjg@chromium.org>, Mathieu Othacehe <m.othacehe@gmail.com>,
 Yannic Moog <y.moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, u-boot@lists.denx.de
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

Hi Mathieu,

On Thu, Mar 21, 2024 at 3:57=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:

> Mathieu Othacehe (3):
>   arm: dts: imx93-phyboard-segin: Add USB support
>   configs: imx93-phyboard-segin: Add USB support
>   configs: imx93-phyboard-segin: Add fastboot support
>
>  arch/arm/dts/imx93-phyboard-segin.dts  | 13 +++++++++++++

The addition of the i.MX93 USB support in the kernel devicetree is
taking longer than expected:

https://lore.kernel.org/linux-arm-kernel/20240321081439.541799-8-xu.yang_2@=
nxp.com/T/#u

To avoid getting out of sync with the upstream dts, please add the USB
nodes inside imx93-phyboard-segin-u-boot.dtsi
for now.

Thanks
