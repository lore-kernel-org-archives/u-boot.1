Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87A606A32F
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XRLKvcPH;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iP0r56t9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B536780C8B;
	Tue, 17 Nov 2026 14:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id us1gzNUqNV6d; Tue, 17 Nov 2026 14:39:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 59D3A81166
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794926372;
	b=SxqOQ540pv42gn/JicPMvO7S/yNtEsASTHknHg9ZpwsgSc77qHoHa5q227S54v/Ek7Kl
	 v59MGrjNCw1TTk0rHPsVbj7nPRAjPHxAYMLVcBj2QV4ZzATM09zpbcuMHcxaBnyJ6lzH8
	 d1y0dRr+lElznBTPNDkJecYOeSmWyq0zPMAOpLOqGjSXd4f4BUokLtfNEjIgag1GMwl51
	 DMzsCMUUEgTpRzRL/upDeO2JJAhdEv30iqFhMKOyHOeqlfhicp84B/OeJKEzzQPJk7QB3
	 uSTVffJ5dzImzSA0qz5VOaPtwL0+RaYgebEPlJDugyo9nFVZe+5E2r6YxR4PZc00Niw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794926372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bFMsAAtK8DreDmjo9LsNl8pbqWbUDfeJz0iyk3U8Rs4=;
	b=VnNjyfBexdClivRjgTeOdzrjaOxoTNptZ8fyGA+BOuTfBhxakpt/ikIuviYRn7lI96Yd
	 UgcXq3N+6U95pIQs2JBlMkY1dq+piywjC28ZRktRNNSQW2SIEHjjciF2kvDCe1yrnc3Sv
	 AFPVIkyYejvUYONe+/SrN1IhIt2D1JJr7W3Ev/ErqbEuCN8v+UgnItgvnBhfwR/gKqUMQ
	 3zsudFMpvvQq075l8VgVT/UgbNhbtSghm97C3fDhv72G9nsAebar2WEJ11QRJ/0ivPbmy
	 /QPmD0tzT99Uc+o+9Pkh4v8uIcXmqktAlwjF7WSvjJyOFNJ3zfkMJJ7a5r7ynJWW/JQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794926372;
	bh=bFMsAAtK8DreDmjo9LsNl8pbqWbUDfeJz0iyk3U8Rs4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XRLKvcPHKcfQoxExqaO+UtHkwBv3n9lIHCLfjwl5iKWVTB2fJCBjuQ7L23CuEN1GB
	 OLiQOEcVBSIAxWK8RPE/VwlCvfMOKiSJs4dKzJ9x8P2GFPdomEF/lZSBSq8roIFtQE
	 qVlLyAGRSK/eFRgJFbnIhiNzARPN+tHB4j7//SlzImlVLFhk9Ti7v6FDsIpsePL4tV
	 pm/EsrGAFxc4SBBxeSYwgqL592gED0ueMBlBdu3GjpaRVssWYKWqfbDHt3LFVbjfZh
	 1Idkj5XZrXTUMLc+q9c7KVxYfHA2UV6V7vqcqdArxNlK9QflWox5fqgFKQxnMQb4lP
	 pDcbw2aLFJYsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59D3A81166;
	Tue, 17 Nov 2026 14:39:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A8C2870B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A77D407D9
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CuTFlQRGB1Jk for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 14:39:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68D9A40215
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92f; helo=mail-ua1-x92f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iP0r56t9
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68D9A40215
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:39:30 +0000 (UTC)
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-99bf7b97f12so606208241.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794926369; x=1795531169;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bFMsAAtK8DreDmjo9LsNl8pbqWbUDfeJz0iyk3U8Rs4=;
 b=iP0r56t94vS0Skb03h5r0gtTzY85nBx7Y9ad0qr7ISiib++Luy+y8E0nD4RRwmgjHe
 A/zUx7zJLknK81hDCzLM8EPIRDdRe7UWuYur4LGRilUr2ZhM2kF0qgu2cN3Vez9ERT+r
 IyCbI2HuMHwh4i3oIrNp7lRDh0dOCSK7x+j1l6/EcDypFwJQVEHyYhYB8C1PapA3DCVD
 tvR18dzbZ8yRnAKzkDwhKbGudHnB1gjaMg9+YFd6y4jz7GG5824qEQ5d6IfNT5yCNQpQ
 U6dLhWCaf9XhT62UdcJYoqdLDGbdR9pNHfN0DZtPu5K9Aee6CH40jtwP+7pWDh/K5VKB
 C2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794926369; x=1795531169;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bFMsAAtK8DreDmjo9LsNl8pbqWbUDfeJz0iyk3U8Rs4=;
 b=ojE/ZK/7sYgw2ipLPO1tlxZ585GB2mym8NDq2pZXYo0vU/bMmvcHeSBs6EJ5qbfjth
 7kdf9Q76Pz8yAExUPOCPm7DEEkfnU8oOPrU/VgIRlzyQsVgzJ0idOwOewTuiCuDPPGSH
 Ew1SLFwJtIkgRBOqRZgtyQ1yjJZu6EvlKAjL3474Lcv52pG9S45VkMUzWmO4E8aReolw
 WKl387Nz6pyqfYFUZaSnDSKAuruXdifAH96snQTQ7cQeiF1poQF883lAjIyOYcLFdZ+n
 p/nMrjCg2hZxZcYQ6oTE3bfFHpqfikCfkX/UgIFzL+/kS5ifxzpdQ0vUiD69Xk9/rWyI
 097Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEDL/yJc8lHWXb6TLynF/zt9BTXL/735I9FXAh32TjMjEPZKMH6s2GG0Szxy83/axO0o6xdfQM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/pN/7UiBWPsbqx5e2JOi3dKpgCBBsVKj9mJHf+jwQ20fcrRpbm
 YRl2M7v4akgDX6qzvcuCmlLUib4zcw6Vy4lHaMBV0uR8NhMehsWtZBfa54YpgUikhVA=
X-Gm-Gg: AYBFou3H17bExSql4/Rlhx++TzWBNVNF+wfA3uHv8BWiSy3zSgMNuuyOwbAjyO7mQRQ
 aeeAa40t7hkB60jmF/azOAHpGLjAjaT0MK50WoWMEp2MutB4rDvRhGXbC53BRZmnfX8kHBMlN8j
 0B4UZa8tuRfwef+Nv785NsfukOlkwhxoM8UhXxbIIBonMdBQNJM6a5QZpEO0dYQ6IwRkixKcyIh
 pBUxKcBR+C8IgIj6UDtlzFqmRmAzw/Kdv8iWm1SdNUcGIO1jkoHOx4ReN3ejsNwGjSNCPtXkgRn
 0Uwo+LGXlUXvBS54cB8gHUBSwwP0BbO7EvJMpDmhO7YaqPp/eReOWDrc7CdhjOxH6jIkb8lLUJ6
 bi4L1tPP5mbzrLMkVRKZQrVZmn3xMuHOAEaoSLg3znMONjXfZ1pCh+fl22XZEVfkSCkrmM7ke9g
 ui1Qqs5VIis0/zSkKrCgSypd5wUGBELBsqGbfXs23XefpN4PPxqskOE96XDB7nySOLdV1O+XF35
 w7mCGAmcVoiPSJ/B8aCjZwmnzDNbIgdyHlIwggwiEeowQAEhflHRoX4HWMmMQjjVp31bcfqOgsD
 c/4swFu0BodvphxqcWJyD8HBhvmzd4nuQMRjxe8Uq3OUfM1J2GhYggv+X5aA9gLpXfYwqaPlvTa
 CDl4=
X-Received: by 2002:a05:6102:509f:b0:7b3:5b2f:7030 with SMTP id
 ada2fe7eead31-7d69f61df18mr814281137.4.1794926368705; 
 Tue, 17 Nov 2026 06:39:28 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c3c:99a4:6f4a:ad27?
 ([2600:8803:e7e4:500:4c3c:99a4:6f4a:ad27])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99e339684aesm2144779241.9.2026.11.17.06.39.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 06:39:27 -0800 (PST)
Message-ID: <aea66a5f-088e-4e17-8188-4a06357de7d4@baylibre.com>
Date: Tue, 17 Nov 2026 08:39:26 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
 <CALeDE9PvZgwiAUxdX=-tN1fgDveNOkeM__xCCJeZrK3Di0WxjA@mail.gmail.com>
 <1b9f2a45-4ceb-48d0-afdb-b406404d98bb@baylibre.com>
 <01408c47-2928-48e3-ba37-34b835a3b98e@cherry.de>
 <f0352e86-58bd-4e6f-aa8f-5253a9c29a55@baylibre.com>
 <4adb08da-1ab4-4849-9001-f0b54065b5d0@cherry.de>
 <273552c3-9bc2-4b60-9a9d-6d6082369fe9@baylibre.com>
 <20261117143531.GQ554944@bill-the-cat>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261117143531.GQ554944@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 8:35 AM, Tom Rini wrote:
> On Tue, Nov 17, 2026 at 08:31:00AM -0600, David Lechner wrote:
>> On 11/17/26 6:52 AM, Quentin Schulz wrote:
>>> Hi David,
>>>
>>> On 11/16/26 9:42 PM, David Lechner wrote:
>>>> On 11/16/26 12:45 PM, Quentin Schulz wrote:
>>>>> Hi David,
>>>>>
>>>>> On 11/16/26 6:17 PM, David Lechner wrote:
>>>>>> On 11/14/26 3:16 AM, Peter Robinson wrote:
>>>>>>> Hi David,
>>>>>>>
>>>>>>>       > Anyone who has worked on hardware that uses a devicetree for the
>>>>>>>       > hardware description should know the mantra "the devicetree describes
>>>>>>>       > the hardware, not the configuration"
>>>>>>>
>>>>>>>
>>>>>>> Thank you for this, I never agreed with describing these in the DT at all.
>>>>>
>>>>> We probably should do some digging on the mailing list because I believe this was brought up back then. I also disagree (mainly because the Linux kernel will never agree to this in upstream DT, so this prevents us from the dream of running pristine DT from upstream). I vaguely recall there are a few things that are binman-specific and available at runtime by parsing some stuff. It's very vague, because I don't remember. But I wouldn't dismiss binman use of the DT as simply being a configuration format, I believe we use some of its things at runtime too.
>>>>
>>>> The two users of binman nodes at runtime that I found are lib/binman.c which
>>>> is only used by x86 AFAICT and board/BuR/zynq/common/board.c (to locate the
>>>> FPGA bitstream).
>>>>
>>>
>>> Maybe it's worth checking with the board maintainers if we can go for another mechanism so we can sunset binman nodes in U-Boot FDT entirely?
>>
>> That would be ideal.
>>
>>>
>>>>>
>>>>> EDIT: ah I see now reading patch 6/10 that you're aware of that. But phew, is it really worth it to do this incomplete split? I fear we'll split the ecosystem once more.
>>>>
>>>> Which "split" are you referring to? File format, file location, something else?
>>>>
>>>
>>> My understanding is that few boards will need binman in the U-Boot control FDT, due to needing access to binman nodes at runtime. Most won't, but the fact we cannot fully migrate means we need to support both forever, and then we increase complexity for what benefit? For the sake of "correctness"?
>>
>> The one ARM board should be easy enough to find a solution for. The x86 stuff
>> will be harder since that was all created/maintained by Simon.
> 
> Which x86 boards are these?
> 

This is what I found so far:

x86 (through lib/binman.c):
* intel_opregion.c and apollolake/fsp_s.c find the intel-vbt entry.
* fsp2/fsp_init.c finds intel-fsp-s.
* fsp_silicon_init.c calls binman_set_rom_offset.
* acpi_nhlt.c uses binman_section_find_node and binman_entry_map.
