Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58EFC54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 11:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E093D87D6C;
	Fri, 15 Mar 2024 12:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QjRrCT+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC3187F3F; Fri, 15 Mar 2024 12:56:35 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0FB8772A
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 12:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-29c572d4b84so664322a91.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710503789; x=1711108589; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AH7D3ewNyobtk24gahLBRboS/Tb85g3SJaRcTAQl2wA=;
 b=QjRrCT+lk2ZAnAK1sQjR5XkgkUQ/+9GYhvBc+36TEOpYM/inTiiO9RAHizm4tWxgY5
 msrxnDi9niVM0uq3pnQKNawv9iPDV2cnw4jNRt/Cnk9KGuB1CzWN1WxSQnJ+HJadszVX
 9dY25AVsggZessaG8VJAaQHVDlrM/H38mfTMa5XtGzKBLCVFuXQUB9PumtEgf5rOIgBM
 Bjh5RpszEicOJDZqE5bkK6zNhiYSo7bDtLYuyC2k6x6LzxGNtu/Fp+tQ2dAIr0sDy4at
 sN+87SWCDFjgd0c+wOmP2VFUKuFkRQWaNYzimsTgp8xkTQuUaSJ70mq12MUQf6z8mdlu
 3+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710503789; x=1711108589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AH7D3ewNyobtk24gahLBRboS/Tb85g3SJaRcTAQl2wA=;
 b=u341w2COZfF/Kd23TAEOCI/aFFoI1FEo2mA+enK/42ObxxiFkJh68AcIO3HPEj6ykH
 Mp4uHOrR6J8e8UCiqmtfJuZ+3nZlopSXMCwbEkFRRqXmomRpxJME2wBhtp8rChve3TDc
 tPis+eLoHWrFfuTNlbCzK7+8MVkosFtkZmWTcGHzLdIdbAUyMud4veePtcHpopiKMCXf
 sfQ8T2pV4PofRuON9tm32CoS48CrVeh222/CxeXBQLXpb+YOoQezHGVaLboyUkzeLpkZ
 n75qGleupWWgIN5IdDSmtQALMZJop3gPkGsA9ZTSh4KKCsiMFzPn454bM82JJAObvc2O
 5JwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsjGuo6d1orNQ4DBE9n5eNSkwrsghL5KXyTFIH39S6GPEbzLJR/AM8yqFb4iVOODvlktLyttNro4ObPnh4UXHl4PqpBA==
X-Gm-Message-State: AOJu0YxdHfQZcgOmTw2gZFjR1ZIiM+33y13RZtcVBuonXnRIcjoeq0EX
 b/ltLIlvvXUzZ+8j1HN59+mah1YKPfl3qz3klG8bEIuoUTxWPe8+M8EPCAHDikLKYvVO7ti6yE6
 XBvEmyCjsoP5m3uu/LAvLVSNUMsE=
X-Google-Smtp-Source: AGHT+IG5WTLVUF7sV14qwny/ThOTXgVk2QW+D8bo1GX+ZenoTg8lYocN5OpOyLittgBd2HcaII0VvzsbYZYzc4G1ONA=
X-Received: by 2002:a17:90a:8a97:b0:296:db75:c240 with SMTP id
 x23-20020a17090a8a9700b00296db75c240mr4274439pjn.1.1710503789503; Fri, 15 Mar
 2024 04:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230214133814.4173549-1-paul.liu@linaro.org>
 <20230214133814.4173549-2-paul.liu@linaro.org>
 <CAOMZO5B=EYPSNXkr=FM+iRvRYiv9fysB8DfhntuhQ_jhkKz38Q@mail.gmail.com>
 <875xxvratg.wl-maz@kernel.org>
 <CAOMZO5DBzEcga0-QGBBP3twT6imLuCv0cD6EYLOTwGN47wTxsA@mail.gmail.com>
 <87zfv7pojq.wl-maz@kernel.org>
 <CAOMZO5AMi_5XqYUodPcfiFtbn9A7P1HVn__F-BLavLqnwMeNkg@mail.gmail.com>
In-Reply-To: <CAOMZO5AMi_5XqYUodPcfiFtbn9A7P1HVn__F-BLavLqnwMeNkg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Mar 2024 08:56:17 -0300
Message-ID: <CAOMZO5CqH1OuVQDNH7+CuzPbBt9M8F7OOhDgCZZ0ad7rBfT52w@mail.gmail.com>
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

Hi Marc,

On Sat, Mar 9, 2024 at 11:36=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:

> Does the log below help?
>
> https://pastebin.com/raw/1i1VBA0a
>
> If not, please send me a debug patch and I will be glad to run it here.

I'm sorry to bother you, but have you had a chance to look at the log
I shared with you?

That's the only issue preventing colibri-imx8x from booting mainline U-Boot=
.

We would like to get this fixed for U-Boot 2024.04.

Thanks for your help
