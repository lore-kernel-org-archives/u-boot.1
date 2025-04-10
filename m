Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAC4C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 18:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5DF383DB8;
	Thu, 10 Apr 2025 20:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tlW5OHft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A53F483DBF; Thu, 10 Apr 2025 20:18:22 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB38083D92
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 20:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53AIIHBD1891703
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 13:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744309097;
 bh=81/y08E8g3bzT7P4wA2KrWHI+a8YQhRKJ/QtJBumEgI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tlW5OHftIh4MN3gGoxJFtMsNCNS+z5ILPiTZGXKhrPysf+CKD+qDlKQtOnSsmlksx
 i/OPeNJ4W+TzZe8CagmHgZq1kSCgMVtLUI88KKZQYfxO/EMh8MwKvZCm0TgpHjrojW
 k2UJhyaqjbpjgfm75B6i+f4Fx7AjSRxeaz41DaAw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53AIIH8R091098
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Apr 2025 13:18:17 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Apr 2025 13:18:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Apr 2025 13:18:17 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53AIIGtQ039174;
 Thu, 10 Apr 2025 13:18:17 -0500
Date: Thu, 10 Apr 2025 13:18:16 -0500
From: Bryan Brattlof <bb@ti.com>
To: Thom Nichols <thom.nichols@voltserver.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: bootcount support for AM62 RTCSS
Message-ID: <20250410181816.luffcoteewfag4oe@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <CY8PR11MB79456EA41EF6365020C89B98FDB52@CY8PR11MB7945.namprd11.prod.outlook.com>
 <20250408190529.qzi54waaxj3hzxr6@bryanbrattlof.com>
 <CY8PR11MB7945B4325CE428F1DB3253BAFDB42@CY8PR11MB7945.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY8PR11MB7945B4325CE428F1DB3253BAFDB42@CY8PR11MB7945.namprd11.prod.outlook.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On April 10, 2025 thus sayeth Thom Nichols:
> Hi Bryan - I realized what I think you were trying to say - the 
> bootcount_davinci driver uses the davinci_rtc​ struct which is a 
> completely different register layout between the AM33 and AM62 RTCSS.  

No worries!

> I imagine I could make an alternate davinci_rtc struct in my new 
> header file just to remap the kick and scratch registers but that 
> feels icky.  Of course I could just make a bootcount_am62x driver 
> instead of trying to reuse bootcount_davinci.  Or change 
> bootcount_davinci so that it uses offsets instead of the davinci_rtc 
> struct.  Do you have any suggestion for which would be the preferred 
> approach?

Honestly when I looked at this I was assuming we would want to split the 
K3 generation of chips into a different file just to avoid any '#if K3' 
logic here. The RTC IP is the same across all AM62{A,P,L} class of 
devices so it won't be a one off use. IMO

~Bryan

> 
> Thanks again.
> 
> -Thom
> 
> 
> From: Bryan Brattlof <bb@ti.com>
> Date: Tuesday, April 8, 2025 at 3:05 PM
> To: Thom Nichols <thom.nichols@voltserver.com>
> Cc: u-boot@lists.denx.de <u-boot@lists.denx.de>
> Subject: Re: bootcount support for AM62 RTCSS
> 
> [You don't often get email from bb@ti.com. Learn why this is important 
> at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Thorm!
> 
> On April  8, 2025 thus sayeth Thom Nichols:
> > I’d like to get bootcount support for the AM62 RTCSS.  The RTCSS on
> > the AM62 is very similar to the AM33.  In fact, I’m pretty sure the
> > bootcount_davinci driver would work for AM62, with just the register
> > address/ offset and KICK_WE constants redefined for the correct AM62
> > values.  A while back I tested the AM62 scratch register from
> > userspace [1] and confirmed it works the same as the AM33.
> >
> 
> Wonderful! It is a different IP from the AM335 but not completely
> different however I think your approach should work.
> 
> > I’ve never contributed to u-boot but I believe I could get a working
> > PR that modifies the davinci_bootcount driver, if this would be
> > acceptable.
> >
> 
> You should feel free to start if you want! U-Boot is very welcoming in
> this regard. The more devs we have in U-Boot the better :)
> 
> > Alternately I don’t know if there’s any near-term plan for any of the
> > AM62 maintainers to port the rtc driver so that bootcount/rtc could be
> > used.  I think doing this would be beyond my capabilities.
> >
> 
> So we do have some plans to improve RTC support in both in Linux and in
> U-Boot to extend some features needed for the latest Sitara class SoC
> but I'm unsure about timelines. I've added a ticket internally to track
> this if we get to it before you do though :)
> 
> ~Bryan
> 
> > Thanks in advance.
> >
> > Thom Nichols
> >
> > 1. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FVoltServer%2Fuboot-bootcount%2Fpull%2F15%2Ffiles&data=05%7C02%7Cthom.nichols%40voltserver.com%7Cbf306542d0ce48c4bc4308dd76d056ec%7C9d9544062c0145a39cc8be64a19fb626%7C0%7C0%7C638797359401626648%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C60000%7C%7C%7C&sdata=MgIfiZ5MnTaFkOfpH9kVXXxwarhhj1d73qoX76TYTuo%3D&reserved=0<https://github.com/VoltServer/uboot-bootcount/pull/15/files>
> 
> This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error please notify the system manager. This message contains confidential information and is intended only for the individual named. If you are not the named addressee you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately by e-mail if you have received this e-mail by mistake and delete this e-mail from your system. If you are not the intended recipient you are notified that disclosing, copying, distributing or taking any action in reliance on the contents of this information is strictly prohibited.
