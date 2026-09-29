Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AD2CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 23:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B71440824;
	Tue, 29 Sep 2026 23:24:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MJfz2kgKMeLG; Tue, 29 Sep 2026 23:24:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E5132404F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790724271;
	b=hJHgCNTcivb47/iFF8YqgZa3pXamAGFOXMTRFZ9f8S9AH0qnVvuC+F/MkRox09u5Vo86
	 KR1yNQ73St5TutJ4NLruaSfgWJi+falR5Sw4HwBwnMVQy1dLIOLryQ4Adu9o2/RYYhY30
	 5RwIzAluotoCAyVcT98a2+LSJMq0oCFKIixMJu+5fzNkDJsyORDAPa4Ij7CYggRUIGxJ+
	 GzBrSqafn1Oj0pPvEO9yeApqoPCLgLUz2V0cq/kF8tMaChBSaNOySzPUyv17lLK3HKWtj
	 Z2V0YyHWvurE8ra9k9ZsDp6iob3oFv92vCRjfV4VDDeXGoV+dRGRMF+H9Dodmu1rO5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790724271;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Zig4u6E8aVUnNLmHxN/n96V3wX/y+pbT2LsSE00jpZQ=;
	b=bwcUbRbEen3FMwYYJb3VD9Wyqwf2C5CPM6Ply8Z3THHZ9lqOUIa7Mnxg4AFpAkiheBcD
	 jbiCBDxGFpJ1i0/iwdKzwSiDerw9iiX67pHbHjO70Oh9uh9k8UeP0pFquVa7XLbOBqGaz
	 yZw7REvruTrd6FSUbvowxcg4T+UjuJEc2Yvd3XcqQCxxdNulmI6Q50YwcgRHt26DH49Ie
	 uPS//l23Bf/yhkB0Rq4yLHaF5QZ7N8PrvzpIdfe3xS6e73rf3Cwd8jcWd2yA1ZTjQxHHH
	 r2EGLlY/qNBqRuAdIzEFqgAPGxHboTObvYFGFRI3gDC9hCi2CYVBfBUQXOJbxVfk/sw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790724271;
	bh=Zig4u6E8aVUnNLmHxN/n96V3wX/y+pbT2LsSE00jpZQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N6MHBLJjGLGIZ3JUhvAHtrv3tnV9ELxyZ7b8CRYXK0x0VztmGFF1Nvnc9DmoHmrTx
	 9MY0q/0N5fBIqWZzWmNtI1et0VLYY0VMASbBB8K1+PQ0wyNkcf0ZBJYznRlql7F1Iz
	 5od+nidP3LcRTNhRaeWIlSscDEsKXFOVIq1+cC/s8MupZdh7NSDXKv7DzF3kRuDiF5
	 7/KwLtNrghLHEaYyWYNUki+c6wnKNyesegTb6fbxt0eeT2zah7XHAf/ruIEdmfrIzn
	 Pqzdx8hoJ3UWth76L/lUsPb/i5w2IuoL5uoxrrM/+Q0ympfagt4Ky6HHkvojhChgNT
	 +44SziIqUzzdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5132404F6;
	Tue, 29 Sep 2026 23:24:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3965933B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AB3280FDE
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:24:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Di4gnNBSsymN for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 23:24:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AE9FC80F90
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790724267;
 b=GfJIV/clCjm3vE6hQb7QYhSCQ3uEiUVFKFYqOQKLf/MWM+njk5di0Nts7xn6ZFxr+yRA
 Ya+psRVlfC77joDjTH6NlRDQKbtgd3vPWYUWOOpCPGBYyO6Mc8c+a+PrvtHlEOBWWggEF
 Ne3jG8L+6kwvnLylUZNyS3qTxUt0ndn5OsFv6/aAeXwIRxYU7zh5TI0eBBZ4v0vWsNSKh
 J4+4Ycw925/NmA9+nI/tIV8+DaCouWf7yRf3zQd5yNdyw3ymOJT9osfS4rBEsuctlMnGp
 axFkTKOVH/h4xsjLkG+KzHLOYZjcKKI0JNVnNmvN0OQtqm/xAlObWfzyrThIOFPSfVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790724267;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=Zig4u6E8aVUnNLmHxN/n96V3wX/y+pbT2LsSE00jpZQ=;
 b=UEgPH70+8Ul1/bJqJLjMf/yiq2LcvwfotsjFwBzSjhv1SbeZooxu46n34MUlHX1Ts1FP
 SbT3zOgQhWadhR2vYQkfbf8Llu4tYbGHGhWn0hJ4tfADAQflio4g/QdY2ooJSAifcZnXO
 /icG1HInHXKBbop7GbK7zX+51orWu3mdxGmcsusXWOJdkzgT2TIZPth/1UsGXLZISAet5
 g16bi7YXLkqN2yVvUZpEo+KwQhajqWTkQIJ5Eh3u+K8wkWwMYQ5jGSTdLGmBPNLuBCOlN
 WlgBwwU6+blNjvTrNwaWDJKNXSzaDZls+PQCXmEktDw4GudondzRxrAe9VXWmYH1biw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="lOEQaK//"; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=lOEQaK//
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE9FC80F90
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1790724257;
 bh=Zig4u6E8aVUnNLmHxN/n96V3wX/y+pbT2LsSE00jpZQ=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=lOEQaK//Crt8o+WjkaweghZ8BUPBxWuiXKp+HvV8NEtoczDfmhpKmjru+SVSmNHsG
 9/rD4U+LLvY+G8RBNJzI2CsaMDmDeh+t9ZxM1jRk2ngukXQjKSLLCYdN1XkZQjHwZ9
 gO2khEa41SE3pD1pcRPrtAJrepk+nYwIOjS1MDpWyvOF6aT5MzwGjOe1+uVQQq72sL
 D3OOs57dwfIMYATlSoCTdc+8wG48u4rkq4foaftaFZKGA6LeAQdzdKK7QsWB6hJtbt
 dlTiLKdv2qgx5pUMiwGikRHPn9rV6uNnQGdBAD3DnJb8r3qB0WNloh5IJx+O53tj66
 BCQE7264FcGrw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A122AB220AE0;
 Wed, 30 Sep 2026 01:24:16 +0200 (CEST)
Message-ID: <2215a15e-f8b9-427d-9321-2fd1283962ee@freeshell.de>
Date: Tue, 29 Sep 2026 16:24:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] U-Boot v2026.10-rc5 released
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260921221325.GF858934@bill-the-cat>
 <e97b4f04-6cb3-4dcb-844b-ae49c72ecb7e@freeshell.de>
Content-Language: en-US
In-Reply-To: <e97b4f04-6cb3-4dcb-844b-ae49c72ecb7e@freeshell.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Tom, P.S.

On 9/29/26 02:43, E Shattow wrote:
> Hi Tom, I found a regression going back to sometime after v2026.04,
> 
> On 9/21/26 15:13, Tom Rini wrote:
>> Hey all,
>>
>> Once again  it's release day and I have tagged and pushed things out.
>>
>> Things seem to be working well on our new infrastructure but if anyone
>> has found issues please bring them up.
>>
>> I believe overall things are looking on track for the v2026.10 release
>> itself, and things are moving along in the next branch at the moment.
>>
>> So, the git tag has been pushed to
>> https://git.u-boot-project.org/u-boot/u-boot and the release itself is
>> also under https://git.u-boot-project.org/u-boot/u-boot/-/releases/
>>
>> We're continuing with a community meeting following the release and the
>> calendar link is
>> https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=Z2IwbHR2NjZhMzZkOThqNHJoc2sxZG04MzJfMjAyNjA3MjhUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com&scp=ALL
>> and once again this is the same time as the previous meeting. The
>> meeting details itself are:
>> https://meet.google.com/jwj-pqka-bnj
>> September 22nd, 2026. 9am (GMT -06:00)
>>
>> To join by phone:
>> Or dial: (US) +1 929-277-5781 PIN: 115 674 167
>> More phone numbers: https://tel.meet/jwj-pqka-bnj?pin=2145803234090
>>
>> In terms of a rough changelog:
>> - Platform updates for Renesas R-Carand STM32
>> - Fixes in our NVMe, PCI, networking and DFU subsystems / drivers.
>> - A few other assorted bug fixes / hardenings.
>>
>> We should have one final rc release in two week, prior to the final
>> release on 05 October 2026.
>>
>> Thanks all!
>>
> 
> U-Boot fails to boot EFI/BOOT/BOOTRISCV64.EFI from EFI System Partition
> of USB storage on Pine64 Star64 board. Config is
> starfive_visionfive2_defconfig and OPENSBI= path is to compiled OpenSBI
> v1.9 'PLATFORM=generic' fw_dynamic.bin
> 
> -E

I've identified the timeline of this regression as the merge of -next
into v2026.04 for v2026.07-rc1.

Please apply the fix [1] for v2026.10 release

1:
https://lore.kernel.org/u-boot/20260929230758.616924-1-e@freeshell.de/T/#u

Thanks,

-E
