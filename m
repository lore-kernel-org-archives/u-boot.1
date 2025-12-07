Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E629D2CE17
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 09:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4499D839AC;
	Sun,  7 Dec 2025 10:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gfjTUKsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28915839DF; Sun,  7 Dec 2025 10:22:00 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C62F8397D
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 10:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dPKPZ6DKCz9shw;
 Sun,  7 Dec 2025 10:21:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765099315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ra6tZ3tUt0y2aSadH5XHEnsWTYJpwG04gDrl1km/F2Q=;
 b=gfjTUKsbzPakSe1VU7Qpj8YTgYEom2dYTuBHIK3xGkFX1He7UAko/n6OXnTIiCdXuvRfXJ
 EUAoY8eWe+I3sFyddNGX9uIUBg4IAg1YKXp0LuCep2HmdjTXkzt//g/DqnbkoOL1JLqvSh
 zNzmHrpla/tstfCoMAmVNRpVN0Lv0W83WH/H1Ik11lxOJMrkd6CEW1o4X0FoQZZZTIiyZ8
 zEzrye/K6S7qW/XQQRxj8pQHjj9bieVP/MsYKaMb+Q2pKNfngG9KvN1foRC57prWjxlw/u
 b8Ku/k9yLLKR8wqi1e/DY0JJldD2JQN/b/xQOAqsjkOoVe1D1XcX8JFGV8dlEw==
Message-ID: <cb9bcc7b-a59b-4800-8378-d664f82f50b2@mailbox.org>
Date: Sun, 7 Dec 2025 09:21:38 +0100
MIME-Version: 1.0
Subject: Re: [PULL] Pull request for u-boot next / v2026.04 =
 u-boot-stm32-20251205
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
References: <24fc65d7-befb-4e8a-9bd6-46edbf87cfa0@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <24fc65d7-befb-4e8a-9bd6-46edbf87cfa0@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4doo4q3no5ht77ckb79pwchee5ik3w4z
X-MBO-RS-ID: 6370d8f4b889c7d6b1e
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

On 12/5/25 2:24 PM, Patrice CHOTARD wrote:

Hi,

>        stm32mp: Fix handling of OPTEE in the middle of DRAM
>        ARM: dts: stm32: Fix 512 MiB DRAM settings for DH STM32MP13xx DHCOR SoM
>        ARM: dts: stm32: Add 1 GiB DRAM settings for DH STM32MP13xx DHCOR SoM
>        ARM: stm32: Add missing build of debug UART init code on DH STM32MP1 DHSOM
Three of these patches are fixes, they should go into master. The 1 GiB 
support can also go into master.
