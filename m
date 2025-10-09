Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BFFCCA471
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 04:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A3C8386B;
	Thu,  9 Oct 2025 06:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="h0wewr2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A69A83980; Thu,  9 Oct 2025 06:13:57 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E4D83869
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 06:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 34C7D1031E4; Thu,  9 Oct 2025 06:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1759983235;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=nlkCj0FP4sNxwKp5t4A1Yac2VIqp4imiXrgaN5nnliA=;
 b=h0wewr2bcWW5syUgy3cV+VGhlUaApJoHvxYqKrygwN9gbYOfuiR3a1mESBm6QU2GmKMBIq
 XPUScT+rbFqL9SwSRB6SNVCzLOmzIVwFULg6cd3wOkbawHjV/Eghuuje4ZcRIr7QAg91G2
 xFYazZBCZqU53JypWBfoMAiLnnY0cc4JrYS8Hsyy452qoV7ZLXNqVIClxpWCtjxVMzIXm5
 XM2XcS2vCRFCYcbXaeszPWyWX4zNZg9966iSdXxEnYK9uU+PanQx42b6Z2qgfjthb77twC
 j9T+x4/pWcPoRO/q6N9zKUSvii591FqB7wQF9KGIFfXlRu29ecfIQhzO52AWuA==
Message-ID: <f90da82a-80ec-24ad-d008-d004b9f4fe43@nabladev.com>
Date: Thu, 9 Oct 2025 06:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] fs: ubifs: Ensure buf is freed before return
Content-Language: en-US
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Alexander Dahl <ada@thorsis.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
References: <20251003-fs_ubifs-v1-0-a48d4861670a@linaro.org>
 <20251003-fs_ubifs-v1-1-a48d4861670a@linaro.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251003-fs_ubifs-v1-1-a48d4861670a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Andrew,

On 03.10.25 12:42, Andrew Goodbody wrote:
> Returning directly after buf has been allocated will result in a memory
> leak. Instead set the error code and goto the common unwind code to
> ensure that buf will be freed before returning.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   fs/ubifs/lprops.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Applied to u-boot-ubi

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
