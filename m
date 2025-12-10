Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C116DD3B9A9
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7DF983B48;
	Wed, 10 Dec 2025 08:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="a+EkyVAS";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="UmXQj15g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5042B83B4A; Wed, 10 Dec 2025 08:25:05 +0100 (CET)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 148748352B
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:25:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-6cht.prod.antispam.mailspamprotection.com;
 s=arckey; t=1765351503; 
 b=u/YseMLG2Vxm0owda+osWIQNngOIFjMq1bPHkNTwBi2S9EdGG0HVfntz4hZ7pBd7ZHgKulc0v1
 H2a8mOEbssFySBsA1yX+0VLsai+iiV0ddBlQG2AiZmo7KUipQmrRANG0iovnJL4z5CgE+nA4JY
 uEnKBUyO3/6cjtKMdd+tph70fQKOwv5Qsph04qDcEPRTz4vFlhJ7Zw8zb+xiudsYXopWnOB7Mh
 xZ26oxHlwIZfXVl7LFnWHtuE3FKTXHRz9/0aUID2nvX/3TEmkptY9sydwWNL1mz/k9gCUml7kr
 JlC9/seyQw/eVw5RBcHLAjlOmSPp4/IlhzUOBOXWNdXVjw==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-6cht.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-6cht.prod.antispam.mailspamprotection.com;
 s=arckey; t=1765351503; 
 bh=bg6BuKYZHnxAYVCZt+YO1T9RGbEd6Xf0jkvhRCXKfKY=;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:References:In-Reply-To:
 Subject:Cc:To:From:Date:MIME-Version:DKIM-Signature:DKIM-Signature;
 b=OX9uwxv4O+5t9w07pNBH6xR5Ahjra4fO0FH+vcs8MFRulpbMZluwlGtDYu9bPUXhFJfHrPeYPn
 MZ48UUh+/2wI82LGWtJOV5oWqOHqV8z5LrSfLCqxn3S1DYWrdt2bm2hLpWlS6hoBj9wl/FK2Af
 rOEY4K0seKNSB/ijVSyvnjF66/hvazx35BL1kp1CZuJI6G4WDItAGD0qa7ghg8Wj+R1lkC8dRe
 rUqrrkzFviHE5eHZYZvNfdBL3NYIAxE4GTJa146qVgsZIodjFoFubeLfpxX+lRPhr/O+M7RQ3b
 5JxV4vqv9okeaI3TzAMbuud/SUAd8MTJgKVlBrGdvoKb4g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To:From:Date:
 MIME-Version:Reply-To:List-Unsubscribe;
 bh=noaICbmJlPm8QC7HBo5X8hEkGLj8DHe7MYUE/6hPxS8=; b=a+EkyVAS1C0RXWTRDf0cNtCKC1
 uSrX/sZEUeiRTkDnsTK2GRlEbWk4ZcykwdpW+qGNDINhF/YGRyP3h3ReCbzWAufpvVg5z9rdTwiJ3
 lCrfWFazYxqXl3ZapljtfPNzQsotmaU8EH9SQKZWSpm72UrEQv8n9WYJvTxLzoP4WKlc=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-6cht.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1vTEZH-0000000330y-0ugZ
 for u-boot@lists.denx.de; Wed, 10 Dec 2025 07:25:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=noaICbmJlPm8QC7HBo5X8hEkGLj8DHe7MYUE/6hPxS8=; b=UmXQj15g6r2sM+Wnkv4c2w9kUE
 OQk+GytmzYc6/DIWnMichyT1yggEv3JMN4BG/hwPbNqCvaVyMZYgJUe7c7WlyPpnQ0O1ITdb0tjWB
 sMFT/hC4GSZOIyuPKUyBgIIv7Pmhq3anMHhJiSN1v3Z4HPx1CGnPXA+dgKkDx1laXvxM=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]:34936
 helo=esm19.siteground.biz)
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <francesco@valla.it>)
 id 1vTEZB-000000000GP-0acc; Wed, 10 Dec 2025 07:24:53 +0000
MIME-Version: 1.0
Date: Wed, 10 Dec 2025 07:24:53 +0000
From: Francesco Valla <francesco@valla.it>
To: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
Cc: Joseph Guo <qijian.guo@nxp.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, u-boot@lists.denx.de, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Sumit Garg
 <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Mathieu Dubois-Briand
 <mathieu.dubois-briand@bootlin.com>, Jacky Bai <ping.bai@nxp.com>, Justin
 Jiang <justin.jiang@nxp.com>
Subject: Re: [PATCH v3 2/2] imx: Support i.MX91 11x11 FRDM board
In-Reply-To: <1d79237b-4dfa-45df-a4cc-a01542d3fef2@oss.nxp.com>
References: <20251209-imx91_frdm-v3-0-02303eb0c1c3@nxp.com>
 <20251209-imx91_frdm-v3-2-02303eb0c1c3@nxp.com> <aTiWrz0RMo7umwbQ@bywater>
 <ab525485-eda0-43c4-a305-99b8727d94aa@oss.nxp.com>
 <1d79237b-4dfa-45df-a4cc-a01542d3fef2@oss.nxp.com>
Message-ID: <fe58761392b58d0cd685d75a3e17ce43@valla.it>
X-Sender: francesco@valla.it
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: de4502105122ab91cc6393576169f714
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vTEZH-0000000330y-0ugZ-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-6cht.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Hi Joseph,

On 2025-12-10 06:27, Joseph Guo (OSS) wrote:
> On 12/10/2025 2:09 PM, Joseph Guo (OSS) wrote:
>> Hi Francesco,
>> 
> 
>>> 
>>> 
>>> I also get on startup:
>>> 
>>>      Failed to update cpu-thermal trip(s)
>>> 
>>> But this is probably due to lack of thermal support at Linux kernel 
>>> side
>>> and needs a fix there?
>>> 
>> On linux kernel side, 91 thermal driver is not upstream yet. And the 
>> ft update is a common feature for all i.MX9 series SoC. So the fix is 
>> to upstream the 91 thermal driver in kernel and add it into the kernel 
>> dts.
>> 
>> It is not related to this patchset though, I think there is no need to 
>> fix in this patchset. Do you agree with that?
>> 
> 
> Sorry, 91 thermal driver is already upstream. We only need to add it 
> into imx91.dtsi and it will fix the problem.
> 

Yes, it makes sense, rather than add a workaround here.

Regards,
Francesco
