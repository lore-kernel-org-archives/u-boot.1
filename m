Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8120EC61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 18:47:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33FEC80EC6;
	Fri, 28 Aug 2026 18:47:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IaGIvOBdbEdv; Fri, 28 Aug 2026 18:47:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787942872;
	bh=Bbn4qADDBX+/ExUvh70l2TlVXXx8RJh5UadqdGLc/7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HkBv+8sy43xbriYXGlLzoJ5NiEyUjNvtkz06Vl4PHzcFktWgEWZ1z/N/HNSgPMVQV
	 0HcxCUZgs4PfLBeLXmGDgzD7v7pZ32CIkggAN9HwohYQ6hHgC6T3ffnDP3EYI/t1vl
	 U8pakTwavj0bieKTH1ojW+o4kdb1b5RMue27XNMCa5Ym6r+FV2NPfSs1dbSc/OnLvy
	 JW9ClRVqYji6uxupGzbmOQIvpzChdYvg1OGdYl6MoInNcejfT05VfECVtNghjGAonw
	 +jG2w0WDZ5FIYqa3cEVbv5HGewo8gIjlEVS3S2oCHyt2ORX3YXR+CZIKisFaL1DwIV
	 bXVrGcyHLRESA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B13780E90;
	Fri, 28 Aug 2026 18:47:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FBFC336
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA09E407D4
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qt1tZ-0WFK0s for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 18:47:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=Y7OZqMpL; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=pyYIMcsL
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D588840789
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:47:49 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hWnSg1hClz8tW5;
 Fri, 28 Aug 2026 20:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787942867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bbn4qADDBX+/ExUvh70l2TlVXXx8RJh5UadqdGLc/7E=;
 b=Y7OZqMpLT9ZAiOS9AKmXMyh67PI7WcUfTYOwbUngXUnOBqpeDg4XRt1tiy9JTlwQs6d678
 IJXmLH1nG2F6JY/cFgAIWwbwHnDN46emz4PnpDbAQKQ+D93LVnYM16/begzhMCgabBGtRv
 Nwih8ClK4RiZPTdvUX/O81hoEoV6nKvOUpXaPhLr98/CahXGIEvU9bhgROIH1nP7WZD7zE
 pXFp4ZAkF7F+rPtzalH9hf+qM1ZMoGaSPMSr85OkN7frhvX8ljrQ72IH4YJwykzGMbwAnk
 wVHoGdxbl69F/VyBFwG/JhL9x/dvgHpmFX2uZxcv428+1DWN0Agm8gOQO+t/Fw==
Message-ID: <7eeeda9b-a3d5-46e6-a120-ba371946ab32@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787942865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bbn4qADDBX+/ExUvh70l2TlVXXx8RJh5UadqdGLc/7E=;
 b=pyYIMcsL94BvB6WBYbt1KqMtQzgvJGmQYQPlMm5RcrKEFhPB0y41LuK/HYmcVFJPC3qoBh
 jRKbxaLqA5tdIVe1+ViQqyzbZzQfZPAV2HDQYwIFZkgmtiPVgDWtxVF/veVVgB/Pa6TKJg
 0fJvUeDNEMPYheLT10IDMKD2vxIXZqTpyWfeAo9/s69IxDTODQlW3psrB9C8XJYvJ3e4my
 5azxCbaBj4kfQCu1aVmv1pY/2gXe9tnZlLOzvHNfL+Z6hS2U5ux2n1P9lN8WP7JuEwiKCw
 cL4yv2hOWbWba8R+r47reEVQcu0Xz2EzyBe7/Roth8uE8HYGfYwEoya37HW2dw==
Date: Fri, 28 Aug 2026 20:27:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/8] ARM: dts: r9a06g032: sync with upstream
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Udit Kumar <u-kumar1@ti.com>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-5-56b6acef0439@linaro.org>
 <ab4604be-aba8-4193-97b3-cc997ea05861@mailbox.org>
 <aoBalbRFgBNJqZAV@maple.netwinder.org>
 <429a5b6b-cffe-4ab5-ba22-8e985c1c3a1e@mailbox.org>
 <apHLVXtTGuVEoeWC@maple.netwinder.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <apHLVXtTGuVEoeWC@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: e6fpxjd1o1zqmb5sykct7h1ti7h7gsju
X-MBO-RS-ID: e051e8ba131dc50f1a2
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

On 8/28/26 7:54 PM, Ralph Siemsen wrote:
> On Sun, Aug 16, 2026 at 01:25:09PM +0200, Marek Vasut wrote:
>> On 8/15/26 2:24 PM, Ralph Siemsen wrote:
>>> On Sat, Aug 15, 2026 at 12:26:16AM +0200, Marek Vasut wrote:
>>>>> ---
>>>>>  arch/arm/dts/r9a06g032.dtsi | 270 ++++++++++++++++++++++++++++++++ 
>>>>> ++ +++++++---
>>>> Can you use dts/upstream/src/arm/renesas/r9a06g032.dtsi instead ?
>>>>
>>>> Can you switch to OF_UPSTREAM ?
>>>
>>> Almost, but not quite yet. The upstream version is missing the QSPI 
>>> node, which just got added in the kernel side. So once that gets 
>>> synced into U-boot then we can switch.
>> Can you put the missing bits into -u-boot.dtsi ?
> 
> As of v2026.10-rc3 this patch is no longer needed, Tom has pulled in 
> recent-enough DTS with the qspi node present.
> 
> I will switch to OF_UPSTREAM.
That is very nice, thank you !
