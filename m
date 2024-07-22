Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464F4C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 21:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA04F8852E;
	Mon, 22 Jul 2024 23:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U26WmhW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19EA98851B; Mon, 22 Jul 2024 23:04:22 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1C74885E4
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 23:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ef260c4467so4311331fa.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721682253; x=1722287053; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hX4+Ci1Sm0jo/F8JrVtRbz16Z4sEA9jmy6R2rY9Mtto=;
 b=U26WmhW+rVT8tL2iC3BR72yK4TZirIOsCqPsz85yt5SrRLdKFSsMXAXM9EkknyaK5w
 Ti/JoYF9xcbL/pXtG+Pt2JTA+UitsohmnRTzk1/TqA8bmUav1ZxuXGakeYYMV0tRBlzJ
 zAu9hFDEjWp53VeqQSIyovD7O7y5loDHs+cucVQC2+s2VmtD5DayF6C5Rezq60oF6Tc3
 ugCNGxGM9jQAH+u/Y5frC1ozJZLpVO5Dd8/Om9awlkeJDldfuBZnCOpkRd/XgvXEI2CY
 a0x3WeiTHHT8+Ryac5TVqi2paS6Gsrs2l8w+FtQii+IQBFj1G/V6rlJE2g2eO0NsrRs0
 8zBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682253; x=1722287053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hX4+Ci1Sm0jo/F8JrVtRbz16Z4sEA9jmy6R2rY9Mtto=;
 b=fCFRPl70uLZEzSsXXhwE1dgpE7oc+1iKtlYBihBwrfT6JdxriJKKvbt0ZqUdTLG4y0
 yG/T63ZTY4Ynh/yVRGgLBlwX+R4w9nfmwWH7qE6xm4PYxY9ekjSSpk2MLx35R+ElJYFL
 0kGSRxJpAWg5416k4v6MzQJr4tbtr++3Im/aPzMTbAAst+7Ia58Zbrl16FLo1sTUZT5I
 Wx6+jIUkdss316f6ZGqOs7kazTlYYlGUm3Is5C/5EDsWIY7WcQbjjaCjlTxnwt+1R7ax
 dg5Z4qQIZbbPuwWK5aEqMD8yk4HLsJx2lp+FWyefgPNv0i4FmTHzW3yCSYkuxMr4UtrW
 7Pjg==
X-Gm-Message-State: AOJu0YxcInmDff8khRrIRV8ccUF8r1/ryt/is0WKBGEMYGNFTGIeqNTM
 k8GQO7bNslNg8kFnMaudj5du7clJguRPeZyk9O7z7hkFle0gjIh+pWDWlOhlW9Mdmq3Pm40eHAF
 dlzAEmETReTjzmOvdWlJrp+m8iucnAg==
X-Google-Smtp-Source: AGHT+IFW2ygr0Y3CJk+oIh2a1XRCpCpdPy9nlJLWu5CQMF36pomXIWioD2qLuuxiJa8GmZAB3aqLq2JwrTPoKVnoH9I=
X-Received: by 2002:a05:6512:a88:b0:52e:93d9:8f39 with SMTP id
 2adb3069b0e04-52ef8d8654bmr2918385e87.3.1721682252690; Mon, 22 Jul 2024
 14:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240720153539.3550313-1-agust@denx.de>
In-Reply-To: <20240720153539.3550313-1-agust@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jul 2024 18:04:01 -0300
Message-ID: <CAOMZO5Cdt8ngLjyZH2bNSEDY2RGOk9OhnwnhDD-fJnQ3uZTb=Q@mail.gmail.com>
Subject: Re: [PATCH] mx6boards: convert to DM_I2C and DM_SERIAL
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>
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

On Sat, Jul 20, 2024 at 12:36=E2=80=AFPM Anatolij Gustschin <agust@denx.de>=
 wrote:
>
> Rework to remove use of legacy I2C API. Also switch
> to DM_SERIAL to avoid board removal warning.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Eric B=C3=A9nard <eric@eukrea.com>

Applied, thanks.
