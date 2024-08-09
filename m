Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA8EC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 19:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEA458880E;
	Fri,  9 Aug 2024 21:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723233521;
	bh=ak2RCDFVw8J+ZXv2ee9fYBjK1Ona1/HrFk/4jN5QcdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FuwIl1uIaOzvlw2Xn1PviyAtpBVO9C4j777+/DkJtprYABWlvJkP6Ke8VSm6xtiUb
	 2V2AYYXNCE+MZCJmGhDpykxm1qWRLGa5mecIsUK+EBuzlL3TaRyYJP2Jg+1Q8p2QEr
	 Zs0HyB/PZP2ehHShHqrl3Pb+tq3X3SMfn/HaW81ARNfHs/uZvMwyBg4vxz+RLNu+Di
	 Buy1ksL72MzcR5t9HJ9prsIMOV/nrFxiix2tfON6NQw+SUrYy80AnQmp7dsNiYtv5W
	 OOL4OOzRqN9KEjxYshRrQXr4D7wIzCGVFDJw7bV5sU0WUkDgzLzVClk2M8y3YemdoM
	 xKyc2tWAoF+oA==
Received: from crub (p508b6395.dip0.t-ipconnect.de [80.139.99.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 63512887E4;
 Fri,  9 Aug 2024 21:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723233520;
 bh=ak2RCDFVw8J+ZXv2ee9fYBjK1Ona1/HrFk/4jN5QcdU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=wRdT3yzO4+GLvPOLWk7lPIFeYdpDPTw/02l2RdEye3SoNEMEu4WnwkR8KnfpUTE7S
 tOqTMoSfY41HpQ9SJlYw1etPkEpLbIkaLE+GsMz2kdiL3XYFTrCnuIDdxqIhHMG027
 et+dbuWal04ONWVSwK3wJ/V02YxF/l/LlehLOm/XyTF4/VCv5kNiev9PHmGgSYvKit
 ljS1k4/4HsEBGz/5nqzNrr/+ug86giUSEvkip0dhrlXOyMqlvNwP+u7e9WvAHtmuUK
 SwQUIdJCQrzR2Yww8wxecpV7FN+nfFwwccggHwz1XE7SBH1XLp2+h32N+yz9Yj/qYV
 VDZTgq1fCMZdQ==
Date: Fri, 9 Aug 2024 21:58:34 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 00/20] i2c: Chip away at some old code
Message-ID: <20240809215834.62643ccb@crub>
In-Reply-To: <20240809185641.GU1626301@bill-the-cat>
References: <20240718173611.4014274-1-sjg@chromium.org>
 <CAFLszTj3JsUHFvWUmP07mGwK315qO=Bt0uQ=JGeKrLgBOQxoJA@mail.gmail.com>
 <20240809185641.GU1626301@bill-the-cat>
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

On Fri, 9 Aug 2024 12:56:41 -0600
Tom Rini trini@konsulko.com wrote:
...
> > What shall we do with this series?  
> 
> Later today once I merge Heiko's PR for -next to -next, rebase on top
> there please, I believe all of the platforms have been converted now.
> Thanks.

there are still a few arm/arm64/powerpc boards that need DM_I2C
conversion. I think we can disable date command for these boards
until the rtc drivers are converted to DM_RTC. After that we can
finish DM_I2C conversion.

--
Anatolij
