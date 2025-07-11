Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18C3C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 02:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32162836E7;
	Fri, 11 Jul 2025 04:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X9x7M6H0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 063F083744; Fri, 11 Jul 2025 04:22:20 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A4B5836D1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 04:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-553b584ac96so1565623e87.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 19:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752200536; x=1752805336; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bq59WBBdyGyyfBaH+CxUoCVCYaFy5V0qQU0z7sKwR0o=;
 b=X9x7M6H0Hr054cFFb0kq+DNYhrLkHxiiTY5mwtASgv5uonjsNA0l78DOgocCkCkhaS
 B1IIasvK2gzVgOmRw7hZaTpX6V7owkMRa/vfOJmdCi64E3pWm5l/y/YGsIhCho/tg5dO
 nH2eGDFs/i4zJX7oWH6KpQNv09AygxsNKwZoDBFIsaOAAQHlIgmYm71W195QFPDxlI3P
 hJ26BRbtn3Mns5ZtCKxWuJeMi7O3oGfDunEQTnfc0biD1QpZuh7wBvXMWkD9Jf6tmmhJ
 wxO1O9AKD6+5qV9H8JN7FsvPmGrFX7ThxgulSBeDGoOHQFsbTCIAWlcHunKgLQmx/Z/a
 330g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752200536; x=1752805336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bq59WBBdyGyyfBaH+CxUoCVCYaFy5V0qQU0z7sKwR0o=;
 b=HjH0Ilyeth5FzidO/oABF60vVmuY85vocPo+d6j7yesQ9Gru8sheHULuWDp/QHHiJD
 x25jML7oNGGlOLbmzYDkic61jpHj5Zvr/Ik+n9UMO1Fz7jIOQfBHaKLekqeyXMeRPRci
 hfnSPuqYuBuh5x4JhUfG2tAqzTw4GkQRBUyVG0BrNYqFx720JEdF6s2sI3gEabFBMRC1
 dp6ctZgOf6HynZ2/+ppuaBXEpxjq3dHe5bjiI7BidrpXn1mRAGdsZjG3EoeMY0AnBqq1
 knIYekbW5SiGo5gwnqDFiDWtBAXZNaDtPC4e+2/xUamkztt+wrY0HP1ntAcJlLgTryv0
 MMew==
X-Gm-Message-State: AOJu0Yyui60iednVSmcbGMJqjXP7TMPDKQ7PbmWzdT+b3cm6kHUu4IeU
 CYNDniCP7zs8UN5Gs3uH2pIRDB/pjm2/XTtS39G/to0h23YN6Nd9WbOuq2+XhPcjSpmH0C5N2HP
 1G/E+VwN+3zg2/aMcJAydrHufs73lSkAsZg==
X-Gm-Gg: ASbGncv7y9NJaG9TRehz5WforZQEbQzYVK4yarj5eF92eQSE0gvfox320NVEyw7T/A/
 l6nATa7NCNduxdJs4+DqSPRSDhJnyM3mdYxPrI/B53z730Mys4++lS9567CcLtF8znUdb65YXZq
 8k0vK63HT/p2ODlV0vY7v1TJufAazmJbd++Vnk7NY7bwd9LkJwxvueGaP8BKDPIktMTOD6MXh2p
 M3zDyW5DYQWxj62RIgSZNZKw3FsrHNC/EP9hbQ=
X-Google-Smtp-Source: AGHT+IF7b0zGO+fqVHLR4KuKwf2OCu2WrhlrOtRaiSlvm2zpm3HUYzkIPD/flznP4LTDKzb/Fm//SB3YgYKqYbeLjzQ=
X-Received: by 2002:a05:6512:1042:b0:553:a2dc:6624 with SMTP id
 2adb3069b0e04-55a057c5465mr164882e87.7.1752200535845; Thu, 10 Jul 2025
 19:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250708103537.27632-1-michael@amarulasolutions.com>
 <20250708103537.27632-2-michael@amarulasolutions.com>
In-Reply-To: <20250708103537.27632-2-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 10 Jul 2025 23:22:04 -0300
X-Gm-Features: Ac12FXzwDiIrHshTW4tJmctdIB2sp1e2zRBwfFvDLq5Xq3BNp20psen85AkbnQI
Message-ID: <CAOMZO5DAv8vbFnXEfvC9-75dXN8n5bTysVj+Uwu7+4Ur+DJu9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] configs: imx6ulz_smm_m2b: Add board watchdog reset
 configuration
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
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

On Tue, Jul 8, 2025 at 7:36=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Add the configuration that allow to reset the board from reset
> cmd
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Applied both, thanks.
