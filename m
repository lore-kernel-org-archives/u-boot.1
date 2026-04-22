Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456D2F94CDC
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 08:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDDBA83936;
	Wed, 22 Apr 2026 10:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lahmr3be";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C763183FFA; Wed, 22 Apr 2026 10:10:07 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D8D8352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so4005774f8f.0
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845403; x=1777450203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5u6CIVsoPYILnwTrqGoE5xuVhKzQV76CLZU4oGT8QM=;
 b=lahmr3beBZ8f/K4swCjVpzZ1YbxcBw5nvrWuguBn/TDM62pU3Zub6eURgPu4jinvEZ
 KiU+u8ywV5rMfbRhgu10qbRVGRtGvRTJHGiypWEyd2SctlkHz3HEFKr4R6GNeyzNXjLM
 v3ZtY9f5vKDH0BBESnfghWQuArU7z6OTMxyjNrVrcLayWXbko+KTfwh6KWCW5rXQqABn
 +rdADlyYkleVQVQsWFK3cWNU+DE3c6387VKkVB3FlzaY9m/2kkSOTNL6QKkaiG8Rsprm
 UBW2ekymOmIhJvy09xzvo/OnjccxX1H82aCmbzWugwIZLjBG8GHZ0uqa6DR3rGLH0yjV
 wcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845403; x=1777450203;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y5u6CIVsoPYILnwTrqGoE5xuVhKzQV76CLZU4oGT8QM=;
 b=QctpjV7yg2kq15GnHKdodJz9vHIi39Qsxj2VR2xUn5y5Z9fxpaWsisxyq/JkkVrNot
 RFzA1jw7dsKwzI6FQrrwrn7i4EDJX8Pv3aKQFgO6VwVM6Kbi1wA7c0ed/G3mqQ/nh7Yn
 cnOYd8P0VAVnFVZyOHMyhN5PHWG2i2cMykIyIunnXGQUQn5Fr8MtW7pA3qO2zAq9KIFu
 EivKKTkmYtF1ZDQ2kgJoDle/G1KXTkIGgCjP3PsgcNZ3G1/RZXehBw9oO/G82J8HEpJ8
 nGpiB7sspO1D+dfIEc3DJymALeqelxqHm0+wfo+E0tTzdHTK0eNkTHiUZ2cuvudgs42P
 3yRQ==
X-Gm-Message-State: AOJu0YxQS/vEjpGPHFugKZgroo7A50nrUIGIaG6JchmXWr96yemzquLT
 7YBvKlG0+eLsbFKtJ0fU9Wjsh8fRCY6Q0s1D+L8KHvZN0K+jw6t2/q4dpAMtw/5zods=
X-Gm-Gg: AeBDietZCX3vJWdUi3cNXcZXskGYsXRrturuu8E9b/+IcIzrmh00/QALVJjsFA7K3sx
 +TzdB6DYtDgdci3HtNtFC1IA+ds9aO1jwuCfVhosHXMq7DkHjX7shFL6u7yvmJiRlB9xIbBvzdC
 JHwG42qlABCRo7PIL+DUnr1QHXM7lcfMcY+wF7dafuqozxsWkddOfeIKml/ig8Ek+c+aXTkC0GK
 BJrAE1NEhuoUNNbCLvVujSODdo7HHkTZwIMFTZd6J2LgaXvkOezdrVawXcNQFrtT9zpJ7BH1euZ
 1xI81FCJh2dNJEeQ7muPv1luFTY4iwlo3KS5HZRti3+4OtscaThVX16d6aRwx9JofU+3EfNKH4q
 aefJ4k+QI0KXy7nxTXeg0w9xa+QpRvv50Yi7L9Dyei0EM21tcypP6n9/QBKbcaLpcwfUYsPoi6q
 qA2zDqQe4Q4ualFMxtj1vr4Fqo7H9biRCsqj0XCb4sR/AVXk/2FmNtGpw=
X-Received: by 2002:a05:600c:3ba0:b0:485:ae14:8191 with SMTP id
 5b1f17b1804b1-488fb73a089mr333848455e9.5.1776845403367; 
 Wed, 22 Apr 2026 01:10:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm453974945e9.2.2026.04.22.01.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 01:10:03 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Alexey Charkov <alchark@flipper.net>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260316-rockchip-ufs-reset-v1-1-808eb017459a@flipper.net>
References: <20260316-rockchip-ufs-reset-v1-1-808eb017459a@flipper.net>
Subject: Re: [PATCH] ufs: rockchip: Make use of controller resets
Message-Id: <177684540266.2674178.10419540392092018903.b4-ty@b4>
Date: Wed, 22 Apr 2026 10:10:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Mon, 16 Mar 2026 20:50:45 +0400, Alexey Charkov wrote:
> Assert Rockchip UFS controller resets during initialization and HCE
> enable, as it is done by the Linux driver.
> 
> This is required to make some UFS chips, such as Foresee FEUDNN064G-C2G0,
> work properly.
> 
> Note that the resets were already requested in the probe function, just
> not used.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/1] ufs: rockchip: Make use of controller resets
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/c7299ff33ebfabe35baa6656590d977dedfba5b0

-- 
Neil

