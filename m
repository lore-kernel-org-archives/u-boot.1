Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF50EEE271
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 23:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D418F8910D;
	Fri, 13 Sep 2024 01:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726182719;
	bh=pxSM8Ni0TgtsgDrju5L1UG4HGZrHy7amTuGVez1D68M=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JueWfVtwvJGmOG9PyI7uCL/zO1iaIMS7Ses/agvvjlgkSOwVp77MDD9DqAmEzaE7P
	 7E7Rj2RFPwDxNJA4VKzaO/V/tXLOlXTE1z8yA8iLEHh8fsThKx2Acgu6yVJgm/HSme
	 vs1Z932NdMNJC4oNSoLnGUkF7FpOytnm/iQbauOQAyQNj5Ua6CDPdFIQAOkFP5wGRM
	 DCGtmmKCIdICAR9FUeSU95ww3OfsE2JisHUQasXm4WgCSFLNoeRtA3DYUdCey2lG30
	 SOWTtOZSwbeJuk8enYyLIA7/Q3vfGbVsCHty4IvSLGBxXBAXSeM+QA3j5dozUGs2/N
	 VWvdHvZiyqLVQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C329988D7B;
 Fri, 13 Sep 2024 01:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726182719;
 bh=pxSM8Ni0TgtsgDrju5L1UG4HGZrHy7amTuGVez1D68M=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=dv1OnUEabm1xtmv3MgM9iju2h2nSVSDYDBLWoHFuUFSetBBsg5jNK/ny/oGtSgGeL
 YbaC6scxS+0e7iidVewmJPCZQrNEca2vI81JM+ChYgIqyjpzq23FeKetPgUmM+WwsI
 AbANCzVZP/xXVVphbTFh5BQJBngD9cGO1KGydQwdK4LWtt5RwyWXE/g3JkpOVlWEzd
 Blo8PUljXGP8ah6NngIAwcmn+FWwHoDlrgAs9x7zgXMb+KXDlpmGPASuebYLRwUKC3
 CWFjq60X7Fm9j6JneoMs9IA8JTb0rzXBCwPAfcS7j/o7K5htWt6q843LBKP+F1cJSA
 kWwccO5UeRJHg==
Message-ID: <bf99c2bd-f43c-4041-907f-f60b42163cce@denx.de>
Date: Fri, 13 Sep 2024 01:02:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-3-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240912060649.190-3-l.rubusch@gmail.com>
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

On 9/12/24 8:06 AM, Lothar Rubusch wrote:
> Introduce device-tree files for Enclustra Intel AA1 SoMs and related
> support.
> 
> - Mercury AA1
> 
> The setup depends on a selected boot mode. Various fragments for SD/MMC
> and QSPI flash boot are provided.
> 
> In combination, the following Enclustra carrier boards are supported:
> 
> - ST1
> - PE1
> - PE3
> 
> Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>   arch/arm/dts/ME-AA1-270-2I2-D11E-NFX3.dtsi    |  14 +
>   arch/arm/dts/ME-AA1-270-3E4-D11E-NFX3.dtsi    |  14 +
>   arch/arm/dts/ME-AA1-480-2I3-D12E-NFX3.dtsi    |  15 +
>   arch/arm/dts/Makefile                         |   2 +
>   arch/arm/dts/enclustra-aa1.dts                |  32 ++
>   .../dts/socfpga_arria10_mercury_aa1_handoff.h | 307 ++++++++++++++++++
>   .../dts/socfpga_enclustra_mercury_aa1.dtsi    | 179 ++++++++++
>   ...cfpga_enclustra_mercury_aa1_qspi_boot.dtsi |  18 +
>   ...fpga_enclustra_mercury_aa1_sdmmc_boot.dtsi |  18 +
>   .../dts/socfpga_enclustra_mercury_pe1.dtsi    |   7 +
>   .../dts/socfpga_enclustra_mercury_pe3.dtsi    |   8 +
>   .../dts/socfpga_enclustra_mercury_st1.dtsi    |   8 +
Is there any chance to upstream these DTs to Linux first , and then let 
them all trickle into U-Boot through dts/upstream/ ?
