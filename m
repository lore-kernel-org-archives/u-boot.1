Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54171C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97580864B4;
	Thu, 24 Aug 2023 15:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692882407;
	bh=rmKvUEju6jpeqEHdnSj/cH8NHHrm4SFQnGKDVicWxYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fsC4J+rsYkmweujiNm9PmgnXnfNqYTNLihym1YFb056Gx3cJixFk8rWDi+WpQ1u3e
	 DvZ34MWgnAgTjl5OXTfIOFN3y3PWuch9xOH7o3KmpDicVP7OaRDVSDE4NdNYmPcyOG
	 q8Vh3Mq3+AjjzTb0LazTFLbRjNZYoVik64lVgGEr9yOH5uDf8s+pcY8Y0Ygy1TaSJ8
	 UFJ/jdmSx7f8fC2sC7T//PFj+oe3AvwqqLVJl0i9zW+20c+JlblfSDUeJJa7kheLPT
	 VNEVRJHlrz1w8PfjAKYEperkb+VUHChDP/LB/dEexYLwjYo0CCC+t0M1CxZt/64iNl
	 QePZ95XlXoIbA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6F42886418;
 Thu, 24 Aug 2023 15:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692882405;
 bh=rmKvUEju6jpeqEHdnSj/cH8NHHrm4SFQnGKDVicWxYY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mpyfBDUV6p/y7LjqobCpbLFy1Gn/ruF55zhlp2oaa7J8VZv7VTb1pJEDoSjzdN/N7
 fky6QcXfr/7yWovUCRByEvNFCZvbLDv55JZIs2AToTNCHXYLLIjRFJ14a87InQPKdP
 /sGoB9e7VJaaZdPFSdH4GAaW3ytLNCzfRxo7BJRTMdOi/bG7dJV8It5MzYde+t4sE+
 JFFaIRUZmaDdhSSZDYsc/EI4aVEk1dYlPqG3g60cgZcgY6vZkPEy3K3c8dIe5wYUoh
 MwTw/DimmLLyBwprW33NbPChTTUa5PVBg3cUM3qkZoUA03zlcMApXlguCLat/MMET3
 SUMJfWx1TNXAA==
Message-ID: <6b9634d5-e87f-9605-c236-49ad9f29a263@denx.de>
Date: Thu, 24 Aug 2023 15:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/1] doc: describe TPL/VPL/SPL boot
Content-Language: en-US
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
 <20230823201400.m4l6hl7zy6x6srzd@pali>
 <c1ed8f80-5752-df54-192d-c1b8c16e4f28@canonical.com>
 <20230823203526.domqjv74ttdwfo73@pali>
 <bbdab138-2499-ad95-d4a8-dfada7e72651@denx.de>
 <20230823205506.oboh4hxdxdi4oalj@pali>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230823205506.oboh4hxdxdi4oalj@pali>
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

On 8/23/23 22:55, Pali Rohár wrote:
> On Wednesday 23 August 2023 22:46:13 Marek Vasut wrote:
>> On 8/23/23 22:35, Pali Rohár wrote:
>>> On Wednesday 23 August 2023 22:32:18 Heinrich Schuchardt wrote:
>>>> Looking at the MAINTAINER file it seems that POWERPC should be set to
>>>> orphaned.
>>>
>>> And this is only just because of your fault folks here, as you have been
>>> completely ignoring any my patches for improving this situation here and
>>> finally after more than year of my reminders more of you wrote me
>>> officially that would ignore any changes from me.
>>> So go and complain to somebody else, not me.
>>
>> Why not pick up the PPC maintainership yourself ? You are qualified enough I
>> think.
> 
> I'm not sure if you cannot read or understand above written text, but I
> will repeat it once again and the last time specially for you: I'm not
> going to send any changes, improvements or fixes to any people anymore
> who either implicitly or explicitly wrote that will ignore me or my
> contributions.

So pick up the PPC maintainership, apply the outstanding patches, send a 
PR to Tom and problem with stuck patches is solved. Why not do it this way?

>> There is a whole thread on frustration about getting patches reviewed and
>> upstream here too:
>>
>> https://lore.kernel.org/all/20230816180808.GB2919664@perftesting/


