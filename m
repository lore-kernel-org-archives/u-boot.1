Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB992CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 18:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D41C83987;
	Tue, 28 Oct 2025 18:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="My4BrivW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 447418397A; Tue, 28 Oct 2025 18:59:19 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EB28836F0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 18:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-654f151d223so1880209eaf.2
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761674356; x=1762279156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbMbBQJgAPf0VIM3iqTMkkRHPgA6dKPRaS+wuq5i8T8=;
 b=My4BrivW908X7rnCE3JMaO13I3JzkyGa7+dkJNcvisT8xvA+xuHDGudLntNz6tGdaj
 VXssCajePU5WVSp+Cc9X471xVER1FYlVsDNpEsttC8hDG+UO233iWWlEteJPXE6JhIfO
 /PEnhIi+aakLTFxQ5ZjmkXM7DXhlbzjHbso/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761674356; x=1762279156;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LbMbBQJgAPf0VIM3iqTMkkRHPgA6dKPRaS+wuq5i8T8=;
 b=svwXh46+2++/ph09zfeg7PVZg7orc4aOq0mpHPSzwlggJ8J/7I6c2+adJu6h4cncee
 50X+opqT8WhK1INXqW751qcmHg8IVL044McIgehLD61P8gh40sLrO/SaWGKBWfs0pUk3
 9detLNoSVOasdNDp022u+GGLB4oxIFqLp5zdBcHnkUE3/WkzsAFvJaWIjX41ehJNtCn8
 Hh9+yHLaB6JsFpZF95IhBG5BPUZK0LoTse+eDlTOycHmiNlGG+B5a9BHj0sfCi7supU1
 2JPnQ1kuDN8kmfnv1LWMQH4C10boc+Qub88xQMtw+K65Jez6okTAsx/MmQOiFOx2XHt2
 QY+g==
X-Gm-Message-State: AOJu0YyWAAQXi0whJI5W2q08YyjsDy27NgUNkKr/mbUXF2RtZkUqKszC
 UCffLoXtrPSEBKjkhD4aQmFgi8060ckddo6xGZtBXthKW/ds/pm3gH0/z6ogrF6QJEU=
X-Gm-Gg: ASbGnctrIA3dMTKjMArxwRiugzCHH/u5Q16T+tQ8Rq1kU6uKJWccj8RJwTLynHQ/dXe
 cB7tcZNMusHefLoOpSCpbJLYO/4z7493XiEe28O8FTCXlW16BT1H4339EFhnT5qYkImZtJNZOZH
 Z8/LsXY8+R1ovD3i4wSf4JR3mosTz0XDcW5Kxhr1+6yl5NDW/rCGoKQk8GMbAVWGkAi7u8/MnXo
 i5uVmA4pg8u5stvoMMhjnL1db/h2/rfA7+pso7KQesdMQ5r5LL136t+iQIOtLZc2vgDOMJekj3z
 Rfdq/DQpo/L3uQ9kjXrmy2oZqJS3Wlt6t2ZjBBrUpQviFVgWv2QZwsI5z6im47+090dxwwmM0ng
 2RHaO8bdEdTBdJ/vP7QbKm8PL+94y+YNchRijVAB3Q+1F1maSMhjlgiYngE87CjEabzLzU2EoHv
 cRFGW/+WWImWpdlrFJNlCNadsM3ImbBz+yusr4CnQMy0ecEeqY
X-Google-Smtp-Source: AGHT+IEbbreRCUlWEEchrIIC+Qj0oyx07sf70tqgTt07MQfE/KOt3XVEmPBmDEWxy+zZCnT1AlOP7A==
X-Received: by 2002:a05:6808:4fca:b0:44f:6d9e:61ff with SMTP id
 5614622812f47-44f7a509eebmr165810b6e.39.1761674355894; 
 Tue, 28 Oct 2025 10:59:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2e0d33sm2843926eaf.16.2025.10.28.10.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:59:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250812-cadence_qspi-v1-0-0d693d810145@linaro.org>
References: <20250812-cadence_qspi-v1-0-0d693d810145@linaro.org>
Subject: Re: [PATCH 0/2] spi: cadence_qspi: Fix Smatch reported issues
Message-Id: <176167435497.2025892.14376274785536173795.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 11:59:14 -0600
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

On Tue, 12 Aug 2025 12:34:37 +0100, Andrew Goodbody wrote:

> Smatch reported issues with an off by 1 error in a test for a timeout
> and also an error exit that did not set an error code.
> 
> 

Applied to u-boot/master, thanks!

[1/2] spi: cadence_qspi: Off by 1 in test for timeout
      commit: 0ed45794ae9fa3bd8adb1f2d85875f93d94249f8
[2/2] spi: cadence_qspi: Do not return unset error code
      commit: 1a5129d3dafda90914972ce78db20f7eb6bc9fde
-- 
Tom


