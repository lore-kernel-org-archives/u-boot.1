Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD79C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66FEC8277D;
	Fri,  4 Jul 2025 15:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k2xMDDDd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C3A68206E; Fri,  4 Jul 2025 15:33:26 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60259803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-555024588a8so973529e87.0
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751636004; x=1752240804; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hr1Ok1DxBYnPcupv8jcKsOgh8eGIrVM/lwNUqRuJ5X4=;
 b=k2xMDDDdDdJSUv+zvQeuXAcsnPS5r9MR7lIjln8KlKzEB8yiakSZN92Kzh34PKSJWV
 OJfSJP1f91hbsKeIPbHekjmWy+NwHZYCJTHZwusNsmMVb4O4NJCD6aP6wMSRqQDze2lK
 AjeEvkm6RAXJ0cA5TLyolBntqSdbudKXJmfrBIuF3fU82jLUhloB1MPW0Ky/3U2/3iLy
 PAfue+Q2ArCSHS8iDDVKNJY5Se+82O2fLMu/uMyNlSpjUpn5RdYJwPpd0KhXuVZkEn96
 mittxP3m+wk7pv51aDx9TXCnil9n/6ZCE/ohBAcdX8O8DqpiGLtNU2k2jmzTkxWWJGzV
 V4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751636004; x=1752240804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hr1Ok1DxBYnPcupv8jcKsOgh8eGIrVM/lwNUqRuJ5X4=;
 b=YOupqB/ZP/Mf31ODZl4LG78j3Zoo1pzkzZiygkatjz5lhIZbkOJef4sPcwEWa916Qj
 c8+xj2DReFyL9tg2hFKYBOa8jTCtpIaibfZvZt4/j4nEqG5GE3x2RMVlOFcBj4RZjEFq
 Gfmz4/yNlpCp4tDpx5uc+gdLIOlmS+J8HSvf8MRgR8VlUennuvJmsYa1/nhUn2msogfF
 NYJFeM3cyNtNfIH3s9PrhdgWncqD5FbcbCeUlyHNwFje0teEnH2e5ztLU+2htTCYrnNS
 A0HKmE4y7LA30HDX7FOKmm08juVXNi6/2WXz7buMEHBj2byDb828uk7WKIYb0+emw23B
 MTdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSlM/6kN4q5CStRkW2h6QKNt5/Z/1OGJ0ajxoqKGHfqM1AtQ2Wcl2xfiND22rXVmPoJpSVw4g=@lists.denx.de
X-Gm-Message-State: AOJu0YwYhOiMIeDMnaC2F/iSXTFDu8ToRDV7zZelf9a96+3WPf76eIbg
 /lI6wC7aS7wURD6tuAvJmo4KSJOHTL9XkV32UMa1zvqR8cfWK4C5pVrhX8rVUSjLN559OEXoVfr
 gRw78kmFZPMrVoEc3rhyWXTd/dBTagyU=
X-Gm-Gg: ASbGncucfR1w2w1zckZM6eVxLko05/d7sHOsJRK6ySiYfm6q+CmOA0On30LrMab7VGz
 md1iA+yzWk/6a04N8K9vA5+ACKmYqINqjZFW+lZ6qsnURML1VCqZa2baezaQxD202vaBYxC1ANS
 mWZ5SQJWA85zaxOINIY1iaWLHRIHfbD/TBSkNMqobGcWjmiIOclxXgEu/Si39dCmWKs2OJk7RfA
 w==
X-Google-Smtp-Source: AGHT+IFkhIy9X1ch+Br2wrrydsuoMLaLOWo5+fv2PX+UwSKQaF9Q1hPs7YVVqbkEL0zeJlJ5cWCKSnmek2PiHbVa4WU=
X-Received: by 2002:a05:6512:4003:b0:556:c4f1:c7d6 with SMTP id
 2adb3069b0e04-557a132c212mr724166e87.7.1751636003253; Fri, 04 Jul 2025
 06:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <CAOMZO5Dhs2GRgvjDCBbwsxxZadsVCrpXaWm4qToYfpak+CAKuw@mail.gmail.com>
 <CAOMZO5Bjxx5tjj75Bo8A4WJWBnV3Q8h1UHK45_xZgOavig0C9w@mail.gmail.com>
 <0b7fcdb0-0d18-41ef-8607-cf060ce3d058@linaro.org>
 <CAOf5uwniX09rvpChMVrFWVG-X5S52aK_ZjnpS8EAN24=r1youA@mail.gmail.com>
In-Reply-To: <CAOf5uwniX09rvpChMVrFWVG-X5S52aK_ZjnpS8EAN24=r1youA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 4 Jul 2025 10:33:11 -0300
X-Gm-Features: Ac12FXxiu1Xgkfv0ofWC_2HZNrfzAxtxrqT87-ncelCFHx9iiVpD0xzwefajVd0
Message-ID: <CAOMZO5B-4qUypOyVEiZt6V_4S35G4m6WATmdXqKnFCwsQJxF9A@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Static initcalls
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Otavio Salvador <otavio@ossystems.com.br>, dl-uboot-imx <uboot-imx@nxp.com>
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

Hi Michael,

On Fri, Jul 4, 2025 at 5:37=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> We have problems that our board crashes with display enabled when this
> series is applied but we can boot
> if the series is reverted. We are still try to understand what is going o=
n

What is the defconfig you are using?

Does the crash happen in the SPL or U-Boot?

Please share the logs and more details.
