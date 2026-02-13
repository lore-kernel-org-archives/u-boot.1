Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC499EF99DB
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA5883CF2;
	Fri, 13 Feb 2026 21:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZqP1CW6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35FCC83D5D; Fri, 13 Feb 2026 21:16:31 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C35083015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-45f194e9a98so489616b6e.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771013788; x=1771618588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoSDpFlRwKvFtPM1a93IxWojAWgypxY9Q3EGmNDzTqc=;
 b=ZqP1CW6u+H5IacWXgW/x0riQfjZwCrc8zSarIzkitTBWWMOnWwYOVoZa/aQaSqL/u8
 RHeLd5BCRg8r1TDbsuKISggOoQToF5uFu861xV4PwGWNuX+uttjeWnghr9QDR+EZ/2xZ
 qtMl++qkVQzVwgXcG9IRC8nVKU9nWOdK1k2E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771013788; x=1771618588;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eoSDpFlRwKvFtPM1a93IxWojAWgypxY9Q3EGmNDzTqc=;
 b=cpzHrPWg7aRoZG14CmKGV7RjGFA4yteX8ykUjLeSBqdVQJHWAz8+K7FFyET3gIw+w9
 799dkkvN8N/Gsh8uULZhxtdRnINVSEYZrOAeeSFJwQSF3Ij3N48z8fvh6Egj3uYwS8AD
 EBWgtklOYamik0jmUDuDPliZaIv3r7JW/YYJhYMq4tD7ZZPOmrFFL009neld5FGm/+A5
 I+98R5xsU85d9tJJSAdSsW9V7CaAvqnqXWNTyLvNKZ8MLgZVzM5ETL11VZprIlPQxzdG
 1wIIEatv67j+EEhLHiIynv+6ZcTy1zo57u6PI+iJV6u59GwKsp+jkt3/9UtYDG37C7Qn
 G/fQ==
X-Gm-Message-State: AOJu0Yx2Jv++K0nQUAtzzb4y+hSZRPQ/qs4FYGMvH44jDS+PvOcWQS3Z
 GrEHdJFAxFFJfFO6vj5UC7jJJ0dMMhuAgGdGgpJNPF37xXLQQxBMAzdHUoU+uLE3Gf1DdHAJa13
 00JIBR+A=
X-Gm-Gg: AZuq6aKOK9miu4SjsxQzEFAfv0OIjmsAQn7yQ8BwFvKCy92itrtjvhnudnc+DbsZEHH
 FJGNG5oU7W+T4KaDT4DwZ4SXgLF8Igh1EDzVl1MW75hJSrg+9DhHrhh4z7neQJHbuxE4BIRUZ4L
 pnRoI9Ov2YUOtzvi/5NT6QC06quHbAF1JtXwtiUJyxjmonh6i+1SOHKndzzQqFVzUpL0GLb+oZy
 smguYcX3v9lWpJms+ANUhMsoqoMrWr7u0LVJhoSFfBpMs7HHFVrj79p+cwIkb3S4CfH/T5cbPs4
 QjF7ggemXre1rjixyy3PT60tYZyA3IC/ehPxEij3XhIIgyDmBOVrvP3y7smXJiOCt0EdabjElVt
 eSGGvAJ5mGYmrCxV3Os5/OPyemyDyFaDOoEqT07fuVa5FpSIcOvrswDfWdcaNXRY8QRrDlaV9BP
 UYVtb4K9IXfIuqwuaFP7Zf2I17Zq+iE/DMVOkNO/w1nouJscAybCjs2Ia8Dm1AqQU53IR8aiA/l
 s80Z5Pe/+py/rcJQK7dKI8wtRGhQyyGuFAmnTtqIF4xb+Kl2Q==
X-Received: by 2002:a05:6808:f94:b0:450:bcc7:18ea with SMTP id
 5614622812f47-4639f079333mr1494630b6e.29.1771013787763; 
 Fri, 13 Feb 2026 12:16:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm5152025b6e.3.2026.02.13.12.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 12:16:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dominik Wernberger <dominik.wernberger@gmx.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
In-Reply-To: <20251031224434.102648-1-marek.vasut+renesas@mailbox.org>
References: <20251031224434.102648-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/2] spi: Squash spi_slave_of_to_plat() into
 spi_child_post_bind()
Message-Id: <177101378702.2522051.7909338647258715384.b4-ty@konsulko.com>
Date: Fri, 13 Feb 2026 14:16:27 -0600
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

On Fri, 31 Oct 2025 23:43:42 +0100, Marek Vasut wrote:

> The spi_slave_of_to_plat() is called from one place, spi_child_post_bind().
> Squash it into the later and remove the public declaration, make this
> function local static. No functional change.
> 
> 

Applied to u-boot/next, thanks!

[1/2] spi: Squash spi_slave_of_to_plat() into spi_child_post_bind()
      commit: 59fa20f729789d12e7815fede6f5b3fb280dcdc9
[2/2] spi: Clean up more of the stacked parallel ifdeffery
      commit: 10e84cc16a1cfb3c70914cb524090c7e5411a37d
-- 
Tom


