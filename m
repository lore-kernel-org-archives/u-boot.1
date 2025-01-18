Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F07C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 07:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 376B080755;
	Sat, 18 Jan 2025 08:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NseWb7ji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D953A80748; Sat, 18 Jan 2025 08:16:28 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AAAA80755
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso526263966b.2
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 23:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737184585; x=1737789385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvmsiMcnF2/uG8bi1GujCIOYQ4DypSOlsDW3rRw14hc=;
 b=NseWb7jik/DKGad/VkeAXJcfwBfZslC4ef1MPR/hUAlIsl+WjcAJY7+a3Ii9JGFSpm
 28fzOSQVW7UmRGDdeaTWmY7+ZsCuNxObM+1flurAqOByjv6HWPxw3vMVXVPIjRPCpqJf
 FsCsklfcCk2QL1rv8/7jV995WjWoNyolE0xsmGHr7RILjgZWh2I268nPnwWQW1AU8n3C
 iegyaYci8RiCk/URmiuK9BCcNP42O7QKBoZ7ivvnZClATdFjyMzr/96SXIkAOjsaDs0/
 osuF6HPkul2t6ILmqIouYOk+x5so0EnqEzPYq74b9BqWgCf4o7TOZlxG3e7Anl9uEBHt
 JYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737184585; x=1737789385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvmsiMcnF2/uG8bi1GujCIOYQ4DypSOlsDW3rRw14hc=;
 b=v53muzISAztJX8+Nt5tAh8NI2Favau8yCr6YJVB9Bnz/cg0oHz9z5Q5rbhdMe5kMlX
 GXEfHEMHOOBVvKylvG7tKYLXVVSfl9sKPLOA2VCDI/ClNn9C6bMm1iFqUsv+RtOUF/TD
 YLLLMIWZD+P2aV3+xmckf8TfYQ7zqMZ5hiocheKU70gMreScTlvviVGYb2EbwH9rnhl7
 7hoQeP2AoNt/E5EJd9UyQwmH8531Mb2mfOkoJR5IL+Dgg+xqE7dDojHJIGaV7ZjRnhM0
 HEmHAwz9HAYXAzD9kmcGsGpe/ZfdYAEbXQeFHIOyuC6HhMpqm3l10dWAY/aMALJHvQvH
 5dRQ==
X-Gm-Message-State: AOJu0Yx6V6J7Bz6StMJIqD8/gvz6TOnhWNXs5Cx6plEJD081G3Hg9xc+
 jR8sCPSJhqCAMmIm8U7JoO9gHxZmHZWT3Pr3IU/LR6ddtj6MwzER8ki1ig==
X-Gm-Gg: ASbGncsyACmkzkE2LiWaE6M6YT2j4dGdBCbIFgCssCWBOIbBJY4j5rfMLAe609lkfTe
 87gOebIbxeNIDAHUx6hoATxmiZV4JUS30Kz0ujEfjjJcjDdb7cMfYz9xhyrAlc77s1P3sAGjQJA
 BD/PaHiLgKQHjQ0zolBvyAHqVCxYDqndCYEkgvT3iFF31JyufmGC+MbLFamTASh9deX8Cpzym37
 1mcOF/HzCzsOPA8ptY+nw3IHUyVS8xE24GDuTnkm2agA9T2+0tZo/8IEarPiNjA9E5X4U6OmPrH
 VGXKn2dlFui0gls=
X-Google-Smtp-Source: AGHT+IGLfOUnmOlf0dfv2EPZsI66QYNfhjl0KwhCdKMeegq4EfqhcelIy5iL++pD0InGzuI7g5FXdQ==
X-Received: by 2002:a17:907:1c19:b0:aab:dee6:a3a2 with SMTP id
 a640c23a62f3a-ab38b4c6500mr434180366b.47.1737184584743; 
 Fri, 17 Jan 2025 23:16:24 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce0f58sm288083666b.48.2025.01.17.23.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:16:24 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Simon Glass <sjg@chromium.org>, linux-sunxi@lists.linux.dev,
 Parthiban <parthiban@linumiz.com>
Subject: Re: [PATCH 1/8] sunxi: clock: improve grouping of default clock
 register values
Date: Sat, 18 Jan 2025 08:16:22 +0100
Message-ID: <12589905.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20250117014537.22513-2-andre.przywara@arm.com>
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <20250117014537.22513-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne petek, 17. januar 2025 ob 02:45:30 Srednjeevropski standardni =C4=8Das =
je Andre Przywara napisal(a):
> With each new SoC added to the clock_sun50i_h6.h header file, we add a
> list of default values for the bus clock registers. This list gets a bit
> hard to read, as the spacing between the lines looks confusing.
>=20
> Tighten the lines by removing empty lines, to make it more obvious which
> values belong together. Also remove those comments that were more or
> less duplicating the next code line, and didn't add any information.
>=20
> This makes it easier to find existing values and to add support for new
> SoCs.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


