Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CB4CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 12:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B084083A79;
	Tue, 11 Nov 2025 13:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="axOYQbSX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CA983A91; Tue, 11 Nov 2025 13:20:33 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE2FA83968
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-594285c6509so4527158e87.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 04:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762863631; x=1763468431; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0+rSepM3PFG+vxOGyAu+EbD+k4OHe34bS9f1D0nIa0=;
 b=axOYQbSX0EqIswkTVqYKP+jzPUpnudWtIq3oLM1Exore5DK+fA1uOJ0sgu0pIB+1sF
 7Rk9wxznxgDtey00rVEX1a23Mb0pcYVxhEBxiCsmrWLHcK1INvZJa+O6Yerpmh2EkGhK
 Q1vjGcPKAztkhVvDbD+5n7pgAfzP2ByFhSecS+TopLo/mlvmS2L2II1Eg3JG769FId95
 Mk7+EtZjgrLYLHDkd3a5hJ0UMafCpcKWXf/nXm0a5EbXuQFt5+e3wMAHt7RDZB8yHqQw
 RQdjL6IGide9JO0bf6zMLptL7bWWJk1RwASGpsDC324OH6eWv3WMYWxLoI1JZdTIma9U
 d6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762863631; x=1763468431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s0+rSepM3PFG+vxOGyAu+EbD+k4OHe34bS9f1D0nIa0=;
 b=LASTOo5x8tBwQTcjxlIwD0A0PIoSHpOwyYMoYg6M+zFskkiZgL022TdHmcTOhUAxn8
 0g6VrtpK7b4NhwXLlvWl14qxfNa3gY3i21Piyplbsjy9PMOFHe1Dh8oCOZKHE7v3Zrt1
 WGfu/XIi6xz9rBy/KC7EfMWY5+QapXu0g64PCP2VgcySegsLk/oiNZ6OWblA/KvcPxJD
 eBs4P8kZtZVSBMNGANZX/fdLLqlSygh6IWZZdVe7xdt7gWi6WJ2bNCG/0I+wEGluy8T9
 drJDrlap5OftHn4X3Ybkb7dHfd6uG9W8cHjv6HnuCVgPh0RoT4iLCf98VcRpj9LunAI4
 1mjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUhED8oYw95DUAglg/B5+CfulXBMhHkA2UhFwRrcr63YoED3txltyuErOrQ21TW8rCKq14yXg=@lists.denx.de
X-Gm-Message-State: AOJu0YzHFn+CYekkq2XltcSW8Fn8VN+2KUPvUWwaNiZHYduD090KfEmU
 6RL5WErO2l5HJUoyTqYQ5lp0DXg0ONfQFeqo9hFMn9rTAu78N3TRK3SvHk75n4n8Eo6BVMceey1
 JPks1F0UT/RE6igTWRLrynFj46TIgPyw=
X-Gm-Gg: ASbGncviVNlJp1PXlLRzq4PH/U4vDZaEOgoGUH19aEWu5Q3QGw1iB7rTf+YoQemidqz
 4FEqPPzIZq/rHWflyt3dSIQcRf99KyspSa08JoolX+NdwbtWwDsuoGsuj7js0a+A9bnxNunCjCz
 mn+QGL5lvdXt02wyjNzqFNCqdqTNM1okCy3cvWhUWLF+k819eZjBaJGVJYpmMvYD+VoGL02mL6F
 bcj6VnkE4OaWyg33H2wCc73guzxEYUEv5MZqZnsAcAMF/PhRMUJHGduiYws4oaE/mfOUTi7xw51
 ue04O1GNINJKmzHqvkWlUzPLySU=
X-Google-Smtp-Source: AGHT+IHWqQJqo9S0OCOrflCZS4wUJSS32CCnPXe+vUINxPa+7NjyRgV6EN2qmXkuUoOWI/iwGqokG/PzEfgrt8vVUoI=
X-Received: by 2002:a05:6512:b05:b0:594:4ff1:52bd with SMTP id
 2adb3069b0e04-5945f145fb8mr4266199e87.6.1762863630696; Tue, 11 Nov 2025
 04:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20251111102904.157931-1-frieder@fris.de>
 <20251111102904.157931-3-frieder@fris.de>
In-Reply-To: <20251111102904.157931-3-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 11 Nov 2025 09:20:19 -0300
X-Gm-Features: AWmQ_bkAG4oL5uDVrrKwbyZU_Sign4qDbOWiNbRj3rEuEP8t6CJYXHbdXbFhRSM
Message-ID: <CAOMZO5Do9AdqZ+j4Kpp8qU21mQ6yBNuvi614n_Q4-Uzebf16eg@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: imx8mp-kontron: Fix USB OTG role switching
To: Frieder Schrempf <frieder@fris.de>, Tom Rini <trini@konsulko.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Shawn Guo <shawnguo@kernel.org>
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

Hi Frieder,

On Tue, Nov 11, 2025 at 7:31=E2=80=AFAM Frieder Schrempf <frieder@fris.de> =
wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> The VBUS supply regulator is currently assigned to the PHY node.
> This causes the VBUS to be always on, even when the controller
> needs to be switched to peripheral mode.
>
> Fix the OTG role switching by adding a connector node and moving
> the VBUS supply regulator to that node. This way the VBUS gets
> correctly switched according to the current role.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>

Is this an upstream kernel commit? If so, please mention the commit ID.

Tom,

Should we patch dts/upstream/src or modify the -u-boot.dtsi until the
fix lands upstream?
