Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC3AC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 16:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B06DB83444;
	Thu, 17 Jul 2025 18:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B23E7K+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D69A83447; Thu, 17 Jul 2025 18:30:51 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 655F58343B
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-32b2f5d91c8so9127061fa.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752769848; x=1753374648; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqTY/hgnUOGw5r/5MMNQ9zxLh09jKm/h4RTZnzclTLk=;
 b=B23E7K+6+PNnXQ24OBeCa0Pyy1WR9vcDRUb5diOma6YcvFfM/BHX2G/fsXC+qdTOB9
 sg2/vYVr2ncWkEwOlfNv59W6TQNXqBVZFhOJTKUbNEkPswlJKYsvmo/4IvgGnTWgWBsF
 2kRKdVHq7XXYQkJoJ8x6kWLjTTGJIjEdxCplGZS9GrEmkd1c4izTh3wjWKiZZy9Lw8sZ
 8XSLyEXwkASWA7XW6dYnbp8sbIHD1iKt/TS5XUx6BcE/0nEr19ixGcfAiSwuRGBEuTjj
 0Kf6HC+tlFrVY77JeSo6COxG12uUwzkFSAm052gFlDQq9hA7Mi7LC5hH+uAzx2msQE2+
 nVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752769848; x=1753374648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eqTY/hgnUOGw5r/5MMNQ9zxLh09jKm/h4RTZnzclTLk=;
 b=EchC9u6YdouWDTqvF0xQhaqpKokHkCUYLAxR8Fx6CpdOruw8YZU2Sl3OxLNXle50es
 P4jGbFV6Bu01F8iQJqiN8LHrgoS0IzQIEWeGF5HWvTvisvrX1NTP+x2w/2EUEX26mgkF
 oYeRcY1P3v/eeOLjXFjgRsuf9Sy4KIeEbOQGeTnrziHK+yycOKauzXg9HyAISiHmtDbG
 FO0/YFxbAHY+xE7PJIWmAg61mRXJ9ot0dq0LtcOKVRL3j6omMyW7k/FsWLRB4uHEuKMi
 bvmvWk23QNRhwVIcG6WDUjPdROw5aExMgopDEARorVHF4KQdoQDe55mcx2v3Dzm40i9j
 FZOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGVfI0Sjg+FFJlzJ4qfjM/L8x+wNWdpZoLIpx3G0BL+RhAtz4oIJ7S3UgkXIOz8O/yNCDtqUc=@lists.denx.de
X-Gm-Message-State: AOJu0YznxrNiH3czpOIkb8TxUo5QSXl28L9bKTjw0Aea58A9cMLCOGz5
 l2xFi5La7/ZhANax07fEmEHpHnEkkZtw2MbkfLU44IHW+TRy4Lw0BJbtxxmVxbfpPQ6IjdZiNIA
 +K7Ixasa1QIKvfFnWfYGubY88MLvetUg=
X-Gm-Gg: ASbGncvAB3lc6c5mLYqCqN0Kn/RnJ3QOsAYeinN2eKxsHJG6wPYjGB+ceCDKgVU/BY7
 iVG6Am5Udan1u71aNZYYvNkrV+9zZqRPx/VQAV/nVbO9h4qK1sphdc8WS11ZYCMTSZMpgzqyz2y
 AKrtkUuVS3kNvYpB9/Nu6vw76covm7F/qmraGtsfOJF18U0iWFnTpQ4QJHuy6FZ4cvhSkItr1m0
 hdVFu8KLWHOlZcZlhQ+MnSmPbYk7x7Sdek2
X-Google-Smtp-Source: AGHT+IEpmMLV/kXFH87hPfS5+KCGEyWTb+DiuNohfm77eAy+F72BSYAiWSwL2SVh4/UzEk+sKHlyYl+lr6zZ6HIEYIY=
X-Received: by 2002:a05:651c:1505:b0:32a:88ca:ec18 with SMTP id
 38308e7fff4ca-3308f4baed3mr21347401fa.10.1752769848163; Thu, 17 Jul 2025
 09:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250710081717.435585-1-l.anderweit@phytec.de>
In-Reply-To: <20250710081717.435585-1-l.anderweit@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Jul 2025 13:30:36 -0300
X-Gm-Features: Ac12FXzBOmHfkl7TRK7RlcNV8rFA1o01CQ4NopI7ft_oPGwkQ8sFG0a_yE_H5pw
Message-ID: <CAOMZO5DsWCDGeUPTN_d=8ZbYJCL1=qjMsyEsvnRwxwdUF7=qCg@mail.gmail.com>
Subject: Re: [PATCH] phycore-imx8mp: Enable standard boot
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Yannic Moog <y.moog@phytec.de>, 
 upstream@lists.phytec.de, u-boot@lists.denx.de
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

On Thu, Jul 10, 2025 at 5:17=E2=80=AFAM Leonard Anderweit <l.anderweit@phyt=
ec.de> wrote:
>
> Enable standard boot for the phycore-imx8mp and use it as default. Add
> all variables required for standard boot to the environment.
>
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
> Tested-by: Martin Schwan <m.schwan@phytec.de>

Applied, thanks.
