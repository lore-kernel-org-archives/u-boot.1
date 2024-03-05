Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCACC54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 10:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3BF288039;
	Tue,  5 Mar 2024 11:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709634760;
	bh=CIyoSJ+hFAUTmeZkVU05ku6SbVAXShu7zBOmSOhpNAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zhswTrRYtT7dNisX2aXg2Bp66/EsSLwhC3qIpHVL5zL1njXw1q6KRQGPmijgH0xOE
	 w8TYT6q93suXbhQgOumvcqbKhu5tVapagyLQeh+9MERW+EM6yqYY6yhFMky19aiLQM
	 vUDo6S0fepp17FoHIEbMrkiG9ktD2PgaWDaIIPrdDboUlmCoikoER2W7mVOdQjm0FZ
	 XQBI2Y0T0oNxp7Q9lbbFkt9drglEZ9vKnqvpTQ2dN6Xkzeym0v50OJXD0sOdmPeNjY
	 /ageMEd7hsNr5P8i2CDAxe+0Biz6mSOgVMNtIeCYomVgPqU/oD4JEuiA2Zi4/WNylB
	 Tk4yzp4q6WJOw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E31F8803B; Tue,  5 Mar 2024 11:32:40 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 513E188023
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 11:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4TpsMS1lj6z9sR5;
 Tue,  5 Mar 2024 11:32:36 +0100 (CET)
Message-ID: <782c5971-b30c-487d-b6ba-34df2e2dc154@denx.de>
Date: Tue, 5 Mar 2024 11:32:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] arm: mvebu: helios4_defconfig: enable setexpr
 command
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Dennis Gilmore <dgilmore@redhat.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
 <20240202-helios4-spi-v2-2-df085461d894@solid-run.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240202-helios4-spi-v2-2-df085461d894@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/2/24 16:13, Josua Mayer wrote:
> Update the helios4 defconfig to enable the 'setexpr' command, which is a
> default and useful for various complex boot-scripts.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
>   configs/helios4_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
> index 04194004f0..73f0638344 100644
> --- a/configs/helios4_defconfig
> +++ b/configs/helios4_defconfig
> @@ -44,7 +44,6 @@ CONFIG_CMD_MMC=y
>   CONFIG_CMD_PCI=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
> -# CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_TFTPPUT=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_TIME=y
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
