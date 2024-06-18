Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5463C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69ED6883C2;
	Tue, 18 Jun 2024 16:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jfO7oeiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0310888381; Tue, 18 Jun 2024 16:53:26 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7201688381
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-254871388d3so2855403fac.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718722402; x=1719327202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2OC9RzETJv83d6Z5zVnWyUBnCIMmyYOCCOt7NeESio=;
 b=jfO7oeiwrb7y+Ckt2TEZNzYhMQOfu7I1J5rqn3jZ6HmH/DmeS3xoxsHVvW9X7aFOkV
 W3fBXIKMXgVH5VRvOEr/FbRo3OA4/XqT/1WbfVKsOzoCS9n2TGOajHWBhRYiuXqV8Nt0
 fpWXU/swO0e2tk1Oq7Txph3Pk+1Ho3QKJPyjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722402; x=1719327202;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2OC9RzETJv83d6Z5zVnWyUBnCIMmyYOCCOt7NeESio=;
 b=NOoTc4DlQiZjmITaosXPwrEq+wo+/NonhLzsOJNwvAJxP3MBwv00hZr8DanRcA24rV
 Coi29glHUNRiGMwwnR06X2AtvDrzUjrVNphvSe2EGsGhOoofcie7l8g+R+z+vYTvv1WY
 eIYkXX2wtyJ19iuhqbqRolhklVdqPCTGLtUxGom7RTNR/C4CfU2tC56hlQXsFSaVRpHU
 iywcnlKYyc7HspvZMlib5zxQDVP9vdbV7xHVBtxVb3ZKfb6jmSkGp7REs5I/0wKMHwb2
 kjYwx9Dikcxxue/FqhQfj2ZT202AN9tFWqbFbSRwvtem0kv8lmXUJP/s064AsSiorgUh
 N3/g==
X-Gm-Message-State: AOJu0YwozugYp4i1PhRu1ZXKMCLQM35QBq2InNYWlOMshopg/114o1No
 7/jR80HBcnr7ogsh15UzP3OEOjAwR1pYlX6Mh3a5jaSFjHnEadLrZAXryi3Ojckc591ioWIvVo5
 PgrpbdA==
X-Google-Smtp-Source: AGHT+IG5T0iVvue4437L7FDGIe0RYvEAFtaUwpBAXOKBoSgFkGD0HCSfFi09XDaGnlWPGxONRSW86w==
X-Received: by 2002:a05:6870:c10d:b0:24f:cddc:ccff with SMTP id
 586e51a60fabf-25c94999cecmr15427fac.21.1718722402198; 
 Tue, 18 Jun 2024 07:53:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94b7besm3202888fac.6.2024.06.18.07.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:53:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jianan Huang <jnhuang95@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com, 
 wjq.sec@gmail.com
In-Reply-To: <20240605140554.1883-1-jnhuang95@gmail.com>
References: <20240605140554.1883-1-jnhuang95@gmail.com>
Subject: Re: [PATCH] fs/erofs: fix an overflow issue of unmapped extents
Message-Id: <171872240148.3307069.8693215570388652862.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 08:53:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 05 Jun 2024 14:05:54 +0000, Jianan Huang wrote:

> Here the size should be `length - skip`, otherwise it could cause
> the destination buffer overflow.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


