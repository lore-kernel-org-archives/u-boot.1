Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A62AC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 04:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6401288853;
	Mon,  5 Aug 2024 06:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722833651;
	bh=9euZlgsy3ZgMjWXJhj/mNLcoE+eoQtQEVPGJpVDTlEA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=S+6QMU0LjDvOK2D0QWg5IsEyXXqpyosquw9cnPbJHTPvE8CbtYWQeLtUZxxMAmT7R
	 V2N+8QhqOkln+9bwt1gb8+h11r1k744OyRL+xZExnvDzmTvJwoucbsfZFPzWJc/YYS
	 Kr3UBmDiGCMJEQBl/n4T0AHc3x2uE+Q9J1KfwXfJgWGyu4Yjd3ZnVV4QU8CpojKoqh
	 6No43/+tUeWRRFsz2AVB9LlEtDazMizREQyZN8hsz7xAKlvVMedolpYkdtKf/VPahz
	 tE2yCVBHa212wnBrFtOaakaU0L44XQB65I4lcnlhKSeG8VsmCiOaKdZGXvMBuvyL68
	 OeKm3WCSggUXQ==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1D36988027;
 Mon,  5 Aug 2024 06:54:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722833650;
 bh=9euZlgsy3ZgMjWXJhj/mNLcoE+eoQtQEVPGJpVDTlEA=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=jpvL1Sp9PwahiRBSOu4vIScXlNWnEGQEMw8cXkUTSmPJyuw9oZqyIgSqGM48Fh5WN
 DawQ5SyzXZfc7q+bdvqgf9KdbzUf+ijkwR7NAbBoFO1e3egK4bsoY2pB9dlR2fdUPv
 4vu048hUkLvC0s064tOSIQb71ojzdzVP0vK5loFu9l8qH85pj5BwuLpCTrQQ9HzHaO
 LWQg6HEMMOxl62paSIyBHBnqnCZhqpkKadzZYqtqt9zzum5V0Buj7+Ri2ENt6xi+9z
 RYbnIThFDiyfCpWZZup1OXJU2yxt543lxtUSrKMndIPS4PtD+WRcmsQx+3Cdkg0QCw
 RYzgdet/TXYOg==
Message-ID: <44004767-f249-e693-1dde-d92a07154402@denx.de>
Date: Mon, 5 Aug 2024 06:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/2] i2c: samsung: Support platforms other than EXYNOS4
 and EXYNOS5
Content-Language: en-US
To: David Virag <virag.david003@gmail.com>, Tom Rini <trini@konsulko.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>, u-boot@lists.denx.de
References: <20240802191920.132133-1-virag.david003@gmail.com>
 <20240802191920.132133-3-virag.david003@gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240802191920.132133-3-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello David,

On 02.08.24 21:19, David Virag wrote:
> Newer Samsung SoCs (including newer Exynos, ExynosAuto, Google Tensor)
> still use these IPs, or slightly newer versions of it.
> 
> Make these drivers available on these platforms by guarding
> EXYNOS4/EXYNOS5 specific code behind their configs, and using CCF for
> clocks on other platforms.
> 
> Tested S3C I2C driver on Exynos7885.
> This along with extended clock driver should enable S3C I2C on
> Exynos850.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
>   drivers/i2c/Kconfig         |  2 +-
>   drivers/i2c/exynos_hs_i2c.c | 25 +++++++++++++++++++++++--
>   drivers/i2c/s3c24x0_i2c.c   | 30 +++++++++++++++++++++++++++---
>   drivers/i2c/s3c24x0_i2c.h   |  2 ++
>   4 files changed, 53 insertions(+), 6 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
