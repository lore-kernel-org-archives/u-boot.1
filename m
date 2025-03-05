Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC6EC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 18:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A501A80F92;
	Wed,  5 Mar 2025 19:12:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FiWdw6LY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A9880F9E; Wed,  5 Mar 2025 19:12:23 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C858980BAA
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 19:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-548409cd2a8so7311576e87.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741198341; x=1741803141; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zebJD0XCn4aklCHgrpPYCkdRPHyIz/GySNO90f/ixqA=;
 b=FiWdw6LYiJwqf6bAxmqH/NJzfo0KiI98kRXkek5u2Fm8YIdR+xFiV9SRzQ0Df+bl4N
 xBkiHyniz7mrpIpm2oEzqEQn2ACrDZXNEAMa/cT4451YDXLOU6KI/qhur09maIvamFE4
 AvnQJm3/DvKE/E+etIGbubKZnQPqQds6Do/Y+BkC0nok8Ggyl7BWKdRnwK14gYmtgeb8
 RBXff2pOJYIE8DMrqi2HIP5SnvwTOBqJZfSnYdhxY/929yreP6b40QnxiwDgG7waX3TO
 knfXsaUpspf5Zdm6UnMq6Efpki4fpc1YYUvv/XIT6uSF6q1a+u2dIT/tMfLpoBERbF8O
 sK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741198341; x=1741803141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zebJD0XCn4aklCHgrpPYCkdRPHyIz/GySNO90f/ixqA=;
 b=w6fTrQWecC+erzSQaYmmQHWS4G4IOItSwuX1iGEmGhU/OAQY8FavHRVick/VidhWA5
 kj7W7wtw41V0pIdxz2F5bHRNQ4xYCSi8X8MqR/IkqJqP9s/z4IStywrPvddMbBUjgjuw
 dZayMfb3MKzt5/Vl+r7WSiJLaTAeV7WOStx005oOP4RPvZLEpRJOaL9TkErxwc+57hny
 8W+tcx/xMKH8v7R/2DIGOEL7UiLSWdAm52+Dy26oEkpdCZprMKtL6JSK7FgCq1WczM/j
 TrjYq5JH3p2ekDwK37zd4UiAH0Ky4KVMSseNkWD+WxankmXRddEo2D9LcY1cjNS1ETOu
 vnog==
X-Forwarded-Encrypted: i=1;
 AJvYcCURRHKDqFvi5sMAT5forKeONU+nb8nMQtz65gU8PARXiTfCfB8AVyNIu05EJ5gSTRQvFIXMa8k=@lists.denx.de
X-Gm-Message-State: AOJu0YyzNb60FsIX2UdwbjDZ9r/4ZfMQa+OJSlGfrKWChqqYVvNUn1pd
 dsftAawqAdTpU2JY68U/7+JgnsNwbsodmhTCGESUCpToxEEI2CseEo9ivGAUGNBNFQb0GafUzpU
 uhK59/7dfbZAP+NbbXWatdLQYf7c=
X-Gm-Gg: ASbGnctcbXdnM1GTcQWzKK7SDdm2z2lH0Cd0CBdUiW+yEqDe9U8altrvXH5Ucuhwucc
 QC+iN31DbeTqU/ODQv94Rh916VUWLeFlQvriikZS9MhIYGxCqAU1+N7jh6V89clVFAR1pxm4boK
 2IXFcwyoFpJcU0+U09ZuWsmXhjK+awtqP+OVSTNG8U6oYORzd7RAUUonji4g==
X-Google-Smtp-Source: AGHT+IFqFuhzAFcxuOt3bWHDGCK5goUUAiOZAHUJrX8saSoofARamP2oqeFM/90ST20EOUFMpQpQudyWXl+LA6WOk/M=
X-Received: by 2002:a05:6512:3b14:b0:545:bda:f20 with SMTP id
 2adb3069b0e04-5497d376389mr1587341e87.32.1741198340733; Wed, 05 Mar 2025
 10:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
In-Reply-To: <20250303170640.GS2640854@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Mar 2025 15:12:09 -0300
X-Gm-Features: AQ5f1Jqp_yjKZ3aLEpjTi4-AoOFFVoog1FtKpKgmGrntnuOuEPoFwWUKCHqCIss
Message-ID: <CAOMZO5BTCir859QDcR9XEDTnc4JnMHdCSLXTe94Z9z_FY5bwbg@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
To: Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

On Mon, Mar 3, 2025 at 2:06=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> It's a tangential failure. Svyatoslav reported this with a series he's
> working on and Simon wonders if bloblist support got broken but hasn't
> had time to look at it.

Please let me know how to proceed with this error.

Because of this error, I cannot send you a PR with this series.
