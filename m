Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC01CF2591
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E63E83F6E;
	Wed, 19 Nov 2025 14:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dWExExR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F2983F72; Wed, 19 Nov 2025 14:17:53 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE2083EFC
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5958187fa55so5034105e87.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763558270; x=1764163070; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=trR4yL6a7p3EIHIw4UhVL8M8R4d9FQwggmWMi6g934A=;
 b=dWExExR5XOqi6jYPckqZTmRASgoM/7T/s4iVn2X9rdNXYF9qq0HkiCJgME80NxyJtq
 EiDRGxy10EAuZsd3B+2NXDGnh1kchZSnB1IOBPjDDz4/HabZ3EkZK6PFXJMXWazRTAz/
 NJ1lErkPIBc/T3l+6ISeYjFkmsZLfWtmEYO2l8i3/zTVRuDi3mWwDh/O35/6LzT8qyeT
 TMubAr2uiyyiMrUlhlnwIRleEXu6NJOD6/GveO+JBIWZ74I7YuSPlHdvBD5/nbujE49N
 brTl913drzdPCGnmqsqtgjVoGNi27wxDNKDd2Do/Tbt/49l8dDPxie2Acxbcb5C6Zx3L
 X7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763558270; x=1764163070;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=trR4yL6a7p3EIHIw4UhVL8M8R4d9FQwggmWMi6g934A=;
 b=bIhaJfz/bixcDhZ2opQ9F3q/zYd39RCy5Na6qS3bzfMbWdisv+lBQt1w1sgCr3Ioix
 lY0a18LY1MWebLUbhaYKGZJ9klE9+3Hf0/L4fChT5B8v5wkDrR9vBKrgrIG+HyuBrRN+
 APrsh7TYqLIQp7eZJfqc9uN93FaWdT+xuuq9v3Ji4+E1E0qT+52852L6ph4cHxIeP5Wg
 8uI4wRWyUmGq+GM1NeAS1KzQN+vGgyW11SFOlNBRQXGsqFZhZhC6N2vi49OgZqFT+vVB
 SQS3y+JI7Mqsf7XknW0fvPx2d8VRXvheB2lHZtBuvWHcLcDTZVcokhApmiOJcCQlT0m8
 UV7g==
X-Gm-Message-State: AOJu0Yyd0h8otJKvfK2N3yWkyfbCWKz6wK/NrEjRyBZQ50cUnafwKmfB
 mEXdaikWgeQHFeFZ8ZKDhs/DMavFuF5C4R8+9NbUaXQXhzGOyo7KuEe9qevd9T75fkXaPay3QEI
 K4u1N7u3NqmymABEMfz5Mpnd32S7j1Sc=
X-Gm-Gg: ASbGncugYtoa78V8NW+3UdE/Q3/tpLAbfqxVnPF/SGx3isQr9ouT/2iErVAGPSK3kjk
 /txpLWXejrJLAU/V3L/PKpzqGlWPqAZuYH8RqOMEc2RpBMruTi1VA/wMcc6M/7qrD0DXQ69RHo+
 lNVBRjB1q5PyOEw9+vmZ5qM6l3veAByFMBylc+/9YtIJlEUuElUbth8m00Zq/3UyLcdo3Jeh1UK
 goXQGb8/3TujLtf4NuPB871jvfTh0go0z9xFQ7dm+mh/tkCEWhBNpYkn05jw/eXJ0tK5lboZAan
 zSioKv22Wj6aucJDKNwMAYihJYY=
X-Google-Smtp-Source: AGHT+IHPjuT77a6dZau8XTlNT8Yp8OGOlkNc0ov3Fa1+MQgnqlMHG9to2M94MqGe+m4T9Co5/aHtQjn9r+DX3yY5lTk=
X-Received: by 2002:a05:6512:10cc:b0:55f:4f1f:93fa with SMTP id
 2adb3069b0e04-5958420fcaemr7016867e87.42.1763558269894; Wed, 19 Nov 2025
 05:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20251119035914.1165505-1-alice.guo@oss.nxp.com>
In-Reply-To: <20251119035914.1165505-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Nov 2025 10:17:37 -0300
X-Gm-Features: AWmQ_bkdoLNaOYQHuTtfjYabMbCyqRgX0CJsbBOaFiPvukfGvEFGhBrmHrqAg9E
Message-ID: <CAOMZO5A0ssJg4XXKwJKN4sHLUnHGykqcnEVp3E-UF9_7mrqNkQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm: dts: imx8ulp: Update device tree to fix boot
 issue on i.MX8ULP EVK
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com, 
 trini@konsulko.com, alice.guo@nxp.com, peng.fan@nxp.com, lukma@denx.de
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

Hi Alice,

On Wed, Nov 19, 2025 at 1:00=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> mu@27020000 is required for communication with ELE firmware, and
> lpuart5 is the standard output device. Both peripherals must be
> available before U-Boot relocation. Use bootph-all instead of
> bootph-pre-ram so these nodes are retained across all boot phases.

This is much better, thanks.

> The driver model for watchdog timer is not enabled yet, so disable wdog3
> temporarily.

This change should be in a separate patch.
