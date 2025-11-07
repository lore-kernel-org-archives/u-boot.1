Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A32CCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 21:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B0EB83E60;
	Fri,  7 Nov 2025 22:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ouq1tsHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD3C83E62; Fri,  7 Nov 2025 22:35:03 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35F1783E23
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 22:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3e2fc677775so888352fac.3
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 13:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762551300; x=1763156100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErwCFwuWdk41ey4M1t54dfL/OpNDDyizJDhmZDMx+Uw=;
 b=Ouq1tsHElMDIxlLR+lribevjMqvgKsoKHQ9zG8QPKEaxxnhjT6NG5HMGAwOwlmbGpR
 kMHj5v75IZFJgg5ykSboE6japkB0TXOjcr1FA75QO93HAWEVsyBINLU6QwpzPzKAxDmz
 2e0g8SXySuG93JB0nrJbdc8AR4cVJVGsGG4iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762551300; x=1763156100;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ErwCFwuWdk41ey4M1t54dfL/OpNDDyizJDhmZDMx+Uw=;
 b=Zohmo6qhRRoG263wEW9VKXy8YO4bMt+b3TwHOd5EgfKH0PulszAS0K41kRiKOEQ4wE
 wrsrWhyGrGfZh943Keqa2SC79U5GXKkpG6RzID/HjxQoJ1VBCyuIItQ2bwTSWwVfn7UO
 JvIpFpHM8nMxzt0E2fj9/3D0FBR1vDprwrtRP/+iNgvRlAkIjLbSP0zti/gPCxqbOcLT
 SY8f9K6QbzGoAaPH21AnwmihWa3+19efUP4C2lFoSeN1t4dfeTWHXcN7ElwNSWBuTCY1
 QsDgyQ/8w1rhB5UrBY9Vp4XHNAQ1uK8oUaoEtux1bDUyNBKbP5xyuOkRErkVIX2QzHnw
 zbXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE/QoX2k7k4FyoLTmySbfMG9hiTeO1rxr1SEaOdGvFLWwBFx8ThQ8aO2ql6Jh5BAMTBEjbHfQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwcFCxZA202JkZ1ZzKsW0K34Yaox0KODmQxImtsi6hQ+5XKbiX4
 kLTwgZ+aIh3hY1rtzOdJwdBilECvUzu4xRTMHp4AC26kgQz9Idi7KOTW4Gap1dS1yhs=
X-Gm-Gg: ASbGncum8IzfUz8gGGF0bjkwFv/fFtcW6TLh7T7SXPO86VJ0/6/wRGtErq/K+VS/5Gc
 DDwh17CneFXNAJ3+iyTI7ZDU4/RFKq+Ee+9m/JocxL+84QMh9605xKnIhMyD4d/5p1UEgUiYfc6
 N+OBlyxlrDYldDjMkOX0L1LzdPj3CaO+608e3xWhKksBhhmlfxQKRQNW076zm4T9+673u/GbGbR
 1v/4IDKnjXFJ4WoAyCv3zdEpoDkOsMDBBH+g8glgizF4utCwDXtnO1GvdiOOcv1AuF5LWfptzYg
 /uscbogbEDLfrE3Z8lFdVJQY6XBZSJyciVjNyHYhH7heEz0ww0nUUV1zUVo71mxp073LIF4yYyA
 AHafDiKlZ0/V1QaPW/AfGzml3K1/S6jYY3To9UcPFFlVXQGcMqxMdFSJ3gmIORoryJt/Z5hjmjk
 rwSAmWfu5BRQQaBxl7aSdI5Y3nEQT6BXDJaqgz9pZk3zhc65yC
X-Google-Smtp-Source: AGHT+IFWUXaISevX7CvVgVJJue89Wi75Bx1Bp9E2ij5cje0VN0y8jYDwYCFqsQa3eOWzHcs3VH4aqw==
X-Received: by 2002:a05:6870:241f:b0:3d5:aec5:77c6 with SMTP id
 586e51a60fabf-3e7c28f45b5mr711002fac.41.1762551299806; 
 Fri, 07 Nov 2025 13:34:59 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41ebb0fc6sm2507000fac.2.2025.11.07.13.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:34:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20251104230203.50404-1-heinrich.schuchardt@canonical.com>
References: <20251104230203.50404-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] sound: typos 'to be write', 'writen'
Message-Id: <176255129913.3424353.8671785603235361346.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 15:34:59 -0600
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

On Wed, 05 Nov 2025 00:02:03 +0100, Heinrich Schuchardt wrote:

> %s/to be write/to be written/
> %s/writen/written/
> 
> 

Applied to u-boot/master, thanks!

[1/1] sound: typos 'to be write', 'writen'
      commit: 199341908e3559a306d2726f7e33e2703864f0ed
-- 
Tom


