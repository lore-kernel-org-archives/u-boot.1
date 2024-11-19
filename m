Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ECBD6C2B4
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 22:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 646F989072;
	Tue, 19 Nov 2024 23:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ns9CIcvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C6E89586; Tue, 19 Nov 2024 23:12:41 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC02E88C98
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d18cdab29dso10162676d6.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732054358; x=1732659158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xecdz6TPvZgAkntTnNmg2Zh/cKxslAlgDy5r4DWoTr8=;
 b=ns9CIcvU7HPYBuKlx918jEPT2I6LrbdUiIfFCmGwZJiGPR9oXQ71rUX+TYJKWu17jU
 JwdO2zq0hW/ejt/cS2cNMXnl8tNo/Doc1wWJyh+Z83OObCm4wIj8VYlhD+V7FAE1ukCu
 bGGZ3LEchwN7QCVCTjuV4+yrgGZ9iC3V9JM2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732054358; x=1732659158;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xecdz6TPvZgAkntTnNmg2Zh/cKxslAlgDy5r4DWoTr8=;
 b=dlrSwjQYHUCrQPq4JpJW4ETPwt1wDDs8VAjuLF1tGYvAVniPEUOhk3nuxnfZ9hjtsA
 4R1xWnTDNKh5Zguy9tnGGmqAOBqkafocmjU3BT7XQnP04F4N/Soa1eqAnqCJnF42r5yU
 ThK2bAZk0P2Loe68F44VpQr41ffNQhpDuX8z6Srvx6F5lS/W8gFqN9L43SzvxRdtWTtJ
 asbBHAs8T8+tSOwVQYUWtR/IfAWtx38XHpq603oyL9J103yP61PTreEZ53CXTSl5MUMV
 hdMziMUa+P+BWWgHX89dzRtu44V91m3GA1lD4TFZU3pVhlKGe+cmKv0PJAaF7/aWGOqJ
 CTsw==
X-Gm-Message-State: AOJu0Ywer4XU+9Sl5wHXmAdwQ8FH+JoJSl7riXMKhXSAityjyXxtX/Py
 9d04VQlhIJmUoxmo0CE+FwCyacNlvdsp04HmpZvV4hpxR9jo5Rs3+7vQ/cEv7gs=
X-Google-Smtp-Source: AGHT+IHie7Nt096nEgIeR5BdEiFF1PiBzKhtET6cOmfH6NpKUMeT3F/0oUadREmvf+f3+5jO+taIXw==
X-Received: by 2002:ad4:5ae9:0:b0:6d3:71ab:adb9 with SMTP id
 6a1803df08f44-6d4378638bdmr7828056d6.45.1732054358717; 
 Tue, 19 Nov 2024 14:12:38 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d43812b003sm1433006d6.83.2024.11.19.14.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:12:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20241108152350.3686274-1-sjg@chromium.org>
References: <20241108152350.3686274-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH 0/9] buildman: Add initial support for config
 fragments
Message-Id: <173205435731.3525042.11668720224374313535.b4-ty@konsulko.com>
Date: Tue, 19 Nov 2024 16:12:37 -0600
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

On Fri, 08 Nov 2024 08:23:41 -0700, Simon Glass wrote:

> This series updates buildman to process #include lines in defconfig
> files. With this, it is no-longer necessary to duplicate lines certain
> lines from the include-file in the defconfig, e.g. CONFIG_ARM and
> CONFIG_SOC_...
> 
> 
> Simon Glass (9):
>   buildman: Add a lower-level test for KconfigScanner
>   buildman: Set up the tout library
>   buildman: Support #include files in defconfigs
>   buildman: Correct the indentation in the setting-up section
>   buildman: Document the toolchain-prefix section
>   buildman: Correct logic for adding a toolchain
>   buildman: Support a tilde to represent the home directory
>   buildman: Propose a format for extra boards
>   RFC: Show building with #include in defconfig
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


