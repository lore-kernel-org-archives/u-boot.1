Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158A0CEACD2
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 22:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 491F2841CD;
	Fri, 14 Nov 2025 23:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MJgCziTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03A6E841C9; Fri, 14 Nov 2025 21:34:24 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3418D84154
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 21:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geraldogabriel@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-34182b1c64bso1661678a91.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 12:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763152460; x=1763757260; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2tUyhIah92QGKm3skN+GFPKLkbDp3lL7w3hkBKRK+M=;
 b=MJgCziTfbzqvEyqpYYXXZKKEPSw9P60vche+wQgn8IKaRFf6u2Sc0zjRfrPhsiqAne
 kUkxo2jaOQ813m5JV9Z7uNbByOGh7hl1mdwcDrDlorg/tfcaiW4j6bAb8sKjU2zcDgxj
 7tXH3GZzwuz2t93BwGdftnE+72i8A0x90Kz5LCMuYTxmZR9mnWdf6hknIgf7WTkGNdal
 MIW8I7X1GHjgU7oDA4dDg5Q7MnZgySbIfdJossCfi+2ugk4ph6gCKo1W2XHqbty0Nhyj
 +4gWxq+/WzkNwjdk1MqtsgBSxEPxI9H1ZH5Ivn4+6fhQtPhWEgnMq8daK9dwYK9qevGP
 x2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763152460; x=1763757260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2tUyhIah92QGKm3skN+GFPKLkbDp3lL7w3hkBKRK+M=;
 b=fGkMsXSVm+mJyw4SGskp/Yh4Y6MyW260HgCGUHv0cQXL0Ae/dT6xUXng2T6RwEa/14
 ONEeB/J5kmHJHiaPttELt/PPWbWVoMm81V4ZaU9Q0AgRiN5gYPn+PY8L8VZBt5jw4ZXa
 ZR9vAMpoQM809W8XtuFk0Rz1OWXOdHEvU8OFs/JeEiyeBMUMVBIA7gCax1c83l0HCu2H
 JKV68BgvQnoqJ46EnGspvqv4bq3nwOyFPBPk7aA3NmsWopE7EAbUqZ+08mDv0IQXEFBx
 dRJTJI8TNhX52zIAKBHi0FaqEIv+kgDZ5Hca2Ipwvpan6CfjOcD0RdS3eJ2ZPwKsTP1o
 FQaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSjL0SV8sjwNtTE27djsCpP0Vp6l027CBXj+fFghm6K8iTUz85KujYQSATH+1ITXwr3W5FPA8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxnw21wjisr2eumup9AbtJGe+iGRJNm3DnLtbn09dLMzHTqrPGS
 vhf76jUUTorFXje4bG8E7QDKLfxWrjpjyvfi/gGQHr1gLIX8nb0BqzLy
X-Gm-Gg: ASbGnctlGiNekWDPzK4EE0uXjPkAdIwFos2g04BLQ3cjJy30szwEpTRKrUYvqbtReQG
 ElvTGNyiFnLFThYsj82EPbZ0bXnPsfj98qLimgEESbA4vmMRrPZRiJboGk6KgrNFP6r9uaXiYhW
 7FO5aOKFV1KvWVFbKeQofdK+/eYfL/2DcvxiQ88q7U83sCQWZ2/kP3PXemz6BvDoz+8aHI9l4HV
 NZOe5tL12C137OuHCWyxegPk7pwRgSu3CzCW/Grx85UyqKy84dHLHEKNOtPTVehr5GY1QfP4sec
 TsQ/260SjHkoAQF+gmGqDQshcU4Bh+BneczcuJBeCRBaexupT75kkRxeCyyI//nYiD7eA47rm9T
 PRb+cr/5e2tTQYyNzAIDqXFHS44OciZFDD04Bdn7++tFCLSg7U14nUP2TvuCh03wPIyIx89Bhvs
 NuhlBbMo3PBsRDSOnnGU4=
X-Google-Smtp-Source: AGHT+IEe7JuZ4t+UG3Ej2ub9oJMa/3y/sYYCQh/JHxxvjriyxwW0b8MtjVbBgwEpy0ihZpW+2/eVvw==
X-Received: by 2002:a17:90b:37ce:b0:340:f05a:3ebd with SMTP id
 98e67ed59e1d1-343fa7469ecmr4392519a91.28.1763152459570; 
 Fri, 14 Nov 2025 12:34:19 -0800 (PST)
Received: from geday ([2804:7f2:800b:9c95::dead:c001])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bc36db22439sm5747058a12.4.2025.11.14.12.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 12:34:18 -0800 (PST)
Date: Fri, 14 Nov 2025 17:34:05 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci <linux-pci@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
 Johan Jonker <jbx6244@gmail.com>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 =?utf-8?B?5byg54Oo?= <ye.zhang@rock-chips.com>
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <aReSPbRxCgdNRI9y@geday>
References: <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
 <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
 <aRLEbfsmXnGwyigS@geday>
 <AGsAmwCFJj0ZQ4vKzrqC84rs.3.1762847224180.Hmail.ye.zhang@rock-chips.com>
 <aRQ_R90S8T82th45@geday> <aRUvr0UggTYkkCZ_@geday>
 <aRazCssWVdAOmy7D@geday>
 <e8524bf8-a90c-423f-8a58-9ef05a3db1dd@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8524bf8-a90c-423f-8a58-9ef05a3db1dd@rock-chips.com>
X-Mailman-Approved-At: Fri, 14 Nov 2025 23:56:02 +0100
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

On Fri, Nov 14, 2025 at 05:16:21PM +0800, Shawn Lin wrote:
> Don't worry, it's helpful, so I think Ye could have a look.
> May I ask if the failure only happened to one specific board?

Hi Shawn,

Yes, testing is restricted to my Radxa Rock Pi N10 board.

> 
> Another thing I noticed is about one commit:
> 114b06ee108c ("PCI: rockchip: Set Target Link Speed to 5.0 GT/s before 
> retraining")
> 
> It said: "Rockchip controllers can support up to 5.0 GT/s link speed."
> But we issued an errata long time ago to announced it doesn't, you could
> also check the PCIe part of RK3399 datasheet:
> https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf

OK, I'm partly responsible for that as author of the commit in question.

First off let me say I do not intend to send any patches setting
max-link-speed to TWO for this platform.

I understand you issued an erratum, but are you absolutely sure about
that erratum? Because my testing shows otherwise:

---
With max-link-speed = <2>
pci 0000:01:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)

/dev/nvme0n1:
 Timing cached reads:   3002 MB in  2.00 seconds = 1502.21 MB/sec
 Timing buffered disk reads: 2044 MB in  3.00 seconds = 680.79 MB/sec
---
With max-link-speed = <1>
pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)

/dev/nvme0n1:
 Timing cached reads:   2730 MB in  2.00 seconds = 1366.15 MB/sec
 Timing buffered disk reads: 2028 MB in  3.00 seconds = 675.71 MB/sec
---

As you can see, not only the kernel PCI driver recognizes 5.0 GT/s PCIe
link but there's even a marginal increase in cached reads as measured by
hdparm, the gains are of course limited by CPU performance.

> Also we set max-link-speed to ONE in rk3399-base.dtsi but seems another
> patch slip in: 755fff528b1b ("arm64: dts: rockchip: add variables for 
> pcie completion to helios64")

I can't speak for patches I haven't authored, but I believe you're
welcome to send a correction.

Thank you,
Geraldo Nascimento
