Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE2FC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 12:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 852438192A;
	Tue, 25 Mar 2025 13:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QBR67QdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A03D81B42; Tue, 25 Mar 2025 13:57:41 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A9E480EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 13:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-54298ec925bso8174524e87.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742907459; x=1743512259; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ay41XjYzUA/U3FBXtG3anwTha8NZ29UyaFPng/qFDH0=;
 b=QBR67QdJU5mtj1nzms0G7hn4fxzmb15d9SPdd93nFnDa17RK5gUlKipXouI2aW/8Wl
 5E1aI67Pn0d4n2u8eNzQyN3JxedBIY+z6NCkDehFxul1u17HDj+pIQE8VS6ePsCsa0ni
 SJIgeJXAhEiI5xWf6r4If6TC+Urn4aUhXAazK5EanUrrXjS7co3DnRmh7wVLUWPB9+GW
 FmJxRSOG1WKHLvsTnzLpzFUB8GTUMB7LK9WzNgg39JtgQnPrxtSP2tQlrLPuiO3/1OdR
 6EJLglkqRoGHa2/XJRvQlAv9+yXeNmv4ziTNwFvywHNviO99QIKJVlgpwrdh7VKJCGab
 OXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907459; x=1743512259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ay41XjYzUA/U3FBXtG3anwTha8NZ29UyaFPng/qFDH0=;
 b=NnSCBX4Gae04HQxFCZCPVjdPD6dhoqhIk3DJxZF50EwL61OHvq1/X97etg1iOWMIhZ
 wdsprlxkqHZA+UHetzo2or1CX7Hu0WNsiimtFka5yRaeydTRga4F6GefKmaV/2RCqDVx
 8ZimJt6un9k67etRbqz1TZHtrgPdhDNQ9Qbl6hRXnw4+IyumMGI/pQ0Ey2lfi5JNx1mF
 y2w1dtlYGC3KAdca3sO9renlvqMIJ5QYKwpvoD+Zad9VA0xJAiFFG3mO4bX3mwBB+thE
 VGSuhoxmVYLgbfBSONeDtj0sryZeu/2rxy2inzZ03F8kk8YsY/+CNIUtkrmshdY6n5xN
 g+yQ==
X-Gm-Message-State: AOJu0YzdSmNvQx1aZo3ZUAR8ANTwKqB0rxIgFvIBNxCvhX3/O38ruXLj
 3mQX8RSBXBCkBgW0nKLaR+hqxTbQACyOFGGD6XCaFEU5XsSfJAW5AauJ4AvOUYpjo5Bb7i1+H8I
 5wVs9AyxqlvkEntl1ywoUsSENmy4=
X-Gm-Gg: ASbGnctIU0d2Xoackiee4ZuCvQ2Wj5kkryRxybGTs0cfeb7Vpxp4vG2i+yNAqgAghtc
 QHaJpU2gL+1V8iZNSujiaJLmL+225msGwUCO9H5aJyni3sh+W03/jcn/tyzro0fhwqHb+7/6r+C
 r1sfVr5fEE9Mt2kC2nJaQVVtCMUx7wYcpz79DMEnG3XKQ3Po2Mn6O9VGUw
X-Google-Smtp-Source: AGHT+IG8m9Oyv84n8fv6EAMUd48m5/uI2yOCUwt0fvkgHpAcIJnEl+XOu1lcw1+K9hoFkg9kGyz0Y2ppqFUodLj1GlQ=
X-Received: by 2002:a05:6512:104f:b0:549:86c8:1147 with SMTP id
 2adb3069b0e04-54ad6502b8emr6134397e87.39.1742907458689; Tue, 25 Mar 2025
 05:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250319032828.249156-1-marex@denx.de>
In-Reply-To: <20250319032828.249156-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 25 Mar 2025 09:57:26 -0300
X-Gm-Features: AQ5f1Jppc_DZ0KPSDq8JkD5Je6z7PqQK24q0col0zQjDBrzMrsjSMZZmsbUZ0Ok
Message-ID: <CAOMZO5CXgR=y5M7g2px=DE9TjaLduL+XN-YqSpUh0ejTzTpJ6A@mail.gmail.com>
Subject: Re: [PATCH] arm64: imx8mp: Gracefully handle disabled
 ENV_IS_IN_SPI_FLASH
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@dh-electronics.com
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

On Wed, Mar 19, 2025 at 12:28=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> In case ENV_IS_IN_SPI_FLASH is disabled, returning ENVL_SPI_FLASH
> leads to failure to find environment driver on start up. Fix this
> by testing whether ENV_IS_IN_SPI_FLASH is enabled and if not, then
> return ENVL_NOWHERE instead.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx/next, thanks.
