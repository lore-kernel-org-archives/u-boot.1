Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57075C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9693A807D7;
	Wed, 12 Mar 2025 19:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="APaP0uum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C9228141D; Wed, 12 Mar 2025 19:40:52 +0100 (CET)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4033680756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-549967c72bcso183391e87.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741804844; x=1742409644; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8muGU7rS11MpBmR5j3eI/cjEDjFdK/3urMK/wGqlobs=;
 b=APaP0uumzHhV8xALiEbZUYgOvP3WICXPxkVbhynvrBzu/PV6RV/0ZsraA/ZMIc0Ws+
 wzB8Gm3SFQP9rWrzbFFT32r86dOTc2KCy2pZ0QHovL4iSuH+7MhzDn/Izfl5LpKvg59X
 FO7SopBYn1+TJqvBrCYhNDnPUpD9vY+NrLgh4GfGTUZydw8bLGaA1JukHpX3pkC47lWd
 766DxqbHgpKYtuXryfXe3R07cMWGcQW71mdhlpwnpRVJ4AmmqzrSOblkMXRBYO6zF8K1
 wOGxGqqqn/2jIcGqMuTWcLtvlb5DorFLGlyI4kXhhqS8A7zZscQbmNtcqrlI+50ZWhxr
 M0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741804844; x=1742409644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8muGU7rS11MpBmR5j3eI/cjEDjFdK/3urMK/wGqlobs=;
 b=FBleG5zedjc6q5ZOnEt8ej3cdq+ERbxuSSDae3WJLtDDT9Lzwa7gw56axiCG5tf333
 Ql5YkeTtzalZlgOXpexRw+eDdIcmx+88SoXDQs9e7rh/cXIHyx1512vuXIwVtUzLguGA
 Sj7/Gswlc9kpZcJh8szI4gZubb5teUr1QmmA5YALr6iMQAqayMFPwksTdsvyjEGYHrPA
 nTLZwoyufIIUGo7kALI2IfZA64OHf59fWdc79hHzo0cyQE1igPVzxa/39YAf1yS9B+2A
 uvLlt1P/bwUk3OGo3LFaIEHMozfYPcN0hr0u9EEvhU7TlLn3x14hVQgqUACGntqT974y
 oVhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr2o8yr5Yy/fXtAw3trF/Wctp147j1HRmc7XJ9Y6iuG9XUNAdBUwoabTBO4Llc2h90grbDYkQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwRNO1+HrXpjR+ie18O/u0UyGzELymFtbv5YnG2PrDyjTjECOPy
 fljZT73wWQ4I5qQwWtsekupnkdi0WLXJkSXkDWJTTM6cVkXF3weJ2vEE5Jccoeyys5tLatDUnZ6
 /wG6fgiG/DmhWx+GmLdA5l4aJqE4=
X-Gm-Gg: ASbGncvotWa9XfE+RI864XcA6Nhb5EcH2xMqA1BwS+0k3c4pucdHG+qBC2UWqP5/8EH
 bLPmEHWTTG85Nxi1ldO+c7Cu6QYpv6noA4WNPENPdVk6fAqoD40QzdMVipfCcSmsVfICEe8wPoD
 qt85E8ljnN/4AQ2INJUQ+I+x9wn05vuWL7KBrWh9MqF36S82mw4KBM2TDqPw==
X-Google-Smtp-Source: AGHT+IH6HbS77AMFTfnJevZUhLBK1NSjX/CQyw/bD6hOKV9SQS0apD2ieUSTfT99seA22qQlASeJRKYUnmz7tffoLes=
X-Received: by 2002:a05:6512:230e:b0:545:22ec:8b6c with SMTP id
 2adb3069b0e04-549910b5cf7mr7778106e87.35.1741804844289; Wed, 12 Mar 2025
 11:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <1741770247-123217-1-git-send-email-ye.li@nxp.com>
In-Reply-To: <1741770247-123217-1-git-send-email-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 12 Mar 2025 15:40:33 -0300
X-Gm-Features: AQ5f1Jp6i1fSkk7fKAz2i7y_GjDT_O-RUl5DDrBd5IMK5QtYGldJ60QHCJ0fddw
Message-ID: <CAOMZO5AfRSjH=u6Q43Tg0rXfOZe5RUy1H31k7OHhOwHjDUvDfg@mail.gmail.com>
Subject: Re: [PATCH] imx93_evk: Fix wrong VDDQ voltage setting for LPDDR4x
To: Ye Li <ye.li@nxp.com>
Cc: festevam@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, 
 uboot-imx@nxp.com, ye.li@oss.nxp.com
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

On Wed, Mar 12, 2025 at 10:02=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> The default PCA9451 BUCK2 volt is 0.6v for LPDDR4x VDDQ. The codes
> are actually used for reworking to LPDDR4 which needs VDDQ at 1.1v.
> So remove it to avoid LPDDR4x issue.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>

Applied to u-boot-imx/master, thanks.
