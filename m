Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EF1FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 16:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E578983FDB;
	Sun, 26 Apr 2026 18:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EW6XOPhI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="novj6LrI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E40383FDB; Sun, 26 Apr 2026 18:30:28 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 585AB839D9
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 18:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g3XHN0zMNz9tZW;
 Sun, 26 Apr 2026 18:30:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777221024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nICxkSB2FR25xsRqDMqoTK+q/26UQdnYMdaLCEW2j2w=;
 b=EW6XOPhIeJJr35AgQPdQgPOi4GeGDOHxrivyKlW3hyo11fe0MnpSeDAaPVXlM2mgRsbMvM
 2Jx1izQlEEmlxgr88BdP24uFNSqZdgWLhfsiwlDxHqGnwyQL0ZxVwKsRqj/DGF1YKukFoB
 QkCUH+GKCOeOjODhyOEZjI/fcyITbjhVPP+CeIbDeC6932b+mDiCcq1sk3hjKnY7kg58iO
 wfs4SYv+PknauGPsaT6PpyMHWRmNYWh1xdD2iodkLxVKQhcehUmD5bCC1uyhGJSmSxraq/
 /kux9ngmH70ZiUzcqps/t0KZBiemqlNvlyq1EqYWcCIP90+QZFZyjoupG7+avA==
Message-ID: <075921ad-8453-4486-96ce-8d68a6f6f05b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777221022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nICxkSB2FR25xsRqDMqoTK+q/26UQdnYMdaLCEW2j2w=;
 b=novj6LrIr5ect3K5IQ+rsHtIR6WGLzLcMsEh1zquJRr4gy72tf5kjsjUEcOBOJ1Bs69GzP
 VYgAGJJQK5cM/Cr+8Ci9a+XR0CZVGaQEZt4ugy++jaEfJL9BAaXTziBskBnPWGjWyVP2gf
 GeOcpGTrljws0dqvdTvdjjUUNNa7VnZbOSgdzuRKLDGj7AarQaXYLw2/NFJyZvvtqPslJP
 9yvCY5PLl0niRbKd50nl9bXxUOt9Sh7BUfwkwUWDWUsdN7Asx8mOnbdQ6nCcd/tu8Ff3Ci
 0+JIy7FBJBdOEM1rI0jzohWPSThuGol6YkzAwxW8+tlsuBQ/oBPGQYs8FDwUyw==
Date: Sun, 26 Apr 2026 18:26:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/6] common: move ram_base calculation to independent
 INITCALL()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, u-boot@lists.denx.de
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-5-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260416055948.130041-5-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 16122a77494de39b042
X-MBO-RS-META: 9mgiygzmx59ensp1mxah9rb6o5rbxtnd
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

On 4/16/26 7:59 AM, Ilias Apalodimas wrote:
> Currently, ram_base is calculated within setup_dest_addr().
> However, upcoming patches that enable U-Boot relocation to the highest
> DRAM bank require ram_base to be initialized earlier.
> 
> The default dram_init_banksize() definition relies on ram_base
> to calculate the start of the first bank. But following patches
> will move that function to execute immediately before setup_dest_addr().
> 
> So let's split the ram_base initialization in its own INITCALL.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
