Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FAAC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 11:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C77758757F;
	Sat,  9 Dec 2023 12:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GHMK11DV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B58BF87620; Sat,  9 Dec 2023 12:57:43 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A010E8757C
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 12:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ceccf6d88fso215055b3a.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 03:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702123060; x=1702727860; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1AWC4sixDFYIgP5Nq5jvbGsG05em8zCyIHmQtnjhSQ=;
 b=GHMK11DV20Rl34lasnqFyb7VBFpy3NOVjREib5Yz7MXqAefpIb3ugW8TX15oH26hAh
 nxxvdC1KSjP5cVxYAf7tuvNIfx4YoPW1WIsv0iddSG0cnMRkh+NYEBX3FS9tpQDJwoCD
 dD9WXIVoTUezTr/QGmMrc0tIuhgqQCHxdtsb4y4bX5X7eROgoYIWHIupcE+j4tB9UrVV
 j9TF8OmZi9aGPjFiy/2RWDDYvWxCr8vx4HxWXsBas1V/zCC7zSZfKN7i/ncvyOBPzHfM
 t/ymKqhfjXZzy27SlW5hwi6WC3hs56eXJzjF3xDXG33hEAP0E0lZff0qR3VF0CtQEHac
 E/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702123060; x=1702727860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1AWC4sixDFYIgP5Nq5jvbGsG05em8zCyIHmQtnjhSQ=;
 b=DgU/8N7I7EG0i6lERT46g/EcYimwv+p3rO7O38zOgPNxHRI8MQ2/sMcskDM8xkq4T1
 zPEL7r1TMnxB/LJi2vCcvBSagUOuS4jtP01A35p1w86pwm/3erkwjzG95zHrU3KjGmav
 jf2Mgcoo440ZwPK1Bi/IMEuK1OJpJZPa9se2GuHxI64fdStR33HGhDEjMejMppTNEaUr
 /NLoScqkgnEEHEVYnjjhJeNKgNGElc7RM+gQJnpnsFxmmaVGv7UhL0KpqeJfaknPil60
 BG2ezvYp7UxjPFzNYhW5G/w54CKh0tsm6vkY40g7znJd4gS/SvOsGfoVqCP5cPotcjkw
 zO9A==
X-Gm-Message-State: AOJu0YwAo4rBzXcQDRJIth6ArxSeVoFCruWTtPwy6Fg1iOszLkwcAjLx
 y+3QEBi8i74pRowRelpK6/fVIDlRg4hgp4MkQCockrzu
X-Google-Smtp-Source: AGHT+IG2DNjFEkLSXm6J8549ZgWURjQD4SwLfn818TsrZ6FdSQ5g9Ion6Eg7fQf/GHxHfeGSWbOWQsI3LROsNFYWRXk=
X-Received: by 2002:a05:6a00:4655:b0:6cd:e328:9d8e with SMTP id
 kp21-20020a056a00465500b006cde3289d8emr3219737pfb.3.1702123059815; Sat, 09
 Dec 2023 03:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20231207175056.336787-1-marex@denx.de>
In-Reply-To: <20231207175056.336787-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Dec 2023 08:57:28 -0300
Message-ID: <CAOMZO5Bf5sa7oEKyCJ7cArj2AKm=gdi4e+agKhdioaj8C=0fzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: imx: Force DRAM regulators into FPWM mode on
 Data Modul i.MX8M Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>
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

On Thu, Dec 7, 2023 at 2:51=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> In case the Buck5 and Buck6 regulators which supply DRAM Vdd1 and Vdd2/Vd=
dq
> respectively operate in automatic PWM/PFM mode, the DRAM EDAC detects mor=
e
> correctable errors than if the regulators operate in forced PWM only mode=
.
> Force DRAM regulators to forced PWM mode only to stop tempting the DRAM.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
