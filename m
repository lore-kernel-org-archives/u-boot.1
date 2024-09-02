Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27026CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 17:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACEE8876E;
	Mon,  2 Sep 2024 19:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="juOztE6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B2E288C61; Mon,  2 Sep 2024 19:44:11 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6FD8876E
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 19:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5343e75c642so5811769e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725299049; x=1725903849; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCfrZkc1LK05ZREFrc/STwu4oht6Hs/gf2+9fxUT07I=;
 b=juOztE6FJ4lV7EzFZCWiiRSFnWSmkhPmWKdmnEVp5udytkPi7HSbwPtpaXX3ceBCS1
 /4YzPTyGvvYhXwB2hNA8oeUUgx19U5AUSnNI5OsAMkf/+uRORCz2ltibNEbSAceFpSHl
 MdBhHfY2iY+4a+NYwzydNG85VeJ5ekzEdtUQRII1HbtoKy8X1/WszWwd2q5MRo6cWTTJ
 KVvQDhgRD72kKCOG7nysUcRTxj4rLlXRhe7HuMFIR/zhvNh4YDhlU51UxhaKxhYfJTf6
 AOkiSOF8d7xtR2IRiBJzZ3goTtAWl1nXh8npQ9E/wXfuvLz4ZM7dQvUI6Qqkdyp7V+XA
 KqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725299049; x=1725903849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCfrZkc1LK05ZREFrc/STwu4oht6Hs/gf2+9fxUT07I=;
 b=lg+0K1VRKhTPTEfShFmyJ0xbMlNH1dlP/7xu5mWY28QHEyf4hR0i0BH/iEMQwlLAIi
 /CHnIDDc0BqkQ4q5CtBt6HVBiEuXJ4d5Y+yLnafnWZlqTh1mzojr2RJAczWkaKMc9Tph
 zp0srOQ8aauun76OWpGY4mSlA7JcnI5T0v43Gen8tpK3FrZIwRjyJSZj/Ugrah8UBmKl
 sRjSvnXt3BdJ15aPPTTUV4vxp6QJHSWwtOWRAghuKKlHgg5gls25Hv6eTmSLVweWrSYP
 k4WCauYUUajapks42LX9ljQ7IWw4y2B1rDSRZxaNOaDXshdPdXpY8GtLsHr8CROPCl4n
 5eUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBhOtRs0xRCd6iGTF5Ujt73PdbUf0m3+PT2wfQxd1UR4eJjHtyzixsRDECaPwqnjN2pKt1vfo=@lists.denx.de
X-Gm-Message-State: AOJu0YzVJT8TWhaU94Sp0SCRHZZ+XMCwtwVY5KeIRXNV2AtGwt8VB+yw
 9l1EcLhIKfMKzWN8fLn0el81pUppTLDaRuJ/mwzon0I7QKeGvqhZhPrROd3SPBZ0tYQgkIlqF9v
 Ku7uTY4sRuduVi1u8ivR0VwIjLzA=
X-Google-Smtp-Source: AGHT+IHHPZ+/O/NwEmwPRukaq9NyOVFN2P5P8HbbaQHHDdPpSmBw0TJHeomfomAs0NFR/z3RnZYZVXBoOZq1TGieb/g=
X-Received: by 2002:a05:6512:4016:b0:52c:e3bd:c70b with SMTP id
 2adb3069b0e04-53546afae58mr8522948e87.1.1725299048558; Mon, 02 Sep 2024
 10:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240828132529.3098961-1-festevam@gmail.com>
In-Reply-To: <20240828132529.3098961-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 2 Sep 2024 14:43:57 -0300
Message-ID: <CAOMZO5AfuTROcB9tWMRy3LjuzC2QjjW-VvoUXAoSJYHqkkykAA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] imx: Remove CFG_MXC_USB_FLAGS
To: peng.fan@nxp.com
Cc: marex@denx.de, u-boot@lists.denx.de, tharvey@gateworks.com, smoch@web.de, 
 Fabio Estevam <festevam@denx.de>
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

On Wed, Aug 28, 2024 at 10:25=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:

>  include/configs/m53menlo.h               | 1 -
>  include/configs/mx53cx9020.h             | 1 -
>  include/configs/mx53loco.h               | 1 -
>  include/configs/mx53ppd.h                | 1 -

I kept the mx5 lines and applied all, thanks.
