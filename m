Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A503D3C93D
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 04:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A86E8898B;
	Mon, 21 Oct 2024 06:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729484026;
	bh=SHH75dNTX9w2C6kRIbLysG6sxRs6m5ibR2Iv5cMjQQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=pzfgQ6MRy6nAEK5b4dqUwPL8hwPfmeeNIFc4D3i/Eca7Blfch3IbqA/4kjWasJlQb
	 N0zoy9OLozOL5brv3KfiZ/oEj1p1MDdNUH90sF7ftMrS7lesF6y9aT5qmtFTPlk4y+
	 X34ogf+JglqDoPDkGBgMvh2uJrGap7wTFDDZxDUzs+ltqUWKEz7c7FrN2gHosCzV9m
	 pQhT+S3Kgls0Ufk5LiPHmS4sKMVCO2Zcl3Y/Dh1z4qTiYLkljBDt96ClLOuTk7S9c5
	 1XBlqUlBG1S8LVX4hNw5rLT/3DnZMb88oWUCRaf9GqkzBEA4lKZQwXxUjoPIKRi29R
	 vzruCVyg/sJjw==
Received: from [192.168.1.107] (82-131-200-27.pool.digikabel.hu
 [82.131.200.27])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CBF88881FD;
 Mon, 21 Oct 2024 06:13:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729484025;
 bh=SHH75dNTX9w2C6kRIbLysG6sxRs6m5ibR2Iv5cMjQQg=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=zH2+zjVPi1L58ZbztVG4JDlB6Yw61IYcTQxy2B6Tr9jpx5uR4rBkCTxg2hUckwzk5
 Ui5117uDZqgFEIhdXEn5TmzBokqte6JMLnMlkopxO2qeqJRkV5RmtWhAZHWqp2WXFX
 pXwh1ZuoIe9WiFdg3a0uqdMpJx5JI9li+I6oAxgY9ok4rw0Xpb7qebz9PgooczzwW+
 bBv5/jzoCvzxEm3RQV8r5IX2zHSZoUjCWAV3XikL8v7kgBLjw0oPAxTNSAjc/fcaD1
 HYQ0riWmMHUKm/tFJ/Rn89FGBELftL5ekyC5enSZvmvUVTCsscHP9sX2TJrKbChFTM
 v78HMHGVrTVDA==
Message-ID: <e0dfb68b-a168-01ed-e2ae-24f1ffc98430@denx.de>
Date: Mon, 21 Oct 2024 06:11:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1] i2c: muxes: pca954x: Add MAX735x/MAX736x support
Content-Language: en-US
To: bigunclemax@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
References: <20240919160658.197534-1-bigunclemax@gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240919160658.197534-1-bigunclemax@gmail.com>
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

Hello Maksim,

On 19.09.24 18:06, bigunclemax@gmail.com wrote:
> From: Maksim Kiselev <bigunclemax@gmail.com>
> 
> Add support for the following Maxim chips using the existing PCA954x
> driver:
> - MAX7356
> - MAX7357
> - MAX7358
> - MAX7367
> - MAX7368
> - MAX7369
> 
> All added Maxim chips behave like the PCA954x, where a single SMBUS byte
> write selects up to 8 channels to be bridged to the primary bus.
> 
> Tested using the MAX7358.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
> Hi, friends!
> 
> I have a custom board with MAX7358 GPIO expander.
> This patch is the port of Linux commit:
>   > 81694437b6eb i2c: muxes: pca954x: Add MAX735x/MAX736x support
> 
> Best wishes, Maksim.
> 
>   drivers/i2c/muxes/Kconfig   |  5 +++++
>   drivers/i2c/muxes/pca954x.c | 37 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
