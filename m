Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC629C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 17:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E69C886E5;
	Tue, 27 Aug 2024 19:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mly+HjDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F3D88675; Tue, 27 Aug 2024 19:56:26 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A2888A2E
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 19:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-533488ffaebso7046634e87.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724781383; x=1725386183; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2luGnNwRkyLSZIFRtKXU1NpvgW6/CzO2A9DaUPmidM=;
 b=Mly+HjDyMwMhe1YyC+hsoUtWVUeM7+sDYjqLd4cqroCG7RMx4QxvyqUQjJD3idpqK9
 25+142jZ5L6D0+dOB5jxV2eyu2v/gKnWiY1ymTJGnlhjjbsOvsw/98K6emvW/A8FFoZL
 6JVrLcT7x3dZO5BJnvkHB+5aAlHw/kyA7ieCWht8lQD8Q3FKfjbN2c3VO9aF1jSU0i6b
 EgVe02vQWOdL8FuaWwmObD8pBqIV9umgjl/nszlanCTp9QA9sjucugZbUee8WYAvoR6+
 Eh8t0nBrIALtSEEk9YnoUPbFwzI4qbnixtrdpO+XuJXckutzEax4tkMTOsdWts/PGskh
 2T0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724781383; x=1725386183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2luGnNwRkyLSZIFRtKXU1NpvgW6/CzO2A9DaUPmidM=;
 b=U8wliH8GnmSUVo1O1SITjQvTR1/tZktDIobqZdIL+RAWOnjaPpr+wTN4M+CMxZDLyX
 Yze+0B7eTahmb6Bi2tRRBFgwUdM1katw3jW0i/MSPr6Z0lw6ood8cd2OBFr0MCIZzaye
 1xb59BzyYHQVnf7JiO9znu2vvMbDYA4r/Toir51SJ+W9zs/lrylQpA9JSWDtc4hXZ154
 VocYOwC7xc+MaVy2nKcn5Ys0RS8I1OuBIq/Fux79WskOiUxAUclhe9FVQXYermqdH49e
 /MIueAoFwlFvpqkpQv/mXIns7T3lgDpgqt2eUwEUuUQ9oosoTGSqXZEDVLoDZprkWoSK
 pf0g==
X-Gm-Message-State: AOJu0YwnJa6oeFwQqZ32QNYs9wTU8gMgbY1tgo8xWeR1Dm8rlikfqs0P
 Swqz/IWkCmIFW9TOBU7G9sLjXAEBaSsUKSVOLk/jZf/CX5XsToNaGHjLcwQRQcX8CdIOeSunkqh
 0APt6EIqQXm6KePIYWNYV0dACt4O6eQ==
X-Google-Smtp-Source: AGHT+IFE4Ssbiw1sB8c2z5SX2+A7bk005R5cq3ZeBlBE31Gw5QfDAASofpG63OdxXZWQPi6q1oXsbqPtDjW2pqKVsu8=
X-Received: by 2002:a05:6512:6cf:b0:52c:cd4f:b95b with SMTP id
 2adb3069b0e04-53438773dc4mr9820985e87.22.1724781383285; Tue, 27 Aug 2024
 10:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <GI.Za6b.48b6UC5Rsur.1cpWwh@seznam.cz>
In-Reply-To: <GI.Za6b.48b6UC5Rsur.1cpWwh@seznam.cz>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Aug 2024 14:56:11 -0300
Message-ID: <CAOMZO5Aj9zSEWF9Gm5-tF9hTaczf6FXv0zo_z+Jws+BGPYPwrg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc_gpio: fix reading state of GPIO pins in output
 mode
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Tomas,

On Tue, Aug 27, 2024 at 2:52=E2=80=AFPM Tomas Paukrt <tomaspaukrt@email.cz>=
 wrote:
>
> The PSR register works correctly for GPIO pins in input mode,
> but always returns 0 for GPIO pins in output mode.
> The DR register works correctly in both modes.

The current code is correct as is.

You should set the SION bit to read the value of the output pin.
