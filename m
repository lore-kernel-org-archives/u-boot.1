Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02693C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 22:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F264487727;
	Sun, 21 Jan 2024 23:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vqAvf8OC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB51987708; Sun, 21 Jan 2024 23:41:56 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68A3087727
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 23:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-337b8da1f49so2364473f8f.0
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 14:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705876913; x=1706481713; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JfPGc8XpEyojDhfAz4mBWFKXdiGaTdTqAoIaSywC5BY=;
 b=vqAvf8OCHT2xApdZLGG5IEvt8Ljerft+oJAkeH4y2HikMOqI2rUXpDMTHOOQre37Ua
 Y5w9c4Dq/HzF64ZFT0I3Ss3dQ1syc8Ek1Z/ApspSfU9ena4+1pw3Md1zp41gzVHXBjIt
 v++CmirYOzco4tcKvUlssPsz5UexlWuTgILjYkCDoBilE7hO7+yg9TqSosCTiA8ugpJb
 L5rAa92ax+zI9A4sZM3eihhyP8cIOjp34to8KZ3yS/MCTqUzcEJ+pNJUR87EBAggBhNl
 a8Q6VnStlyixkqtRovnK8EpkSRhrzQlSM9AqdxEGGahdj495/t0bxbQqWdxubeMxUGnb
 ZaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705876913; x=1706481713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JfPGc8XpEyojDhfAz4mBWFKXdiGaTdTqAoIaSywC5BY=;
 b=aotTaP/hBygiIP7FWCLre/pr2/p5J6q3Ws7HOMkShqNTY4mP3bczvXXXZy0efiXclM
 dXPyr26gZNI0yi3j28erkBF7EJRhKI3EOumYHXKzXiQXIV2sYy/iXRZ5PIGtUNXGvAYI
 CZbvYlgaYjxil+bjAzZXGMHnkeJNqW2CQa8k+GCReNcrHSD3/780Em1uMCb4F2Dw7pcr
 Do03GH4TuooXmW9FcYQErxnDmj3eDZRaV7O4uoLNjKPHcX0E6cB9MRf21Ef+i8aPqLkC
 Vv7579H4m44rUWgZINvSry7FSk31IWDQF0c8yzFl9o3yMIeI3DJcnpLPX7rFQYCVFlYf
 xfeA==
X-Gm-Message-State: AOJu0YxhhNEv4HqzNC6UvdoZnYnwWxpyL4xoKy6fpH6bW/VSSw567o4T
 jDMGbmOWXoedeg1euXow3wmu/lbTUNG9Ty17/ZKc4ePuYb3GJE31yikkhyLJhDg=
X-Google-Smtp-Source: AGHT+IF6/QNAGe2STqa+mqW6uwtjIdWYyinrMwf1MVvuyjnfhmIXSaHOSIf9sHR7nT8HUCRPrXxrJg==
X-Received: by 2002:a5d:4605:0:b0:337:c73f:db07 with SMTP id
 t5-20020a5d4605000000b00337c73fdb07mr1411798wrq.136.1705876912767; 
 Sun, 21 Jan 2024 14:41:52 -0800 (PST)
Received: from [192.168.1.17] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d5909000000b0033936c34713sm1278295wrd.78.2024.01.21.14.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jan 2024 14:41:52 -0800 (PST)
Message-ID: <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
Date: Sun, 21 Jan 2024 22:41:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
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



On 21/01/2024 15:33, Marek Vasut wrote:
> On 1/10/24 11:35, Sumit Garg wrote:
>> Changes in v4:
>> --------------
>> - Switched subtree to be imported as dts/upstream sub-directory rather
>>    than devicetree-rebasing sub-directory to better suite U-Boot
>>    directory structure.
>> - Since we now have v6.7-dts tag available now, so switch subtree to
>>    that from its beginning.
>> - Patch #2: Incorporate build fix to adjust Bindings Makefile rules to
>>    old U-Boot Kbuild infrastructure.
>> - Patch #3: Incorporate fix to resolve rk3399 migration issue reported
>>    by Simon.
>> - Patch #4: New patch to reuse upstream DT includes by U-Boot as per
>>    Brian's use-case for TI K3 SoCs.
>> - Patch #5: Added a note to OF_UPSTREAM Kconfig option.
>> - Patch #6: New patch to add script dts/update-dts-subtree.sh as per
>>    Rob's comments.
>> - Patch #7: Separate patch to align documentation to use Kconfig symbols
>>    instead.
>> - Patch #8: Clarify subtree uprev schedule as a separate documentation
>>    section. Also, fixed documentation typos.
>> - Patch #9: Added commit description.
>>
>> Changes in v3:
>> --------------
>> - Patch #4: Minor commit message update
>> - Patch #5: Replace CONFIG_* with Kconfig options
>> - Patch #7: Dropped Makefile portion and enabled OF_UPSTREAM for SoC
>>    instead.
>> - Patch #1, #3, #6 and #8: Picked up review tags
>>
>> Changes in v2:
>> --------------
>> - Patch #1: excluded gitab CI config check and added commit description.
>> - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
>> - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
>> - Patch #5: s/U-boot/U-Boot/
>> - Patch #6 and #7: Picked up review tags
>>
>> Prerequisite
>> ------------
>>
>> This patch series requires devicetree-rebasing git repo to be added as a
>> subtree to the main U-Boot repo via:
>>
>> $ git subtree add --prefix dts/upstream \
>>        
>> git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>>        v6.7-dts --squash
>>
>> Background
>> ----------
>>
>> This effort started while I was reviewing patch series corresponding to
>> Qcom platforms [1] which was about to import modified devicetree source
>> files from Linux kernel. I suppose keeping devicetree files sync with
>> Linux kernel without any DT bindings schema validation has been a pain
>> for U-Boot SoC/platform maintainers. There has been past discussions
>> about a single DT repo but that hasn't come up and Linux kernel remained
>> the place where DT source files as well as bindings are placed and
>> maintained.
>>
>> However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
>> use devicetree-rebasing repo [3] which is a forked copy from Linux
>> kernel for DT source files as well as bindings. It is tagged at every
>> Linux kernel major release or intermideate release candidates. So here I
>> have tried to reuse that to bring DT bingings compliance as well as a
>> standard way to maintain a regular sync of DT source files with Linux
>> kernel.
>>
>> In order to maintain devicetree files sync, U-Boot will maintains a Git
>> subtree for devicetee-rebasing repo as `dts/upstream` sub-directory.
>> U-Boot will regularly sync `dts/upstream/` subtree whenever the next 
>> window
>> opens with the next available kernel major release.
>> `dts/update-dts-subtree.sh` script provides a wrapper around git subtree
>> pull command, usage from the top level U-Boot source tree, run:
>>
>> $ ./dts/update-dts-subtree.sh <devicetree-rebasing-release-tag>
>>
>> The RFC/prototype for this series has been discussed with Linux DT
>> maintainers as well as U-Boot maintainers here [4]. Now we would like to
>> reach out to wider U-Boot community to seek feedback.
> 
> I very much agree with the direction this is going in, but I do have two 
> simple questions:
> 
> How do you propose to handle fixes to DTs which are applied to 
> linux-stable releases ? For example, if Linux 6.6(.0) ships a DT which 
> has some defect that is fixed in 6.6.1, how will that fix get into 
> U-Boot DTs ?

This fix would also be in the latest Linux tags, so I think it would 
find its way here - as I understand it patches aren't accepted into 
Linux stable unless they land in torvalds tree.
> 
> Assume that there is some large breaking change in Linux 6.(n+1), 
> something which would be problematic for specific U-Boot platform (e.g. 
> i.MX) or would require a lot of work to sort out, will there be a way to 
> temporarily pin DTs for specific platform to older DT version until that 
> is resolved (e.g. pin to 6.n) ?

(Upstream) devicetree has to be forwards and backwards compatible, were 
such a breaking change to get merged without prior discussion with DT 
users (i.e. U-Boot) then I think the correct course of action would be 
to revert it.

On a tangential note: as I understand it, DTs built from dt-rebasing are 
still subject to U-Boot customisations via the "-u-boot.dtsi" include 
files, this allows for dealing with incompatibilities due to missing 
features in U-Boot.

-- 
// Caleb (they/them)
