Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F0EE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 23:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 112CA80245;
	Sat, 14 Dec 2024 00:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WcYubyJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55BD5801CF; Sat, 14 Dec 2024 00:16:54 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16792801CF
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 00:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-46792996074so27358561cf.0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734131811; x=1734736611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrOhgOUW8C+dYNlCcesoigBBwR7Th4WLYhOPmXER3UE=;
 b=WcYubyJvBXhwCsYza7WWsaWYOjK9ED7enRQIcvx0/rbPl7xZsdVGXYbDrbFk3REdj6
 3yDukfUVSYxMNZwq31cyl8QKGOtmyXn6ayt8sQqlXpURt4N4MzBDhkwPRUSujEE9/Lau
 +ud4Jnx/glhUJc+xkwKca3SB50Si3RyoOV9CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734131811; x=1734736611;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IrOhgOUW8C+dYNlCcesoigBBwR7Th4WLYhOPmXER3UE=;
 b=B7p243R/BTRkugkc14P3NZHgh6CTlCx6zqRNE7AY9rqbgME6vbJb9wrP1LMi/+jI9Q
 0Ari0Z5K9macSwK6YbnXrbQJiW+X17APZvwInGN1znGfOe2Q9iJoi+/BT2bSOg4WYL5k
 5sB6DaNvB4oH/9uEfHqisVm1UYsOHGVwU6nZLZ0hZ1+3ScOhxqF1jmzb0LtUy3jX+8dg
 O7CQka40BhyqtgSzgGwiAWTC+onTygbyqPm+U0d5E5FHmlZFco+qPZOX2u+pRjbZw/AT
 4wnb7bbj5+0ekIjvITqDorq/GMStNHAoBIMsNVfeLlq1+eRpERv6otn53Ykinp2fFlcW
 H3RQ==
X-Gm-Message-State: AOJu0YyzZLiG72Hd3RGLhtpaW6o276YaRVUqt2UHKXE13fCzHrCOLVIP
 kkgucnL0zPJiW3JOeZV4CvPAO25P4VLuT0q0eqg5hnhRkYmcO/mYY2ixXW+JjgE=
X-Gm-Gg: ASbGncsCOekURZ635GgUfjKJEKVRT+Q0IIKag4njkTxKyVi4mpMi3EL+tx/hb2zDJWu
 47mWfDZeljQukLhiNlL35Dwx1dJwWy0FCRCKdBcUE3Sf+uuX+k5BM7AfDjvrVtjwbl/c8u424fr
 mcgqI8iY2LyVu2/ohh0FT+ojVJFXAVyfjHT260eANR77oIk2eGRZ4THW9TwXmOileTZ74yEIUpC
 x/aMADMinrmbXUUacz05+dDCkvF1ImDjSgWnjV2kahEWgBjC5s4Lw8=
X-Google-Smtp-Source: AGHT+IGYol84/sSGoTa8QLbALJPMOO8zgcHT+RWEmoq4k/VRpmqNSmAE2Rn7UWK5/kOgziPP2LK8gQ==
X-Received: by 2002:a05:622a:14cd:b0:466:a119:f4d3 with SMTP id
 d75a77b69052e-467a58402ebmr86019511cf.45.1734131810939; 
 Fri, 13 Dec 2024 15:16:50 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2cbb69asm2690171cf.39.2024.12.13.15.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 15:16:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, bb@ti.com, marex@denx.de, hnagalla@ti.com, 
 mkorpershoek@baylibre.com, caleb.connolly@linaro.org, 
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, jonas@kwiboo.se, 
 j-humphreys@ti.com, rogerq@kernel.org, nm@ti.com, devarsht@ti.com, 
 ilias.apalodimas@linaro.org, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20241126120322.1760862-1-s-vadapalli@ti.com>
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
Subject: Re: [PATCH 0/2] AM62A DWC3: Add support for USB DFU boot in OTG mode
Message-Id: <173413180891.1760624.9231691279584984355.b4-ty@konsulko.com>
Date: Fri, 13 Dec 2024 17:16:48 -0600
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

On Tue, 26 Nov 2024 17:33:17 +0530, Siddharth Vadapalli wrote:

> This series adds support for USB DFU boot on TI's AM62A SoC which has
> two instances of DWC3 USB Controllers namely USB0 and USB1. The USB0
> instance of the USB Controller supports USB DFU boot:
> ROM => tiboot3.bin => tispl.bin => u-boot.img
> 
> USB DFU Boot requires the USB Controller to be configured for Gadget
> mode of operation. Since the USB0 instance of the DWC3 USB Controller
> supports both Host and Gadget modes of operation via the Type-C interface
> on the AM62A7-SK board, the device-tree specifies the "dr_mode" as "OTG".
> However, there is currently no support for dynamically switching the "mode"
> from Host to Gadget and vice-versa with the help of a state-machine.
> The OTG mode is treated as a separate mode in itself rather than being
> treated as an intermediate stage before assuming the Host/Gadget mode.
> Due to this, USB DFU boot via the Type-C interface doesn't work as the
> USB Controller hasn't been appropriately configured for Device/Gadget
> mode of operation. One option is to change the device-tree to specify
> "dr_mode" as "peripheral" and force the controller to assume the Device
> role. This will imply that the U-Boot device-tree for AM62A diverges
> from its Linux counterpart. Therefore, with the intent of keeping the
> device-tree uniform across Linux and U-Boot, and at the same time, in
> order to enable USB DFU boot in "OTG" mode with the DWC3 Controller,
> the first patch in this series sets the "mode" on the basis of the
> caller function, rather than using the "dr_mode" property in the
> device-tree. There are only two callers of "dwc3_generic_probe()",
> each of which clearly specify the expected mode of configuration.
> This will enable both Host and Device mode of operation based on the
> command executed by the user, thereby truly supporting "OTG"
> functionality when the USB Controller supports it.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


