Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14044C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 05:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC738331B;
	Thu, 17 Jul 2025 07:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1752731825;
	bh=zweqEmy9dsH//3Oq1831sEtthZvoYeedGjnHSjsMyaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NzUXkKst6xedx0ibTA4KCOKa2MR752jZ5+ckXXdRPDKONP/zJAxFL2Fr7xoAsbyWD
	 brr3LTK5uo3cWHHeR7pYjJjCvnh3p+nnu/cp6/Iz8cYvQ+4WnKax+iAt61bmcLeirL
	 1miCLGcxht4xkU7RPJb2/+4MKzForIJRQ5GJEFvgXQ/iisNh68kBlFR+zxIm1YiZPa
	 vXyQirfQA2wabgD7Dq5DhyfJ2kG4NqFWJ/B+a0V6wxx7jApzOGW3rVAp1bTYu4Xvgq
	 BBcs2siVlaZMrXnBC+D4DhJwQc9jcwhjaROpt9NxlBz+luSNwb7W476ePy/i2vx4bE
	 rZliNZl5xMxxw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E50D083321; Thu, 17 Jul 2025 07:57:03 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED11E82B0F
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 07:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="bFojWX+Z"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CED3810397286; 
 Thu, 17 Jul 2025 07:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1752731820;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=zweqEmy9dsH//3Oq1831sEtthZvoYeedGjnHSjsMyaw=;
 b=bFojWX+Z+AiJ9SAQnFWiUC5uc+kZ9XgsBmm7FFrwSjNXIRbDR0Qdo2PuOvkOZMYeOQeQCD
 iXfygNTX/tfmuMlx0m9Pf4t0pcVIY5ezCcnCd4N9XqHMDVe0DqjQYvrd89nWlEnXNuVbTR
 FHP4IdXrb3qB9DjyVz+4GW0JdWinPhugx9bRL+KUOWYGD40dY+wtKBvAh5OSGWBd3cFNkK
 k/KKU5moBclzvSVUEGBw0slU6+TGNe6cMOOwxLe6wULiU+/xC/lbAs1arYkC23Jn7CGio8
 gna0PAAER5xguudeFmMkv63Af2/fQh1Atj0Ur4BfFLF9QukQ3WP+Ub/0xgGWYg==
Message-ID: <e0292583-4f44-e965-70e0-1b63cbe74422@denx.de>
Date: Thu, 17 Jul 2025 07:57:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1] i2c: muxes: pca954x: add pca9545 support
Content-Language: en-US
To: Frank Wunderlich <linux@fw-web.de>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Maksim Kiselev <bigunclemax@gmail.com>, u-boot@lists.denx.de
References: <20250606095056.22082-1-linux@fw-web.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250606095056.22082-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Frank,

On 06.06.25 11:50, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add support for 4 channel pca9545 found on Bananapi R4.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   drivers/i2c/muxes/pca954x.c | 6 ++++++
>   1 file changed, 6 insertions(+)

applied to u-boot-i2c master, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
