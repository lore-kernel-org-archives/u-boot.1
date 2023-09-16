Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD65C2BA12
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 16:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1BE086504;
	Sat, 16 Sep 2023 18:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1694880466;
	bh=9EI3ZfIj7viA6VNnVTXvcsUF+m+pPhsq3WSLvx9lLbA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DCvTOljPngGOVC00LYfCogBy6+QkGzZP+UhQ4t7JKNRf6vI3Fa/bdA3BfMhsGXYdW
	 ViYX2T+X3SW05m5w+ks8ayhCzt7lGewSVEsn6yZPBaF/0mAxWfsC15wLaAlI+ZtY+i
	 FD8nf+elnnSTnKLDk3DR4ApzfhLdcwt2DkS01GUeML1AeHg4+Ma238DIPiS2JN4OkO
	 x0zVTJ4PFEl5tUINHKS96UeeCM9Qp81ooU9bN5trIoeNW3uNFi5kAvLqrSA3Lt2sOH
	 TUImro1lyWo6WWZipO0P1uRryhVqIML9rPIjXm5U8nBTQNo8KW+CMvFAaJvVe2gVDr
	 OCaD0tQFLsp3A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8610C8640F;
 Sat, 16 Sep 2023 18:07:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1694880465;
 bh=9EI3ZfIj7viA6VNnVTXvcsUF+m+pPhsq3WSLvx9lLbA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=v/rn20PyXyEvuaRQoX5KGpThhexe4Yn1byp8gO/Mv9vGx28euYVPimX3yzmqXfH5o
 CXtE8r6CaI/Rb3HNwyO5MKdagR9BOkrmj4mFJB5EN/JdWLOHUseI9TatiQw+9uqhL6
 Nl2tf0SNpdVtUpMwAGylaiXfNnsM+31VNbi6kx4c9HOPsQrEXgY9AbsJVtK1O4EKOl
 mMKTUZVgpIwtpt6qLI/Pqz6Q1jQERj+4QiSTHQEnoBnY/L2/LnQnUixDB7yw8OOm00
 hLjKdJQmGor1Zd8m78yF27KsVgEgtyUqDuvjCs8zQiByAgdb89KLKc+sHcZ16Kihmg
 CjWy7WLGHwwnQ==
Message-ID: <f00dad5e-bbe7-7a4d-e955-ce317cefb932@denx.de>
Date: Sat, 16 Sep 2023 18:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Aw: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
To: Frank Wunderlich <frank-w@public-files.de>,
 Frank Wunderlich <linux@fw-web.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20230820160004.44880-1-linux@fw-web.de>
 <trinity-6cf108b4-a879-40e2-a04a-54451262d671-1694873885042@3c-app-gmx-bs23>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <trinity-6cf108b4-a879-40e2-a04a-54451262d671-1694873885042@3c-app-gmx-bs23>
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

On 9/16/23 16:18, Frank Wunderlich wrote:
> Hi,
> 
> just a friedly reminder. would be great if it can be merged in next uboot-version.

+CC Tom

> regards Frank
> 
> 
>> Gesendet: Sonntag, 20. August 2023 um 18:00 Uhr
>> Von: "Frank Wunderlich" <linux@fw-web.de>
>> An: u-boot@lists.denx.de
>> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Simon Glass" <sjg@chromium.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Kever Yang" <kever.yang@rock-chips.com>, "Marek Vasut" <marex@denx.de>, "Jonas Karlman" <jonas@kwiboo.se>
>> Betreff: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
>>
>> From: Frank Wunderlich <frank-w@public-files.de>
>>
>> Add Bananapi R2 Pro board.
>>
>> Till now evb dts could be used, but iodomain is different
>> (evb has 1v8 on vccio2 and vccio4 which are 3v3 on r2pro)
>> and with iodomain driver this can cause hardware fault.
>>
>> Devicetree in mainline-Linux:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts

What would be real helpful is a commit ID from which the DT was copied , 
so it can be easily updated in the future.
