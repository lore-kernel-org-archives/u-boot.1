Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2D5C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 08:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D7AC881CA;
	Thu, 16 May 2024 10:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715847932;
	bh=MHzFPSN945IkHNk4R6Dq9XEFLVM1gVcLeHaMkljE/e8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s4c4LwjkeQTgmi+N8pLHpsMexc8aNw9XS/RNW+JSFzQfocVLRxOmE1df0hOkdzc+N
	 4EhmJaCgH6BJp0waRQcTBO7R/tWP179/nIq/ej4hQqr7bcqXpCXq+xro68qLX1MdRB
	 rtOxEqUZ6Trb9sGlbk0nVTlNxGjH2MpWZK+udtoq9HDuLLuqcDpGAuYpq8MsNGFfcS
	 DUDUKxbkkFCKUgN6CUa6i2sOjEeeO0uFQOq+kxRy1hFY8Nkzo2MlxqpsvtMQlx/71X
	 GCDnnDFbIXewjTqv8PpmUbVPw4kUmQn9HLjeLQqvhJvfZlt9KSYR7YReQ6+kZJXnKt
	 TFJfakB19pGbA==
Received: from [10.88.0.65] (dslb-088-077-007-084.088.077.pools.vodafone-ip.de
 [88.77.7.84])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: ch@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CA2608812B;
 Thu, 16 May 2024 10:25:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715847931;
 bh=MHzFPSN945IkHNk4R6Dq9XEFLVM1gVcLeHaMkljE/e8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uKZlK6yoREjs+kbY6hhjuOlx3xIoL+q3+ZoriMsV5Ad8VkWCIP4mvuSr+TBLOcTyG
 s2bKfm1gJNG5rIdwt9aeXAdOMBgqO/nv8u5bsyF5ROT3FFdDwlShYqukmHuhGaM0MP
 4seuCkfyKAEGDGBEnsPGul8qulNSrNpsSyjyBQCY7x9d4hjbBSlL+DQTGc7IDtuzOU
 Dm78bxpUluqR6un7k9MS2tn1YoLvNWRONO4ksEIfqd9u9uyIn76wwumKKzgyt3Pzs5
 iFecLdt2vANFa7T9+czWN264a4CnSlXZCVHfG0yGDHjCDhDJWEDsoNmF0UaE4bSOht
 BgvXiVlZ183zA==
Message-ID: <ac57d92f-5f75-47fe-b2d5-5f633290b030@denx.de>
Date: Thu, 16 May 2024 10:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: add documentation about the required keys/certs
To: Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@denx.de>,
 open list <u-boot@lists.denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20240503010518.263458-1-marex@denx.de>
 <20240507130650.713801-1-ch@denx.de>
 <28173ffa-209b-498f-a2c3-99ec2f898e7c@denx.de>
 <e98dc839-f58f-4463-9358-4d3ba267d558@denx.de>
 <7d834245-9ac2-45cf-b5bb-045560863bcb@denx.de>
 <CAJ+vNU2MCQNDO1hehq3CvWAFUqaSR=0eW6xRrE8Dzcna79-doA@mail.gmail.com>
 <CAJ+vNU1NJOXELwyUJ_QW4m-QTdJZwSA9R8v3-1wzJK9K8PxEZw@mail.gmail.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <CAJ+vNU1NJOXELwyUJ_QW4m-QTdJZwSA9R8v3-1wzJK9K8PxEZw@mail.gmail.com>
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

Hi Tim and Marek,

On 2024-05-16 12:46 am, Tim Harvey wrote:
> On Tue, May 14, 2024 at 11:50 AM Tim Harvey <tharvey@gateworks.com> wrote:
>> On Sun, May 12, 2024 at 10:08 PM Marek Vasut <marex@denx.de> wrote:
>>> On 5/8/24 9:23 AM, Claudius Heine wrote:
>>>> On 2024-05-07 3:28 pm, Marek Vasut wrote:
>>>>> It would be good to mention the DT properties which govern the crypto
>>>>> material paths -- nxp,srk-table, nxp,csf-crt, nxp,img-crt -- somewhere
>>>>> around this sentence.
>>>>
>>>> This is something that should be documented with the changes where that
>>>> code was added, IMO. I only documented here what I found out and have
>>>> used myself, I haven't used those.
>>>>
>>>> I would be interested in reading how to best overwrite those paths and
>>>> the image structured from board u-boot.dtsi files myself.
>>>>
>>>> If you want to can pickup my patch and integrate it into your series and
>>>> extend it.
>>>
>>> I'll keep it in mind for V3.
> 
> Hi Marek,
> 
> The documentation patch here by Claudius does resolve my issues
> discussed in the other thread and I can confirm symlinks work fine so
> I think something like the following should be added:
> 
> CST_DIR=/usr/src/cst-3.3.2/
> ln -s $CST_DIR/crts .
> ln -s $CST_DIR/keys .

`keys` and `crts` are very short and generic names, and putting them 
into the build directory might cause issues at some point. But I would 
not be against putting them into a sub directory (`imx-hab/{keys,crts}`?).

> 
> then with the following change to nxp_imx8mcst.py you can build a
> signed image without code modification:
> diff --git a/tools/binman/etype/nxp_imx8mcst.py
> b/tools/binman/etype/nxp_imx8mcst.py
> index 132127ad4827..7d8abc78fc89 100644
> --- a/tools/binman/etype/nxp_imx8mcst.py
> +++ b/tools/binman/etype/nxp_imx8mcst.py
> @@ -68,9 +68,9 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>       def ReadNode(self):
>           super().ReadNode()
>           self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
> -        self.srk_table = fdt_util.GetString(self._node,
> 'nxp,srk-table', 'SRK_1_2_3_4_table.bin')
> -        self.csf_crt = fdt_util.GetString(self._node, 'nxp,csf-crt',
> 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem')
> -        self.img_crt = fdt_util.GetString(self._node, 'nxp,img-crt',
> 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem')
> +        self.srk_table = fdt_util.GetString(self._node,
> 'nxp,srk-table', 'crts/SRK_1_2_3_4_table.bin')
> +        self.csf_crt = fdt_util.GetString(self._node, 'nxp,csf-crt',
> 'crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem')
> +        self.img_crt = fdt_util.GetString(self._node, 'nxp,img-crt',
> 'crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem')
>           self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
>           self.ReadEntries()
> 
> If copying or symlinking the keys/certs directory is not desired are
> env vars exposed to binman's python classes? If so you can just
> require CST_DIR to be specified and use that for the paths?

I personally would prefer using (one) environment variable(s) to specify 
the path to all keys, that way whatever `cst` needs, it will find it 
there, and explicit symlinking/copying can be avoided.

I would probably rather call it `HAB_DIR`/`HAB_BASE_DIR` or something, 
because it doesn't need to be pointing to the whole `cst` stuff just a 
directory for the keys and certs for the HAB. `CST_DIR` might leave the 
impression that the `cst` from that directory is used.

And you can still allow environment variables like (`SRK_TABLE`, 
`CSF_KEY` and `IMG_KEY`) to overwrite the name of each, relative to the 
`HAB_DIR/{keys,certs}` if a `HAB_DIR` is set.

This would be somewhat backwards compatible and allows simpler usage by 
setting just one variable (`HAB_DIR`) and leaving the rest to the dtb.

kind regards,
Claudius

-- 
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de
