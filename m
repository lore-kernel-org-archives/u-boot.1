Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AC7CA0EE6
	for <u-boot@archiver.kernel.org>; Sat, 16 Aug 2025 12:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A553383445;
	Sat, 16 Aug 2025 14:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=rudi-horn.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=rudi-horn.de header.i=@rudi-horn.de header.b="vVypFwMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E8B83445; Sat, 16 Aug 2025 14:18:50 +0200 (CEST)
Received: from mail.rudi-horn.de (rudi-horn.de [198.7.63.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A289183443
 for <u-boot@lists.denx.de>; Sat, 16 Aug 2025 14:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rudi-horn.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dyn-git@rudi-horn.de
Received: from [192.168.178.22] (dhcp-82-220-85-57.bbcs.solnet.ch
 [82.220.85.57]) (Authenticated sender: journal)
 by mail.rudi-horn.de (Postfix) with ESMTPSA id 9A5991A0A41;
 Sat, 16 Aug 2025 14:18:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rudi-horn.de;
 s=mail-vserver01-rudi-horn; t=1755346727;
 bh=U5yvv51h7jNBk4fl4yxTI/9u4SE7TtfmbTGF0mfwtrc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vVypFwMPIi56HQx8mnBON3zTjE/BkqP4f9X778f8c+B7YMyuDd0XM28Iw9VChR86D
 ip0GmW0fuE57OhaMFWgfXxPqoFVuPhLHThrnGH1Ds28K6+dGb4KWEHBgdxFjUkqIWl
 qCNAVIcn6HSC56DDJDGDGKKg6WKMEMRv06H1d+H9gqX3vZqPbSrKkrwakuLl++5Nxn
 qrAaXtuoJejmKODYTow1zYEMoJ4jfz7+B57lVGeImMjkackxhrOHy/D09WtolVT9mW
 TcvaJTV66Xl18Ewl+54PtEGaHrLYCHYceLH68RhR4dWIUz2NdVyMtevzs8MQkUMBir
 aPJDBfz/P3MCQGcjs9eXqohx5idMZoImsRmn6Mq8DoEJF0lvokAElxQQBZooV8u5is
 xYxDUjxXfRw3ff9P7YHY/Q5jUuv5yZmGvO+LbB1hPevl34hQnEatjlk3VFMepzlBRQ
 geEC/AcdMEPmPP4zVqwNrNYwgmqwgrTg6V4I8HxRHcfv2giYvg5kwJ/Ay8H/bGmobq
 3hbgfPkQMFJa9IpSnOke83bAH+3vm5YXlPn7z1VUlYfTCwh8BYJcS9leOuPHyX0Kag
 4gwAKiWwB+/m60kJCH1LFu0IFMTZPNMbdZVS/RfAue6xuILYV5vFQ+O+XrWuP5nWCD
 mVdUbstik7wS3E2pF1ltdz0c=
Message-ID: <9c947490-a571-4b35-b3a9-66c8174a7490@rudi-horn.de>
Date: Sat, 16 Aug 2025 14:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] Fix detection of odd memory configurations on sunxi
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@lists.linux.dev>
References: <56f44755-fca8-4364-905e-685e79fd1aea@rudi-horn.de>
 <1927944.tdWV9SEqCh@jernej-laptop>
From: Rudi Horn <dyn-git@rudi-horn.de>
In-Reply-To: <1927944.tdWV9SEqCh@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 16 Aug 2025 14:58:43 +0200
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

Hi Jernej,

thanks for the comments on the patch.

 > I don't see a benefit for public function here, since it's unlikely 
to be > used anywhere else. Just mark it static. Compiler can optimize 
it better.

My motivation for this was that the implementation relies on subtracting
`sizeof(u32)` from the address. This is an implementation detail that relies
on the internals of `mctl_mem_matches_base`, and so I wanted to place
it in the same file as `mctl_mem_matches_base`, preventing it from being
static. It will only be called twice, so I don't think optimization is 
too much
of an issue. However I don't feel strongly on this if you would still prefer
it in the same file.

Once this is resolved, I will submit another patch with all of the other
comments addressed.

Thanks,
Rudi

