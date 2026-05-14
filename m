Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83270CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 23:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDB168469A;
	Fri, 15 May 2026 01:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qDtjDKl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA67D846A5; Fri, 15 May 2026 01:15:53 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC93F8467A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 01:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40946982a78so3115079fac.2
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 16:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778800550; x=1779405350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ytfgi/PorBjmFVpylbBqrGYQ8Efj1EWuHroDWhACiug=;
 b=qDtjDKl+po3xrpjLMiWMOLXTM1NzBE/9JhwmQj+SZqM99Cv0gLilAHQFs0AlKNNNcQ
 QxpCQEh6wYQf/DYyWsiqnKafzCbitijJTP6JX87V7WVafD18l793HouOA/d4tSgFP619
 k1kibonQm9ZEUxZ7jf/3rMqlFqNGssAuAGqbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778800550; x=1779405350;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ytfgi/PorBjmFVpylbBqrGYQ8Efj1EWuHroDWhACiug=;
 b=jBE+8kWopc7yTf2oMgDsfFovxs4AGzawsw8w3mum6+G4PnVzSjzR635Sh9BIGT/Zjx
 PKdLLybWDCrYAEZfN80GHgZ3w19O8mjFOqTk3Dw28Zjaj1gS1xj3kLORJ+Z4fCA4R0gS
 CveuqgX1Da8X1KydfQQiy/+5Z0GeoGKDn/IRcG1ei5eoLHvQHhr0WDDTpm1HHdb8CT4v
 mOk2uMgB+OZ93x+s6OfqsPLBSuuS9TPQewAy9lGj3iiYb+HCiocHw/XvpkoksN+05J9l
 ojaPsqfjo86OPNUKGAIe+TwWHAx1tXlmWSi5lhE7FDPH+1ufNvursVeWtpWcPu24MQdF
 RLUA==
X-Gm-Message-State: AOJu0YwvQI1DXZR/SfuMQnD0UdfzDNAO3OxEMPBhDUUE49hw/QdCtCr9
 54txa2VtQPxEIKtfsC5y8beGPNzIYZZRdJXaQLSKnYCxuFR62Ud0WbbB4wSO7c5mrQc=
X-Gm-Gg: Acq92OE54M+hXpBilAm0LKYEdD+bFs9UTitEGe0wF/qCv/g8JgCHO11uh9gFWYLl9oM
 2TRz9ez3ZvAgmJVYJXUsE7HY2u143yOeLUTIN5Burkq0kfwEuMbF9eE5y2uTMv4Ir437JE/wdmM
 DWyOVu/o6weJWFgUZUuUYI3uK3fJ6FDNjza5tgWpet8/8QhAgpX4LclZqoH8SLXRUbqSt1iFeZi
 COu7g7RgKaQX5D7nG+UHFVmimRxgJg8YSy1NPUeaeEvBBbCJUpOQhpdxsM2wM8VT1RoOztNMia1
 0V0JjQMnhYBe0Qy15WRa1VSRXClBf3baZcIz41z66ggrCu9Z0/+WT+r/6+7Kc9VUziCl4SR9b2B
 c8z18UIUJhpfT7rmm+HYtQpl+pncRfmvJSUo1JhS+RY4cA6qJx5mmsaMeP9kSxYS7ZBpkWXtohX
 a6CoRjx1V2ncr5/sdM1N6+zuoBFszQAwo4O4HM4+oJaYt2voiwWDhxtPu2sE//HYwV19uZF8FBK
 iBMxoCU03EtU8WL+8hIEsI9RAh4/C08tsfyRpQvhvhqxycZew==
X-Received: by 2002:a05:6870:d0c9:b0:430:7c2:9a30 with SMTP id
 586e51a60fabf-43a2da7596cmr1233236fac.15.1778800550523; 
 Thu, 14 May 2026 16:15:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc144b86sm3020885fac.1.2026.05.14.16.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 16:15:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Cc: Simon Glass <sjg@chromium.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20260505042530.2965678-2-ronan.dalton@alliedtelesis.co.nz>
References: <20260505042530.2965678-2-ronan.dalton@alliedtelesis.co.nz>
Subject: Re: [PATCH] rtc: ds1307: Handle oscillator stop flag set on ds1339
 chip
Message-Id: <177880054972.4123088.3972480568071998354.b4-ty@konsulko.com>
Date: Thu, 14 May 2026 17:15:49 -0600
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

On Tue, 05 May 2026 16:25:31 +1200, Ronan Dalton wrote:

> Currently the oscillator stop flag (OSF) bit is never checked or cleared
> on the DS1339 RTC chip.
> 
> On getting the time from the RTC, check if the OSF bit is set, log a
> warning, and clear the flag. This matches the behavior of the DS1337
> chip.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] rtc: ds1307: Handle oscillator stop flag set on ds1339 chip
      commit: 46606025225274b065490daf50bd58defb6b6659
-- 
Tom


