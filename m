Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6033E9370C
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 12:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5639386C7A;
	Thu,  5 Oct 2023 14:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FYZvigbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D245686C7A; Thu,  5 Oct 2023 14:37:54 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE39886CA1
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 14:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso8772905e9.0
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696509469; x=1697114269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vILP50vAWqz1sGV49ycYMK1044oT2WQWquY6fd4VE8=;
 b=FYZvigbdxpwzgQA2VtxtBsKJCxxR9m+3xQ6haap3NpChsAwX/VE9gtrL2WpipWN6oK
 VLacVAhY6yruUNVc3h96H3gBD8Eh+m9gnaBEhHsf2fiErW1AKgKl9LgB8Bn8YknjnWn8
 2h3mmoYIWbnziOn4mYYfarwAVXaaW2qGaL2yAzWudr95evSm9VkUVdkHiRLJyPSOx7B5
 vun1Ee2XHitKG4CjKePLYnJHXlZ1G+mCyHSjScWg7j0IuahyTeNHucH6Hvyre5rM1IEw
 cRLrVyhXk/BgTYAvSWUrxsdiqHw/TIolXQB3dhsq6WKBkbSHy0Fi8D8IaSnDEoBuQ/gB
 VjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696509469; x=1697114269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vILP50vAWqz1sGV49ycYMK1044oT2WQWquY6fd4VE8=;
 b=OtRiyLudL0qAYkiwMsiYItWN3GrmSJNvutqmROApObu5JbVW22tjz4jsqfnLfGjt+Z
 sztTMXPlWOOqPR+CKtuKpQS6M1D8K5X3ZcVC1K7jKv+eLQemX1yQPSmLC9qFUK9a6Lvk
 iHWXnN28KelUCf3lNA2fAbbFIEkeZ71eCA4i1/zl+PTqUQi9lArxFYZw/oAh+8o5VhUR
 VRNXfmpeg78b8ndTgYa8Oj6N04MDiZONZAOkQ0im8TNAShnW93aUdCH+qX+q/AolXMgU
 RvVBzZg3YCOCYqRExPBDXH3yMkUECiEpl/W35jrEomzhfcaY0/bhlCQ00Z4NyhgrTYoi
 R4RA==
X-Gm-Message-State: AOJu0YyTgRcCAc34sUpwlbavgz2+DN1WxT3YmvDbuQorYR4Zvrmgvyou
 AoM74h9RkfVP6TCKxoUX24DZ5A==
X-Google-Smtp-Source: AGHT+IFDv2g//dYtCLGZQb933u9QwgB+63BxytZt4FWOu0hUe5MlJI/qiv64BbwHmIjOIZvdDWZy5Q==
X-Received: by 2002:adf:e491:0:b0:320:b2a:4ea6 with SMTP id
 i17-20020adfe491000000b003200b2a4ea6mr4435100wrm.9.1696509469268; 
 Thu, 05 Oct 2023 05:37:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 k14-20020a056000004e00b003177074f830sm1715339wrx.59.2023.10.05.05.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:37:48 -0700 (PDT)
From: neil.armstrong@linaro.org
To: sjg@google.com, lukma@denx.de, marex@denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>
Cc: u-boot-amlogic@groups.io,
	u-boot@lists.denx.de,
	kernel@sberdevices.ru
Subject: Re: [PATCH v3 0/8] Support USB for Meson A1
Date: Thu,  5 Oct 2023 14:37:46 +0200
Message-Id: <169650945649.3912260.17461050766538864431.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005085434.74755-1-avromanov@salutedevices.com>
References: <20231005085434.74755-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Thu, 5 Oct 2023 11:54:21 +0300, Alexey Romanov wrote:
> This patchset adds USB stack support for Amlogic A1 SoC's
> series. Made reset / phy / dwc3 drivers more flexible and
> added support for A1 board.
> 
> V2:
> 
> - Made power domain for PHY optional.
> - Add missing CLKID_USB_PHY gate.
> - Drop patch with USB stack initialization in board-a1.c.
> Instead of, enable CONFIG_DM_USB_GADGET for AD401 board.
> - Support A1 in g12a_child_pre_probe/post_remove functions
> in dwc3 driver.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/8] dt-bindings: reset: add Meson A1 reset bindings
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/fccbc810551a7e1c821ac23d5e8fd27c12ded1b2
[2/8] reset: add support for Amlogic A1 family
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/29ad8b0401dc9a75a15077f2a38363659091580e
[3/8] phy: get rid of raw hex values
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/11572764d44783870cc61ac2f0435bd555222ef6
[4/8] phy: move clk enable/disable in init/exit
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ac7f5b2f768d298fe84ab36d363853748ae23243
[5/8] phy: support Amlogic A1 family
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/66defb628f658df97e426ab13dc620b9bf6277ab
[6/8] a1: clk: Add missing USB_PHY_IN and USB_PHY gates
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/84b0d40f3adb03074a80a58e4e655b422bce40ce
[7/8] dwc3: add support for Amlogic A1 family
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8a4781ff2e51d5831b7d236a327c5fb13849b689
[8/8] ad401: enable USB stack
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/686a98392fc1beaf544c8cf65f48b781a56a5148

-- 
Neil
