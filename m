Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3308EC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 12:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 993138786A;
	Fri, 22 Dec 2023 13:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kuri+I46";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA9B8786F; Fri, 22 Dec 2023 13:19:52 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40B0787867
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=maz@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A50AE61B75;
 Fri, 22 Dec 2023 12:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53732C433C8;
 Fri, 22 Dec 2023 12:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1703247588;
 bh=VTyTL57pVUyjGPeZC/K4WrmCt+qh1/g5YG705cv0REQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Kuri+I46R/2CQTRmq9xuTUzqXqFW7HQsfwPeTv4hy+mo6FSnji2fYrWFLP0YMjlC8
 ibIpI5ledqDdKnX9t9RR3uA7S7QPNW9MnMeG+69oP79ow62f+sugv6SBfoelIETFPz
 WhjBL27uRQlFTvUBfjBB4mC+FrutU4bhEX541PxNUROENo9iMtCwnG6P5gRMROeM9I
 g8Qc3mfuQI3a0BrG9oh2LBLV6f3PmTP+3XZlvZn2ELip8+vc/dGnqyv9PHGxL19J/R
 0NGACxrpezRe3RguMbIoGFAKF2uQuJNoiwl4Jkh/AOUXSiwmU5jMxFWB/DSpxx1D54
 w+y4/9u0iVckA==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1rGeVF-006IqB-N4;
 Fri, 22 Dec 2023 12:19:45 +0000
MIME-Version: 1.0
Date: Fri, 22 Dec 2023 12:19:45 +0000
From: Marc Zyngier <maz@kernel.org>
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Peter Robinson
 <pbrobinson@gmail.com>, Dmitry Malkin <dmitry@bedrocksystems.com>, Thomas
 Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/7] rpi5: initial support
In-Reply-To: <20231218210341.30073-1-iivanov@suse.de>
References: <20231218210341.30073-1-iivanov@suse.de>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <a277be3746ae7fd3bd2676090a90d233@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: iivanov@suse.de, mbrugger@suse.com, pbrobinson@gmail.com,
 dmitry@bedrocksystems.com, fitzsim@fitzsim.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, agust@denx.de, wahrenst@gmx.net,
 florian.fainelli@broadcom.com, u-boot@lists.denx.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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

Hi Ivan,

On 2023-12-18 21:03, Ivan T. Ivanov wrote:
> Hi,
> 
> These patches are adding basic support for RPi5.
> They are based on v2 series from Dmitry Malkin[1].
> 
> With them I am able to _start_ current openSUSE
> Tumbleweed without modification. They are still
> a lot of things to be added to the upstream Linux
> before it runs flawlessly on this device, but at
> least in U-Booot SD controller used for uSD card
> and Frameboffer and HDMI0 devices are working fine
> now. It seems that PCIe controller is working fine
> too, but I have not tested it too much.
> 
> Serial console and reset are also functional.
> 
> Hopefully this will help others add missing pieces
> more easily.

So I've given this a go, and the basics (serial) worked
out of the box (thanks for that!) after performing the
memory-map change you described in your reply to patch 1.

However, I don't get anything on the PCIe front:

U-Boot> pci enum
PCIe BRCM: link down
PCIe BRCM: link down

despite having an nvme device connected and enabled
(the RPi kernel finds it).

I'm guessing I must be missing something. How did you
test PCIe?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
