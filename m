Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A147F4613B
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 15:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B1C8420D;
	Mon, 23 Mar 2026 16:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KQ1nPfhL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D965B84209; Mon, 23 Mar 2026 16:14:42 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 708F884206
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 16:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-409de4132b5so1678354fac.1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774278879; x=1774883679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQrKIJ+MtU3RPdBZe/ZFW1+9jb6OagkFFX61HJuatrc=;
 b=KQ1nPfhLNLKwcv5KrqqXP5V6ktB4mSQ9nQsMz/5Jm/KENGbq7eFRBBl1e3aAjmz62F
 eTcl1Zrdcz3H28F3SsITLRm1/BknyKrFLO1TQEclamvJUambvgSyDnA3fWGSolNH0bgT
 u3OM4ZtbKfL4IfZhd4aqwymTcCVIOXr3I/ACs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774278879; x=1774883679;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sQrKIJ+MtU3RPdBZe/ZFW1+9jb6OagkFFX61HJuatrc=;
 b=MWDcz7FYxto8NXXUUDVbZMLrbQqoPHh+D5Oz1hbyL6hUiCRG6OJW7RX/LABFJcONWY
 RupmjgkWEDOTZhEKWfuSjtShslAHdx9HBTNAx8kpyIVlba3IAlEjhqCs7SiVwGTkNMFX
 6fyDM0k7U6wnB+rYfEDeDS1KURerYIsaW3PbuXoeyFlo4EqUCtvdht2HXJzCiNQLeejV
 W7MgePZ2YhI47mho99m34dK6EArCKW2SfiG12eph9IpTBSLTAkorG1emkgDAzRADNi3d
 zXJMEqT/sxJJje4Jp4M0XsuIJXu8U+RNEIefnegAfdDWjsCOOms/ugePrrRwDxPUUOL5
 Leeg==
X-Gm-Message-State: AOJu0Yx9JbnCGYIyOQ5AQQz9Z8jmb09WdlWcvYmxwhZMIEW3vtbFMhC6
 eIPJv897/kzAl0eCjW/Plnc0C6iCfTXUDo6adk/SVqpbX4tSsKO+Lf73hoWt1oUqWaU=
X-Gm-Gg: ATEYQzwgwU4RpX9yw/Wz8EHspWXBytK+YcYw29z/1n5jE8qDKbWlCDkpEg0L8A6PI5V
 WZpg4pswibxObc3XkCxNguz96V3V+YJW3hRM4NgF39jxJHe0moGGpemQ1Mw/P71zj9H7hHfGmx4
 vDuyXeo0nyLmJ0QWyDEgghr9al09gOMGgGTYs/E1xc4cvsVvaT2ZrnSe0S2oqhOx+IkNF7XOwYT
 Iv/tVXshy5FJyVFXGMRDcSRCyMPfvfVYxErpvrakNqqCG0Td3vWhSeXStklRyCSLYiE3XgR80rF
 qYMeDYObRN2pQqVezqxVngVIMYi3TOpQlZw2kHguzwBnhcmPijjFoX+3+VIYoMogg95OqtFMLbz
 +R6dSBytfqufxL7hLPbKYwzIUuHN1jP0/6vW8DvSHVK4RJI/37CjBZaXeDjli5tI6UpD/g02E2h
 OYfjTQJyYGBdFM7KTFa5Lm/j/9qi8uIfy/uz9TfdRjBS3UKXXue3lgTOjXdwAMSXn3lgsq5H4z+
 1wHOiVj46qGClz+0SAL9F438EGc8AZG4yUzZLHz0zmv6mE=
X-Received: by 2002:a05:6871:5295:b0:41c:4e6b:368b with SMTP id
 586e51a60fabf-41c4e6b72c3mr4029910fac.2.1774278879091; 
 Mon, 23 Mar 2026 08:14:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14dd0a6bsm10057366fac.13.2026.03.23.08.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:14:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <acE1KOZN1HkALulE@nxa18884-linux.ap.freescale.net>
References: <acE1KOZN1HkALulE@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2026.04-rc5
Message-Id: <177427887845.2283014.9365510367400229079.b4-ty@konsulko.com>
Date: Mon, 23 Mar 2026 09:14:38 -0600
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

On Mon, 23 Mar 2026 20:57:31 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-for-2026.04-rc5 for 2026.04
> 
> -------------------------------
> Fix SPI flash clock for ls102xa
> -------------------------------
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/29615
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


