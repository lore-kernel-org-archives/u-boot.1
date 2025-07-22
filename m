Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C5BC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 16:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 037388340A;
	Tue, 22 Jul 2025 18:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZH+xxvzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB755833D7; Tue, 22 Jul 2025 18:08:36 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7754A833D7
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 18:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73e57751cd9so1730007a34.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753200513; x=1753805313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cj4UxNlaH2emG81WDJjVJvM6R24YoIro7ar9V2TzCGA=;
 b=ZH+xxvztg+jNm3+cl8ptyNNdh6u2IcqWfWg1rPRD3aCtqYi5MWb/l7GvjN5Qwr8rX2
 xku2+1hURkaJHlcOtIuKz35/aXR49CeI7ucqnVQ5iL/bfdxB0HSaGYU6Oy8z4O/0I5zi
 Fl7oCe1V7+biCh9hn06ioS2lO4+MFOlHq3zuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753200513; x=1753805313;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cj4UxNlaH2emG81WDJjVJvM6R24YoIro7ar9V2TzCGA=;
 b=RwrPD6aESFzDRXrl6dGBXvNtmaW2nhZiKzgdKoarndyeCQ4Yy20wVfd2VBcfTBnVFF
 RgFM3/l18r3mEx2vcLfKrD0DsCPWbOeq8URabocTbeWFAe2C1XAFXXx6M1aD0CctuG5L
 6iavTuoyOpB1iVCE4uzzU1QUGzcuO7mNEKCHedgP8Vr/2YtzsENdufBwAzoRLokfO4do
 nJeGJ3NVGMRAnZ5AvWLQ6DWwdYo7be84dM89S8FtG/1M4djIucIloss2cHB0KLdJHzQ3
 sHu7WQmnKLDyFu/NOzbcnIuD4wZPSWSEOhAIqLV3RwUEOVKjBknP1+8FV2EiOKn9U5k8
 /oFw==
X-Gm-Message-State: AOJu0YzfP1I3dmrbLlRbCOpj0F2rfE9pIxuDjx3aPgeNOnEcDZd4DRhk
 bZeVvMAksx8kA+UuA1ly8AdA5IzGffbN9GBtxATcMXrivOt5NQyYhJlhVt6prekAKAE=
X-Gm-Gg: ASbGncs5NpyPpKp+gxSxZqonULZqTlUUgIeze6PLpmx31fBlj6a7T+jgBolpsqoObMg
 X47D6GDUvV7bjEZxNFITYNDtj+8+28/QzCnYiVo7ntZceuHaIgxSHGkF1mppSTgzeFVZpp02RIg
 660hlPJ0Ky5Xq2n1QL9revuuSPpN1d6+0sSP/LvmjGW8y2mPLas6A0t2I+07e+Ls2v+q4Eab86h
 KI31Ud7BeFGq30xGZdFSMkgFhlws3++H67BkRv880aTDDyiO6xOP9/FawU04MeeqtIzBqhAQX2S
 HrqgmGfEK+eiv7MrqvvehH2eK7yqytwilAgjKTqhOCDdmMZND6UHKiFSUBGP0RQ1GjK1cfm7RsK
 S0FkcByo9jCqBolojx7CHAXMIT4teXQAwq3M/pDMmhvgVAJB1XcZ6I9U=
X-Google-Smtp-Source: AGHT+IF5VDJiAg4H73+UNIlNVrZlNOW4DgywK+FxNgLJb6XKSoBGVG6NOW1Mg09ZncI5kfmK1h2kKg==
X-Received: by 2002:a05:6808:6907:b0:40a:a8ad:bc11 with SMTP id
 5614622812f47-41f9767a107mr13778064b6e.17.1753200513094; 
 Tue, 22 Jul 2025 09:08:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-615bc84dcb9sm2120814eaf.0.2025.07.22.09.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 09:08:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Frank Wunderlich <linux@fw-web.de>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Holger Brunck <holger.brunck@hitachienergy.com>
In-Reply-To: <fd74ef18-ae9f-7650-cb08-98f090c05a3a@denx.de>
References: <fd74ef18-ae9f-7650-cb08-98f090c05a3a@denx.de>
Subject: Re: Please pull u-boot-i2c master
Message-Id: <175320051200.8418.10285418192634929898.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 10:08:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 19 Jul 2025 11:54:06 +0200, Heiko Schocher wrote:

> The following changes since commit 53bd87651e45b32efa398dd5e433d8b93d781445:
> 
>    block: sandbox: Add support for SYS_64BIT_LBA (2025-07-11 11:33:25 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-for-2025.10-take2
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


