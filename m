Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D305C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 12:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4339D877BB;
	Fri, 19 Jan 2024 13:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WTSa2tlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D232187BB5; Fri, 19 Jan 2024 13:59:55 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B946487561
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 13:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d6f7879fc8so1254235ad.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 04:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705669192; x=1706273992; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h5Zy+zXXe8XFW9Ly5OfsknWFLFbjN1n7eu701cHrLWA=;
 b=WTSa2tlHgSd0hBf4M9AbFCT/WeQ/EOOG9EGetrEIX4CRqIsiujn5bcZa0UyApIn1h6
 GHGtf+6ECFQJbBZJJttHDSt1YOK72xMQ6Ov8uylQ0xNXgPuu7DFiz0oIiiHXGNMwDKk1
 v+q9iUdhiXa1+Nnsj7rJ85zq9XG9PyCtKAdOoaejnsRdOH9qs3WErEYZ/k2ycEfuEr8M
 OYeRicLbYu4pFuoR+x1oDHLj3K7g59qx/BLJGWzVlTdUJzms+BMiT5nxiSJw+57SpOas
 LnLEJ/TSB/32vFZ3LczZPftzNbNl2QZI6Mbb3xvXbsbxFSfO7JqRsDPEYzQGyYmQkthR
 3RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705669192; x=1706273992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h5Zy+zXXe8XFW9Ly5OfsknWFLFbjN1n7eu701cHrLWA=;
 b=OGEV8Ukmp6J8vA4MtZ14qASsAn6PP2TiPRuQJYwMb4T8rC7GQtnaHZefr6x1QsCr5C
 x5rkNuh60G8YRYF2CqfrAXytQG1J9eM9lk/2E4+Ewt1x0FPqynLbXDITA1JLcaeimUUj
 JbsLpl2qCg72cGLTRO0bAHSIyYM3Eh1F8bi9wYRZ1lFNCK7r7qxrcdFyTADcZaPZXw0I
 u4w37mYEd6nxQtxdXS5zjp3UiC9kDPuy3Gr1fgk8lfZgnHkJrgc9tQxGMClnE0BZRs24
 poowwCUokHilsshPeAwi5q/fzBUKuXEfijOkfCJ8ZQ15lYUCHDfs8BND5cWJlxCwmsIU
 mgzw==
X-Gm-Message-State: AOJu0YzuQmGZg370bjyWGqhnqcMYQ8wTwAC8AfhS361IzAdNInm/yFbf
 Yp4nXEFkLGllopNZymYrw30PLBBjNKK4yc17Ub8brBha8TpnKoyw9k2wO0v0plwcEGMKlY+h2+z
 B68v/3vQ7GnQy+B9AXFZuUqi5vw5a57pLLOs=
X-Google-Smtp-Source: AGHT+IEcyA/EUT7wwzoJ7kGlHmJpP4tv8Jzo+QoM2o3IaMOmXZUA7eLKlrIQFQST3crF6nCXxRgfUbB4RBA1mizTBmI=
X-Received: by 2002:a17:90a:bf13:b0:290:1f0f:fc89 with SMTP id
 c19-20020a17090abf1300b002901f0ffc89mr4433246pjs.0.1705669192083; Fri, 19 Jan
 2024 04:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20240119004656.264825-1-marex@denx.de>
In-Reply-To: <20240119004656.264825-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 19 Jan 2024 09:59:40 -0300
Message-ID: <CAOMZO5CGJfhiptQRzW7FDbejTB=YnXAVFP-Juz0SY3VgQMnu7g@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Configure GIC clock parent on Data Modul i.MX8M
 Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
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

Hi Marek,

On Thu, Jan 18, 2024 at 9:47=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The CONFIG_SPL_BOARD_INIT lets SPL common code call spl_board_init()
> during the SPL start up. On this particular system, spl_board_init()
> is used to reconfigure GIC clock parent to PLL2 500M, which is the
> configuration expected by the Linux kernel. Enable SPL_BOARD_INIT
> and fill in the GIC clock configuration code.

Please add an explanation about the "configuration expected by the
Linux kernel".

In the comments below, you explain that this is needed for overdrive mode.

It would be great to have such a comment in the commit log as well.

Thanks
