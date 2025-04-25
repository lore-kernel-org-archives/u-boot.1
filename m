Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE03BC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 11:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13AB98205A;
	Fri, 25 Apr 2025 13:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e11pNS11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 098CA81E14; Fri, 25 Apr 2025 13:52:11 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D0D381E14
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 13:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-31062172698so24577471fa.0
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 04:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745581928; x=1746186728; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/Gwd10UzpgQXQjWySgA5HH2yxEs4d03ypyCLTAedh8=;
 b=e11pNS11jgd+ssrg2mbJ9eAreyb6ALdElgS01l6BOtDg3N6hHKk5TmfXU9d0q2QfTg
 pps4LkSqTpwqVEZtZO2RiFPq+CpE5a6aU7i0KVKwxDdR+eUr8iaS/MapxM4SXClEuUrT
 A9zXpO1YnCRF1WA/3eXdSnd8DlJvdaf8V6n2wWjMZWhbq6lj1OEmJoR3Du2nGSRrqvGm
 Cm3q8GTr95xh3daiNn9SA/XktHqJYafBtRcX9/a5O/BM3m8dlx0WLZFVp/WP152TkonL
 Mx+I/ihhNf21wpdb4Igk/CierBBLPe1Ak6y2nyfNuIE7/FaIVI9S2JJRbV7W5U6ESLQp
 +tPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745581928; x=1746186728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/Gwd10UzpgQXQjWySgA5HH2yxEs4d03ypyCLTAedh8=;
 b=qR6OVrUVnxdu/WmbDm6PI1tA6Iawn4ltbxcyzwDGKUWBZiR3uDdFhrwo2ZechOii4T
 trhXZtGX56oV/NblJb3eWa5pF9HJuWRs86Z8ywHNR2C85XrQVYm0R9MP9yseGJXoj4ME
 a3SAZAoLqfmTpo/4y4+ul4lWlaR+n6VRrbJyjPWOpK24x17yOJKLRQntag6L75bP6q8G
 NjYnlFQUCDzV4Of5ntdVRnvIQqT4P+iRwF4SfBVC/GHnNGq9gTwkOVYDhuqSLop6eDuo
 JjTUc9xB0ljBxSc5NsIOR83HEx7zhbEI9qaQPV+QTeu8FWa85VpXy2L0sBC3e820D4+d
 SlYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+jDfqvKL3nrxEdBfE+7OPwRY+fhT1m/RMokFOOxsUWpYsLFQvgVEJLLfL4DFvlZsv8s7ZLVI=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl27azthLn9dtn8UGg2xQZpbS0jW75fpaC0mIEXab1KTnRblg5
 krUbfMbzt220JFVYVzaAJgi8WRKg0SlL0UNalSOukqYD/vDpb+nQkxLIgZU65qDv6NHDJ+CC1Xa
 +aLEA5h2VI57cHu2NtiGic3In+Js=
X-Gm-Gg: ASbGncvW0YHukRPuVdWLfuWbaIu15vPqe12tAeMDLDmyWziyf1lLGJUrJ4mxWne4RMm
 DIhDrRWVRdwbZsE7bF3gqnC96ZaZEBX3/sy1E4yXxI/ZnT+FBBtTB+QFIPTobWX0wl03lcDi5nS
 M4YlO6gUS8CI9A0CSbXMKtOIXWslZ4nz/HCeWKsb3GWmLeHnB+NaJNoPWRm2UiALxb
X-Google-Smtp-Source: AGHT+IFQCBtl6vaZ8hw49AMkaIZmk60gJAV79+YV7jDnsx4JkvnL3k3un3sxVPre+dbVsh3HUIzDpiilAZ0O1An+6Yc=
X-Received: by 2002:a2e:b8d2:0:b0:307:9555:dc5e with SMTP id
 38308e7fff4ca-31905976560mr5439931fa.3.1745581928149; Fri, 25 Apr 2025
 04:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250418210430.27458-1-dullfire.ref@yahoo.com>
 <20250418210430.27458-1-dullfire@yahoo.com>
In-Reply-To: <20250418210430.27458-1-dullfire@yahoo.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Apr 2025 08:51:57 -0300
X-Gm-Features: ATxdqUH4MGjmb1FRXkc1oXAX9KycDt_aMGumDMB26YdKNnqF_TiotmqNHgcpNVQ
Message-ID: <CAOMZO5CTPqW-KP0MbemiHbL3X9C_TtXUB4NZECKPemXHB=HGDw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add FlexSPI support for i.MX RT1170
To: Jonathan Currier <dullfire@yahoo.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
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

Hi Jonathan,

Thanks for your patches.

On Fri, Apr 18, 2025 at 6:04=E2=80=AFPM Jonathan Currier <dullfire@yahoo.co=
m> wrote:
>
> The nxp_fspi driver is missing some per-device quirks that are needed
> for imxrt1170 support.
>
> Fortunately, linux (where the driver originated) has since added support
> for these qirks.
>
> This series cherry-picks the linux commit, then adds the imxrt1170
> usage of the quirks.
>
> I believe Jesse Taube is also working on this problem for the
> i.mxrt1050, however the patches I saw were quite a bit different, thus
> this RFC.

Jesse, could you please help test and review this series?

Thanks
