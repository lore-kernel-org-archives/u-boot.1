Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7369FE92FCA
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 18:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A91F483EBA;
	Mon, 29 Dec 2025 19:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b7MXg//q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D301A83EC0; Mon, 29 Dec 2025 19:17:41 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BD98393F
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 19:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-37a2dcc52aeso100735781fa.0
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 10:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767032259; x=1767637059; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajBu2LaTqIlP18sdKI0Wo2tu+zGXE+zH0/6Xxxy0XlQ=;
 b=b7MXg//qG354rFfnS7rvZV6uvF805uYWtm0BcO+O4YesFZAi4GUzj3JP3yAKqLms9g
 p5JqNTi3InJxllbC9yhPNmsxzseaBW3vGv78HX4q86gKUxCD43ATpO10RtFf2cVmlwsM
 QJix4G9GCsfhzIhvElR37ymoStAKS4gvzO2yrkmbIT+V3dBDFe1cL6MUOa69U/OedWVE
 bx8/mwclHZI5tBGyrl9PthowbepymzNIV6IFVUyFdypoPnndAsGw6hH0bT4hb3Gdi9ud
 a+/4S34GXx+xn43RbyOcZrPnSoq6S8pWCSec+xpQ+5yrwnBWgROV5FDLGd09Ex+a2XXG
 VvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767032259; x=1767637059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ajBu2LaTqIlP18sdKI0Wo2tu+zGXE+zH0/6Xxxy0XlQ=;
 b=f/m9fuH2r96e43kJBC+tLIFO/AwR6ZY1o6Fk9C/nXZF2H46gNgf1O4I3pOyZ2iz6R3
 JtIMEeX8mdoNPbG6zoRXBnk5sosxCtV61zBrWPnoJCLnEn/XW7XbCLXjtsoYH6gStACR
 LJgtVlBbZ96Xoow7eRgskrZhuHDGhdXVRp9YS5nG1c0HoPmshdNIExabpNlLHpNZiE5C
 6LYIwGR6ooBsS2nbKDXka1CU08ZguIDcCHQylQ54xVhtvCRn6H9uTU3NEcxr/qT/ZLPf
 hwBR1To09qdleJ1A0FA1BwYbdw1ubvtc1pG3e6nZ1TD/1B/zLOY2KungspvaKFhuFbRZ
 slpw==
X-Gm-Message-State: AOJu0YysfRnN+dK2OmYdAexbS7u63NZ/XUpa+jx/bOjAoXp0HrHBrwDm
 J0+gFuY0XaqqMTEOOsq6FiORo4MvbH0VgB7KZBde6qhT+8bHpVb42E08ybq2FfVx4rBP5Irdwud
 XkfRozc8lue/FEVGdBltUL4w0Q1NnplYwHw==
X-Gm-Gg: AY/fxX54Jp5q3yCcZ1AqM+ibzfJ3BU24Xj3CdU+qLVKgelv768fi8zAlTx7Ta8uAQDA
 FKYSTKAjHnRpxign4XO4dUxNsvTsAciG0CA2aEc207QWzexMIN4oWiI+i7SzllYauGSXavp/N24
 ANoT8CZsEVXFnsmhZKSF4EpcFrj8nL4orHxNfRI8WPhn/g8sdAnhUyFc9QstQ6kPvjUh4YiosPx
 O2qwyXPvbtKL/q4SxTkDsz+T2+W60e6gxNLXaC6EIxaVKk9E0V3eekSJ7JdKdHzjpuzOl+IEFDc
 532ykOpLaAABaI21DwGfjj+9
X-Google-Smtp-Source: AGHT+IHD0xGQfXnN2RPBJduOnCILkpwrFQANWJ6fJmGvxSsy2yw8ic/YQwmTEQ0MwyUvgeh4V/8qWu0DW57htlzX/r4=
X-Received: by 2002:a05:651c:199e:b0:37b:9b58:dd1f with SMTP id
 38308e7fff4ca-3812167209cmr94444001fa.34.1767032258729; Mon, 29 Dec 2025
 10:17:38 -0800 (PST)
MIME-Version: 1.0
References: <c34fab31-6c3a-4cff-ab6a-8a6f3db2d2d4@aandtinstruments.com>
In-Reply-To: <c34fab31-6c3a-4cff-ab6a-8a6f3db2d2d4@aandtinstruments.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 29 Dec 2025 15:17:27 -0300
X-Gm-Features: AQt7F2pMM8NqxauXEE6d5OinbCgqRIprPIkdTWw6JGN9NGqVNrs_2CFJdzP9dX0
Message-ID: <CAOMZO5BLodKF5U4WPX4i7+mdBphW2cofB7oWfJYK3vPAuj5e3A@mail.gmail.com>
Subject: Re: [PATCH] video: mxsfb: fix pixel clock polarity
To: Sam Meredith <sam@aandtinstruments.com>
Cc: u-boot@lists.denx.de
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

On Fri, Aug 15, 2025 at 12:25=E2=80=AFPM Sam Meredith <sam@aandtinstruments=
.com> wrote:
>
> DISPLAY_FLAGS_PIXDATA_NEGEDGE means the controller drives the data on
> pixel clocks falling edge. That is DOTCLK_POL=3D0 (default) not 1.
>
> Signed-off-by: Sam Meredith<sam@aandtinstruments.com>

Applied to u-boot-imx/next, thanks.
