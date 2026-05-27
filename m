Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2650CD6E41
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 08:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D31CF8341A;
	Wed, 27 May 2026 10:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="l7Xi3FYQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LTFNhAu7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 090F4839A8; Wed, 27 May 2026 10:46:29 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E978056B
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 10:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gQNWk3r4Vz9tJC;
 Wed, 27 May 2026 10:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779871586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7o9RUlSfQSD/X+6i+AvIu7NMnLWJF7QvRN63mUs08wQ=;
 b=l7Xi3FYQcgUeKztSQDZlroAMC8O12KrlrkG9p/VhcNXBuX4dftyNaZRo1EU9zPa11DnAzF
 7JNkTs6EXdVge17Q6TdsK2fknDEU+RuffsGy2bl2KtN/YitlPZGaBuK0yeyfDroq1sOeYm
 OOvTC367ZcoU9I+Yr21ToAmV/GuIz+6fVovAWjOWcaRgrP+NaSda4fABJcKjQLClhGHZqJ
 4IgbpTtD6Xl24V8eTsP+qLJp7SepjtqokUjvv1scHcD9vddkOKIfWW4M6g1M4G7qcmSvpB
 JnrNivlpm/45sIS9WOVky2Ap/2Y8dBz5FrzdDKvjIvnVm8KCOhjzK7cUeQl6Lw==
Message-ID: <47a4bf11-8999-4334-ab30-fb37575552ae@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779871584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7o9RUlSfQSD/X+6i+AvIu7NMnLWJF7QvRN63mUs08wQ=;
 b=LTFNhAu7y+IChkHE0iRCuXGa8D/UPahf9iSVh7sT0xp55uLRFKGi9gI+MtvkThccudYEjX
 BOE4AfJuhXiRSAmlE5Vs012nZDMrDP7UF8uFaVMNIttplQvt90Hav1luWxVBtPTZ51q5fz
 iy6UShZEMn1QMNQqL+fHXlYx+NtANML7qBrOLLammAoYNzjiFdMpTiLMUWlJ3H2TnaqRQk
 q12AzgYdJoq7biXYVpQyaOGfFGAjGTTY8b7ljPlVS00QjXQVqUwIIiD9ohIJ3+omh9cq+K
 oXtS6EbguCK1blTmOFqZ8p2qZCHYN4TAJ36KIlk5c5jla5TYg1cAm2OswkcUbA==
Date: Wed, 27 May 2026 10:46:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] pci: dw_mvebu: Use dev_read_addr_x APIs
To: Neil Armstrong <neil.armstrong@linaro.org>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
 <20260526-devfdt-pci-v1-3-ed7f31d73938@nxp.com>
 <135fb709-8272-4606-b017-6f86615ee400@linaro.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <135fb709-8272-4606-b017-6f86615ee400@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: miax114rcburw8otfby74hsh537uhuyx
X-MBO-RS-ID: 467896f64ea3ccb3c72
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

On 5/26/26 09:01, Neil Armstrong wrote:
> On 5/26/26 10:09, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Use dev_read_addr_x APIs which support both live device tree and flat DT
>> backends, avoiding direct dependency on devfdt_* helpers.
>>
>> No functional changes.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/pci/pcie_dw_mvebu.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pcie_dw_mvebu.c b/drivers/pci/pcie_dw_mvebu.c
>> index 43b919175c9..5a177478afc 100644
>> --- a/drivers/pci/pcie_dw_mvebu.c
>> +++ b/drivers/pci/pcie_dw_mvebu.c
>> @@ -565,13 +565,12 @@ static int pcie_dw_mvebu_of_to_plat(struct 
>> udevice *dev)
>>       struct pcie_dw_mvebu *pcie = dev_get_priv(dev);
>>       /* Get the controller base address */
>> -    pcie->ctrl_base = devfdt_get_addr_index_ptr(dev, 0);
>> +    pcie->ctrl_base = dev_read_addr_index_ptr(dev, 0);
>>       if (!pcie->ctrl_base)
>>           return -EINVAL;
>>       /* Get the config space base address and size */
>> -    pcie->cfg_base = devfdt_get_addr_size_index_ptr(dev, 1,
>> -                            &pcie->cfg_size);
>> +    pcie->cfg_base = dev_read_addr_size_index_ptr(dev, 1, &pcie- 
>> >cfg_size);
>>       if (!pcie->cfg_base)
>>           return -EINVAL;
>>
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

