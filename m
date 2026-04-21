Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973E2F8FA8C
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81FDF84368;
	Tue, 21 Apr 2026 17:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7R7q2pl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CCD184370; Tue, 21 Apr 2026 17:16:29 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E656384366
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so2442236f8f.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776784586; x=1777389386; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TfbYwp0L/5avo8qDDcydRcEUMMhyloCTIG3HJQWUeqA=;
 b=S7R7q2pl7NLGOIGkQrVHU7zgzsLkGPkoJe2WN3fKImIzCveN1NV7p3jtnZ1c33K+nQ
 KygAgg5xBx3JYqO5sGOYcFlLqRVzJffAAYp9rw19C/JmW6RBpjMrCfENzWY/jTABnX0y
 kLGeE8+p4yyfRUpOEIzSRmLCrCMwSysvOgUVMV+vCqfz2kovBubKBbPWLJB3Z2M37VJJ
 6pMH6/SeI3pApL6jb9I5YaHUKA2EKksucn+TwYg9XBboIErnIN2K1sbUEhwpBc3YW6s+
 KgEIGYX+CKtpAaVh83ChAZYtdJmOvex3qsgpW5bH97IjwRoKGYeeZVAxSVGblS9yKlDd
 Cllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776784586; x=1777389386;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TfbYwp0L/5avo8qDDcydRcEUMMhyloCTIG3HJQWUeqA=;
 b=sGqeTk3t9+MSkRi9CCIwvWR7LS7Q+xT3WmXgm08Z62vejZNrkuL2ZQaq3yhJShdlSL
 mK/R070Q/dDR10Asb47kNWf56JUZsWX6EJ9WhoquWT/XKsXhcx9WivfX5oTHc3mtFm1R
 WhIVWQxvkDCr7kg+qUUcHCJSbPM9+BNoAqM+bRAN9lU1seS65colhv7tnfkEyJXPGcND
 77fgsxyqjcMpFyD+4fWBeM8oAWcG5H9vFd7YLj6PMhvorvYvxR5jPV/d0Jv4QLUDZtFY
 S46ZvgEVLQW1LsTG+OLbxnIReay+dU6D0Ky2v4Ygs76H7wrOS6Bksv/8m7Jd+UMNDbmD
 18+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MZl6PrXzOBzTcnPudQxV4COfOv1Fv+rKL1IWwCc/1m5UmPwrgg/dfbMK1iunvd4YgxmchOeQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyK+q9a3312vH1H+SUnk17QS+d21vlJQJkvCjF7movch7OxtoPf
 g4hzAI7QWKNUkhIMJcEWOq8QGBLtQHWuMAawY7wg+wWB4NSyeDMdBp1Y
X-Gm-Gg: AeBDieumDOPL0Fib1DtqqSxWQuEafc8fpANfIMQbxhIMdHHpRByvQz07BzWbYvxy3/J
 ao3aEhdF1m4irDjplqlO929pjCD51Co9ImL+OeEc8s2BBVlzyqlzt+iZq+VGYP8AjvnevLujcZ4
 +r8uZ6mFcrHlG0lTcEM17BnBqzvjI+6pF12SxSr9ZeTqAGsq11Dd7kUGIvhVA0PartnC9gdJ+qW
 A0Nf1cYHxWnxFOrthNg2y3CRE3BCnw1SEz9YlXStEQ2VlPczTFawEyburAS4ATVUk0rJdeqiHiI
 /HRZJILtEfk+ihuLcIdrSHMVP84h6n4q4TrVv2ETOP1xXQ4crFT3j9W4Numkc7QCjX0k0+9PGZQ
 0QkaUZaPBDDSrmhaJeqcSMWflS186h2/G67RUOL1L24CDHSeliX6sZZKci1z7UbOmkeae1Vej2K
 AtkcuDJb7HgPhmQGBkzh5weZBUnjcXSg9vQRfUgmaMBdAqehHPalqykE5mHYNElh28IT9ug4EyM
 v8zn45IGI2gvHgUyIq13D0BDfYLfspAIshvYQ==
X-Received: by 2002:a5d:5d88:0:b0:43d:7275:c1ec with SMTP id
 ffacd0b85a97d-43fe3e0fcc5mr29646279f8f.40.1776784585871; 
 Tue, 21 Apr 2026 08:16:25 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e44f69sm40151578f8f.25.2026.04.21.08.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:16:25 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:16:24 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Sparsh Kumar <sparsh-kumar@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, vigneshr@ti.com, 
 praneeth@ti.com, bb@ti.com, afd@ti.com, n-francis@ti.com, vishalm@ti.com, 
 sebin.francis@ti.com, d-gole@ti.com, a-kaur@ti.com
Subject: Re: [EXTERNAL] Re: [PATCH V2 0/9] board: k3: Sync rm-cfg with TIFS
 v11.02.09 firmware
Message-ID: <vjlrb25moymvlg6tfofolyc4ybgfju3yglefe5olcjk2qphz2l@5d6e4knya7re>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
 <20260225151047.GJ1593142@bill-the-cat>
 <e6d88daa-c00c-418b-a8df-3714c7254002@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6d88daa-c00c-418b-a8df-3714c7254002@ti.com>
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

On Wed, Feb 25, 2026 at 09:17:03PM +0530, Sparsh Kumar wrote:
> On 25/02/26 8:40 pm, Tom Rini wrote:
> > On Wed, Feb 25, 2026 at 06:54:16PM +0530, Sparsh Kumar wrote:
> > 
> > > This series updates the Resource Management (RM) configuration files
> > > for AM62 family devices to align with the TIFS v11.02.09 firmware.
> > > 
> > > Background
> > > ----------
> > > With the latest TIFS firmware (v11.02.09), an additional virtual
> > > interrupt and event is reserved for MCU cores to DM usage on am62x,
> > > am62ax, and am62px devices. This series brings the rm-cfg and
> > > tifs-rm-cfg files in sync with these firmware changes across both
> > > TI reference boards and vendor boards.
> > > 
> > > These changes are backward compatible with older TIFS firmware versions.
> > > 
> > > Additionally, the am62x platform was originally introduced without a
> > > tifs-rm-cfg.yaml file, unlike other platforms in the AM62 family.
> > > This series addresses that gap and enables tifs-rm-cfg in binman for
> > > am625-sk and am62p-sk platforms.
> > > 
> > > Changes
> > > -------
> > > TI reference boards (patches 1-4):
> > >    - Update rm-cfg.yaml for am62x, am62ax, am62px
> > >    - Sync am62px tifs-rm-cfg.yaml with TIFS firmware template
> > >    - Add missing tifs-rm-cfg.yaml for am62x
> > >    - Enable tifs-rm-cfg in binman for am625-sk and am62p-sk
> > > 
> > > Vendor boards (patches 5-9):
> > >    - beagleplay (am62x-based)
> > >    - phytec phycore_am62x
> > >    - toradex verdin-am62
> > >    - phytec phycore_am62ax
> > >    - toradex verdin-am62p
> > > 
> > > Note: For vendor boards, this series only updates the rm-cfg.yaml files
> > > with the required interrupt reservation. The tifs-rm-cfg.yaml files
> > > cannot be updated without access to the corresponding SysConfig files,
> > > as both rm-cfg.yaml and tifs-rm-cfg.yaml must remain in sync.
> > 
> > Do I read this right, and the vendor boards will now be broken?
> > 
> Hello Tom,
> 
> No, the vendor boards will not be broken by these changes.
> 
> While it is generally recommended to keep rm-cfg.yaml and tifs-rm-cfg.yaml
> in sync, the specific changes in this series do not require corresponding
> tifs-rm-cfg.yaml updates for vendor boards:
> 
>   1. AM62ax and AM62px: The global events reservation change in rm-cfg.yaml
> has no corresponding entry in tifs-rm-cfg.yaml, so no sync is needed.
>   2. AM62x: The virtual interrupt change would ideally need a similar update
> in tifs-rm-cfg.yaml, but none of the vendor boards have this file. This
> series introduces tifs-rm-cfg.yaml only for TI reference board to align with
> other K3 devices.
>

Hi Sparsh,

I'm evaluating whether we (Toradex) should start including this
tifs-rm-cfg.yaml file. Could you expand on when this is required?

From the documentation I gather that the tifs config is a cut-down
version of rm-cfg.yaml, only meant for TIFS consumption.
Furthermore, doc/board/ti/k3.rst mentions:
    Devices with a split firmware will have two firmwares loaded into the
    device at different times during the bootup process. TI’s Foundational
    Security (TIFS), needed to operate the Security Management Subsystem,
    will either be loaded by ROM or the WKUP U-Boot SPL, then once the
    wakeup U-Boot SPL has completed, the second Device Management (DM)
    firmware can be loaded on the now free core in the wakeup domain.

Is this a necessity for secure boot, or how is it used?

Thanks for the help and kind regards,
Ernest

