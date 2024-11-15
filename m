Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAEBD68BD8
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 21:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5878B88E32;
	Fri, 15 Nov 2024 22:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h3vkvxy3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6891988E32; Fri, 15 Nov 2024 22:39:21 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 573F18907B
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 22:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4609b968452so14539561cf.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 13:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731706758; x=1732311558; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWMj9iwi3fYNuYDS233/xF5AOaovinwFh0IKmmVPICI=;
 b=h3vkvxy3/V6yt0o0xUbOlzjmGM2jPTcjoTDYDPJaS1OPqL0t/Y9psp1MzsLavNqsxx
 y80syPR5kkDzPj/jaE+kabDMWfMiQOwehItBKjaBtGbCc7/cWXx2FvJu31ao7siG0bIP
 eCyBdpGg6k7rgtuoYSzmdIQDhJdFcGfzfyEbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731706758; x=1732311558;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWMj9iwi3fYNuYDS233/xF5AOaovinwFh0IKmmVPICI=;
 b=JSkRsTFUquS+3OTwjKwfWaZnJ38AGxuXO+9iiQauhb+0G7gVXstyP1BU/sqZCLBNYu
 FspuVRUfCYHmU5dwOJ0FZTXFkQDXGf5y94bcxjYtU8STrLD6Zi6ElxA8AcP83UAUtIfY
 nNB4JFuaWr5B3maWAJS/f/jqNWXtXOtl7IcB1lU4I7dB0izRpH/PdlvLpS4GaYtk4okf
 xqkksu467f843wAnFqO5/uLFmSzz9JAzQuMtRxf7hcYfbluC8p2/Wu7xy8OCTWWl+wOn
 U9nzntCZIUnsuZeZh5CoFfubd8mVoqTmiFqOlkeJe5slz6I6RQpxU0qawoJRSBf1Lohq
 ouAA==
X-Gm-Message-State: AOJu0YwRH9ubrHACgKnVIJcRD4BYcign8O0+3YTnlcrKxQih+9LZ8wsX
 f7G9nUnZMffKkLPVTvgv+f64dlzQe2LFfsMf7pjLArrq8YmrDuTyXqPT3EL6W1A=
X-Google-Smtp-Source: AGHT+IFtrQa5hZk5v4nZTYX0utIa0l1XWdJfgRKWGsY9WFz2zE6edTQZ/IUDSnluCdwIU8dXxGNLAg==
X-Received: by 2002:a05:622a:2293:b0:461:429b:a2c7 with SMTP id
 d75a77b69052e-46363ec55efmr53470531cf.47.1731706758212; 
 Fri, 15 Nov 2024 13:39:18 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca68b71sm201771885a.125.2024.11.15.13.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 13:39:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Love Kumar <love.kumar@amd.com>
Cc: michal.simek@amd.com, padmarao.begari@amd.com, 
 venkatesh.abbarapu@amd.com, git@xilinx.com
In-Reply-To: <f1492ac88159eda2c9642bd66ce1645ac43676c7.1731676061.git.love.kumar@amd.com>
References: <f1492ac88159eda2c9642bd66ce1645ac43676c7.1731676061.git.love.kumar@amd.com>
Subject: Re: [PATCH] test/py: spi: Rephrase the warning/error messages
Message-Id: <173170675611.2851979.6970677333518929071.b4-ty@konsulko.com>
Date: Fri, 15 Nov 2024 15:39:16 -0600
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

On Fri, 15 Nov 2024 18:38:00 +0530, Love Kumar wrote:

> Rephrasing the error and warning messages to be more meaningful and
> clear.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


