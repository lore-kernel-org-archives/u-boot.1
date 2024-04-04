Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81369CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 09:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCEB8883F2;
	Thu,  4 Apr 2024 11:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fLmTwEp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3201883F8; Thu,  4 Apr 2024 11:11:14 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB09883EF
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4349Awav128608;
 Thu, 4 Apr 2024 04:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712221858;
 bh=a3O8ge1rWGPrbvvqoFXP3riInq+Wc85XkCGZBmnTGq8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=fLmTwEp0Q/u2vGvcC2a2tORxvuNrAXL1iOnEM5ybhh5/YoC8UIomM0tXurootn6rC
 xgL0XorCWYwmFdgwIF5/zjTfX+M+vb46oWoV1mPmfOBqXeGIxw6jiOOYm5pX9TvOE9
 EyIysWwdVKqZ2VwwuQPqmlyos8/JsdnV7LgeB2QE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4349AwYG036200
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 04:10:58 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 04:10:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 04:10:58 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4349AqHX074983;
 Thu, 4 Apr 2024 04:10:53 -0500
Message-ID: <f4059b33-e36c-41d0-8205-9f8b1b665843@ti.com>
Date: Thu, 4 Apr 2024 14:40:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Michael Walle
 <mwalle@kernel.org>, Manorit Chawdhry <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>, <michal.simek@amd.com>, <marex@denx.de>,
 <neil.armstrong@linaro.org>, <afd@ti.com>, <vigneshr@ti.com>,
 <kamlesh@ti.com>, <u-kumar1@ti.com>
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
 <D03Q9AGO5ND9.1TJM3KSNA71WG@kernel.org>
 <83c6532a-e994-4bcd-bc48-9e22ecdec644@ti.com>
 <D04LUAJJ6LC7.1JVGVTJ0UCMVR@kernel.org>
 <062f7c42-7088-4813-a2d6-ecb7ab22b4ba@ti.com>
 <D05D4N00QDKO.2PJ7VW4BNGQ11@kernel.org>
 <2e817727-524e-47e5-9f5e-2ee13d99a9bb@ti.com>
 <20240403103458.mn2xkemiyymidipo@uda0497581>
 <D0ALVJNAVD8U.3UYSZULLZ6YG5@kernel.org>
 <d23bdaec46343155c752fcfb5287d9b39ac44918.camel@ew.tq-group.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <d23bdaec46343155c752fcfb5287d9b39ac44918.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Matthias

On 04/04/24 13:34, Matthias Schiffer wrote:
> On Wed, 2024-04-03 at 17:51 +0200, Michael Walle wrote:
>> Hi,
>>
>>>>>>> And on top of that, it will just be a base board and there will
>>>>>>> likely be some carrier device trees (overlay? I'm not sure yet).
>>>>>>>
>>>>>>> As far as I can tell, you've put the memory configuration into the
>>>>>>> device tree, so I'll probably need to switch between them somehow.
>>>>>>
>>>>>> The "k3-<soc>-ddr.dtsi" file will be present in your k3-<board>r5.dts
>>>>>> which makes sense, the memory configuration depends on the board.
>>>>>
>>>>
>>>> k3-<board>-ddr.dtsi* (e.g J721E EVM vs. SK boards consume different memory
>>>> configurations.
>>
>> Right.
>>
>>>>> And one board might have multiple configuration depending on the
>>>>> variant of the board. Typically, one board is available with
>>>>> different memory options. i.e. 1GiB, 4GiB and so on. The actual RAM
>>>>> chips can come from different manufacturers. So all all, I presume
>>>>> there will be different RAM settings, i.e. different
>>>>> k3-<soc>-ddr.dtsi. But I have to switch between the setting during
>>>>> runtime because there will be only one boot image for that board.
>>>>
>>>> This is a runtime dynamic DDR configuration support you are describing
>>>> correct? This means you would be including all the supported memory option
>>>> DTSIs in your k3-<board>-r5.dts correct and probably do some board magic
>>>> code in the SPL DDR driver to choose the DTB. How is this affecting the
>>>> packing of the final bootloader which will anyways pack the whole R5 DTB?
>>
>> Correct, the DDR configuration should be chosen at runtime after
>> reading some board strappings. Unless, it will work with with the
>> same configuration which seems unlikely to me. But it is not an
>> unusual configuration I'd say.
>>
>> I haven't looked into this in detail, but to me it seems not that
>> obvious how to do that in a generic/upstreamable way. Multiple
>> device nodes sounds wrong. Thus, I'd likely need different device
>> trees for the different memory configurations for the R5 SPL. Not
>> sure that is yet possible with u-boot, though. If you have any
>> better idea, I'm all ears.
>>
>>>>>>> Also, regarding the board variants, I'll probably need to choose
>>>>>>> between multiple device trees. That is invisible to the user,
>>>>>>> because u-boot will choose the correct DTB according a board
>>>>>>> strapping, which btw. works really fine, see for example
>>>>>>> (boards/kontron/sl28/spl.c:board_fit_config_name_match).
>>>>>>
>>>>>> Again, this is assuming that there is some HW blown register available
>>>>>> for the board to use (or in our earlier K3 case, the EEPROM) but that is
>>>>>> not necessarily true every time.
>>>>>
>>>>> No, that is of course board dependent. It is just an example that
>>>>> there are boards with more than one DTB.
>>>>>
>>>>> Let's step back a bit. Right now, there is
>>>>>     k3-<soc>-<board>-binman.dtsi
>>>>> which is fine. But it seems, that TI is heading towards a common
>>>>>     k3-<soc>-binman.dtsi
>>>>> which is intended to be used by all the boards that are using that
>>>>> particular SoC, correct me if I'm wrong here. Now the problem with
>>>>> that is that you hardcode the FIT configuations which are really
>>>>> board dependent and assume that there will be exactly one DTB per
>>>>> board, i.e. your "#define SPL_BOARD_DTB" etc.
>>>>>
>>>>
>>>> Correct, but as I mentioned in the earlier message, if your board supports
>>>> more than 1 FIT configuration, you can easily extend the image and add more
>>>> configurations.
>>>>
>>>>> Thus, what I was trying to say is that you should split all the
>>>>> board independent configuration (dt fragments) from the board
>>>>> specific configuration.
>>>>>
>>>>> And again, of course I could just ignore the k3-<soc>-binman.dtsi
>>>>> and just use a suitable copy "k3-<soc>-<myboard>-binman.dtsi" for my
>>>>> board. But as I said, I'm not sure, this is the way to go and I have
>>>>> a slight feeling I will be asked to reuse the "k3-<soc>-binman.dtsi"
>>>>> when I submit my board support.
>>>>>
>>>>>>>
>>>>>>> I don't think it makes much sense to hardcode your generic
>>>>>>> *-binman.dtsi to just one FIT configuration. I'd rather see a split
>>>>>>> between generic things which are shared across all boards and board
>>>>>>> specifics, like the FIT configuration. I mean I could just copy all
>>>>>>
>>>>>> Correct me if I'm wrong, but my understanding is that you would want to
>>>>>> add more FDT blobs in the *-binman.dtsi correct? That is still possible,
>>>>>> adding another "fdt-1" and "conf-1" in the
>>>>>>
>>>>>> Something like this in your <board>-u-boot.dtsi,
>>>>>>
>>>>>> tispl {
>>>>>> 	insert-template = <&ti_spl>;
>>>>>> 	fit {
>>>>>> 		images {
>>>>>> 			fdt-1 {
>>>>>> 				...
>>>>>> 			};
>>>>>> 		};
>>>>>> 		configurations {
>>>>>> 			conf-1 {
>>>>>> 				...
>>>>>> 			};
>>>>>> 		};
>>>>>> 	};
>>>>>> };
>>>>>
>>>>> Then you have the information at two places. One being the "#define
>>>>> SPL_BOARD_DTB" stuff and the other one being in this additional DT
>>>>> fragment. That is really confusing.
>>>>>
>>>>
>>>> Hm... maybe. I personally don't see it as confusing. Even when picking
>>>> between multiple DTBs, you will have a default DTB in any case, marking that
>>>> as a macro wouldn't be confusing right? We'll need to get a third opinion on
>>>> here then, I had seen your ping on IRC [1], putting it here for the others
>>>> as well.
>>>>
>>>
>>> As I see it, it's not like we are making the fdt-0 non overridable, you
>>> can still override it in your configs to make it cleaner if you want for
>>> your board template, I don't think that -
>>
>> Though it is not overriding but rather merging, correct? So one
>> would need to first erase the node just to create it again. Which
>> looks more like a workaround.
>>
>>> tispl {
>>>   	insert-template = <&ti_spl>;
>>>   	fit {
>>>   		images {
>>>   			fdt-0 {
>>> 				...
>>> 			};
>>>   			fdt-1 {
>>>   				...
>>>   			};
>>>   		};
>>>   		configurations {
>>> 			conf-0 {
>>> 				...
>>> 			};
>>>   			conf-1 {
>>>   				...
>>>   			};
>>>   		};
>>>   	};
>>> };
>>
>>>
>>> is not doable. It might be a bit duplicate but if I think about it but
>>> we are not losing out on extending the templates for multiple DTBs even
>>> with this design. I know it might not be what you want but I feel that
>>> for single DTB it's really convenient with the macro stuff and we don't
>>> have to override any of the other binman nodes.
>>
>> I've raised my concern about stuffing board dependent stuff into the
>> now generic "k3-<soc>-binman.dtsi". I get it that it will work for
>> 90% of the boards and that it is very convenient. I'd have rather
>> seen a split of lets say
>>    k3-<soc>-binman.dtsi
>> and
>>    k3-one-dtb-template-binman.dtsi
>>
>> All the generic stuff goes into k3-soc-binman.dtsi whereas 90% of
>> the boards might still use the second dtsi with some define magic.
>> But it seems you've already made your mind up on that :)
>>
>> -michael
>>
> 
> My hope would be that we can get rid of board-specific binman configuration in the common case
> altogether for the K3 SoC families, using @fdt-SEQ etc. generator sections that will just include
> all FDTs configured in Kconfig.
> 
> A while ago [1], this was blocked on ti-secure signing not working with generator sections, and
> according to my experiments, this is still the case in U-Boot 2024.01 (and looking at the Git log,
> also 2024.04/master/next). Are there still plans to make this work? Are there any other blockers?
> 
> Best regards,
> Matthias
> 
> 
> [1] https://lists.denx.de/pipermail/u-boot/2023-July/525095.html
> 
> 

Yeah! This was a series that I pushed away to the side when runtime multi-DTB 
selection was removed. You're right, this seems like the only way we can come to 
a common ground.

Let me see if I can bring it back up again, the last blocker was signing not 
working with the generator as you mentioned.

But again in the interest of time... this would mean this cleaning up effort be 
kept on hold. If we can agree to move to using the generator later as the final 
solution, can we pick up this series for now?

>>
>>   
> 

-- 
Thanking You
Neha Malcom Francis
