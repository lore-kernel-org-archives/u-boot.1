Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE8BC87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 12:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C8E0846F0;
	Fri,  8 Aug 2025 14:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KUIq1/o7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 254928471D; Fri,  8 Aug 2025 14:58:43 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F893846E9
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-55b978c61acso2022977e87.2
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754657920; x=1755262720; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AaEb5rRaEnUxyrd2mm1N6/1ozy1yi0sLKiDNsP+z1O0=;
 b=KUIq1/o712UCnVnIhWz+IFr8RfofhL0ppOWM9p2JZ77HLK3FxNhKS42XhpEpu+mGJ+
 fuTFAfYRvbX4cTi0JXNTB18k3tGWQw+lpUzrCQjE77O5p0aFUElq6AJl1Ls+0yudCtW1
 1HbyX82Ejemurb77RY/lDH6tv75cO4n8HTk8gDl1OvVaT/DX7MpZQ/7M0uGIFzIh6D0m
 akB/MVQmiKFX45/WvnQilf6LCvqbne0uaBN60J/ip/jF33u4IdZn4oskRxXldeZffgVR
 kqH+juz3RUwSo+N881pAQUEDbyjE+WIy8nXN+3BDySEsRzmqIAKUYrmPCgpsb+ALo/XP
 FKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754657920; x=1755262720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AaEb5rRaEnUxyrd2mm1N6/1ozy1yi0sLKiDNsP+z1O0=;
 b=q0Bbjfa0ipRCqkK9XJKoEOrhjBUm1L2IwRmZ5QRz4wiQmFazwChSHnHl506bUHWSku
 BU7CASP1gN9MMiqmjDaypNY/JJGbsn1GdoC0VRhNBvVf+nAWViGnZ6uJe7LtPsEnGkYZ
 rknYPftxErZ3mFl2KIa637tjyNuwhFkepiOv5QoWGJKLiLrok6z2I7jA/WgoqS7noM61
 PznBOaheiE4Tg/8u3RNn5u0XmX7tjvc8QdEmUiO1twQoWQzA5TMFamn3h1SNXmC906RF
 lOFjAmtNgPXKHNKG6n3m+yGkv6Kw9o6XbzPam/yS0BH+1UrGYrrpcQMmc0h1gh+5xFfM
 /cow==
X-Gm-Message-State: AOJu0Yz98RDdNo4U8Xqj1mICQhXJ7IWWvo3WcebUtjt/kIOQ/hxo/k2e
 B/EldQ1T3q5IJSnKLw8evl2syM2tFZdaMv4j9uolWRE7luswMwRCNqSvWGejycyh3+dXdNU3Ne0
 o3r6McHbZoc1PBPjVOO7GqGwbZPvKxAo=
X-Gm-Gg: ASbGncukWMZy2Kr4k2cuLhswa/PJUL9TiHawXJsWxNVgottsEfyg1s9Px8C2agkQqDH
 Ma5e0f5FlYQIUc065yecqm/s0FaAs2OH1BH97dofzbYeADPUjIdtrcoq1rkVpGH2sbwlKUOjA8O
 mijGufvSt37J57ibXiBTDVM1CKBtlKaX9X3aFQZ1Isdkj1pR+hmpv05m4rUQ9+CpiKjKYIuTHII
 kDgPr4r5H1s9gtJvw5i4+hlRqIXyf1hnKj4YA==
X-Google-Smtp-Source: AGHT+IFEpsVSbmL61wXJ/SBoJSim5cTU0/osFwbi5mKc6Y2aIcF3d1wCVrFdq7gzg6eHxEoialLTpGWlP/A0zcBLSog=
X-Received: by 2002:ac2:4c48:0:b0:55b:9796:5d6c with SMTP id
 2adb3069b0e04-55cc0149ea1mr660143e87.39.1754657920318; Fri, 08 Aug 2025
 05:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250724002517.948571-1-davidzangcs@gmail.com>
In-Reply-To: <20250724002517.948571-1-davidzangcs@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Aug 2025 09:58:28 -0300
X-Gm-Features: Ac12FXzyA8gXltENd4mqH7tyq-bCutbJUTJfVW8N40AxL0fGyj34OfZq07yLa0U
Message-ID: <CAOMZO5BAozW_ukvESAeBJLBWdk9qkbGxofz0nJMDcTnUt-N3LQ@mail.gmail.com>
Subject: Re: [PATCH] configs:imx8ulp: Enable temperature command
To: David Zang <davidzangcs@gmail.com>
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com
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

On Thu, Jul 24, 2025 at 3:05=E2=80=AFAM David Zang <davidzangcs@gmail.com> =
wrote:
>
> User can display temperature in the console runtime on i.MX8ULP board.
>
> Signed-off-by: David Zang <davidzangcs@gmail.com>

I changed the Subject to "imx8ul_evk: Enable temperature command" and
applied, thanks.
