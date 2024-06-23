Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDCBC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 04:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EB3788239;
	Sun, 23 Jun 2024 06:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719117293;
	bh=RmQUi6Zk6mM7DObRIlZwTXynWWeQDr1j3sXHzfKdNIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ntFpNK3rf2TO++KRf9zyMWMOEdMHl/kZD96dkzRZhaXtw4R+AdNmzE+5M/n+fyeuY
	 txa8FHMEnSbx5adf3GtGBpXd7QTcxRiTxlofjnNQEvpMqrp1htfpoXoyypYf2d6ntq
	 j4dcLVP/KHBqyHs6nIqDALX2iz/iLQikIi82dIEcXkpCpfwSmOprGLpWn98IQIz3LQ
	 LQ/4T5Oa+B1ZpcHdm8drRXe8D+JrZpYPqYZiXh17kdimpn16jOzBPzZvNpyeSEAn7J
	 NLETH33a6IUaSvWP1C2NAuHK3Y6u1/7Sxf5wt+EVDuByI65Vescc3yN6duuuNeAu4X
	 vvYhr6nZTB18w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 47F8C8813F;
 Sun, 23 Jun 2024 06:34:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719117292;
 bh=RmQUi6Zk6mM7DObRIlZwTXynWWeQDr1j3sXHzfKdNIw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dEqS4SeU6V+bEOHBPc4LrOz+bIf5mVJJFv0+BNMJkP44/LR5n4R3ixknbxsz+ZQ8Q
 gnqidamfLubCTMPccCduunvbyaU6USxg0r+hJJPRsez2N/M5/429LfPBhrQxh8Yity
 vbhv70C6C5zUvdmVkkV1BiH9RnPqjO/f1n9BalsQXnJWHEgX7RNafx9UNwB1YVCd78
 L72zvCK46s5CzqAFWMgECmNd44xayB5dlfnQHSWUf1KP7gRGlD5TAP0IE1dVUYk+61
 o5Oy7icgwhtxKTRPrleI+Se1hlESd/sU7LadkSwue7ar5iePWdkkC+L7Jq24cFF6gX
 eajAxtZnfTIqQ==
Message-ID: <e6170c7f-bac5-4a24-bfdc-70a09c23c09f@denx.de>
Date: Sun, 23 Jun 2024 06:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eth: asix88179: reset during probe
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240618145759.3296876-2-caleb.connolly@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240618145759.3296876-2-caleb.connolly@linaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/18/24 4:57 PM, Caleb Connolly wrote:
> In some cases (consistently in my case with an embedded board) the
> ethernet controller will time out on the first init but always succeed
> after reset.
> 
> Let's reset the controller during probe so we always start with it in a
> known state, and don't have wait for the first asix_wait_link() to
> time out.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>

Please let me know if you need me to pick this up via usb tree, even if 
this is kind-of a -net patch .

Thanks
