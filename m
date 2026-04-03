Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B4DE88D82
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 05:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A553384106;
	Sat,  4 Apr 2026 07:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wFZUD4Vq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37EF884106; Sat,  4 Apr 2026 07:09:47 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57BF483B8F
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 07:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fnkD74lqCz9tqM;
 Sat,  4 Apr 2026 07:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775279383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uYEocCNPfl4gp+o7K/Xj8CYmHu1cA9mJ7Tf/Mdksu0c=;
 b=wFZUD4VqkehCfUMzKYFphWSl9zkOwrfa1tSflg/DYLOPOv3xN8YfgdBwrMV5T24zB9Zc/u
 0iIzOfZPVpblw3xKatLrHpcG5yjb1J3N+SjOdW2nKJqRS4HJH4r0mHLxH2BMOJgK1WDJiY
 e1jnUYID2R8HRFufIfGfGkr7esFz2J8jk6wX6zN2zgjaIrVkapJcAK1PCSWy9ErkMz+OUB
 O2D/CK0lYJG4hkzsVUzs3SwXSeMUWZZxYYfvFliXTmkrrd6yQQsfJhaIMKYmy1iDP39FS6
 5WQ4Wxbsqy1Scr0HRARDKLhicH/D55UfqlPOzLG1/6lqoQZYnUzp2LZvnEx6Xw==
Message-ID: <6f84ee18-8884-4c13-86ab-ebc5f0118ece@mailbox.org>
Date: Sat, 4 Apr 2026 01:16:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/6] arm: mach-imx: Add command to expose QB
 functionality
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, viorel.suman@nxp.com,
 simona.toaca@nxp.com, ye.li@nxp.com, ping.bai@nxp.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1775121078.git.simona.toaca@nxp.com>
 <18e5f58dc65283a73c29c4b603a5b56f7c4d3e8a.1775121078.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <18e5f58dc65283a73c29c4b603a5b56f7c4d3e8a.1775121078.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d7057c7a181e7924d50
X-MBO-RS-META: yhjbr3zpcx8axjdgtjdmef8x4bggs4pg
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

On 4/2/26 11:40 AM, Simona Toaca (OSS) wrote:

[...]

> +static void parse_qb_args(int argc, char * const argv[],
> +			  int *qb_dev, int qb_bootdev)
> +{
> +	long dev = -1;
> +	char *interface = "";
> +
> +	if (argc < 2) {
> +		/* qb save -> use boot device */
> +		*qb_dev = qb_bootdev;
> +	} else {
> +		interface = argv[1];
> +	}
> +
> +	if (argc == 3)
> +		dev = simple_strtol(argv[2], NULL, 10);
> +
> +	if (!strcmp(interface, "mmc") && dev >= 0 &&
> +	    dev <= (BOOT_DEVICE_MMC2_2 - BOOT_DEVICE_MMC1))
> +		*qb_dev = BOOT_DEVICE_MMC1 + dev;
> +	else if (!strcmp(interface, "spi"))
> +		*qb_dev = BOOT_DEVICE_SPI;

if (!strcmp(interface, "spi")) {
   *qb_dev = BOOT_DEVICE_SPI;
} else {
   blk_get_device_by_str(interface, argv[2], ...);
   -> This will handle all block devices and all block device
      names and format strings of those, no need to write yet
      another ad-hoc decoder for those by hand. Then use
      blk_dread()/blk_dwrite() to access block storage.
}

[...]
