Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0D7CCA472
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 11:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D3D083F20;
	Tue,  7 Oct 2025 13:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dQA2xwSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8915A83F56; Tue,  7 Oct 2025 13:23:42 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B4683F1F
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 13:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-373a56498b9so78063191fa.1
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759836220; x=1760441020; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahpkZS1Vg+w1MAArdhmLSLQ1Ndnf6vl+DWF1szD4T64=;
 b=dQA2xwSyFHAevtquD5/U+jWxpxxRJLtlEAU4cYOdyGXxlg3RVA+xZQ2lBDUucG8srg
 RsegSU0bKMP74PtsmlpnxD1q4JCqXvmKFB7MgU/F6eYRTRPOik/EPaibVPFVWN/VoTSu
 WOyaJ/nHh8evnEyAzI/qgtElwxYN4gq2C+K2EntBrG18BJ4Y3Xi+M7P9ezk+DnNOnWK/
 SKYKf4fFkrZ3oqUy77RcPz7IMwjnhEkh6IAufhjBiCsBu0TY1s8FwLyAHPFYUfEbUqEF
 1lKMxHCJRPS6h+osqT97AidYSkllwd5N30ekTW9pEGeAonPpeeE1pmDzEZta1YWjkqQ4
 FocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759836220; x=1760441020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahpkZS1Vg+w1MAArdhmLSLQ1Ndnf6vl+DWF1szD4T64=;
 b=mESUY5c1EtyXxCQIszYcBU88WNG6Z6wu+nBAIDNl+f7Grj3IMrjrWJI25Nn9y30nlh
 XGIgifuL/5rpTofLo9EAHMIpR4lL/UKkAaaH9V5qrEAtbhQFWUIU3pFoGYQuWbGIBclk
 reSr/zwWeB6TWTq3Tig5z+70om6+RVo83DywSvA0I92QgXiWxM7y/+CAptKcmUQKZaXm
 dTgeGMiaGprwAyD6GBx9noNMbIUnCuY83ZL3i8FVbFA7zWaYgcFMBR3iEbq4Ic8/YRri
 GuVjXC+B2Ee8MFZBaY5TQ3BVnwWOv1ekKHlVmhJCZ6o4m3i8En3Re7+2kplwCInUfw0y
 k6mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNk2BW9IlozKRTmhKteRRgUOD4ICrwK2sLBS/9OqmnEDM0Qelq4297e/vNws/oGt6QqkGi2Y8=@lists.denx.de
X-Gm-Message-State: AOJu0YzJXq0MgO4o42RHTrRK9rn7Eeu0Uf4v3QextrirLf85GKDv+X9y
 Izqu8YSiBAGSJeOi3XTTtkSx2C6YgdrWrspRcwxZYlmpvRWBzkqbmVTaEqlxADAU+kRen9sBym5
 sJx0sGlvaUbLUBqaIrsix2bvV9rmLWG8=
X-Gm-Gg: ASbGncvpxeqf+nwZLjQKmMy5kvrqWcW6+BIWm2O0xcVVMBEBxfd//IzKRKmdHGRchQU
 AuuDI5hXfEmlxsRFAaZDYnZNN+z77dwCQiFTzLCYSQvcG0FBvV/UQjjIPA/5SWTXhBJomIvQyZF
 NPKSZhFC8uADlOjOhY8JsWj01HVm1LiZadBH6PzSywJJrTMvTu22LR2EpP2OLUzJSLyiM47SV0C
 qMSOobcp11Yy6PE3ce9kcWZkGfUKFqDC4WSv5ca88z4tAQJB4ErDKrrK2bEIng=
X-Google-Smtp-Source: AGHT+IEZ5RaC0hqQu0fkjEyY4orw6X0jsXv9ZqHib6G2wQPdIyRcG5NDHzhIGEK5zyqVywDQcMZ2MRUoB1KSGzspCVc=
X-Received: by 2002:a2e:a54a:0:b0:373:c272:d986 with SMTP id
 38308e7fff4ca-375f526e5b0mr9477041fa.17.1759836219495; Tue, 07 Oct 2025
 04:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
In-Reply-To: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 7 Oct 2025 08:23:28 -0300
X-Gm-Features: AS18NWB4KveDY4xwB6VlrmpWA9DUL8zKwE9OEF7HhW_-CYTjpCp0WwK7-vbYPz0
Message-ID: <CAOMZO5DArO=XT6NjUheyL5-ec-s0WxW9PxTNEBZ6QXvdGVG=9A@mail.gmail.com>
Subject: Re: [PATCH 00/10] Enable USB and ENETC on i.MX943 EVK
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, Frank Li <Frank.Li@nxp.com>
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

Hi Marek,

On Tue, Sep 23, 2025 at 8:12=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> Changes for v1:
>  - Adding USB2 and USB3 device tree nodes with required PHY and
>    regulator support.
>  - Enabling ENETC1 and ENETC2.
>  - Updating Kconfig and DTSI files to support these interfaces.
>
> This series depends on "imx: add i.MX94 support".

Could you please help review the USB parts of this series?

Thanks
