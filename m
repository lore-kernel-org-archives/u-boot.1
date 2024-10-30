Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12903D7494F
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 00:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A43891A3;
	Wed, 30 Oct 2024 01:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mXKB7sW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7CD3891A3; Wed, 30 Oct 2024 01:16:29 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A94D891A3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 01:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6e35fb3792eso56366857b3.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730247386; x=1730852186; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPW619fG2VuVF96SoE3+q223PVEuALef1DbC72AK0oc=;
 b=mXKB7sW5SzAy+7AWg46EeLw2W3+xOnoDtkc5yO+Z0gUpaoeDbPzFnPwKg06sXO1M26
 MaH2I71gGzefiHa4Kw+XPdOpJs5YdFutnysVfljYH11/588P7XIRgSHU/WZj92IlR5xV
 C6k7ujRMGhYrMQiRfGjk403zOj1FQtireRWKNbC7bZoROoCY/qc1tu6Yy+LgLUsag0Ni
 v9LYvIbfnOsPD4mM/TLLl2iQiSGyWz8h3Ljz50qwygEQiLSIpevGoj5HhBKtZd8bNWqp
 newZYylsH0aaiZg/YYzaGGswjwXc53LkpiUeTnwM3PX4K4/INw0nRRv2c41LXsI0TOmH
 iXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730247386; x=1730852186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rPW619fG2VuVF96SoE3+q223PVEuALef1DbC72AK0oc=;
 b=uia5KAlh2wF5xiPUeuyOUu0P6aRMMgs1TzC6jk+WYoYPQUQDnSQzk0RNcs3wbnyr6V
 Zt+PJNGv/Ov4hKcYa/VPEZnsrUA1+S3CH9izWrnyNNllNI21yFBP+WFevC6lUtx/FdFp
 56kgDBgL6mTKdU4/X72DjX4ZzXGTI5t+0fUsUihSyd6BN0TcTjQBUz+bYEjv63sPo/+n
 LaqBay94PyQX4IcjBmFJBJoSuKXTn7WuXYB/5uPELHYHqVIwvKilxXmtWmgJ3qK3ySJD
 NrPtEriZwCfZ7HSyJqM/vnW0sqmEfr327Q2oQgT08++2sECQ+IImNvTsFV0DGm/rNELv
 39Wg==
X-Gm-Message-State: AOJu0YzLLobwEqpDpGFg9T2VQN+q2MaNkNerlUWvA9gp8zBujD7yKyOg
 HNx1HGMx7Edjy+5rtq21K9NCa6dmtz9CAxfWHpHhi63jlVjqaiC1LYj0KaWbV8kBqcZP270/XlQ
 cukH+q18CbmFrcdbz/AcfLdINAPo=
X-Google-Smtp-Source: AGHT+IG1mU42TD4GJXi7zrk/gAVFVDU9PkohvrbeBLhoDyc/Xprr8aO3/46JnocaYXi3BMUD/xrjRi2IeYPp7Dzu1RI=
X-Received: by 2002:a05:690c:2c13:b0:6e5:bb93:4322 with SMTP id
 00721157ae682-6ea3b980d5emr15374607b3.38.1730247386002; Tue, 29 Oct 2024
 17:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <0b4ebdf6a0219a871eb031fccd9aa6d8c9cb2348.camel@iris-sensing.com>
 <ad6c9edb5194d8fb5b61fd6cc1d36fbce09efc6e.camel@iris-sensing.com>
In-Reply-To: <ad6c9edb5194d8fb5b61fd6cc1d36fbce09efc6e.camel@iris-sensing.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Oct 2024 21:16:13 -0300
Message-ID: <CAOMZO5DRJ9d48N=PEvfiaobJU2ncKOT8ZwPxxsEzw63Lodi2mA@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: dwc_eth_qos: Add support for platform specific
 reset
To: Erik Schumacher <erik.schumacher@iris-sensing.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "pro@denx.de" <pro@denx.de>,
 "marex@denx.de" <marex@denx.de>, 
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>
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

On Mon, Oct 28, 2024 at 6:42=E2=80=AFPM Erik Schumacher
<erik.schumacher@iris-sensing.com> wrote:
>
> This patch adds support for optional platform specific reset logic in
> the dwc_eth_qos driver. This new function 'eqos_fix_soc_reset' is called
> after the EQOS_DMA_MODE_SWR is set and before the driver waits for this
> bit to clear.
>
> Signed-off-by: Erik Schumacher <erik.schumacher@iris-sensing.com>

Applied all, thanks.
