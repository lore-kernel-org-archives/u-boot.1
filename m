Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5C3CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 22:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BD7F83938;
	Mon,  1 Sep 2025 00:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nLnk6JEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6FF383447; Mon,  1 Sep 2025 00:38:22 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52872833AD
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 00:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-315aedbb286so884039fac.1
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 15:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756679899; x=1757284699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=za40CwFaiy7pZcpCVJNj/AABxp/aOOcnqeq/eCdZTbc=;
 b=nLnk6JEepT+VpN8l+2kz7L/qb9r6ACU25jvSLn2F4xEJd1H1SXUOCCn/vq09BAYSbw
 lWcgSAwUnKzX4eP9LzCddlUKq3pMTRGlFwahyysKNvQ2FM96VQeiMivsovrhXhFyHfMK
 Ikz6ZbVimOUMYyRgyWQvz+XrJDl0R22UkUyoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756679899; x=1757284699;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=za40CwFaiy7pZcpCVJNj/AABxp/aOOcnqeq/eCdZTbc=;
 b=vIqWzy8QmZ2anCyuYBg32j/7w4mlo4hCPuZ2TJ9lxihFTRuwsIVQaH+L7ld8+tGWlK
 jqCpb7uBvhrwnJTrPZWfQp0ATOGjnVKtp9FdV4SdmnxXfwceaKRC/wZnZn4Fi9CkysFO
 k+x5NS/6HV7QWLHc4d5Dal2JGywnrG85W8HY3zi/X+kzSXn+gz1wDYaEfdqd5SVCH8nT
 rtIyIZtbQoZ48sNpVLh3VktrjaL+2Kc59DGqAYbUfrR0+CNia1rDPboG5zSAtmFB+WnD
 VOfQz54lB6dUM+r3GNrOXnJzdOYtoeBp1XL5SbF3r67OGLYC+3ypk2EWc51YEv8Y12CL
 O8jA==
X-Gm-Message-State: AOJu0Yya+YcO8NLy6imPDRMy9B/wYrn0j654FfnYOxeBNryTgLUR1vhj
 4SWC1EsZVbzidQIukqbRECunDN6gKTezaL5lUtngP+L3v42Nbu64XR3x/LlGdJjcF0Aglj6WAIN
 LuAopNrI=
X-Gm-Gg: ASbGnctPoei7ddVdWcYtfPCRfvM8VXq2OC2o+PM4VBm/IP0ckuRmLeI2RpJ3FSNGWzp
 z9JOdEGojVHyhhrZMWz4skGmj1WNMy/1qNkS3ls9gvCBGZ+9G7VnPTdJBH9WJDSL6oWkPu5BHg/
 0kae2wleYYIE10cbXhwqw9LoVRCQH6PFeU/Iz/iWPN19XpeWCs4Hi5tr8FVHgD6ETt6EpVnsVsb
 RMqVh3fZjxkI91x1nHvNN1IYkHkvdKyfxPRkh8mSRwgC1pdUIv5ABRjY7+xBQF8DofU1ii4Rwlj
 vGsQF83ntZrKN3g1C14aACGH2wiw+z5zHipUrmRFpt2zzFHHTsMFG6cCHNXAfVNEgKvJ+x1+XaR
 GgRnsKCI0of8hgB6u2x7DB1TQWzNYSiviwmNMqvYxPow027S3RQpn72UY/nMBT8i38g==
X-Google-Smtp-Source: AGHT+IEwJRuTjkAzjxvSB6M/W1q4LaX0vnzw5V1zAalvIWD783jlK1wETpzu81UEzQh4BZPxLn2JZA==
X-Received: by 2002:a05:6871:2317:b0:306:bd25:6d34 with SMTP id
 586e51a60fabf-31963346fbdmr3027661fac.29.1756679898975; 
 Sun, 31 Aug 2025 15:38:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7457428c153sm692089a34.8.2025.08.31.15.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 15:38:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20250804215113.1412224-1-trini@konsulko.com>
References: <20250804215113.1412224-1-trini@konsulko.com>
Subject: Re: [PATCH] power: Tighten some power driver dependencies
Message-Id: <175667989798.2964020.12302329022747835833.b4-ty@konsulko.com>
Date: Sun, 31 Aug 2025 16:38:17 -0600
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

On Mon, 04 Aug 2025 15:51:13 -0600, Tom Rini wrote:

> The MediaTek mt6323 power driver cannot build without access to some
> platform specific header files. Express that requirements in Kconfig as
> well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] power: Tighten some power driver dependencies
      commit: 384079802a3eec3fff9578903285acc93ceda76f
-- 
Tom


