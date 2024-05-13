Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0C5C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 05:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33B4E882B6;
	Mon, 13 May 2024 07:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715576891;
	bh=bNsrapvyoGMvfc7B33fDWGzAfn6gOn59qkO4s5e6k40=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MdpH0SdladUIrAzQFkqnryNo/g8mAjROXd/ebpdLtSusTa4joSKEuD9gQnBXBknbo
	 tPetDW5XWfZGrwOZzoyLmJSGewF7EWdhdKdX25QDv+QErMDjI8yR0p1esbqP1uVffn
	 d665Jjfr7TzLOL2F+v15pCsSPBR37rS/UigJC2rfVfH4qUSEKxS3Yhi8aYO8Vc9oaU
	 qD9iNO0zd/Ac5J5x7YYoI4dG6ulJD4PnF39DP2L6ftUvo1OCA7ak+U6CwIAbB6+h+y
	 JYOLUD2riQ9JogNfKH3sb8V3VEOMbS7KKMhsvaiqpaFO0Tzo5cV7i06CvT3YB4uBk+
	 +jgbscWb/a/hA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DF9DD87E74;
 Mon, 13 May 2024 07:08:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715576890;
 bh=bNsrapvyoGMvfc7B33fDWGzAfn6gOn59qkO4s5e6k40=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oIFZnlFtAyRsTgp4AeikDikzrR27MCJ6sMJoHydUAMCq0H3PF7vn3hVTjjA79mjhN
 Hx/3gNCkIEh8ogBZ/VHSzehU11ZjthXRPPe25N8xtTTAHb+XKsbGQ5BIPRIxOGx9Fu
 t0aOd8kSS0CnroV1CAVUF9Y8ZZSSY//f83q0rfcwvg9MMTyvo2W7erNriffhLmi4U6
 RpOGTjkIXTi39bDO9K9HHOSOakjOIYx0g3Grpu4RAQ6zWqiYcPkz9r9AY03XAPz3Br
 +U5IMK51FbZ0G7gaN20+WW17NMTv+oDhh6opohKhQDaHXOThROd/LScdkn9aMqYWYE
 DdNe9pJGoroOQ==
Message-ID: <7d834245-9ac2-45cf-b5bb-045560863bcb@denx.de>
Date: Mon, 13 May 2024 05:46:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: add documentation about the required keys/certs
To: Claudius Heine <ch@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Fabio Estevam <festevam@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 open list <u-boot@lists.denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20240503010518.263458-1-marex@denx.de>
 <20240507130650.713801-1-ch@denx.de>
 <28173ffa-209b-498f-a2c3-99ec2f898e7c@denx.de>
 <e98dc839-f58f-4463-9358-4d3ba267d558@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <e98dc839-f58f-4463-9358-4d3ba267d558@denx.de>
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

On 5/8/24 9:23 AM, Claudius Heine wrote:
> Hi Marek,

Hi,

> On 2024-05-07 3:28 pm, Marek Vasut wrote:
>> On 5/7/24 3:06 PM, Claudius Heine wrote:
>>> For CST to find the certificates and keys for signing, some keys and
>>> certs need to be copied into the u-boot build directory.
>>
>> Make sure to CC "NXP i.MX U-Boot Team" , else NXP is not informed. Use 
>> scripts/get_maintainer to get the full list or just reuse the CC list 
>> from patches in this thread.
> 
> I send the patch with `--to-cmd scripts/get_maintainer.pl`, maybe I 
> should have used `--cc-cmd`, but that would not change the list of 
> recipients.

Should now be fixed in
[PATCH] ARM: imx: Add doc/imx/ to i.MX MAINTAINERS entry

>>> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt 
>>> b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
>>> index ce1de659d8..42214df21a 100644
>>> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
>>> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
>>> @@ -144,6 +144,22 @@ The signing is activated by wrapping SPL and 
>>> fitImage sections into nxp-imx8mcst
>>>   etype, which is done automatically in 
>>> arch/arm/dts/imx8m{m,n,p,q}-u-boot.dtsi
>>>   in case CONFIG_IMX_HAB Kconfig symbol is enabled.
>>> +Per default the HAB keys and certificates need to be located in the 
>>> build
>>> +directory, this means copying the following files from the HAB keys 
>>> directory
>>> +flat (e.g. removing the `keys` and `cert` subdirectory) into the 
>>> u-boot build
>>> +directory for the CST Code Signing Tool to locate them:
>>
>> Do symlink(s) work too ?
> 
> I have not tested it, but I don't see any reason why it would not. I 
> also don't see a reason for mentioning it. I want to keep it simple, if 
> the dev whats to do things differently, they are free to do so.

"
Per default the HAB keys and certificates need to be located in the 
build directory, this means {+creating a symbolic link or +}copying the 
following...
"

Please test it and add it in V2 if it works, I think symlink is better 
than bluntly copying files around, esp. for crypto material.

>>> +- `crts/SRK_1_2_3_4_table.bin`
>>> +- `crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem`
>>> +- `keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem`
>>> +- `crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem`
>>> +- `keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem`
>>> +- `keys/key_pass.txt`
>>> +
>>> +The paths to the SRK table and the certificates can be modified via 
>>> changes to
>>> +the nxp_imx8mcst device tree node
>>
>> "nodes", plural, there are two, one for SPL and one for fitImage.
> 
> Well, I was thinking here more generally about the node type and was 
> assuming that the person reading this knows how many they have of that 
> type. But I can add a `s` in v2.

Use "node(s)" which covers both options.

>> It would be good to mention the DT properties which govern the crypto 
>> material paths -- nxp,srk-table, nxp,csf-crt, nxp,img-crt -- somewhere 
>> around this sentence.
> 
> This is something that should be documented with the changes where that 
> code was added, IMO. I only documented here what I found out and have 
> used myself, I haven't used those.
> 
> I would be interested in reading how to best overwrite those paths and 
> the image structured from board u-boot.dtsi files myself.
> 
> If you want to can pickup my patch and integrate it into your series and 
> extend it.

I'll keep it in mind for V3.
