Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AC3CA0EE4
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 11:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F108304A;
	Sat, 23 Aug 2025 13:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c4Oui3Jq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C12583096; Sat, 23 Aug 2025 13:53:24 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7351482E37
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 13:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-55ce526627dso3074266e87.3
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 04:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755950002; x=1756554802; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PA4CQaCMKlMfV3xPo95VM44ncW1jK839/8RCHzssz+g=;
 b=c4Oui3JqzIRAX2nS4RUSSgKYwZhOXgTEllwv3bu3LTB2v1pk+6D3rcF+WhnvwHp/x6
 GhhLzicvqqQr5LwhiNB4tuKujDODe1nkuuYIiQ5gvSb+ylerKgAodZ7S7xAdQerhnaog
 A0x1gRX9FfDJgzL4szf4u/RRx9YIU5yIu6xIv3MZP/Rp4Rcr1a5aNyaCQnKNdkyzfdh5
 dLf9dbr8iNOVFwCyRTMOpnwEXbHakxJYSVKqrb6gyE/ynVsvX1qbNgQwNy13bV2cjAnY
 M/l+dmozkf0GhQt/g38PLpbcfLbYjzEONMx0eZIgVsM1rzinkCBsrjnZoJZA67mlecNs
 bsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755950002; x=1756554802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PA4CQaCMKlMfV3xPo95VM44ncW1jK839/8RCHzssz+g=;
 b=sL3QSsqd1mv/A+IJ2si3S9CeeNKbKtgRX45XGs6w7KHWOyS/pPtGEfmpGgDSxCw3+h
 c/AkzZ0jRPjc1Yl887dea50uwlowPJPpFK6q5DliDtbgp3TvLapL+qUPJFqf1Tft1Udd
 7gMIV/meXABs1xiQgM6RXPzVh5/ZV/G5X2MwMisTGHS2zBR+R0wsalWAMp13O/7lPCsK
 +Ty1wBQ3TK4xLhdLsVk+IAD8jdrlLqCuKuoEdz0MyLByY1nZO5CMcfOkGK1eBSRrbIjh
 BcyjVpBHkw5xI5ueHgdyN/aDkRHg9GtB7RQUx2/RcnR6+OOVbRauJxz5o5hIqisSqk++
 i3sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZHjsIroM3HcKe2hRyGiAncun0h2w5nfd3ztL2x0K++qThZ1uVGKsIar+hN5I/6wtRho7DU7M=@lists.denx.de
X-Gm-Message-State: AOJu0YwDhoFzta9LDWd2+LZ3l8885bBFukB2YeDbYuohYxcSIk26myBL
 Qjpzcpr6rrlbxthK2No2HfMADxFyK6khcmxMBsNGNEWZoriix0QdD21QxCMKqXedFKZHw7+6337
 X/15BPUFX1aoaz1gjM9Cr7VgrfzK22qQ=
X-Gm-Gg: ASbGncs4k2iElSYzOG7CKS6XqZVOqigB1LTzHieBk9d+YNXnuojjsDAJ6ivJIzQWHFw
 uwcn7m9pBCVdNKRLE5QxswqprVBTc1p8XVSP4IlilxE/PR76V49GUP+pdOJnmtKc0/35bNwJvlJ
 CIGQ2qcyYoOKwQZclL9TwHavShqLHpLQ0AtMdmw393OTzhmx297z25JGU2yjLFMoCVN4JGgx2Gk
 a6EJjeLtao1jOJjhxD60u0UQKy35/gCKNpjWmmwqnVRfORNrA==
X-Google-Smtp-Source: AGHT+IHfPFhLzC6cSAH8uTvcJjIq+cHqtddCCtKxwh+29R5VChAitiA6LZSNjdNc9JNrmExaZZGOMWc0qEAKIcaHBp0=
X-Received: by 2002:a05:6512:6711:b0:553:a3ed:f2ee with SMTP id
 2adb3069b0e04-55f0c6a4088mr1459722e87.13.1755950001399; Sat, 23 Aug 2025
 04:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250721180205.2696763-1-tharvey@gateworks.com>
 <20250724034438.GH18395@nxa18884-linux.ap.freescale.net>
 <CAJ+vNU0bm6ZB3cZP6Az45sNsMZ3QZJEVj7C20yFygF_YSqa5bA@mail.gmail.com>
 <CAJ+vNU1n_+Q70jYEtZ4Eii4qM_R6e+uVfHPKZD5KYHt_ZrX2cw@mail.gmail.com>
In-Reply-To: <CAJ+vNU1n_+Q70jYEtZ4Eii4qM_R6e+uVfHPKZD5KYHt_ZrX2cw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 23 Aug 2025 08:53:09 -0300
X-Gm-Features: Ac12FXx9CcfiFZt_pe-iDr3ERspcQnZ_VbEytXkHoMXKzWKvuygiyre48Ddt33I
Message-ID: <CAOMZO5CSjZeXpHGqRCZsh_j2iSo_RLA+VKZV-vM=LUyrhhPn=Q@mail.gmail.com>
Subject: Re: [PATCH v2] usb: ehci-mx6: Add i.MX95 OTG support
To: Tim Harvey <tharvey@gateworks.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Fabio Estevam <festevam@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@oss.nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 peng.fan@nxp.com, 
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 u-boot@lists.denx.de
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

Hi Tim,

On Fri, Aug 22, 2025 at 6:38=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> Fabio,
>
> I'm not sure if you were needing more reviews for this one or if you
> were just waiting for a follow-up to Peng's question.

This patch looks good to me:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

It will go through Marek's USB tree.

Thanks
