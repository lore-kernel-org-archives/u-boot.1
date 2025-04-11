Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D3FC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 13:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2AEE84064;
	Fri, 11 Apr 2025 15:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RwVQbFsY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46C684057; Fri, 11 Apr 2025 15:36:13 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5677684054
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 15:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso21156425e9.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744378571; x=1744983371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAm8o8Ymb1ybPEQHE+JwuLZzo1sOOx1WxSdZszeOxXg=;
 b=RwVQbFsY9Wx0sIJlHnV5KM/OWyq+kLMD14X9bNmZDeg+5YJls1yqdBQGOLs6Ks258x
 S48itl8aeDArsK6qHyXBNFkuL8D26OSuQvi6xiNFrAZWQfZx1i49fWsN+bBceFqEB0m2
 89FRVynn6MuYejh6ib+aiQzpLh8xkg0nncL6gsFJiL7m4nvUB3pRag57UMlMt+IwEcTu
 fqDiDYgZWxPILj50SwS31heRA2bjGrNfZJo8MGD/qkuYezcsuwLJyAknp6dTosr6EMdN
 AzQQwEwLBxBbKmoAEUrtGwlQ/feUdmT5Q3iAE4kt5EP4VlOE4DdYJi092IRJ+EB10keC
 UJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744378571; x=1744983371;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JAm8o8Ymb1ybPEQHE+JwuLZzo1sOOx1WxSdZszeOxXg=;
 b=cEDpFxGV8dGD//g+X3fotYFffSyuiR9jOU1JGEpYfzOZki4x68Ls/mGKYQOSugXHTe
 S4y9PIO+OD+tCaaDuo2tF7lcFHAyTHWkK0XiifF262G8LNcKeStL8mRvR+AdIXC6VzjM
 fMNh6WQxOe6hSpKIKOJzmR0G6hegPULzUtExOl8tNiaO40594ZajWnyJW/6H37btfzAW
 QOoCLzsAWeqDrj1ykNJ/WN0/NF1lbSVRyBri2XG+IjzganG+FEIIknsZUlBZgl8Qprl0
 QWuYXuzeN6jM7pVKzGLRn0QoJlObfimNKhkRbTwLOq9sEqAxZ9a5YIZG5D+3O5iNrSQm
 tYkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMxYqo/o2fRHdnK6r241o/lvsSE1oeWoxCIcvAjZBShGtLhrJfQvIrzmtmec5QO5f/yWTg9kE=@lists.denx.de
X-Gm-Message-State: AOJu0YxG9laF0vmmvtnVa2uNXNNCDpJ0SFNT1uIqmUcveUzJ2xmRuw4W
 GmUhavHpaYJQZnNf9/xecKJ9z+2eQcaeDQ53jCQ1P5y1Mra2x1KpGdbpA4dknes=
X-Gm-Gg: ASbGncsP+oLlhfG5GBoaieREXKF/Arn5XMKm4dqWLs8FZz3X2nmGW1gbMCHpvwX3OO8
 Lf96yi2PzyLtcBbBlylXhK+Qqsh0ImXMC/wb0cTjN+fBb4CiqVLZl6V0POvcg6V2POX7Gib759B
 1rVnwmVY3T9AQe2tIG7GzPshQvx+a9MEaazXb919Y4ETtBKlGxVdc9sW1h8rK0btwYfCHHm7aBk
 xrSGEK7WwlquVSLF+aOC873CJxsOGU8E23R1x01nNU+Of1351/abjQq612svhcqYcT5NV+lqfjE
 EyvPXiEwQRZurf43VZ2NRQQEBM/Qo3ZoSTJNP3uJI4AelljFH/Lz/55/XRwmweOuRCOSZjodgHm
 67ZolVw8sqvOEauH7KA==
X-Google-Smtp-Source: AGHT+IG592bE1fb10vK1BuGdP7JXzKiqn93d4dZDdU20QJTpxPi+ZA/b4MkRFzov6/R2BmEvgMnV3A==
X-Received: by 2002:a05:600c:5104:b0:43c:fcbc:968c with SMTP id
 5b1f17b1804b1-43f3a92639dmr20920545e9.7.1744378570788; 
 Fri, 11 Apr 2025 06:36:10 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c8219sm83195365e9.21.2025.04.11.06.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 06:36:10 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Danila Tikhonov <danila@jiaxyga.com>, 
 Jens Reidel <adrian@mainlining.org>
In-Reply-To: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
References: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
Subject: Re: [PATCH v4 0/6] Better smartphone support (Qualcomm)
Message-Id: <174437856938.2613234.1996686696172949555.b4-ty@linaro.org>
Date: Fri, 11 Apr 2025 15:36:09 +0200
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


On Mon, 31 Mar 2025 14:23:17 +0200, Caleb Connolly wrote:
> Improve support for running U-Boot on [Qualcomm] smartphones, with:
> 
> * A boot menu which can be entered by holding volume down during boot
> * Hang on panic (so errors can be read on the display)
> * Serial gadget which can be enabled by holding volume down or via
>   boot menu
> 
> [...]

Applied, thanks!

[1/6] board/qualcomm: introduce phone config
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/fd775fb7aff8
[2/6] cli_hush: support running bootcmd on boot retry
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/657e19f8f2dd
[3/6] bootretry: check for bootretry variable changes
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/aa5ef3c0a752
[4/6] doc: board/qualcomm: describe phone support and bringup
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/4509f8183970
[5/6] button: qcom-pmic: prettify and standardise button labels
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8f5685d5d32f
[6/6] button: make button_get_by_label() case insensitive
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/9c607005c519

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

