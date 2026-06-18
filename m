Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02106CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7527784874;
	Thu, 18 Jun 2026 17:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FvaJZpLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6EF84995; Thu, 18 Jun 2026 17:11:35 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C09698460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69532288224so2002578a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781795493; cv=none;
 d=google.com; s=arc-20240605;
 b=dDWjQp3uOb4CBk+QF1clNsYaD1VEnIku0zpLOQzVl7BRBtcbzgFDozu6Iy7CcRXgJt
 8+vnefoVPSN/rnzicyLgeaxFv1tYVGi63QpYy/BIFY9Q1Rqe0s3kg74FwsqirCBGf5YJ
 YgLWaf/qGNwrZfQA8EwDAS8HHDUB2H6e8xbPq9OBMso8WnR/RhD2XWQkn9LTrp52O3Gu
 S1moB2bEWUrAyFkW1rWQBhXOm6PO+TCQfTKHxl03FQVAwhKybQitN//Yvaz+rsqJxFfo
 kP7mR/QJa5rCj4lnnEWEK1YVL93rFgSqTOYhGEHwBAd0X+S+2Qo3cuGVerq63FOq53YV
 swKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KxplIp15NTXeKVYVZbCjHZPsJw+Ubbs5WwMTaDLbLuI=;
 fh=9yTjFfFb8FrOmKKKT7SbI/aqtqgnfkFojmDfdoXnctQ=;
 b=HZB+XhOnLrhklEONqt4BDI9Xm3Tt6p9n4YnE0moxYj246AN8MtIl/42rgoOl0lcDxe
 A//SBIUCCQNvLVsrvnh2rpfZ65i1/D/S6sgmtWnmjBcADuqJcvwzN8qA9TucC8Osf6Q0
 6Xtvmv6+ckKCOj6tXH9eNeXTiLkXwXxIy4O2QxDXQTc7GWmrCb24MOef53yVec3WhUnR
 U0B54hJ6j1h7UzTL5Ntka2vl9EnRjkB+adq2cI04uLQOn3tknXHd7m16IZFkAUbZG63T
 fvczQ606jUWk52cQoZKEoy5ircg164Ex5NqCAElY0lrcaKsEbNdE1JAvrypm2S9OHGbe
 jKuA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781795493; x=1782400293; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KxplIp15NTXeKVYVZbCjHZPsJw+Ubbs5WwMTaDLbLuI=;
 b=FvaJZpLhjyCVahwIz7MuFmpTMcc9Su+qjiI3y/fYZhYfKWNpWgTn/8Z8hAZY0453OE
 oRFWo2j4vXb2aNG07rs8/98ns7u30kH6WcBhkOcbYAhhI9S5L5bvRU/5z+cvVDXJaVjQ
 lCIoiwCJIQEzGG6SaaWLYZo3zTGZoWN72+Nak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781795493; x=1782400293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxplIp15NTXeKVYVZbCjHZPsJw+Ubbs5WwMTaDLbLuI=;
 b=Z0HtzEeB8ycjiOeeQPaYSPH6G4wkooksxqXW1sFTjCNcH1XoNuJVmvKi7gip477+l0
 NkeANfcKNZ0OYjImRqQ+feyTWs6moJUAxT5xsPy9kDTUIPU1erntl18zQDjivH82eJdk
 04pp0QnZKpOysCnhFRoiZoBv7DBzgaWxO3UGFu9QSA/vR88bz3WmqtteIt9PIpkDm1Eu
 d6gExG9ekS44g+1UoagzO+diNLZ1yhgyIYMIMcsBm6pqAfiZELJNwAgGznvflZs7ATQp
 H/Mu5vN7dqWHKEUOsVAYd8kCxRqWbXqq9Bmo0PuVrEyXuK8vyyDpppv6c/a1YvmfFI3j
 DkOw==
X-Gm-Message-State: AOJu0YwQtcEW80KMSaemOMxeRbUqylFk5hRUbdC8tMERxCdFWxhJSQw1
 HkVxk8Nf7oFLgHuHjb/JqDp13vrbHBzEr7mn+sMLFX3lMHNjx8OKNMnj9dn30Jz8pc2PeZH35pq
 AtiV81morlpTK41eg9UN+/ZUkXhrghtsyMobXIdKV
X-Gm-Gg: AfdE7cmVzwO0ONjClWpPLSRtwYAMic4vGWGXXcVo1lwUiijhppj8QvL47Svre92kXX8
 KhUxoOrcae6qchJxUXgcW2n3x+asr9kCz0iCM4cpc+r1lwR4lxYekCdlf8RbxEpRp5TGOCMW+6P
 HP+fdq1qGsA1+ZeZa04i0V1lKNbLxsTdrMqbjP/P06ZQoTF5oOOkbBs9dauO2eqwJQVjiUABRRj
 f7rQF/ZvIPMOAZERAlD9Z1KpnCgO8me86ERrYqnXuQzApSoa0wuYDMjnUatuqPmepbUAF7SGhDn
 Tj05OzNw
X-Received: by 2002:a05:6402:4490:b0:687:5157:1d4f with SMTP id
 4fb4d7f45d1cf-69547701c55mr4734142a12.26.1781795493297; Thu, 18 Jun 2026
 08:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260617-qcs6490-rubikpi3-v1-0-495f618a1e4c@thundersoft.com>
 <20260617-qcs6490-rubikpi3-v1-1-495f618a1e4c@thundersoft.com>
In-Reply-To: <20260617-qcs6490-rubikpi3-v1-1-495f618a1e4c@thundersoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:11:21 +0100
X-Gm-Features: AVVi8Cff633h0CZ4GQmvS0F-v9w82NU8Y0k7yQAkBNtm9zncpg0c79OjTXcZxVI
Message-ID: <CAFLszTjjSEtjwfvf9V2M-kM4gjjdgZtyOT6Y8r=QJvewE_iRnA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dts: qcs6490-rubikpi3: Add U-Boot dtsi
To: hongyang.zhao@thundersoft.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Roger Shimizu <rosh@debian.org>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-06-17T10:56:10, Hongyang Zhao <hongyang.zhao@thundersoft.com> wrote:
> dts: qcs6490-rubikpi3: Add U-Boot dtsi
>
> Add the board-specific U-Boot device tree overrides for the
> Thundercomm RUBIK Pi 3.
>
> When U-Boot is loaded as the primary bootloader, no previous stage
> provides the memory layout. Describe the 8 GiB LPDDR4x layout locally
> so U-Boot can use the available DRAM.
>
> Signed-off-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
>
> .../arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
