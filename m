Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149B5C28B30
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 02:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4686D80756;
	Fri, 21 Mar 2025 03:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ROWogbIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659D380756; Fri, 21 Mar 2025 03:00:55 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A658003E
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 03:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3018e2d042bso1869124a91.2
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 19:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742522449; x=1743127249; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFvy2pjLOO0hplE6ptl8e2OhUdGEcUtbH91PSFCHy3Q=;
 b=ROWogbIMd/NPatzb65Zbf/CLMlaSUKW0XdE8IH5wlCvwWt9EhE6qiWXA/UYRuC/diX
 S3yvK2YC7y+9S+k9SxOD+3moq1fJsC6zX/SX/jv+F80n2glTLQJtR7SFiuEeGwTBgprc
 F0ko3h6CiR9UAAi6hV+qqV2D4wCMN3TqJ+unaj6m9Fi0nf90rdaPZfBdEEeEYPFfs0/K
 DtXDscKmPwKvsvXiwMRmT10+0S17X89eFd8b1vZquAPniZBMiwhJRpKw4GbMmsaE0tA5
 dbjorVrOjBDICK09TW3djB0ooVGekuoiCLmr8XWf5o/1S/9kPuuUPJ63tRxvUPifAj6M
 a/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742522449; x=1743127249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFvy2pjLOO0hplE6ptl8e2OhUdGEcUtbH91PSFCHy3Q=;
 b=jUGFW8i6CMRp7J6KPKByjysJrETZsvgCGbnmlfSDaI4E5Fo552OTM4D+1jssaS3vkh
 ZoH8enFug9E97/yVzzAY7g9EJmDugVAj2Azr9BrS1jp7J4kJRKpSuPQjZ5EniDI0EbdC
 0c7ewC8bOZ6zU60KWAjotiBm/TFsvuswdkRZ7U/ZlGtRT/ZWqdd1FXN53kVOg8z+ytA/
 7K1/hcQbpRMf/tcv9neWhMKi1BLz5y7zlOpwV7ejbH3vK95O32rWDnXKNh/EuWKz1PqY
 sG50ljF4grUsMvQBVJLXz2EVEelJg/977cm7bckFmGemhibwE+t5vuxnADjXz0NO4lBw
 qMQw==
X-Gm-Message-State: AOJu0YwUeJ69WpylIATDyQ40uKDQXhTP1H8LKnjldFJcOeFhBVTlHXBm
 1JfaiC8MLq47SS7wuci0Esiju8ww1YzT+uPrjf1R6TSJRp+wdxi8ucxVLi1lxYSKg0tgdRpsvAr
 4oJyHBTATP8NfrTpT2au+ODvlk5I=
X-Gm-Gg: ASbGncuIq2s2ybWACHpVsQIqxiOGq+tzuoQMZw22qj19NsRyl91Jr6IiHPf1rJGF41z
 UJ6SDwKiBMFImd2dqIdh949RGWkHMxpAUXa1Oj/wxmECiOJJexi3uomY90XDjYHpNyfh4/plOWM
 x3uX0BaxSl7il033JOGWQALmqMzT4t9N8YJ/5pVYZHBi7B91UQvVvG+syHurhw7+vI5GLjxg==
X-Google-Smtp-Source: AGHT+IFZGqa9US1Ib+X4iD1KVisjPEGYbgBoVB9qb6qcPdyYpoWkvlzhfWN1VTNKbJ8tc3aWjg4SV5SV2JGk7Xq3/IQ=
X-Received: by 2002:a17:90b:390c:b0:2f8:34df:5652 with SMTP id
 98e67ed59e1d1-3030fea49dfmr1913429a91.21.1742522449522; Thu, 20 Mar 2025
 19:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250321013109.709431-1-aford173@gmail.com>
 <20250321013109.709431-3-aford173@gmail.com>
 <7592b048-da30-4512-b6a3-f435b6f3bc3d@mailbox.org>
In-Reply-To: <7592b048-da30-4512-b6a3-f435b6f3bc3d@mailbox.org>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 20 Mar 2025 21:00:38 -0500
X-Gm-Features: AQ5f1Jp6zbRhYb4bc3AQuQnA8-AGSWvpgxq2vpsOcZkncc89bsjmZ_E4J5YDmP4
Message-ID: <CAHCN7xKStps4Cyr8=WaCU5bUY_doeh4jcUHv4XFUm7CLjq2JWg@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] arm64: imx: imx8mm-beacon: Enable CPU_IMX
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, festevam@gmail.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Christoph Stoidner <c.stoidner@phytec.de>, Yannic Moog <y.moog@phytec.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sumit Garg <sumit.garg@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
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

On Thu, Mar 20, 2025 at 8:55=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 3/21/25 2:31 AM, Adam Ford wrote:
> > Enable CPU_IMX to register the ARM core and identify the
> > speed and temperature information using the driver model.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> I am tempted to say, imply this for all iMX8M and iMX9 in arch/...
> Kconfig , so it gets consistently enabled for everyone .

I was not super excited to change the behavior for everyone.  Since
the IMX9 always displayed it, it seems safe, since there would be no
obvious change in behavior.  Making this implied for everyone would
result in a change in behavior.

adam
