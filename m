Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D27BC61DCD
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 17:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88BA280EAC;
	Thu, 27 Aug 2026 17:01:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWbRv8EUj7Fu; Thu, 27 Aug 2026 17:01:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787850074;
	bh=9jfdT+2pLEPxhm0R3X+vXM+Bk2hXFo/YMl1mud71UnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qr10yEgv7yPJ8RW8eSOeejgEgCBkOp+TeVMgZAkqOwCey6IaUY+hi+rPuV0XUcM/J
	 zpKtyTKsvS8EmEtHmF33COH5KJsnO6pFsL0epqPZAtPdnT3p0z9YuV99Thj9SqZaOG
	 F3IWb1xHFcdOTM+3QoDUZ5DpFgVYM0OVxQeukyAuOZA+zpPPZoqFuK2KCmGt5pmxiu
	 aPXMj+W/LhgfHXHcq473EUtyo5KhSFWc6PDpjqKIAWMeyO40lTqp1Gp7CjrtwAOq+f
	 n0Wr7pSdoljK8AO3kB1cSUgXNOzp+bG4BtiT2hqTjMhKfKWo+JYTfurpCI+RnGvIMh
	 nU1e8S1AtsVQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95A8C80EA3;
	Thu, 27 Aug 2026 17:01:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 59763355
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 17:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B4F7607AE
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 17:01:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UA_8bT4nFv7w for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 17:01:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=UFKlLknX; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=CegI2QTP
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8528607A0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 17:01:11 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hW78474ZzzMlG4;
 Thu, 27 Aug 2026 19:01:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787850069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jfdT+2pLEPxhm0R3X+vXM+Bk2hXFo/YMl1mud71UnI=;
 b=UFKlLknXrrKbj+dIbM2DXyDgLKDD7cHJieXZE9umYbijKnOj4H3j8absRTS8XT+4tmu72f
 ViLXL7eNPFmwQ2W/ziWU+OJLI+XwikLigd7r7uX2nyFI0iAJvUDcuqH1FcriTJulcZ6PTy
 PCD0I1ZWS1JmVHu0dqyqYUTJz0cpbuHRdlYnQbKMN4lqYrLKLL2FGyHofMm4sHbIOk5zlp
 W9XJR00RY3e+Jp1/9NOBaSBhlPLwjcW9qg9LQbgKJ0Q6Zmmh09lqupdnmWrVbPKAjrnDS0
 qNnGcDHMjFYO+dcoSy/gegrXZB6l1Y2zQfydDxiEQndrcHjF5mp6GUUqElX2yg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=CegI2QTP;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <125194c0-6055-4233-8f02-904234a0fb2f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787850066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jfdT+2pLEPxhm0R3X+vXM+Bk2hXFo/YMl1mud71UnI=;
 b=CegI2QTP3pcZZWZi38UtHEeZmgqOHsLZNuRN5IHHO8G7IFzgTR7fJGjjSGVm4PUflUGrT3
 Z77drrRgmsaCIetyXJa0N1Qgu+UVsGpdnCKovGuyJpDKHzVdFkmhMA1d72OxijIwlBv5TA
 IZy6nsXjlOEIjvzzD9UOjZPq6dcW7U6ctG7GMdpctRAVSLdFkpT+zDf6PNUx+fcEa+XSI2
 Ihwj4n/CptCft8a6OoGE9GFJXzTcs5xDDNifnLcKN+HdgXjhKMo9knnsEV0zdvSa5yRE7K
 0W/313c/4srK1/bOAlWBgGrvurb2k5ykl1UlMSyUlV4zNGqOcvzKzsxppsQkiQ==
Date: Thu, 27 Aug 2026 18:53:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] mmc: zynq_sdhci: support Renesas RZ/N1
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>
References: <20260814-rzn1-2026-10-mmc-v2-1-51e4d8a717b8@linaro.org>
 <4e3a48d8-d971-402f-9542-820f254abc77@mailbox.org>
 <ao3xXc7dNbFmKEha@maple.netwinder.org> <apBFzRluireFK8tl@maple.netwinder.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <apBFzRluireFK8tl@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gom8hzumwn85wqsxn5qch3j6bmtq31qa
X-MBO-RS-ID: 24295a7a8464db5e69c
X-Rspamd-Queue-Id: 4hW78474ZzzMlG4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/27/26 4:12 PM, Ralph Siemsen wrote:
> On Tue, Aug 25, 2026 at 03:47:41PM -0400, Ralph Siemsen wrote:
>> On Sat, Aug 15, 2026 at 12:21:11AM +0200, Marek Vasut wrote:
>>> On 8/14/26 8:30 PM, Ralph Siemsen wrote:
>>>>         return ret;
>>>>     }
>>>> -    clock = clk_get_rate(&clk);
>>>> +    clock = clk_get_rate(&clks.clks[0]);
>>>
>>> Can the clock ever be non-first clock , i.e. do you need to handle 
>>> clock-names DT property somehow ?
>>
>> It's not clear to me if the DT binding specifies the order. It says 
>> there must be either 2 or 3 clocks, as well as clock-names properties.
> 
> I had another look at the clock ordering. According to [1]
>   "Order in lists is significant, order in dicts is not."
> 
> The binding [2] uses a list for the clock names:
> 
>    clock-names:
>      minItems: 2
>      items:
>        - const: clk_xin
>        - const: clk_ahb
>        - const: gate
> 
> And as we can see, the reference clock ("clk_xin") is listed first.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 
> tree/Documentation/devicetree/bindings/example-schema.yaml#n47
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 
> tree/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml#n116
> 
> As a further check, I reversed the order of the clocks, and then ran 
> "make dtbs_check" to verify against DT schema. It complains:
> 
> arch/arm/dts/r9a06g032-rzn1-snarc.dtb: mmc@40100000 (renesas,r9a06g032- 
> sdhci): clock-names:0: 'clk_xin' was expected
>      from schema $id: http://devicetree.org/schemas/mmc/arasan,sdhci.yaml
> arch/arm/dts/r9a06g032-rzn1-snarc.dtb: mmc@40100000 (renesas,r9a06g032- 
> sdhci): clock-names:1: 'clk_ahb' was expected
>      from schema $id: http://devicetree.org/schemas/mmc/arasan,sdhci.yaml
> 
> No complaint when the clocks are in the correct order.
> 
>> We could try using the name ("clk_xin") and if that fails, fall back 
>> on using the first clock.
> 
> So I think we don't need this extra complexity after all. It should be 
> fine to rely on the first clock being the correct one.
I'd still go for the safer option -- look up by name, and if it fails, 
fall back to look up by ordering.
