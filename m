Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A57AC38150
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 20:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4691882E2;
	Sat,  6 Jul 2024 22:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZKwof6LY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D74C882EF; Sat,  6 Jul 2024 22:47:59 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE16881AD
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 22:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52ea5185ba7so250895e87.3
 for <u-boot@lists.denx.de>; Sat, 06 Jul 2024 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720298877; x=1720903677; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/54uw++Kzb6rOKKsibjmEXEFT/XPytKX1rlQUvCtGM=;
 b=ZKwof6LYzdJKRtleW7WmX62CeD3RI0POewuqHtdSJSotJwsoCWAkHwqrtvTcZC/bGw
 RiNM2+tUWDnmyBzEpgUC8dr4muPxNSN22It+pPQGc80v0P8JoLWfmMCWihk18jSkJ0Fl
 2OZtyCrJkIi+F3WPBPDlmlkkcp9TDfXB2xRI6Uj011tsUcjxd5Ug1JZrBYOBmmJTfmWc
 0oN61463nGa1xst1UWLZqXPAkW4UvDtC+OQBcM10YhO58gJge9QKtBem2IRPi/iQ8fGS
 CkCfMazoWk25qLKZxUQ8qHOxC/fCl6uv8nQKh3GZYrTdRPZPklWGw5jPrLTkScg/Rmzi
 GapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720298877; x=1720903677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/54uw++Kzb6rOKKsibjmEXEFT/XPytKX1rlQUvCtGM=;
 b=nha5YqDHq/h6dwy9YPWRxwMW+0w3THoew3QjEfSkTlzyctcm7v84htFn1Bzt0j3EL0
 KE83Xb/Cb2ih3n9Vzcweb/z9dPQajBopalwXt1sC8RKeur7a8tRv0FpSAP5oUfcyyPh6
 yMNLx+PqDBuyyvr+6erzDcMILuMFp63BU7mTBFBRTXSIkjiftHIfFjMJVyvzAK2wMP4j
 AzCDN7AcMWWQDrY0ysf7g9qsi6DWE6J1ipu0FVLCeVU02Dby1FxjmY6sEmb7148fXGHp
 4FKksVb2/r4ceD4JE/q6BIyM2iFDWpv9FgbJyT1Mpb1C3+MA2uVQZDnYNIVU9xf4+1Q+
 Ec9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa3AGYtSe43otTNAcfX7Ztxr8EWiUmF+aLm/pr6OszBC63fvBZPjqpesu+hZTrLUGrFSVGyg9YluXdLfIJ1HuPvmrnDQ==
X-Gm-Message-State: AOJu0YyrW3iVDLGseiBo/2iY/Ylnzp1E3bRWmA8ayz+mYDkZ1XoSQTl0
 hIqB0W8b+/pdA7ClPtfb3vPdjFaDiHzVE6lSKkUdWK8nRMDRWS/ef07Ms4RjcvT9OC4KhvgLo/B
 LEoOkvnjdW6DdAb8Tpwh0RjnqiA8=
X-Google-Smtp-Source: AGHT+IHns67k3JivVe9MG5xsaBT0nQnUDbTNBRvSsWyp0fuKk45Ll+dKg86d5biwB0rEun+5aZcXVd9tNLLBnBdJVFA=
X-Received: by 2002:ac2:5051:0:b0:52c:dd58:1a97 with SMTP id
 2adb3069b0e04-52ea0762b99mr5565609e87.5.1720298876439; Sat, 06 Jul 2024
 13:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240705121121.3829244-1-l.anderweit@phytec.de>
In-Reply-To: <20240705121121.3829244-1-l.anderweit@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Jul 2024 17:47:45 -0300
Message-ID: <CAOMZO5B1inxUinDgabX+DJ3uF=wRohiU9z-utqM9LeAcvQXR5Q@mail.gmail.com>
Subject: Re: [PATCH] configs: phycore-imx8mp_defconfig: Initialize caam
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Fri, Jul 5, 2024 at 9:11=E2=80=AFAM Leonard Anderweit <l.anderweit@phyte=
c.de> wrote:
>
> Initialize the Cryptographic Accelerator and Assurance Module.
>
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>

Applied, thanks.
