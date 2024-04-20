Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF0DC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 23:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31EFE881FB;
	Sun, 21 Apr 2024 01:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713655462;
	bh=lrDE3GeP9ZodFsEIGijVyn60aLHj8WFeStmBgQe8iIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PUai31tXvyU98WplBtOUTAmy0GehgBzSIwdO1pbDhK56qwLU/NBEVcXj78eTQQumq
	 gQbOoamzS2QIvMPdJw9nis1Ad6i32V+EiEbw31Y18DlYNA00COorOQ4Z5DcUJwX50k
	 k9pzW92vX8yRUuQSlfEytTLNvlUaGMdldLoqp5Xy9R5lWtQXb5abkmc3qEKYsWdlj4
	 6B5wWaquT5AnnhM8ik9aOeksgWIVrL59C7AteePkntPc/k7sS3hgfbScxbayFlcUu9
	 FB8490w2JMyZ+MlDiophwhTT/SyHbHEthAg6nBRBEUFouvs9drelq8OOIRWaV+Z+bx
	 A1vVqcOk1ZC4A==
Received: from crub (p508b6ab0.dip0.t-ipconnect.de [80.139.106.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CACFA881B6;
 Sun, 21 Apr 2024 01:24:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713655460;
 bh=lrDE3GeP9ZodFsEIGijVyn60aLHj8WFeStmBgQe8iIs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=n28nz8ArVvEqOm3XvbUOCFSbYOsqFZxC86BRWPL8PJUAVpOBFf8eLb46yC1CcwzzJ
 hnaCwu88qfsgexbouEavn1pb1B78udAi5C3OUP+hBrgbCQAYT8hu8VjZA7odkBC55P
 EO8POPbvQVCuF/N82aUEpPXDdBB0NlAqdMGiPeaC7s71xRvhww1FEezPUrXrZm84ev
 prSwCugU2W6JvvCGjWShdH0UOUpIzTUCqGqTLFzh5as0FXBGw/nycKP8cYB1Kblss3
 9+m+jxO6S3eUPPeSYQs4ZFtglYaVbE4Ay/CDggl0Uusod6yZ5XWyfnv8uVHhjPBIiC
 Q1414AEA4Ylfw==
Date: Sun, 21 Apr 2024 01:24:00 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/2] Simple panel improvements
Message-ID: <20240421012400.49d3862a@crub>
In-Reply-To: <20240108164501.4660-1-clamor95@gmail.com>
References: <20240108164501.4660-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon,  8 Jan 2024 18:44:59 +0200
Svyatoslav Ryhel clamor95@gmail.com wrote:

> Simplify platform data pass to simple DSI panels by direct
> asigning in udevice_id struct. 
> 
> Support EDID searching in case device tree provides no
> specific timings or device has different panels (like paz00).
> 
> Svyatoslav Ryhel (2):
>   video: simple_panel: simplify platform data pass
>   video: simple_panel: add EDID support
> 
>  drivers/video/Kconfig        |  2 +
>  drivers/video/simple_panel.c | 87 +++++++++++++++++++++++++-----------
>  2 files changed, 63 insertions(+), 26 deletions(-)

Series applied to u-boot-video. Fixed dm_i2c_* build errors with patch 2.

--
Anatolij
