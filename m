Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962DAD1356D
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3989989095;
	Sun, 27 Oct 2024 17:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZITCqSnL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cDwwU2Zw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E36D788EBA; Sun, 27 Oct 2024 17:32:13 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D98F89040
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Xc29K5pGHz9sby;
 Sun, 27 Oct 2024 17:32:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NpzhqMICqF4fw9pA7fz+adgbuDfBendKph4gNJDfINs=;
 b=ZITCqSnLEn0cXcF1YuHkEZkNT7sc7wXfi05KKWo0knIx11PH3Lrvuvnuh8LKmsVxvDh7bI
 w2SjvlT3c+5+hUyjQtRo882Or4IOaQWK+UKqja8fyPwrKW5wDAgKjKAUU4+N2rpoIrno8X
 mguIz3LoRK2KGHDOTv0ooHZSkb4j8gYl7BnuFvG+4IP2eUOKVzC1iLnT+JdiZ48RE3Bsma
 RydgNURs9MM2/Yte78G3j3djUz3PJsuErZpTge3RZHCqtlwMhGNEFyroD4XXsvW8NX34Pa
 9Gmtf4Vs6RGlV7oZL0FFZORYEFFsW9xCqQjaaqyqjdIAAcieDoAFvPq82hD/KA==
Message-ID: <050f5c38-d551-4c1d-a38b-80436bf27936@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NpzhqMICqF4fw9pA7fz+adgbuDfBendKph4gNJDfINs=;
 b=cDwwU2Zw+kE0prN+lF4oBNXbSLKV9WJ5cfu2CSfjHB1ViJUuzasOdX1xo5aiH1+vuuMLH6
 Rb+U/kwIusCANp1leDBNCpX/j00X1L3ysXAXw7g9pegi9Yy19ycCHbWfvsV57RAWMkgjGx
 ZeTwY5YBZVUY3lBDbu/Pj6LnfFaw5Nkqp7tUTNFgmfqj5fRvlgLuUwEO1h4c//od75aPir
 mLfd5+t7HtuOVC2teXgkhdFrhuGaV89ckEXDAo5fnJESxpnZP92VaXY5LRYNEXso/NQ5dg
 /B/o8r4P6mhJRy182ioefdw1obmxaS0iWCrepYvD5E8iWr/tTmHDsDpwxrYG3A==
Date: Sun, 27 Oct 2024 17:19:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 07/14] net: phy: ksz90x1: Load skew values from device tree
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-8-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241024152448.102-8-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: x9zmi6yhz9fax963r168ar1nsdwri84q
X-MBO-RS-ID: b4a9cd7efae9bb130f1
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

On 10/24/24 5:24 PM, Paul Barker wrote:
> Various signal skew values may be set in the device tree for the ksz9131
> Ethernet PHY. For example, the RZ/G2L board requires non-default values
> for rxc-skew-psec & txc-skew-psec.
> 
> This is based on the ksz9131 phy driver in Linux v6.11.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
