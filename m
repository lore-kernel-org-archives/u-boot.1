Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5CFCF258E
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 21:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB5E89069;
	Sun, 13 Oct 2024 23:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728853847;
	bh=k7VEGTX9HYGfi5ox+Iw8znuU+8MeGiTLZvM7roXZto4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=moNelIW4b71rwUStIrJCr7mszXKI5lYMzRuqqOYb803J95GDu9VyZAi9dBdYqeNyP
	 8J5OESE6iQ5mnxeM+2S6Ea8GaZUR85sg050lARf37qJ6IF3ikoAq8I5t7d0KGLo8Jd
	 yLV2+cuWbRT5q0tGR/TCyxqGYBeHWcZGmotgGv/3mMdPXft4MbbScU892e1/IsEily
	 IR0v3lyAztZw9LJ1yZi/AP/NBfFTtc2+16vQarzlfNXcHsFOzWiAWf8Hs4VX6UoPMR
	 2JlkvtRlf+pof+ca0dvQb3RO5wEpWhyEaNMocwNfOsn4w9jN8Y9/STsq803UiYnn29
	 hrRXLzJhsW5Dw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9C42D890E9;
 Sun, 13 Oct 2024 23:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728853845;
 bh=k7VEGTX9HYGfi5ox+Iw8znuU+8MeGiTLZvM7roXZto4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uXO45Xv0tCe8YUFYLgOmJ4xccFytszqZd3dSSQh9ClcK/DXLCckfHVw7R7Hbh2W/N
 DONPIoTWtsLcdF8VVi4DM3m8y+yJU/l4TD4gi+IJHEOCLk8JfiCeTyjYMRVITBlPf6
 MyiRXMLmp2F4VIz2tBHmSqKAtYi+UZCWMr2w/1V5DjOOqLhvXk107pXusQrN1tvHf+
 IjjlZuRwW34wxdL8eexwZqt2KCUy8q1JtL7tuE1ghgxxuXMXRIPWRlygtmpTtRXok/
 BK3/eZmIzkErzip/CgLiMd2Hn7Tn42y0/JE0yXwc+kDd+8tugtTEoEUqKMP/tPE2vq
 TJyw5qdsh3c8w==
Message-ID: <31cc8a21-6f40-4218-accc-a633d3b16e67@denx.de>
Date: Sun, 13 Oct 2024 22:38:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] usb: dwc3: invalidate dcache on buffer used in
 interrupt handling
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
 <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-3-5f3498d8035b@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-3-5f3498d8035b@linaro.org>
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

On 10/11/24 4:38 PM, Neil Armstrong wrote:
> On Qualcomm systems, the setup buffer and even buffers are in
> a bad state at interrupt handling, so invalidate the dcache lines
> for the setup_buf and event buffer to make sure we read correct
> data written by the hardware.
> 
> This fixes the following error:
> dwc3-generic-peripheral usb@a600000: UNKNOWN IRQ type -1
> dwc3-generic-peripheral usb@a600000: UNKNOWN IRQ type 4673109
> 
> and invalid situation in dwc3_gadget_giveback() because setup_buf content
> is read at 0s and leads to fatal crash fixed by [1].
> 
> [1] https://lore.kernel.org/all/20240528-topic-sm8x50-dwc3-gadget-crash-fix-v1-1-58434ab4b3d3@linaro.org/
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>
