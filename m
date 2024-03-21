Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0B7C6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 19:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A3588813A;
	Thu, 21 Mar 2024 20:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711048635;
	bh=Wng/1RnjKtdqqLJK7UQbmz4phmcmY+XI5ItL2fFdurU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bi1a/G4am/4l/uXMZlD1Tv0uCdIOwHFlle6D1EQyod0T8IX7bETgWG1E1uhoI1Wjg
	 ZxCsHdYiPLfeFOBfJ7PYAGhuRc88hD0bwO7+4MY16UnzZxrDC2XovPblsy2GPu3fq0
	 xU24EiUGvPT+KY9NDHTghoIcA419ahjtwvvrha/q4wiPmYHV+f3hHgaK+ntcChbuGK
	 xwMit3rKY36aja+W/5EJzNzk2YmROPI5eDPodbBy3Qah9zD1Ib0OR3LyrbaPjL2U6g
	 xjY47jrDXsgN+1y979g7N2KqcYaNbBdjVdFOdKVrWn+dcnzw6mZiu/85fzSXTrA4qp
	 xRlaf1ruxLfdg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5C2F388125;
 Thu, 21 Mar 2024 20:17:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711048634;
 bh=Wng/1RnjKtdqqLJK7UQbmz4phmcmY+XI5ItL2fFdurU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hzh5g5XKUb5ZTuh9v0IvwTcVM0X4dVaE3moRkTeSNbpWGpqYFR2Gv5cs+GHcHfLz4
 Vs7imB5o/c8BOppYzZ8dE5vVMunSGUnkUt3XeS1q006tM3+SHlrdaCu7Ea9TUpCiD/
 x/Dyw6UsrtYrOK/XSswDJ/bUONz4CDhBPcU132/AveVqpLfUoryR/s1aQ3wrbWBTiG
 +0OFfnHteWhIOD3MbffzCjSKzboIU/O0FUgRfidPEmW9SjYl6Y/Ex8EHs0duXM48Dn
 8auhDGCL8OkBNWEiyEIvTGQ1fOvHybvJ5kOH2BBpHzBk71I1GS9B8Fyr9atscCu9AX
 ZCys1hR5qmLcw==
Message-ID: <7b72bd8d-653e-4bba-9d62-26a60d85792a@denx.de>
Date: Thu, 21 Mar 2024 17:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm: dts: imx93-phyboard-segin: Add USB support
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
References: <20240321144541.15314-1-othacehe@gnu.org>
 <20240321144541.15314-2-othacehe@gnu.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240321144541.15314-2-othacehe@gnu.org>
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

On 3/21/24 3:45 PM, Mathieu Othacehe wrote:
> Enable both usbotg1 and usbotg2 ports. Disable over-current as OC pins are
> not connected to the SoC.
> 
> This

"This addition to ...-u-boot.dtsi is temporary, ..." would be clearer.

> is temporary, until USB support is added to imx93-phyboard-segin.dts
> in Linux.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Reviewed-by: Marek Vasut <marex@denx.de>
