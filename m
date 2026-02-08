Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DE0EE0AF7
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 00:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDCB83AA7;
	Sun,  8 Feb 2026 01:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YG0aCQ8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2619883C5E; Sun,  8 Feb 2026 01:27:52 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11B21839A5
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 01:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-4094f6f4b7bso673137fac.2
 for <u-boot@lists.denx.de>; Sat, 07 Feb 2026 16:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770510469; x=1771115269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Sctap2Pxdy8CFCiFQYrFXlpdHsAqbbyeYpVwp72ElE=;
 b=YG0aCQ8xRMHobi5sj2IF7s3erWTj+iXJlHpyGEFxCFXFYFER+jOhsBn9vNpeScJFRc
 jrxTfRrkegbUtWVZEimaADtVybqkNfRXQgM04y2BUudEKCSFnRGyuYfGom01heAiQRCh
 BF0qKhCfOThBrnsxUwDExU0GGCxXEiXoKOJ0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770510469; x=1771115269;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Sctap2Pxdy8CFCiFQYrFXlpdHsAqbbyeYpVwp72ElE=;
 b=fi+d1lVpMTaD6RHl0Pq1Eu4Wk3XdK4tx+d8TSwel4FJmNc2QJmW1c6ip9p/WOIBC/q
 0ro9D/4hfszCYA2MU6KT+/tDlQRLBRSv+t8YcfZ3eajP/L1DK7BabcpbVyWevvef3C2J
 eAeGYm6xTQaze8zRuMbkAu242J3h2NptlHGUSkMTFnXNYtwx6P11CpP9kzJRVbKYL069
 Kizd1xPiji7OSIHkjOMw19g+Ft+Z5H75NGYhXPC2GALjLld64GpxMbKnitwfXriW7skd
 7Wnes5/axrngLEVRCxj50+l/F6wx7xsG9USCRqhpq1c/yh6wCM9iJ/WQUisqnD+puSwJ
 oOvA==
X-Gm-Message-State: AOJu0YxKeo/if3LZnVeE12CY+ZgKShVwZ8DQA8Qlt/A0gvvqFoHReM2b
 uJiUaushOEkkc6cRGqndzHRxh/onXTzX9QpebcFEc4R6l1EZ3JS4vHaJMvHRQVtIUgE=
X-Gm-Gg: AZuq6aJZYlDAa9NJbwMyCnroiRKr0+YMx7GDxIMzrzzduuo+29MJk/3NHLRbyoAmPve
 8Lvq+Un+1r05kE5oxXCvI082cjvkJ4aUK+LXecTn3D1znMTw1u//29yjgW3+CqBpukJaVSknk3t
 fu8NgHSjbrJXIgQYIAzKCrWscKx3ErlvCcqZYYLJD1On9k3A04A6p31jxoW1/1XOBX7xa5KUYDG
 7fppNmse210ElbrENxhcurv47ApJati/mQgnbe11kA3VJR5oV45MWZz61d7n1/d/mqb5ZXl5tSs
 pm45KTKA2opeGSXagj7D430VKpkL9whhD+/s8NL3wDdIIYdxMQjDroXxsk5raJgxQgnyqHGC+BS
 xRvaNqqVVCV6lNpkSI7CLsD/mmo+OxQ5bswtArrkNRtf/tlfZkUYo5Rq2PaCZp6LKW1bBa6nWxi
 NE10eU6zqzLV3pJCcH9c/mFl1krmuJxkdJ4FjPL3hp/PCzErXCIYaUGS3jHSzNiC6cDAP/OE2eI
 VG1iMY5rRdkrJa8zs0zu09sD0LEuO3pgqPfrQ==
X-Received: by 2002:a05:6820:4dce:b0:663:22b:1486 with SMTP id
 006d021491bc7-66d0bea5c4dmr3269213eaf.41.1770510468880; 
 Sat, 07 Feb 2026 16:27:48 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3b2a6c16sm3552448eaf.16.2026.02.07.16.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 16:27:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: bb@ti.com, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20260128123623.2737451-1-s-vadapalli@ti.com>
References: <20260128123623.2737451-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v2] arm: mach-k3: r5: j721e: clk-data: manually set the
 main_pll3 frequency
Message-Id: <177051046798.295305.3858119696258241990.b4-ty@konsulko.com>
Date: Sat, 07 Feb 2026 18:27:47 -0600
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

On Wed, 28 Jan 2026 18:06:21 +0530, Siddharth Vadapalli wrote:

> Moving forward, DM firmware will no longer mess with the MAIN_PLL3.
> This means MAIN_PLL3 will need to be manually set to 2GHz in order for
> the CPSW9G HSDIV to have the correct 250MHz output for RGMII.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: mach-k3: r5: j721e: clk-data: manually set the main_pll3 frequency
      commit: da6d5a93ddac5e60ebc84c75456318fa20a8f995
-- 
Tom


