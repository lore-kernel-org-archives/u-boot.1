Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99996E83827
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 19:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 768E283C61;
	Mon, 16 Feb 2026 20:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qkcg9MU8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC3083C67; Mon, 16 Feb 2026 20:39:01 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D2A80325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 20:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d1872504cbso3148712a34.0
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771270737; x=1771875537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yw/b23ydxOkKrIe+O3aeCBNlycl26Pk+LqLQsPopiKc=;
 b=qkcg9MU87n40JuYxi5yZO07AHuCUkyEnJIKuHKwOyoAq1OKw5/hNHz9CFTSkG0M1KS
 wQfBKCwA5JxcVXYnfgCiArRT46qqmUPDo6r7r3dh5mvfJv237hmjhcvZOVfEmclfYUmz
 AM7ZWeP2PlZqUZbcRQ/tnapjsO0Eo32ct1ZVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771270737; x=1771875537;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yw/b23ydxOkKrIe+O3aeCBNlycl26Pk+LqLQsPopiKc=;
 b=ZXNSfGe/mUnGZXwKhIuqKZAROTsJtgD/uH4gu6EzT5f7Qn5nVl6nZA47l/J9+EbZMC
 IlJeqbeQ4j0/3KLCylPqYe4bht1fl24BW7B1yvetHWW5zSinLYhkRULpZ3crUTpSgtjR
 248CfM4OfgrlR3Fktch9fX57rvutaiDLb5KONSZWlmWMgGpMMDOFl2yJ+1jDruK7klrt
 P7sdaZuGpNOUqh7os63CQAhI6WQ5Z/OzYXaASGidgiHgTURjgMbyCXTA0Ed5Rvb+2dWR
 q1OhlCmAfdXt9MZd6KR+qbrTbM/LLVLa2kDsO8hWK+FKHPkgj/3E6M4zFmwpYOsHXNC/
 Y0mA==
X-Gm-Message-State: AOJu0Yzu5IUddhTX+mrgZ+wf4cgHdMwGgxck6tmD+sHIow7gbLojbt9x
 kWJdQOyVi/k3Yt/BSk+NSxekWBXJGNAsbMi+BwVfJmO9niqrArAKbnLFOKvJ53CIeCQ=
X-Gm-Gg: AZuq6aIQWfvKK8ms1SPKNZ2Biw7hWy4TAF7IBmkHMN0uEWz2xz0PwJvdFMbFqfnnV2c
 JZpgMyuHBJ4zQRghqZnnBex61yYS6ICLLXuNXBUPVTghwo9sG0+ugf6R+FJbAfPySb/bEUG954t
 eOSsnPO1eg6ckhA2kvyOLNB3NGtUPETld7+PWKD9o8WJTfISPdFIDkRNIgdQkUPq8OirHzIkHw8
 XUdkVfuig5N38nSQohQqrClrinoDuM2nY6Czh9UL5CGHwwiPRyJHhR/L/dQXvoJvH5FBi+10nDZ
 K6+c8k42qIG6ZHkrI+SCrhrYiDHiKkhYdR3fJy4MsE6plxvUN7CJcY7mKL1Pi39pjhOK0ckpA/J
 4gJPIVpToTmCH4QBr6rj2nFzBj6bzUThPnCJT9t7Xz/S+KhiI2UrxiZSDYUlJwVJNX88dHvxAzz
 m4+t7An/rG+K6I8nuSrZ86D2YMp3rUia2skZTyEDMsnJNd2T3FikiPW9NuPpKC0WpplonPibZns
 cUXVgVcyn+zSNEPAIKCriAa43CT3NEYnGRUbuaQjyxiHbZR6A==
X-Received: by 2002:a9d:798a:0:b0:7cf:cc66:6df7 with SMTP id
 46e09a7af769-7d4cdf16ed6mr3992149a34.9.1771270737685; 
 Mon, 16 Feb 2026 11:38:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f9483sm14142543a34.20.2026.02.16.11.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 11:38:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
In-Reply-To: <793a4158-ba45-4d1b-ae8b-3177fae1b4b9@gmx.de>
References: <793a4158-ba45-4d1b-ae8b-3177fae1b4b9@gmx.de>
Subject: Re: Pull request efi-2026-04-rc3
Message-Id: <177127073698.2634449.9094812104958109088.b4-ty@konsulko.com>
Date: Mon, 16 Feb 2026 13:38:56 -0600
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

On Sun, 15 Feb 2026 10:07:34 +0100, Heinrich Schuchardt wrote:

> The following changes since commit f9ffeec4bdcf1da655a0ffea482062adde78fee8:
> 
>    board: toradex: Make A53 get RAM size from DT in K3 boards
> (2026-02-12 08:12:09 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-04-rc3
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


