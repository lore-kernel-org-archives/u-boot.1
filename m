Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FA5C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 02:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA6B8764D;
	Sat,  2 Dec 2023 03:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FxWlV2fk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD548764D; Sat,  2 Dec 2023 03:28:21 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2702869DA
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 03:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d05a2307a5so1866795ad.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 18:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701484096; x=1702088896; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFmJi1hafRwbJ059v73pKBOTRJHDMrgVNTxpFQ0WWu0=;
 b=FxWlV2fkRVu+7InAeJqisAoTLXxjuVjAmeXFPywACbcMlGTy/rBT15Eu8Vyv0OC5Tz
 gKcz0A6/kMD3c7q3zxuvU5eqW138D28+1kOwi0CZOFNDOzfIcEVBx3+qg1RAvIdE4pl0
 n6BshbmzngtWqkXz1ZgaY83JMi/xHIgzID4YnRpI10q6LlUWIrEQGu+klr4EjPIvxWAB
 L1cu3azPBIc7ep0ZHq9ZaeWW+t51+MBxk+sK7Ojh4NWgrGyTpv/0+z+O4h2akFDzIJnz
 R2uOnCDa82MAwOUncjT/hjWHR4kU6zY9Zwe5afe+tw66xxT6Fav+8iDOhZUXQ0NnuVb9
 z/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701484096; x=1702088896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFmJi1hafRwbJ059v73pKBOTRJHDMrgVNTxpFQ0WWu0=;
 b=Dv/BUFKHO6xzrupYrMeFqtUEI54oRe9PFoQFSaG21Jeamb6542lntfCjHVT7rJ2zek
 PK6M1vhTEdrZLIN29ZYXKoh0WkOfVwh77HGaM9zvqsRvT6Mvde1blP9URjyAsQpGxO5X
 n3RnyACI9nB43pejOJ94Xd33bZfRVe8nyc9eDdGw4QIrf1uuYHkfBVF4sEEGAX3kPph3
 OqcW+dDWREMAdm4Oew60ojtqhf4FgS39+LvswA7wPVr6uK8JhdxcZ4fAdfcLoVPKIUgv
 2SyEqvTFQ9RUk2KGIf3f/4GD1bPYFWhUFofvQoOJ08cLzyHBs0qcLhYESjNPu7BrqkIv
 U9gw==
X-Gm-Message-State: AOJu0Yzzmryy6/5+YXUeek3VPCoMvj4myGxNSd3sT65rRLbGei0VJM3f
 OoTud1wNyQiRyFSZr5VuTZ9hy/0anIFk4bpxScE=
X-Google-Smtp-Source: AGHT+IFvlSUo1WPwbCElsJ/QXnMJM7hv8qFZ7qsbByA3jOyO6SMgxUTSsqHiIElPjYvpVikvF0ioxTbDb24OcraSxYQ=
X-Received: by 2002:a17:902:e80b:b0:1cf:a718:384 with SMTP id
 u11-20020a170902e80b00b001cfa7180384mr27891943plg.6.1701484096199; Fri, 01
 Dec 2023 18:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20231202015620.213638-1-marex@denx.de>
In-Reply-To: <20231202015620.213638-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 1 Dec 2023 23:28:05 -0300
Message-ID: <CAOMZO5CpcU2WNpRVja9OB40Eokw9=D=zrKzp6H8SmdUDiu06-A@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable CAAM on Data Modul i.MX8M Mini/Plus eDM
 SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>
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

On Fri, Dec 1, 2023 at 10:56=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable CAAM in U-Boot to make crypto available early in the boot process.
>
> This has a side-effect that in case an older kernel version contains a
> broken CAAM initialization timeout code, initialization in bootloader
> will help that old kernel version function correctly.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
