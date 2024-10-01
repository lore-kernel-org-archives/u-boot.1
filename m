Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC88CCE7CF7
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 08:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C124089177;
	Tue,  1 Oct 2024 10:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KkTnJcEP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC3F589177; Tue,  1 Oct 2024 10:56:10 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A88878917B
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 10:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb1758e41so38716895e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 01:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727772968; x=1728377768;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPYnEP6r7NeDstVnKAC7nLURVWB8somVZhS9DoSmpFE=;
 b=KkTnJcEPS94ZA64GG3N1yxem0nfwURHJ7ThZS6uqZCh/0MrqSSzfIXRwMUFB+Cc5+M
 Q3YWjbSV7hkilfG3Z6AQVP6pDQ/PiF14lgWa9vR7Afxb7Tr42WMbe4BojXT16UaQwSQc
 r2u68/NdNzWrXhmzyJXgj8vqKKblUqB6Sl7TU+4KgPq8B1ZUhbJtOJNesQeIN+zdBLgg
 cfzEe/fICxu6ergZJjG+mV1AyTGYVE726w9LFqTE8IWNBIDtpdibliMdTMMN3TkqgV6K
 0Y3z0D8KmPZinamCbotgq8qBaBLQW/uv8DCMrWphb2pKXHuIF/dCtGA4BISkjVswM5Ee
 2ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727772968; x=1728377768;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPYnEP6r7NeDstVnKAC7nLURVWB8somVZhS9DoSmpFE=;
 b=kTu/7+p0rHZxTrjNItStRmfMQYEbN+2vvuYypdHA0kbcMa9SyjTyHOqGNeX5del9MQ
 jFOePTS8Ac3+L14x2WVcs57slzMj/owvhvaaSZEtJYk+BNIXVulo+h01Ib19JG11tB1B
 F6T0WO6jYlWskrMMmx5Oo9Y+AmTxJiCq/1sO+63Oij8Ftqe1l9voE3PiUKZpMTg7IecT
 k3dTJX/Ian37ae021kvvemXhHHCfY2njJCqVTzYRaCPFCJCes0nsjWfmcRPR6Rk1vGeF
 uGs0ta8dt+5LSf5gshSa/1QEijkSJdw5RCWE/kE3r9jAE8e+kmSXkQx3ZRsLRzJVaX9X
 yReA==
X-Gm-Message-State: AOJu0Yy29vhEVttoyR6DuiC+bjjJDoynr9ri3tGV9nN7Qm0/KmKzVpdi
 5DjVIX1vsQkC4Wo6GhHghARzYO3DS458ybUiNUWgcfBHGBLMQKhTMFoDCIexlWU=
X-Google-Smtp-Source: AGHT+IEMOQUgxvgEcje0wBsyjUkrVZWjjTypLuM4MOEORepHXyNtPec23YVPkYXu5CGUya3yqhXkyA==
X-Received: by 2002:a05:600c:1ca4:b0:426:5ef5:bcb1 with SMTP id
 5b1f17b1804b1-42f5840a012mr98072815e9.6.1727772967984; 
 Tue, 01 Oct 2024 01:56:07 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57e40ab9sm126464945e9.48.2024.10.01.01.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 01:56:07 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240911133900.1444083-1-rasmus.villemoes@prevas.dk>
References: <20240911133900.1444083-1-rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] dfu: define a callback function for the dfu_alt_info
 environment variable
Message-Id: <172777296703.47811.4486590659666115846.b4-ty@baylibre.com>
Date: Tue, 01 Oct 2024 10:56:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

On Wed, 11 Sep 2024 15:39:00 +0200, Rasmus Villemoes wrote:
> I'm trying to use dfu-util for bootstrapping an stm32mp board. It
> mostly works fine, but something goes horribly wrong as soon as I make
> use of the ability to run arbitrary u-boot shell commands. The shell
> commands themselves work fine, but the heuristic "dfu_alt_info may
> have changed, we have to reinit" seems to cause the board and/or my
> host machine to go into some bad state, and further dfu-util commands
> fail.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] dfu: define a callback function for the dfu_alt_info environment variable
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4b17845529f5f0c94fe68c2daba1948d0ee41bb2

--
Mattijs
