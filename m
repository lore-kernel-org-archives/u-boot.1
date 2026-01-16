Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618C5C982E8
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 309BC83B7F;
	Fri, 16 Jan 2026 19:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gcZRHUZN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C666583B8A; Fri, 16 Jan 2026 19:03:41 +0100 (CET)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C35883AB7
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-b870732cce2so359494166b.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586619; x=1769191419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UebgEJcMBBfqC+c05gyOF2vk2BpcDMe8caGgis8n5SY=;
 b=gcZRHUZNiJ4M+kCa6qmO4lEa9bESkZmzlsDTjLisfzrhnD5zFmObZBJGh2hn6YUFWn
 JXAa4Y3JvAiEgNMEEQrICMu0u10XL3j4vYJA2DeCZB3oeqr0mWJzQMjNth/ftYtWTzTX
 no6Togavbex3oetGG3bC9Xb6zEwAo4ieYELNhMOoEk6qh/6xIjPcHolJwqpbwDoNl3he
 14vb8vUVD+h7eCSOQLC3da3Ie+8MpXLJgSn6o7J0q1Ujbv9tP/RZRhHITH1CLcEhE/zV
 DQLDcRCx6K84eCRM19HpyiHRomgff1Bu3LBSa7NfpD1ThU6DHQhxuODmBV5vqokdefRx
 5KXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586619; x=1769191419;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UebgEJcMBBfqC+c05gyOF2vk2BpcDMe8caGgis8n5SY=;
 b=AMzGBhVrpZ8LHbOiHpynltHW8hUMRia+9jzk9/+0++oVsP9n9t+zL2oAD4px4SOos4
 geayL0tQvIC9z28XbvRuoLP3OFnTTqLwcYD5NciLFZDmsLoSA8jqjQ1mY4vaSbr84llT
 i2FJ1RBmgSk8tC06z7HFPeIghx4yLyBNQhyf1IWyhrSsNxPG0tEslwUAvkpppq0DEJAt
 a5OW//vETpvRi2En8hAvUMG6jZb57BWqPhh5m1UgzsdA4+TcICLr4D6DwdgN+TYZ0JpF
 fzUHRn/ATwZYFwgJJhufs8OHEj5qFQi1E0HK1ykZR006de5uTBMCowLwQ69JiYoLwhgR
 A+xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0yyaoal2kFbZicS4Nk13n/C3oHI3ikK4AWUCf+PtQq7MZ3UtvVz7tgl1dV2zfbtezePb91z4=@lists.denx.de
X-Gm-Message-State: AOJu0YyeiMAkSUrMZc5O8m13x9oaVGu2WgqO8Gk+747qohEhJu9EST++
 GYM8nTWRWXErhwMP9mzXafyXsOKXC4/eOwWxVZSgb0ymwd4c2N1mVYbRQ8en5c7gQHI=
X-Gm-Gg: AY/fxX6GN7d/COFzR2Q/520qVGfqTrVYOY2wD5+tmb9Nr1JwnomPNLf3jr/nnZ7O7HH
 P+w/demvOJGWx0NIlcG7HuyxQ7ANGfaRenCA8h6XHne6bpYQrJsSYi/ofprxG5nHQ/ZpfBi2ahQ
 Hz+B3gxUXCAguK36e88cQUGcJrpGLL/UsD0nhZYJgOfzR8xb1BRftJeRa8IWWchIlGsl6+Fl8mX
 Feuurd+SiV2u/npLHjYVnnsF1Qf0xmpoXOnL5lNc+XOqcqzrmvgAiJuwELvtAldZLJVnd9DrmpT
 uD9unwFF+XG5xukfPM1q58i5km+92FiGm/JZztOKW+xz0166IfWGzyoDsfFSIAxtHefsyQ1evfn
 sqDfROx7+S7Z6MQ/v6bKstVvX1aPQXjxzDX4zpVKkQK9cXwXe9LIN1jhfnKUmBXigw19ReLPst3
 jldifKZZzqnflANsFP/QCQUvIeBKtsKvZ6XELpZj5pYe/KPgSWODDYWA==
X-Received: by 2002:a17:906:6a25:b0:b83:e7e:372b with SMTP id
 a640c23a62f3a-b8796b3fa41mr236915966b.44.1768586618965; 
 Fri, 16 Jan 2026 10:03:38 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:37 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: lukma@denx.de, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 trini@konsulko.com, swathi.tamilselvan@oss.qualcomm.com, 
 quic_varada@quicinc.com, u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260113065856.3287772-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260113065856.3287772-1-balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v1] clk: qcom: sa8775p: Fix USB clock configuration and
 add resets
Message-Id: <176858661692.3399278.7755036018481117606.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Tue, 13 Jan 2026 12:28:55 +0530, Balaji Selvanathan wrote:
> Correct USB30 primary clock RCG configuration and add missing
> USB3_PRIM_PHY_AUX_CMD_RCGR RCG configuration.
> Above taken from Linux commit 08c51ceb12f7 ("clk: qcom: add the GCC driver for sa8775p")
> 
> Add missing USB3_PRIM_PHY_PIPE_CLK gate clock definition.
> Extend reset map with USB-related BCR entries and video BCR
> for comprehensive reset control support.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: sa8775p: Fix USB clock configuration and add resets
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/f4886799a0af

Best regards,
-- 
// Casey (she/they)


