Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA579C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 21:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A34869B6;
	Thu,  7 Dec 2023 22:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gerhold.net header.i=@gerhold.net header.b="VT1jZle5";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="89S7AvBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA0486EEC; Thu,  7 Dec 2023 22:37:50 +0100 (CET)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [81.169.146.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDC6086758
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 22:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=stephan@gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1701985066; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=o+l62GIzLL4KZtOntMceb87Q9TvJC2uSnmFZgC9Y8Fjl5zagEXRh4kInKHf1WQatQp
 ZcqLkXr7n/zboosEv8s6X/EbHSJOwdMK/6Uqfxv9PEA13hhFLWqJw3I3pBar7Z4noPnj
 F/rYGAnZr6Tq5mqwgPbNErbdPjhLIQDw+zXZghgssPvIRiKzyx++Im0/meB2dDMIwty3
 55q7Cle4ZyFPkFHStWO2+6oebz4t7W4ebvbOMxuYKZ/H4Dms/EraT0GQ2uz+MTbyVMBU
 92dJUIJmwEe2r6Gfg9S0IRITNUuDC+7P02qqiiRVCW045EIQhOwYaahuXUAjWQ+X81a3
 RN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701985066;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=p9WIzhBLSo61NXXCy8BkSxyTouu6n8D9oR4kRx/OZ20=;
 b=FArDSKtD/7U0KqAeThIEgZJfB2nlQkDhg8wsRxbKzN3S00U14IajCjeERwMsHUFioq
 965RmcvbknW4vH67hUh3GfBlTRER0zZ4QtOEb1W1OWSbEyULeEWsLY4dwJiEPNIYJdU1
 22m4f2BC43XpxZFWZJ7C1V5gP4GVKu0CxWuSzgBy4l2pHRU3azAQAShQQY2jKmeELGRv
 yO+uds1vBBiR3x2xSZqBM/V7MEz+aknR/K25+B3Bk2tyk7aqmdgplU4mK/Xq4MhAjGm3
 qALVDXHw6NVoiLE10sNYinOpjjOej/VqFqZo3S07wKsfxqEXsNZ/OrViwmBSdd2phFHd
 4qsA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701985066;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=p9WIzhBLSo61NXXCy8BkSxyTouu6n8D9oR4kRx/OZ20=;
 b=VT1jZle5wmm/RvRHO1mAdHm1eX8AojYAQtQLs79G+am6Wf0zrUn3zyUy0KPWQWDl5o
 rGfcUOacmEZt/w8oQWAhSf9y9UCDZvQfy6V5ZCah9CDZzI4cAwnxCgO+FvMBljdnSByj
 QlOL+HYB12OvdJlnvfL1AXWt2gvX1YFyc+uu7jifdhaZZwdJWVy7Ga3TzRxt1Y4DuKP3
 73azsnDsu7zGZBvPxU1KVanh4fHzA4D9SAzCl0I6E5KK+nVq88j2tY+/VcSf2K0tUhzc
 evsgTZWVvAkJ5RlCzxIgnJU5tIEXmLIwuw0wI48eAlKSmfkKp12Aqm8uR0fecpEO5h3E
 p+Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701985066;
 s=strato-dkim-0003; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=p9WIzhBLSo61NXXCy8BkSxyTouu6n8D9oR4kRx/OZ20=;
 b=89S7AvBBto35Xs6AA/f0y+ZN48EyC7td+qwG5y0WtpOaKCe66r1m6e0TgFLAO9hvV4
 mWXOWIWy+PLzyQUXouAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8paF1A=="
Received: from gerhold.net by smtp.strato.de (RZmta 49.10.0 SBL|AUTH)
 with ESMTPSA id 58bb61zB7LbkAWa
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 7 Dec 2023 22:37:46 +0100 (CET)
Date: Thu, 7 Dec 2023 22:37:45 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 18/21] dts: msm8916: import DT from Linux
Message-ID: <ZXI7KbpOKDp5fpbd@gerhold.net>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <20231121-b4-qcom-common-target-v1-18-9492198e0c15@linaro.org>
 <ZV0DJrk_iOMd5I2a@gerhold.net>
 <3334681a-e5b3-4d76-afea-26f8111808e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3334681a-e5b3-4d76-afea-26f8111808e8@linaro.org>
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

On Thu, Dec 07, 2023 at 07:11:02PM +0000, Caleb Connolly wrote:
> On 21/11/2023 19:21, Stephan Gerhold wrote:
> > On Tue, Nov 21, 2023 at 05:09:41PM +0000, Caleb Connolly wrote:
> >> Import the msm8916 devicetree from Linux and adjust the dragonboard410c
> >> devicetree to use it.
> >>
> > 
> > Can you add a note here from which Linux version you took the DT?
> > 
> > It seems quite old, the msm8916-pm8916.dtsi doesn't exist anymore
> > upstream since v6.5. Would be nice to bring it up to date (I don't have
> > any more cleanup planned at the moment, so the current state upstream
> > will probably stay mostly as-is).
> 
> That file still exists on 6.7-rc4, as far as I can tell?

Sorry, I meant msm8916-pins.dtsi :') That one doesn't exist anymore.

Thanks,
Stephan

