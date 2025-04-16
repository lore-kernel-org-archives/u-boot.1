Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7375C369C4
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EA6C82F84;
	Wed, 16 Apr 2025 16:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EVo7peAG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E0D482F7D; Wed, 16 Apr 2025 16:11:05 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6809881B4B
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2d0364e9231so1752959fac.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744812662; x=1745417462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pB49QnCCc/tukT6ov5jUC9Sjg69JgxoVRShT8D2gMpo=;
 b=EVo7peAGb+7ozLqmuj2Q3ksFBjNNkxDOzmsEg5NEUC/PMR1vrUbdmxlMdhSiOzQfgp
 wWzyBqfqmifNji6W3/M8QmU7ggdovaEdj+uVD1P6E6gKto/GZJE+QEpKQn8zOsqt7qY2
 UrFHHOO2u03keBLALmKLjSDAKjRTTa5m+OQGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744812662; x=1745417462;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pB49QnCCc/tukT6ov5jUC9Sjg69JgxoVRShT8D2gMpo=;
 b=VVrgg4SQnqcjECfEhiZa3Qy1uNsevwEfgcOEClib2AVEPcWSnlSKbJCbMQa65DhRRh
 9T+RorgEZsiw2KvQb2yZ18pddV1I10ca3LWbXutJVwtjhw99J7JgxX4J1QYEIqCR/AN8
 GBzbJqAfalDZlQp2he+hiJjWaHhom6VbF3FRO99caFbQtlfkvkrBnR4qo6ZT8QEFjGxG
 uqdPesQ02SpHyCu6VKfv/sUkIGmj4CHy0pApxEk/nVp3NSrapCRVdxaVDQseAt2NEEZZ
 zXFEtHB2ICh4jjrxSvmKjpYOclAoFJxLf/QHHMnfc4tZWAPct2K+gRrmDIgocL7MmGYx
 s8yg==
X-Gm-Message-State: AOJu0Yz3gh8MPJ8s4+CHDB67ysqZuQspxZGhwlCRl5EJbG1pgc0ELdxh
 iN702/wfZXjj0E/PDEyniCUPsuFE8zCo0QMidv/bEVyu57cHw+XQYUB+xH4S0Ac=
X-Gm-Gg: ASbGncvxY6YnWmolvMkMFwRx6F1J9Ksbf5vIM8aZFDWpWZpFgk5SiMhQoXEOiGr4hn6
 62PCmgAx+//RBDJ5NvY3Sa8UrVloWy/UiG9xrvvyAoC57bntVuuhXncVevnkFlHzMv34oVV8BZa
 bfgn8KaKoY0w5h+ICQhYljMVuWVU/8SkIwyKdxkb7F7apmQ7Qd2DfTEdtTBWRKtHHHZXu7DUTYK
 l7n6C0MQZvg3LwN1vOiNJ78MDatAdLj/kUtyxt+MODXVjXtYjroNyea3FMqQ63JOes6x5YGP2+u
 ll1sBktc3bJz51fR0M79v5qliNMIaLCjKHqGdRPUF/c2QhI3TCnWjOwCH6oodwuMFs6Oyuf6knt
 BrMy9/m4X7T8=
X-Google-Smtp-Source: AGHT+IFotoyXiBV67UIEBIti/lC+greRrrfweDIdcjYpDrmom82pSCddBlIAePxMHAfl6AvRtkxc8Q==
X-Received: by 2002:a05:6870:d24b:b0:2cc:3a6c:4232 with SMTP id
 586e51a60fabf-2d4d2d10f01mr1081895fac.36.1744812662192; 
 Wed, 16 Apr 2025 07:11:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d09695a14csm3314722fac.15.2025.04.16.07.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:11:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Christopher Obbard <christopher.obbard@linaro.org>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250415162409.4548-1-casey.connolly@linaro.org>
References: <20250415162409.4548-1-casey.connolly@linaro.org>
Subject: Re: [PATCH] mailmap: update my name and email
Message-Id: <174481266122.2150978.1453731115027327603.b4-ty@konsulko.com>
Date: Wed, 16 Apr 2025 08:11:01 -0600
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

On Tue, 15 Apr 2025 18:24:08 +0200, Casey Connolly wrote:

> Update my name and email address
> 
> 

Applied to u-boot/master, thanks!

[1/1] mailmap: update my name and email
      commit: 5b4ae0f3f040908602c80908c3023b5454883d4a
-- 
Tom


