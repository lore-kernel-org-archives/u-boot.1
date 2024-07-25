Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D959C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF4D86464;
	Thu, 25 Jul 2024 15:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SDJ1gwBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA69487919; Thu, 25 Jul 2024 15:03:57 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C04380805
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ef2c0f35f2so162671fa.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721912635; x=1722517435; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXf+GcdYzsg+76SBgeBKaMpnUugcPufsMdWhbdKshDA=;
 b=SDJ1gwBLOjoBvU32+t4ygW3LktQrbFsUOhvHgq6kqDJz5rvp3cMKyy6Cwbsr/zX3iL
 SMGF+khhCw3gniXdu7DP8YWg/EKLNso6jf5D37W2lNKaC5EhBke2i0ALG7OYZ1z+ngeH
 A9L+nxVvcLrsU8rICaG3Rbk96QMJsEN/HkPbUuRv+SCT8X+t3oOfrNRrKZOGRJ61f7AV
 /gMfRNoGyGtTF+Cayqw1qVKTDlZiuiHcLEtDIgzeZjof5xbugfS91751foDU8fXVh3LH
 yfgvf6ky0LPNE6PxARiCR/bHVgZu8u2rnLQlx9J8rrDW2q74Lf4VqynIG1e6kxWGmNtp
 z7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912635; x=1722517435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXf+GcdYzsg+76SBgeBKaMpnUugcPufsMdWhbdKshDA=;
 b=RHnMApSQJSNYTNwy5kwMDZPZN2fDW5dONAetZFkfg10Svtb2Lu/xjWP88bj3mjFhdF
 FQxlYeNQmiCHrxeguVZn7vbuTTQKMTx/cmYzm5vu5Aiq9tF3rwmVPwsbdIKYoN8q1iqX
 1Fbyr/yl6JTP7F829DVqdDR+DhoDf6Cj+qyx6BW37PFzX4Ab0YPeyTVo89oMXZiFBwnQ
 XqZx0JPt5z9hxUcAT3+g1tMh6xUGx8uIR9vMbfbm5V9LKzaPKXYQ3uXFemBchI50qsse
 uyTlFi/vzLnQXT544NV7tJo01jks7hOpjEM1lgd66iZx8rig6eP6zPHyCtwp6eVxk3/H
 WRKA==
X-Gm-Message-State: AOJu0YwIW48rsr1uwpD4VVijCUK+GWwu67pHe1kPgmlgwT/yNY3duPM2
 iRWcteVbF4TgKhSljk6oUxGg8bk5hAJgGgf45/EyFhx0U3PYEqcUDi2qNcHO6BHusnZFYlO744x
 M0TIZkSrr9QZhx0AoQNUuy4mBcyBWJIx8
X-Google-Smtp-Source: AGHT+IE4JP1dp3yds1MpbnYCr9cxPD6TsErOPZ7bXI8CUEOS1jfQm3J/ETB7R5v+a4d0gWEmjghMcyQ9HIqBMVSb4Xg=
X-Received: by 2002:a2e:be13:0:b0:2f0:1a95:7102 with SMTP id
 38308e7fff4ca-2f03c7b8a37mr12512631fa.6.1721912634886; Thu, 25 Jul 2024
 06:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1721910373.git.jerome.forissier@linaro.org>
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 25 Jul 2024 10:03:43 -0300
Message-ID: <CAOMZO5A_0gdH6ndm18Gpy7opbHCLBKxO9j4yKJa9XvoDudmg-w@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>
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

Hi Jerome,

On Thu, Jul 25, 2024 at 9:58=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:

> - Add "net: fec_mxc_init(): do not ignore return status of fec_open()"
> - Set the proper environment variables when DHCP succeeds (ipaddr%d
> etc.) and read the proper ones for the given device in new_netif(),
> allowing correct behavior when several adapters are available (tested
> on i.MX8M Plus).
> - Fix an alignment issue with outgoing packets (see the linkoutput()
> function). With that the i.MX8M Plus ENET1 interface works properly.
> (reported by Tim H.).

Adding Tim.

Thanks for fixing the i.MX8MP problems.

Cheers
