Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA351D2A520
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 19:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F28E84099;
	Thu,  4 Dec 2025 20:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nCTwR1qM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2186B84083; Thu,  4 Dec 2025 20:31:53 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFABF84083
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 20:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c75fc222c3so671436a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 11:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764876710; x=1765481510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMYVLjqJmUtjRuLRjT3uR8EgJN/+gwN561+n8KfNsqA=;
 b=nCTwR1qMbRQDKWiMyNb3PtczKArmaLeZChk004ZaNaYEa6xzV1o4vzOCgSJRb6sxwc
 g6Hmt5w2RkX+ln4ZoZC5eYGFBY7MFdr+qjDp3hKtsZmB79FYCpMyvw5EWWalllchvsk6
 IEXjqoeNRiFBm7kH3XlYokPtQxTVkYRZ6i19c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764876710; x=1765481510;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wMYVLjqJmUtjRuLRjT3uR8EgJN/+gwN561+n8KfNsqA=;
 b=drEEIFv0Eh3a7TffV4Rp1t0pnPpm/cP+JukoQZfy4GxweVjZnFjvYem9n82DiXRjQl
 BgRouwiQEsLMmZ4Tt4pe03BN34YpTWzc8kMz+EI3TKHCJkoLo9OriIM1F2N7k0BUrVDq
 uFQ3nms/zdmxncBf8pWFOhtlzrwrxot+TGOerMFCpzbkjWu69I/NbduvPbt92Y2Z5Xw2
 JQ87q+QNLEXLVrWPE8IODZxPDo12AgPsbLz4TC9u8FhOBqj5csXwI3+hKqXPn22f38wd
 A0iRkmyc68rmG5+Yyjq6U7FaMJYNCuPaIXAVM9MjUWWkgIvh5/I5jJdNgEXRmfeFH+4J
 Up6g==
X-Gm-Message-State: AOJu0Yy+4rW996gOwUvxnPv1iK5TAhHt+hQjkKsyzOxnwy+erKJEC4Wa
 vvni3jcaLVYVXCZqG7DUGEoGbKjE3KT//ADEP9fTEZxyuA2ZU2clJyoQO7nxIl8aMLc=
X-Gm-Gg: ASbGncvX4A20XD2aFvF2GF4w5lXoIqoSEY0hdnMRqeX+hwdOMEjEZvW+++r7odti1FU
 Ye0+YwSF9G3OziRKkEldBJ8aIJAt45KZN+aGZBLwqWQJHOlGS0q8D3DNMQmK58wyepGZDVo12n2
 ATzBL3FBU/5mRg0sPUkvfcX4gH0vAoLqSDOqzaPVSV1DaFtLnqyFB1TPI0eRH8i/BjUWEVR6y8D
 6L/lsXoFflJ/n7AX+CmEuV3CSInvjp7AiMGMFtwwbc0PjHSlpEyj+rarZjc8tOoqkL621eAplLh
 ZUJBqksYHs9pgdAR4hZNnq08+9Vn6OUQBtyAfEJUaTqRW1VupK0XtxPjOW6K+FkHZn4Ml07+kf0
 OBg7Vb1rdcxW5+uY+GwgJLLJslyALO6h/lNBFHNiNdhlBKOnpNwYYXyiJsMNFPEGUb/yuNPbSH8
 HBwZDJImQgi+Ck8075wXyy+bboklCL0t+7JTX7RenU8lptAOKQ3XE3U7Q108U=
X-Google-Smtp-Source: AGHT+IG8TIXzP71p2LeS/Vhjj5xl75wI+GD3WwzKjB99g1e1AMs1WBGTa9S8o0v4SBJZ/Fz5UMb35g==
X-Received: by 2002:a05:6830:43a8:b0:758:1e20:c41b with SMTP id
 46e09a7af769-7c94dc923e5mr4910806a34.33.1764876709682; 
 Thu, 04 Dec 2025 11:31:49 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ef0c840sm1147095eaf.9.2025.12.04.11.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:31:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tim Harvey <tharvey@gateworks.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Schocher <hs@nabladev.com>, 
 Jim Liu <JJLIU0@nuvoton.com>, Stanley Chu <yschu@nuvoton.com>
In-Reply-To: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
References: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
Subject: Re: [PATCH 0/6] clk: Fix some error detection
Message-Id: <176487670839.2050783.17210057518215020381.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 13:31:48 -0600
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

On Tue, 21 Oct 2025 17:08:24 +0100, Andrew Goodbody wrote:

> The function clk_get_rate() returns a ulong with 0 meaning an invalid
> clock rate and also negative error codes being returned for other
> errors. But being an unsigned return value this cannot simply be tested
> for with a < 0 test. Instead use the IS_ERR_VALUE() macro to check for
> negative errors appearing as very large positive values. Fix those
> places that test for <= 0. Also fix some places checking the return of
> clk_register() that incorrectly used ERR_PTR().
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] mmc: hi6220_dw_mmc: Fix error detection for clk_get_rate
      commit: e24a7b3b172379b50a7fa96ab4634de109c3e432
[2/6] mmc: fsl_esdhc_imx: Cannot test unsigned to be < 0
      commit: 42d30f9447c136d2c1f46c8a12e6058e3cddc3b6
[3/6] clk: microchip: mpfs: Fix error detection
      commit: ae4f60801f344aa26e3f2d1ffe6f6227be6f16a2
[4/6] i2c: npcm: Fix error detection
      commit: eb13583b9de27005703ab085d5ef45fcdbb1d4fb
[5/6] i2c: imx_lpi2c: Fix error detection
      commit: 40ad377c1619eb9b83d088a96f40b86a907c8c19
[6/6] timer: imx-gpt: Fix error detection
      commit: ce219307a21fe7166b13542ba923ee09aef7f2f5
-- 
Tom


