Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3537606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F+A+pknA;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CW3SzirW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 989E04062A;
	Tue, 17 Nov 2026 14:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E-lGZJVwi49S; Tue, 17 Nov 2026 14:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34192405F6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794925873;
	b=liOQkJO7InlOVF2Xfa1k3FfY5Qk3QhafKOS3H9/yNcfGJo4ovpgZtoV7LXQqUQtThRov
	 V59pYR0Fh0EZzvnZgJLVDvNmhFufNWk2+N5xldnrMQHRBx9ecgZK+G0NUlX372yXC3ZhN
	 EdjEG7XXXLtadSP0Lh2L01+LWPY09YTsM1ZYe6phTXtX9uCO3EhvyWEMz64gPTcZHIDKg
	 gC6JjxYpJ0bfKUcHsbakEaolfiZuWSjC1A9pWXwzkQbXP4AY4zlBgFn1Yq7REWoV8rSET
	 H9Q2v0JxoqQuyy19Io9gy7JDgHRw0I3VDZg84cBLOyUxetCiFhqBNc2kdzQgeHHMU8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794925873;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UvekSraVUs/lRFGqXqH8GejDXJWeCmrVjuQoEVWrn1c=;
	b=PKAF4VRkM4E9k/iPicGbizmB192nozszzv6lLAiZJln/WqLTlkqKv3nD23/4EIfZzUG9
	 iE/3WQLXycI7bKe2EsPswcaB/6HKIXb8+QaDfAcL6nIUVvyXHoBKlkpnUAFDBNhSdgch5
	 jZomkc9myAPmrf5KI5B2QeEEQLKsLE3DnaBATmrKzzEBMNWXP+TMmk1gUXNc9KN1LpURV
	 2Q+wZ3G7jKxf2hrUCTbFvcyQDVQoS6Ag3erCipO0Dj+N/j8RRhelf6ltKVKbig5o07dO3
	 iWiHBh/XGj0ESs8+486apvy32/sfeGFiZyZrmwqyg90NMLg5B/8iU+tY2q9dX3umQmw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CW3SzirW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794925873;
	bh=UvekSraVUs/lRFGqXqH8GejDXJWeCmrVjuQoEVWrn1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F+A+pknAb3N/RR+Lu9Cd3KYJprUqDUCeuTadOYLqKAoUOSQw9Go2GONLXJFpbCxM9
	 rmqaSVjniKrdpqcC0HmiTp3cHM4ojmEfxMsjTF4UsQvJFB/quqPAyC5GBYzD6jQecz
	 pgMvmjz2uq0a+RSFjcN4LnmRMR/PtTTCrgHg8iEwTYVJBvkc/uLRvXPGuize8kvxCG
	 zo55FZYincsAnemQ77sYIV4+uARiGGpVXNnqPK9Fjz6wFpZ0DDWQk3XcEorcd8Pypy
	 4ZsUajgpGc7egZjBmX+c0soPM9zc61yP+79sDi4SFUvpEkjNYy/z0zTWRqMJkUXy3E
	 vicujI+DR+57A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34192405F6;
	Tue, 17 Nov 2026 14:31:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B9551E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22040405F6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SmJ01nGm8BSS for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 14:31:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DA130405D7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2e; helo=mail-vs1-xe2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CW3SzirW
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA130405D7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:31:04 +0000 (UTC)
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-7d65662077cso3052551137.3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794925864; x=1795530664;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UvekSraVUs/lRFGqXqH8GejDXJWeCmrVjuQoEVWrn1c=;
 b=CW3SzirWJc3PsNVF4OEDWJ6K28gcqxcX2e1MwEB3vDKcX9BFIApQLqz6OgxlSMBiHW
 YBlmQnLiSPCVscD12MjkRD8KCJfmgHoJ2kjxv+XfYFK6qxIjKEFKPzvcPXSmrvmAisHZ
 geQ0yDLolgb+BR/M5WPxRP3P9JMFHoLCAHZbWQDHtgSOqUG35vEwkzng1j0ZyJntEcCQ
 DZ+eTYwSqwycOeiaiBjIOJGydgb6/HnUn1fJlI+ObAuc/18/yUMUluzQOlYN2QE7xzLH
 Brsh6DpavEWZ2OqqIyXpwukiwg7NflUaf29qmKyMp+n01hv7TIqlJKOIRLoUXNUvhXsp
 TbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794925864; x=1795530664;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UvekSraVUs/lRFGqXqH8GejDXJWeCmrVjuQoEVWrn1c=;
 b=kWc0t0MD4lA0m3QCOgD9dLI42xIgLS0ki4x6p6gC6cqisNt3OVDIMpG4rI8lODEFm6
 5J3X65XilpehsAjpUwZlBwAMi6FisJHA6+6rXIqXXs4+jP778VX3SiwBd+z+oheZtkjQ
 xejxweZ84+H9BjcodDOvOvmtl0OydJag6APiINS9prAgKaEUCUUndplQ87mMo4MdMq29
 eQO94DHzi+yx0ac48RX1LnFy3HjCkeVt2nXlk0CP5E1Qb0YWeREQgXftIctOAxXZpZ27
 iHhTZeV4BPuGWTqhq1rhlnm6CIBhrvSJwWzNCWHRICNDuHNPp3b+JtTnWcsHkmdTJ2LQ
 4Seg==
X-Forwarded-Encrypted: i=1;
 AL+hErHhDffUGO1gpIxhNtSR2/zFvwlgnwVpbv1GDYaLXLCIPXtqZF/lM2LCcathKUVa13KSHW8pugg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+tAEG/sETg6QLNsy5McqHCWq3EqMS6bw6/h+AP3k1RFvHolCeY
 I8Q8wngAV28fTY0FniGckXfG6SejAacB9S7vGRfjTKmf+tjmH8ZJE9tJ8g439Nl7qO0=
X-Gm-Gg: AYBFou0oPaeNjedHCJYDxUwGuImQYGU60MxU4DpNKyngwUvYQUjojCIr10hyFmOYPWX
 JbI10o9M4b5BL2xGPBuu9ONsDHVYAX6Y/5BWTbBdndXvnWlK8d3ajQmoeaQfysTFszu38I7p6Av
 Op+lujj4AdmZz+8y8e7awDSTDYkBE3qLEHUnLr0VHRI4XVDsl/deorVEvDlQsibTzaPN5/P2tNQ
 KvxmHfAJV0ZejilC6if6Sqy0IcjKT6VWwI0Ycb9Uscra/WxMTMjFwnvaduKiGyWwJU5x85EnUSF
 or6Cx0czwP73i9eAU25ftoBpQUbIQinmoCXrnvdDmeQyR5OTtt96rL8Z2wQ9LcfnCAl6vId0lSN
 U24LUPU70SPcO1ra7KTIGfi9UFZYN9VdtOkKWIkxyc6uWFvJVUBjgVb6iMXXTQ1KSLpoM910wAr
 82DkveftxRen6dwxIDz638P/kKlssMNjxtB9B1NxgYuy+zWL7ESY5ykWnszrXQQ6b3U1WQyTRZ0
 BxseG0GSm/fan03dAVNtY4wn4DWUQMuB3sIzgEhSX/UOsUYN1PEWET5VYW5tahJR2iWXZXQFrG/
 8803yWkm67uETxAsNsmSqxovDa01Uh98bXz3ePi32YuuVFY9tPR/2SuCeJfCoVT4d6aJnnB8x73
 Rhdt+
X-Received: by 2002:a05:6102:6446:b0:7ab:af4a:f2f3 with SMTP id
 ada2fe7eead31-7d64d85ce1amr5520721137.26.1794925863568; 
 Tue, 17 Nov 2026 06:31:03 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c3c:99a4:6f4a:ad27?
 ([2600:8803:e7e4:500:4c3c:99a4:6f4a:ad27])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92104435204sm12998586d6.31.2026.11.17.06.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 06:31:01 -0800 (PST)
Message-ID: <273552c3-9bc2-4b60-9a9d-6d6082369fe9@baylibre.com>
Date: Tue, 17 Nov 2026 08:31:00 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <4adb08da-1ab4-4849-9001-f0b54065b5d0@cherry.de>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 6:52 AM, Quentin Schulz wrote:
> Hi David,
> 
> On 11/16/26 9:42 PM, David Lechner wrote:
>> On 11/16/26 12:45 PM, Quentin Schulz wrote:
>>> Hi David,
>>>
>>> On 11/16/26 6:17 PM, David Lechner wrote:
>>>> On 11/14/26 3:16 AM, Peter Robinson wrote:
>>>>> Hi David,
>>>>>
>>>>>       > Anyone who has worked on hardware that uses a devicetree for the
>>>>>       > hardware description should know the mantra "the devicetree describes
>>>>>       > the hardware, not the configuration"
>>>>>
>>>>>
>>>>> Thank you for this, I never agreed with describing these in the DT at all.
>>>
>>> We probably should do some digging on the mailing list because I believe this was brought up back then. I also disagree (mainly because the Linux kernel will never agree to this in upstream DT, so this prevents us from the dream of running pristine DT from upstream). I vaguely recall there are a few things that are binman-specific and available at runtime by parsing some stuff. It's very vague, because I don't remember. But I wouldn't dismiss binman use of the DT as simply being a configuration format, I believe we use some of its things at runtime too.
>>
>> The two users of binman nodes at runtime that I found are lib/binman.c which
>> is only used by x86 AFAICT and board/BuR/zynq/common/board.c (to locate the
>> FPGA bitstream).
>>
> 
> Maybe it's worth checking with the board maintainers if we can go for another mechanism so we can sunset binman nodes in U-Boot FDT entirely?

That would be ideal.

> 
>>>
>>> EDIT: ah I see now reading patch 6/10 that you're aware of that. But phew, is it really worth it to do this incomplete split? I fear we'll split the ecosystem once more.
>>
>> Which "split" are you referring to? File format, file location, something else?
>>
> 
> My understanding is that few boards will need binman in the U-Boot control FDT, due to needing access to binman nodes at runtime. Most won't, but the fact we cannot fully migrate means we need to support both forever, and then we increase complexity for what benefit? For the sake of "correctness"?

The one ARM board should be easy enough to find a solution for. The x86 stuff
will be harder since that was all created/maintained by Simon.


>>>
>>> The code is extremely convoluted. Fortunately, there's good test coverage, so doing incremental changes and still having the various tests pass should help refactoring stuff.
>>>
>>> Type hints will be an issue as there are some (notably list) that were added only in very recent version of Python.
>>
>> The typing_extensions package helps with backporting new typing features to
>> older Python. And with `from __future__ import annotations` a lot of it isn't
>> evaluated at runtime anyway, so shouldn't break things either.
>>
> 
> I'm telling you because I had issues with scripts in Buildroot requiring a new version of Python only because of the list[] type hint, c.f. https://lore.kernel.org/buildroot/8636dc29-19d0-479e-a48f-c0f67fb7a3bf@cherry.de/
> 
> I briefly looked a few months ago, but couldn't find an obvious way to make sure we don't merge code that cannot run on some versions of Python? An option of course is to have multiple containers with multiple versions of Python and run the test suite in CI to validate it works on all intended version of Python we want to support, but I was wondering if there was something less of a hammer-approach than that?

Binman already has 100% code coverage, so running it with the minimum
supported Python version should be enough, I would hope.

