Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D8BC54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 18:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F8988AA7;
	Tue, 27 Aug 2024 20:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pA2YApkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72471885A0; Tue, 27 Aug 2024 20:35:50 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7377788A6C
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 20:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-44ff99fcd42so32899281cf.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724783747; x=1725388547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UjOzcxpNeytLKDcsAxO+MeMzWZ7SHdUcgjrNTOIB3II=;
 b=pA2YApkPGkPcvFGjR7HEpiWx9QZiqV9D90ABmYlscNJZ9gw4xJp1uqQ0ZZ3EotNbhV
 QSfzBNys80U+XnZ2ke0HAUTMvB1S/xTFSUIjt60Kl+Mo0PWBc5K/K8cEFjvybnK3XIeE
 KBfGpeiX87ZZY650CSEa3BOZtIUxOxYi2tyjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724783747; x=1725388547;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UjOzcxpNeytLKDcsAxO+MeMzWZ7SHdUcgjrNTOIB3II=;
 b=VkMeGrDaOz7uKvHvZfebIH1zs2LRTyAbwgEBwAvBkNcl+1fr1rEEE0nRJ4qe9RafiT
 eYvFcQgKnCBCeC8BmI/W1bHORsna0j8ryquODH1UTOE/cdq+7rDKyPdOH6XRY6PPa7g+
 apWH3Qj0EYxTRRxryZ1Pub1YyOtgp2RX+2WmJbFu5gc6G/jGuq/mabokiWGCjhiC53yA
 wyMozG2aJCrCyJ1hvts00qn/Np1qY83H4nKmaOHi4hTwBtGCFwvSMLiTzr3z8e8chyOU
 EBcOB3ViRz30X3+MYRuo0Wzls2iOfEBXsD1RkzS8ZOd6tuZwCOz8HjR5S2SQMR2p2peV
 DpiQ==
X-Gm-Message-State: AOJu0YzuYzgW3J+Flt1sJq6AgI2yps9fSRPf+yr/q3fs+jke8v6RUduK
 F+C3ej2lZylalvmI+qGsIqyNhPUrQqOpeSNr9sUm4eV6Q7ksBFpk9DaLE+n2zuo=
X-Google-Smtp-Source: AGHT+IGubvoBD7IGSrPHBoE0zg3FZ9zqgfpDSJVZV8+H5/LiJdwRhiXsKR0+oyOygsQup9ojHlckiQ==
X-Received: by 2002:a05:622a:5590:b0:453:1eb5:dec1 with SMTP id
 d75a77b69052e-456609478f3mr39680601cf.50.1724783747331; 
 Tue, 27 Aug 2024 11:35:47 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1c9c9asm54635271cf.89.2024.08.27.11.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 11:35:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tony Dinh <mibodhi@gmail.com>
In-Reply-To: <20240815203022.771615-1-sjg@chromium.org>
References: <20240815203022.771615-1-sjg@chromium.org>
Subject: Re: [PATCH v4 0/2] bootstd: Try again to resolve infinite-loop bug
Message-Id: <172478374602.2927671.15685037514509379076.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 12:35:46 -0600
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

On Thu, 15 Aug 2024 14:30:20 -0600, Simon Glass wrote:

> This little series tries to resolve a problem found with an earlier
> fix.
> 
> Changes in v4:
> - Split bootstd patches into a separate series
> 
> Changes in v3:
> - Update commit message to describe how the problem will be addressed
> - Fix 'virtual' typo
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


