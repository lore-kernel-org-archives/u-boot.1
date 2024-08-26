Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F24C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A0088B0B;
	Mon, 26 Aug 2024 18:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eCVpywhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C245F88B0A; Mon, 26 Aug 2024 18:50:06 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B190988A08
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6bf9db9740aso20530336d6.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724691003; x=1725295803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3uF1UnFByoQ9Z920lWXWQN8QleDrvTTPFRBYkpmibu8=;
 b=eCVpywhCGPWcvbA6bhAKNkX6i8SlrW0Fci0Na9d7Qglrqe5DTA3QgF/tNZpExY4StQ
 joQSpAEKfgQztZNrPfkMlpoSAgjlgOkoRI44ljYwMMhhJq/Dz6lQZSsja1Mr+Y4aZmIi
 POWSxlvFpjtvXh/69g5F+hwSvwjNw6mEMn79I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724691003; x=1725295803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3uF1UnFByoQ9Z920lWXWQN8QleDrvTTPFRBYkpmibu8=;
 b=LzJvFsxwBmnMFgz4MjtojKvu9Gt0gyuClocO51odFpFjG0ah0EpGHirkqZoWJxjazR
 XFa/keEsUqCx5bzVFL/h56i3EX08fYY9HAanwmjJFMTAUXjxGO3rUcM6vNIRUJlGe/nY
 4BeaMgLa6PqESFToyRpauEru2SY9oeyQinC0qABZd1rfz5Iz556IZITOCxZJp51uf4y2
 0cd43R7I8KWgovioFoLSAr2viRRU59wsxRSV5XgFgfTwGP7bH1DYYvOWHcJUA22Wyuz7
 CM2U5lAED5NlGYUVgaZ7Uyho8Gr0bGLNvmKqd4rsiMcozyKmwLbIum2kfW9dVdzWdXrv
 KDpQ==
X-Gm-Message-State: AOJu0Yx2qy+DKrcdu+CycmHhHYaz+v7tOmByh49F218kn0NdKL+jyTso
 +5YSHGTaJ1oOvxgL7/OXVSqgycm4mRvx0S8cNsQonh8di9UpFOMtyYGPag7AIK1RqeoyP1aEKH2
 C
X-Google-Smtp-Source: AGHT+IHksyVsbqBKOFqUiDOqIU0BN46skxqfq1H5C5m2mo0axQzRH5GeKwnO0NmvB9S3Ec+G5eq2QQ==
X-Received: by 2002:a05:6214:3b86:b0:6b5:9439:f048 with SMTP id
 6a1803df08f44-6c32b6a4dd7mr181316d6.19.1724691003489; 
 Mon, 26 Aug 2024 09:50:03 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d1d242sm48576136d6.16.2024.08.26.09.50.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:50:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/6] Remove almost all project wiki links
Date: Mon, 26 Aug 2024 10:49:51 -0600
Message-Id: <20240826164957.2789525-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There were still a handful of places where we referenced the old project
wiki pages rather than our current documentation. For the most part this
series changes links to instead point to the current website version of
these documents instead. In the first two patches the content was out of
date and it was simple enough to correct instead.

The only remaining wiki links are in:
doc/feature-removal-schedule.txt
README

And in both cases just updating the file for those links would imply the
rest of the content is correct and it is not.

--  
Tom

