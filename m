Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB7AC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 14:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F69786F8F;
	Tue, 31 Oct 2023 15:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0625A86F8F; Tue, 31 Oct 2023 15:21:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9549B86FE7
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 15:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB4D71FB;
 Tue, 31 Oct 2023 07:22:18 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.29.65])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E1E73F738;
 Tue, 31 Oct 2023 07:21:36 -0700 (PDT)
Date: Tue, 31 Oct 2023 14:21:28 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nd@arm.com
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20231031142128.GA193998@e130802.arm.com>
References: <20230821210927.GL3953269@bill-the-cat>
 <20231020115747.GA141285@e130802.arm.com>
 <20231025145736.GS496310@bill-the-cat>
 <20231025151237.GA265088@e130802.arm.com>
 <20231025151526.GT496310@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025151526.GT496310@bill-the-cat>
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

> > > > > ________________________________________________________________________________________________________
> > > > > *** CID 464361:  Control flow issues  (DEADCODE)
> > > > > /drivers/firmware/arm-ffa/arm-ffa-uclass.c: 148 in ffa_print_error_log()
> > > > > 142
> > > > > 143             if (ffa_id < FFA_FIRST_ID || ffa_id > FFA_LAST_ID)
> > > > > 144                     return -EINVAL;
> > > > > 145
> > > > > 146             abi_idx = FFA_ID_TO_ERRMAP_ID(ffa_id);
> > > > > 147             if (abi_idx < 0 || abi_idx >= FFA_ERRMAP_COUNT)
> > > > > >>>     CID 464361:  Control flow issues  (DEADCODE)
> > > > > >>>     Execution cannot reach this statement: "return -22;".
> > > > > 148                     return -EINVAL;
> > > > 
> > > > This is a false positive.
> > > > 
> > > > abi_idx value could end up  matching this condition "(abi_idx < 0 || abi_idx >= FFA_ERRMAP_COUNT)".
> > > > 
> > > > This happens when ffa_id value is above the allowed bounds. Example: when ffa_id is 0x50 or 0x80
> > > > 
> > > > 	ffa_print_error_log(0x50, ...); /* exceeding lower bound */
> > > > 	ffa_print_error_log(0x80, ...);  /* exceeding upper bound */
> > > > 
> > > > In these cases "return -EINVAL;" is executed.
> > > 
> > > So those invalid values aren't caught by the previous check that ffa_id
> > > falls within FFA_FIRST_ID to FFA_LAST_ID ?
> > 
> > I had a closer look at that and I agree that the deadcode defect is legitimate.
> > I already provided a fix [1].
> > 
> > [1]: https://lore.kernel.org/all/20231020131533.239591-1-abdellatif.elkhlifi@arm.com/
> 
> Ah thanks. I had seen that posted but not put that together with this
> email and assumed it was addressing something you hadn't talked about
> here because you agreed with it being an issue.  I will pick up the
> above patch soon then.

Thank you very much.

Cheers,
Abdellatif

