Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F94CD0D175
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 21:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 368998405C;
	Wed,  7 Jan 2026 22:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fCz1BCVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C07F78407F; Wed,  7 Jan 2026 22:07:05 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE8783A2D
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 22:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-65cf3d51c95so1364622eaf.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 13:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767820022; x=1768424822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ql9sRUtwP08VAnKEHH5gn1aug5O/pOi+rGp6QfhFJ3E=;
 b=fCz1BCVtrqNEnpPac67rdwDHo9rU2eGx8TqrN17GN50nssgjEvo0SlNWqBASyyN/GD
 aTIR2rnS/JfoQQcxHCSKXTf6jjahwphU6Djvyl/yY1NbW7DV1ymhnYVJXyKkJEf/ufoe
 Prutgy+VjDZeDV0cR6AiUzjcbN58FLPGoe9Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767820022; x=1768424822;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ql9sRUtwP08VAnKEHH5gn1aug5O/pOi+rGp6QfhFJ3E=;
 b=d8b2w4AXXnTQvgioE2Dst0SePL4kM+eP99Y0e8JAZeXqnDRegP+IJLFX+dVqSdF1F7
 FrSpGGbcbgNMFPkgf54HIs5E3qOGTtylDKFcq48FFvvxrzktWT2jqxCqRVpl3kPO2XAb
 hY4tPJWCRAfP5Q+/h6OsFVwCuWDxBEMGP4z3NDjhIDURJ7VJszGsIr4c0eYOksMaWRO6
 5JSsQbv4HL9mYAqot8KdhKH6dQ8HUX7TxN8gLUsvo9n126z6pdy6vExd4es4scDI+IUh
 Y7CI9BaS8is188zYqK21gAf8gKwDVFkQeDD02HbjaiThBUQYS2I0YRP4tpPh7deuPT6u
 eHuw==
X-Gm-Message-State: AOJu0YyY5fDBLIgDXyrBLiiT4hQClu7aWWFKs1ZhWtK5imOkPFmdx3fe
 vj/Nt+TPQvSSRwkwfomfsOCxL4VWl+V0cplv8ITvZWzf3dLYRBFvvyXA2u2N9zwPqxU=
X-Gm-Gg: AY/fxX6RGDI67fiX4qyxgbjP+PXe0JgTCb+l3o99/Z7ttpqOqwv1TJJW5Ms4mA0PmhH
 KV2tciZvEAWRFOnWoifOmZlh4SeNZrrTcFsPLRqSWN6j4l132PDFx1ndPxexR54NlguE5mR/2c6
 AtZsQsZwV8hp1F+kYalH6BhvHLMqsIixum8IT6mC89LVm+Kdmh5btYguQWX9xAMMFroKq2ioqO5
 QPL2C7tWOuzTP6GfdvhrkPv0S6bSfHkqMsd9y8PW4sFVu1279K+N9Fvw1EjSdV4u1TyBw0yJ/tk
 OY5fxjMkzV/5ON4k7yAmLQ2dBFgCBzOWzKKmbs6pVGF4MfXB4IZ7iNRUZ73S594L+DHPFqX7Ojk
 USH9Ysw2hWrGZBPEPVeAeHLl5TG/IBHVNva30oilvRIh38vN7qGcGKv1YI4NAtWONyg+GL6HfRy
 qc6YR4DJ0ULUqBCw4/0CrooPK7xEoNZXdHhA1xfZjUU9jqxTxSHqYoVw07aT76fWt1AvTOSPpGf
 tY8yownrdAcWL0labSsnejuhqeSzzzozgrMRw==
X-Google-Smtp-Source: AGHT+IFck8nk9gY669jLWkRyEl+W44DqcTqd0Xm4FgdK+w/pWirv9HHYSROF4+/n8SPrV56/RWAO+g==
X-Received: by 2002:a05:6820:622:b0:65d:1c:f39e with SMTP id
 006d021491bc7-65f550ad71cmr1867950eaf.70.1767820022159; 
 Wed, 07 Jan 2026 13:07:02 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48beb796sm2513609eaf.7.2026.01.07.13.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 13:07:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome@forissier.org>
In-Reply-To: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2 1/3] test: env: Add test for environment storage in
 SPI NOR
Message-Id: <176782001999.1069019.13211831759337448582.b4-ty@konsulko.com>
Date: Wed, 07 Jan 2026 15:06:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 23 Dec 2025 15:31:10 +0100, Marek Vasut wrote:

> Add test for environment stored in SPI NOR. The test works in a very
> similar way to the current test for environment stored in ext4 FS,
> except it generates spi.bin file backing the SPI NOR.
> 
> 

Applied to u-boot/master, thanks!

[1/3] test: env: Add test for environment storage in SPI NOR
      commit: 88de22a4db03d6dfbc4779bf942383fa390eac34
[2/3] env: Add single to redundant environment upgrade path
      commit: 1f131385810fddaeea23c5cf0269497d7e637534
[3/3] configs: sandbox: Enable environment in SPI NOR support
      commit: 8dd76166e3dc47f898155a047f1594fdc7a63d65
-- 
Tom


