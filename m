Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71BDD5CCB6
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 10:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC4778334F;
	Tue, 16 Dec 2025 11:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.b="gUiW6fIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFD2833C6; Tue, 16 Dec 2025 11:07:50 +0100 (CET)
Received: from mail117.out.titan.email (mail117.out.titan.email [107.21.18.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA2E83106
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 11:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dVt0L3hCWz2xFf;
 Tue, 16 Dec 2025 10:07:46 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=aNOEi8DrXeIMMENcyUc4isD22TAXwG4xkD3y497RZ1w=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=from:message-id:mime-version:references:in-reply-to:to:cc:subject:date:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
 q=dns/txt; s=titan1; t=1765879666; v=1;
 b=gUiW6fIAzYw1THhDVeRQHLA8imtAhTzC1z+Rbev42Jr9FMpAly3J06A0cATgmRN75z+GHfGq
 LVFE2nkcJSooO/V2nJXhSLh/iqLCgv04+f4U3P5SBhxpJZHJT4/2MZUbWYeK5Rfqxq9Rjkg4qUR
 U4k6++taS1r14hukC7FLvhLk=
Received: from pie (unknown [117.171.66.90])
 by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dVt0C1FQvz2xHK;
 Tue, 16 Dec 2025 10:07:38 +0000 (UTC)
Date: Tue, 16 Dec 2025 10:07:35 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Quentin Schulz <quentin.schulz@cherry.de>, alice.guo@oss.nxp.com,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Zang <davidzangcs@gmail.com>,
 Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 5/7] usb: Kconfig: imply DM_USB_GADGET
Message-ID: <aUEvZyIU4YMiSwUJ@pie>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
 <20251216-imx8ulp-v1-5-504115a53020@nxp.com>
 <13e5946a-26d7-4b60-91f1-df9a3ba36f52@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13e5946a-26d7-4b60-91f1-df9a3ba36f52@cherry.de>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765879666358736970.27573.6019921219820275071@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TPG/S0la c=1 sm=1 tr=0 ts=69412f72
 a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=8AirrxEcAAAA:8
 a=l7Fp-COF78MC_BAHFP8A:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
 a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22
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

On Tue, Dec 16, 2025 at 10:49:47AM +0100, Quentin Schulz wrote:
> Hi Alice,
> 
> On 12/16/25 7:38 AM, alice.guo@oss.nxp.com wrote:
> > From: Sherry Sun <sherry.sun@nxp.com>
> > 
> > Since the ci_udc driver has been converted to DM driver, the
> > CONFIG_DM_USB_GADGET should also be selected when CONFIG_CI_UDC
> > is enabled, then we can use DM ci_udc driver.
> > 
> 
> Is DM_USB_GADGET *required* for CI_UDC to work? "imply" allows to have
> DM_USB_GADGET=y AND CI_UDC=n, which is probably not what you want. You
> probably simply want "depends on DM_USB_GADGET"

And if DM_USB_GADGET is required for CI_UDC to work after PATCH 4 which
does the convert, this patch should probably be merged with PATCH 4, or
we will have unfunctional commits, affecting bisectibility.

> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > Reviewed-by: Ye Li <ye.li@nxp.com>
> 
> Please do not provide Reviewed-by on the first version of a patch,
> Reviewed-by, Acked-by, Tested-by, etc.... should be given publicly on the
> mailing list. We don't know if Ye Li actually reviewed it or if you
> unilaterally decided they reviewed it. We don't know if we can trust it...
> which we shouldn't have to figure out.
> 
> Cheers,
> Quentin

Best regards,
Yao Zi
