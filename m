Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2587C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 02:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E269D87905;
	Thu, 14 Dec 2023 03:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BwhevR1A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE32D87994; Thu, 14 Dec 2023 03:00:28 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7658587871
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 03:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so1279848a12.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 18:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702519225; x=1703124025; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nix7e/cJuUPjptcO+SHw8JvTaYWDumfsHdbjZj1TLEo=;
 b=BwhevR1AaoVwTv0D2ssa0eLsIRdKFVoc66KCTF0cM1rhbl0E/L8Y/tUxQvxzDAKHiF
 18zZ7uSTorzSOSgQ7cqhoTl+0/9sQ81gegBTiPiLDUx41MnH1znranUbXuurzKw28y2y
 7veywLcva1Mz7LjV9Y4tcGbxpsAoT6qwPmnTE5vmw+kDA+C3R9yVoCJCnzqeHp5ZWu2R
 zoukYARJyg1Exo4YEbXr5xstcgJd2yI0mVBFSg5+kJ4b3qsTZWiURVpV3sIWjPfs6oOz
 /f0Yv/aJz+e0Qms+F0TgSpOH+QTIw3d3DbOwmD5lkxQys2wEKIrIsk/q7w9fwd9VzneX
 yMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702519225; x=1703124025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nix7e/cJuUPjptcO+SHw8JvTaYWDumfsHdbjZj1TLEo=;
 b=EikGZ6VlKr2gsBHak5DaPLbUWnBL79lw5H5CofUt3ZRcJQLNrdVBFPX50UnkxWMesU
 Iq3diSo57t2/V4HaLOgEgk3tRTbR1Y79nIk/f46YONcfV875aohFSiokNA1AWhBlnVFK
 gIDfz17uJpcBBkdpq2FtNw9f274knyEvJINWtxy4c2flXr2xEWykg4DxCKrpKsmR4iNk
 73mcW4zUBAxHzYssmqa7e5ydxGt2kFARkaZvyNa3aNdCYCeM+KWV3PttRiQhxZaftOlZ
 cgyyIbRk/qAHBX+SvUFRBFYVq8lSHxb+27JTpGoe0bh5K3V95yQ5lU/g6oZ2VmCCwy3q
 F/AA==
X-Gm-Message-State: AOJu0YwZ6Br37hrTIF0Nm/91BFTNfFr0hWb/ebTetJPhAORhXGZriS6Z
 SJLm4pjExHDKJ58QesN4OzGwWYVJGPH3mn0Q2pw7lOLW2Os=
X-Google-Smtp-Source: AGHT+IGfNIVMo7BERIqlwYJOQVUc/7vCkmekUhxU6Kaq0rbgkFD5StqaD0heJiu9kWJp8wh7QfqVMYSO1RJeSq19YHg=
X-Received: by 2002:a17:90b:188f:b0:28a:f2bf:207e with SMTP id
 mn15-20020a17090b188f00b0028af2bf207emr2326989pjb.1.1702519224690; Wed, 13
 Dec 2023 18:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20231018185212.128405-1-marex@denx.de>
In-Reply-To: <20231018185212.128405-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 23:00:13 -0300
Message-ID: <CAOMZO5D-P5-6V91w3k8NEsUFa8YhG=K-f=n=z0FhM65Sh=qa-A@mail.gmail.com>
Subject: Re: [PATCH v2] arm: mxs: Clear CPSR V bit to activate low vectors
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, Stefano Babic <sbabic@denx.de>
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

On Wed, Oct 18, 2023 at 3:52=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The MXS starts with CPSR V bit set, which makes the CPU jump to high vect=
ors
> in case of an exception. Those high vectors are located at 0xffff0000, wh=
ich
> is where the BootROM exception table is located as well. U-Boot should ha=
ndle
> exceptions on its own using its own exception handling code, which is loc=
ated
> at 0x0, i.e. at low vectors. Clear the CPSR V bit, so that the CPU would =
jump
> to low vectors on exception instead, and therefore run the U-Boot excepti=
on
> handling code.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx next, thanks.
