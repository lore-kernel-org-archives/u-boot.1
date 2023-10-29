Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE7DC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6889287C95;
	Sun, 29 Oct 2023 16:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592190;
	bh=yFlETdTA6Xp40NlI72b1ufUiTkOzvkjPt+KEtxPkQ2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qv7QGXRufoCTyqF3tc15m6cSnTieYIRxR3f02vzAW4gByQgNPCJl4p9RQzfwDFIz9
	 o4mBZbwCBC7Y2R96D2nM28YzmAhWPd9Qac/8EjRy7HkK1Lj0H+uEPl7Z6fUMrV7+bR
	 QnvPzg0u7st94UJwLtk8IEegjrY5r4KphpQZUIjEcrVG2EL+XeZiADNspXrOjD+N2p
	 9y8OJ9aeNL+PVOh4sRVnNuw9GnFMWUOsu9B14JyxJiwsI3ybE7sk7tX30FxoGTe8Lk
	 pAUyZYuCIk6GbVir2o9ZT8hkNGv4iS2g2eiArOaRDN5q7cEaK1059R59ugj5H5CbBf
	 f4dEiV6EYo/9A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A5F0D876F8;
 Sun, 29 Oct 2023 16:09:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592183;
 bh=yFlETdTA6Xp40NlI72b1ufUiTkOzvkjPt+KEtxPkQ2k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VQAxzpdR7fvfANEbvOb5B9H7OIiHGhQxNNyZ23MB4CXDdrM8rheL7VP3F161JoXrx
 DbVjg9uuJAKIOG6YkV/RF5WqGsQQ4ENH9K0pSTiudi61c5DRdDLWa+a5njeUUX+Ql1
 a7+pdwD4Hb9eCVKUipN8kNbinwOatpx4l3cmZ80WVE0PJk1UdynvTpjgpp2St73I/H
 hp9e5O3UwneYS/FiftSzPtTy7qHhBpH+SGMylUKBZRtIVBSsg03ByhaU9ZmjAiwQBU
 0OUCEnG+trGh4kSSy0JIwIjSTB11uCRi7fgEK+2yQ6yXDDpBivcN30okAo11K4F0UH
 dgvziq0B1S/hg==
Message-ID: <11e44dad-9e32-44fa-90d3-baa0d2eb63a0@denx.de>
Date: Sun, 29 Oct 2023 13:10:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] usb: storage: Use the correct CBW lengths
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-3-v1-0-0153210a7f55@marcan.st>
 <20231029-usb-fixes-3-v1-3-0153210a7f55@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-3-v1-3-0153210a7f55@marcan.st>
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

On 10/29/23 08:23, Hector Martin wrote:
> USB UFI uses fixed 12-byte commands (as does RBC, which is not
> supported), but SCSI does not have this limitation. Use the correct
> command block lengths depending on the subclass.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Marek Vasut <marex@denx.de>
