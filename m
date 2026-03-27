Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086C610F2873
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 23:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B0A83FAF;
	Sat, 28 Mar 2026 00:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cPhTClr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FFC783C14; Sat, 28 Mar 2026 00:06:28 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B4283C5E
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 00:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40ea36b56b7so2128042fac.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 16:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774652785; x=1775257585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zji4DyEzKD3hDTaSPW6OQ7Pv3oeeeYF99iY/j8/AYMk=;
 b=cPhTClr62r4QSNorv4NtUU8fDdp+it58iC2Z++D3cF0o8jkPiV9nI74dT704W5NBdS
 GIVwyNC//OO8nuhQD0xh8XX0vS+oVsevAKXp+JryriE6ddk4NYTX1rnH2Hsf2lkOnhih
 gp5ExKwto5lT/yUm1mkWVVxqZK5MGIDOhiBL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774652785; x=1775257585;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zji4DyEzKD3hDTaSPW6OQ7Pv3oeeeYF99iY/j8/AYMk=;
 b=h3PzA6RS5U2uW12zj1LliO790n+ZWatustUIWtG/Or3OeYW2vUble1Kp76e5eOFIO2
 W8mdfQjG5I66Y+rJ8Tk4qaxXNezn+ED01XfiW+FdukAKy4285QobU1l50nmDUG9l652l
 2jVdd2GXXFp02iJhX8mBiOEZ3iB883J2wmPT2oRJo6MUroSMbmcXBpAHoHjn71JQMwKA
 8oM6UjNSHOXCzDKi407ATQOmzK12dXSNXOCorUWhuz3h629SpeMTalEINYjpfACE0wYR
 Gh3HTH5EMhl2Wiz0ZXFMqMqOn/ivE3iHYBCC/CN8UyHgz80K5nSuM2TVGCzcC0USPAVf
 3AIg==
X-Gm-Message-State: AOJu0YzdMHC0hj1cW+hXhmhBNs/RKM9MSc6xEGqsNX0b1cbi9+Zipwld
 n05QI9lmDTmsDNy7jJqRZvE3SqWMgroPVMyDUtdLGAV6WBiW1OIFNudOYzFQ82YoJ9LihR9CwTE
 ajKnP
X-Gm-Gg: ATEYQzwBjN/1QelWT3OidkZPGLnGy9IpAJXBhjTJUML83yArptBEdh/dTXfJWi8CQAE
 pbm1kZoLx7QLD+bHu889/Tps/QiIHFQeouwQOHt6yJxt2Uu1BXjXtTJZqfkPy/nsAgfNoxM946f
 V0l8kRS4ibmKoDU9r8LqD23rCZqvq/KvbKl02EPUKLaSnMjnazEsvbccUsgaLC+1SToVJ1pZHuj
 JvOCQtRTNquQhzKmJsZqjK86pwNGnl/PPMaAHLCin+v9mBuu+V+aBQNTJcyyVYwbN2X56G2jSMZ
 bX84Rutjf+B8lRNl71xBSGUgdJ7nYLZK067QdLh60VyW7ke9GThqqy2Q8lmwhcZthU7E65dGq4s
 7X3ne/howN+wPZ9iv0ZP2amdANgFLTbPEK1TbhSuf6nWxHcnLWepq9ya2vRrKpQLrru0wKTI7i3
 C2+dqOMlvAE+MDuScEJZpoIW59kiqdREgp5dGxnXXf9/2eqSJVlqWSDIQl0rFQF28Io0orsaCK+
 vLyWZZoh4FjT+d1/G0VQUT6M8vXqsT2tuqgrYdCf5CiZRg=
X-Received: by 2002:a05:6870:bac4:b0:417:629a:79cb with SMTP id
 586e51a60fabf-41cec2cc539mr2310698fac.30.1774652784625; 
 Fri, 27 Mar 2026 16:06:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d04cf9e03sm421650fac.14.2026.03.27.16.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 16:06:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
In-Reply-To: <20260310220619.1762455-1-daniel@thingy.jp>
References: <20260310220619.1762455-1-daniel@thingy.jp>
Subject: Re: [PATCH] fs: fat: Refactor dirty flag handling
Message-Id: <177465278376.41705.5830607433446577112.b4-ty@konsulko.com>
Date: Fri, 27 Mar 2026 17:06:23 -0600
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

On Wed, 11 Mar 2026 07:06:18 +0900, Daniel Palmer wrote:

> Refactor the dirty flag handling a little bit so an inline
> function is called instead of directly stuffing a value into
> the variable.
> 
> This allows variable that holds the flag to be completely removed
> if its not used i.e. CONFIG_FAT_WIRTE=n
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] fs: fat: Refactor dirty flag handling
      commit: 29cb951e8ca6a9feecd920da31af9f18918057fe
-- 
Tom


