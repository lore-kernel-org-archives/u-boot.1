Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570F2E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 17:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83BED803A9;
	Wed,  1 Jan 2025 18:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZZDA1Nmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FDD38031D; Wed,  1 Jan 2025 18:54:27 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01AF48037B
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 18:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d8f65ef5abso89283156d6.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735754064; x=1736358864; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwAQmhc7/20iinCvJzfQRMp1z8tmRm8yghTp6P+8umc=;
 b=ZZDA1NmcMwJqM+UOiva3/rKKya5rf0F161Z0yJk0xOPKuyv3uG1g990kJN1fpvKDex
 ocTtEKu6j7X+ZOO0zlCFCmgrtv2K4GsMzibJHEWbMYE+tSPqfzsU/SNXZ/7WspZibp3M
 or2Tdv4PgyUSIua/UrYypZUKklXKkBv3AR00I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735754064; x=1736358864;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwAQmhc7/20iinCvJzfQRMp1z8tmRm8yghTp6P+8umc=;
 b=r33ewZ9G2dSpcKrUs9j/7aJbW1eYc1v0r80MhLsMHis2+oPnP6gGAr2Dkcntsflymz
 WebkRU9hZieaBjY6y/ppLGB2qkxcB3LGUnkxo789hnATFeDtHW9L4kz60tJClyzD3srP
 e+Prjf8Zi4v0V+IwuKkKDr+Co4gnEFyBABRoezd/ChnplFXToEiq69aF4CIF+Yl3380x
 4/RkXcoHvCxZ3qeJUFw5t4oqUlKu41yy5SrqkMAU3TFhow6L+g264N8rxSTmWoX7SX3j
 VUdax4HViF0kmVeVxbd/spSbeItuDeJfD4+ohxHXp/vrV090wVid0bP6forDJqeIQV97
 NJsg==
X-Gm-Message-State: AOJu0YzxBaiIhXlssQOEddvT+1iuc970MOuY+LbyCTmVV52ONIPCU7pg
 +adkb8nuuIGNyjx2H3V+p9rkPfH5pHYnZ/S03KWibfOumbq8jZYskAdnuDw2Bx4=
X-Gm-Gg: ASbGncsF4stF0aAFxIN6Ah7pJ5eo9patMq8vE8Z19ODCcP/yRfbCqZ94u0KaaEwSUAQ
 jMm+vykUYhvyhqS8ngDe6H0WAduIQVrUgP9Pbu9msfskxpUzmf965As57Unnv6Mc/5ykujGbjxC
 Pw5dVoY424lOaUuBo2cjA4MU5fBs3yVIWuPODTSGupP654Hmz07UTzTzYnaiX7Qf/M+Il8ekK2U
 L8kvVLKSR8z7rnvs1hR8OIGVi2kQC8RIVJwnV0M6icAC0rIoHBWM+6W
X-Google-Smtp-Source: AGHT+IGb18X1dOq38xj0cHJUk4YglvOkkZuuXtYAGaYGeZSzRFkF7N7b+nxpQjh1rN9UuECx5YXDBA==
X-Received: by 2002:a05:6214:19e4:b0:6d8:7efe:f791 with SMTP id
 6a1803df08f44-6dd23345594mr787813516d6.18.1735754063996; 
 Wed, 01 Jan 2025 09:54:23 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb525sm123411896d6.97.2025.01.01.09.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 09:54:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <cover.1734093566.git.jerome.forissier@linaro.org>
References: <cover.1734093566.git.jerome.forissier@linaro.org>
Subject: Re: [PATCH v2 0/3] Add 'trace wipe'
Message-Id: <173575406212.1681845.9114152812004598204.b4-ty@konsulko.com>
Date: Wed, 01 Jan 2025 11:54:22 -0600
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

On Fri, 13 Dec 2024 13:45:35 +0100, Jerome Forissier wrote:

> This short series adds the 'trace wipe' command which clears the trace
> buffer, allowing to re-start a capture from scratch.
> 
> Jerome Forissier (3):
>   trace: add support for 'trace wipe'
>   test: test_trace.py: test 'trace wipe'
>   trace: document 'trace wipe'
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


