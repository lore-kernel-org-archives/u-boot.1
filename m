Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B11C44508
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C55684D75;
	Tue, 14 Jul 2026 19:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qMw3HmiS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC82384D72; Tue, 14 Jul 2026 19:56:15 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F56184D65
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7eb5a9f02e8so2290401a34.0
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 10:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784051771; x=1784656571; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rOwD5hJp81cPpUGzTGNTd+jjCQope8mrfTspTuN1PYo=;
 b=qMw3HmiSxmTbbkQ2MkLFRGYjlArGK72ErO9PJUIzlZ9Hp7pjh6oM2Ea6Ip5IC5qh+j
 C0fnMWgHvwPQUjtsKFshFpTp+TM5WcNgPU/rUWERkQInKoIA8PYYLRSP+gPjCE/Gw8nF
 gAHZQT8rej1mlM3BiQChUvDzP57cGjjQWTom8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784051771; x=1784656571;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rOwD5hJp81cPpUGzTGNTd+jjCQope8mrfTspTuN1PYo=;
 b=qQZGVmm3bd970G5g32pCf5r9c/IL8tRw6cSP9zyG2Sdajah5PCBdmhC6HFueroh0wa
 Z7yvLSmvdKm5AyLXyVjI6anjKCk3oH7MIVpXRGnyUGV2Gzs5mKXrLVg2EG0GCaogFfth
 aerqbnYKip26MzPVM59R9WWfpc9RCWJjmECaIwHzHblJW6XrdoLB2DzgfhEOOe54VCSp
 BYhpwqdqVPIGnxzckCb5Hgtrzn9eJVjFqsjPnto8l58y0oO6TN0Vsg9Z4A70jdWXRnSc
 MpkezERbF5t82is9q0px/54/PqDXKCHOsmK01QhDE1uevPcBqtyTdJ9/Eq7Qs3JUiC8K
 oEqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Z9oshcpXk3XWCHvAtOEKaG8CltEJKMeNy2fjbvUmFyB4XHgnr49X3XnE73A07QgXthbo5ACk=@lists.denx.de
X-Gm-Message-State: AOJu0YxhbZY1tAlcyp6HXoleh2Tl/qNPMsFQlSzmRvNGYak/WxCvWZI8
 o/lZfUCI8MF4gFJEg30o37W/EdSmege4XdLpaPIkE4vlhPYKwszMxmRmMCo7fTIJh7jXzeYWlgr
 CGfYRojc=
X-Gm-Gg: AfdE7cm/tpvYObLD0VyzWy351iArOLlKOHQx3ufdmjo2ConzInO6UtJ2blirJt3ro/c
 SMk5bwcVE4wEZzDhqVo0pDS0xC0gJasclR8Ym5Uv8H2UAazdbxCcTEvWtvST7DE/VXzpXC6M3K/
 Q6lOVID0hvmVnZ+TqIeU/OGSWn381MswhO/on2tNdVXP+lQib+g49Txu0TURicYhKT+xzL3w6j7
 kWrk7sGob7TcrUY6oTyeLA0tCh3iFtWLMN9fJUsr0dCvRMleeiCmHJ4q4Bv+GuxHoEIFZM2lCjt
 /Oo9wUSJfUM186AyUC3U2I0NvM96tJMkh3jBnVCPeo1dUDd7TW0gxe3Fxpe1TUEtjqsXlC7S5mG
 85YK/Ma3bh8yHiKTZtj6pDyDzok49YdkpvuikTNWgjZEep/nrXUotJwdk1aOwM8H8Zlgw/UUMHi
 fEwWGhMxch1B6VoYIl6RFTrNfAwsEqymUKMrx/D1rk+BwUSIg8P3qCrP/ksZrmI3fjkx/ZR1cO6
 AG1tzg1Su9D4849TnK/HCALLnG6GW7gB+SE
X-Received: by 2002:a05:6830:67d6:b0:7e9:dd93:b88 with SMTP id
 46e09a7af769-7ec0981d862mr8501547a34.27.1784051771313; 
 Tue, 14 Jul 2026 10:56:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcae206e2sm15597648a34.2.2026.07.14.10.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 10:56:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
In-Reply-To: <20260701095003.212997-1-casey.connolly@linaro.org>
References: <20260701095003.212997-1-casey.connolly@linaro.org>
Subject: Re: [PATCH] get_maintainer.pl: tighten up git contributors cc list
Message-Id: <178405177034.3971373.5983282106793132959.b4-ty@konsulko.com>
Date: Tue, 14 Jul 2026 11:56:10 -0600
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

On Wed, 01 Jul 2026 11:50:01 +0200, Casey Connolly wrote:

> get_maintainer in U-Boot is configured to include contributors and patch
> reviewers from the git history in the CC list, going back 1 year if they
> have contributed more than 5% of the patches.
> 
> This is well suited to some core U-Boot code that has a long history and
> doesn't get much love from any dedicated maintainer but for newer code
> and board code in general as well as defconfigs it can be frustrating
> for some contributors who do not wish to be CC'd on patches as well as a
> general issue when dead emails are included.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] get_maintainer.pl: tighten up git contributors cc list
      commit: 83f6cbb87177350e32eabcbe6dd92b951dabae25
-- 
Tom


