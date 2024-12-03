Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6D1E74AC3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 16:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7701A895CE;
	Tue,  3 Dec 2024 17:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733243466;
	bh=sVK3b4jnuxsTh+W0jAWvuhkPjIRwFPBDeDwHQtEmSKo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L1V86/KRE6CnKY/nE2fqbstJe/KDY1UfdINZGPCw0rvVcrheuAuVqsfiIu4M/wQml
	 UbiT4Pk9gx6Z/xySYB2Vyfr7rRbUT4okNk3VVRUU2E5Iq92Wjfg7S+An6Jo1bW1lFQ
	 XRcGWNo+GjRhbWWtjpWwXZ5NvYtsNj3iGmjjDrgNR3+NUqL4Bfshr56EaI/FFckM0I
	 bArwVTVjSLW1u+isK2K2An+QxY5tct5Pl+msz8k+EniHkRnkB88pARvp/lZze5s0k5
	 GMgFC2UkD3uPBXZQk0jQdnlLpPPYKK/qcet8whYMVWcr8XtkJSKUshOXOz3GMBBYh1
	 g04hzn/XF0f/g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 082F5894D9;
 Tue,  3 Dec 2024 17:31:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733243465;
 bh=sVK3b4jnuxsTh+W0jAWvuhkPjIRwFPBDeDwHQtEmSKo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sMVW3kHZ9Sb/7D+t65ktogEBqS6oEBMKpfVM1LsoKdIguz/X/o3zNBNheQWBCXxGO
 z7zZIp8gkMwZetsh3fNC12BMuGigKmnM4lbd+KIoscl/d3Y5zuMs6YIwEViMZsiJHr
 VPkFPDXEWlVjK+F90+qmy5xhAnwedjMw9M9V0Z7JDc4Iu55c4PUmLJlrABlRg/RaJm
 wFxyKmg2WfAPHosex7kfdjhGNnmQLp6cayydE3I5/WT/ijiBrWXE94o9jWQnQN9ivy
 xYqyUatc5hYx/zXbjUOfR42TlMpLE8oNkPzL41y4A9r1ey8NJjgAlzQg+UEk5AmBKd
 h+UwnQgoLL4Pg==
Message-ID: <aeb6e6aa-9d65-4a23-9a0a-63fd920af856@denx.de>
Date: Tue, 3 Dec 2024 17:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dwmac_socfpga: Add RGMII-ID support
To: Rufus Segar <rufus.segar@carallon.com>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
References: <fb698f79-3b93-4e03-b582-c6a80b827318@carallon.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <fb698f79-3b93-4e03-b582-c6a80b827318@carallon.com>
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

On 12/3/24 3:30 PM, Rufus Segar wrote:

The patch is valid, but please use git send-email to submit the patch.
Also, add Signed-off-by line ($ git commit --amend -s).

Thanks
