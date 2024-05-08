Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6A6C25B74
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 07:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEEC3884D6;
	Wed,  8 May 2024 09:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715153033;
	bh=GkWJidHhx83ItbBI2+7//f+GUUm+7gHzORbkvOHhPPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DUXWRdRYLl7tU3ajzFSRaMveG67clQ0IzDA1bffkLvO6uloeXrdWrUMxvw6ZmxJEu
	 7Pacekp3xt3lrxEv25WxpD3TJIee7+PC/ftO1R9SP8nQhoKN6ykgMz7CWo4omkQp1K
	 sz6OZ/hsZbvLJVV2WfIbZNA3hPjAm5wylme0pE0Mjdy9oUZNa9H4Hv1MGG1MrMB4Q3
	 kCU9pLwN4bXsqWzJfvF+tv9F+53a3vmW5RHjAPtNlX3OMf554OgxFWUkJDapik49AJ
	 HaT/9gAWgOQE2JzVvmZjG0OsgZQrC5GRK1E+smOP8GQq5Glr3jtKV5uOYqY1H/Si7I
	 DP6ddGQo2aYVg==
Received: from [10.88.0.65] (dslb-088-077-007-084.088.077.pools.vodafone-ip.de
 [88.77.7.84])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: ch@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8AC8F8845B;
 Wed,  8 May 2024 09:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715153032;
 bh=GkWJidHhx83ItbBI2+7//f+GUUm+7gHzORbkvOHhPPI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nhV4nJ4nvmmDCONo0Fyc1g+EFNU/4sewBZDpbXHpCXAldEWv+fTpYtBLqDCkGWAt5
 +NbIzGQCnaaIYPFFwPBswKIMVBA0FgLBnbBePUDxcEA811UncsP+awWOUJbVFGa/Qr
 yxS8JvgLN7SatJTgdh63oghEc4o63D3QuD/y1P6CFobOihm3pDQuGFSc37ltqd6+SI
 NtZprFamlpqtHxqMeZloW0p3a5WzlLoRaoxMkVuH6mA2zBWG6/u0JQ3bEVsWOXCo9m
 70lFAw399ljuG00si4bTYLhJzX5Bbt/w7Mg68PfAQv72wGeRF1bfLJ4BvylBge6enH
 BNk/YJanlWcmA==
Message-ID: <e98dc839-f58f-4463-9358-4d3ba267d558@denx.de>
Date: Wed, 8 May 2024 09:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: add documentation about the required keys/certs
To: Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Fabio Estevam <festevam@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 open list <u-boot@lists.denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20240503010518.263458-1-marex@denx.de>
 <20240507130650.713801-1-ch@denx.de>
 <28173ffa-209b-498f-a2c3-99ec2f898e7c@denx.de>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <28173ffa-209b-498f-a2c3-99ec2f898e7c@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Marek,

On 2024-05-07 3:28 pm, Marek Vasut wrote:
> On 5/7/24 3:06 PM, Claudius Heine wrote:
>> For CST to find the certificates and keys for signing, some keys and
>> certs need to be copied into the u-boot build directory.
> 
> Make sure to CC "NXP i.MX U-Boot Team" , else NXP is not informed. Use 
> scripts/get_maintainer to get the full list or just reuse the CC list 
> from patches in this thread.

I send the patch with `--to-cmd scripts/get_maintainer.pl`, maybe I 
should have used `--cc-cmd`, but that would not change the list of 
recipients.

> 
>> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt 
>> b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
>> index ce1de659d8..42214df21a 100644
>> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
>> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
>> @@ -144,6 +144,22 @@ The signing is activated by wrapping SPL and 
>> fitImage sections into nxp-imx8mcst
>>   etype, which is done automatically in 
>> arch/arm/dts/imx8m{m,n,p,q}-u-boot.dtsi
>>   in case CONFIG_IMX_HAB Kconfig symbol is enabled.
>> +Per default the HAB keys and certificates need to be located in the 
>> build
>> +directory, this means copying the following files from the HAB keys 
>> directory
>> +flat (e.g. removing the `keys` and `cert` subdirectory) into the 
>> u-boot build
>> +directory for the CST Code Signing Tool to locate them:
> 
> Do symlink(s) work too ?

I have not tested it, but I don't see any reason why it would not. I 
also don't see a reason for mentioning it. I want to keep it simple, if 
the dev whats to do things differently, they are free to do so.

> 
>> +- `crts/SRK_1_2_3_4_table.bin`
>> +- `crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem`
>> +- `keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem`
>> +- `crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem`
>> +- `keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem`
>> +- `keys/key_pass.txt`
>> +
>> +The paths to the SRK table and the certificates can be modified via 
>> changes to
>> +the nxp_imx8mcst device tree node
> 
> "nodes", plural, there are two, one for SPL and one for fitImage.

Well, I was thinking here more generally about the node type and was 
assuming that the person reading this knows how many they have of that 
type. But I can add a `s` in v2.

> 
> It would be good to mention the DT properties which govern the crypto 
> material paths -- nxp,srk-table, nxp,csf-crt, nxp,img-crt -- somewhere 
> around this sentence.

This is something that should be documented with the changes where that 
code was added, IMO. I only documented here what I found out and have 
used myself, I haven't used those.

I would be interested in reading how to best overwrite those paths and 
the image structured from board u-boot.dtsi files myself.

If you want to can pickup my patch and integrate it into your series and 
extend it.

regards,
Claudius

-- 
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de
