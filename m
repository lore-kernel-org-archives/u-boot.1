Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC930C02181
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 00:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26ACD807B4;
	Tue, 21 Jan 2025 01:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737418006;
	bh=6lU8fo8ZK3Fesx76Uh28BjYX9vHw2AHjG8xdYIoXYCE=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TAY9s2lG4nEL6sxNqqxn4x4GbThqgvw3vUOpXre+O9dZAeVnwlBspWdYcUy5UmuJ+
	 mf9fVeZoy9jD0QCQxkVtrA4p2CUBcS1Kv+nrbvbjGXcWcXo2yw0jpZpNolR2nHrLK1
	 KJeZfifkc+/ooiBlcCy+hKIGLGq0h5Uj6x0x24QmtUxRljKpGgb44cUq4sxUlk5mk/
	 FPtrA79q3GQg6PpVwlm0x6qarYgc2/kT5itwG6MJ4umZOGmJeMR1YEOftMiEmZNGcF
	 iSgWNjaOdLUsofU215iqjaSPhEbANWN16ThsRk7BY+iZNo1nP2V8EFe/TZ6xtDb2rc
	 9KrVKBCFpkazA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 844828077F; Tue, 21 Jan 2025 01:06:44 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F8280759
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 01:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Kfp+cIno"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CA15E108A88CD; Tue, 21 Jan 2025 01:06:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737418001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lU8fo8ZK3Fesx76Uh28BjYX9vHw2AHjG8xdYIoXYCE=;
 b=Kfp+cInoLPjotbU40hIl0P0DFRRL9f0DP06u5RXikeZafZCZ4Bv3aKpX7aop7lR+rHPEAI
 l2K5shIWLNdXSILUiT6NZ41pazXRbBxtuWahEaDaNCjtgeMO1EEj2cmySMG4ZK5RjvY18R
 8mE88EtBhFSvOGT6xEtg6R7RtFJ7kOa0ftpGGlr35qsg0oKBbDgZdi9XCGv3iqh2ieQveY
 iw7uNROEuUbtkuO8Qb/hGYe8RRAGAolvtjIXdEXeMWMrpxXgrysWLdN7y2WIMgdCEhipfO
 MQWFLeAVmHv2MMyPKxpCrqySkRk8aFS7Ya/s8RDmWxEZXDyOUM5jxbhirJzNsQ==
Message-ID: <d39646fd-9c3f-4e5d-8d2b-e3d17feed604@denx.de>
Date: Tue, 21 Jan 2025 00:58:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: core: Fix timeout check
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, ni@konsulko.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, u-boot@lists.denx.de
References: <20250115062044.3834433-1-quic_varada@quicinc.com>
 <87frlj85qu.fsf@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87frlj85qu.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/16/25 10:31 AM, Mattijs Korpershoek wrote:
> Hi Varadarajan,
> 
> Thank you for the patch.
> 
> On mer., janv. 15, 2025 at 11:50, Varadarajan Narayanan <quic_varada@quicinc.com> wrote:
> 
>> dwc3_core_init loops 'timeout' times to check if the IP block is out
>> of reset using 'while (timeout--)'. If there is some issue and
>> the block doesn't come out of reset, the loop will run till
>> 'timeout' becomes zero and the post decrement operator would set
>> timeout to 0xffffffff. Though the IP block is not out reset, the
>> subsequent if check 'if !timeout' would fail as timeout is not
>> equal to zero and the function proceeds with the initialization.
>>
>> Use poll API instead to resolve this.
>>
>> Tested-By: Varadarajan Narayanan <quic_varada@quicinc.com>
> 
> s/Tested-By/Tested-by
> 
> See ./scripts/checkpatch.pl:
> 
> λ ~/work/upstream/src/u-boot/ varadarajan/dwc3-timeout ./scripts/checkpatch.pl --u-boot --git HEAD^..HEAD
> WARNING: 'Tested-by:' is the preferred signature form
> #16:
> Tested-By: Varadarajan Narayanan <quic_varada@quicinc.com>
> 
> total: 0 errors, 1 warnings, 0 checks, 33 lines checked
> 
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> 
> I think Marek can fix-up that when he applies, but if you send a v3 to
> correct this, feel free to add:
TB by author is a bit odd, so I dropped both TBs and kept RBs only.
