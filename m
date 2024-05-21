Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152E0C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 10:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A95B88748;
	Tue, 21 May 2024 12:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716288948;
	bh=Bk+vCeFHARpAccUrGW9n0hEdrbPDRol6bXpkGpOrugg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xxqX9ICIcu11+JWqZZ9qjpl93FKrYM2Hb17UQkXifsVLjAwk1bgY+e7ZpU6dekCbv
	 x11U3n9sosWmQEkNmw9lVEs367Za5t136UaK5/AJ/XFW/eknC/ZCR8yMHRSCZn3LTI
	 EohZmGEMod5Wr/dUQMu5aeYHQZ02NxeFKuSH+VkMIPrELCE2iLLYnkjSOmVTSgBtcE
	 y0kVJi8k3gf4iwOGStwt8e+hFCkVWvz0E6lTHbCIsRePG3WVyz+eBl+rmsNN8tQJ6G
	 4Lj6fyUfH6IbwX/KchQVm3REEWTQN+P8h8mbqtT+mjCtJuUlCbwF1SSTLlPpvZvUgz
	 EXOhm0lxJc1eQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7DE018871E;
 Tue, 21 May 2024 12:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1716288947;
 bh=Bk+vCeFHARpAccUrGW9n0hEdrbPDRol6bXpkGpOrugg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ONsFKl+N2K3v9PL9kaLMEP8c8lJTUSsiwGs4u7fW1a04SsG1xAK5Qjl/ges0XjMcL
 dmOLDaKPNVNO7Q9PQGKOyGcbDF5a+Q2klOFFdASZk52TRzAcg3horzVgfzcigPBN9R
 f2EmAlpFt1/U9XzoUaxfm2kCMylGxCT+CbEKWhlI00eLIwaduN8ULjPHho6sLQw6at
 44MzIejE/NvTm4EPj7e9fTxqFjGZIBRzL66gkyYsw7U2WU3EHuwVIqsZgADUwBebDh
 WfxSawwAGpCkOZd6QNuCc7gPKSqgIsnCDlDn29V44aF13SfqiZRFUiV1IhMCY5qHEw
 5Jb61BsAPaeSA==
Message-ID: <1478faff-ded2-4fa8-a368-9291220e97da@denx.de>
Date: Tue, 21 May 2024 12:55:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: imx: Increase PHY auto-negotiation timeout to 20s on
 MX8Menlo
To: Francesco Dolcini <francesco@dolcini.it>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
References: <20240521093950.8810-1-marex@denx.de>
 <20240521101200.GA12495@francesco-nb>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240521101200.GA12495@francesco-nb>
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

On 5/21/24 12:12 PM, Francesco Dolcini wrote:
> On Tue, May 21, 2024 at 11:39:38AM +0200, Marek Vasut wrote:
>> The ethernet PHY on MX8Menlo board takes a while to come out of
>> reset, increase the auto-negotiation timeout to prevent it from
>> timing out in case the ethernet is used right after the board was
>> reset.
> 
> Is this specific of MX8Menlo or something we should have on
> verdin-imx8mm instead? I am not aware of any report on this issue on the
> verdin, on the other hand the verdin imx8mm has normally only one
> ethernet interface, and this is the one from the verdin SOM.

This is specific to this particular carrier board and does not apply to 
Dahlia board or Verdin SoM.
