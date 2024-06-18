Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EB9C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E98D883AF;
	Tue, 18 Jun 2024 16:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o28Kl0Es";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E398839A; Tue, 18 Jun 2024 16:53:24 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8ECC882BE
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2597922eb9eso405461fac.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718722400; x=1719327200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHOj/sm5vItnHbuS36a2H/DaZe2UX4fG+ucISd9q24E=;
 b=o28Kl0EsWp6keVxsOFHGQEVFzZTQy4Ehj8M9VrKR7z45Z7aji5n7YIuW+RkaiAAdk+
 dRurks5A28CQy+SB8zL3iWrpKHMrR3T9G4/d4QhhEXSCqyTrIudW5jJK0RC7skCZKtrO
 M5oHRvkaf2cSWUD6KUH5+1lCC+zHQ60wu+AhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722400; x=1719327200;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHOj/sm5vItnHbuS36a2H/DaZe2UX4fG+ucISd9q24E=;
 b=loJv+dN8b0v4TzPvBd0NqtAh/L7g4mgpF4uXOZqBTa2keKJHaZm4dJ7QMmwqKtF3Y7
 80EOmCb9gzRzAtv8fn4RZp2LpsGcq3Nh5+LAe+6du/pxtu6T75lTF/PWVQgKrLCE2xoD
 MGtQ45l/ICZWRMhSuYcuNC/yvuqMNsMlcUV6ky9oKBaTHBRy0Q8GUOkKncX3b2kBTD62
 KxfjM7u9ba+hDF1WxCjtlPG9XNL7mpjbB4KZ1r0M6VhgtX48x5DQXVRJs4903Pe5DL1r
 9m0LMoR39sYeqtYYhOD98IMPtAd79XEx++w4LaSvoQ2Glu/LycztjjHsPJYM6DxyS3/S
 0N2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKFTYtycs0VcQET5xNk/DePjmYzdKBYx4DzGzoqQMBSILU4bHmE3J+wov2ZMDBcvWNKWCI5WqsOWl450JlVO1pBBSR2g==
X-Gm-Message-State: AOJu0YwD6rE9y0cD3dqaPfw5TR3ZVUYh12KRid6XgRqkDj3ACCoIpcu8
 HyAi9/OR5lcjPjFwUF8uQ5Nro9T4NYTpS4vXjTSGXr3cLnOmQp9Td3gGkmBbjIHtIqq653d/mSu
 bIZIGaQ==
X-Google-Smtp-Source: AGHT+IH/rV4Up8Fk33SRSz+nHLiuebcX7Wwq1aRQBgAqBcL/8Ce7C2pkY9wCpUIDiiIV9/9Le4UVjw==
X-Received: by 2002:a05:6870:7026:b0:254:9812:928f with SMTP id
 586e51a60fabf-25c948f411dmr12478fac.12.1718722400437; 
 Tue, 18 Jun 2024 07:53:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94b7besm3202888fac.6.2024.06.18.07.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:53:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Dhruva Gole <d-gole@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20240605152752.1711835-1-nm@ti.com>
References: <20240605152752.1711835-1-nm@ti.com>
Subject: Re: [PATCH 0/3] arm: dts: am625/am62a7: Switch over to OF_UPSTREAM
Message-Id: <171872239958.3307069.10311597624913034146.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 08:53:19 -0600
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

On Wed, 05 Jun 2024 10:27:49 -0500, Nishanth Menon wrote:

> Cleanup am625 on by switching over the last two platforms (SK and
> beagleplay) over to OF_UPSTREAM, and while at it, switch over am62a7
> (last of the am62* family) over as well.
> 
> This superscedes the previous version of beagleplay only patch[1]
> 
> Test logs: https://gist.github.com/nmenon/ba310d3750a80789aca6a4fd90190135
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


