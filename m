Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A515BC5475B
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 21:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDAF87EE6;
	Sun,  3 Mar 2024 22:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="wfDE47Sx";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="O97xrIRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DEE787F31; Sun,  3 Mar 2024 22:59:17 +0100 (CET)
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 292B883414
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 22:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id f23712b4;
 Sun, 3 Mar 2024 21:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=UF
 Vd2jdHQaI1zxBbC9TLlshEnjk=; b=wfDE47SxgG1wbpMOWFJ7uMFvSeCvF26VRS
 2rN8O6PDgBhw0Rn1fwa+pdgg98bDeuTtmzFh2ISO0AbseLsAA3obfxmZibLDRkvj
 oMXU2xiFVC6veb+2p82WDylhe74vKkxLTGcUyczy/4VPnpgYU6Ib2tfXmcW+IPz6
 AFwQd9SXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 DNYAmDUuO1u+WYHUHKVAA0YfAtr+9aLX0Nc+V4ujrp5UKiGkKhTcsaKjwQ2IeDAU
 CuCOWh6cNsmHji9D1WqpN7EXUjkEqY45FbCIXgF2nBfk25xSy7MttoZitWryuIMB
 yohz40HOzVJ+3cAJ5j5w4Zk5yUbeqm3nZS71V8YaXyQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1709503009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E51gSW7qASfgoCWO0eyOutEF8k7M6wAy1POby2Lw3yI=;
 b=O97xrIRfWmzxLIHhHOBz012eozBeEBOebz9P4UZLZAS0PX3bvVvpq5LXmOjTTEU3VxWNZp
 QgOVY9/iLX5UFrssCgdKiaildo6YcTZBQtDB1f/6J/LdG3G2+1eCIm/5yKAocHGvZkWU5T
 vbLoIIG/xbAaT2TbzfwOwg9Ypk6Z7wI=
Received: from [192.168.0.101] (host-79-50-209-47.retail.telecomitalia.it
 [79.50.209.47])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 1859a0a8
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sun, 3 Mar 2024 21:56:49 +0000 (UTC)
Message-ID: <bd0b13b0-0554-b280-a40a-17056a1e2c5e@kernel-space.org>
Date: Sun, 3 Mar 2024 22:58:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
To: Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com,
 Marek Vasut <marex@denx.de>
References: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
 <20240302151813.GA1652651@bill-the-cat>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20240302151813.GA1652651@bill-the-cat>
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
> On Tue, Feb 20, 2024 at 01:11:38PM +0530, Love Kumar wrote:
>> Add a test for reset commands which performs resetting of CPU, It 
>> does COLD reset by default and WARM reset with -w option. 
>> Signed-off-by: Love Kumar <love.kumar@amd.com> Reviewed-by: Tom Rini 
>> <trini@konsulko.com> --- Changes in v2: - Set bootmode through 
>> boardenv if modeboot is not defined Changes in v3: - Fix the issue 
>> with bad pattern found on console --- test/py/tests/test_reset.py | 
>> 61 +++++++++++++++++++++++++++++++++++++ 1 file changed, 61 
>> insertions(+) create mode 100644 test/py/tests/test_reset.py 
> I had hoped this was all sorted out now, but both this and the saveenv 
> test cause qemu_m68k to fail now. See: 
> https://source.denx.de/u-boot/u-boot/-/jobs/791635 
looking into this.

Regards,
angelo


On 02/03/24 4:18 PM, Tom Rini wrote:
