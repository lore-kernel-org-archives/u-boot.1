Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4067DC54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 12:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D9D8800B;
	Thu, 21 Mar 2024 13:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h4frznFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B26DE87D5E; Thu, 21 Mar 2024 13:15:12 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94E6C88047
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 13:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-690d054fff2so5789146d6.3
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 05:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711023309; x=1711628109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmvnKKO+ChOjMwQhKSnPKWHoN5OJYrrQ8fGK06L/TDQ=;
 b=h4frznFq0MSVS5xTtKGpUmzwJIb3tdITUl5b/+Qe3nYAwneAV2M0BLfwEX92UtVXSp
 OBiMutx1nPQfqcEuBrUt8VEBrD22cB76Syezj9DcyWNFW9L2IGFQIQ21ckm7GzvaVZQR
 dr3/PaepGspxs50UtkjpgEYyaTc5MBE+2mEOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711023309; x=1711628109;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmvnKKO+ChOjMwQhKSnPKWHoN5OJYrrQ8fGK06L/TDQ=;
 b=rFknWPz4zH25L8T4inXjKntPDIfQR2NIUyY2TSR0dvrTsb/l1xak73Z3rT+yRGd965
 SD2sUUMKUxn2JigK+Rx5q9PCql7PNonMtBRYiXt6RhQFt3vfpvCjCkG1N7KG6q9vwPMV
 v1Q2peMiI48LZVY6VhTFXA6KYkOq82OQwak9WC9BWNyBupmwJRzkP6mjmm1vcIb7tcLT
 FEr3Lx+jSZ/AKeVgM67sJUV2002kA/htfFOxoCiXt5SbzvM6XEpHidVg3lzf0ialyi1O
 pAPgeiHm0akY8Lo51AwomRgZMKvrxrrU1eFZ0m7MJ6K07t5s/opDYjyaZFx5N/LZnUt0
 nUpw==
X-Gm-Message-State: AOJu0YyHfXm6dUEfv5U2tlo20/uEVx3TlIY0GranNI+pJ8V6XLapttoK
 9myS4xv2zVSqoC7NuGpGYlXsGM02f4d39HKc5jMATa0vOJYpeYoSTNBejeNiqDg=
X-Google-Smtp-Source: AGHT+IEFhrz4APCAqME8s1WTVXb4rchXStHnbzj0V8P3shXt4wDJl1ejZ+IfZlq8ZMyJW9xdV1Yytg==
X-Received: by 2002:a0c:da94:0:b0:696:46ec:59cb with SMTP id
 z20-20020a0cda94000000b0069646ec59cbmr4359984qvj.25.1711023309494; 
 Thu, 21 Mar 2024 05:15:09 -0700 (PDT)
Received: from [127.0.1.1] (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 kj25-20020a056214529900b00690df461ecbsm8990690qvb.10.2024.03.21.05.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 05:15:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20240313115456.9251-1-piotr.wojtaszczyk@timesys.com>
References: <20240313115456.9251-1-piotr.wojtaszczyk@timesys.com>
Subject: Re: [PATCH] gpio: mcp230xx: Add support for models with SPI interface.
Message-Id: <171102330848.1913497.15629036736532393455.b4-ty@konsulko.com>
Date: Thu, 21 Mar 2024 08:15:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 13 Mar 2024 12:54:56 +0100, Piotr Wojtaszczyk wrote:

> 


Applied to u-boot/next, thanks!

-- 
Tom


