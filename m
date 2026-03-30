Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798441061B18
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7EFD83EB3;
	Tue, 31 Mar 2026 01:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b7MFaX3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B239A84035; Tue, 31 Mar 2026 01:00:14 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D918352B
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4645dde00a7so4434591b6e.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911610; x=1775516410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8Ck60q9Z0oTYtQrpKMC1AdOb1O58oXkmd/cGVpjtnUw=;
 b=b7MFaX3uJv6IkN1vx20H/phJeUDG/n+LZuU3rYmk4dwUIfYUkXgJpmmGCqARnS3LhT
 07m0Wy8KazKb+len8Ze7Omq6lHZwsQgOEzTPCfNOwDpTZYN8ENWXO7KAlYlDfqfGQgPE
 Vmjk6He5MM22TWxhUDmOCT8L+wXceLEDIZCRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911610; x=1775516410;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8Ck60q9Z0oTYtQrpKMC1AdOb1O58oXkmd/cGVpjtnUw=;
 b=szL9i+pbhtD55ouFuq9LTH730zmevLMRGezB/Ex4hi9uoWTIS8B3VbOUIWJser+dgU
 eMpbq/SSdXmzJoeTefIGYQzTZcLeGaQgcw2bn86bsY2/za3zNlWEC7y0eZthdkyXjpPe
 7yol/EiAz3AxJfBzpzTvRmcHr+X8HCDV/9iLzMmpJF5pqkDpGpCVsrAJh6jiJTT2cuN9
 m8rdyrE018Chz/zc8LULa1ADnanuAUWkiJCiypNsvRslidQqKBzqG3Wykv6xb9Z/X5Mx
 waFuGFkH6auIBtrzB4chl1ecRA3aX719vTeVmvdHqtxu19BxW7gAkWh45Niz9XWA0TYw
 28bw==
X-Gm-Message-State: AOJu0YzYdwbfH/oFJ7oLn1ywXenKf6No1gcKTItIp4/sjecnSXgJp2E2
 mDrOhPPfHgz99g4O7lj5t+7wIMjMBgrl9vmCjZaZop4vtkW1ybgjLLProSGdBQlIk5Sl7gmkUUx
 P6cz67oI=
X-Gm-Gg: ATEYQzw+RKbvApPuuVB42zG2ZsJSvI12wCo6IWOdLASCIQk+P3M53LTgAdfSyEB/C0q
 S8p4Y2z5PO8LbfYOGfmWpWD6jhWLrJtripUgaXUbhJ5PESUXwzMxO+Y50DEWvX/GiCM/ml2C9Yw
 AobCelgIGoNmrVxWesv0IOqX81ems6xhmFDmXAYAB4Z4f3OAJ+kS5EFbEMGXOgCdBUR7eehCwR7
 SY1TF2aZDfC2FzKLcvdpFRcbybazv+aq2qHW9eGYQxp4x5ayRocgzN+M9mx67YIl1FqHP9rIza1
 jfpH1g2DqVjejVXAyY64JUEiliUK5aXdV8Oni0FxS1h30jdfExrO5YJs4Bfn5w2vY9oV0NDJAzF
 QLBQmwNGqYpIFNx5URYWevV+xupsdH523ENCuKXr9eDBTXAcQfmmBV5koCSpwIYKXZo5H8tGdcC
 cGvS/SwgRY9boXEsUBEbHxCQohd8yvx7NqbKxUCQRmwpmCLjm3FUU84U1zyG/njyjq334aZr5X0
 DztblEAMcmZx2iJBqJYBLOY1zzZmQNtb+DjecjZr12Z6+E=
X-Received: by 2002:a05:6808:5390:b0:463:a42c:503a with SMTP id
 5614622812f47-46acdc021f0mr811438b6e.14.1774911609684; 
 Mon, 30 Mar 2026 16:00:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260317012421.4162392-1-trini@konsulko.com>
References: <20260317012421.4162392-1-trini@konsulko.com>
Subject: Re: [PATCH] xPL FIT: Rework SPL_FIT dependencies
Message-Id: <177491160863.1028292.1128149529265499100.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 16 Mar 2026 19:24:21 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have xPL_FIT select'ing
> xPL_OF_CONTROL, and that in turn requires xPL_LIBGENERIC_SUPPORT. The
> most reasonable solution here is to have xPL_FIT select
> xPL_LIBGENERIC_SUPPORT.
> 
> 

Applied to u-boot/next, thanks!

[1/1] xPL FIT: Rework SPL_FIT dependencies
      commit: aa8203f83ab500c1150188d9682e9fe6e29fd6ab
-- 
Tom


