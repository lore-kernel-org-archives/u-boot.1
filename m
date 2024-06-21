Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49000C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 18:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 891458845A;
	Fri, 21 Jun 2024 20:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2XfV45/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CCD68846D; Fri, 21 Jun 2024 20:42:57 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 231CF88405
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 20:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c70878c54aso361048a91.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718995373; x=1719600173; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cozUdDLQLwb7yykmQzNYEW7SkYobU0Ql20BWmD+K/hM=;
 b=Y2XfV45/YliHtaHgI76CChqeTJ7V9wcDFGh9UkWKZPx70MJUQmBTv20ALwSNTfK6G6
 StWCiMCRIpRtbrHEWZqvdgFzfhXA8pzLehhPHZvjlD2uV82ssX59j2vA3BgodNdtbwIj
 VKM16idZ/GfChjXAYfw4c/5xQ1pbjCCHyEYaz1DajK65Hz+l1skhTpz7IHLEOJdAWe/U
 CTZeIeXKiZeIhT3lMfC+D5II8qknXHtXenHJd6cC4MHZJ163rVy+wcBDAYGmnUSkXSov
 eBU8nlcEWGAb0cFeNTD2E8NSHMlHMErXQ97jQrjSeu+6nfhgjo1jOJvNM/Q3YufXUkA6
 7sDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718995373; x=1719600173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cozUdDLQLwb7yykmQzNYEW7SkYobU0Ql20BWmD+K/hM=;
 b=C6PIsMT1x3xmadH6lHFje/D8fpVOCntgSGYzaxziPSyduPMSkO92WjRtPDioj3X2MH
 TtY995heT02dfxfQRe4gR6YL08DfDF5wdG2hjDt5TaCzbmuEVjKpshW7Th4KLUCtcth5
 QRP2vvzijhP6QfT4bWCfZxJaxHBbO+T8ojsolWGQWhNx2ZAfXt8fKjY3RTPIc8plG2mx
 PCbppc1tjLj8T8OyHQh+m2aQM2ayLY7tTkhW+U3QJyIPVT1ZHIGhnaoNgOFkHo6plrWR
 Q5zE9OPlp2lq1oRTkv71agcF1Vym2V5MdBrQ99oZxGTAoqtuL+h3aETPhnpBZ0jzbfKL
 VaxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmwVP3TdcJLLcyV0TDTuZPFFIODsSR20LbjRy0o+3s0YPFx6uKEaahba+wmShK+f3P82omfblQu4Sv7E5JRAnQE86Wlw==
X-Gm-Message-State: AOJu0YypEawbZaP7r9l7Hdi+Pf1ppUxSN54dme1RrssPvDMRrrMftSRW
 3Wk5LSQDN1jNT/L5CbExMDvOTHNIgl/BfuIb/Sl+GzxypJ62p/KLbOs1j1+yKu1xS8A7RcAtWH/
 3J3G9beF7UbdaIBpbqiES2gc+n4g=
X-Google-Smtp-Source: AGHT+IGgFSQM+FDR39XkroTNodWN/hUlxB76euXndCj+dwXk6EcgZy3TmhEF/QFMcs8i0vfHwBnKKtwyuiFwDlj5Zac=
X-Received: by 2002:a17:90b:30c9:b0:2c8:412:8746 with SMTP id
 98e67ed59e1d1-2c804128779mr4402302a91.4.1718995373487; Fri, 21 Jun 2024
 11:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <CAJ+vNU0yGH6FKZsx+UZXvnQnsT13U9iKUb68=Fqc_z7J0XL14w@mail.gmail.com>
 <0db93742-f8d3-45b6-9d1e-e4f687c2d81a@linaro.org>
 <CAJ+vNU3ECDoquHLyA3ULac0HkUGbzggG-bDQ8v0F2vStyr47gQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU3ECDoquHLyA3ULac0HkUGbzggG-bDQ8v0F2vStyr47gQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 21 Jun 2024 15:42:41 -0300
Message-ID: <CAOMZO5A4MS9eZe24WBSu4omfhjmwtjM72ftdQBwDWGd1wFiLmw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
To: Tim Harvey <tharvey@gateworks.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
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

Hi Tim and Jerome,

On Fri, Jun 21, 2024 at 1:08=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> I tried your to-upstream/v5-wip branch
> (042bea36eb9731079a3d7afffe3774d79e06ac5d) and it behaves the same. Do
> you have something else to try/test?

Yes, when I tested older versions from Maxim I could never get lwIP to
work with i.MX.

Jerome,

Please try to run the lwIP series on any i.MX board, if possible.

Thanks
