Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A1BC54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 08:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38CFC87E03;
	Thu,  7 Mar 2024 08:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="EPEzpvfA";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="zdDMR/m2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D0E87B7C; Thu,  7 Mar 2024 08:57:10 +0100 (CET)
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6102787E03
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 08:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 1a2b9d17;
 Thu, 7 Mar 2024 07:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=Hx
 svi0ikhKnW3kLvvb4QccH9OcI=; b=EPEzpvfAA8eGX+For/TEf4EpzThGKbrEQY
 Api3JLD/LQdahf+47gHdRpyUxDckWMIiAlmgdUpwKzlefkLBbp0kqFTId3SA28Fk
 +EP0paeUHApCkiPkSmUuX3W3dxw4WpJtLW8sT0uuYGZvRr+xAcAckMBdKg6OIDlC
 /jlUcoIGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 buhTUF5+agEFUWN+KebgF8HVpKB+cVW6lVnBXW1TGw5WEf/dFAUd0b3CW06cJdI6
 cVM7RTifuk5tca9Imy26bocXjewr4DKveIWRktqKwz2guBwfo2vdhzWW01w/9gQd
 GPpUBJNZAJKacx24Jsdkm8tc6qWWmAaOqwFbUj8PGo4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1709798065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9J7jC9zzZTj1vdU67t6A+ZSu3UplaIOvVoO6Ch6SmE=;
 b=zdDMR/m2XTBIWjc13/XXi/i1AQqYmMBg/Y3eNv/5dWACDNFSQXXkZ7P2pyEwr11nzMpWQr
 /CvFYs9D2xAbxCJM28uWl7uOMfHv17DKT7O0WxMl7J4x5d7tKZg/mB9xE2ByVi1X8K0a1Z
 btTALdQYvZgLUFHvJnzWQpPHHgLSyNQ=
Received: from [192.168.0.2] (host-79-51-238-97.retail.telecomitalia.it
 [79.51.238.97])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 88ec6ba5
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 7 Mar 2024 07:54:25 +0000 (UTC)
Message-ID: <c05a25ca-d4b7-1179-cf46-645bc4cdba89@kernel-space.org>
Date: Thu, 7 Mar 2024 08:56:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, Love Kumar <love.kumar@amd.com>,
 u-boot@lists.denx.de, git@xilinx.com, Marek Vasut <marex@denx.de>
References: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
 <20240302151813.GA1652651@bill-the-cat>
 <bd0b13b0-0554-b280-a40a-17056a1e2c5e@kernel-space.org>
 <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
 <c523aabd-93a4-f9db-2726-7f912a85aef0@kernel-space.org>
 <20240307001053.GE1523872@bill-the-cat>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20240307001053.GE1523872@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Tom,

On 07/03/24 1:10 AM, Tom Rini wrote:
> On Thu, Mar 07, 2024 at 12:36:42AM +0100, Angelo Dureghello wrote:
>> Hi,
>>
>> On 05/03/24 1:34 PM, Michal Simek wrote:
>>>
>>>
>>> On 3/3/24 22:58, Angelo Dureghello wrote:
>>>> Hi Tom,
>>>>> On Tue, Feb 20, 2024 at 01:11:38PM +0530, Love Kumar wrote:
>>>>>> Add a test for reset commands which performs resetting of
>>>>>> CPU, It does COLD reset by default and WARM reset with -w
>>>>>> option. Signed-off-by: Love Kumar <love.kumar@amd.com>
>>>>>> Reviewed-by: Tom Rini <trini@konsulko.com> --- Changes in
>>>>>> v2: - Set bootmode through boardenv if modeboot is not
>>>>>> defined Changes in v3: - Fix the issue with bad pattern
>>>>>> found on console --- test/py/tests/test_reset.py | 61
>>>>>> +++++++++++++++++++++++++++++++++++++ 1 file changed, 61
>>>>>> insertions(+) create mode 100644 test/py/tests/test_reset.py
>>>>> I had hoped this was all sorted out now, but both this and the
>>>>> saveenv test cause qemu_m68k to fail now. See:
>>>>> https://source.denx.de/u-boot/u-boot/-/jobs/791635
>>>> looking into this.
>>>
>>> Is reset implemented in qemu? It should be skipped if it is not.
>>>
>> yes, seems not implemented
>>
>> => reset
>> => reset -w
>> =>
>> =>
>>
>> Not finding any trace in the qemu code related to
>>
>> out_8(&rcm->rcr, RCM_RCR_SOFTRST);
> 
> Does reset work on the real HW, or can you not test? What I'm wondering
> is if we have a missing feature on the board/arch code (and should
> disable the reset command) or a problem with QEMU.
> 
I don't have the exact hardware (m5208evb) but:

1) i checked by tracing that on qemu the reset function is properly called

=> reset
resetting, RCR fc0a0000

2) reset register address is correct. I checked also that writing 
directly to it by mw.b does now produce the reset,

=> reset
resetting, RCR fc0a0000

=> mw.b 0xfc0a0000 80
=>

So looks not implemented in qemu.

3) testing reset on similar mcf5282, real hardware, it works

Regards,
angelo

