Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC5BC54E71
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 22:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D0B88027;
	Mon, 18 Mar 2024 23:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710801473;
	bh=yoY4rECuHDwfhpSZZ7WqSjEoeYBzFL/4Q6MdKTJvJjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tAc6nLPJaH9jxv6oYTi7z/MUeLmlZMo5aF3y3/3ZqdFC57w/zvGVlQDGFfhkKHgmR
	 YGnY7rSUDPCUeSrdZNl4/LlKbNzHEyJvgREpYCBNTwZ1CMx7yLKC2oH11djh/97s8q
	 syfkyVSy6I/atSZ2UsJdDQJOi+YGFQ3HWOUdIxgPlWSyzS0jPqOc3gCEB85QQDDkXx
	 DV203slG5uODqFrcNqgRDFMzyti+d0GcdGCcwMc6WiXlBwo3/uagdfMTr3Fj6ssyDl
	 5Jac1d3DwIp2esF8mwvh3WTTFjpnBk5BC6G4r9P9tvqugSybfBEaRIVx2zOODw4m0w
	 M9Hkzvq0KC0DQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0419F8801E;
 Mon, 18 Mar 2024 23:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710801473;
 bh=yoY4rECuHDwfhpSZZ7WqSjEoeYBzFL/4Q6MdKTJvJjI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=anOc80aR3+i237eOIkGCH3Tx9DlHDvm/iTdqTQQddCE/0nyKLNYWQGSgNV+MjhwGO
 KaHWDOBYyJox+ohODX3sGgZo+5ufLVmYK/wLw2Saq+6LNVBZObvf0dVjnpsakN2LJ1
 PGxpQd8ot4m0c0GY1kqZJd76T+8lFoR6ObQxlhrsTGD5kz7vd0r2vhaeCEQMZki2Xg
 PGAftk8q3oR0t7vf7mn2CV8aATwoRCaP18m8NN1T4mHwKMCYmp7swR2g2yyNlS2OEm
 dUPKeASrbBdju6EuUfBPIG8Z72cxcEGVwVuce2qP1GuhF1TDcmXhlJd1Q7+Mbftyp+
 Xgzzlrtr9ey6Q==
Message-ID: <c9f92bd5-96c8-46b6-a672-9473d7be7aac@denx.de>
Date: Mon, 18 Mar 2024 22:48:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: dts: imx93-phyboard-segin: Add USB support.
Content-Language: en-US
To: Mathieu Othacehe <othacehe@gnu.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Yannic Moog <y.moog@phytec.de>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de
References: <20240318171637.12664-1-othacehe@gnu.org>
 <20240318171637.12664-2-othacehe@gnu.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240318171637.12664-2-othacehe@gnu.org>
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

On 3/18/24 6:16 PM, Mathieu Othacehe wrote:
> Enable both usbotg1 and usbotg2 ports.

Drop fullstop from $subject end.

> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>   arch/arm/dts/imx93-phyboard-segin.dts | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/dts/imx93-phyboard-segin.dts b/arch/arm/dts/imx93-phyboard-segin.dts
> index 85fb188b057..acf307a3192 100644
> --- a/arch/arm/dts/imx93-phyboard-segin.dts
> +++ b/arch/arm/dts/imx93-phyboard-segin.dts
> @@ -40,6 +40,19 @@
>   	status = "okay";
>   };
>   
> +/* USB  */
> +&usbotg1 {
> +	disable-over-current;

Why is this needed ?
