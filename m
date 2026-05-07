Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B5CCD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 04:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89EA8847E1;
	Thu,  7 May 2026 06:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dPvYDxSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B06847FD; Thu,  7 May 2026 06:19:08 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EA65847D9
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 06:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dea1272943so261893a34.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 21:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778127545; x=1778732345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FR39QBTnbgUGhvx+AKszTQcbWNuIoQ9kgwDolrM9qPM=;
 b=dPvYDxSJ3c438mjzj9T8g+lvCiB5TfTostV1cqYBBaf0hNJwMzL+b7JVCr583c8tim
 O6TGi2TfT427rLk/g3o1N9L60BDyCI2w36B9w+IPDGm7LPqufmZKInejnEirM4IFd247
 VKtCgKJcaf53GTEMTKsroBg/aFwx790gM9F18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778127545; x=1778732345;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FR39QBTnbgUGhvx+AKszTQcbWNuIoQ9kgwDolrM9qPM=;
 b=IB5gESzFGmMQGHr5BLiowNAB1fJjH0O/mgIGvYuYi7Apz/wS8BElhtviUCj5R+dtLb
 V0ILm+dgg4PkqTDjUDE+0HfWJqX4h4lldhUvO5O1DhLmBj+wW3k78mbn/BnFunlAuPjs
 h3aRssyf6YWZVF8Oad5BuYkSjXfWOC39NN17hqr1e7YxgQ+Eu8w+JEDF90zxSVdavQ4L
 1qRwiQwfWcQhVFm3fPSKnTPcdT5G9rtHVABgrhd8yPxaKnt9+2QooQUssOsUaF1wVwZw
 MkaqATIJPYLGZFLOtlLsRZ3J9OC63Xi6LbQMqbdhRunMeELh969eACm/fWKqQlMDhIhJ
 dPow==
X-Gm-Message-State: AOJu0YwXkDHPhFUIKVwERFiaSz8oVnkD9HdNiQaQ3BkwH9nVI9hM5UGZ
 w4GRA3ZdTrJsOHqVGCOVclTmmfSEyHKgfb0qUIYSaWvPgncp0FpQiUiDEIlcDBif2CxBlVlzFPR
 ZsOaTj8Uwteub
X-Gm-Gg: AeBDietochJPiKtl+6J539i4OhBNmD7JNR2GMeEF8q+/z7T9mlpMnVZ0pO2fp3ZDYpa
 oU2JrhbHwmlb6m5kL/LLFaPsDMvqp3KuDew4GQyRbI951O1j2sVzhrCI5T7e2x7zHLBht8ljvOc
 b+gnfMkaLVcf9XDmXAyBNO9TRTgy1ze7u3GZav8vn7CteASZ5ifbdmxCb/jhYbGqYg+yM0XHetR
 K5QHtpctscFB7mnunv9gVFSRq3ADtN3WHiycaG5Hy41M4Ej14QEAebP+mwsS5jp506DlzOm/W0+
 d4jXJRVfpHl1fr+1Wgi8AoCxD2j/a88sNfufxYyrthD2Q0zOnlMdT/NsqKl9MDz4r25l/ohAv2Y
 EKPCz7UXO9heE0FAFbuX+rSrfm5LDSf8tmJXZDZLBEKA7YWtb1mjId0CIkZipvtFxg9JKEgXmkM
 l2MIFhsplKgefnNosqFKVmkoJnDSpX7V1JLwfP6Nvggl02PRCdGaCgmR7ZJbvywZRDwfafqQ1UE
 3+G9LjQvyHRitsrw8YACJ1ZcXFUTVL3SI9ujyYDSO1E9poeRqhvsCcUANqfewD7Vgb9V8c=
X-Received: by 2002:a4a:e918:0:b0:696:178e:298e with SMTP id
 006d021491bc7-69998c95828mr3627507eaf.11.1778127544412; 
 Wed, 06 May 2026 21:19:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6968945dc14sm11176481eaf.6.2026.05.06.21.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 21:19:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <afwG9Lz_wtbOS1g9@nxa18884-linux.ap.freescale.net>
References: <afwG9Lz_wtbOS1g9@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-for-2026.07-rc2
Message-Id: <177812754313.3287861.1427574164828487694.b4-ty@konsulko.com>
Date: Wed, 06 May 2026 22:19:03 -0600
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

On Thu, 7 May 2026 11:28:52 +0800, Peng Fan wrote:

> Please pull mmc-for-2026.07-rc2 for master
> 
> -------------------------------------------------
> Enable FPWM bits for tps65941
> Use max-frequency to get clock rate for msm_sdhci
> Fix and update for pfuze100
> -------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


