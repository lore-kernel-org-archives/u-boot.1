Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30228CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1AFD83936;
	Tue, 28 Oct 2025 17:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="itiiwZMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B9280422; Tue, 28 Oct 2025 17:57:37 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D20A838CC
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-475dd559a83so21077125e9.1
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761670653; x=1762275453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSTco3xDXYvmDsSP4TVelhBOwcikz0kpeMZeCMtuRzI=;
 b=itiiwZMpjTTJoyB/S6nbKE3WcbgsG6Qu993VjuPkLgSJlMTe4i5bXez0ofhTX0A0o4
 VaNgp+h7Fq27V/vBekoXMNTGo+kBkgk0JsYuX7+71id2tn8X0i17AQWq1r8BkF2XUrHQ
 eOJtEkeKdzZW511BaRwlnVgPpcmsNiiS9il0y+jHtHN7uuQs/TQJ4smt5FT4rwUQmEfQ
 a9risATLk7FW+f4WJhe63zxvO8l6PyHYZUMm6+dlgkPNF0ZNOP1Sjb6jBqGzGRbzzgxC
 yHJnF7eLZKqnV30VLZo+CWO74YWHUf31WmPCnVJzKWJbxU4OkDNCtZKkfz4yQPIR0OXy
 CAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761670653; x=1762275453;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSTco3xDXYvmDsSP4TVelhBOwcikz0kpeMZeCMtuRzI=;
 b=SUX53ncEfsnVSNDxy0RSEeVbA7yrBlM1NO/V57q3RrJJXWGWHLHn1Rqwn3HvwEBRyF
 pL8Br3QvvozIsZKDIdfdT0+pofTJJoGB91T1XKP50sQ5j5H7uTqSJyIwf+htKhbRcv2V
 RGyq9g/yJuqh6P/3vRJoYO1hPgD1miN4+U+CE3YN9ea7EAjS/SrFEOlXySR0tRRelI5S
 i9qE3XX4YM3URH5IGK1xpeVt+3KteOgsHFHvTEMaa4Rx9KL3ocpTikQTNjKVw8+CITRm
 BUnHn1I198vIEEOd64SM2PKWmf+UNbXtnH2TGi1cP6fZMzp6F+DyemoOp+0jeU+29/AU
 cPuw==
X-Gm-Message-State: AOJu0YzjxPA8b5Mcnxk7YLbGWqUWvur6y0THjnvcc3ImfbWE2GT0fs9S
 5/jlqbMsaWoESGPv8WFHSfYMH5pXhYXaEFtopg30WcpYs//CfoPo2rhmLUXnhaZeUQrJmuvLA/k
 JyEhHdVk=
X-Gm-Gg: ASbGncvk5ymOYIBdttjnuTdSWR/7eN/7+B8vWxqQg8JT+WmXxozH/6rFjqtzYeIVgxy
 yaJHxRF/uyLkqJ90hvNiT7EcD3C4UQ+jomrh+MdGDc53zbvxBkwXAmNut7OtmojlbOLsX/rG7b4
 jM7c2ibmJrSPD8AczZA3jUwcx9WZBflLhDgkbGUZ7IokRyXOb5WiMwh0Yv7khPImd0q9qrkBW8u
 nm5VxPK+sVBjDEi2rtxBKqeksXq/ZX7E4owy6tthFwHxhno1ryIqMNsiR5cY6sXAkh87JtYr3e8
 WNKP4MlpMCR9qwHABckL+tla+0uIMMYQJHtLWn2ZqgxnMWrwbAdzoYXGOP1P+ZxnZ33Gjj/4N53
 +I9fbIOJei1xfWo3oUmr0WGw1OTlPzgyv4nDagAExy0vAIWzQT2bDV1uN1PNb80ZJtiq6PUt6AI
 VnNz8nElAGKrnZAK7Xtp9s
X-Google-Smtp-Source: AGHT+IHMh2HnyX0OUhbUSHaqvTDGVKK44VaLJBftzWokJX4G8Zu3V2tAp0YQyJnYTpITrKH/6FANLQ==
X-Received: by 2002:a05:600c:608b:b0:475:de12:d3b2 with SMTP id
 5b1f17b1804b1-4771e1f1dc2mr1329125e9.36.1761670652900; 
 Tue, 28 Oct 2025 09:57:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e222ca5sm1971495e9.15.2025.10.28.09.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:57:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Jared McArthur <j-mcarthur@ti.com>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, n-francis@ti.com, 
 bhupesh.linux@gmail.com, u-kumar1@ti.com, bb@ti.com
In-Reply-To: <20251010195556.1772611-1-j-mcarthur@ti.com>
References: <20251010195556.1772611-1-j-mcarthur@ti.com>
Subject: Re: [PATCH v2 0/2] ufs: Add support for setting bRefClkFreq attribute
Message-Id: <176167065236.4104072.12544235485943211811.b4-ty@linaro.org>
Date: Tue, 28 Oct 2025 17:57:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 10 Oct 2025 14:55:54 -0500, Jared McArthur wrote:
> Currently, U-Boot doesn't set the bRefClkFreq attribute before
> changing power mode of the UFS device. If there is a difference
> between the UFS device and the host controller, all commands will fail
> after switching to high speed.
> 
> This behavior is rarely observed, because Linux sets the bRefClkFreq
> attribute on probe, and the bRefClkFreq is a persistent attribute. In
> other words, once Linux has booted once, the issue will never be seen.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (master)

[1/2] ufs: Add support for sending UFS attribute requests
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/ae0872e9c38394be8fcdb38ef391e635d4cf7a22
[2/2] ufs: Add bRefClkFreq attribute setting
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/c7327ac29590952089bf3d8994d0951e58cc2322

-- 
Neil

