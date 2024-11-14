Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26144D65C56
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 07:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB10895C0;
	Thu, 14 Nov 2024 08:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="FwwGvCSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 411A6895C0; Thu, 14 Nov 2024 08:34:27 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F38D890B9
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 08:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20241114073414epoutp0311df6d6d449b0a3714f3360c78a60fa8~HxW1Isu381284112841epoutp03c
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 07:34:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20241114073414epoutp0311df6d6d449b0a3714f3360c78a60fa8~HxW1Isu381284112841epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1731569654;
 bh=04SBPgqPRzKtzMM6zh92Zy3+/luLANEC4LRBiHm4s3o=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=FwwGvCSCZoYt790I5xyJ7WHOwqa/Zcj+hfU3EQ5qiuaRdNiBH/Zm98/w26BLcSY9g
 wL0+yiZ74f5+ENDvPiPUwrbaJ3MEbD1ZQHe7m5g51+qwFS3di9Y7RGzCoDR2bcz8EP
 sbLVF3wiHCueWAAr6nFGT26uCPXWRpwrEwcxUvrM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20241114073413epcas1p4c3f30508877ee695ecb1bf6dd42529de~HxW0RIjil2861728617epcas1p40;
 Thu, 14 Nov 2024 07:34:13 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.231]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4XpsNN6qQkz4x9QF; Thu, 14 Nov
 2024 07:34:12 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 5A.45.09406.4F7A5376; Thu, 14 Nov 2024 16:34:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20241114073412epcas1p4102f01a9fad699a7025f68f5e3e1e751~HxWy76a-70345503455epcas1p4L;
 Thu, 14 Nov 2024 07:34:12 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241114073412epsmtrp21c181b6b68fa95e27ee66487639848fe~HxWy69dLz3223832238epsmtrp2S;
 Thu, 14 Nov 2024 07:34:12 +0000 (GMT)
X-AuditID: b6c32a35-aa3fa700000024be-ab-6735a7f41c7b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 67.D0.18937.4F7A5376; Thu, 14 Nov 2024 16:34:12 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241114073412epsmtip179d70723892c2ec52e89a379dbee2a44~HxWyoBwZh0134701347epsmtip1x;
 Thu, 14 Nov 2024 07:34:12 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Caleb Connolly'" <caleb.connolly@linaro.org>, "'Tom Rini'"
 <trini@konsulko.com>
Cc: "'Christian Marangi'" <ansuelsmth@gmail.com>, "'Dragan Simic'"
 <dsimic@manjaro.org>, "'Ilias Apalodimas'" <ilias.apalodimas@linaro.org>,
 "'Jerome Forissier'" <jerome.forissier@linaro.org>, "'Jonas Karlman'"
 <jonas@kwiboo.se>, "'Marek Vasut'" <marek.vasut+renesas@mailbox.org>, "'Peng
 Fan'" <peng.fan@nxp.com>, "'Peter	Robinson'" <pbrobinson@gmail.com>,
 "'Rasmus Villemoes'" <rasmus.villemoes@prevas.dk>, "'Simon Glass'"
 <sjg@chromium.org>, "'Sughosh Ganu'" <sughosh.ganu@linaro.org>,
 <u-boot@lists.denx.de>
In-Reply-To: <5fb2f6ab-c47d-4ea0-83bf-a14d8e737cb1@linaro.org>
Subject: RE: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
Date: Thu, 14 Nov 2024 16:34:12 +0900
Message-ID: <12dc01db3667$99856830$cc903890$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHaT+sCPosajtQJrVFjmKLcCGTQEQLwZzE6Aq6uYgAB8I/7nLJ7oaIw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmru6X5abpBnv7TS2mnvzGYnGqZRuT
 xYUtyha9Lb+ZLc63Lma3OPnmKotF68o7bBbrVq1hs/ix6gurxc3XDhbftmxjtLh3Tc5i6qTN
 7BZv93ayO/B5zG64yOKxc9Zddo9XB1axe5yYcInJ4861PWweZ+/sYPTYOXsfk0fD4TWMHhvf
 7WDymDH7DWMAV1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotP
 gK5bZg7QA0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAtMCveLE3OLSvHS9vNQS
 K0MDAyNToMKE7Ixvy7pZCo6LV2x4/JyxgbFBuIuRk0NCwETi1sxTLF2MXBxCAjsYJT6+f8AM
 4XxilHj/+Tg7nPP3URcTTMviZ6vYIBI7GSWmf+xiA0kICbxklFj/OgDEZhPQk/i/aCEziC0i
 EC5x/cNMJpAGZoEeFonZy46BJTgF7CTu7r/DCGILC3hIrGt/C2azCKhKTN9wD8zmFbCUWPhy
 BQvEZgWJn0+XsUIMdZM4238d7CJmARGJ2Z1tYHdLCOzhkPh+v48ZosFF4vrWP1DNwhKvjm9h
 h7ClJD6/28sG0dDMKLF0yUFWCKeHUeJfw3U2iCpjif1LJwOt4ABaoSmxfpc+xDY+iXdfe1hB
 whICvBIdbUIQ1SoSl16/ZIKZf/fJf6gSD4kvL6TgwXhs3XumCYzys5DcPQthwQJGplWMYqkF
 xbnpqcWGBYbwuEzOz93ECE66WqY7GCe+/aB3iJGJg/EQowQHs5II7yln43Qh3pTEyqrUovz4
 otKc1OJDjKbAkJzILCWanA9M+3kl8YYmlgYmZkbGJhaGZoZK4rxnrpSlCgmkJ5akZqemFqQW
 wfQxcXBKNTAJCp1+FX1b6WQYa15MxJFKFs+5iZWbRP0nH3P70+bHLujE1fVuJ8+cnhbnyxyH
 pi98d4jpiOnhGCsNFqYlJ05feHCS325CwITgF/czdt+9saf63EmfRToPH13a2c267YLG1teN
 tk5Juzkkb7pu9HViFp6n4hdTGjBdiTVDWePCr12uzY0aJfmnjl19eGdF5fSdUaZspzRSumta
 P2V90zNzTTz5K/lN+KXagH+s8paxn0437jVQvT7zrpD/ZmH5ux/97/jXCH5JKFt9MWrC3+R9
 R6/lzfu5ON32SV3AjPsMGaezd3zKjzkYnfhw14M2h7Q5D97P/PKdVUZDcH0nw4xUA+EKieaA
 xVznbZ9dCS5SYinOSDTUYi4qTgQAewNl8kMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnO6X5abpBq9vSlpMPfmNxeJUyzYm
 iwtblC16W34zW5xvXcxucfLNVRaL1pV32CzWrVrDZvFj1RdWi5uvHSy+bdnGaHHvmpzF1Emb
 2S3e7u1kd+DzmN1wkcVj56y77B6vDqxi9zgx4RKTx51re9g8zt7Zweixc/Y+Jo+Gw2sYPTa+
 28HkMWP2G8YArigum5TUnMyy1CJ9uwSujG/LulkKjotXbHj8nLGBsUG4i5GTQ0LARGLxs1Vs
 XYxcHEIC2xklGro6mSASUhKfn04FSnAA2cIShw8Xg4SFBJ4zShy9qg1iswnoSfxftJAZxBYR
 CJf4eKiTGWQOs8AUFol/txczQgx9wyixef9aFpAqTgE7ibv77zCC2MICHhLr2t+C2SwCqhLT
 N9wDs3kFLCUWvlzBAnGEgsTPp8tYITa4SZztvw52HLOAiMTszjbmCYwCs5C4CxgZVzGKphYU
 56bnJhcY6hUn5haX5qXrJefnbmIEx4pW0A7GZev/6h1iZOJgPMQowcGsJMJ7ytk4XYg3JbGy
 KrUoP76oNCe1+BCjNAeLkjivck5nipBAemJJanZqakFqEUyWiYNTqoFJ4tgN1p65PhFpO/4t
 vFTl2q0aLK51+VudfGLO8bOTHLhT9whWL38l9z5kR+G6SwUlfNtyor6Lvw4KTd/2scs1+7fr
 jcCZy+pWXU/5tTfs4u+qCZLs746lvJt+uuRJ8L8fWqUTD8qbPg2fpe+33Mxx7XELw93sB100
 DHsvyfzqPfH1ysHgBHWTCEEzZekrHLMf/Uozvv90r0xr0sq3FUuLHUJP2d/QL2uqfyzzufvd
 dK9lmwRqvLfzFH3df9V4/ZsK7rPtM/fM/fP3GH/0587Jqut/cL/b+eHIreCZHZu26YWpH/RZ
 wvKJv/Hcp/jiC9HulzfPbezsZ5GKjj91ZZmRZ8etAPvzh8uF664s+3FRQ4mlOCPRUIu5qDgR
 AP8fLTgEAwAA
X-CMS-MailID: 20241114073412epcas1p4102f01a9fad699a7025f68f5e3e1e751
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241113144720epcas1p22744898f3e7c9a1e1813fd54730cca19
References: <20241113053023.1870736-1-caleb.connolly@linaro.org>
 <20241113142437.GM3600562@bill-the-cat>
 <CGME20241113144720epcas1p22744898f3e7c9a1e1813fd54730cca19@epcas1p2.samsung.com>
 <5fb2f6ab-c47d-4ea0-83bf-a14d8e737cb1@linaro.org>
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

> -----Original Message-----
> From: Caleb Connolly <caleb.connolly@linaro.org>
> Sent: Wednesday, November 13, 2024 11:47 PM
> To: Tom Rini <trini@konsulko.com>
> Cc: Christian Marangi <ansuelsmth@gmail.com>; Dragan Simic <dsimic@manjaro.org>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Jaehoon Chung <jh80.chung@samsung.com>; Jerome Forissier
> <jerome.forissier@linaro.org>; Jonas Karlman <jonas@kwiboo.se>; Marek Vasut
> <marek.vasut+renesas@mailbox.org>; Peng Fan <peng.fan@nxp.com>; Peter Robinson <pbrobinson@gmail.com>;
> Rasmus Villemoes <rasmus.villemoes@prevas.dk>; Simon Glass <sjg@chromium.org>; Sughosh Ganu
> <sughosh.ganu@linaro.org>; u-boot@lists.denx.de
> Subject: Re: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
>
>
>
> On 13/11/2024 15:24, Tom Rini wrote:
> > On Wed, Nov 13, 2024 at 06:30:08AM +0100, Caleb Connolly wrote:
> >
> >> It may be the case that MMC support is enabled even though the board
> >> we're booting on doesn't have any MMC devices. Move the print over to
> >> the print_mmc_devices() function where we can only print it if we
> >> actually have MMC devices.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >
> > I'm not sure I like this. What we do / don't find on startup is part of
> > the not-exactly-API. It's true that if we don't print an MMC line at
> > all, and we should have MMC, the user (and any scripts that parse
> > console output) but now we're also increasing the code size a little bit
> > too. I can be convinced this is a good idea, but I'm not there yet.
>
> Hmm, fair enough. I'll offer some more context, maybe there's a smarter
> approach here I'm not seeing.
>
> The main place this shows up is on Qualcomm boards. Since all Qualcomm
> armv8 targets are supported with qcom_defconfig (just by adjusting which
> DTB is used), we can't know at build time whether the board has MMC.

I'm also not sure if it has to apply this at this time.
Partially, I understood what you said about your case.

But In my case, the printing MMC information was useful to do debug at booting time.
(correct dtb or not, or wrong configuration, etc)

Best Regards,
Jaehoon Chung

>
> I guess my thinking behind this patch comes from a bigger picture desire
> to get UFS and MMC more aligned. The number of devices with UFS is
> definitely going up, and I would argue that U-Boot's inconsistent
> treatment of these two storage classes (obviously a result of their
> relative age and support in the codebase) is really unintuitive and
> weird for users (nevermind that the "scsi" command is used for UFS
> devices, cute though it is).
>
> I'm really wary to open this whole can of worms, since I guess it would
> require some larger efforts and collaboration to fix. But maybe this
> patch (or one like it) would be better suited in the context of some
> larger effort to unify storage backends?
>
> Kind regards,
> >
>
> --
> // Caleb (they/them)



