Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE74C54E58
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 08:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61BAD87E13;
	Mon, 25 Mar 2024 09:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TQ7caD/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC4987E0F; Mon, 25 Mar 2024 09:18:14 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C60FE87E13
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 09:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4148b77ceabso855365e9.0
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 01:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711354690; x=1711959490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vn1W2ruOodemTLcB+pbYYO0c3qegjIEhkk51wov75ag=;
 b=TQ7caD/E32x1+f6ypBg3DyRkT6gkS+6+CUGN4tMo/9IAyzPjVEj8Hc7Lgc1dJc6ciH
 NdToJxI6PWpGlnGMplnmDhtTIxrFxIpEK5p2brJK9k2lZhsDyTWr/NEX8enwcNNOhe/h
 nxxQYHZ/qdziAni/wBaLcbUHjxAuVWoZVkNGI/eA8f3wtGIOk1IutXh7P4fvGIxm9bae
 0TvLxFstiye+NQviRhherEeSOn/KF/s40afNiFoAvaJBdQB/2yO1XsXlBnmzOFfvy9xR
 dVIUg1AHvCSHuLNCoJhXUSjuxW1NqbhcED9/jiQFvEB/4bld8uMIFVDaTqLLx9vUPeA5
 lSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711354690; x=1711959490;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vn1W2ruOodemTLcB+pbYYO0c3qegjIEhkk51wov75ag=;
 b=SLpYLOq86byjgUMhi0DWY6SzZXyNJG/HSFMi6Mqr15HFd2v+nJG3Mmpd4rYnk9/ymC
 AS8+NGG6aDsLL/wUP19e25+n2ifD1MAKNsFklkR5HIQlLjVhnTtHQbPPlD3lHj37MO0/
 Lk+4T9Gbg3prsH2ZONAA9OZzn/iYoLqDmq/NNOAKvg14hCpEwMicIW4+S1rXy5vB9/Bj
 oj1nL5RF7w1EQC3+yjvVE8SO450w/lWFUNTBi3YE2/+plpRrmqhhER01upyTJQgc9Rif
 Pk/zZZQQRuPjnN2aPFT6QZNNfDFC5T140rXh5ed7WKjK3mc2q9N/NQM+0qOUK1XCEIW0
 Uudw==
X-Gm-Message-State: AOJu0YxorT3CZe94wxJoOxab9ogYbSnev3tm43WLrVgluHAxnPytR7oo
 Yz3mRL888sLaFFJUsbDsOioQoo7xarc0X2EAQEY7XkOVDcgYzThc+Iw1KTnix/s=
X-Google-Smtp-Source: AGHT+IEnIbCEhnwyDMPL1uDQFsxaR2kmLl6kkQkDTep/4JxGSJgMaqv97d6aGdotW2UExKekvSKGXw==
X-Received: by 2002:a05:600c:474b:b0:414:8948:5f88 with SMTP id
 w11-20020a05600c474b00b0041489485f88mr1655577wmo.0.1711354690057; 
 Mon, 25 Mar 2024 01:18:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 m29-20020a05600c3b1d00b004146750314csm7686212wms.3.2024.03.25.01.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 01:18:09 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 linux-amlogic@lists.infradead.org, 
 Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20240324151905.3817732-1-christianshewitt@gmail.com>
References: <20240324151905.3817732-1-christianshewitt@gmail.com>
Subject: Re: [PATCH v2 0/2] ARM: dts: fix Ethernet and random MAC's on
 WeTek Hub/Play2
Message-Id: <171135468944.4116391.11813937820801790173.b4-ty@linaro.org>
Date: Mon, 25 Mar 2024 09:18:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Sun, 24 Mar 2024 15:19:03 +0000, Christian Hewitt wrote:
> In submitting the original patches for WeTek Hub/Play2 I appear to have
> squashed an experimental change to place the u-boot.dtsi file on the common
> board dtsi, but this was incorrect and results in broken Ethernet. Patch 1
> creates per-board u-boot.dtsi files to fix that. However, while the NIC is
> now probed correctly the current p200.c board file doesn't find the MAC in
> efuse and we get random MAC addresses. Patch 2 adds a fallback method for
> generating a MAC from the CPU serial.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/2] ARM: dts: fix Ethernet on WeTek Hub/Play2
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/cac77418d6be11445c3e1139f6763b5f5f5fe9fb
[2/2] board: amlogic: add meson_generate_serial_ethaddr fallback to p200
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/65d5c367b00cb392bda560c3da1834979adcf137

-- 
Neil

