Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E554C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 07:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D347F87825;
	Mon,  4 Dec 2023 08:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701676622;
	bh=R4Wlk5SIpPMfhgjTjEhOjU10VXGKRXDXzsDyIrBeDAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AYiRBQaSV7fm9TuY6iiOHj1v84Degwbzk1jeNr2RpHfMxUzS8d0OOSKYw9snvlCmt
	 5Pv54qiei1G7LsHKgHFazj9dkRKFMjUqnm2AMDYUpMN6CIJ8O6h5bvHoqghyAO7DwD
	 iKelgm6ALQ70lHYwxud8E1cPvuJ4S3ure9sEwzKc/zQ1Yfrv6XPu0qLVk1fR3NidnI
	 10jKg45FzqY2d7Aj77bxEw1Nm57D4rjuNaO8PWmT/trnTu/QjeufZaQiroWLTQhHuX
	 Mw+Sdm0u7626duVnNn/FQ903lLmnCUp7IkGbm4nLVFPTamnkVfR895CD6ZIe5OsG03
	 xkbI7326LolIA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9F763876A3;
 Mon,  4 Dec 2023 08:57:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701676621;
 bh=R4Wlk5SIpPMfhgjTjEhOjU10VXGKRXDXzsDyIrBeDAY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IlRKNE5co+Gro5+7Il2tZWiNeRRGdyTJDKMuXelci3tK0fwhvp6rDs/bCJfSCZzOa
 ITV7u3qCJRB/i50bqYvW8v5YtzHH1S1DrGMDbCyP1TlHYSND/s7hxpIhfmlOEpoCiB
 JeFPau213D904RTnTH0PQAA6GFGoTHxd8iXAaG6aAe7uqEB5owEpdjXKc2wgibHHK8
 1p1sXJOV10f8knHKVgyFSJzRr0xyK3i5XgszJnKq2R4A6aw1uVFkke9lXwGWR7OYug
 /Ot0bme4CPKq/x7mgmq8XkVhz3y3UMrEbZghRfc1RyojdNrpOAf6H35qYlIlKouEjB
 cqWyTCLf5V94Q==
Message-ID: <e7b025bd-3498-4899-a73e-c55ff7a81f7a@denx.de>
Date: Mon, 4 Dec 2023 08:41:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: mxsboot: pre-fill buffer with 0xff, not 0
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, Alessandro Rubini <rubini@gnudd.com>
Cc: u-boot@lists.denx.de, Rogan Dawes <rogan@dawes.za.net>
References: <ZWy2Chxgz9mRxGQN@arcana.i.gnudd.com>
 <CAOMZO5Ajq2L9-pNLqq0JGUmWdn5Lw=SeQsoZZ1YNYJbC1gJZQQ@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5Ajq2L9-pNLqq0JGUmWdn5Lw=SeQsoZZ1YNYJbC1gJZQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/4/23 02:35, Fabio Estevam wrote:
> Hi Alessandro,
> 
> [Adding Marek and Rogan]
> 
> On Sun, Dec 3, 2023 at 9:24 PM Alessandro Rubini <rubini@gnudd.com> wrote:
>>
>> The tool works for me, with imx28 and NAND memory, but the resulting
>> blocks are reported as bad, both by u-boot and the kernel.
>>
>> This makes it impossible to erase from Linux (for an upgrade without
>> console access, for example -- u-boot can "nand scrub" but linux can't).
>>
>> pre-filling with 0xff creates a proper boot loader image, but no
>> bad-block marker is there when written to flash.
>>
>> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>

Isn't there some kobs-ng or whatever tool it was to properly initialize 
the NAND on MXS ?
