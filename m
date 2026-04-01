Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FFC10FCAD2
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4310583CF5;
	Thu,  2 Apr 2026 00:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O3mQBbJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A9983D8A; Thu,  2 Apr 2026 00:43:54 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF0FF839DF
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b97e6e48b24so37730966b.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083431; cv=none;
 d=google.com; s=arc-20240605;
 b=OKJaIE+dr7kEdA7fiZTNlaaN6WlD+j6blX+bAwdTeO/id4a1XMYg1AC6yKRoBTUOTe
 fhGBKrddTIlMY/J3nwmOOA45wTiTH7qtTK2VHdkcR0giJmLKFg4c9liW1McmwhZSFc0s
 ceb+hgxg7JxUM7zdtuFTLXHT1SHrMOCFqaR2OgP0JpWPpFAjTcV4kbb669CPz7cgGolp
 g3NGvXqcAmt8bZRW87ZHcvpHCFUI9q0t44gr/fifgclgow+KaKuGoh1yV2Z4YFXdbjNz
 JB9M9DZz3ofUKLesukiTLmA4f4NmwVIwpkJoeT453nqdJnieweUVSVALUSKRzhmGLJH/
 /nUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jfX0rySErWWJGW9ij5vjuK1VM06XJcKBKhNqBCfW28A=;
 fh=kbLnxDkL9kx5xB4l0NU9NlWmGCI/+0mUCnXZmWQ32JI=;
 b=Mic0Sg+UzimC84t3Fz+hffg7BiA0/DAn3UJ1pc6EbCkq+DQKaLX2/hGJZjvEFpPS1d
 LqKpclwKVmsfIBj7DkKUeiJwp9PYS2IHf6F1eD7/9ptrXrqENmGJxVv51njrRK57thQ4
 Pe9ii48awnauSdM7b3RV2OEj54IBGjTPBkhoP7AHv2Vg/6xjAqw/r5LCWb7W54KTGezt
 E1K+Nt6nZvsXwTaslPne/MoiItCQ0W9W5ymTfXrqyeZ5XWXfaZXb+ALfLj+g7wX4ZJ1W
 dtkpRHCnnTEkoi1K04E3XMt2J+X6npBnCr9YPoKPJcKxmYbgG+hDp3YuaIWfhJwZxg0w
 Qcrw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775083431; x=1775688231; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jfX0rySErWWJGW9ij5vjuK1VM06XJcKBKhNqBCfW28A=;
 b=O3mQBbJQ9sR2jupcW6ON4uSAzHhzIRrsMOecmiNCfLZPFkWa1hUvW6GMeQMktvLFVi
 FgO5spcsYrcZXxFv/e3IiYjuf5Mnp8M3bxV/mandMQ/i2G5rF0Ei09IB5PUyF6ofZcLS
 1lZbA0K+OyEZLQyT20I7hrFKXNIAiUpOD7GQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775083431; x=1775688231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfX0rySErWWJGW9ij5vjuK1VM06XJcKBKhNqBCfW28A=;
 b=EV3pdaqxBwTAV6y7H5/Tomdv0+U0oRXCyhTDQT/iw5o4j2gYLERiElTyo3wDg1cLYU
 WtxUNwUbnwg7mSoic7lkg3CXC5kBhVovr12S6MG59szezehbZNskxxO9X9sXBZgkqhg7
 dRLIGdQayDd5j0vIi/lX7YYKSFX7V/+M34zGu0XUOXJevKvKvnsJJpFJm9PpbXppdqQd
 SJatnEZ53JgM3oEQZP56jKNv/SWbiWChqjSv9OpemLVZsNGrnBMjn/mW+nWiCo9315NG
 0D//oYa2tQbFMzbdsz1epSBgwpDoMj0iBrChWQWmd6lfyuyILTRehk7/n6x6lH8TaZG+
 nUhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpuZudU7KlIUrp4cJ0r6gwaU2KxhbJqsjnEMGqTR4fFFTMJsiWESZHvJvIW50PtTs+d1UO7aY=@lists.denx.de
X-Gm-Message-State: AOJu0YzGVG5fI2cB1NrQv14Chdet6KnqCBF6+A5AwWPdy4b5QpDDVXie
 hDObvHKzNaevyLlsloInwBz3o/vk13FailCVOA49LY+o3LtWmxpwSPK/y5Hx8cU7x371rGQAeqc
 JCJMIY1DadKBCBv4EVxrBPd5j4b+yGr2oFHYmpf//
X-Gm-Gg: ATEYQzynCzV+MRVq55iAfKg2JXxY///qc8+CdLCYKfC3vQqm2qQzv1w9Zodf4a5mcLb
 sEOU8RLFt+YyKhmVayhTCOgntCytE3KMUoPfYe3TcpSHjAp6LfrAXF6lcAfvQz1+NogCwdZ3qQ8
 1WJ89GyNk+P9yGYlPqByht8pHHNBPr1cldZeQSiys/Esq7A90gcRpzLq83JC+9F4UREgbP2nlCr
 pvmDI0P+9ps8Hj5Si0ib9tmDLBymZO0rvpo5pUfJP8tqX6kS2bFutyIp2xCqy4NVz1szGrYgPFx
 rQOutg==
X-Received: by 2002:a17:907:c789:b0:b97:d126:c007 with SMTP id
 a640c23a62f3a-b9c13b2c4a6mr344637766b.30.1775083431337; Wed, 01 Apr 2026
 15:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-12-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-12-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:43:38 -0400
X-Gm-Features: AQROBzDb6sk8zAEEn9VR7xoJsMnChu5sJyrdDBUWEnmlZw_-Z5Nq8QARPMh7PuU
Message-ID: <CAFLszTjokOBA+NB5zHLURq3jg5ZPLmgMro7CcYE5OBiru2h0Dg@mail.gmail.com>
Subject: Re: [v3,11/15] tools: binman: pre-load: add test for ecdsa
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> diff --git a/tools/binman/test/351_pre_load_ecdsa.dts b/tools/binman/test/351_pre_load_ecdsa.dts
> new file mode 100644
> @@ -0,0 +1,22 @@

This patch adds test data files that are referenced by the test code
in patch 10.

Please can you squash this patch into patch 10 or move the test data
files to patch 10? It's fine to add new functionality and its tests in
the same commit.

Regards,
Simon
