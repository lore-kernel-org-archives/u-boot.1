Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088B9C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95BD787CC0;
	Sun, 29 Oct 2023 16:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592195;
	bh=Oycuat/edA/HiT92S8gAyA5XupVbufHEA1EdkI44MnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Syb5OK4aZV24lJRBRnQkt6pc8i7uNtV1OgiI+UlgtGX2lpdRnkE/HBBP+NhfVmczc
	 vTR3VlQ7lbxUqkov3i7kx9xvyDuLrbrU1EYqTykrsW/6YKYNIuHMSn3RGuATqbeQst
	 thpgJKkzzgkimkHru1iu/XCClRsGb126ihiVT8unoQieypb2kpa9A0ss9JSbXD/EKl
	 svMdoZC5pPBpA48wpg14WEoJ5vnqX3ZEj6HboZptPNgjt19O8dptDxfmGPXJD/px2U
	 64t6MWQeC6NRN7WjBFreLByAYZGikS2ez8MbDhalKqEfddHhgEHJGptpvPwHZsexqk
	 FesiRHM6IHmUg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 831CB87950;
 Sun, 29 Oct 2023 16:09:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592188;
 bh=Oycuat/edA/HiT92S8gAyA5XupVbufHEA1EdkI44MnE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pr6I0ZHJJl/gdBL+taHT9A6vN9Goy4S9lJ5RPfb2qXUBghOQnbOHPoNtHM5f7QuxZ
 gd7pqlxam3P58VYPGXtmVmMYv/dnK21EtkRI4h795uMdfe7TDGc7AeVqs4ua7ruoli
 OZvS4RGQ4XQa6v4fewBYRHmfnEQPsy1zgOHbSMiRzDBNtXrTxYD52mCFDca6yG1A8m
 XbaJfcDTFOcI34sQuedruWiOqtwTovZvcrTgJmIPF8K1e1dk7H+5pGOvnSqSVOB3yK
 ZMEiRZHnMNkveFqQgdR8PWbkpNxffDDBfBG6wfASB2/d0umWT6fj7fO5Y8OOGj4PAj
 6uC01wtnQru1w==
Message-ID: <5b653914-92a9-4b7b-87aa-51820ab90335@denx.de>
Date: Sun, 29 Oct 2023 15:35:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] usb: xhci: Fix DMA address calculation in queue_trb
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
 <20231029-usb-fixes-1-v2-7-623533f6316e@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-1-v2-7-623533f6316e@marcan.st>
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

On 10/29/23 07:37, Hector Martin wrote:
> We need to get the DMA address before incrementing the pointer, as that
> might move us onto another segment.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Marek Vasut <marex@denx.de>
