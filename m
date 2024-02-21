Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD20C48BEB
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 15:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92178801D;
	Wed, 21 Feb 2024 16:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708531107;
	bh=SA/qwtnWEOvG5f0DmwLRierDsn/a+Up+I+pKvJT0OC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TTJL/ebsiH2Xs3ZmIp8R3FHBZ6bLHAl728z5j1IZCyhtgLOhaV4ympeycCDheFELm
	 pWIn7/ly/15Tf/nd1Ai7RCZpQIpEQdAV3ci4ewTGfJaiksuEEGb+678GIcIH4Ydfac
	 sscVY/Ae/UHdyysSwXpFxUhfxX72TL6lR/QYJwyxjeg9hZpRH1d/UN0EUzlvCg0t4H
	 Zdm6u8aUqQJZyGsSNhsO4w14D9Z3eKthpMxRB6is5g3+4Ov2G/BdLeia5tUi/Owv1N
	 1/F1byOZj+qq69CQomlcsm1lbbi1zrhQIcWmzZy7sMGySCmB4DCYSfgOZSixkg+qew
	 UqyG/W2J8JrSQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 39B938272A;
 Wed, 21 Feb 2024 16:58:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708531105;
 bh=SA/qwtnWEOvG5f0DmwLRierDsn/a+Up+I+pKvJT0OC8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=restZy4xglmz51rRBcad8i3xERaGXGRpNO8ABzDerpb+AxrEtX2HO/sAA/TpTsDdC
 Vw2/OWRsQZZ+SxBiXRnDkXpkSixw7DjtXEWW0gOoG2AD7xVFZ7X3BIgcv9+fT/yK1Y
 Z/ZVghqTGf2MhWyM8A70zYYupf+KAWtRJ41QaiEuaBDztRoLOO1JIwOyDwxHYVnLhu
 MSyXxsIkgJIpZwY/3ylLOC3lmjGqZyB+Bzm5QWgCoBXmFNIA7nxfW+S68LDIBJavdE
 ePCwvumwXPQHRZAmejZuIKVdGXmUs2dzmHraYUMyWqUMOsIxsfusmkuwaOX80gQvIe
 x0sAXQMqT7ixg==
Message-ID: <d4cc7a36-5703-4f68-a760-e8fb8bc6ca5a@denx.de>
Date: Wed, 21 Feb 2024 13:28:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] usb: xhci: refactor xhci_set_configuration
Content-Language: en-US
To: j@jannau.net, Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-1-814b2e741790@jannau.net>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240221-asahi-keyboards-v1-1-814b2e741790@jannau.net>
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

On 2/21/24 08:25, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> In the next step endpoints for multiple interfaces are set up. Move most
> of the per endpoint initialization to separate function to avoid another
> identation level.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Marek Vasut <marex@denx.de>
