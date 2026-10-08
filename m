Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B874FCA600C
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60C8160B72;
	Thu,  8 Oct 2026 12:46:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IpbZulHNtS3I; Thu,  8 Oct 2026 12:46:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7134760B3F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463585;
	b=ejyGllxbfIl3pOW+YgkLbjA6dBJLNQ8MALnOguedRgXpEh9SFMatHaS9DKOmoCdUDh+6
	 gBepYwGbirw9Es6tWL7mRDZTePUECT3+X0hKVNcUZJVFDtp++mZQiPO576nGK8Jih1R5X
	 +EBquEs4kC3GPVFzkfV1kF1iqXcproqYXJel3N3Jw+3TVIrn1kiol5kYurKDpwh1DbBQp
	 jqfOyiBZZTrjV59+QgHyPwezWvjAPv+85vFEZ7lHxZBa5Gga2unRXiZe0dPUOCmIH4i9r
	 lB4wWdWEGedXQT8pZwFVr0VAQ/UddutQMnh+8OYTLVyK9gmERtbY3dW7j6jGlCvngpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463585;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TXinAbatRsEMtUtBMVWkeQwgMl1Rc2vT60N5Ns1XSc4=;
	b=TdLI+Ig4CEI7LZ90jlx/KxyC2C7pMvAviWNL8kzI1UxLDP8uzPZpSvu+hJ9cdMO5c86k
	 4EgHSyF5rKVK/b+zAmC49F9XqHkthyaCi7AwCVpNrvZ++D+AbKY4C/YgcIHMFLOlVzCQH
	 apOOA0W0GcIbJCG4CbMelVNVw4RDS5OY0sqyVgxAePft4HkFqaCtcbRV2nT2ygGlDCJ0b
	 ukShDOYs2X2fwsx67forfYoNEVHN5y6PflaEBMJoOrPlS0BQ2zIQJILkE8GZrsrWt7qjl
	 zCbN7B36pELf9F+fIuUaUfbQR9gWonIEB7dHwdKglL6UuHYp0s3sKrf4vAFXV2tuJ+Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AI4abWE1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463585;
	bh=TXinAbatRsEMtUtBMVWkeQwgMl1Rc2vT60N5Ns1XSc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HzzRT8v/RbDd2uNhp5MJb7QnsX8IyJul/IxfAYG0b7L8Zsq05aSayEPMT/h+dZayE
	 Sg27iF+oFNki9MxcEVu5L2EEJ3Vu4uzE5pO21MqjmmU8XW4sBZgwoxv5tIbLbFzJJn
	 oXt0q0Za+auH+PPnY+zFaf/IKMt8zKnRFcpUx8a9tUydKvVpQaSbrbWpJdt2w4D79x
	 jJpJiCGgQ3W9x8bEa4feDS5IF5vnfYtUP3Ms7ZQarSwvMn3WUrs+iVpqF90UJJtkTL
	 zPiubYLd9YmvXHfQ+bfQj9jlOQVas5aZEHWs3PBXIZ0Wh0PNLg3WemYhig78PUPrVf
	 73CqH6XdYa0Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7134760B3F;
	Thu,  8 Oct 2026 12:46:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41A282E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E7F060B3F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id su5ReK9IS_Rv for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 12:46:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0D4FD60B70
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791463581;
 b=hv+gt/31tpT3/8v/1w3jM1odnSPqWudaYakwTFH3euukg1wc2YkBZRXwqRwQ9Csj1Bit
 9PJRRzx/svHcLmD8xJoYUKLhNQihapYpoEwr9eiCiTRpmCBUlNCnY7202Hvk+ljYMGbSJ
 U5hzHaIaEHN8sIMVCbzY4NFaGJYaMWzAsqNaqvmBeNj05TPCjZHGj9tciLbFBn6/IQEo0
 rosn+BQ8T8CjsXVSmyvlRRXTaJrT9Ing+ZZjCTAyRH5KxdtOha7jhMYlHEBwFdj3W1KTR
 kgO2yC+5XjCF8CokuVXTEPK8Tu2PwUrw/OWF6NVUlgIVJTNrdjFJxGTAgd6Pb+PVwjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791463581;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=TXinAbatRsEMtUtBMVWkeQwgMl1Rc2vT60N5Ns1XSc4=;
 b=A/RDOxMU3wzTowJajHTjeDfgPKLcsNlvBkA0mB8RDGzjf+0Aqc28Sunk/oVMywOgWc2P
 VB7bOqXZgFp2p1z5mG1OxukfQbga0zRSB6pnUZmelJxCA2n2fTUNzGUpTQdAotg5ewD+W
 ShO82Yc2QACGxFTkFgVC/SQcKLqb6YPQGIMcZL+DkUEJQ7MyV+l+UHSsDSw8w7FV8xwOd
 Wa2FuYpNb4OpeB6uV8rGTqIN/sXCQ369KJLi+jf4yY4W1rj/9j+xDhCy/rwuApYb2LkAL
 Obh+ovg4u/JHavHKqzRyofYaxD9nCOfBg2MkCXkNeh1YleZHZe1sPsirLsrbP1qQASg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=AI4abWE1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=AI4abWE1
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D4FD60B70
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:19 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so53518355e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791463578; x=1792068378;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TXinAbatRsEMtUtBMVWkeQwgMl1Rc2vT60N5Ns1XSc4=;
 b=AI4abWE1QpS4Yb7gfkZyThl/gQ3FvoqsnnyUCGR0rGzN2/vZnh7+4tPXS1dZ9vjZs6
 vopLWnmsly0bzlF1/LJqgAPpd18RP0dDvg0WoiRu6aMoFchsEgPi8fgiYrpZiJMCrrin
 N3bVYoc5mKh42lwvuWYR53H2iT0cyca6QOYtnmZB/NG4R5jIgd1v7cYGGmCH0VKhaQIi
 GXKWZFyRTQcuRWxmR2pBHvTivoMgvhIRMf6gvsAqIGaL8m/Ms1t35rHNcLqXn4C7J9I6
 4a33IgKZfuEQQw3qOLbNPeEIklY7FfSABm+GqWs7FBtXaEqJUYH536PI9+dWB1Nb3kB5
 H+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463578; x=1792068378;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TXinAbatRsEMtUtBMVWkeQwgMl1Rc2vT60N5Ns1XSc4=;
 b=Uh7BqdQZQ1ZR3Phh9z/pgyrJ5fPMlSUKPMGsCfkA6uIE5Gx9QfdiZ9J+BG5H6gnVAS
 xU3GObUXV/QzEGkDRTLc7BS8sZ3YQ0HPOG8KokEghldYrw/VnPiLOhzYj04XHQtqjONp
 OA4wXfD4lj5L/4tu9SjVMDKiXM7ubre0UNV30WANbGMrvPAc3Cn1KbqMA+N9x1KPIQCt
 4pvKyxRaUIvwF+TY1NxGka5LchGwmTVhIYrNDaaohEHvNcJhaBWLsyUG+spZNLJBugPL
 TDo1br/Dl2bqZm42d6gpPS9/pmJ0c1SxUQSCGe6RVAtw/PVKGtLd86nXRcBfNgVsKJm3
 0LdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwp1L101eJbkPzRgR5ZhTtNxgbKMu2QLldMyscwBJAr8qbA+rSyU908R9dYlPWJEG5yN5SOXt0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nhQPpKZSaKbLZh2OLR9ggsg/YS2ptn/ORJdlVGGnhZ5L1uWcWL
 iRp2ybfhahlRucPTa+pBujb9QOfSq5pDXr+/U38LOHkYcm9dsivWl8Atk9hDUS1eRds=
X-Gm-Gg: AYBFou0K+HY7tvZhvQUc1gu31jaLnfjNW0KY6sMn4BKxYG432GzEBZ656fry+TlNs4b
 GcBXna7nvv8NF2TnHCvQ11vP6qRDafH4dTvBRCCNIx1Vk6HRv/CkyG2nmFp1eRqjSYW7zepFwF6
 wSeDK9dB4Sjd5ZUiW+5jpteygFdzwhvU41D0LPYVBuD4DtTzqcYG+nOVY7iqnbbhbAQAQjD7jm9
 Mcd5F2XICRIK2eY8xPGcKJv7aW0eKXP1nvr2QLIK/15jxwBz1vMb52DUWkUj+HtYIdHfythgQL0
 vxAWVBSTl0Hvh3ZP5rXBMq5wBqNFE2ASFYLlYMXdu3sAxyWJD0/ww6PYPeLHlNHwH6yw/0AXAzk
 CVsuXmucnmKld0Jb5FuSCK0vmAbMa+O9tdgMdP2j3cL8ekY2tY4FhPHEUn/J7EYgUoTqPmO6jyM
 EiFvFcXqIJLwYGwHq1jRAvRp5wnpVCQLDp9bARZ3V4T9duHS/AInVWiDwKNz8xToy46ma1VYzD0
 BJOZMCqOryJ3295iOs4
X-Received: by 2002:a05:600c:3e08:b0:4a0:1cfd:314 with SMTP id
 5b1f17b1804b1-4a180455651mr109791165e9.26.1791463577722; 
 Thu, 08 Oct 2026 05:46:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:46:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
References: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
Subject: Re: [PATCH 0/3] configs: sei510/sei610: drop Android support
Message-Id: <179146357691.183177.6890118451387915702.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:16 +0200
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

On Thu, 10 Sep 2026 16:04:21 +0200, Guillaume La Roque wrote:
> Remove Android support from SEI510 and SEI610 while retaining generic
> board support. Both boards switch to meson64.h, leaving the shared
> meson64_android.h header unused, so remove it too.
> 
> Fastboot remains enabled, but "oem format" is removed along with the
> Android partition layout.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/3] configs: sei510: drop Android support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/bea8681a949120c5c6b030ae9af8972cb0c35d28
[2/3] configs: sei610: drop Android support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e06e8b3e79707753936e0e881113fe76cbe5534b
[3/3] configs: remove unused meson64_android.h
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/aeb24d97a378ea1199ae54b6c272a32b60fcdca3

-- 
Neil

