Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2661ECD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 17:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C60584926;
	Mon, 25 May 2026 19:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lIRCo7ZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CEFE848D2; Mon, 25 May 2026 19:01:28 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61522847EF
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 19:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4824b15c19eso7968034b6e.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779728485; x=1780333285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9s93pRkDMMKAxoZA8wiSmH/plKTm+tKYlGxlyDgFwA=;
 b=lIRCo7ZEl5vpwQKia1yvsBFv0vyhnqN3PBivb7sWVo85vsaLOMzuOxqxP0fhfygE14
 KAsOHPfORKgRsdjVWszgNNo5+6PUAXm+/PluFCRd4A9K0uPNYOEzJZ7Y5PKrOFrJUwRs
 p1lL4Jw1GYbh/tF7bAeXFWPEXqLyV+9SUHpj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779728485; x=1780333285;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L9s93pRkDMMKAxoZA8wiSmH/plKTm+tKYlGxlyDgFwA=;
 b=Ff0yk6Re6/HClveJpYOkFKg5Kt2O+qpfd7viJoaqoPcyj2QB0ghrvxJvH9n8jPHipe
 ECPk2Tv/5VgD2dYQMwuqTcBW/dgtjK2RpUzmYhrUgh/tItjXghtsRKp3LoyfA/SPkUnE
 yYSZlcQQ+xH8nebGHVlTHQzkEX/h7HAqXTk7uI8Mb1iRbOnlVBowhbC1tryuAJGUrLTs
 YHwV7d/IgAyO7iBZv6+mXCnlZ8kr+P7Un5fcDWQ/2c23CGarB6PpR/UB7q5espNSkC3W
 EkdhskMk98qUeRJvX0jq2yfnTcyy/Jo51XYY8MG9n2O6Xr73H/L1cHMPdQiRmXKvxXgf
 2K1A==
X-Gm-Message-State: AOJu0Yzuxttgel7f5/0RqJ5fdwa2VB8rltAXPH3Pm2NBloY4rvhIN1Tt
 QXulgVPL5m0GPzMTlVMuw6AVM3Ntg8IFjRX2Rd9bbuk41VUnxYWyqFJ7ULxMI2kAz/wS2q3U4YN
 eQsKCO5I=
X-Gm-Gg: Acq92OHnraopnjCv3vvpOJ+6BlWn/wOn0FwBqe2heqXcMuOVb6eIuHM7/HELuy38YNq
 XZ5FQBUGiClhzqAu6A9uQ5rFZp3DLov6/C3xLbgm+yIaPeO+L/OMa2vwrqZYaS1bavaK3+3B2FS
 6/MbOVj5tIM3rSoldSezOwDok7UT/IrjvNDey0yHQr1MgEeXoPDoRwTvUrcFaotaqbE5LWlskfl
 qvFaZugJsWKI30FKmGvFIVCgI9l15lfPHzUj7p17uXA8RfUBnnBEOjd5+yrDUewLNDUc7VkT/Ud
 Y1Ctd5f13XQLviMyWm2MpsCAfwHJD5pX9fpNxIsy/Z9aIy4CAbdiV/2crp/s02JVsFVMPL06/A4
 u7PiWHwJxDp4gUtfKlYf1Y30aysMMpYgpkaN9GCyLscQ6v2QnXjPPOhvEiJ3jDfjSbBdTGmyHwa
 JA8pAbn1AYl1YniAFa9755ytRDSCuOnhr2oTp2TUYmWGfahjVFRBWLjA4N/vLUThNYFckOsPUb/
 NoYU67lKuCcKiB8G+wU1/cAymGUa13lP7IDOrFCZ6JgRXgaCWilDOA=
X-Received: by 2002:a05:6808:4f53:b0:485:4396:91a3 with SMTP id
 5614622812f47-4854a3b9ed3mr8750326b6e.30.1779728485117; 
 Mon, 25 May 2026 10:01:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-485546edd14sm4993136b6e.10.2026.05.25.10.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 10:01:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: ilias.apalodimas@linaro.org, sjg@chromium.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20260515054327.1033466-1-w.egorov@phytec.de>
References: <20260515054327.1033466-1-w.egorov@phytec.de>
Subject: Re: [PATCH] Makefile: binman: Search board directory before
 srctree
Message-Id: <177972848373.683406.4436694334448325103.b4-ty@konsulko.com>
Date: Mon, 25 May 2026 11:01:23 -0600
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

On Fri, 15 May 2026 07:43:27 +0200, Wadim Egorov wrote:

> A file like rm-cfg.yaml accidentally left in the source tree root
> shadows the board-specific copy. binman builds the wrong YAML, the
> resulting rm-cfg.bin may match a different SoC, and we end up with
> the following error:
> 
>   k3_system_controller sysctrler: k3_sysctrler_start:
>       Boot Notification response failed. ret = -110
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Makefile: binman: Search board directory before srctree
      commit: a20893480124414befecbc0200cb329a0fdf094e
-- 
Tom


