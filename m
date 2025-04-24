Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00699C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 21:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B97A80FDA;
	Thu, 24 Apr 2025 23:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bPtLl8SG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7BBB8082A; Thu, 24 Apr 2025 23:32:39 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A7528082A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 23:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2d060c62b61so1171387fac.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745530356; x=1746135156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdU90JTg0Ni+W+X2Aq2zKe3BNu3cn+Uab/uTnvDJ344=;
 b=bPtLl8SGVY26+/Rbj3xkJxkeoWgSF15etW+UW9PQRVje0nn36X5sYij/qq4z7kO0eG
 bw1QZOQkGMCQoLxijeyeo0cLblPV8tLHAkt4OCV7KF/ZAF/Ib0fNx6VvJTmqLM9xZc7A
 liDQRkTDDXGm//v203cJRy0NrZKjx+3wuYP1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745530356; x=1746135156;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AdU90JTg0Ni+W+X2Aq2zKe3BNu3cn+Uab/uTnvDJ344=;
 b=Lr8+6qt+rRtgPcNZGq0MeqHZ6MCrVeoUISbZ6LGA6CU4V/C6k1sNlFjMt8W890tlto
 WER3Ss8bvdsQWIWpUXn+b3z+p31V4w10Tu1j6duEgdb408gpdlTsE7aNC8JXS/QnHOfP
 ZeQOsozPUld2E3tiKOKzDPSQaFIQDf4xfxsJrQaRvb+g+b8u4nNR4yDPqeBc6USqKqWd
 tmIQRt6QohqmRl77rlD9P1CV8zhTaULr3o0FNwUecflknjjiJFQJIvYYq495jPSITQAZ
 so5z1xyRskVeLOLrtBMQTgziyHvfgEjvhbklrPrcRmZPlYvz0JgCOcTTqTXBb2+Dvc/K
 6C0A==
X-Gm-Message-State: AOJu0YwgWQRvahYANuHDfkcLKaNbs6BNTwGwP64xSXoSvMP3RGUhRiLj
 friwYLWPbxE80QD489H7p/GfftHnfGoDnSapuDcci6/qNLK75pxxEHnxPmU1+tJ0xflahG+irB7
 9
X-Gm-Gg: ASbGnctMzAULcr8q8V7xodmF5JlCGmcHrewIEmT8FdtGaBihmvKEFEN1ZbJyUol5OjU
 sSyLFTGZi0PMlAFT4N0AY5srk7qR+9W53TrK3sBvpnX9PLQRW+a/3tE7Wf+NfiOoGKEdzxhPiUO
 cb+UtllKESgxXGq4XVSI6Xlnh174WWIGkb2879of+DztIu8cbuRLltxJnWLmDbyczgh2nMs4c5T
 Evr6vV9PIn+BACrSDjMqlUAXpuvK74J3oa3uj6MaZ8JuKj+KQrZoKjEdAZWKcT5q3W4HMIofgc3
 QiD/34LC4HULfmUk3JPOK8/9a4KAol+ihzgxx4GMdjq1pNAuF1BKscqokeJNRYZQ3LPGoe2iSi9
 t
X-Google-Smtp-Source: AGHT+IEjwA5c5k30d5OrFlOFuYYaQHvQcxL+ntKe6OGi1FApKdvUtdhaQv5Fnv4pB3jWOeragcVwEQ==
X-Received: by 2002:a05:6870:e985:b0:2c2:3ea8:eb3d with SMTP id
 586e51a60fabf-2d99de4506emr47553fac.33.1745530356367; 
 Thu, 24 Apr 2025 14:32:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d97364d9b6sm489419fac.8.2025.04.24.14.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 14:32:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Anatolij Gustschin <agust@denx.de>
In-Reply-To: <20250319112003.594938-1-sughosh.ganu@linaro.org>
References: <20250319112003.594938-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH] cmd: cls: do not repeat clearing of console
Message-Id: <174553035515.4093791.17728314168299939022.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 15:32:35 -0600
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

On Wed, 19 Mar 2025 16:50:03 +0530, Sughosh Ganu wrote:

> There is no need to repeat the command to clear the console. Remove
> it's repeat attribute.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: cls: do not repeat clearing of console
      commit: 068eebd065ce7f4dc1ffeacc6a15a41982561015
-- 
Tom


