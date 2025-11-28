Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161E8D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666ED83B07;
	Fri, 28 Nov 2025 17:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XiVoHJQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 131E283A7A; Fri, 28 Nov 2025 17:25:43 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DDF3839B7
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3e8317b1262so2099398fac.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764347137; x=1764951937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3SpsLQWs4AmOTjutV/YCRMPiO24iljhhUvLgaMGGNLE=;
 b=XiVoHJQoLxdr4aeYPtnSnhm8OAUOK1/G7l1bSeeH4iW1mv2R+IEJ9zttJXQgnqccir
 Wh4BwBNpXwueYzzgr33SU+BktivrEMcNQ/EyLoI1gEU7VPz3Vwh9+EHGrzfDbaYATfUc
 OcsJOWPh85x+zOJmwTE2Y11htFDYnIXAF7rSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764347137; x=1764951937;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3SpsLQWs4AmOTjutV/YCRMPiO24iljhhUvLgaMGGNLE=;
 b=HwaMGYCIi/w6XxVSEq7/uzq2FhPkFMHGjppLo0f3KTLXw7Zdm/32U5K72EhRTjuq8w
 K/GCFDfcJ1r1OvXj5uhG44EV5DQFOWiT1cjdj+ErzMyEHiqZ0tSUbc+AqA39ynBG0ih4
 Wb2l3/NlBzhGfnP90Kb25KwUTIcrbWtA3ebUKQlr74zcmQ9wYNLtEJ19lfB8bZ/OW47t
 Y0nKOapSS5XvhnhXPXz4ehK4sxago6SXnSDgzkQKYM4uWGZPQqiaCOBdBWpB8XyyNfOn
 A5WwxdBRqzZ4Bacyd960+K/s5/LyWk7rQUfu5FjUhYPQgFUH/6KdcgPojRYWl4lsM4Bj
 WPGA==
X-Gm-Message-State: AOJu0Yy0NcuwXuG4TNkV7X8rY2v17ceM8YLCwi0LygdwbeIJElLyT4da
 SMMUogOJ+j5jhyNUJoaXYf7KQ6vXoBT9FOcGz0q1/cgwFchO/5+aAUK4H/jALJJ/ERpGS+NeXGA
 xS65VdTw=
X-Gm-Gg: ASbGnctuNr7WM4kIYKuCirgF9AB0e3LV5hw2ndfzv9QNUlV62O60ODxxESB5LjU9AJa
 9p5mrd9+oo9Te2VkcS8N0uhMK1EJxS0tG3e6DadxzJZ1F7rv0WGw5tztImZR88Jl/0t+sOoxf3q
 6NzL1BjZMMXEluo+2G9uXAd+3w1RNh8A+2/RCZjCdaGgybJLxq2SNofT9a6Se3Qrj2VdzoJQo6k
 oOvs26kYCFXemj7gIaLkNMG/WyYCoMmuJDx7Vd5Jqq1tem+gD8w6Relkghzm9E2qGlq8jAn8cVT
 ENeVIBtjIMGo0MGQmWlYGi7eaZ1oDVdjGzYF2q8kRc/m+uC4/i9MuzOtvv9wnmc2kGEErK4dGIO
 dX1FNPdB/E9ThPHRszQ+gr5jWAXE+nGIRkDkGPq6dT9JZJD0FDUT5fqq9MUqn30BxKE6Grlerqv
 AJ86WSKoaJfT0pvV1pKy58F80vpXAhb8zX1DIOvUG7Hcup9N2+
X-Google-Smtp-Source: AGHT+IEpU1Yaq7ebkSZeu7zoMx5MqfdwetMWDR3a8E5LTQAR7RjVZ+zSZ39ZL3QimHYiIHSLVVwI4Q==
X-Received: by 2002:a05:6870:b50b:b0:3e0:b765:dcff with SMTP id
 586e51a60fabf-3ecbe2b882emr11888478fac.5.1764347136840; 
 Fri, 28 Nov 2025 08:25:36 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dc9ff3f3sm1973682fac.2.2025.11.28.08.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:25:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251114215447.2395858-1-trini@konsulko.com>
References: <20251114215447.2395858-1-trini@konsulko.com>
Subject: Re: [u-boot-test-hooks][PATCH] labgrid: sunxi: Add writer using
 write-image
Message-Id: <176434713590.219281.3644252368337401019.b4-ty@konsulko.com>
Date: Fri, 28 Nov 2025 10:25:35 -0600
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

On Fri, 14 Nov 2025 15:54:47 -0600, Tom Rini wrote:

> Labgrid has the ability to write a given file directly to disk. Make use
> of this to behave similarly to bin/writer.sunxi_raw. Note that since
> labgrid passes "bs=512" to dd, we need to adjust our arguments for this
> rather than bs=1024.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/1] labgrid: sunxi: Add writer using write-image
      commit: 1011d7e5972e585b50ee574f7d15db25b5c5bbad
-- 
Tom


