Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA3607C082
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z14LpGWL;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Mt+IdHp5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F35DC40952;
	Wed,  4 Nov 2026 21:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SNTt7xtfEyYR; Wed,  4 Nov 2026 21:08:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB7D74093C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793826491;
	b=Rb8GkvTAMlf3w4X79QisQWtPACTE0u0GCoDgvXuWNr+MfhzeuW6/GoOnz/8CmuQIg+Rf
	 wMUUPZFiub6r1Ip5MM5uSANaWAkUVEi76OenjL2AP1PggfssBbVH8J4p9eFLm5efLxHGa
	 o/LlYjle33sOGU+v3kgZNQ3djJesNsH/s28h9byVMW2wz1eE9g17Oq+TjLOQWMioF23UR
	 hQL78+LJTuyGGVCQ51n2HvPsS4GV8qmkLewJovEvECu2HRLf4Jpzoo+OQRGpGfUUwrvtu
	 8GrIw8W5o3BMG7q0cXqnPmD/mxM9s2IQiLXrQsCmjKUAhY3C7nvnRFvRyvrz2s0vaeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793826491;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bdkrGnLaovWLx+X6PjJA6V3ADdHONcBhYUJg0pieers=;
	b=Gv1xhtn19HQ8kIKsn9n5JozwMy3/2eAXUcVZGew/dFThqPhZotxAcPQLEJlX10wGq/yb
	 D3l6te+qwzAZkHD0tckbCXajVilxPLP1ramZMlE59JJYJ9hQHtRjXX+MohBnHM14Vujzb
	 QCMXq/AEA/es3EEWpp2UHEmtkWzPUTP3p8PrX0xlf2yQytHMM/o3EZVn947HQieonigaF
	 3vP4n1y4lDpKATcJKiOreVw7XBYTq7eDQzA6VTP80KiOTubuyBAxTCFSbiFJpgLdTkesz
	 /JUHfD15NADzouoc7sOTW8oWsmxGNsedgmqAAAHbT9HTKgC4nbDHkE7ZzYF2rG4EC2Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793826491;
	bh=bdkrGnLaovWLx+X6PjJA6V3ADdHONcBhYUJg0pieers=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z14LpGWLoFWQJ+BKhCHZ6FfuwoNBZJyhULe4XRblz0Ke/0ryJpZhirEdX+kaT6I9X
	 Q/OOfVzkBiwGfQGKvaM2+/59JE5nQvuYzWq4xAIOajWah26tGoh/FXznsVz4WiTfgZ
	 M+SEAu5PJX6J2Mrd8chzCCdHvjCpBGrr2rlo48VcW5Af5UxKISgwA6FMeX+ELhZtkH
	 1GO2S0ABeLzWSqal8vMnj7Mp9J3KdVNKe1JTlMee2HEZvQfqhfDPVm/0sD8YowGWux
	 gZYQKozW82I11lOAtDkyW+6WZWxUybjIHP2m8tL0MHbhTUdrgvC6N3ieov6RQq1ao7
	 5RfFBus6TcloA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB7D74093C;
	Wed,  4 Nov 2026 21:08:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1523131F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06CCA8109F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eomKld0kxb4g for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 21:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 53DFF81062
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Mt+IdHp5
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53DFF81062
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:08:08 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-563a0462094so629053b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 13:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793826487; x=1794431287;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bdkrGnLaovWLx+X6PjJA6V3ADdHONcBhYUJg0pieers=;
 b=Mt+IdHp5nZxwnG75PsDGGvtuLmCtGt0hracGzA01X2llIrh00WZx9of0FXSo9ILbQK
 ZPTF+eAvu7UWgdI0zOHq3COmDoFatPv7SCEVB0/8Q+GokHLHPeBV8Z4Qzig1DHSX890z
 ZjGYSfNfi6vfltJOfWLQA0heriJPQ8/lGK/j2bbw65zsEPy8jHhWd83aZPwqlKZPXU74
 7DZYAKehXII3HeOJ7efjn5O40rSlFCXR4qi4+GLU97vTTYSQNvbrCjFEh0g0ISNN/MTw
 N7T7uVfiPcPURBMyadvnw14UhsS1FTP4ITxwHDjMM7BWc+TyUHYkrJkQINRdL5Z+MrEH
 +NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793826487; x=1794431287;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bdkrGnLaovWLx+X6PjJA6V3ADdHONcBhYUJg0pieers=;
 b=JcDMoBFBQLv6tiE6vGv9bgaLsk6Xnvyq9Gx32sC3nNYB87PKPHWASkN+T2C1ExyemX
 n0EkS73lMZukGqz3x85492DCX6rBwqXSsY0UDQuU8jO98PgMVSG32k5pS5LDrGssNYce
 JigPzcy7AbDFZzE+EXy2NDSxZxFx8Qs8OcMCO2y7nn61frp3mdDLIs4+JeBBSz5d/Ldj
 ecyT1LYoGtutWsPv7esa7EdhYnvOWUduEF7rCmxMtMarIA2imvYNFDKLTy9k/YJTTxS9
 mLx2TveQxlU7+awcL8D+MnNaX7+CPBsEBAC2a/zpGTJnjene+KPTc2oVzKA6cgc77QCH
 lphQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJq1pxZ/QDVvNqL8IWujIk2SE/wI9DbaO/i+EsUuKZAUpOpjWjc8hcYnfR7Q7lbEs9AN0sXTw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+/F5xXemvDn5k3n7kpFanC9j4yNfEU3BoZ9Sq08PvJ4OY2Hk8T
 buFk3RLNGMq2bR2UrNk8mpFqgI3EFtGQqZT74syIcPojwny5Iavp05ezaLpSidKdpdY=
X-Gm-Gg: AYBFou2WlBVfNxVO3Bi3zqRbL3hQOmMGojeAnq5NVK1LX1RDb59XVy9I34lRDg0cUn9
 mS8E2MWG9u7t7ubBERKd9Co8XmWXdellUXRdgw6CcBqISofNq/3qyjr8qygHRx165S3s3F9EHYQ
 1+xmCP6+wVNSdJmbta6l+R31K/W3P3xR2riNiRwwy3zw41W3bvYYWxL+k1ZXc9+RjLSL3CXUGoo
 dZGK63AyctOGNVA6Yj2bGi5s0I8/SY1dDrEExkIny2pIt1zPRQV+3PabbDyrfNhzKb9F/ANCb+9
 xcmSwxo/G9gNUVmPGs2SuJI/t7e9u4W1pYWyTmHv9QmODki4P/UA02xUNHHNGLzIeTH6hzZdi9Y
 eO26vYn5vjZXtDYBkbXHK//JgNrRn+IUIXA4piKSJRMXZouG0TSUT9MVShxxYLSyo8UqhH5hozI
 rJkSrQt2lxyAGLsUCBb8h2XeU4In6GQBP5ThHzhE68t7uKwbYALAFRz3uCtrChzDZjaHL+5Lb12
 NE3kjGGqz/eq5yaKrozWEn3E8pfsI4gv2KH45JW7R61AbUMUSl/kSnibfohJHdFELqFPPmyLBCh
 2jnQHKJertV5db7xWmPT8bTBXQvnwecPzVrclkHmEp0mb/B5dUg5Ejrv4WeOrVkrAHXwAD+ZM8/
 JVVhaYCuYHM+qBH+FsFc2
X-Received: by 2002:a05:6808:2223:b0:55b:f88d:6eb2 with SMTP id
 5614622812f47-5640d973550mr13361808b6e.6.1793826487461; 
 Wed, 04 Nov 2026 13:08:07 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:f563:d5d:661c:51ed?
 ([2600:8803:e7e4:500:f563:d5d:661c:51ed])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9f93e30sm2591552b6e.13.2026.11.04.13.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 13:08:05 -0800 (PST)
Message-ID: <b5248a3c-48b3-432a-a86e-298688d7644d@baylibre.com>
Date: Wed, 4 Nov 2026 15:08:04 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mediatek: mt8189: apply the DRAM description from the
 bloblist
To: Tom Rini <trini@konsulko.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
 <20261026154340.GA646438@bill-the-cat>
 <9af0101e-e133-41a4-b0dc-b1d215bd7c83@baylibre.com>
 <20261104202100.GH1164024@bill-the-cat>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261104202100.GH1164024@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 2:21 PM, Tom Rini wrote:
> On Wed, Nov 04, 2026 at 08:01:16AM -0600, David Lechner wrote:
>> On 10/26/26 10:43 AM, Tom Rini wrote:
>>> On Fri, Oct 23, 2026 at 05:32:42PM -0500, David Lechner wrote:
>>>
>>>> On the Genio 520 and 720 EVKs (MT8189), the DRAM size and some memory
>>>> reserved for the DRAM controller depend on the DRAM fitted to the board.
>>>> The devicetree built into U-Boot can't describe them, but the boot stage
>>>> which initializes the DRAM has this information.
>>>>
>>>> That boot stage can describe them with a devicetree overlay in a
>>>> Firmware Handoff transfer list: a memory node with the DRAM size and a
>>>> no-map reserved-memory node for each reserved region. U-Boot already
>>>> applies such overlays, but only when the transfer list also contains
>>>> the devicetree of U-Boot itself.
>>>>
>>>> The first patch makes U-Boot apply the overlays to the devicetree it
>>>> found by other means as well, so that the earlier boot stage only has to
>>>> pass the DRAM information. The second patch enables bloblist support for
>>>> MT8189.
>>>>
>>>> The first patch only changes behavior when a transfer list contains
>>>> overlays but no devicetree. As far as I can tell, no board does that
>>>> today.
>>>>
>>>> Tested with TF-A BL2 passing the overlay on a Genio 720 EVK (8 GiB).
>>>> U-Boot reports the DRAM size from the overlay and its devicetree
>>>> contains the reserved regions. Without a transfer list, U-Boot uses its
>>>> devicetree as before.
>>>>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>
>>> I'm wondering what the status of uptreaming the TF-A parts of this is,
>>> and why we're in this situation rather than how the other bloblist
>>> platforms work (as I understand it anyhow) of either providing or being
>>> provided with the device tree, updating it, and passing it along?
>>> Conceptually, I'm OK with this but the support of just passing an
>>> overlay from TF-A needs to be accepted in TF-A too. Thanks.
>>>
>>
>> We weren't planning on upstreaming this to TF-A. Vendor firmware currently
>> uses vendor TF-A for BL2, but our planned "upstream" solution for BL2 is
>> only DDR loader + U-Boot SPL rather than trying to support both upstream.
>>
>> So the most important case we are looking at here is:
>>
>> - DDR loader passes bloblist with (only) overlay to U-Boot SPL
> 
> Is this valid to the spec? That's what I was driving at with my upstream
> question.

The spec says [1]:

  The Devicetree Overlay is defined in [DTO]. The Devicetree Overlay TE
  contains a devicetree overlay blob in the data section. The intent of the
  Devicetree Overlay entry is to modify the live devicetree in U-Boot or
  kernel. A DT overlay consumer applys each overlay to its target base
  devicetree when both have the same top-level compatible strings.

[1]: https://firmwarehandoff.github.io/firmware_handoff/main/transfer_list.html#dt-overlay-entry-layout-xferlist-dt-overlay

So it doesn't say anything about having to have the devicetree itself in
the bloblist.

> 
>> - SPL could go a few ways:
>>   - pass bloblist unmodified to U-Boot proper (what this series proposes)
>>   - add U-Boot proper control DT to the bloblist and pass it
>>   - have SPL apply the overlay to U-Boot proper control DT and pass it
>>     without using bloblist
>>
>> I think the second option sounds like the best.
> 
> Now that we have the series for passing a bloblist from SPL to U-Boot
> via documented register convention (and again, thanks!), it's an
> interesting question to figure out what to do here. I assume option 3 is
> really listed for completeness and yes I agree we should not do that.
> Which of option 1 or 2 is better maybe depends on more of the hardware
> constraints itself and if we're using SPL_MULTI_DTB_FIT/MULTI_DTB_FIT at
> some point. We have code for resizing a bloblist and so we should be
> able to handle being given a small one with the overlay and then
> allocate a new one that includes the dtb (and if needed, not bother with
> keeping the overlay?). Either 1 or 2 is fine, it's a decision best left
> to the MediaTek custodian so I'm deferring back to you :)
> 

I will think about it some more. I might end up doing both 1 and 2 so we
have some flexibility.

