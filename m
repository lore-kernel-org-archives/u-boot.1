Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C8DCE837A
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 07:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F3989003;
	Tue,  1 Oct 2024 09:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="lOqigvSB";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="YctBbnv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 226BF88EF4; Tue,  1 Oct 2024 09:21:20 +0200 (CEST)
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C598910B
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 09:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id a6390c5c;
 Tue, 1 Oct 2024 07:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=7k
 xlARUwxBiflPvy7oDUdcTgr58=; b=lOqigvSBelOOANoBFMdi5jnqV+n+CJSwgV
 bfLQtUQtpNA5Z0+h4ywm76POlBXP4LDH3raZ+5C34GP/Ig3PhWPmw1vNRRs5CMQm
 7nvoDfbEmBuB7TTxbS6mMP2zj+0OC+I7YAbT8WFmaaIa3Mscj+g9TwaJ/yAhvUfs
 HvE2tQYYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 s+BrMz0czywzTdbr8ioDZ7Bmos9Mdi6nKUGSoQQOmco/SkIqbyCRlHsbzJdd6u+H
 pf2mGF1fKHY1BALb4ffrfUHu3kBxQwytcjVnoUkd0fFS3glvIQJYg+UZB+UzYZqO
 BiXZ7+VOXikk1ParoGauDoHp3rYbCGAB2gnQnOBsf6o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1727766855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWkel0DYx35M30NERSHnwXM+CUSNKvAQhh3g/egckZc=;
 b=YctBbnv/HvrjHyc0ZmQVacVQNVdjDDhb+6tmcOF4CiR+m7cysUCy+ssvC+W4izMIyWFbfx
 7TaSDVCRb3aq/D24Pf0wRenwCeREXTlkNML3i4KXs3XqE8HpHN/f213c6nByVG2PTLe/+7
 WSWMgmAAYNmq7QDIKLEE+NYpsPLY3y0=
Received: from [192.168.0.2] (host-79-54-25-3.retail.telecomitalia.it
 [79.54.25.3])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 827b26cb
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 1 Oct 2024 07:14:15 +0000 (UTC)
Message-ID: <884ec3fb-1fe2-4afd-b757-f81734fa9d9e@kernel-space.org>
Date: Tue, 1 Oct 2024 09:19:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] led: Remove old status-LED code
To: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, Alison Wang <alison.wang@nxp.com>,
 Andy Fleming <afleming@gmail.com>, Doug Zobel <douglas.zobel@climate.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>,
 Kamil Lulko <kamil.lulko@gmail.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson
 <sean.anderson@seco.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
References: <20240926223009.1270197-1-sjg@chromium.org>
 <CALeDE9M4DrdsDrJEGehWuXyfNSd1K=sWE8RpSk6W5uySBoGUQQ@mail.gmail.com>
 <CAFLszTiqqiQD3S03y3_g8LDehJ3dE1stONUzm+MWHEDppZCMjw@mail.gmail.com>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <CAFLszTiqqiQD3S03y3_g8LDehJ3dE1stONUzm+MWHEDppZCMjw@mail.gmail.com>
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

Hi,

On 27/09/24 6:52 PM, Simon Glass wrote:
> Hi Peter,
>
> On Fri, 27 Sept 2024 at 09:52, Peter Robinson <pbrobinson@gmail.com> wrote:
>> Hi Simon,
>>
>>> There has been an LED framework in U-Boot which uses driver model for
>>> about 9 years now. Recent work is underway to improve it and provide
>>> more features. It is probably a good time to drop the old code, which
>>> is only used by 5 boards:
>>>
>>>     ./tools/qconfig.py -f LED_STATUS
>>>     5 matches
>>>     eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
>>>     socfpga_vining_fpga
>> Why aren't these boards being migrated to what ever the new frame work
>> is rather than dropping quite useful functionality on these devices?
> I don't have any of those boards, but perhaps their maintainers might
> like to weigh in?

i have the 5282 evb, but seems to have some issues executing code with
a recent toolchain, i am working to revive it so i can perform tests
eventually.

>
> Regards,
> Simon


Regards,

Angelo

