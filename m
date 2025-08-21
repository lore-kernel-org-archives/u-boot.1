Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB5ECA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 22:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEDDC80422;
	Fri, 22 Aug 2025 00:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C9yUlSQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F71A80548; Fri, 22 Aug 2025 00:42:38 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 192AC8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 00:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-618b62dba1aso2078272a12.2
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755816155; x=1756420955; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MzlQuEMNz25NX1rrDdA9hFqqRhU0tMtMNKkQhHzINIg=;
 b=C9yUlSQ9w/vGi5EwX+aL+/ERBqwqYPWgCDs9pSoGCx3GFMt9IOUacb+6Uq49NAOwKo
 S553wn/G0Itn5iH7KBZV/n8wwCo0JeUJhtLxDum/HuTMV66bdvwwvMoZaQVbKew/mDCe
 r2Czd8j82/ChwmP62QRJW/Pb4BQK8DgEzR236THV2Cz3dsQTPyRijd13Vg5UsC5sU2EE
 6INNzg346t58nX9FYdNIdrkfECc7MXYlaLYdDQ+I5/SzDa85BDB2wkOjtRxB7EIcfhBU
 HgE+ElTEOTnvwx2bbGL/NCINyQvQnLnMcf1RsdA+gc14gN5enBOX8U01dQruc4crN6Cb
 UBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755816155; x=1756420955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MzlQuEMNz25NX1rrDdA9hFqqRhU0tMtMNKkQhHzINIg=;
 b=YZbqzqDtGlxlU5wckCk69ONzpWMys87w0Odvpo8cmvpnzrYh4W1BQdRR/1n0oFHaIk
 hOgOPb2u8dSuPVgCo6MwfTNevr3J8GtMxHxdRBW0Jp0iU4bp2beaX7UmJ22c3LhAjgze
 QhGx8cXWYN1+gtl9uzfBTzkYrO4FHJ4/nJbssl8PUttktCEUUqMmLDFksvITREsVUqWf
 7D9/IfJoPOyy1jTTcgBR5QgkSeUUN6qQwjRAtSRtdE2b7kmon7mv8PZnsdKSHUx3TbEL
 ZIO333AGsaHF6j0GNHAKjrEcP4cZBX1G7o6Uqm0vR0D4nZWEMPEvmj7FU8A6bBwL0H2Z
 LwsQ==
X-Gm-Message-State: AOJu0Yy9kx/16cFMBLjDAqnpR4Gok1jKJ4qfBiqUrgv5Hh7nwY0vsTlH
 mpDc0uaWdM8YqEwthljsa49q3LpMj3msZcMy7POdYrtbG6Gk4vTiqqGaGv7mErGB3k1//4RS/YE
 dsclUbFUc0MiKVvM0onLjnRXkmZLu2m9P5Mg4Rzc=
X-Gm-Gg: ASbGncuP0jRx+bC64wKoAdI2ClTki14PYm8BsZJxufPMtpERTRpOGApdeq1CnBFSxeL
 OzHZs0zSRS9K3MagHFhiHO4dz3N5uuKnL8ZvkHGCK1p2+nPIsry7uVV+8EIVlA/kmM0/WKFQhtR
 NtFjnJwCyxJ76bJGk+tZPM3YZSy6dR7o9PSskRdk+0h9PXP6hvWMPA8kjlT++OxOE7Qiiap2vjh
 x1vDcohjK2wHpj4WubeG+W6e2sSIfZDrPEqWNO2
X-Google-Smtp-Source: AGHT+IGP0VK7/Z1U8bfeTHFUD76Am4vNv9vViaVKCHMEChGB17Iih4ksr9nXXZFTjzS+81HOXeOYR2FCY6eqwjXJEu4=
X-Received: by 2002:a05:6402:40c4:b0:61a:3236:22b5 with SMTP id
 4fb4d7f45d1cf-61c1b708cc9mr571866a12.25.1755816155278; Thu, 21 Aug 2025
 15:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <03b60737-2289-48c2-b4c7-63c768ca4149@gmx.de>
In-Reply-To: <03b60737-2289-48c2-b4c7-63c768ca4149@gmx.de>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Thu, 21 Aug 2025 23:42:24 +0100
X-Gm-Features: Ac12FXyMfhfFDMHBmF8-SXgnz3k4cS4fBIJuyo3XKlzZzlIJTo4S9_gHPl2_jmw
Message-ID: <CACAHuLBGed=O00UrQ788iJTJk37+6Y+Bh-Nqo2u4Sat1S4GaQA@mail.gmail.com>
Subject: Re: [PATCH 00/10] doc: minor fixes and improvements
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
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

> [...]

Thank you for the heads-up.

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
