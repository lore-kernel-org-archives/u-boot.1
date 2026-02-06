Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA2BEE6B44
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 18:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E95383C4B;
	Fri,  6 Feb 2026 19:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oEN3DC2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60530836D3; Fri,  6 Feb 2026 19:15:29 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B675836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 19:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45c9f47e1e8so902939b6e.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 10:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770401726; x=1771006526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2VqsYTEjQzrSCCJ9j3NBltU2e/jpqody8IVvyv53Qg=;
 b=oEN3DC2zry6xr6WYN84mUcVNwi1ggKWCcJCUkrKCEhS6uQ1xot+OhuceCm3TtukIIB
 zzBVTr9P1ixRc8fkBIs+zaB7TjfPAt3I9WsfVBJnGysscoNKZib2k5A8G2w80NJHvuQP
 Wc1naDLpsI1xcAf6D7Q4YT09vmEjnKIZv87ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401726; x=1771006526;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m2VqsYTEjQzrSCCJ9j3NBltU2e/jpqody8IVvyv53Qg=;
 b=MKscccAwryvqJdIIBExb2ekVCwbWQlUhHeoDABQ/YtcJRfKjMd64fYZi5wXK2++Pk/
 XP2hCkAgu8HvA0btz245hZtPk7nWCdNR9Atut+VJRNS77Wf32Th88mmiF3SMp84lsQSu
 MEQkhD66D3/O9ogxChaIPBVZ3YYLlPWk/NCSaIOVGHlF27Im2I7OqUC2oVwjBpRWU6Wg
 SqLykGcYVg4so2TQAwzBjiivCyVSpFddGH/GVgwt3f73u29S9/wm5cu1yr1EsdCuHmDS
 +xBSduz/wBB8JQDyl0PWVtExSJgFkQRj/mPhxnMi0O7n3Jg889ZhFcfbb9HYBKfEy08D
 qo9Q==
X-Gm-Message-State: AOJu0YxEll/P9jBMqPeJ3w65pM3akBsHvdGH5Tmi8LX0vZzqzOizeMDB
 VpsgLcEjBJv+GnwtdUDhihSb8pBqU5QZpImH+52cX4YxmyRQjV5OcwM96uM5CIlA1us=
X-Gm-Gg: AZuq6aKYcKDeA7/6PB+aWaRaIGWZIp0NzjfduJ60PPiqrwXQ0G7NJS7lwHnzkOJN5+h
 V/pDfMsIPkyJtHu/zlByM3lCl3vy1XyqSTlUp7mJemke1Pspv5lg9BAkEMPMe6Aw9ulLK41Z8rP
 ZqAEmZLeSbuJDIm1XPwoLXF7IkLalGofuv0GoYKoFo+OZVrLxojhGiS8TwaQi1uUAucdvWRpPjJ
 /euMdoCnDAZUDlTTHYHIFhywk/Ikazw0JOivog+miw2qET0K1sgUkbu+5dHd9oiW1cQYb447Xvz
 2ZQ1JMeZicEe0eBz7n4NMYRp8DXUk9FgInHWLCkMigTSwaIw6jav2ENf+398UMaBln/fdiFEYMg
 pI85FjF6E1hk5AgdMXSGyLD4u2AjuRw4+/Bof4q1WzMKMeItPyYCf5v2PNhp2kv39t0of8eFwcu
 hxYOcIk5HSQWCDGsMQQVf2GsI1vETArykBaltGVfYinCesErzNY/8nqldBNxtWY+1t3AJXOkYmb
 GRXZ70VwBQFDvhwBtNnHFDxzuWHefDgAoaMkw==
X-Received: by 2002:a05:6808:182a:b0:450:92f9:1ba1 with SMTP id
 5614622812f47-462fcb86046mr1623431b6e.67.1770401726033; 
 Fri, 06 Feb 2026 10:15:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d470914a1bsm97426a34.27.2026.02.06.10.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:15:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Alexander Graf <agraf@csgraf.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260128194152.278586-1-marek.vasut+renesas@mailbox.org>
References: <20260128194152.278586-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] cmd: zip: Use map_sysmem() with buffers in the zip
 command
Message-Id: <177040172492.4023747.15012505785220812780.b4-ty@konsulko.com>
Date: Fri, 06 Feb 2026 12:15:24 -0600
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

On Wed, 28 Jan 2026 20:41:30 +0100, Marek Vasut wrote:

> The current implementation casts an address to a pointer. Make it more
> sandbox-friendly by using map_sysmem().
> 
> Use symbolic return value for the command while updating
> the return value handling.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: zip: Use map_sysmem() with buffers in the zip command
      commit: 3a76ba66ecb65b892de8b16360a8b0e93415f712
-- 
Tom


