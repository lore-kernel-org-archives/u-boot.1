Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA829C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 19:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93AE82B34;
	Sun, 25 May 2025 21:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ScMz6aiN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16DD682B37; Sun, 25 May 2025 21:52:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 580AD82B33
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 21:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=671e=YK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1748202715;
 bh=MAfp1sXwUBtieQ2WDoBUz4DQm02mL9rl63sU/Imophw=;
 b=ScMz6aiNI6dup+VwmUxYyP/JzS/k/SDkuaEIoQULot7Gurfpi91HLM0QWsj6d32Jp2oDkzbyz
 d3a9l55m2O0+XOkGmv3XK/YpM/Jy4ap9qn43R8Q0k+s2+BUYTLbZFHeqW06WedMWLev7fHJMr4J
 Wr7w4Hhqfs61Uvni8eDLz+H9NeSSMKoCdAMkuCMmRqaJ1p60+LnYcwb139LNB1xcf1Rb3yq026G
 yGjAR8lBg1OZmhHxoBhuR6C+lybetvLUIFa3P7j39gQlKnA1YY3yKH+9f8De8xDRXhHOIEuPRNr
 805IC5wx3Pf1PjYDl7Rk20Q2hSRp9R7VXLHLgjp0FHEw==
X-Forward-Email-ID: 683374d8a0e3f2dd0ce244dc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d041c823-a258-4d73-902d-350a2aae0066@kwiboo.se>
Date: Sun, 25 May 2025 21:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Broken boards?
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAFLszThbRhKF1Xwqk+hLu8Y-VXB6+fHVXYfphfVjWMN=dVC1dg@mail.gmail.com>
 <20250525135553.GQ100073@bill-the-cat>
 <CAFLszTgPK_TWjoaJPMa6RAH-pugpO_uhkm-VafQLzaNuFZRDLw@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTgPK_TWjoaJPMa6RAH-pugpO_uhkm-VafQLzaNuFZRDLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2025-05-25 20:05, Simon Glass wrote:
> Hi Tom,
> 
> On Sun, 25 May 2025 at 14:55, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Sun, May 25, 2025 at 09:46:03AM +0100, Simon Glass wrote:
>>
>>> Hi Tom,
>>>
>>> It seems that some of the boards in my lab are broken in your tree.
>>> Have you noticed that?
>>
>> Your lab has never fully functioned in mainline, so no I've not paid
>> attention to it and don't use it. I figure it's part of the lab
>> maintainers duties to figure out false failures and
>> more-or-less-expected failures.
> 
> Oh, that's a shame. I didn't know you had stopped using it.
> 
> I use it on nearly every PR. I did once send a patch to disable the
> boards that were broken, then another to re-enable them, but I don't
> think you took either of them...
> 
> Here's a recent run showing a few problems:
> 
> https://sjg.u-boot.org/u-boot/u-boot/-/pipelines/794
> 
> But x86, RISC-V and some rockchip seem to be broken in your tree.

At least for bob, jerry and kevin you will need to change your lab
configuration/scripts to use u-boot-rockchip-spi.bin as the old
u-boot.rom finally has been removed from mainline [1].

[1] http://lore.kernel.org/r/20250505-has_rom-u-boot-rockchip-spi-bin-v3-0-75f23b3bd8d3@cherry.de/

Regards,
Jonas

> 
> Regards,
> Simon

