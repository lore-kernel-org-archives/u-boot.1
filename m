Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE562C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DC0875DE;
	Thu, 26 Oct 2023 16:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dODxfddk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2EE0875E5; Thu, 26 Oct 2023 16:11:45 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937458745B
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-27d5fd02e3dso198448a91.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698329502; x=1698934302; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkEormax+IxtvNf8D+DyTfh5yBEFi1/vj3K5Nm3yFvU=;
 b=dODxfddkwOAyhiaO2SidWKG0Mv9bXzDobery4zWIj5ElBV+oYOjeEMYxi7mANjmdLD
 PgRdCJ/o08Xi5Le+J5JuMgtShdZfoKnr+n7B2ffLI13E3ijKu3yKqjx/lCh0FpDHdK1g
 7Xtfn0XYB/uFxUCrOaCphS2yR0+h1D4yvBRvvr3uisQAWjDPPlB8MpKdm0U0wyBOoKNg
 4bkTR79X9DDfQVvBY7KF8t270KKjXW3KAjwb94ap6VFU0PcXyf1H0VW+YMvLPy5o1V1T
 1pNd8q2FO5ri4EGk8DlTNyGgYgoiqpmIB5S5F1R8xmKHTL6PIjaYRCrn9eIrnyvlAiMI
 oWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698329502; x=1698934302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkEormax+IxtvNf8D+DyTfh5yBEFi1/vj3K5Nm3yFvU=;
 b=tJ+a1jrj9AKMkAwautA7OUPSogU6lJhbftPrGoFQRoj+vXnohM0QnavsdIsHodq0hu
 7Q7BtBzvhvyDdc3x22pBKIwckNTfGz0MK8p+vGhnOtMQ63AJBeOIKA38bqC+FLn6WAIf
 E82tdkSUmmbUMswc7bZu82dOyxV01r2sFfclQ15l3a5WNgyw9S775KoMSexvG7NKDzPg
 xMhaySOo+7Df05cBUKTFVpzEkJszMgnX9Or25IBkNjqFn69aXdXxhiaHHkrCqqlVzf0c
 eXl4HzOjYscsLwkfvWbFgfYHobDzE/vhuHI2PL1VEmvG930Q2xMcbwGlG5FZ5tZjtUW2
 yKCQ==
X-Gm-Message-State: AOJu0YwQZ0U/jIKWYpmNpM9YgqbGDBDlUIorLf2aDWNbAIxoQ9MrZKN9
 Bk3G3mfEJKvCmMGd1vOQrJ0sulhCyeDL8uQyg+ndUc2jTmw=
X-Google-Smtp-Source: AGHT+IHaWOykSwNbyoNaxPqyyDi19k2SBSu0svsfAbpYmRBYi1wRmVGko7R4IFOmtsSLdNsFu7XKqkazw6EMnHWEX3c=
X-Received: by 2002:a17:90b:1bc7:b0:27c:fd8d:164a with SMTP id
 oa7-20020a17090b1bc700b0027cfd8d164amr20985622pjb.1.1698329501763; Thu, 26
 Oct 2023 07:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231021123947.434-1-egyszeregy@freemail.hu>
In-Reply-To: <20231021123947.434-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Oct 2023 11:11:30 -0300
Message-ID: <CAOMZO5DkLNRv49o9HJnd_=fPRwYX+W3OGA672TE97nm_xAwmiw@mail.gmail.com>
Subject: Re: [PATCH 1/1] [u-boot][master][PATCH v5] pico-imx7d: add baseboard
 SD card boot detect
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br
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

On Sat, Oct 21, 2023 at 9:40=E2=80=AFAM <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Technexion PICO-IMX7 SoM is supporting USDHC3 (eMMC or micro SD on SoM)
> and USDHC1 (SD on carrier board) to use on any carrier board like
> PICO-NYMPH. This pacth is intend to take over codes from Technexion

Typo in "pacth is intend".

You can simply say: "Based on the U-Boot version from Technexion."
