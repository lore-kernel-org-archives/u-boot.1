Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DB1C4167B
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA83877FF;
	Tue, 12 Dec 2023 17:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fd8klEgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F0D87800; Tue, 12 Dec 2023 17:32:14 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89DB3871DE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-28ac13259afso177202a91.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702398731; x=1703003531; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGsXfk+c0xao9AJJvE4QXStq0mUy2qc+daspyFbmSsI=;
 b=Fd8klEgtQvzyGuGm1KIODNvu8bTvi4GKm1UyQCPd2VZ2YW6dawScWb4wHnyHcvhJue
 zr9uHZyvvMefYh1GMlQBNSq1nJBbkdmFpDw1ls2XxOgR5lVp3pKFGapyrO9CI+iCmwYG
 vfbpS9z4IH0psx7oYrEZQn8dvcqfD9L+K+ufO9r0jJJJRa1IdU6myipsqawr0v7yw4v4
 J8lsWCOteL1oPxv06LY/uieT5wUWzBAdaQcK1WMu4dtjuaRN0I19Gyy03s6AfpOQimwu
 ZAvPE8WRPvjN3f/Qw1L9WMCdTeIJ6cMSk1P3E52dpZXBJjxyKx4/ZKzkCn4pXC/rVOQG
 aQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398731; x=1703003531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGsXfk+c0xao9AJJvE4QXStq0mUy2qc+daspyFbmSsI=;
 b=evkX+yIbTkP7May2Hew+vUKZ1XIZPkCCmuxHA8uIFX9RTbKkndBUw0th4+KGrm/917
 TjiI/n7N+Lu+fBaZQzDpF3JSiMnr51Y1OBEpDLbQC4+dQ9N0w07IWVYnhWx/ar6xanNZ
 aSX6G/VtUZTBa3kPAyX19d5Eg0R4elK3IqRYmE+Gvuu8oLAr60ePERAwjjXBvT/VmEn9
 En3AfnFLtvt6X0h+DIl3p20NhwuKWHqeMeQJchLWyAHQ4Z4qlPdumFI2+eeiFp4RebzI
 wAn61krA1SV6STwhbmGAVZOOiBA+PzmFLqolOSYUnjjl6hG3R9ZAfe11aLqyssRjb8tO
 2rlw==
X-Gm-Message-State: AOJu0YyfsAyHbBuatyTlKLpunJXvyNm2u0XDCeLI4MRL+YvCFe4PxULk
 L3h9A9A5KeD+LY7PHxiTLE/YGn42pSeE2Wvh4nZYgGOV
X-Google-Smtp-Source: AGHT+IE7sH5Ric551mb7CzfqX1FDkAx802uZvMi/IsL95RRx0u7kLrrwwc3YkllFvdScQKrz8xr7sBwm2FboVYk+MM4=
X-Received: by 2002:a17:90a:7e86:b0:286:abd5:e061 with SMTP id
 j6-20020a17090a7e8600b00286abd5e061mr11213304pjl.4.1702398730919; Tue, 12 Dec
 2023 08:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20231117150044.1792080-1-miquel.raynal@bootlin.com>
 <CAOMZO5AwuiZAohLhRwFQx-UeL5eoxfCgVqVvM77+4eRKbmt6dA@mail.gmail.com>
 <20231212172130.2193caea@xps-13>
In-Reply-To: <20231212172130.2193caea@xps-13>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Dec 2023 13:31:58 -0300
Message-ID: <CAOMZO5CSyok7RD+vGebkgv4F19BuXWAfmzmG3yUB6JniDJ3i9w@mail.gmail.com>
Subject: Re: [PATCH] tqma6: Fix DDR configuration
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Markus Niebel <Markus.Niebel@tq-group.com>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Miquel,

On Tue, Dec 12, 2023 at 1:21=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:

> Thanks a lot. Any chances you would have access to additional
> information to explain how the network vs video pipeline
> interact without this patch? I am eager to understand.

Unfortunately, I don't have additional information on this topic.

I think someone at NXP who is close to the i.MX6 DDR controller design
would be able to explain it.

I am adding Peng Fan on Cc just in case. Or maybe you need to enter a
ticket to the NXP folks.

Regards,

Fabio Estevam
