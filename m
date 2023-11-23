Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0FEC61D85
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 09:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B94A86FB5;
	Thu, 23 Nov 2023 10:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PlY2h5mE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C6B86FB5; Thu, 23 Nov 2023 10:58:33 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F09986F34
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 10:58:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [100.94.55.57] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id BB15C6607390;
 Thu, 23 Nov 2023 09:58:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1700733511;
 bh=yR7f944fUA0J3gmfCTipLiWEMaQqW07XzozDzlOV6xU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PlY2h5mExIoNdGrSJhYkYfxoWBHGsZsO+q0EpRp7U9P1kRnQhTJpmoDRHHvVYKcHk
 13sjfKW7DXdPBK6Rri1eOwHwcbM5g/7rFJLZbYXraXHqr+eAwVVmU/EUOskwscOTyo
 8sWglcnyHylkZWgGJHcqwECpCCReTcgl4NwakIHUyOtXf/avUhg6+cOLwC4iIbLWkB
 ssj1tWhiNSt1xwTC2paBJrErrFdHhVc36eIG714vHkzJxCgxH+gZASBGH2Gpyg4AkV
 qbzUspROb6wlR7zPx15aL1GjQDX5a/k2gQnzNIThJFdzdGbb0Q9otM09HffMslVdp3
 Ruh1os+Dyxn/g==
Message-ID: <65cd4f1d-10fe-4701-b362-3995f8f0bfe8@collabora.com>
Date: Thu, 23 Nov 2023 11:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: eMMC errors on RK3588 (rock5b)
Content-Language: en-US
To: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc: jonas@kwiboo.se, u-boot@lists.denx.de, kever.yang@rock-chips.com
References: <87pm01oxd2.fsf@tom-fitzhenry.me.uk>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <87pm01oxd2.fsf@tom-fitzhenry.me.uk>
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

On 11/23/23 07:22, Tom Fitzhenry wrote:
> I am able to reproduce this on RK3588 QuartzPro64.
> 
> I cannot reproduce on the vendor u-boot, used on stock RK3588
> QuartzPro64. That works fine.
> 
> I thought "[PATCH v2 RESEND] mmc: dw_mmc: reset controller after data
> error"[0] might fix this, but after applying that, I am still able to
> reproduce the issue.
> 
> 0. https://lore.kernel.org/u-boot/20230619103347.278004-1-eugen.hristev@collabora.com/


I never said that patch would fix this issue. It fixes another problem 
that was happening when the controller was resetting. But that issue was 
arising only in a specific scenario which happened only during my tests. 
So the fix is here, it's helpful, but not fixing this issue.
And it appears that this fix will not be accepted to upstream, as it's 
months since I am resending it.

Eugen
