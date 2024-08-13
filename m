Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BB2C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7950488842;
	Tue, 13 Aug 2024 14:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Aj711ByO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C15AB8899B; Tue, 13 Aug 2024 14:43:26 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F1C188842
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52fd0904243so542092e87.3
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723553004; x=1724157804; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoxcnenKDT0drQtvswtXBy9nAC5DFoJfVcx12J0/bVo=;
 b=Aj711ByOR49USjjbAAz7mvFaj+FBCtON4PSWoy/wUN5BPtuwNqIzotelp+n3kXV86E
 ozO0+lxPAwwA1OmSCQMib4GhDSs4yeMDcH6YFxD+0GcMpOdCi5IUxy4iozi2IDy4VVxU
 lBh6lLzD42j2vEf0nKLajKysl+GQ2YSiR7bSBeh5FjPpw7fSXsjJva0CWL3bb20Xh0jG
 Nb3itO//kmz5dTcbCr9SscLqG/4XcypHLRhLlikOPa6+AIY7D06XrXQqhZA7CjGYEcqP
 pjVWZfkyvbpdmqc9mJDPIMNnOwngh3i1roRsIVEsT8j+VRPAWdbhcryJslZxeN3323l8
 iRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723553004; x=1724157804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PoxcnenKDT0drQtvswtXBy9nAC5DFoJfVcx12J0/bVo=;
 b=nopDiH9+p7MAH2JCn12NyHtC3gCs3Y9JQON1JodZZTJ0F9/b9kXnTdP9teQ4zxRbM5
 lhrE8V2bPvifZag0dVihkxU/UfLhbvKwOCC2Y0gInKPKeJXVi6A/jKG3C4wjVz5L6s7a
 slLSRLF7f5pfoYqbzEglfsUfeyZnfmlsAPvSOAcSF1Um4kygeW6JqnKO7WD/TrMcZfDj
 275CpSgze0seE4NWPr+R93iTv6sdUdv89qzuEtGeoOjIddvdXrwcbHRz3UlN9jmSxx7M
 +xMqDFlnCrI0v8pHyZMO5L3iYwQGo4eKLz5K+JRTnONQmDZW1hXT6ZrrXs9zqlpLmdqs
 qSzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw1z4GKL3h9N5QxIhGnsfrIdorxnGoshbZ6oXI/AvLvOlBlKp1Cfx41hFXjgqEA8m7fKysN74zqLKjJs5xs8snRvnPwA==
X-Gm-Message-State: AOJu0YwMbxXd3ZBGkfdP4gOyx1h2EpTqIhAKhVLt4aRZqFxI1RBFlGwH
 KdiVK5eQ2MBgLEYKU76tnViDuO2P/dAjNvTceOLc7FJD91zcCNPWGikiOT6qfcoGOccXUPxkmTv
 tM1XnbAP3BG8LaQbY2Be0ueaoTy4=
X-Google-Smtp-Source: AGHT+IGEAnAO9OFjMK61mbXb4054HOjN+88P8YRldHRE2cslErIQgFPXz5xJnpXc+ry4OQpD6CZuiI0N9cK60A1kI2E=
X-Received: by 2002:a05:6512:3ca3:b0:52e:9beb:bc09 with SMTP id
 2adb3069b0e04-53214fddc1dmr902926e87.3.1723553003347; Tue, 13 Aug 2024
 05:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240423141551.2410199-1-caleb.connolly@linaro.org>
 <eb12b7f6-dba1-42ac-adb6-3c180d811130@denx.de> <87ed6ssj5x.fsf@baylibre.com>
In-Reply-To: <87ed6ssj5x.fsf@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Aug 2024 09:43:12 -0300
Message-ID: <CAOMZO5BWjyy_nuHaRKrh=ct9_e8JqfRZ6qtTmBG_r2-bpHMwPw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: support USB 3.1 controllers
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Igor Prusov <ivprusov@salutedevices.com>, Nishanth Menon <nm@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Stefan Bosch <stefan_b@posteo.net>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

Hi Mattijs,

On Tue, Aug 13, 2024 at 9:26=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:

> Marek, should I pick this up through u-boot-dfu or will you pick it up?

This one is already in master:

https://gitlab.com/u-boot/u-boot/-/commit/ef1e322f3e1d9a221a1ee6109f6571429=
ee9fb4a
