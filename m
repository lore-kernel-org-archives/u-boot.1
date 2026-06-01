Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF61CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 21:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E25D8493A;
	Mon,  1 Jun 2026 23:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZmUcNBYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E32F084958; Mon,  1 Jun 2026 23:16:38 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B57984932
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 23:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bed2195323cso225839466b.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 14:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780348596; cv=none;
 d=google.com; s=arc-20240605;
 b=fW2s8ra0T0BK+QGvNg4MHG9NUgfTJn6uMDNle0VJvzZad7k5oJkvPnbHxVIN0q+RBB
 VoZPAeoEYoOPU1nUzRyLohwyNtbLCz2OpJyliB42LXx9dQQxN+0Rb1ZaFvkjaAgaCYie
 ZBgh00TtJ3dSdGeYwau2/e623sFp7f+Rdtf41rJmfVyAU5hj/S6jZ4CdIYk1rjBqg0Qq
 XmLHAnUlmFm/LtBuyshKfcLYRLd2EZ6dA3Zm9qmeDVFW7NRMqt9CYUOvJ7u84XgnXQYV
 VcSBVZ+6Url6bk+1q3zHGB88WIh/U9LNzd34bQefs7VHxs2LnxUkXcdJ/o3TrljqwytB
 orGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OBbsQ/CfvEmb4ux2twBJDdm2FJIcEEGrX72VTO0ztIc=;
 fh=sx+F5wj53PUJLPt1PaRFipAlAw/0h8Q6muOuQlO539g=;
 b=VwKRGjqasZu3bGn1Fm9PxnFua5qNwME0MgL7ahjFbxxofojMWOvNwx0xe4yjRxnVJO
 RsIGzd3CVoRkE+y/yNLiL9WxExTv1BWm1SQBhlb930IfTKF8vPb0J9CbWuBTeJR/8YA4
 maWbkgAQKp270t2rQ5n5d2v4lsnlBFglRTOFHMyosC+QyZHn1x2lb32j9ehfrGV3T9bM
 +dWIihmnbTuOphUWk21Syq9flBFRl8TSZvaiiAGls3Z/NEgTN6ix/s6TU/msh7ZOF4xD
 QauPBWvtx0KN0UcSQ9DMQU2xcU6SYcqt19beYNKNIxTe3FYfcGVB/eup9Rerfecrb7+k
 CdNg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780348596; x=1780953396; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OBbsQ/CfvEmb4ux2twBJDdm2FJIcEEGrX72VTO0ztIc=;
 b=ZmUcNBYiKxLYmXrq6GkyCKTSWcvlgvIGYejwNCQl9GWIk4JqFJVM5sBLNYcUpbyDfP
 KnR5Vpi6z3AdjygSA3XaenyzzBHEUhxFA3fsvR8GAEQrGhLhWkFyjnkWMGkQ02cJxlAv
 6dlc+0TShkN98w6I8tRo7ONvqFO1XqH49UTRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348596; x=1780953396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBbsQ/CfvEmb4ux2twBJDdm2FJIcEEGrX72VTO0ztIc=;
 b=sgbbREveCUZ+sqU4awixeG+sqjTPKn8da+pmrhus0FEMRfrZlEk1AOUMh3jcsrqCzL
 fG0C9sv/3DeKqHkbloSNew7YJitRmUTu2Rgr/MQM2H9agK7Xyf/QqxP9Cp0wSOTR7c1T
 AV6cwW3OwDrKg2rma7uShep3PizmHB+Nv0JGzjUBbo3F3ynOdpHrtDbikaqiu7IvkwLr
 B09hW4IxvEWn7rJ2yLmE4wzw1YItnuNKxHl7FaHfTLZUf2vRc5iUy9iHS5paFRBXbHEv
 vGwxtRlOVs2YToSCdbvqCZCdATdMUheOf55WaZty23/aIbjWVs5LP0I0a/7JpqYHOx2D
 1aPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+m0renDE/U40kk2aFroqaXpIaZ0sABU85VPS0oqJduC01A3IbuYEvmMkR0gIYgkDtZotkP1z4=@lists.denx.de
X-Gm-Message-State: AOJu0YxDlzeBozjU6yi/z3qjFDJ6gXMEgnWhy5aqHJm/E00uf+pORZwY
 snn6RZRPAS42oyrDZHcGbd5VT95o0BRMUKDI1EK2BJWUkgUD6pDdEnPtQ1esD2WHdxD/2iYKrdX
 DZcPxzG2jUVvupox1ayse+DblnzgzU5mRVWhPYPNe
X-Gm-Gg: Acq92OFy/0U8FEsYyZck6DNvNYYO1ugRmq9GHO8JrtR1ICFA2lwso0Ru33ijxinXeEl
 4agIK0Kkr0M6bBdTBGHJLojqJ5uPHd9ZRUrvFiE/46PaHgE2rnHNLCuFyEpeuvam/lUMSlqq2dH
 Csf7F8i7GRxmoo6Hbna1QJaxHsu3b5/029izzx32Sd/cvNOHYiOBArTTU1IScSVR48PzscNhYsx
 O5siNuM+TSYbfcD/FriulQ9aGoKnUU6qnoRb/5vkV7T8j60pxDMq5fM5djVUYLoHsO0o2mizgsv
 jnzsPim+wD/4jnZI
X-Received: by 2002:a17:907:3c91:b0:bef:36f3:7263 with SMTP id
 a640c23a62f3a-bef36f38531mr20944466b.17.1780348596520; Mon, 01 Jun 2026
 14:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
 <20260527095123.50797-8-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260527095123.50797-8-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 15:16:17 -0600
X-Gm-Features: AVHnY4LC6god7_kn2mn680DqXsM20GVkkGj_J7MXyFMD6h1QrvSI1oxdIBNfMTo
Message-ID: <CAFLszTik70T1g-cWF+yDhvPVwN6SkGw+MyqMw3NJCLyY+79qEA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] boards: tqma7: call tq-sysinfo setup
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-27T09:51:17, Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
> boards: tqma7: call tq-sysinfo setup
>
> Probe TQ sysinfo drivers to print device info from eeprom during boot.
>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> board/tq/tqma7/tqma7.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
