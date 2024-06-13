Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13249C27C6E
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BE268893B;
	Thu, 13 Jun 2024 17:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B1GwmrBl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2EF88933; Thu, 13 Jun 2024 17:33:14 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D875988929
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f9b213ebf9so516175a34.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718292790; x=1718897590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uMhg9OvJFXGn82ls0geCugBdoamRlz4PJ8LoFjiXQY=;
 b=B1GwmrBl72xICiRjLYr5P101EGPsfqgi54bl3WEwpDFjpTYxLgApflMC0Rkbyb4pK4
 TtEsSGn1RwCuYog3cUytxdlpJiM/lPv5RcqIsJ+VVHGsmqRwBbfJAKNwi7yOWWB185BF
 TsOm3TritIQZwguVHS+E6tcclXnU2ZCGyTArI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718292790; x=1718897590;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uMhg9OvJFXGn82ls0geCugBdoamRlz4PJ8LoFjiXQY=;
 b=RaOFFtEmqzy+EcXnY46S4LjEF81iJPpXAvPdde3jEfRIpJVRYyfr7tHTCjybCfCFlJ
 W1mk+9qTxB9euDL6oWwJUpKxxaUK+a5WwM6JeNNR1D71N8Jr3FB1WJHKRVcbZGUHhXj5
 GZ/xesk2w91Ll97EyXYG7N7T+eD+Nf0NtCSV/7da4n3hWarwg0sxiy/9ngm8DUHKEhAq
 mXfNGDBMowzCbxD+Ak07l0wTlCjJanEqy8BrTok4b4DHf/4aQ33OHVS1LGsi4EAA6xmL
 xocABUNliuJ3YU6Ey3iRYqWGmICyEIjZWfeQyJKwrE6BatcCzrXihVMHp2trHDvztkR1
 p49w==
X-Gm-Message-State: AOJu0Yzb8L7zeUCiCgZzEgFUZ7V8thxQeg+uFV4h+zJTz0SntmIM54if
 5VfZjWG6cnF4QvXh2eg6dHmlfNTXSaO9SvayuYf3GaZEf6Jr0OOpB+f/CcbUg+15iVG0iJYtrpJ
 qYfo=
X-Google-Smtp-Source: AGHT+IHHHKLsyQlZU1IRwvjDUEvY7sJcZ4Xx3FAJdkCPTeEfKn918WL2Kq06ERQpdYIHfWlE5oPNtA==
X-Received: by 2002:a05:6830:2b09:b0:6f9:7854:29cd with SMTP id
 46e09a7af769-6fb9258f4b2mr106576a34.9.1718292790090; 
 Thu, 13 Jun 2024 08:33:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b84efb8sm250171a34.73.2024.06.13.08.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:33:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240610-cmd-sound-help-v1-1-0c1e13a49ec4@cherry.de>
References: <20240610-cmd-sound-help-v1-1-0c1e13a49ec4@cherry.de>
Subject: Re: [PATCH] cmd: sound: fix help text
Message-Id: <171829278863.618648.3742407116666192572.b4-ty@konsulko.com>
Date: Thu, 13 Jun 2024 09:33:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 10 Jun 2024 18:11:44 +0200, Quentin Schulz wrote:

> There's never been a -q or -s argument handled in the command, so let's
> remove it. This was highlighted during review[1] but somehow still got
> through.
> 
> While at it, slightly "reword" in the help text how the len + freq
> arguments are defined. Indeed, len and freq work in pair, it is possible
> to define none of either, n of both, or n - 1 of freq if there are n
> len, in which case the freq that goes with the last len would be the n -
> 1 (and not the default of 400Hz if neither len nor freq is passed). I
> assume this isn't what's expected but leaving it for another patch if
> need be to fix what happens in that very odd scenario.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


