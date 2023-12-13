Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E993C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D38668782D;
	Wed, 13 Dec 2023 17:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702484566;
	bh=7NXJsxhxikCqD/BEn2js0Rpo6BqK1Y/RylU7gjkBsdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ja3JvE2ZCQW2Q8rpiQwnkgZCZTgdpIoOn0aI3NKcVJUMeoC0kf384xNuhBm2jh2B/
	 5avxB3OMTDMz2fZBhyVAYYaB3WSM25M8Wa5NUXM6PKPzSHEJD+rJ57NgLLeA1JxC4c
	 H+2jBLP8psTWs1k3UnqGL33o0SD/6yD+N5nC1xnnKEg1jZMz0Yk5EH0lbfBHEy7bZ+
	 odVuM8hZzvbGD9aVXYoJE1aZl7ts9dV8O0VP2/ywQeZ1TgD4pZLHsinScmSuGwrvVb
	 bDkgyflRDVuw3mTkGT3wbxhQIU4bIQrcWKUFMWN/pfb9XtQQmyZ1HTlnmNGhZDJwM6
	 qq1+YxVi15CWw==
Received: from mail.denx.de (unknown
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: festevam@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B443187827;
 Wed, 13 Dec 2023 17:22:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1702484565;
 bh=7NXJsxhxikCqD/BEn2js0Rpo6BqK1Y/RylU7gjkBsdU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VbHBIDPKt0xiCZ76Zbzf0MaLk48mKp5lRza8QnTPyLoKeUT95RyGevSWdRRO0eTSh
 g0D60k3JcHDdxJAYKu3sIN8HVOr5y1ueSOStWJiVkGqIJaA668KZM8mikAIhJ9gy2U
 padYHAt7iBguDyUHPSxJvVRbIJ6KLJLmtHB29IGOdtFrDA9KQTUBByb6hsZFcROxtG
 2eP5YcHzbvc/7//20IprYBKww6DV1I14kj6/3gahfFD4KZEQVjhKU2Rx4lRLwCKsmm
 d58wL8QDN43kGosdjAqSe6WEBQLJb539Tn5NDCON61ESNJn1iMPehLhP/4uOakj4kA
 6WDMf35RiaoFQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Dec 2023 13:22:45 -0300
From: Fabio Estevam <festevam@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, uboot-imx@nxp.com
Subject: Re: [PATCH] imx7d-sdb: Sync devicetree with kernel 6.5-rc1
In-Reply-To: <20230711112349.427104-1-festevam@gmail.com>
References: <20230711112349.427104-1-festevam@gmail.com>
Message-ID: <920ba5ffaad7601f47e8e260772ffded@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
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

On 11/07/2023 08:23, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Commit 0aea5dda2928 ("ARM: dts: imx7d-sdb-u-boot: Fix usdhc1 UHS
> operation") did a temporary workaround by addng the usdhc1 fix
> inside the -u-boot.dtsi file.
> 
> The imx7d-sdb.dts from kernel 6.5-rc1 contains the proper UHS
> fix, so sync the devicetree tree and remove the previous fix
> from -u-boot.dtsi.
> 
> Also, adjust the PMIC node name inside pmic_get() to match
> the devicetree update.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot-imx next, thanks.
