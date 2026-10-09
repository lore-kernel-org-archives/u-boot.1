Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B47CA601D
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EACEA40935;
	Fri,  9 Oct 2026 16:29:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eil42m3THIwd; Fri,  9 Oct 2026 16:29:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1067F4092B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791563381;
	b=GmvzCLgJQaRni8P0mS3wyKGF7wiekpBHrKlPVmiF0AReDsFcwv1NbOvkX2mNv3i53oSX
	 GPcvRxuvG93IQKTuoUylgQgJsABKk3hIlYRVuwDhqdQmH1tVn1jUU62FQ0W4BU9iAeoQW
	 9vDp11mUSbLEwxwBNbyru0dpv0L0c70Nut3ywipLbShayn7m/uLg5wtdj7Nx01Ptr5dSo
	 RhsuD+d9jH+UjUbSyIw/KpT4M9Y/dZvpwUY4VDe5DmXTb6ADohRfPWbIEij+LQms/A3Wj
	 Q1VjkxPi8jYrttj+gA4N4QyJLMhZfYdzLxrSKigsgrqYgC9kjF5NQiE9MU3vkOuXBvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791563381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=M33hgtnFZmsPlBz2zRB9Jwm6NBtIvy5HxDvDdwsPT2U=;
	b=J7i6grAhGzQr5KNxXSRPi/Xzu93Sz4JGFUKwJPmwkhxodIyyJ1uzFppnrCLdVH7X5n1d
	 g5cYVP/kkPfkqE6+OsxEjrXgqbQCTmwezleVOi4oKdL8mCXI6jg4+EXdsoFCIH15/V+1F
	 YDmeldR9zyGuJlCDKdPOX+3+lq/LznzrBOCh4Fv7L0hO61iKrJq4jCXTrerR9dLoMLMyo
	 wja14d0DbzRPBwPp0SyTbTV0CFdmUPBevX/x0vYdfaVlIxj0BOt+JG22hZNsNR0jX/gSd
	 x2Wn3w+Nkh7pQ6Vpp3zOfPx8RB5co1uk1GY4bX0Y40ZCIQQGvJwQn6pO7wqn/VZ6BnQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791563381;
	bh=M33hgtnFZmsPlBz2zRB9Jwm6NBtIvy5HxDvDdwsPT2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cY8EH8slV278SrOqH7I+65HaIbYTsAgtFdOP4qXhSamSEG7Crp44jKYE20Z9Tofqu
	 kkWNBGMc1JalIOGcrVHpVRP0DEQkx16aSz2YuAhoLlb89vb4ZUhAF1UFjGrD4oNRCJ
	 5rZLWyxVaTEpmRsr7smocLjQDdFpAJ+C4yKQ2hlGGNMZIELHF1IhKuGsl+YGVjS6W9
	 Y/ODEGdBSOOgLOgFdV8Js+m0O3tFWUoW9BOzZU3HAPQExatqJMrpczKDnWjWt9C9e6
	 IA4tdHydsU3UgPX5xhKVz3x6L3ZefpqAcBCXRMSuEoi24AyoptyrYQGrJfYmZN/5AN
	 ouLRsb0je9EVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1067F4092B;
	Fri,  9 Oct 2026 16:29:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 674AA317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 651D5608B6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dPT0Vu8dCqcP for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:29:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A5D0C60609
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791563378;
 b=hnpc3UriFddvGHxkVQ0SXAgq+clgC0FWeOOLRDHqZZTMsC5Kl6GfC0Us3kwg6G+V2FmM
 HPv32bHOUES13r76mIbixACaOXGbuSUG1BOxQQHbupFtW2ABynAo5551nvLbyOzocAeq8
 E/Ui7DN4Ae6nc2FdmkIFnFunk5Zg01Qv7RYSvfAsuJLwmHUhW2XOKZHXJNDs7pB8SxJfr
 n71t6faAJf1tPFDFQsB2xLTlkzCohd/b0d7B3/esOWZZIcIqWKUqURt8VkEsV/yhM97Yc
 xlq5iR/8+HcgwqqTyWjZGM9FCmiXnQSymToEBGhEg/QBZx88Sdart6b7kJxRuZPwWrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791563378;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=M33hgtnFZmsPlBz2zRB9Jwm6NBtIvy5HxDvDdwsPT2U=;
 b=OgdyI+fy25k/PbZOTMRZgcb/eTuVYqqU+fAAX2j3NO55t0KVVYS774PM/q9bUmqAqMUd
 ZsOmk3hHf9DqnfyMQ+w+aizEznP2vEh65CJaS17XQHZvv8AR0pxyLt6jNwh4aLbxU0riG
 AarDu6jj2w0VBBT7wYjMhTIs7H4A3gXWIN3L2iaDF5ArGzl2LI1ojg/EkKavXRWG0jXM+
 wi+W66OK7W27jmY9Hn7NOzt+8sNrw7yPvNlOBapL+vsGk/ZsU45n07m6W6pj/nNPcU8wD
 gj7xdknc0GDJdqCLZjcE+PXwPxEbzNIN+vj1FZbGMWeWXkUG2/+/YAfEyQDbC8Drsyw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=u7MVC0Gb; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=u7MVC0Gb
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5D0C60609
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:29:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 047611D14;
 Fri,  9 Oct 2026 09:29:33 -0700 (PDT)
Received: from [10.57.55.139] (unknown [10.57.55.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E64633F66F;
 Fri,  9 Oct 2026 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791563376; bh=9AeOqZjWordDbYuRRz6/pidGv19rdPH4O4n+5klwf3Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=u7MVC0GbyHZZ4tpzIsPxg90qw4hlr73oIllXMEXhD38Qi3sgnjheE4HOH2WPtUuVk
 44vRvI7DrL0W0o6k0N9hEbYuDWDJeebVjltI4b0uGX38/0bqKqyZrJW8ftKJzj4Ary
 8A9neW5eJg/3j0hfTWWF/CjqmkTpZCmZ2sXjM4Bc=
Message-ID: <46b973a1-3c3c-4321-80fa-a929375d52bf@arm.com>
Date: Fri, 9 Oct 2026 18:29:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] sunxi: Add support for A733 SoC
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>,
 Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
 <20261009120356.194364-1-vinicius.eduardo.pedrosa@gmail.com>
 <3f57db40-a604-4800-b15f-2d159a3a5ca7@arm.com>
 <20261009161409.256732-1-vinicius.eduardo.pedrosa@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261009161409.256732-1-vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Vinicius,

On 10/9/26 18:14, Vinicius Pedrosa wrote:
> Hi Andre,
> 
> Sorry about the wording. I kept repeating it to give context to people
> who might be reading the thread for the first time, but I see how it
> came across. I'm building on Yixun's work and yours, and I should have
> made that clearer.

no worries, I got you ;-)

>> Honest question, is it really *you*, or is it some LLM?
> 
> Yes, it's really me. I've been working with embedded systems for many
> years, but I'm new to public contributions, as you've probably noticed.
> I do use AI to help me research tools, handle some tedious tasks, and
> improve my English when writing emails. English isn't my native
> language, and I sometimes rely on it too much for the wording.

It's not the first language for most of the sunxi folks either 
(including me). Just try your best, we are used to decipher slightly 
broken English on a regular base. If you really must, feel free to let 
AI help you with the wording, but try to not let it wash down your style 
too much, or make it too perfect. Translating incoming emails into 
Portuguese(?) is fine, of course.
But maybe *you* learn a bit or two by doing it yourself ...

> But the
> hardware work is real, and I take responsibility for what I send.

Cool, that's good. I already figured as much, just wanted to double check.

>> Why not? Probing DRAM is somewhat the idea of that routine, and it
>> should restore the previous values it overwrote? So have you tried
>> running that?
> 
> I haven't. I was concerned about overlapping BL31, but I should have
> looked more carefully at how the routine works before ruling it out.
> I'll check the probe range and try it.

It's not the nicest test in the world, and it stomping over BL31 is 
sketchy at best, and just works because we don't really protect BL31 if 
it lives in DRAM. If we would (and we should!) it might actually trigger 
an EL3 exception, so the routine really should observe reserved memory. 
Also I am not sure what exactly happens when it goes beyond the 
installed size, I guess that differs by system.
BUT: it might just work, and then it's good enough for that time where 
we rely on boot0 for DRAM init.

Cheers,
Andre

> Understood that the FEL workaround is temporary, so I'll drop the size
> header idea. If it's useful, I can test your U-Boot proper series on the
> A7Z when you post it.
> 
> Thanks for your time and guidance.
> 
> Vinicius

