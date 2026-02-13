Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B384BEF99DB
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D700E83015;
	Fri, 13 Feb 2026 21:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QOnDtKMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF2E83DCB; Fri, 13 Feb 2026 21:16:32 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C7C83CB5
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45ee8823e2aso822502b6e.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771013789; x=1771618589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvwfaQn0kL5S/swkIZIsy7cJk0G7ukRH7hqm2YEf/DU=;
 b=QOnDtKMrYK4cgIDRmEoU9ELiUSUlPv0lgrUGVhmwK4xhG+LOECShhexhevOQ2F2eQp
 WdE8WrIA11//KZvW1WPW7K46gpkzgFY9scdIOMZaJl7donG9Nsnw3t8/V9TxYOoXSoXF
 bFbKLExOAnU89AWPyDEt99l5UqcL2fzdMWIDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771013789; x=1771618589;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvwfaQn0kL5S/swkIZIsy7cJk0G7ukRH7hqm2YEf/DU=;
 b=VSDBdInfkQaoeJkdVLGsncQGP8Vjp1Ckciu3APTOPystzEN57aFmfmeSKdH8gqqzW7
 DQmLb7uwpIfc0elDFPuN1CHGk69a6yeDF2lgVTY+Bp66KTR34xSZS7T9gBs/VMdQZ172
 lt4729OjfQKxzJ99YwnsZ4nNTxmbL5kU9RmWreqdFJo0qxtzZ9IiLCTsvSQa53u5q+el
 zg/teCHxzJFW5Et5ueFqecUuWqyoj2vWGO6a+KPJkcj3dmKWTcBO38pswb7ABvs/aa84
 PnPcA6OcxeIbBk7KgiUM7Qo+4Lu6rnMbm71iSZsslmxv5zXpXO7wZi5Jf48GYXcfL2SX
 P6Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5raz6n3PAlI38Sl+64TnjQ49SchS9UDnY3qAnpAU/xraSQ3/hDFIuPxIAd4klx44na/t1Pfk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/lbhD5zym0XQ7s6wQnmAhWboc6zMjMi9ltemoKNgLcrfIRB7F
 aHvjcDmz1cQr8YWhaF4R4aPVVh2xmrc0oaGwJt84IGyLAG5/0N/Fgtwgca25miLX60O8JH+bKRY
 nZpQR9N0=
X-Gm-Gg: AZuq6aKg0INMmSzJCpN8C6+0Waqk2eEiUJV+21fQz08oppEHjOSRhj+ijLTR6Ju2u1m
 TqBvMH+vsWKoolUFNzn3ojQvYSQ3GTLwomCE4aMyPNN0OjSn6qVWSXNO0nzBqfJ6prbZgkfXlgI
 /+7UkodaMS/bUOXcFOvXIuUQeYqoasyuWmdG7Z3gIzk5FTfHrrMt/5W2fm30aDkjkkDmgn0E//1
 Hvbs4F8scOQmSP/PjTuCGvWrke4Ax1xKB0cF8muM7eAqf1KWOm9PspSNfWQyxusia0MjZhmTflJ
 7yDmGcfcB4Ux8LlsT1leZFEERBZtatH4VUwhKw9WZVpH9iohwWAyStrQUuew4ry8Dbs3uT6ssz+
 +XnxfJkiCydLe1FXsA3eLujBuhg/jToJIq4T3LqlY+SHsnb3phkXJZk4it3x176bp1qliUtgsYK
 qBD1YYGClVcbhQZXCKS4DxmDx7pfVgFgALctG8coINiGH29R0a4IreYk+mTlQnj8OSFQd9sveIn
 37c5R8MOtc4hMwLiGhS00blaMo+4yozXNCbXzApUeFBzQyeaQ==
X-Received: by 2002:a05:6808:15a8:b0:450:f3e4:eb05 with SMTP id
 5614622812f47-4639aeb47b5mr1968381b6e.64.1771013788633; 
 Fri, 13 Feb 2026 12:16:28 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm5152025b6e.3.2026.02.13.12.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 12:16:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Steam Lin <stlin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
In-Reply-To: <20250702092313.970234-1-miquel.raynal@bootlin.com>
References: <20250702092313.970234-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: winbond: Make sure w25q{01, 02}jv behave
 correctly
Message-Id: <177101378791.2522051.16623231453997742661.b4-ty@konsulko.com>
Date: Fri, 13 Feb 2026 14:16:27 -0600
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

On Wed, 02 Jul 2025 11:23:13 +0200, Miquel Raynal wrote:

> These chips are internally made of two/four dies with linear addressing
> capabilities to make it transparent to the user that two/four dies were
> used. There is one drawback however, the read status operation is racy
> as the status bit only gives the active die status and not the status of
> the other die. For commands affecting the two dies, it means if another
> command is sent too fast after the first die has returned a valid
> status (deviation can be up to 200us), the chip will get corrupted/in an
> unstable state.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] mtd: spi-nor: winbond: Make sure w25q{01, 02}jv behave correctly
      commit: 4f76c90bad3867c402cae28b45c928626bedefff
-- 
Tom


