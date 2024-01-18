Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE72C47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 20:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF9D787B84;
	Thu, 18 Jan 2024 21:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JTIkSY/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0A7E87B84; Thu, 18 Jan 2024 21:46:09 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C69587920
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 21:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28ffa74cb40so21720a91.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 12:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705610766; x=1706215566; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89pHHO98czB4+308yMVj790tzhWeJVE1j9c54iIkKKw=;
 b=JTIkSY/qn3pU82fgfDwyflZMNiWT0f0sVX0Kp1OSlI4+El0I0sXVbNv4UOJRpRI3JX
 wuADONl7SMeXCvGf0jzORx+TuxfPle+sJIUpHIseHU4rKqSaGf8sC877Audc9Q6IvOIx
 3zRIPAxyBvSHrvk7geYl4pDV/JD5rUxpoSugjUQ6pBo/5L5wcsdaDqbewV0aOhWI6vR2
 jOlJfFkUx4Katg1WbYzVDUW6YQ5zy0xhTOhiDQLnC0IHcf2M8P4aCYpQsF2OLT7qnvv4
 Hc1pOT/MWzuYNs0Hx2pL9LCnM6fDmmkeKPwsQ4Fj6g/JRp4/8OB55N1LxraSzSvPyDh3
 hcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705610766; x=1706215566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89pHHO98czB4+308yMVj790tzhWeJVE1j9c54iIkKKw=;
 b=aO4FfGCQDT2V2JkfBzFbmvwokRkbGtPOrh7dcdAnmsNA0k9DHneIjmXtDoAYVEbVya
 uO6O91vSfnYjgQANOuutKkOOy6UdoEi1uq7liK8gdcAoxuznER9QwCpiZW74zqXuSaXq
 rE3Ul1a4w331PwjNxCzNYSb62mcdQzGSOlOr+7S4fataRM4A83V81stj3r6io3x4c1Fl
 o1hGF07ACE6BySi84aIsZ3eOT6L1IIb/elvXF8E1QhkLfwTInYi0iRPDxt80Xny0IZ5l
 c4YSzR9Gf0/SG1smtwhiqEOMkwbVHQKGq/vBWp83bWBkw2OpOAvmz9JJtzaLezfEC4lv
 DiGQ==
X-Gm-Message-State: AOJu0Yx5v0wqxzM1471nHXuL5SbAcm7T+sqtMhlp65fvP94UxaRDdXcD
 6jp6p1hHeKlx6lvOkV6axbBrdUmColvBAmACwv0grM5nLY0RtVNONCPFFXShdGM3qjRrHPxsNPi
 huPaq3AMI3VrsXo28vjsIg4pWdbE=
X-Google-Smtp-Source: AGHT+IGOyvE2PVTttLQ9P5xchecK5cIacsFyltRDdyPdnDvwBujTUlY1XxYXtxCZM40SAQwSYQ1obDtxbRejW/MX39k=
X-Received: by 2002:a17:90a:ec0c:b0:28d:2e64:88ae with SMTP id
 l12-20020a17090aec0c00b0028d2e6488aemr298823pjy.2.1705610765910; Thu, 18 Jan
 2024 12:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20240118150640.3802089-1-festevam@gmail.com>
 <20240118150640.3802089-2-festevam@gmail.com>
 <ba5f6816-1911-4c7f-a9ca-714e2ab66536@denx.de>
In-Reply-To: <ba5f6816-1911-4c7f-a9ca-714e2ab66536@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 18 Jan 2024 17:45:54 -0300
Message-ID: <CAOMZO5ACUjbsg9ujEngSCNQf5FTJrJ1mfB4ZwA0nVtgKAfkJjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: imx: imx8m: Enable the SError exception
To: Marek Vasut <marex@denx.de>, Ye Li <ye.li@nxp.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, thomas.schaefer@kontron.com, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

On Thu, Jan 18, 2024 at 4:08=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 1/18/24 16:06, Fabio Estevam wrote:
> > From: Ye Li <ye.li@nxp.com>
> >
> > To work with commit 2f3c92060dcd ("imx8m: workaround ROM serror")
> > we need to enable the SError exception and install vector in SPL.
>
> This really does need better commit message, sorry.
>
> Details, please.
>
> What does trigger the SError ?

Ye Li, please improve the commit message and send a v2.

Thanks
