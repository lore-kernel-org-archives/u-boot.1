Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD78CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11A5B405DE;
	Mon, 12 Oct 2026 17:02:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k7xVmIqnlfaS; Mon, 12 Oct 2026 17:02:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61A7F40553
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791824576;
	b=HS7nUr9dcWcp3Ry2g5VFanTZRlVhTYYOHrCBudwYLYC8QIUlq2AmkQ4kpPm85J65iI30
	 OUGH+V5YibfZtAOvF0ju5ifJMLwuzHBHCpT56w7jOVsQB8gdgP1BsUQqlbKrbeWsNSQcV
	 YZ2k8DMpwfsqTJYFaKPU+bt1iIG+eekn6GHi1HmRqMOYGliMj2s19YGu2C4Q3jdngj5yi
	 pf7ddNp2AYNSMv248TI/qjda0sszGm+uOFq5R4jPWhFTrzkKxoMKQBegKRU3+qAcmOZel
	 OJ9l3IfEhWVRIQNWblsoid7EuoN3xPhKninHbnDPuTzSrBFhxGWlc8+4vtaD/e9ZU4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791824576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=R3RrxDxGMuhgZmvHMjPSrddoahGwUJ9xZ6lY8aaNySU=;
	b=mjhhHSBisbuvEUWr75M0nqt77o0r+HsjCW4/ECEiw4vn9TWEhuyxQoR9PjUsW/XnM6cT
	 IvZ0FtpEy+h6O9U51Uym66AL6/z1DOV+DBq7Yli4H+ZAbxIWJ7aw9muMuF6EErrFwzNt9
	 vR/qf7cEyG/ulsi/uNbeL9EaAoZKDt0MsaMG/pvMnYv+QcLhhel0FvO1ClpZQvyO7Sxr3
	 fAvc5cKIe/8vartZuoimTV1gfSFuNwpffigY84c9EsGAtD15T/qvXGrBGriK6SBCJ4vsj
	 y4Kc0XfKVVl9rXM28e0pOA4WFcJcI3eDQKonGiTseuh3s5rHTsFwdgp/Lm31YvZct4Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791824576;
	bh=R3RrxDxGMuhgZmvHMjPSrddoahGwUJ9xZ6lY8aaNySU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yVQj1ugZymNkOHOX4WAoiUT6eKWtl3dDFYA64vz89J8ryliZN2j5vhO/+jt+Kroh3
	 jiz1u6NwTnIpXn3b5jWit7baSFebPe2vHTpnBUWmUf3nX/7XB5WBLA8uSpkTI+r0iJ
	 222vToxpn3ZivK8kLmF7B1yRbQDgCRc8wl9a5ICiH7LY/1QTzHIfvYMnzmY2sSATd4
	 Nm0MHz9Pgq9Q1bkAgaL/9EqNx90tVsUpNHbi/yCoeD3SqkxfDytrQY1UxmDe9j5PWZ
	 IQ/bC+8cYdKvrHbrmfL6B58gCfM1X/KGvELvalePx8EQOErHCkN3/ZYLqvkYzIBno8
	 2W/jFGpMd/chg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61A7F40553;
	Mon, 12 Oct 2026 17:02:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 633D72E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 554C860670
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXqyL8f3TtNb for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 17:02:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7AEE060600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791824574;
 b=i6eZaFUfJOoWp+ngdmZCRKaRlvClf5+oUTcLSmZ8lmJBD2Fkk9k2frkiUi8Lb96BkQlf
 Z+OGkWOI/J3xR03lYHoi1rCYkrVXIY0BTaWqhGEJJ4Db9bUUhuKY9shvJ1Ugo7HFphoiq
 VvtpbrpiuHY1WuecU4rIgrViZFkRh6TmJTAra3LmCWG+mnBqgkN+qRwSZD0L/7jOnR3jX
 4lmz71dnKfQ0Ym+cS4GtxSKD60iXqPp7dy/EjAmHzAwryu6/5xubKuQJHfnLLFiSrLuFd
 17dyghTeFnjA0wPlSsqEQhfCB+BqDGPnY14Z39jEHvrx9UPwzr1dVU2Hh36vo5KDqgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791824574;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=R3RrxDxGMuhgZmvHMjPSrddoahGwUJ9xZ6lY8aaNySU=;
 b=RMh2QznnY1wPLUxmAEWLmpRE3+QYrX4UvDACyuhrclgvKM/01un8UamMdGl2MPjitEp/
 KpUD2iRogFzxZNcYYAb4h5QMP1XbhJSOlXv0BMg6juSrRG5CJQFACJehorS2eQHzZBHDB
 o05JW0N/HOV98is+/dtZi5cePa0Vl/3mY/Thjwg2ojeB9Hi7oIkRxsQRWlBlgBZOIRxfv
 amO3DXu4eKgx4AG32tmWxZJ1uK+iLD7TbeW4hLI13Ql7zkMAYMjdLen5kHIgzXyF+86Vz
 Ni/vShK0qoPsPvuO3a5hAF21mU4sLenkHpN90Gfz9aqC7mHZtc30JBpZyv9sXkh18Yg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=ABJy0HcT; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d90e=id=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ABJy0HcT
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7AEE060600
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791824573;
 bh=R3RrxDxGMuhgZmvHMjPSrddoahGwUJ9xZ6lY8aaNySU=;
 b=ABJy0HcTz0USJoHWCtOnAfUTZSR+ebT7kuezcnkFxh+i+PYYIDiStHaqpR3ba47wXzlVyxLAs
 dlfkyqWrQacl3H0DTcew5uSubibavV4inYCaxPfX7Wzxfu7gNWTVRoworca3Mq8MaFo2v1vzt/g
 FZQS46XOsaPb1Kkd7wt9hbWDHBjLvW9fqdtsIofZBA8gA2z0BEqTBfyivDGFR7y32ONYmwOcf6p
 8vPk2p/S0Bd9kMeitQyBSUmhXK8IRRlUIZbtAiIEdt3gm4UCR0uj7C/uJ1nUiUTvqKQgzTJE2D3
 eeqtsLqew59Dmcz4bWz4VhNKBBqYcYl4M15nkysZbhAw==
X-Forward-Email-ID: 6acd12b99395ed86e9c4a4d5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <38834bee-36d4-4871-8917-345ce6eb03ea@kwiboo.se>
Date: Mon, 12 Oct 2026 19:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] rockchip: rk3588: Remove unused rockchip_get_clk()
 helper
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-8-jonas@kwiboo.se>
 <af324bde-f2a8-4425-8d57-944ae5567c84@0leil.net>
 <27039afb-0ef4-4cb0-b752-d5083d3cfd14@kwiboo.se>
 <e7d919d0-c6e5-488c-8728-5607aefdbeb6@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e7d919d0-c6e5-488c-8728-5607aefdbeb6@0leil.net>
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

Hi Quentin,

On 10/12/2026 6:16 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 10/11/26 12:55 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 10/9/2026 11:55 AM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 8/4/26 11:44 PM, Jonas Karlman wrote:
>>>> The rockchip_get_clk() helper is typically used by SDRAM init code of
>>>> older SoC generations or to help get the CRU base address from the clock
>>>> driver private data.
>>>>
>>>> RK3588 has no uses for the rockchip_get_clk() helper, let's drop it.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>    arch/arm/mach-rockchip/rk3588/clk_rk3588.c | 8 +-------
>>>>    1 file changed, 1 insertion(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
>>>> index 9b112e45f1de..272d28e973b3 100644
>>>> --- a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
>>>> +++ b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
>>>> @@ -3,15 +3,9 @@
>>>>     * (C) Copyright 2020 Rockchip Electronics Co., Ltd.
>>>>     */
>>>>    
>>>> -#include <dm.h>
>>>> +#include <linux/kernel.h>
>>>
>>> Why do we need this included now?
>>
>> It seems to be needed due to use of check_member() in the CRU header.
>> Will make a note of it in the commit message for v2.
>>
> 
> Please instead fix the CRU header so it lists what it needs in its own 
> include file (separate commit prior to removing the unused function 
> please), otherwise we'll need all includers of the CRU header also 
> include this.

Sure, I will instead update the CRU headers to include any required
header for v2.

Regards,
Jonas

> 
> Cheers,
> Quentin

