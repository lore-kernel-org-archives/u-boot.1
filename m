Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF00C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAA8987846;
	Wed, 13 Dec 2023 17:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qn0BY442";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 043598783E; Wed, 13 Dec 2023 17:28:38 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A6F87846
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-28ac8f1c7b1so281231a91.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702484914; x=1703089714; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=75c0ZRR1XLPLPjb6eEhvjaR1ky0np4GZx3CRNJva0g0=;
 b=Qn0BY442xNwwgJOQ1zR9fLMep99kvqYLVOytBoLU931vJeh5RvtDc3eswxkW7sQV2P
 nTbEMhJ7pIcO91BxbxZZPlXF+YW3O/xUoyOt6Jw3SIk5wTeF9mVPL9D16ZPrYsazo+xR
 bzoYmnzNrE9HUqu3/njwvysZAT/pPVrgADhLt3GuafCnZxm8T4IY1bHiUT4pkhLSEEcJ
 cZ8txfUtvmJJP4RJ3MGzskwcWcDteHIzlIsbiGONg2TvLFv8VhZ0kkfS/loJGfNIeLEq
 +1DMDlH//KR430QPrLpnGt8cAt856zMtPqWy7nbRrynCtlWMvZknRK6IFtZ6zHdm1aXP
 b0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484914; x=1703089714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75c0ZRR1XLPLPjb6eEhvjaR1ky0np4GZx3CRNJva0g0=;
 b=OsJyHwsvenfeNdlPllhNPz28877vF867E2nuB2lptanLh7IKdcFbLDXdpFcfpZgZsO
 8kwHx1aWkK1bh6OSOdhQj1WysfIB28IL7nLLyt/UAoDz9rhcPugKiGRvXXLFSBwZARiS
 nswIEtYcYGfyj8GmouMZKHwZThaBHXdeFoZmvlfib34LN5RtPA2uXS24Eo7WK82VhBwy
 7xQDLscuUSVXcp6G6bWdWUXARprE+1kLkp/pZhyf8fu+hPOD1RttrfREFUFOJXvgD/pO
 GKenkeMCMO84G+9kXQXzNOZZubwkITc8mRRFv1JIkQQgakch48bejEMGZSgrb0LaAsI0
 a2QQ==
X-Gm-Message-State: AOJu0Yz9xZjJNBKfuTHi1CXITtWzJ4zGE5G98aYyLxDA5XZeVwOhvID+
 qKtJqtSYdOlYsHprlFRaBy6fOgysGWPK2pC+Wbk=
X-Google-Smtp-Source: AGHT+IFj5RJLQxElkFtVEbrMa6fpMKRoHdQ6rKYa4zpSDrtKP0ALo6Kc6OKskibsx/eR85YKs2JnbQ43zj5fbwGPRPg=
X-Received: by 2002:a17:90b:1055:b0:28a:f2f2:331f with SMTP id
 gq21-20020a17090b105500b0028af2f2331fmr1057511pjb.4.1702484913723; Wed, 13
 Dec 2023 08:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20231019123609.1489768-1-festevam@gmail.com>
In-Reply-To: <20231019123609.1489768-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:28:21 -0300
Message-ID: <CAOMZO5CkWeoKYCMP+qdc8o+Tgpfs+k_fdqqh-ZDfaYXDdcecjA@mail.gmail.com>
Subject: Re: [PATCH] phy: phy-imx8mq-usb: Remove .exit operation
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, aford173@gmail.com, marex@denx.de, 
 tharvey@gateworks.com, peng.fan@nxp.com, Fabio Estevam <festevam@denx.de>
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

On Thu, Oct 19, 2023 at 9:36=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Currently, when running "ums 0 mmc 2" and breaking it via
> CTRL + C, the following message is seen:
>
> u-boot=3D> ums 0 mmc 1
> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1dacc00
> CTRL+C - Operation aborted
> clk usb_phy_root_clk already disabled
>
> The USB PHY clock is disabled twice: first it gets disabled
> inside imx8mq_usb_phy_power_off(), then it is disabled again
> inside imx8mq_usb_phy_exit().
>
> Let the USB PHY clock be disabled only once inside
> imx8mq_usb_phy_power_off() by removing the .exit operation.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot-imx next, thanks.
