Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A9FC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 07:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA9D80657;
	Sat, 18 Jan 2025 08:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q5Fryhey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 602C680748; Sat, 18 Jan 2025 08:24:50 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B4488063E
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so5263705a12.2
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 23:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737185088; x=1737789888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVdVorWj9H6HGRaK6ZkoKObx3RzmR6QxrZImko9v4OM=;
 b=Q5FryheyhgcTIObVLiOrzLylUIhAYUVNxVIr6/VuzelaJvEYK/rZcXAbQV90SMiuNq
 3YiDiUcVYZY5IdD/Vc0el93DXLzT0S/y1CntKjvO95MtO2E2We1+QNUvMtwEtktXh46/
 v5pOtKQr+X0woiUdb8fqclaXZCXSeSAK2tDVECvl31Wrn8Vzg80+k1YSVLcrfXxyA/r9
 +la6YWdaedSiBmVQDHLtaOULgBpKU93EWhupmEnZl0AfChrR5b+pgAPmqUYcUdaF+3iH
 SbulCebyiFIizsXwPJTryI+S8Fpz7JZX1/cj3VTDHwMgQs+q9Os8a7nWEKhVX5rngNtA
 7o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737185088; x=1737789888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yVdVorWj9H6HGRaK6ZkoKObx3RzmR6QxrZImko9v4OM=;
 b=LiHZCl7ESGIBMNATEDBDS749/gGAy0L2MfKh0h2GxYZ+Daw9Q0jGQ6hiJAdI9dnNt5
 JV2t6+5TWSDBM4MR/dnI2tbIe0vLwWOOJUe55QNfIz8moMe4O2AYt6YL1AVZEjCc/Y41
 WrdSHTe07DEgNZKjZHP4o04UDJWGxlXAxR3hRPQ7ocv/Q5zag31XbXemIM0CEXflXL/U
 uY/o6OY2lGDZ8Me1NDy7ad252Gl87azhSKYHmpcr7RJ0rthwu1/ctpGvfRHFqKXCqlRg
 cN03is3j0ikA4QMsKlmpkU/sFqEAAXB86JNvJ+yAqw5IdmHSNeo98hqOQCNjy4YAmqCb
 llqQ==
X-Gm-Message-State: AOJu0YxcY/jc59hcJNRwWqizFT07vnvBSX8lnENnwMEnnrwaulssYZxY
 31lr0n1wF0a3ShboKumxjAZ0TwZQP/5A7uhEiWs4IUI+gtevBFRyJjVhAw==
X-Gm-Gg: ASbGncuT6hz8Roixh4udzmN2JVpLAI2yrZwDBJpo6gXKRIjH/q1KGoILIYUbfu3kZQU
 C1PIoazDe+WQ/v4pDUcUSI1qpyiqbxd0M40sWhJbMsFVlkQ9N4B94sxWgHNsoiXcIYNK1I359nn
 vqnsC0R0gJGNuBndrAiQKmXngXCkn/8U2oOnKjdylmxmYyXAQxzqC8TlRH862HIFlmXLJHFP+hZ
 BbM6NUW6aoCYOk+ri0vz7DI2VFbXxEoQcRgGJoAfa4kiFSvrs+Yfq3+Cy48rtqUKNlnb/GLF2Ct
 qKL8HCNHnuoatf8rRj1xtStANQ==
X-Google-Smtp-Source: AGHT+IFpPnqFyx/4M+K1AZhcJHn1T4ySfJj7G7jnLutj/9lNVkQowgcINV1aHBuTFJnWSb4aTkEenA==
X-Received: by 2002:a17:907:2d88:b0:ab2:c2f1:4578 with SMTP id
 a640c23a62f3a-ab38b190e7fmr493934266b.4.1737185087745; 
 Fri, 17 Jan 2025 23:24:47 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f4052bsm293366766b.95.2025.01.17.23.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:24:47 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Simon Glass <sjg@chromium.org>, linux-sunxi@lists.linux.dev,
 Parthiban <parthiban@linumiz.com>
Subject: Re: [PATCH 4/8] clk: sunxi: Add support for the A100/A133 CCU
Date: Sat, 18 Jan 2025 08:24:46 +0100
Message-ID: <13680233.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20250117014537.22513-5-andre.przywara@arm.com>
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <20250117014537.22513-5-andre.przywara@arm.com>
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

Dne petek, 17. januar 2025 ob 02:45:33 Srednjeevropski standardni =C4=8Das =
je Andre Przywara napisal(a):
> The Allwinner A100 SoC has been around for a while, and has now seemingly
> been replaced with its close sibling A133.
>=20
> Add support for the CCU, as far as used by U-Boot proper. Linux has some
> basic (clock and pinctrl) support for a while, so we can already use the
> existing binding headers.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


