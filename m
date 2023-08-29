Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88380C6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 16:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990BF86415;
	Tue, 29 Aug 2023 18:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="dl+aa2CC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E8786415; Tue, 29 Aug 2023 18:29:15 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E630D864F1
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 18:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7605ce3122=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37TC1pbn002739; Tue, 29 Aug 2023 18:28:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=VVzjf21Dso9Z3rBfL/k6z0SPmOknPqiL6aHhwu0orSQ=; b=dl
 +aa2CCKNspb08zywDM8wowkLo0ZU9m4gC7hJpK875vJ2nh+qS+fwKIp1dgBvcdjX
 CvMTsHw8Fhng6tPqb+X7Q2njkH0hov6pZ7pnFJ/q1l49EajScgyTVbmXqPIc0eqj
 0IGDXKri+zLEQ+8hE3wwOvcaR7wry4vIhq44LGgcvWN61Vq2psxDvUqi1XH+delc
 4negsJJgvkNo2sSRRy2Z1+e/P3MiEaLZ5GEvE1+/O9jZLSLvEbiOUUk/ADKqABpj
 ovwWihquWdi9Jtxu1DyXWPxDmBRIxcDG6HFDgzAyqVHp6NQXHvGhrJd1iklPcXGt
 vIUehl5CeXQvH0VDtTiw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sq89bw3pn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 18:28:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A679A100057;
 Tue, 29 Aug 2023 18:28:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9E8D820F578;
 Tue, 29 Aug 2023 18:28:52 +0200 (CEST)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 29 Aug
 2023 18:28:51 +0200
Message-ID: <8091c4f9-a0ce-aa69-098f-2effdb68ffdb@foss.st.com>
Date: Tue, 29 Aug 2023 18:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] stm32mp15: Use u-boot-spl-stm32.bin instead of
 u-boot-spl.stm32
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Simon Glass
 <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Dillon Min
 <dillon.minfei@gmail.com>, Kamil Lulko <kamil.lulko@gmail.com>, Patrice
 Chotard <patrice.chotard@foss.st.com>,
 Vikas Manocha <vikas.manocha@st.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230824030304.1555547-1-sjg@chromium.org>
 <20230824030304.1555547-7-sjg@chromium.org>
 <3ab486b0-be22-48b9-7417-742ed8360f0f@denx.de>
 <20230824142505.GM3953269@bill-the-cat>
 <4cbffed6-6a07-1a56-bf10-7303e2aff78b@denx.de>
 <20230824151419.GU3953269@bill-the-cat>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230824151419.GU3953269@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
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

Hi Simon,

On 8/24/23 17:14, Tom Rini wrote:
> On Thu, Aug 24, 2023 at 05:09:07PM +0200, Marek Vasut wrote:
>> On 8/24/23 16:25, Tom Rini wrote:
>>> On Thu, Aug 24, 2023 at 05:12:45AM +0200, Marek Vasut wrote:
>>>> On 8/24/23 05:02, Simon Glass wrote:
>>>>> A '.stm32' extension is not allowed anymore, so change it.
>>>> Why?
>>>>
>>>> This will likely break a huge amount of scripts, I'm tempted to NAK it
>>>> unless there is a very good reason.
>>> This is in the cover letter.  Today, buildman --keep-outputs doesn't
>>> actually keep the needed for booting outputs from a build for a number
>>> of platforms.  Simon's response is to stop having a free-form list of
>>> outputs. With I guess the caveat being ROM-defined names (for example,
>>> we still keep "MLO" because that is the literal filename TI ROM looks
>>> for on FAT partitions, on mos of their 32bit platforms).
>> Why not just place the free-form files into some output/ directory and be
>> done with it ? Then they can have whatever extension they want, as long as
>> the output/ directory name is stable.
> Yes, an alternative here is to just extend the list that's removed in
> patch 2/6.
>

The ".stm32" was choosen on output on mkimage to be aligned with:

- all STMicroelectonics documentation  (for example 
https://wiki.st.com/stm32mpu/wiki/STM32_header_for_binary_files)

- the proposed scripts or files, in particular in the YOCTO generated 
flashlayout files.

- this extension list expected by our tools: STM CubeProgrammer 
(https://wiki.st.com/stm32mpu/wiki/STM32CubeProgrammer)

and Signing tools (https://wiki.st.com/stm32mpu/wiki/Signing_tool)


So I prefer to kept the ".stm32" extension here:

	filename = "u-boot-spl.stm32"


NB: the justification for buildman '-k' option seens not fully relevant here

        because in patch 2/6 you kept not only the ALLOWED extension but 
also some particular files

+                to_copy = ['u-boot*', '*.map', 'MLO', 'SPL',
+                           'include/autoconf.mk', 'spl/u-boot-spl*']
+                to_copy += [f'*{ext}' for ext in ALLOWED_EXTS]


so all the files "u-boot*" are kept with buildman -k even if it is not a 
allowed extension.


I propose to change the patch 1/6 if you are agree

and allow binman to generate the file with same rules than buildman -k 
option in patch 2/6


The filename is valid if

- the file is named with the allowed prefix 'u-boot' => 'u-boot*' so 
"u-boot-spl.stm32" is allowed

- the file is with allowed extension =>.bin, .rom, .itb, .img


Regards


Patrick


