Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E550AC48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 10:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D7E28807C;
	Wed, 21 Feb 2024 11:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708512192;
	bh=j50eO05yRSVBzkl1TjpExrKB0ptO4wwBhQx8SwppDuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZKBnqApUln4nWuRYaS+TU4GD/ybKpqM9P+XlIcxp7b0Z8jLZTcVGWxpHd6VPQTWfp
	 8yk0jFerkljQzRv0SgzMi1rKXc0abLrTmxKKSkGd5V/KhMu899YhDtNUNkNIBIkx8S
	 3uEhHu9AWZXijQ9aYkYANMHqx6l+l3iG06KWPzvH0MDvNYVx1lg7wnqs53oP9TYQys
	 01NMmYBtFrJCLDJ5l7d/f0o4k1LMuQcAKwBQuVEKAHNrAMuZdguB6HsLOe3vDO6PwG
	 e6mktYJpFsoFhuUVi7AY+LrRLVcKoA4wJQU+D3mfLC0FkW6S0Nemmu7KMGLw1Hfjxx
	 1IPamkHOsdM7Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0EE9B88079;
 Wed, 21 Feb 2024 11:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708512063;
 bh=j50eO05yRSVBzkl1TjpExrKB0ptO4wwBhQx8SwppDuE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qetZmNAW6Nts3hI6RPluU5Tx639HMiOPf9T3GCon0uvDqmEVOQuXJ1zCtWeJQQpBF
 Od5/h7ttXTSI3Zf8jrllsB0Y0796f6OD8X1rSvZ52gh3g/PmIJZAKv1op4Y+3z1mub
 qesUQO3tBn2TZli6P30RCvSh71kzoMRKHwC6EHqQA9KbwfaO/mJxmMAjP9nKpu8oaw
 bp0DmtnqLVa0aZ45Sq0IEH/+M0tOrFiI9uTNPkiitATyGNsVwDGrgnYnbFSKflBsry
 GaEepvsOhlx5fyiPd61TWfIweHBivu1eB+CPG1C1E1h6hLCqvqvNyJotOONr6OP4Qg
 cjwLH3ulVuJDA==
Message-ID: <79590f1e-d90c-4d42-9633-7fb9cee17228@denx.de>
Date: Wed, 21 Feb 2024 10:39:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
 <20240221075516.GA5131@francesco-nb>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240221075516.GA5131@francesco-nb>
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

On 2/21/24 08:55, Francesco Dolcini wrote:
> Hello Sumit,
> 
> On Tue, Feb 20, 2024 at 06:40:56PM +0530, Sumit Garg wrote:
>> Also, enable reset driver which is a prerequisite for PCIe support.
>>
>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>> ---
>>   configs/verdin-imx8mp_defconfig | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
>> index 22b8a334dfa..d8bd644322b 100644
>> --- a/configs/verdin-imx8mp_defconfig
>> +++ b/configs/verdin-imx8mp_defconfig
>> @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
>>   CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
>>   CONFIG_IMX_WATCHDOG=y
>>   CONFIG_HEXDUMP=y
>> +CONFIG_DM_RESET=y
>> +CONFIG_RESET_IMX=y
>> +CONFIG_PCI=y
>> +CONFIG_PCIE_DW_IMX8=y
>> +CONFIG_PHY_IMX8M_PCIE=y
>> +CONFIG_CMD_PCI=y
>> +CONFIG_NVME=y
>> +CONFIG_NVME_PCI=y
>> +CONFIG_CMD_NVME=y
> 
> This will increase the u-boot proper size and marginally increase the
> boot time (because of a bigger binary to be read from the eMMC).
> 
> Apart of that do you expect any other impact on those changes? SPL
> binary size should not be affected, correct?
> 
> Asking this out loudly to confirm that nothing unexpected is going to
> happen because of these changes.
> 
> For my curiosity, care to share what's the use case? Do you plan to have
> the OS stored into an NVME device?

Boot OS images from NVMe is useful if eMMC size no longer cuts it 
(because debug symbols or to collect logs over long periods of time).
