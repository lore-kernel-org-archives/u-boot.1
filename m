Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25556C072A2
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 02:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE9A87525;
	Mon, 20 Nov 2023 03:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700446198;
	bh=FKMQmFwpbVhLN6t1zUmQJtu3CJn8J6byTrmtRDECin8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bhnSKOZDPqaRgYZp3Kwq4vPHXOu4e40X6hnL0Ks8MFuFqxfa5TnShwyryu7uW3zCQ
	 IVUNcv2TxMYNcA+ZvNEs2qD5Ru+/epIhy4XtSRjl20ye5DGSRg5igsxnwS6K/uv9Q5
	 7wvfLgjPCeaYDRwmw10mBmtxsQQMUbgrmOOZXtfZDytNkeDeVf3xCcg51v+tdC1fjB
	 8Kr587bAYOY38v3S6jyiyW4OWz68I44K7ZwTddFt8+0fGDLk9hU+N7i6tNhAvBMC44
	 EETY/CkXBT9TCGMnxKPZrXISH4Zx2azVH4lIy+xqbjqCDNQ48W4VZxI09Ft3hGxVlE
	 WjvVmwGiAbJsg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 291D886EFA;
 Mon, 20 Nov 2023 03:09:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700446196;
 bh=FKMQmFwpbVhLN6t1zUmQJtu3CJn8J6byTrmtRDECin8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=R/THLcvQSn0iF5vERo4UORN9s9C64bZOBmnWnvHK6X5ap8jqkAr+u2mWP3SWW2c34
 W3VMQigtXqyjzsBzYltRoEGpSWrshO54O80k1wKqoiATYlqgyYNJupvJRJgn9+9akY
 t3vfCfq+oVRBqHg0nETaO4uGQtPW+vsWezCM+bP4NwvOOFQ5JvxhvH3wLtUUeuNEMQ
 sd9LQv3GNIcwU48OzoJ2UHveaWRQP65XvlFtpMvywvCU0j3Wj6dVKbM/oHzQ7mBTN2
 t2sXXYFuxWTMFTTPRROGHVGk9NoQl9MNa2dAZbhepUo64wcIZmst1k8TfznLu05WF0
 zgLfj05+GYIPA==
Message-ID: <3b662808-e047-4023-a00c-1b6728bd5c86@denx.de>
Date: Mon, 20 Nov 2023 03:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] USB fixes: xHCI error handling
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>
Cc: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.dev
References: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
 <fe844c63-0c44-469c-a4e0-f0e1f2ac63fc@denx.de>
 <CAHc5_t2WFZH65MJENGvC6u21ETcRn47ceQd8jrHV9DVmmM10Vw@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHc5_t2WFZH65MJENGvC6u21ETcRn47ceQd8jrHV9DVmmM10Vw@mail.gmail.com>
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

On 11/20/23 00:17, Shantur Rathore wrote:
> On Sun, Nov 19, 2023 at 8:08 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 10/27/23 01:16, Hector Martin wrote:
>>> This series is the first of a few bundles of USB fixes we have been
>>> carrying downstream on the Asahi U-Boot branch for a few months.
>>>
>>> Most importantly, this related set of patches makes xHCI error/stall
>>> recovery more robust (or work at all in some cases). There are also a
>>> couple patches fixing other xHCI bugs and adding better debug logs.
>>>
>>> I believe this should fix this Fedora bug too:
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2244305
>>
>> Was there ever a V2 of these patches I might've missed ?
> 
> Is it this one?
> https://patchwork.ozlabs.org/project/uboot/list/?series=379807

I think so, thanks.

And uh, my question therefore it, is there a V3 which addresses the 3/8 
and 8/8 comment ?
