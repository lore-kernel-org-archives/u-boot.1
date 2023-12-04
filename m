Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0280C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 15:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E5E98755D;
	Mon,  4 Dec 2023 16:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aBWKLSBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB98B8719C; Mon,  4 Dec 2023 16:54:18 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0313F8719C
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 16:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso46117605e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 07:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701705256; x=1702310056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WoBLP3TcQFzmfczrHfgPA+b5xSwmAnDgCGceIepFN/Q=;
 b=aBWKLSBgf46WLm9XglIqwN/iac76aYI9RJVRV7DL9kC3odj0nQ63jgUSBoo8hGx0ke
 Jb1Iiklpxe1PVm/X4JhIMWM9EtdEOXMIj3HfMJGizpeDLcoHzbEVJX9zACs0cFrp981G
 TC13csR5OTVhewcammyD81ZIXJVLteChNcIxj5A9434FmHQ18j0zA3pS4Jl5AGGsGiXO
 Rub/J+6SS6x502SOCpTwey4+qu6KSCf5o6NCFiA/YUR8uuWQ0/AqPxj4f3zWShROWjqI
 5JiZaYpJXTvq5KnmYSYkRD4nmPrhLb2lUono5m2wvmRnFgU+vhYnCzocbbHPv8dPtSWv
 qZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701705256; x=1702310056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WoBLP3TcQFzmfczrHfgPA+b5xSwmAnDgCGceIepFN/Q=;
 b=qM5nrKoKjlKReO2aH3j5U0bOP6NBkjrFCKAYo8CTuWmgOgrhAnahoZ5Uedn9PcLXAB
 MczlEyjvLVGCAbTTRJsxUb0wDh3MvZcMhL5gVsSwG1GEgp5uOOkr3M3VqgUqO8V4qCQs
 BEwNLcW0/ZF1JVHaG8kwt46V/QLxO5ewacwL6vzRkU6Dfjp1JKrJsQfYZQS5bleth65F
 bROPY6hFDGRqS1D8rOo/C3NhA1eo/AbffZ3M4efxrl+ry5EKbkXKGyGhAmZBiEKsRZ/5
 G3JD4VQS09tvM50AaGeLNG4GbNbNFmBG/7WEIOXX3u/gGWwnqeLHekMtkprEJmseMb4H
 AYEw==
X-Gm-Message-State: AOJu0YzsqsSuo7KGjqunaRflxb+aLyJvOgqD5OgK9MneSKOnPgclK2Rq
 f1h+LaA7rzomFBzJBSdX6ZEe8w==
X-Google-Smtp-Source: AGHT+IGBH86ScbqZn6GjWlgZZuY10BL3+F1jqZN4la0Dehsb74OYgWC2frLjNN3Hlr+nK7LKsHZpFg==
X-Received: by 2002:a05:600c:3584:b0:40b:5e22:954 with SMTP id
 p4-20020a05600c358400b0040b5e220954mr3122134wmq.67.1701705256304; 
 Mon, 04 Dec 2023 07:54:16 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 ay10-20020a05600c1e0a00b0040b397787d3sm19249356wmb.24.2023.12.04.07.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 07:54:15 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] serial: msm-geni: rework oversampling and fix clk API
 bug
Date: Mon,  4 Dec 2023 15:53:53 +0000
Message-ID: <170170522351.224390.8746214675614893917.b4-ty@linaro.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231114-b4-geni-uart-v1-0-48c8ba9dda36@linaro.org>
References: <20231114-b4-geni-uart-v1-0-48c8ba9dda36@linaro.org>
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


On Tue, 14 Nov 2023 12:51:10 +0000, Caleb Connolly wrote:
> These patches improve GENI UART support during init by implementing the
> parent property read directly rather than via a misc device, and fixing
> the error path when the clock can't be found.
> 
> In my testing, the first few lines of UART output on platforms with
> non-default oversampling values is often garbled, this is because the
> parent misc device hasn't yet probed and so the clock rate is incorrect.
> 
> [...]

Applied, thanks!

[1/2] serial: msm-geni: don't rely on parent misc device
      commit: 393825c304411c6483dbfbc45ea09c577365ddb9
[2/2] serial: msm-geni: handle devm_clk_get() errors
      commit: afd9dcf23cb232dd5f352336c6b389691682be47

Best regards,
-- 
// Caleb (they/them)

