Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BC41099B3C
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 02:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 523B583F00;
	Sat, 21 Mar 2026 03:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WqSkqejP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D290883FC5; Sat, 21 Mar 2026 03:40:47 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E3083FA4
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 03:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fd3Zg6h4wz9tbS;
 Sat, 21 Mar 2026 03:40:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774060844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ooacIPu9FpvODFwrhsUARks5otfa2uj9ShxOv6alJzs=;
 b=WqSkqejP5f9ML6HrhGmggFwYy6k/xWt3/HJaYcpqtpBQZ6KryiSNYuxt5s9lWyiMhfnUbD
 cNFmJmZRFud5a/XxOvw6Lv7Zag2fSrCpwk9KX3A4ZQ50JvmSxbPI7Tvqza+M46s/BXcL4c
 a324RzZTxyDGRdRbjjPQCvGbGdGQ9rcO31xvFHP0pB83wLYwAnsi61o/JXQINpoaDqovI6
 8xSbu1JO7T61cK4onozXl8KxcTZuyV6k74PA3fpS5Ebq7Xnltb8Sg7A/EtDdvwKy6Sdkwk
 dRB6+ywB96KR5y9/NWH8a5Tq4FG8XEQSquzRUt7Qig7JBjB39hoooFqP3E9utw==
Message-ID: <fe03dfa3-75aa-49aa-a11f-8c724199f1be@mailbox.org>
Date: Fri, 20 Mar 2026 19:30:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] optee: Correct dependencies for BOOTM_OPTEE
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com
References: <20260317012452.4162719-1-trini@konsulko.com>
 <20260320172458.3587330-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260320172458.3587330-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2c09feab63035364346
X-MBO-RS-META: iqcr13pgytd84ws4xwshz1m4361mkcwi
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

On 3/20/26 6:24 PM, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue with the dependencies
> for BOOTM_OPTEE. This symbol needs to select BOOTM_LINUX and in turn
> depend on the library symbols that have to be enabled for BOOTM_LINUX to
> be valid (LIB_BOOTI, LIB_BOOTM and LIB_BOOTZ).
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
