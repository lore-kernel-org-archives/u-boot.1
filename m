Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CC0C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 10:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 725F987BE5;
	Mon, 12 Feb 2024 11:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Khq+iT2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B706879DF; Mon, 12 Feb 2024 11:59:41 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F198287EC4
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 11:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso1017142a12.1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 02:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707735577; x=1708340377; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmSgkQvcG80GyxJXoXDLwXOxN7cm8RWhTzqJk03C90U=;
 b=Khq+iT2T+9zi+dyiQMaGzXtbIlxbB8ztaWDO4jpao2GLi1nB2P6+k+qQ/fLplpErGD
 x9TTJ0ktmokhw+6bEYtoOnfxXPhxtJuWy1NXHiOjOHRTe5SwzyEcNY3ltQcZlWHAmCSI
 4MXdc27Kcba4YKFpyvBeh74qP9kceksIdMYhaPj6CF03VyLiqpFf8ODZwFZP80tMjtp0
 FB7ZenCuL919VZC8fWQuWIJrtl7YA3DmtqQg3UYlMThOnL5moZ9L8B7oe8ijnywvpWfo
 ruNijb3Z/vAkfIN9ZkUkyeiAXlDRkelr8HeIwFXeOkUyybQGdSN530hmqtBXggCK5nzk
 U7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707735577; x=1708340377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmSgkQvcG80GyxJXoXDLwXOxN7cm8RWhTzqJk03C90U=;
 b=sdidBMOiTQ0yk8Bo1TTra+yBowsrHJJOoiqhEJ1FqgZXJi4qFUw18pfQEWkwW8wCUT
 dOVsa83KW6/Jw8ePGNFEwus49hiUmZ4qZpBAARganDPyQzW4vspnJ/KnQtpTlMJ43FIA
 kp0DbgRi1su1KvzorZMY7o+4r+K6AAKUnBt9Btfi27fbOPWQ5SE7hC5oHzvy3p/KIrHN
 QreMYHeBSAnB7ntlwI4fgLATCMeNqF8TnCWMrofjlwT/8SxsRFVPRwRvlw1PGtGZqGIt
 zOp2tyO9JhpBDn5nD3SzP1T6AjwsPr97azuSo/4uS9Zn4VZmXiA/Spmvzo6shi6Begpz
 tTNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHmjJkX3I1NmXwa1xnHfSe3Ncz5VR3kmTepmUwlRivuHIUdAshX6tpm7TDNkR1cmXcSd07SKw/fuI37clxzgvQ2rms7g==
X-Gm-Message-State: AOJu0YzgF9/rMmQt7ipK5u4d9DDhj6Gjk3P2EHpRIFVDty1NduhzbPf+
 CSPSXKPOGQsBB7W0qPw+MoTDRL1OzAmCdGJYAQ0xLDaPUxue4XZTkquR404PLt13BYGVIIazWS3
 oCoGmNZuRY9XiScFXzQK3Q3nxMuI=
X-Google-Smtp-Source: AGHT+IHJLtQqBHhkTUjPApaQzdu4iztKkxR0zj1Nud5yacTIggH/HUaCjnl/r0u5RF5c3FAW/hCQtO897argGjBt3IE=
X-Received: by 2002:a05:6a21:999f:b0:1a0:5a49:801b with SMTP id
 ve31-20020a056a21999f00b001a05a49801bmr396501pzb.3.1707735577346; Mon, 12 Feb
 2024 02:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20240209103009.5463-1-othacehe@gnu.org>
In-Reply-To: <20240209103009.5463-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 12 Feb 2024 07:59:25 -0300
Message-ID: <CAOMZO5DWK_bLW5-_4is__8GPBvpOp1JdBDTRjbET78yzAPZekQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] imx93_var_som: Enable AHAB support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Simon Glass <sjg@chromium.org>, Mathieu Othacehe <m.othacehe@gmail.com>,
 u-boot@lists.denx.de
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

On Fri, Feb 9, 2024 at 7:30=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org> =
wrote:
>
> Hello,
>
> In this v2, I moved imx93_probe_mu to a dedicated header.

Applied all, thanks.
