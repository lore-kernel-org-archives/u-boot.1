Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCE7D3B9AB
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 20:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC4883CEE;
	Wed, 10 Dec 2025 21:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cQrky+mn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D171B83CD2; Wed, 10 Dec 2025 21:45:27 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC1983A91
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 21:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c7545310b8so182966a34.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 12:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765399524; x=1766004324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=leBy/LWy1uw6AmZcSFgk998+fEGehpBU9JxoxFOGvsI=;
 b=cQrky+mnNAPEhyUnT0bZm9IMEP3Qs5SLIXkCr9L3/unWj7Rjlauf5iC7V6oNf9Rg5E
 SCS+Q5DK6ig0nnAwktXG7LdPW1EI2/wVtabL35J9ir73ts1c91h6MxDdWBUO2brr/NuI
 1/OU4oNMgVNMLZ4x63CEYoAqujdinisC0Gq/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765399524; x=1766004324;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=leBy/LWy1uw6AmZcSFgk998+fEGehpBU9JxoxFOGvsI=;
 b=JxOplxbzo8Wr9vu9fDPuPXHYG2LVX8gkoyDg3MXL+/CcYE6i9tegsz5ICiaW9+2cP5
 ATGedOpS+VTSJbHRcUVojxL1uJxmx89AMZK7AQbDSyYucA2iy5maLYoS3Dimln4O4PvV
 4i5o4InYcA8aRysRqJFGBL0dn/yApe8uzxLEV4GNrm5zQROL8mE5QpIeqcE/INv2n2W2
 erBEDLDng3sGiOXy18mOSBGMYaYM0CoGHQ2cyxqhQyvwq+IzdpAqY/N68kqcMoI1M33X
 zhB3T/rXiHm1HjiBGIFDraufZTnBPJdr97EaLc+BDhlOjXT7vJd+6HvE9/sxsBBE4C3V
 +Gkg==
X-Gm-Message-State: AOJu0YxLVxkYT+5e1DjYuw5n549JxMZQxQg62BttvAsPL4kJjD4+A8Ls
 X2UI02eEqLA5pqZAfkwPLzKZIZSmSpeGfB/Jb/4fVzUdpNqm49Z2i1i7zI3TEnTPOXk=
X-Gm-Gg: ASbGncsyFgSH1/BFXRRIvk70g4EhVcxMd4UoWEQq6RAPPSbXN0y/Nt/mcgC/02aVaqg
 ONl3/0qwC966t8CL/JcEqcoySogAt5Z27o4lzZOdL/yhxbVKk1uY93LEsuliNXPuuI/0fF4wuUt
 wGb9FacokFdWppHu3qiXq1e/zwJfbEUMzuPx5T0MgKM/tl7Ux9/b6TYg56W4JeMDhEMJwAvEFHg
 DPf+fWF6DKao/WWVCsVsPsY7cze3oun/ofk9FdxZSyXR3jo4aTCE5QCJsBa0rd7emBiApath4rm
 MBS3Ku+uLjjukbtQ9L7IKX8FFT2CFCDtl3eNgY/NquFaODCc75kDT9KJ30QE76kZR7BvkUgpDjG
 rF2tnN3IcPYH+9hxd5yYIdkVR9/p0aIWgIAEWIsK9iWVrDbY2YPsMg5I5DZH+tOLMa91px3DzI9
 gKkCnjDLgyJlaiSAAbL/LYi4dHX1ke0omscdBozYCOo6RvMvq+
X-Google-Smtp-Source: AGHT+IHaaLap0z/3dtVZ5cTtUeWt90kItHdAJvqKgs6YNr2QHpkwkN+jIyUpoQVHvB5MKulxZnJRYw==
X-Received: by 2002:a05:6808:1581:b0:450:a9d0:b790 with SMTP id
 5614622812f47-455866fb23cmr1957481b6e.46.1765399523684; 
 Wed, 10 Dec 2025 12:45:23 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d4e70030sm485887fac.6.2025.12.10.12.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 12:45:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: "Andrew F. Davis" <afd@ti.com>
In-Reply-To: <20251126-topic-am33-hs-evm-remove-duplicate-v2026-01-v1-1-5008cdb30536@baylibre.com>
References: <20251126-topic-am33-hs-evm-remove-duplicate-v2026-01-v1-1-5008cdb30536@baylibre.com>
Subject: Re: [PATCH] configs: am335x_hs_evm_spi_defconfig: Remove duplicate
 symbols
Message-Id: <176539952274.3502425.3403187728107926232.b4-ty@konsulko.com>
Date: Wed, 10 Dec 2025 14:45:22 -0600
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

On Wed, 26 Nov 2025 21:25:56 +0100, Markus Schneider-Pargmann (TI.com) wrote:

> Remove symbols already present in the included file.
> 
> 

Applied to u-boot/next, thanks!

[1/1] configs: am335x_hs_evm_spi_defconfig: Remove duplicate symbols
      commit: 5425350bf530ae958bf98af837b330a05c2a05f1
-- 
Tom


