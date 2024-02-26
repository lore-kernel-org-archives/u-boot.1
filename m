Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27853C54E4A
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 13:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DCD287EF4;
	Mon, 26 Feb 2024 14:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708952663;
	bh=AzDOUIfTKv73A+dxa3/khE8LXggnY5BcbQqZR7WFN9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WISTzuBVDTliUvXZMi5f2DdrbO+/2hmJMsBeIkmM54n+7Fik/FxWLl2F+I5js2V+Z
	 q+qS/olO+5QG2GMEIZBOJ++ep6tiRnfs5GkTQGuj+PSF+awbXh+xlFN/tJGdAdTLcS
	 zFYsUJsZO/Yev9Si26rPpRVmrEJNuG6aIend8k7kzIHABF4zDRUUVR2AohqKQ5N5oJ
	 tDfxj9Jp0NvpfkmyGrJXD+qn+8NyCs2YNsyxH8qKQnX/oSZQTqaGq3m4Dd8uI/Tc5y
	 8mTLN1uvvvPymlxiFhCRX7GPMmbM8+z74zgVVe0vbuQIrKkkLpCzmXKYNUBJkD1LUO
	 72+i1I/v/6ySA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A36E687EEE;
 Mon, 26 Feb 2024 14:04:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708952661;
 bh=AzDOUIfTKv73A+dxa3/khE8LXggnY5BcbQqZR7WFN9U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fKzuey+3ywOmhdYqPqtC2cnCIrzen0Z6H4P872fipvKJZ5ztkdAko+Izs5xEa239m
 yu7lbf9ZrQL0up7/sXL4KOXV11hBRT1plrkhfRQ9PWAmmYbvFcjP+FXpoinSGbwalT
 Jx36ahU5ZW/hvL4+6q07cKTKaJW4bEDLQQwiM9kYswNBW4dMF/Ez8hIZ4J8qM2+G0B
 X4OFRDe0sOOh4B1Plsj/nZ4IiVufwNbmXOBiSsViEcaw3ED/31/y8zcpPFQX7mDxtp
 LrynW2szEe2oAFjB6+5ljZo7Y0hJkgf2vJlGTyvMsnUU/ZOCTawPtUkY4oJgF9FLcH
 Y9NNvQm66fLyw==
Message-ID: <180d7078-ac13-4d56-8ef5-2b64f7f41937@denx.de>
Date: Mon, 26 Feb 2024 14:04:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it,
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, festevam@denx.de, andrejs.cainikovs@toradex.com,
 sjg@chromium.org, peng.fan@nxp.com, aford173@gmail.com,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
 <609581c7-d221-4eff-862b-6f172ba9d4e8@denx.de>
 <CAFA6WYPdqsD7Xy1EwX7R_+A3UiskvxaTyvR6D9qP45WhUxxA6A@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYPdqsD7Xy1EwX7R_+A3UiskvxaTyvR6D9qP45WhUxxA6A@mail.gmail.com>
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

On 2/26/24 1:50 PM, Sumit Garg wrote:

[...]

>>> +     ret = reset_get_by_name(dev, "pciephy", &imx8_phy->reset);
>>> +     if (ret) {
>>> +             dev_err(dev, "Failed to get PCIEPHY reset control\n");
>>> +             return ret;
>>> +     }
>>
>> Some clk_put() and co. fail path is missing here.
> 
> Ditto for clk_put() not being available. However, I can add the fail
> path for the other reset.

Oh, maybe reset_free() and clk_release*() then ?
