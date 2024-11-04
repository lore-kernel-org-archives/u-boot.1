Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE2CD132B8
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02DDB88CA2;
	Mon,  4 Nov 2024 13:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730722447;
	bh=VYdRT9CoMgQuIide0MS0BCgFmmVvcJtlhL6c/OuSzyg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c+5hquwvS12nCICE3qO1VnWWylX+Cn+hvjJ8MBSUJoaVWlbUeGjSs3VXJCzRP/noO
	 H9OcCaorb+wIxXUu5GDCdqDckckODhxld969dc1fUNjan8P20HM/NvlH7tf5g7fxIA
	 HP3C6J+xv9m+tXrBe36JebSOg/YhPxPOfaTLeCKGwx78zsmX1/qKkvIHIyx5bXeB2M
	 y5e//ktx+osJjIf8gdJd/TWHJ0c9Y2+PdeSb+XeK7eCzy6ksxjWSIZvFR7uMOzLYnH
	 M9sI4z5o/0obBLbCFF91YMlNZGhDhYwdxk6rvQuF7SbfYbdpa02D2B41cTULJdFTqi
	 IxFsv+KWrFePg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 611E880245;
 Mon,  4 Nov 2024 13:14:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730722446;
 bh=VYdRT9CoMgQuIide0MS0BCgFmmVvcJtlhL6c/OuSzyg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AlevxP08e/nqYviM7QY9SCpSPsHU4nTkLhRxjP1L+wz6/ko5wie+Liq6sZqV+DKz5
 si7q1OvSZqcPqonSdKV6lZugdkkAeOyIh5LiaN0L3gvpQSeh2i30UA/0pNYqYIllBv
 d6TxEJ+PgQSVLo/H+eqm2dTEzXSs0IL2gIyfPdRG35S6y3oyoKC58EUL2t/lXsTlmU
 ZRgyclWpc583W+YQgZmdYQ6ZdPw4P9Yk73hqeoArolHsdaw7CbV2mA3kt8fgRaVmlI
 AGOOlrPo3XENweELkG3mDTRk4aZEjGPrmP3DvEbqelwfEO2ZWBvtIlSyntRYvGQU3X
 5qbPnFoVcfShA==
Message-ID: <ee6519d5-30cc-485c-b87e-89665066a827@denx.de>
Date: Mon, 4 Nov 2024 12:17:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] (no cover subject)
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Teo Hall <teo.hall@nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
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

On 10/16/24 9:17 AM, Alice Guo wrote:
> This patch set adds the basic support of i.MX95 and has been tested on
> i.MX95 19x19 EVK.
I have a somewhat more generic question -- can we start U-Boot SPL and 
U-Boot first, and start the ELE/OpTee/... whatever firmwares AFTER 
U-Boot has started, so they can be updated just like the kernel can be 
updated ?
