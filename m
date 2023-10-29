Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB977C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B440B8795B;
	Sun, 29 Oct 2023 16:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592183;
	bh=c1M6ST+n9p6CiLGsOnHhEGuEQJxDMBDFbvBzzQ1GMVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SEPvQSCg6ocYN7424Bt/+mYae0cJ+lDsjrAcNzlFpfbNIWNiLDogZ7bhBr+N08QdZ
	 PnhfnFHIVeLNNq60+4c//hRLwg8XRdKrNASxGTb3dZySFzfToLnvzeF1PqkMITHBA5
	 bKGro3PZiAU1ykIj2efZbgsZ8LHWcj2x3IxxeG+sgAcJ26NgsnZW1CL2BgHWxLgxqu
	 5+rXTZYP1/f+HRt+yOJNIlBTjT3uBiy966RtozrFV0ZB2nLAz3QfDWDSoAf9omKw2W
	 a9kT4bes08HahWKiF8eRB9Cpqn2T1hFWKxS39ApHbaVhceYq2bc4PM50X0xTCWgdo4
	 W3G+WBC1UipbA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7CA7F8719C;
 Sun, 29 Oct 2023 16:09:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592180;
 bh=c1M6ST+n9p6CiLGsOnHhEGuEQJxDMBDFbvBzzQ1GMVQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=W8YVQXtvjANOyavDwKsfliboYGdxd8zymjnXM2PTA5U2+WLam/YJlB/6rOig81QE1
 /1ll2BqfiWO+FBVYhXK2q6y3b8KC/YQ14iwgIDv9khraYWkPBFGPmg27auYdlN89sv
 G46BS28M0KL6Ij2LVJ5RUmiFWuDXrIZYL9TJrODQ++oIrgzLoX8ojCmtqQEliwE6zM
 XOPvtC7QFz5KL9EKwDtJ+0XI2QPCsrtgxsfBY/TfGT9+JczkZMRjoD69J4nJdLnKFC
 deJtcdurmbmRoKT04w/BLvRFuvoRYnOX5PbV1BqpmIZjjRu4m2vwBNms+iUpIKsZnA
 TEdrJiyS3RiqA==
Message-ID: <0e08be5a-4f71-4c13-8791-127fbba7cb63@denx.de>
Date: Sun, 29 Oct 2023 12:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: Pass through timeout to drivers
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-5-v1-0-54bb13001f54@marcan.st>
 <20231029-usb-fixes-5-v1-1-54bb13001f54@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-5-v1-1-54bb13001f54@marcan.st>
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

On 10/29/23 08:36, Hector Martin wrote:
> The old USB code was interrupt-driven and just polled at the top level.
> This has been obsolete since interrupts were removed, which means the
> timeout support has been completely broken.
> 
> Rip out the top-level polling and just pass through the timeout
> parameter to host controller drivers. Right now this is ignored in the
> individual drivers.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Except for the negative timeout value question, which needs to be sorted 
out:

Reviewed-by: Marek Vasut <marex@denx.de>
