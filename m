Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5112AF46C4E
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C40458352B;
	Mon,  6 Apr 2026 18:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jlQN1C2C";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nGlJDUCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9B3783F98; Mon,  6 Apr 2026 18:05:18 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A858341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 18:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fqDgc3l2Qz9tWp;
 Mon,  6 Apr 2026 18:05:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775491516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqeAsjMWW01uMWGw/wTCrmq+wceEKhP3wlRL/lvb9Aw=;
 b=jlQN1C2C8pRkC/RV/bP3za3i7tWyEYPfn2zMZN1tV/WgvqKg9JCaBDXAX6M00s26Vn1/l8
 kNJsNvl2e/UYc7ttX+EodDF/le1Xe7wHMiw48vCboCU6YujGgHte8TWuCPfCDQ9M0feZku
 d869DhCp6okE1QyF6sV12qsrJKBuHvgjTiEGefkdhW3P+sVrmRCH7H9IBUjMXynItzZccx
 8akEm1I7Ala+hPA/yQUYVmDiwA/gfdW4EAS+ufjaMx5Y9L12JwobBMP8HtcdMsrOg1ZKNd
 4NCV6BZjZRJzAu/g9SUBifcpRPcr9CCbQWQ7CVw7qn0S9FS2dKxNOg2HcOuvgg==
Message-ID: <3e515a8e-710d-4664-ba49-ce287bd5edc2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775491514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqeAsjMWW01uMWGw/wTCrmq+wceEKhP3wlRL/lvb9Aw=;
 b=nGlJDUCeRUtF7aLabQx+OidB1/Ckj107Zae5yvhi9zZzKmT1i1mWZx8onB6IXdGbRF8Fby
 WOAYhzSKMyDH8+W6ySakDX601mcm9mB59wW7xNGAC4fgAjTdqVrNEEoT8qlxjrENXfe8zZ
 cSAaWDcbzmX9zpemZVCbpjnGIsRR2FJYK3TEzd31Wb+QyxthNxB4b03GJmaBT9eVwssxUV
 C5XYZ8f900t2em7v43ry88ZzJrtvnNciIl0CWH3bSN+yIhpXON4NvAnY3ItYIOfGRDwenv
 nKstf6UivMC+ketf2z1xXCiOZ4XHEswSIPt96kaW/xTbObth0otMDmR+WaumkA==
Date: Mon, 6 Apr 2026 18:05:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] net: phy: ethernet_id: fix duplicate eth_phy binding
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
References: <20260406084204.1274302-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260406084204.1274302-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jaxziwxymmb8c9damjnooun5ihapyjwh
X-MBO-RS-ID: e19a6d675e498392215
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

On 4/6/26 10:41 AM, Pranav Tilak wrote:
> When both CONFIG_PHY_ETHERNET_ID and CONFIG_DM_ETH_PHY are enabled,
> eth_phy_binds_nodes() called from eth_post_bind() already binds the
> ethernet PHY node to eth_phy_generic_drv. However, phy_connect_phy_id()
> called via zynq_phy_init() -> phy_connect() cannot attach to the
> already bound PHY device and creates a second instance, resulting
> in duplicate entries in the dm tree.
> 
> Fix this by guarding the bind/probe block in phy_connect_phy_id()
> with uclass_get_device_by_ofnode() to skip re-binding if the PHY
> node is already registered in UCLASS_ETH_PHY.
Shouldn't phy_connect() check whether the PHY isn't already bound and 
bail early if it is ?
