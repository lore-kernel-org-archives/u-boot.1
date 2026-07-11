Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774D7C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 00:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A752A84AE2;
	Sat, 11 Jul 2026 02:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NgyFFJFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6756B84AE6; Sat, 11 Jul 2026 02:17:27 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 587F484ACE
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 02:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6a384e29a20so1062693eaf.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783729044; x=1784333844; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=75CwTibYAIBKqdJ0vBD/kL3j0NVRoOu0j3yRSzGLXdc=;
 b=NgyFFJFTrXsGzdpsBDjT0tNmbsutgMh5en4e1eOvNMI94Ueu4an/f4ILNzsYvgjcVg
 51mLJbcB56PF2pG8Tv36mfAAbTQDyFV1JGG+biZgQtnghlCzFDBoZwgwTQKmnh3x3oAI
 ZyIK1e108opuLTEKTu5sHxy2sCqlFjfbPuQ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783729044; x=1784333844;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=75CwTibYAIBKqdJ0vBD/kL3j0NVRoOu0j3yRSzGLXdc=;
 b=UIFjlkwqhiOI63kKv1O1Vo65L+G4mMooRzGlJm8ftl4QaHAvFjz1RyIOYEDBBS3OdD
 VQUMlo1drvB79Mmru9wXv52Tf0ko8Ik8nibqq7mCBz6cspfbUyRGSPzhsWln81Jk3l1I
 BFGupwOtwyBudQhOGQEaQm/1McDi1tvZZZYFaaqBAHuY0IPVl9oC902x2unvAZfkPAX3
 6Ye93dUSyph0Fxy2D14P9TLMmOAJPBEJCZCHHNEBfhMSMSQwQlBap/95i8RYPhGhZI7f
 Vmtlxzb4K4o6Q0E6uCU4I7OkMamnPLxEzp9DZH/OHajYfJ7qby7Ac4ALh+fTTKdk5F09
 HTQw==
X-Gm-Message-State: AOJu0YxVdnjuHn5Ng68QeagqIAu/ABOGHylUjmKgcAVyoVBgRLDge9b7
 OQRz4asOXo8DfWxCEm0DwLJVm+bUu4QOD7Xi+Dqrt5Hb0CLy7tlJDnGZVMxlDA//J2w=
X-Gm-Gg: AfdE7cm/oaN0y1BcFXLhWb3eiLAKMEflzl83NMhnDpsaVvfgovBosDOaQWz+dFJ+axw
 Y6MAbFn8QloDQyxBrYLosTzfW+sgj3427Dg7hRa6Vt+9iFjf5IkUqA6swH7eAkTWyU4O5MQmRGs
 wSz9asguiMT3pDWNaadWt9fjnUbI/DEnTAXg7WCiAOPwjTlp09NwRovbPCfU2wneEDa3ouaMzuO
 iAySplr5rTf8g+9LgXioQRjFifNrl/yB5m3qAah1cDSOtdbYUOj92x0Er+GHcqko+ZiZxskXVDt
 B3LXqFNmf0cCIVD1r1TPy/JrRXRJJCk6YLo7tyiylK3UBI/vSyJ+Z8g1MHdvzBsO/rDyV9AaONR
 K7A/EFSPi9yopljweK8tced0+3tJKvJg4oMuYW0C5AcPOZVfusFHllQzg3jFeX4QVOuouX8zcfB
 SdCQRyounWbuKf6ttzWyy/NTW+4ySepQnNrv+JMKM/zH09CbZJJ5Q0Paem4a1G5g3cISytgnCxz
 hyzL0jSBqBH9hsgNmZwVWcU2ox4OnhuIZIy
X-Received: by 2002:a05:6820:f00a:b0:6a3:7ccd:6616 with SMTP id
 006d021491bc7-6a39a6e052dmr776823eaf.39.1783729044025; 
 Fri, 10 Jul 2026 17:17:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a39af0e953sm651312eaf.3.2026.07.10.17.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 17:17:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <pkrfunq5wqzbioom3k3xw7vsxmahlskafrcczcoefqviaygvbi@z5grmsndxzly>
References: <pkrfunq5wqzbioom3k3xw7vsxmahlskafrcczcoefqviaygvbi@z5grmsndxzly>
Subject: Re: [PATCH] cmd: host: fix duplicate device_unbind and wrong error
 message in unbind
Message-Id: <178372904322.2905849.1810299103184537632.b4-ty@konsulko.com>
Date: Fri, 10 Jul 2026 18:17:23 -0600
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

On Fri, 26 Jun 2026 09:16:46 +0530, Naveen Kumar Chaudhary wrote:

> do_host_unbind()'s error handler for device_unbind() prints the
> misleading message "Cannot attach file" and then calls device_unbind()
> a second time on the same device, both of which look like copy-paste
> mistakes left over from neighbouring code.
> 
> Remove the duplicate device_unbind() call and report the correct
> failure with the device name.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: host: fix duplicate device_unbind and wrong error message in unbind
      commit: 9df08fb181de1c02eec2d74096e14252d779a134
-- 
Tom


