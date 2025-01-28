Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F63C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 07:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487E981C64;
	Tue, 28 Jan 2025 08:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="gu2+Pb3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFCDC81C64; Tue, 28 Jan 2025 08:10:16 +0100 (CET)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com
 [91.218.175.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D2381BF4
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 08:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
Message-ID: <f6fd2395-07b8-4171-b4df-a57b62d51ef8@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1738048209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBQ2zDfEtE4GVdeeWwRyUgDottJIvBjQxYtwSurbi6w=;
 b=gu2+Pb3Wb5r4oJ14T7PCW3RPfj/Oa4Y/fKS7wEtMvm7jHtdXfvqkVtnw/2za7Y6KyMoJ+2
 vRLMx+Xbp0M+wysQtaJ0z5R5aR+/nqrB5P+Tc/4FqX61G+/GzHc7SUUmoLKCZgNQTpF1jx
 vmlUOxmhEYjlNvKg7IZsuXSCcb/r2SloC/sGtqG1ibgAzEJ8zFldT1Ygs4oQ/7mGPFIaQ3
 WR1b3wax9aGMFaLYUrLSBYK54iFztOVP1OClfoGhVvPR4hKxuPd5IMDKk/7cyC8vOSBx+A
 UD5o1HQFnTyn+YGtAn7LrpqGp+K0cVxu0Ct/IwDYb9Yvem+EOYyM5GbtDU7QaA==
Date: Tue, 28 Jan 2025 10:10:06 +0300
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] pinctrl: qcom: add sc7280 pinctrl driver
To: u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: Markus Bauer <Markus.Bauer2@tria-technologies.com>, u-boot@lists.denx.de
References: <20250122-pinctrl-sc7280-v1-0-8bdba72e6366@linaro.org>
 <20250122-pinctrl-sc7280-v1-1-8bdba72e6366@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20250122-pinctrl-sc7280-v1-1-8bdba72e6366@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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

On 1/22/25 6:02 PM, Caleb Connolly via groups.io wrote:

>   
> +config PINCTRL_QCOM_SC7280
> +	bool "Qualcomm SC7280/QCM6490 GCC"
> +	select PINCTRL_QCOM

Hi!

And again, no, this is not GCC, this block is called TLMM.
GCC is for clock controller.

