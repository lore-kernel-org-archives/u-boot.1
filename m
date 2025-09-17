Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C018CAC599
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A81D83621;
	Wed, 17 Sep 2025 17:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MssHJ+3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0043583678; Wed, 17 Sep 2025 17:08:18 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29CC83631
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-750b77699b4so5155645a34.2
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758121695; x=1758726495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24mW39Tw5LGt1WRj/sJfTeLvjgYUahueE8kA2aATp6c=;
 b=MssHJ+3M2S0RBAOQ+kCxWG+c8BhZeGKbzy9thLTuR09gIbGI/nhZFGgkMeDAbW4Ls5
 umtaS286Jw6dEeSCyyqWOF/DqzquMrsNqzPY06uphOTzVXEq5zcegP5t9uDZIoc9P50u
 e+WoD0tYeDDw7kYyDSLOhwTZ96BlDg+srpiGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758121695; x=1758726495;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24mW39Tw5LGt1WRj/sJfTeLvjgYUahueE8kA2aATp6c=;
 b=rvmtN3mqflBfcePZUuINMvkfyi8vQwaApWUX69BxM2wfcjUBfxa/djhHh42RE8l8L/
 KDpEdtbK2A0DAMm70a6eQWf58A9yzqYJvI0amhyjCqT4sICibbW2VWuzuirAbmZxO2ki
 wsg9mb7vzmddJfVHXPS/knZezOImuOWpFXENAbRlKjU4jdXskS+W5uMoXDbcCopo8NJ7
 FWqHiYVk7ZCSmZ56rjrQ/XyXoENybZCc5sMpkuQ1qggpPjcdM1deVHuoE+7ojJ/z/QdF
 7gyKjzw02vnQ7HD5GvFzpgfgHsVUa7DnlND7ETBn7y0DCUftXW283nxw508FBjUUeUI2
 c3pA==
X-Gm-Message-State: AOJu0YwMxa1Tdyjh6aAJYgrerQGpxjtKJy0on6N/TOmi0ApW6oI3/xMc
 Js3G04ywotZKDp3p5+dFHXvOsZOOneWWxr5q1GMfBIopISC6DvuZ6IMUpraQeHlvAZA/B2vPyWW
 YNdB93tU=
X-Gm-Gg: ASbGnctHrb87rpTQisbT3L8Gvf6sUEW3/c//aynricmcjwp9ISek9ZsGwkol/rz6+9x
 YOhE3fcqmszJV9gFR5IDIneXcEK3IjSVVDlpOuiTNReUTOtDwWCD4RWoNdUtXm/pR5X5vw0QlAl
 NR4IehPd+77quoU7u9jMBUURHB0FcpE8oo85zdehgo2HpQMOMLdsBHNlPjg+/hQlGALzDPuG2vK
 SeaWXOyplyXLWAcpTdTiyMuZmQW9N8IqIl8FR/8WdmedaCSQrrgmK/fVsq/a93x5Qu7IM1B4cVe
 alRcMNhg5SDHmKf0KIPWFIzJHaYlRdfB0gFYlWDTrgzwUuR8ihEMXN/y9bsqPJzlMN7ZO+DBNaO
 g7liNAxSxQZT5I1CpnPfWxhXPUSkT/XPVdH+26HOK5iTRO7TwDzr/i3s8D4eycgLgehDMa2nBB3
 wo
X-Google-Smtp-Source: AGHT+IEymUgRYymlGdGelKiFVzuiaxLa1TKpAIhzwcgAQxBtcPHBDO9jBpK7zPBYRpN4ZT5XI0BNVg==
X-Received: by 2002:a05:6830:2a0d:b0:741:a668:2cec with SMTP id
 46e09a7af769-7630f4dbaf2mr1427226a34.3.1758121695245; 
 Wed, 17 Sep 2025 08:08:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-758b2883055sm2981354a34.45.2025.09.17.08.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 08:08:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
Cc: Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
In-Reply-To: <6846ac4ca29c1156cd8020c19584bc26c2727d58.1758093736.git.michal.simek@amd.com>
References: <6846ac4ca29c1156cd8020c19584bc26c2727d58.1758093736.git.michal.simek@amd.com>
Subject: Re: [PATCH] xilinx: Disable SPL_OS_BOOT for Zynq and ZynqMP
Message-Id: <175812169412.761188.11898422145823577040.b4-ty@konsulko.com>
Date: Wed, 17 Sep 2025 09:08:14 -0600
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

On Wed, 17 Sep 2025 09:22:18 +0200, Michal Simek wrote:

> The commit 210702ae6ce8 ("spl: spi: fix falcon mode for spi boot") fixed
> the logic of spl_start_uboot() where 0 means OS boot and 1 means u-boot.
> Zynq/ZynqMP enable OS_BOOT by default but it was never really be used
> that's why disable it to boot via U-Boot phase all the time.
> 
> 

Applied to u-boot/master, thanks!

[1/1] xilinx: Disable SPL_OS_BOOT for Zynq and ZynqMP
      commit: 5b35aa9da1e0795981cf7bafd1053feb7de95be2
-- 
Tom


