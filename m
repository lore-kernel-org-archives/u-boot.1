Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC317C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5BDF81DE3;
	Mon, 31 Mar 2025 15:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V535N9uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E37C819D2; Mon, 31 Mar 2025 15:34:44 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E386B8144A
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso29717025e9.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743428081; x=1744032881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CjVdQdaw0Kcrw9uLGqkSDqYWDMgF8efugNkoiyYBaY=;
 b=V535N9uuHVKNdBZMM0DomwMTNn8NQjK3PjA9pK1Dtmo4Rsc5vvj8g32qEq2lt8aFmY
 e+Y9reZtU+Lz584WHkAd02opHgYeXm5HVqLSENKbUnSdydY3aDNH1wB+ZaTkoc9TPswK
 3aLoEb/4fT5w5z/1Z0oetaC61NiS3986YYKfwrrJjtJXgcNLeY0W45fNSlDcTRf5+XL4
 Y7UuBGgJ/xkAn0XqJ3GgX/WtX9XMbLnDloTBk+V3P9Kmj9C/Dc50kWS0kNDdcxVz34Ip
 yC+50zW+VXO6cZeZ9Pl7G3XUjgN2tHXwjR54An52NpBbN7nkHQ7r5XBzHD/TJvYSIuzm
 BkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428081; x=1744032881;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CjVdQdaw0Kcrw9uLGqkSDqYWDMgF8efugNkoiyYBaY=;
 b=quYnQMOPJYvgs4ULhX3LwpUPrFljYMQa02i3k4nE15mXizDZqfnTzVPIYujD9DnyyS
 8NQ00X8lRh6rVsjkSeCWhGuXja/e2qAosfzBmlVS4TbJnSk/WyTZxoPoYhz80Ea84CvE
 SUIdVW4KraGt88kBm2TEnyGVCh4Vg/vf1JKa2+7gzJmcGAq1fzAzi8RGMyjNhDuLDM6x
 twDVZfC6sioeaICKd9BmNmgRpxEBS7i6Nlcr3Hbr0gEtBqRBqYwZIwpzXqdHAWPTfoGU
 /XeQ17BrtuCtgGwXrzMISij2NKiQdWPyNlrqk9f++nUDA/SZcP5Pupr7hqt+kdn650lL
 zxnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7MNDrv66bPCRJOwzdxphRMkTCsyCkXx+ZxLmmFL3afRvjJ3hoSt8EW5rxNaZu6453DYdvaPc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywogq829jkIv2EkB+rM+5d1x088JQupNkxQ+ckCj+W14dhkTlb8
 sHWWCGQ2kBs3HCw+6sesoC8tXfiPq6k6dJQOnq7B9gyWiZ2PJ5+KEOKwQDPKS2Q=
X-Gm-Gg: ASbGncsb0N6cFHMrkRNKaojIaCwuI8/7dOkAQkjTiqLbahVOlkagmnvH3eBgj0FMbjR
 QduMJ/Tzyl5FSJX3BIRsxXR+QpPprp8tp4eJBl4v13DSMiG8EJ9C9m/6a2D5mDYSrOL4uivFgZT
 dox5hh6/Zpr5VmMi+r0BuFuYb1ug9AlDl8wAGDp/HymAqL0W6z8E1tVqa6ZtHV3yIHvniJ4fjy5
 0cWaFBj8jzuaTTocB2O0UGQYrwkZNTDCpqPA9za8q47cl/9Y0THDwGPMMgiw4j/idQ6R7CYwoNe
 ohHgoXEHOhSp+hmPWPrjN5qIvycKYT4ZhtwLhv9TbWTUq7UJsfzhLeZ5MLKQfaVbITSDIKBOBHd
 u3QSb3s2EFE8u
X-Google-Smtp-Source: AGHT+IH/mZu20bi/S6XY/Q5DyLzjvKYzYCRc9+N3JLckzF1dKzdc+a21GJpkw7C/X900sY9OU38uVw==
X-Received: by 2002:a05:600c:458b:b0:43c:fabf:9146 with SMTP id
 5b1f17b1804b1-43db6248241mr88563625e9.17.1743428081317; 
 Mon, 31 Mar 2025 06:34:41 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe389sm164266095e9.19.2025.03.31.06.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:34:40 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250328104011.1837872-1-caleb.connolly@linaro.org>
References: <20250328104011.1837872-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] qcom_defconfig: enable OF_UPSTREAM_BUILD_VENDOR
Message-Id: <174342807978.411395.16109462789277501817.b4-ty@linaro.org>
Date: Mon, 31 Mar 2025 15:34:39 +0200
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


On Fri, 28 Mar 2025 11:40:07 +0100, Caleb Connolly wrote:
> A single U-Boot binary can be run on many different Qualcomm boards just
> by booting with a different DTB.
> 
> Simplify the build process for this by enabling OF_UPSTREAM_BUILD_VENDOR
> so that all the DTBs will be available after building U-Boot once.
> 
> 
> [...]

Applied, thanks!

[1/1] qcom_defconfig: enable OF_UPSTREAM_BUILD_VENDOR
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/ea169b980cbc

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

