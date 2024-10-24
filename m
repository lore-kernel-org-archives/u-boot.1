Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00006CE8E70
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 13:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 570AF88F3C;
	Thu, 24 Oct 2024 15:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dD95uwEb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB0389266; Thu, 24 Oct 2024 09:38:09 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F07A389092
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2af4dca5cso137532a91.3
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 00:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729755477; x=1730360277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzchIbyH3e/rjW+le9RyG5IgmzMcny6u/xm+hWebQeg=;
 b=dD95uwEbiuKIEKMX5LhLUSgAhzIHmnBjzLM4iM/95Z4k2UWjRV8U3eMtvoF5kbLtfP
 NOsdrPyDIi5qq5wOF6tGOkoxhuM44cfq++lAbPGGDPxJyn8sE2NN26OV70Ec/pbRc/CW
 xztqRHjlUBww/M5K+NJ2jiPipZfRXmQ/ACScit8VIpIHJiKJsvznie+rLHJ2hmfmAItA
 OOeY8xHIG3nEqFo1+FnjEHhLjUCdtj+P/StJDX0sEasfqfwKMSpO0XiuY/L2u56s26GH
 HtszxLnjOUprxGf7m27aAZZu4b3lgRRG5rqXGEVVJRrSDLItl4b2OQdvmDBwvYQbR5BB
 bvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729755477; x=1730360277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzchIbyH3e/rjW+le9RyG5IgmzMcny6u/xm+hWebQeg=;
 b=AowVdyIrxsPi61cW7aga+TA5QN4WOxJOCghIlqcViXD9L0mXKyvQd3p7y5DIyEk2hm
 j30soclQ3J4kV0SKZrQGctx1iZbyy+pD9/BQAX/iMzDndw/nQSZpXfKC9+njclAAFlXl
 CdjXveKFrje5lwNyjq7/F7x9pgKMbVK4g0l9tVayEFNhiTFjPtzKsb8I+CCTR6WIU5WA
 en7cy0VczuQIqWGMovz792z000ofFJQziugRj2HR5/mUqw21RAOpOyTG8fQHUmktfY3b
 O54J5GsL37lk3vrmfbIO6PDQFnePHiJpPysDW2fScgzdtb8r3fqmkXPGTWM4ByfQtvJ/
 oUlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyjE0QS+G1BzPeJ8gbLz/vGRVG3FUH1Fyov8OrAP4VUOW+7KvRtJcvLoQXkOPKZYHQrBU5esg=@lists.denx.de
X-Gm-Message-State: AOJu0YyuxU2PpDrC6O4SW3NhVzjf3m3HvUMQgYlP6xFRcGfaSWDqZzC9
 XamYikiGa6mMwALxXRKHhvyIGnttmEnGfnYPoZKHDGGWGxvMzDaj
X-Google-Smtp-Source: AGHT+IFzSjlJeYdIACcQkX1To4IdwsRqNXE1autVTHvwrI7xeECX3WY4/4EB2PZg+7glE6irzPCIoA==
X-Received: by 2002:a17:902:c40b:b0:20b:7ece:3226 with SMTP id
 d9443c01a7336-20fa9e47695mr31337035ad.5.1729755477404; 
 Thu, 24 Oct 2024 00:37:57 -0700 (PDT)
Received: from rock-5b.. ([221.220.134.146]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd2f0sm67593155ad.171.2024.10.24.00.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 00:37:56 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: jonas@kwiboo.se
Cc: kever.yang@rock-chips.com, liujianfeng1994@gmail.com, maximmosk4@gmail.com,
 ricardo@pardini.net, trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH] configs: orangepi-3b-rk3566_defconfig: Enable
 CONFIG_MULTI_DTB_FIT
Date: Thu, 24 Oct 2024 15:37:51 +0800
Message-ID: <20241024073751.432974-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4dcb2c33-eac9-4f33-883b-95ed89893b31@kwiboo.se>
References: <4dcb2c33-eac9-4f33-883b-95ed89893b31@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Oct 2024 15:12:23 +0200
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

Hi,

On Wed, 23 Oct 2024 21:09:34 +0200, Jonas wrote:
>SPL should call spl_simple_fit_parse() -> fit_find_config_node() ->
>board_fit_config_name_match() to select correct FIT configuration and
>load correct FDT for U-Boot proper.
>
>Based on runtime testing making board_fit_config_name_match() always
>return EINVAL in SPL, I did not see this Kconfig option help U-Boot
>proper load correct FDT. It only made my debug log print out:
>
>  fit_find_config_node: Cannot find /configurations node: -1
>
>And U-Boot proper still used the base "Model: Xunlong Orange Pi 3B".
>Not sure if this behavior is different when vendor SPL is used.
>
>From my understanding your issue may have been because of a mixture of
>older SPL and newer U-Boot proper, and was not really fixed by this
>Kconfig option?
>
>Unless there is other uses for MULTI_DTB_FIT, e.g. if it is required to
>load correct FDT from a kernel FIT with multiple FDTs, I think we can
>skip adding this Kconfig option.

Yes, please ignore this patch. I was using an old version of mainlie
u-boot on emmc which did not set correct fit when booting from sd card.

Now without this patch I can boot without issue when booting with emmc
or sd card only. I am sorry for your time on my mistake.

Regards,
Jianfeng
