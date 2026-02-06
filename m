Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE791EE6B48
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 20:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECB4C83AA7;
	Fri,  6 Feb 2026 21:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KyqSKd4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E3683AAD; Fri,  6 Feb 2026 21:12:13 +0100 (CET)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4BA983642
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 21:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-45f18e8f2f5so1715108b6e.3
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 12:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770408728; x=1771013528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XDExZupfC+nyst34SKYQYYZ9X6wAsfZ5xbM0Y18Q3E=;
 b=KyqSKd4RhTAUxD4aR6IJBv0e4l5wLg8jsT32RgoQG474RhahS7lIQk5mK8T7gYt6M/
 Mb53fBwpj9LNIiKEakG4KNi5KybosQSLn2sH7Q8w4ow9Du56F66idR9Fsle5QA8ruUQW
 udvT4B+VSXsZo7EFzMIthvA3+Z3sFirKOfd+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770408728; x=1771013528;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6XDExZupfC+nyst34SKYQYYZ9X6wAsfZ5xbM0Y18Q3E=;
 b=ohGKVRqBUaaKFA2ABM3KZhIQmJyWyp1bbq8POt+U57kKKoBMKxok/YxBo47c74C5yX
 b72SC1M90rQ6PWtn/qjkDBUaDfq1FQcm+UbS3zum3GL1ggZMlTNfqO0sl6Ef+Y9hRbEj
 WFyQFa86VF/gQpcDj1s8FGixCRGbBHMYB+x/1Hh8288r8eFzkfcuv0mBzYRZhcKlF72E
 ULIN/MIHllrs6eIGoDIrn7+5/TZqelvMyir1dehgXKXdMfjJ6cP7eH/th5bUEfclQ4AR
 aPyGUrqEYFNoJG8M4nWM+w9qIzSpGZD3ncDgbcYIK4tRwI+/4rcOlvlr8o6PNrxiuTDN
 B3og==
X-Gm-Message-State: AOJu0YxnoSb4UGeNs/JnhoSBqonH9VgNwCtRxBspDTrxNfvR78H0ZTRK
 SB6QbneC3IMtohKIEjahtMy1FQmaZwGK6t0jTGPGCrXuFiWBpz0KfMqhoc1S0lGdJUaEJH0psms
 IsYRE8qE=
X-Gm-Gg: AZuq6aIxh8aOuetgTOTzgeUV18erRMYP2Xzjn085L/T4klb7Ihl76lSDDDDv6S0Voo5
 I27Gp8bsBZ/UkPcQrCb9E3FsgluzAudJrYcoxhCWSLE0oVs905V3b85ZviC06Ax4CB9W4Hr7IjL
 pH1SClTUBRP+BUsMtpngviGneMAG6GcJBWGVfFqaGlbd/0TQfeigFYiO/YM+yRbCM6IsqxblsPL
 kwhwC4OQ7Ic52QfDdomAOcT52wbATUTFkrwhvDLbTr7mU+2lwqUJpq7wDaLaGIFjl13uBM+AsO9
 WK6wnGnAlzYDcN3TMDnKMa58pJFMOzzOxgFFstiV5l5ueP0r/4jI2QGcFAXk+tDWA6iJQ0IyD6j
 F6757dc/Yzl1UW7F4M3JP5ZdgOniTQn9k9EGskp/9vDeXz3TMsTR+Ynxue2zs7XUwBCuxSmdW64
 ey5KkJI7LqKtzOrngHAMo1XP7aYt7btGA2y74VMuIRZsNHas8NgNZQjnFl2FFrWZTQRTFyRPVry
 5dZYL3Ux3hrN+BJxDyu4QBUoUmrtyoXFVv0oQ==
X-Received: by 2002:a05:6808:c18d:b0:45f:27e:5cb6 with SMTP id
 5614622812f47-462fcb52a9amr1830245b6e.19.1770408728614; 
 Fri, 06 Feb 2026 12:12:08 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462fe6ee926sm1913509b6e.0.2026.02.06.12.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 12:12:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
In-Reply-To: <32ebd3f3-6ce8-4be2-ada8-9edb25f42bcb@gmx.de>
References: <32ebd3f3-6ce8-4be2-ada8-9edb25f42bcb@gmx.de>
Subject: Re: Pull request efi-2026-04-rc2
Message-Id: <177040872771.4057369.13504651172800284955.b4-ty@konsulko.com>
Date: Fri, 06 Feb 2026 14:12:07 -0600
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

On Fri, 06 Feb 2026 19:32:44 +0100, Heinrich Schuchardt wrote:

> The following changes since commit b5213bbfdcb1812be510427857827ee8becb9f8f:
> 
>    video: menu "TrueType Fonts" depends on TrueType enabled (2026-02-04
> 10:41:48 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-04-rc2
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


