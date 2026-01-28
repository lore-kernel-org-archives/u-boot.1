Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60122D46BF9
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 20:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C304683E1B;
	Wed, 28 Jan 2026 21:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IzBbdkn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84FE383C6E; Wed, 28 Jan 2026 21:18:59 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D9883DE0
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 21:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-45c962424daso120231b6e.2
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 12:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769631536; x=1770236336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pEyPdyuEvAy7K+GrqraKemxm1zzZpCDJr/Eq9b45IU=;
 b=IzBbdkn5u9WtYdIeCjZLDvhhT2wwFiPCcwlLKO/eidkkYOxFDUemRkdH20mxlnCCd0
 LCkf/zfkcEghW5bPRYtFW3vJerLZm5ujMxSCXrQLbZTawZk3Y8W35JrtxjUIqz0RFkZQ
 2bSEJy/TYL8xNpo6RuhFq9ildwKY7YLDonmow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769631536; x=1770236336;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4pEyPdyuEvAy7K+GrqraKemxm1zzZpCDJr/Eq9b45IU=;
 b=mskvQuksgv1xKG2tWWfynCESnDGB8MqtbqJvtoCR2TTd4APJVyjNWTOSl/I6KLq1PO
 AwszP0OnSSZ8oe+NRHO2552+4mwykVKBlajKdXrDhXCHHaCGPzaHBirNcwNFyHSdoR6R
 CbxYbDMzpluKXyv90ehdoIAD/DXq9GSeJppW+hNte8vZlBKyUHnLZA9iGaJbAw4rI3/g
 TbwFfpNPem3i+Cc6EdFnpT1pmLGvwR/z5ZyhJR9UIOEITdbbYLp/UvHOpCFhZjBsO1HB
 Hv0xwVrExYBlmsaYrgZ0NnM3pYU+hJz6/0kc7hJY1fwp/ICAkU63+QtrTEfyb5EnvCBC
 i6SQ==
X-Gm-Message-State: AOJu0YxfjAyRinoi2H+GtZAecnnouVl31ppstqcIj9puThkqp0f0cVRr
 fM5k9TY19L6kFYim4nrrIL1tyq1jMZOU3F2ejK/9U7AbzinY0UVQ36Xqcgl7ERMy81lbT53f4di
 L09KiG6I=
X-Gm-Gg: AZuq6aJ9uRFjFft3OKnPXkYBdqWNDAGO5WoXe0mEan7HpOV9BHvhIhKMQaPT0OseOXg
 G29inL8r6UrFbIlAUj+T1XgT7VTrwOpwI883PufspthJisXzCRnFsB1zdp9PEFWF+Xdph2/dRrr
 i0yDTHqtHw+HSUokAt75UUbomnQG+65NzIsW5olWQChlFzkWirAiY2gGR6u6OFVuzx33lABzOdS
 VfQAhHClQk39/m61eqjyWvRH65JZgocsZ36ZCh1j6pEwkAMKwbuLKRK1e8si7Xjn9qmIEh6BQqS
 0jo58eUyTGMe0qa656weK99jexISu1W8U5jO9d60yPgw6gF0zIllRFWgPxRG+lXx7WhfJFnsyr5
 4WLxRu+0+NxorQwFkUarHyJdLu9Rf8GxLOTdzueA3Mdx7Kd4Um1rFf0hQwl+R9xJVOkyzWwZDPn
 63gzGqnCI2NDLLbUmf3keukDbULYQXRRRdGc4IP2BoLBTftw20MYCu7MqvPRY0oJoo679XgDPyU
 9VhR1enmNS6Q4yIqkiz1mGUvbTSE9GRtu0pow==
X-Received: by 2002:a05:6808:10c9:b0:450:4cbc:b20c with SMTP id
 5614622812f47-45efc64e658mr3244976b6e.37.1769631535838; 
 Wed, 28 Jan 2026 12:18:55 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08fb82f5sm1799991b6e.22.2026.01.28.12.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 12:18:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>, 
 Adam Ford <aford173@gmail.com>
In-Reply-To: <20260127213149.1338179-1-trini@konsulko.com>
References: <20260127213149.1338179-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-Id: <176963153469.1736087.17968021607914550586.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 14:18:54 -0600
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

On Tue, 27 Jan 2026 15:31:49 -0600, Tom Rini wrote:

> As of v2026.01, no platforms contain any rel.dyn sections in their xPL
> phase images. Their inclusion in linker scripts initially was an
> oversight as part of taking the full U-Boot linker scripts and modifying
> them down. Then in commit 8b0ebe054bb3 ("arm: Update linker scripts to
> ensure appended device tree is aligned") these sections were used to
> force correct alignment for the device tree. This however, lead to a
> different problem.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: Remove rel.dyn from SPL linker scripts
      commit: 5ffc1dcc26d3df9e2b192151936cb98014fb6e49
-- 
Tom


