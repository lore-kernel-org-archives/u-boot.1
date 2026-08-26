Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FDFC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 108BE406CC;
	Wed, 26 Aug 2026 13:02:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yd_tUXXMl1Ue; Wed, 26 Aug 2026 13:02:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749321;
	bh=zcfonYc9M4Dkdj7ZylbclR+HgWl+ToRre9quSXy/vJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kO89kNKJ/Vgj2SsI1aUeeWooFxGOkjFibYNIBTeSgMcKvn3K90hk6l0xzSRsHG54g
	 ReOFbnpoIew99os8lIfxlnzpN1NFjtFLa1WCKX02GnSwXdasbHcnngzB8M5+Cqq7bA
	 yGzZQlCv4hn4ie65h2UJhiGqdf9K6nCkB6rqjyHUmNTXVJnU5qhcAF6GQrS3ahMz6j
	 Vnuk8/tSzBtpzmowREP/yV2CBM/I7WoUB/F8HVUbliB7QYuCVPxoURTOHB62K689NH
	 XevL1FUyX/3d3ffB/CqVzQ4gfI2WUm6lQ64buwGZEaMJfT69gkghnxGvBf2VPO8GHy
	 7UtCbjUzkO9KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37EC8406C4;
	Wed, 26 Aug 2026 13:02:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 853FB2FD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7707B40130
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IIi0oGoVICtl for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 08:08:06 +0000 (UTC)
X-Greylist: delayed 491 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 26 Aug 2026 08:08:04 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=baodeep.com
Authentication-Results: smtp2.osuosl.org;
 dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=baodeep.com header.i=@baodeep.com header.a=rsa-sha256
 header.s=dkim header.b=pgXiCytQ
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.250.0.168;
 helo=mx.adeep.su; envelope-from=v@baodeep.com; receiver=<UNKNOWN> 
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E41714008B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:08:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 183545F1EE; Wed, 26 Aug 2026 10:59:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baodeep.com; s=dkim;
 t=1787731188; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=zcfonYc9M4Dkdj7ZylbclR+HgWl+ToRre9quSXy/vJM=;
 b=pgXiCytQOK8qRz3Ss1qjOlhBODR23k6NFBan9/Cr0dl5nQFf7HMXk+lDiTanMV9zTH6Uaf
 W1V34LT+BX6YUnJLl7JXBLP4TfPQxtnZLjkll3zecMT8ONZLHhEZk/x6XUN/2Xtx3UH6Fz
 HOvZX6PmFywOSeJ86dAZ6UM4pyree+2UIw0q4cgQFnTgRhLsSTUGpDdKe+oJMBiGHTqmqZ
 WjEPMywm0jR+EZJhxNNvCJvjoYLCDprJoVzECicD5vmJYlLrxSIy7EGk0Sh0TdUs/8Lz5o
 qvjS8w77kd6HrGGKeJel7Jh8EzMeFqCsMH+5aEiipIsJYVaV/cojXJPEJHQLMg==
Message-ID: <c6a38536-b1af-440b-83ab-f0ca05975637@baodeep.com>
Date: Wed, 26 Aug 2026 10:59:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 12/45] doc: board/amlogic: jethub-j100: update
 product page
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Soeren Moch <smoch@web.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Le Jin <le.jin@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-12-ee7573fe3a4a@cherry.de>
Content-Language: ru
From: Viacheslav <v@baodeep.com>
In-Reply-To: <20260825-linkcheck-v1-12-ee7573fe3a4a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:01:55 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi!

25.08.2026 19:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The original link is 404, replace with one I believe to be correct based
> on the info on the product page.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/board/amlogic/jethub-j100.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
> index cbf1ea761077..053d5aa57ec7 100644
> --- a/doc/board/amlogic/jethub-j100.rst
> +++ b/doc/board/amlogic/jethub-j100.rst
> @@ -3,7 +3,7 @@
>   U-Boot for JetHub J100/J110 (A113X)
>   ===================================
>   
> -JetHome Jethub D1/D1+ (http://jethome.ru/jethub-d1p) is a home automation controller device
> +JetHome Jethub D1/D1+ (https://jethome.com/d1p/) is a home automation controller device
>   manufactured by JetHome with the following specifications:
>   
>    - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
> 

Reviewed-by: Viacheslav Bocharov <v@baodeep.com>
