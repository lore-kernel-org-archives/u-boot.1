Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B69ACA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 538F081270;
	Thu,  8 Oct 2026 12:46:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aoS3w79-8A96; Thu,  8 Oct 2026 12:46:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 02433812AF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463589;
	b=l+RsQLd39aThWYRuqqr/UnKSEg2PpGvrv19f8ZONwHslE7qHgyMEt3qhvSqoBGrtxQ8a
	 xmCrMrl46e4QyT0h26ZZoQhvkpT5HnQlzYLo2A9dg8FKbQFHEE57foSTC4l56RxgxP9GA
	 LqCcb+sf/xQM1VxMhCnV/6/mZe+O5fvtarbWJiMI/GIZjopImG0pvwEfeu1HglHlQslyE
	 /rB+nFGPqtSZtUvvVKBMoGizPpkKR2kmLxlG6r3j3iXmU9lDnVTltVc/l+bD5oT7yi7Wd
	 m4JYNuzuSUCkeVpFASenMiHBlYyJowuMxkfd5raBrH6OmRmMbr9aBqLUI8NhDkAEVEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=b2xWNSnsD7YZxVOcTN0Q+u8HqWAgP4ZlEBy8ABCtr6Q=;
	b=jBoYX2BWX6Tvpd52uepNEycK3bw62+xtzaWX+Q0wIFKAjcPIeHuQY7n9txwI8d3y+trh
	 qqLKfjzzHyiEp10VrZbugjaUABg6azL1SralCIMnkSgKZqhduw3YnJxpKlAbmg8szfYOx
	 cLWWCWJAmGZq4OkIwpNSHOWOEiM9ZOxNU8vrvbGiHgRTyufpW6q8WHmEtTK2cK1LZyPp7
	 tZ6y7U1kGKLkWMU0UBe3gZjiEnsr1m2BiyqUoFppr/Xy0Z0JFTy1iPBUuEAftdh6urJpg
	 lfURIbLZI/GR5EZwNGcnNt+3r75Wnjz+UjZe/3s8NdRWGhAWgeNrcw3PihXaGghnRLg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463589;
	bh=b2xWNSnsD7YZxVOcTN0Q+u8HqWAgP4ZlEBy8ABCtr6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v90QtjRukGVKs9tH93seXY+6jBMXcQn/L91eVBVMg9P+KvPJGncRKBZlIKNx/2s+T
	 AqahtIL6d9WAsA/+L9TJX8IjgFyWPQEsHyWHSUYNp4S3pXj6Fwp1eEQZjNkCS9YYct
	 l2czy/IN1LqstJr5WOe5iOfRnFssWTxWXjxsmALrHRxrXI483UlqF2NSYKbyX8GO0E
	 l36yZCkwOuA/IshTMxPQB63D+40Ao4xKG4AxkoCjijZtZXutC1aekf5hpAvEf1Q0V0
	 aJP3eJv6nKtmoxOdtClzzxPp0DAiyM9UVBnR2sHfxhzpV5BznJZJEuLNumXB7wbNac
	 Yi3VW8AM8RPDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02433812AF;
	Thu,  8 Oct 2026 12:46:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6734F22F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CA6740AB0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bYnNVSYI1k-K for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 12:46:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1F7EE40A2A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791463582;
 b=eb61GHTZJMfMkiFYyvUml+vCd2ywtjFt/o6dDJO9DjB0h4dPvSxvo82IqcrANVv4vxiv
 wRVDhn7lHPGB527DmCX2XCPJSf1Cla108IfkJ50UiSqYNwwyHRP3KA1FjrroK3bWqbZtc
 uDwna5P3gLh2bkzqU/gQPQisUnp/3xnqaJZn6vwbs0cGzgDREizaEYt8KkbjVvvt9bb/1
 W3pmMj99dJZ6Idb1JNGd1TzWZ+Q8KeagyVkH7erawvR8xXmrC6EoT4MYnlT61/xNgXMU9
 ZNPsm55RO5emGgZby92aVdDFK0jZ3NO6WYSNQXSneHirRzMhkKRV3q0BSf/xNtZrGfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791463582;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=b2xWNSnsD7YZxVOcTN0Q+u8HqWAgP4ZlEBy8ABCtr6Q=;
 b=FckmGH5ji3Ox7R+HiAtV3eB7Vxz6yQ43f1FaVsnygkINqVG1fLfboipo63ffeK1GHwAU
 R2VXrw/h68z0JH9p0umKPqEz9or98PZCdnIvc54pcvocfXBDsRYgOnWE024rk1W3BeSGz
 X0gERRG1PH19LsPfXJhTKlrDRgwy5C0fOnezGGaDnaEHfsZEVUpuW/suk8Kfe175RF9Zk
 Bt4AXXYnFT4QshuTXGKy7BCLL9ehEgbVMsCfwB5yw9mm68BPQ8ht3xZtJLqTOtXO+47yp
 5YR6FtPQ/PfbkjWNmPdlgptJiO1APKs6Ic6VqcZMwGxZe5sTZs/68hmZ6UVPUE4uSlg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hoToP6EI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hoToP6EI
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F7EE40A2A
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:21 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so981821f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791463580; x=1792068380;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b2xWNSnsD7YZxVOcTN0Q+u8HqWAgP4ZlEBy8ABCtr6Q=;
 b=hoToP6EIhkGPY4XagGf0xdi6uTwkJUBbaaE7Qmfba2gr0dKRhTlvQjSbSJ0DycBkoC
 38fnX7M5oZcbib0e1wek7v8EU6SJXUUHzMjj7KhOiFKlwpnpFwkDnXToCfXgNtOjOMe/
 szR5rxQU0XiMb3FElkdwVJT6SBsJhqsfs+bUIZIwJw9HwthFNPkt7uEd8924D3Zt4jAU
 gv18SrWz9AfE5JRVEKq7qCepsjl79ETQ6S/amZ3OmjkKRtP7+4UhFroArwAiWF6fZYFf
 TpwnBV8eToqKeOH0Svt/L2DeGW5T+i4RSfYfQfFr1FlYk8C55eJwMA1BwW5tBV7oJbT7
 hCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463580; x=1792068380;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b2xWNSnsD7YZxVOcTN0Q+u8HqWAgP4ZlEBy8ABCtr6Q=;
 b=iR1PJE/yZPlEpppnTCmqGeoBOHwA8ultI8VmeY9ablDScPJV4q/ABJ9fatOMWTAOxS
 ExHjFkIQO8eQGUBcgQuPoKvPx+AMLGNnLbR/F5a02vPSgZiu7pls/PapCC9Ytq3DqICI
 k4myiNLm+a7GbShLS7V8p9GtBhM2+bJVG/te6guC7kinJwIZ802KvXLt12zfTDkrME3k
 kLtei5Fh5bTfUhnXnaQL8JcPHX1ekbu12COOzxZQ0hke+NsZc2Wgy+GwroZPlivjlgRx
 4cxu8cJQvRMlPUWKXukJYFKZvSO97llEGiBKtFuqM8yr/VXGc2fi9s2N9iPDuJVdH43q
 /ULw==
X-Gm-Message-State: AFq9FYIP/omca4KyWZOQQ2q2Ghll36EzzORqCjw1/s1NfbaBcdIUFw34
 tJksOSl/C8BY3jEkam1AS3qnFiWVnR/+HwrVegjPdQ3ZITuqYdKEWU1pUyYTp3e6th0=
X-Gm-Gg: AYBFou0x5KW6h9M6zgdmIjMHx0YynlvZ0OCdWrLZD/gBsrVaHA1EIYo1hTZ85ACG1/U
 a5Ua8PiSiirv9FkzBvt0Ys5vXEUi0Gbm7sy8/xAsv+QQVwLS5jZsTfJ68Dm9N/ZbJ5tFXJ2UHQN
 c+UckfilKsN9fXZRG++6V4/nk+KdnuKtE5ENsTT8kFPTSHNXWjdMfFYas1DnOCgZc68ZhJCosUk
 yCu+BaLshCDoLy59cM0FIFDPjNQi0buKztm2s0qpgi4lsMSI/C+OVI2uHQzyOJiFpK6/xflgrfK
 TR6bD1oTams6d4MflZjJQ8D8moa6ZKjiAdRFR4LqRaqzdCJP8ZENnVa5bznTnU3Hq5PQNe0O8yi
 fnX32lEpUjgFlt9chcQobMFZtEFr2r5bJjOf3rfR6yh/819r8LcpCgXE4KoPcQiz2BKEGRWIagC
 ZSNMRb4k9+shDE8H+5AbxH53LuXIGtxzhUotNwC1nuyE/7nNTuIXK/vOV+AKHqDx/gslacaf106
 QsYWmz6DheYk0shIVI5AAVgCMOpufw=
X-Received: by 2002:adf:f704:0:b0:48b:26b:7f8b with SMTP id
 ffacd0b85a97d-48c7288ad00mr8740599f8f.57.1791463579587; 
 Thu, 08 Oct 2026 05:46:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:46:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nick Xie <nick@khadas.com>, 
 Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
Subject: Re: [PATCH v2 0/9] arm64: meson: Add s4 support
Message-Id: <179146357877.183177.5146930302645374090.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi,

On Tue, 29 Sep 2026 14:06:22 -0400, Sean Anderson wrote:
> This series (along with several patches submitted separately) adds basic
> support for the amlogic s4 SoCs (S805X2/S905W2/S905Y4). My tree with all
> patches on it is at [1].
> 
> I developed this for a custom board, but I believe a better candidate
> for a defconfig is the publically-available Khadas VIM1S [2]. Khadas
> has kindly sent me a VIM1S so I was able to add some more features and
> fix a few bugs.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/9] arm64: meson: Add s4 SoC support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a0f6e4a9f1b3ba2314c58bcd66a61a8941508b58
[2/9] clk: meson: a1: Eliminate separate id parameter
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/81b3945a2096fba2ba8421641dbdabb5ad73740b
[3/9] clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/99bd1d3f515842e8801d6c8cfd556077b9ba219b
[4/9] clk: meson: Use soc-specific naming for common functions
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/1f615257213246dc741416b3e92a4e9e76d76d5f
[5/9] clk: meson: Export a1 functions to common file
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5dadc8a09b07f2bfa9bbf0d151b660c0beb92a90
[6/9] clk: meson: Support fractional fixed-factor clocks
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/538d95ef9ed6413dbd735ca799dfad2fe8c6e001
[7/9] clk: meson: Support power-of-two dividers
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/10176b815d013d8825fd243ae20892cae35c249f
[8/9] clk: meson: Add s4 clock driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5363c69e08d0f96834f4d80dcf23e11d64cfd80a
[9/9] meson: Add Khadas VIM1S support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/9c048da44bed99311355450d70840bb0795e21f8

-- 
Neil

