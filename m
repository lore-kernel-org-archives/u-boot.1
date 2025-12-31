Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAE9EE57C5
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 21:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987AA841F2;
	Wed, 31 Dec 2025 22:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nGbPDx3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5226C841DD; Wed, 31 Dec 2025 22:29:08 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7281984097
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 22:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dhNPX3BZGz9td0;
 Wed, 31 Dec 2025 22:29:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767216544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HkzxOmrFEFP8TbUFURSb6wcriaDC1VE85DnA+cxp1s=;
 b=nGbPDx3otWNeBqUc/mi17L2b1gjVAn6Jnjku+UJYYTjjkRppxqLPfmRzhAB7zViKFeZM5o
 MO0dW8CxoOvZSiM3vkeeUN5RedyVvBQQgP6VHw06XX9sLNz/0JSfPMFa0C2cRmieq4TRRz
 laev3QLBJsHPjXZ2Ht+7xU3+ihMdLO+a1a4uWngdxgt6Cfq2gcyPykwYKXESMY7NkzjPKN
 TOQgwH/UFFZDmnzC3bOUg0sFLtcC+LYlptoP67qqYKRap5r+Wy1lbyNOuTXT0p8GEuN/+k
 57UgA7Ewz8cAMo1xwEOp6/eLaPVA8FbFr2ZtRCrjyheuyMhOD0FEXzwTzZOL6g==
Message-ID: <85fdd57f-1ff2-4677-a2b1-954a1191c485@mailbox.org>
Date: Wed, 31 Dec 2025 22:25:52 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v5 3/3] Makefile: Deduplicate image size checks
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
References: <20251110091256.2422534-1-pro@denx.de>
 <20251110091256.2422534-4-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251110091256.2422534-4-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 646ee041b44e282cdfe
X-MBO-RS-META: w59uzaas18q6phi543ke7147gsdjpizf
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

On 11/10/25 10:12 AM, Philip Oberfichtner wrote:
> Deduplicate some redundancies within the SIZE_CHECK code in the toplevel

top level (space between the two)

> Makefile. No functional changes.
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
