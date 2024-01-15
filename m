Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87361C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 10:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 683AB871CC;
	Mon, 15 Jan 2024 11:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PBb3HcO0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d1RDCp+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033A8871D7; Mon, 15 Jan 2024 11:45:54 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD1F387061
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 11:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TD81q47dvz9sSj;
 Mon, 15 Jan 2024 11:45:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705315551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WW8PuhjL3jfMxGNFtBp8vVLpX6IgtsD5mT4dAC8CgD4=;
 b=PBb3HcO0eFXY65ODHIlUY7T4Epozp7oGv0KHmVvHXX35DXt1Cf9jjQOSZBriFD+R7gqzcH
 vCrFbSx7cHGWCyzegAi+cql5tVqoQkYY8j7WEXoTKrsfoFjsiUoABEoRd12kjxWG1HKS3G
 MmKs5ACuXLicDScOLJgpZHECEtAHOTYlPhzJOb22uocJ1+M3WGqEpDN3TnB+edplcPOS5x
 fAJfMZzvmBsg38V0FTzHAvuOq9yYGWpHbER8IoMxFM64sIvhhWE8FxsUFNhDhKqMoHn7He
 zh70kNBINiUAR+4iRcsXvr/zyGV+SWyKinA5rMBcSQG+FWQWw5kVEQ3XkRT/6w==
Message-ID: <2437b772-6aae-40bf-ba26-8dd2e9708a8c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705315549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WW8PuhjL3jfMxGNFtBp8vVLpX6IgtsD5mT4dAC8CgD4=;
 b=d1RDCp+zolY0iyXo2+duhsftebi9aSdHXhgBF69y2E8DO3UoOD1K3qEd46YvJ94WfLiQwI
 6fQpQyggKPX+rZEDocAg+/45P0JPdS3kwVye6IbbN2ueoOBPMtt4nrwi+MyuZ3XnWlDDSe
 q5fpE3gmY/bYwQN+1zfuUCJdKUSpuXimjZ2rgfwVdkqRA8DudI5ZPN7VVWzijlRF+7LP9t
 bhxAU/29E2GVH1Xg9jWgYsmkifgk95ewEso0UZB4JDXOtRsmtsC9xR12rhpsskdpjAuzaz
 qFow/Qjh7ojjRVWGk0R4BmtCbCWxNV25GM62u6NMvCB37VcOslW+DI37+ppOew==
Date: Mon, 15 Jan 2024 11:45:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: phy: the NC-SI phy device do not require mdio bus
Content-Language: en-US
To: Jacky Chou <jacky_chou@aspeedtech.com>, joe.hershberger@ni.com,
 rfried.dev@gmail.com, marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 u-boot@lists.denx.de
Cc: BMC-SW@aspeedtech.com
References: <20240115103447.389339-1-jacky_chou@aspeedtech.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240115103447.389339-1-jacky_chou@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: mx5fnxn1oi5kttzu7au6wtgapafdudx7
X-MBO-RS-ID: 78e3301df6af276c683
X-Rspamd-Queue-Id: 4TD81q47dvz9sSj
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

On 1/15/24 11:34, Jacky Chou wrote:
> As with fixed-link phy device, the NC-SI phy devive does not
> require an mdio bus. So, a condition is added to check the
> NC-SI phy id to avoid accessing the bus pointer that is NULL.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !

