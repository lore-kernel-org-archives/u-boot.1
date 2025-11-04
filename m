Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC16ACCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 19:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 440E283655;
	Tue,  4 Nov 2025 20:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Om9PoWLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1490283623; Tue,  4 Nov 2025 20:05:06 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A4A18003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 20:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3c9a42d6349so7019133fac.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 11:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762283102; x=1762887902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmQlTf7hl4XDIHrZkJjSW2Y0NbggS0Mo4pZZEenKMoc=;
 b=Om9PoWLw9dFNd6Y5wEs6wvOz27jRT+JU9Cci8cZhzotHDGyg8vgXWXKKpPx5NytWk5
 n7zxSn2f//O3eViUMIxY+VScRLxp4U9UResUBcY7SlGfe9qaPRlMZ86Ey/nNTEKuVvET
 aPQyBVsXp2DwXtXyhrD5p1xu7easYO/+5XtZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762283102; x=1762887902;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmQlTf7hl4XDIHrZkJjSW2Y0NbggS0Mo4pZZEenKMoc=;
 b=iyIgou7LF2VOeSG5rrT0WZvcjmUXYovg9qlN0OubRixI+Jso+NTC9va7A31ZxSGexS
 dW5IT+hOKUd1u3/hRjuWH98DXGopnrtgUBmBcHGBckc9Y8B2hud+S93cj0VoD55+v4ei
 vGVFP37QPsgJtZDJBigMs4WA8YNMWbVHMS9krnamU6SfeQgQh5PKuWf2xPppjpU1pLKy
 fhh86GzEInZbjkWA9EFAqgqf0dwQw5lm9Hhq7ThymiYLdTSmIYzI/JZWU/+IPzCUiuZa
 G4lWdMT9UF151Dr4xU8SB1evNh7+YIqKipTJFAbhDs54kM6AXJze4pkLqQ/zkOVUm7tF
 9n2Q==
X-Gm-Message-State: AOJu0Ywf2Ed1fn47inrH1LB7Yir5Htmu6QhrXUKOjZGV2jH+4pKuPlJk
 jnNzARH8iOfwNWz0kmRf6gtSutyWS+P3nrCdymuJsMF84KppPw/MZpOdWDaBlhmSM9Q=
X-Gm-Gg: ASbGnct6fsnY3OI7P5pGGkcR1mbiAeWLctTn4dg7l0aZ+vZ4wfLTmA03T0Iia0yYqEv
 s1qeSK1nOl8tmFDonaw22c4HsVFndM6H7ghp2zE2aeyBflApjcJXrueW+uGxOGYwnSrbSsJNZ6E
 l08dz8shUCRJBYIAnwy88q/lMkTS96lVxc7WTJV573XQoEYKy7YHlT9ZSvL9iROwjE2rC66xxQW
 XwBMYjvWyYIiSjPrlwDpedplp7GK4Ut3jsD/OSF9wWQLRmQlx6Az5MyW2dzzzP14IWiQioQ3zSx
 3oAPIMLQvx/TJYTqYnM3kxlwhHUgsT6/BVDWo7iWKk35xTSkojwFyA3QQLheJ5vW6mApFGUR0qV
 CQ0ykDR0suS1wZGZJKSF4qHB3XYAJrX9NUvsJgNEGigVgj2/R8lVj3mneTJi/JcbXeXg+gJnbkz
 AiIqhNaWTo6oYL9O1ZQwEuiQOfMh5i1av7w/JBPQ==
X-Google-Smtp-Source: AGHT+IEkm/raNyt775d1DpHxNHHuhjWmu6G+6+9IZ4eeCTDxkrN0JfVw+PWFBEXHWkpKTlqrRmqP6A==
X-Received: by 2002:a05:6808:1983:b0:439:b1eb:3026 with SMTP id
 5614622812f47-44fed265384mr182187b6e.29.1762283102225; 
 Tue, 04 Nov 2025 11:05:02 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fe4ca9d03sm352611b6e.24.2025.11.04.11.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 11:05:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251021181703.598342-1-raymond.mao@linaro.org>
References: <20251021181703.598342-1-raymond.mao@linaro.org>
Subject: Re: [RESEND PATCH v5 0/5] Enable Firmware Handoff CI test on
 qemu_arm64
Message-Id: <176228310061.3992564.12873924159259004340.b4-ty@konsulko.com>
Date: Tue, 04 Nov 2025 13:05:00 -0600
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

On Tue, 21 Oct 2025 11:16:53 -0700, Raymond Mao wrote:

> This patch series enable Firmware Handoff [1] CI tests on qemu_arm64 by:
> 1. fetch MbedTLS (v3.6), OP-TEE (v4.7.0) and TF-A (v2.13.0);
> 2. build bl1 and fip with both Firmware Handoff and Measured Boot
>    enabled;
> 3. pytest to validate the Firmware Handoff feature via bloblist by
>    checking the existence of expected FDT nodes and TPM events generated
>    and handed over from TF-A/OP-TEE.
> 
> [...]

Applied to u-boot/master, thanks!

[1/5] docker: add OP-TEE and TF-A build for testing Firmware Handoff
      commit: 183299d9a400ef2c1361e4b4959f663aec7b4e35
[2/5] pytest: add test script to validate Firmware Handoff
      commit: f974e9b626323a940f308ba7174dff0607827aed
[3/5] configs: select CMD_BLOBLIST for Firmware Handoff testing
      commit: 5396bf30ab5f807d7e8781f058f0aef5e6fb4853
[4/5] ci: check existence of bl1 and fip in the test script
      commit: 7a3fae6a493ba4886e3b55cc27f74fc01efa72a1
[5/5] ci: add test entries for qemu_arm64_tfa_fw_handoff
      commit: 915f0b232af756dcf7d8784781ed4a37a8028413
-- 
Tom


