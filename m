Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A61E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 14:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BF138036B;
	Wed,  8 Jan 2025 15:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mr0CmMQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4329D800DF; Wed,  8 Jan 2025 15:25:17 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DFE8800DF
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53f757134cdso17590807e87.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736346314; x=1736951114; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SiZNQyTlfLqvWxQRYSEzO3pNijgdm6j7SUZWc1haJhI=;
 b=mr0CmMQC+SrBnDNS458bYDWCi5siWdQdZdZF8Bup8xzG/mPkLOc0nc2kDF1FPLWX59
 5R40e3Y0NOQ5E9HJBQg8uhg/Od6n2PCm5x1pm6XJShW7WnOYLuINUJ6fE5uoIJoZJLKR
 rYGTBYLJat3uSk14Xsd1GsxPR9cYY0GQO8N5fW7jg957lV1XDUdUxxIHia17IkTuxheL
 vwlU0lYpKNYrsyJKxZoL69xz2RXp8/13+PYmdmCqDxWmQRfaprjxHAxSLrX5TyQ0lFYO
 kAmU41J0kRUxYWQN05okYW8klpqlejJK20dYcUah4VbETlkbmpqArTB4C98S++ViVA2y
 ujPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736346314; x=1736951114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SiZNQyTlfLqvWxQRYSEzO3pNijgdm6j7SUZWc1haJhI=;
 b=iGakNOmo9Kd75H1wc0iNYzpKVjZEfvvkF3FZKnCKk+VQLXXOyZimQfvid/6ts4t6Ut
 kuZW9iqZHQdCg+61nnKAYMJegp4gs8BUIiMyFNmfTo63ScpLCOPfNFI8fHEbt1vG5SW6
 50ZbcMRPQgd/5d/JBX4u/cKZeu82uen6SqfrNQXwRiH+aQRcy19ejGJIOT9OSnGlKF0b
 U8Ux7AFwy08zu/JoHW46KN9CIE9fCls+EE9RN+Arux6bSwNdEaLPszRTifuNhGbhLbN+
 sEGNn9h+tGp6XRPwMJPyMNHymKWwy67vFXsoE/ihZ/Xb1JelfA3cWPRqOiFR9jvWpmlC
 hF1A==
X-Gm-Message-State: AOJu0YyDsyDT9QOoyRn6QylK8Vi58HvluW2qzCe/OYZ3TzS5ElNMgSVE
 1IPa0ndt0aAyBh9QJDlbOWXDHUdc+wHRGbrc2hrTLLsZdLC+C55taAXcamGYq5lNRFPArwjv+Fz
 gy9kLt1SCGjufAB299eMQJRcRflM=
X-Gm-Gg: ASbGncswjrpNYGsqiiNnZA3f0X5Sc5ohLuYtgNFWl5HIVUlyGEM3EIfDg6zgOm2KrVB
 ZBZ8L+w//mJ+GQ95wXqZLvCkrAZ55i7nNhn7dIRLbCwtmZXbEV46/e4qfv+9UdFqI0jbDAg==
X-Google-Smtp-Source: AGHT+IHeUE7xVYnJrnn4RVtMpPHVcbjZq6KbiHScOdwKTNQxOffu597CQzO8p1gUPDiV/fCulDM9BlxT3pkErrP2/Nk=
X-Received: by 2002:a05:6512:ea8:b0:540:5253:966a with SMTP id
 2adb3069b0e04-542845da3e0mr761688e87.34.1736346314169; Wed, 08 Jan 2025
 06:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20250107225919.196131-1-marex@denx.de>
 <CAOMZO5CzsOpKHpuron5JwbHqHMJLT5LRPutJfWk5amzXdYpMqA@mail.gmail.com>
 <4215c58a-50c0-4e7c-9d9f-64a8bdd6e9de@denx.de>
In-Reply-To: <4215c58a-50c0-4e7c-9d9f-64a8bdd6e9de@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 8 Jan 2025 11:25:02 -0300
X-Gm-Features: AbW1kvaiZ-3NHRejmNRIK1N6oiGbWK73q6a0545avrGA_vzpJAz314L5fUcdvN0
Message-ID: <CAOMZO5DMD1a8buiW=UeUoBMZObpJmD5XWf=tCM9Y_tg4HjN0fQ@mail.gmail.com>
Subject: Re: [PATCH] usb: ehci-mx6: Add i.MX95 support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
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

On Wed, Jan 8, 2025 at 9:53=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:

> The driver is still called ehci-mx6.c , the Kconfig symbol contains MX7
> in it, but we still use the ehci-mx6.c driver .

You are right, I am sorry for the confusion.
