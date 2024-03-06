Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5C9C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 23:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED4E48792D;
	Thu,  7 Mar 2024 00:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="h5G3+k1U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="ZdnBWgJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 772D587DA1; Thu,  7 Mar 2024 00:37:25 +0100 (CET)
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A63E78785E
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 00:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 06aa52c5;
 Wed, 6 Mar 2024 23:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 content-type:message-id:date:mime-version:subject:to:cc
 :references:from:in-reply-to; s=s1; bh=zPwiKb3ERI7S1EHc9yQjFDBzO
 48=; b=h5G3+k1UVY+V12iAupHiiOlZ5R6UPQZwNNYyU3FTHLofsODmfR6ig/DvD
 iMFhKQY4RgQKZbsQtUNNceJV5X1uVTrEN4o4GcY9fuXLY7fvjY3UiBOszLzUYQ69
 fUpXyLLsoroQUq4rlzpykqZ5EdDkIQJVLG/WLwQRy0CPcSJJuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 content-type:message-id:date:mime-version:subject:to:cc
 :references:from:in-reply-to; q=dns; s=s1; b=RBr7X/hTYWHqa0yQrZs
 YK4Ve2izJ9ej13DWAK/YCEqKZXZGJSHJoM6zmuuIdnKJ/JwgnWco+oQ79a6tHYhE
 p1xDE1CJ+0VZsNIGI8Vppo+vhi1uNMFxO/AJAORJFurMosmGOkjHwpJkxiNOWzjT
 aMkPjg79jxY3y8whdsPdGwAs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1709768087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mS49dQNR38IIar870Aen2Xh8DEkHJFDxKa2GnX3+0+c=;
 b=ZdnBWgJBqbfkOwJ/qou9A40ox397uMwWS47IscJcMWJffglBlbGmm9Vs3/AKbHs9Ip/Joc
 2eupwQ/4Vqix0Mk/i+yAYdHsez1a5KwxACZh3SCwrWyH4/xWJxrorrRRLm6IA9JdxoYwwo
 91Hzq1ii2zLo8mfItMOrze6OLae89B0=
Received: from [192.168.0.2] (host-79-51-238-97.retail.telecomitalia.it
 [79.51.238.97])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id cbfb3715
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 6 Mar 2024 23:34:47 +0000 (UTC)
Message-ID: <c523aabd-93a4-f9db-2726-7f912a85aef0@kernel-space.org>
Date: Thu, 7 Mar 2024 00:36:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
To: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Marek Vasut <marex@denx.de>
References: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
 <20240302151813.GA1652651@bill-the-cat>
 <bd0b13b0-0554-b280-a40a-17056a1e2c5e@kernel-space.org>
 <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
From: Angelo Dureghello <angelo@kernel-space.org>
Content-Language: en-US, it
In-Reply-To: <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

On 05/03/24 1:34 PM, Michal Simek wrote:
>
>
> On 3/3/24 22:58, Angelo Dureghello wrote:
>> Hi Tom,
>>> On Tue, Feb 20, 2024 at 01:11:38PM +0530, Love Kumar wrote:
>>>> Add a test for reset commands which performs resetting of CPU, It 
>>>> does COLD reset by default and WARM reset with -w option. 
>>>> Signed-off-by: Love Kumar <love.kumar@amd.com> Reviewed-by: Tom 
>>>> Rini <trini@konsulko.com> --- Changes in v2: - Set bootmode through 
>>>> boardenv if modeboot is not defined Changes in v3: - Fix the issue 
>>>> with bad pattern found on console --- test/py/tests/test_reset.py | 
>>>> 61 +++++++++++++++++++++++++++++++++++++ 1 file changed, 61 
>>>> insertions(+) create mode 100644 test/py/tests/test_reset.py 
>>> I had hoped this was all sorted out now, but both this and the 
>>> saveenv test cause qemu_m68k to fail now. See: 
>>> https://source.denx.de/u-boot/u-boot/-/jobs/791635 
>> looking into this.
>
> Is reset implemented in qemu? It should be skipped if it is not.
>
yes, seems not implemented

=> reset
=> reset -w
=>
=>

Not finding any trace in the qemu code related to

out_8(&rcm->rcr, RCM_RCR_SOFTRST);

Regards,
angelo


> Thanks,
> Michal
