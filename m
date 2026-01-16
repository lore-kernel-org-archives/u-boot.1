Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FE4C982D1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E9D9839DD;
	Fri, 16 Jan 2026 18:33:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GEM3nHd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E79F8389A; Fri, 16 Jan 2026 18:33:04 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 144FA8367F
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40423f8c5faso1546713fac.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768584781; x=1769189581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7H+Pv2UKrxDe8hApuYHyc7kOx40lFWmASZ1Pc2yXOYQ=;
 b=GEM3nHd8phYQAmtGJU3wmzPnBHhzpS2OWVm/4bu8RxXWXEKD/j2OcV47atdFrGPN6P
 SvDrgUl3K1uFmar9RC4/aBp/pqLiQiygnCoASI87x48aYy9LgZq4XPfj/O/Xj8VUB3iW
 6rcx1XM5qPxpMUYtkVhPRs3cXd+BBLL39B3kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768584781; x=1769189581;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7H+Pv2UKrxDe8hApuYHyc7kOx40lFWmASZ1Pc2yXOYQ=;
 b=UdY0wbrsAiZNGbdpJUBdqxL3eGx7Cxv+qNnjunhEr8Z2Im8yvtUefNieVJ/751um+E
 rBYmcR1rPrqMmP3nguMDJLnqhORDjzoZ4XGMP9/lBs9UAf1EqE+oghq81qhELOqYDgbk
 GTZC7+/velkUuMTyLZj+q9WNaqX7+1bqF7kkb78J3K5BgDhNcEEsfwEvFwNpYPz31gTE
 XZWzm6d1BlTa2fG7gNl3Pl6LBWxdlL8IgxJ9ea9CktYnHWiCdLIYpuubAwYe2q7iU4Ng
 9KaShkV1VcHC3Ku9wJQ3NcQSoKI42DmsUqn722sE4qsjA6dUA8HejpxKwTY9HDFCG5If
 NMgQ==
X-Gm-Message-State: AOJu0Yy41omUPSV+v6mL1HAnc0Wjzv0//YNTJr3RxmVqQscF0TTMgIlT
 XKVPT0ZndM9Rqyb70tC6kj9I4oRxMUVQLdR6syJQFR80zFSj59UR7eSpNaQ+9C/UEsuOJUmMhXi
 roC/i
X-Gm-Gg: AY/fxX4jh5CmT+xPP/YWiztzytDVSQUFqbtN9SjX5676hv2hlT1j2DTw9r9Y0XalMql
 JmQ7D7/Id2BzgDqQe3sfTwTo91zE4pxuaAzHC2/FAHUYBiGwf1nnHMepmCRUwi7ednjlERI/q85
 /BHJcIvab+4yZgHsKqk3nNL8oz1CsUBL1nJao3mmheZLIzy+JZLihh7KrT19eVxFMTguQchaY37
 W53F99oBuLUifswYM85GXRkZxCw5nJhupdUtmrurt6nieo7O774Am9DJLNzTWeL0p2yyGrDjhIw
 bfZBAvVnoUWhixe9GHXFW3Kdo5bzVaaSi3LTWFu46QiiUJ6C7WP1N8u1Ea1rCZALPfXJFCOwWw0
 JRKjFiy+gant94IDuXNMXYPWc5XAly2JwbBveljeER1C3Y1pmZg50Vk2nVOc4O1vBzbj6d3yxQc
 rG1KQBLsYpbKZoxbpaveIW9KJp4dTfn3/CjX8JpgskVJfQN7yQKl+DA4nmUOuePEJ9oBzMUKRv+
 pcyVh4N42qWbz5/MStt2SmHGkqIjbBWhzeK2g==
X-Received: by 2002:a05:6820:6acf:b0:65f:6ac2:785c with SMTP id
 006d021491bc7-66117973657mr1649883eaf.34.1768584780768; 
 Fri, 16 Jan 2026 09:33:00 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661186ca7aasm1494068eaf.2.2026.01.16.09.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:33:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Francois Berder <fberder@outlook.fr>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 =?utf-8?q?Petr_Bene=C5=A1?= <petr.benes@ysoft.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87sec5d21q.fsf@kernel.org>
References: <87sec5d21q.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20260116 into master
Message-Id: <176858477997.4075554.12203380251943615160.b4-ty@konsulko.com>
Date: Fri, 16 Jan 2026 11:32:59 -0600
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

On Fri, 16 Jan 2026 16:12:33 +0100, Mattijs Korpershoek wrote:

> Here is a PR for master
> 
> Android:
> * Fix missing dependency for BOOTMETH_ANDROID
> * Add bootconfig support
> * Add 'get ramdisk' command to abootimg
> 
> DFU:
> * Improve error handling in dfu_fill_entity()
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


