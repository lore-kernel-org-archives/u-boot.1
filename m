Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEFEC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 11:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 780CA80DC1;
	Mon, 24 Aug 2026 11:34:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2UGuxJPXk-Fa; Mon, 24 Aug 2026 11:34:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787571297;
	bh=MTdVFBQA8kRPeGAPuTwdWbLXwsu+yiwOWD+wvoqll3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UrP4/9uaJZDtybEscYgFEj0JxVza04tmznGGj26s/4kngHo8hnzgRKLLNnlGFN6j7
	 hGxeq9r5FFjaIWIFvWFOdA+VS5YoGz6BP27Cvm9XJsNZKQtGs+2N+L3F8JCXG6iMV6
	 xBWtwtZn11jSaNnPZL72sYBjiykPqCb/QQjUfPbqqw0qwiay5Er57Jv3TvjwbX0T5i
	 NneREDXgfD5lOCvhtGROAFq745vq1Qi5gUFW3gsNknYu58s1mNGSwb48X9Oz6xcpaI
	 XPd6Sbm5ZsLhUkbQZWOWg3nhmvc/Lq7kI1Zijpfn+4gcxpED1BO9rEnCfW/3abY/T9
	 G1L1S3Mb9eFfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0A9C80C09;
	Mon, 24 Aug 2026 11:34:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BB8F3AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5DDF140159
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bBa_aYxGx-gl for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 11:34:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a03:4000:b:d08:14a9:1bff:fedc:75ad; helo=mail.kernel-space.org;
 envelope-from=angelo@kernel-space.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=kernel-space.org header.i=@kernel-space.org
 header.a=rsa-sha256 header.s=s1 header.b=f51zhK+v
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 435174014D
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1787571292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MTdVFBQA8kRPeGAPuTwdWbLXwsu+yiwOWD+wvoqll3w=;
 b=f51zhK+vxWVXe3GmnhBEfhV9Y3M8L2vdbPC6p4RoPtrMXU1sLhBLoRMWd4aPrqmjCozw0Y
 SfguGtx7FqjKX5HGmQfZrEvN4ZQsE97UAMmgPmoc7DurnGsD14hEruYMm5a53tf0K8CkNq
 RqGq0pSX9LZVY5nldW4eFbgOAWcOB5k=
Received: from [192.168.0.2] (host93-7-32-195.dimensionesrl.eu [195.32.7.93])
 by oreshnik (OpenSMTPD) with ESMTPSA id 29dd0436
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 24 Aug 2026 11:34:52 +0000 (UTC)
Message-ID: <9d95447d-0786-4bf0-952d-15543a58ab38@kernel-space.org>
Date: Mon, 24 Aug 2026 13:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Clean up emails from non-existing domains
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 git@amd.com
Cc: Andre Przywara <andre.przywara@arm.com>,
 Aristo Chen <aristo.chen@canonical.com>, Daniel Golle
 <daniel@makrotopia.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 "moderated list:ARM STM STM32MP" <uboot-stm32@st-md-mailman.stormreply.com>
References: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
 <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
 <f7c4c39c-f45b-4a02-922f-4d1474c14cc2@kernel-space.org>
 <14ce91df-4a4a-4b29-977e-d8a5837e8242@amd.com>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <14ce91df-4a4a-4b29-977e-d8a5837e8242@amd.com>
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

Hi Michal,

On 8/24/26 13:16, Michal Simek wrote:
> 
> 
> On 8/24/26 13:10, Angelo Dureghello wrote:
>> Hi Michal,
>>
>> thanks a lot, i should do it for m68k.
>>
>> Acked-by: Angelo Dureghello <angelo@kernel-space.org>
> 
> Good that you acked it but don't you want just fix your email address?
> Or all of that files/boards are obsolete and pretty much should be removed?
> 

at least "sysam" boards, they are not obsolete, working actually on stmark2.
There are some quite old NXP dev boards that i am still trying to maintain,
still on market or used market.

My company name changed some years ago, and i forgot to update all the files.

Yes, new email "angelo@kernel-space.org" may be better, likely mandatory for
board MAINTAINERS case.

Let me know how to proceed, should i send a patchset for all "sysam.it" references,
and you remove your changes ? Or i can fix this later on.

> Thanks,
> Michal
Regards,
Michal.
