Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B82CC54E41
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 14:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20BDF87D50;
	Sat,  9 Mar 2024 15:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cRP3Z0VU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1058387CF1; Sat,  9 Mar 2024 15:36:52 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A60387CF1
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 15:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5cdbc42f5efso978115a12.0
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 06:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709995006; x=1710599806; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cce/Z8QzgXhwJOO/TDm4EMebw7eQijRs5Cin5Xsgg8=;
 b=cRP3Z0VUlR3ZUWht2k9bwdqNG7aEvMnt/8uHeABR4v7Keqs8vV+H8vrHnQWvEQWkZ1
 KePDka365QgelbyVbA0kxhg5vsr05ntWMtsu98v8lhjwBXL37QKkBS/KBQkCZ1CSMqYu
 BZUjbA/l8mqo3Ywj1rhaoYjCmmQLP+/fdDrEoOax7ls8QhCW11WH2Rg2S3yeaPf9bsMe
 3UX7CyF3xMMk2ru4iN82tvG0DEuQry4xLcqg//6exDIUiuZOG/a8L6qUbJC4dECxpKcA
 VOcgYZezNdySZSOvR4ADzpIL5RFEjFWKrfbbsCsiNIeM+Nea+3YPQeWaIvl4P8LVkje7
 VdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709995006; x=1710599806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+cce/Z8QzgXhwJOO/TDm4EMebw7eQijRs5Cin5Xsgg8=;
 b=luyMiObyyb+uaLUn5rpKw4fZKFUjXf6hFmyXxUnQjB3G6gj5Nf2lPf1fqfXrqSIfUu
 WRMyDe1Aiw9UWxEBHXN+4TMMVBysqJt64nkY2kNR2UMOMiClXmoeleUOCbbGPkXnp59L
 N75MUKCZWcr41yE3CiWHc2XZkbI9Ec3BDUi4VGgIszCP9bw6e9iCS54zr4tz1MpxebO6
 ojEq5SiSwP8CVqEu5XJo3SlTD/UhbvT40nP0jQBUVFuLyxTOqdXHH8cRp6biVvjdZFse
 GTwi/bWWT4mdlJBDkb7QoJnb4TBfuajwbheMMpMIzJz0tviE25DVRJ9n7KSGfMne4JhV
 X1DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxDlUfuFeCR539ZtpNUa5h4gpGRvPdnox57Otb5sMMndXq0W+/izTZ/5d6DSV6T2obiPfqdHR6ovpB3zUvGoa/m07kBA==
X-Gm-Message-State: AOJu0YxcQVr2Pb1JPTPBqj5xiTItZjuS1mtfkeYwC0TFhhrjcae4ogdq
 ilzlvVcIcJiRsiCw68H9Yt75zCRDXZacmlHvbuFN1l/5sJhmO98Yh4eNcSKFPRLtI/rYHqrW31+
 Y5qgQ+tkyKqZJ+jgFg7AgGAVuoeY=
X-Google-Smtp-Source: AGHT+IELv/QssnFElL3dms1Vdq4CeIk1wDD6Nagp9hnU3cGct5HYJHZXFgmF/P1Ai1cETRmGd1izFRn8s6cQSfSt8nk=
X-Received: by 2002:a05:6a20:9f98:b0:1a1:74c9:b66f with SMTP id
 mm24-20020a056a209f9800b001a174c9b66fmr2971257pzb.3.1709995005803; Sat, 09
 Mar 2024 06:36:45 -0800 (PST)
MIME-Version: 1.0
References: <20230214133814.4173549-1-paul.liu@linaro.org>
 <20230214133814.4173549-2-paul.liu@linaro.org>
 <CAOMZO5B=EYPSNXkr=FM+iRvRYiv9fysB8DfhntuhQ_jhkKz38Q@mail.gmail.com>
 <875xxvratg.wl-maz@kernel.org>
 <CAOMZO5DBzEcga0-QGBBP3twT6imLuCv0cD6EYLOTwGN47wTxsA@mail.gmail.com>
 <87zfv7pojq.wl-maz@kernel.org>
In-Reply-To: <87zfv7pojq.wl-maz@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Mar 2024 11:36:34 -0300
Message-ID: <CAOMZO5AMi_5XqYUodPcfiFtbn9A7P1HVn__F-BLavLqnwMeNkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: Reduce add_map() complexity
To: Marc Zyngier <maz@kernel.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, u-boot@lists.denx.de, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Tom Rini <trini@konsulko.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

On Sat, Mar 9, 2024 at 9:39=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote:

> Can you figure out what memory access is triggering it? Even at
> narrowing it to the subsystem level would be a good indication.

The problem happens so early that I am not able to narrow it down at
subsystem level.

> You could just dump the entries as they are written. The order may not
> be the same, but for a given VA you should observe the same entries
> being written.

Does the log below help?

https://pastebin.com/raw/1i1VBA0a

If not, please send me a debug patch and I will be glad to run it here.

Thanks
