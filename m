Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28184C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 23:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC0988426;
	Wed, 17 Apr 2024 01:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="JbzLssmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2893188426; Wed, 17 Apr 2024 01:33:26 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B0A88422
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240416233318epoutp0145e16b5afe12103fb0e497b54d694f88~G5rr5peEm1582415824epoutp01h
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 23:33:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240416233318epoutp0145e16b5afe12103fb0e497b54d694f88~G5rr5peEm1582415824epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713310399;
 bh=K8SLKkKmtVQx+bMJz0sTz2aH1R+EHdqbAB9cMGSsOkI=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=JbzLssmyK0sbz6iGIsSraSHVR/iMr6vn7fkKM5now/TeXlQA5lDx+8WFTPSozigWH
 GvJy1GAsaQfs/ExKAd8gkr8xki5WMxIxLoAHlANWeKs0Y3StEqhHhsyo6LqML430AS
 fH7tV/CWHK4EkfE23jMM++Zdn8xqUO5l4bw3UsaM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240416233318epcas1p30bd96d88cf52fd8a681b6ada371da74f~G5rrrNdOw0406404064epcas1p3X;
 Tue, 16 Apr 2024 23:33:18 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.136]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4VK0hs6GrJz4x9Q3; Tue, 16 Apr
 2024 23:33:17 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 1E.E2.09663.DBA0F166; Wed, 17 Apr 2024 08:33:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240416233317epcas1p26420d97a49b662dedb5ba8bfd1d36f0f~G5rqgfbpf0292402924epcas1p2U;
 Tue, 16 Apr 2024 23:33:17 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240416233317epsmtrp191c732e5f9b88354b0802da063e2a32e~G5rqf3flH1813518135epsmtrp1i;
 Tue, 16 Apr 2024 23:33:17 +0000 (GMT)
X-AuditID: b6c32a37-2f9ff700000025bf-52-661f0abd132a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B9.8D.08390.DBA0F166; Wed, 17 Apr 2024 08:33:17 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240416233317epsmtip27212f3b25d68269f0466f42e17fee0e1~G5rqUNaav0196101961epsmtip2X;
 Tue, 16 Apr 2024 23:33:17 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Quentin Schulz'" <quentin.schulz@theobroma-systems.com>, "'Dragan
 Simic'" <dsimic@manjaro.org>
Cc: "'Jonas Karlman'" <jonas@kwiboo.se>, "'Peng Fan'" <peng.fan@nxp.com>,
 "'Tom Rini'" <trini@konsulko.com>, <u-boot@lists.denx.de>
In-Reply-To: <8fec34b8-8d04-40ba-baca-5394762a4d27@theobroma-systems.com>
Subject: RE: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match
 linux
Date: Wed, 17 Apr 2024 08:33:17 +0900
Message-ID: <000901da9056$75785ae0$606910a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH4WoF6XMPcZuGkh8wOOqd8YokilwGmXxzLAN3e0OMBSnvFFQHOS2UQAsaHi2YCFY+6A7DcIKBg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmvu5eLvk0gzO/DSwubFG2OPnmKovF
 j1VfWC1WP9jPajF10mZ2i7d7O9kd2DxeHVjF7nFiwiUmj7N3djB6NBxew+ix8d0OJo+1jzaw
 BLBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2h
 pFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwLdArTswtLs1L18tLLbEyNDAwMgUq
 TMjOeHBpP2PBCemKyTc2sDcwvhTtYuTkkBAwkWj+8IENxBYS2MEo0fVOrIuRC8j+xCjx5v15
 VgjnG6PEt11TmGA63m5czAjRsZdR4usbEYiil4wS83a/AitiE9CT+L9oITOILSKQJrH+125m
 kCJmgVZGidPth8ESnAKeErvO3QDbLSwQJNEz/zALiM0ioCpxtvc9WJxXwFLi8IrdzBC2oMTJ
 mU/AapgF5CW2v53DDHGRgsTPp8tYIZZFSXRMnc0IUSMiMbuzDWyxhMBMDonbF76yQTS4SJyY
 2cMIYQtLvDq+hR3ClpJ42d/GDtHQzCixdMlBVginh1HiX8N1qG5jif1LJwP9yQG0QlNi/S59
 iG18Eu++9rCChCUEeCU62oQgqlUkLr1+yQQz/+6T/6wQtofE62WXmSYwKs5C8tssJL/NQvLD
 LIRlCxhZVjGKpRYU56anFhsWGMOjOzk/dxMjOI1qme9gnPb2g94hRiYOxkOMEhzMSiK8LcKy
 aUK8KYmVValF+fFFpTmpxYcYTYGhPZFZSjQ5H5jI80riDU0sDUzMjIxNLAzNDJXEec9cKUsV
 EkhPLEnNTk0tSC2C6WPi4JRqYOr66Kp1bM95zmOSi7P4p9053jc331imkvXI2zmHl26170+d
 qnRrw4R/+/+Jms84+/qL4Nc07m/dzzOVrvXm1pacr1fvk665mH59wb2Pe+68S3W+crZMOM1T
 3O6uo23MIo9TVzLzs777vXnMwFWg7GIQtE9WWl7wndXXKb4MWrMmOEor9K/9zmux70bTkdRf
 RzO+WJo6LGeRYw/UmXUzeGXLLnZJZ+kcK/sf5x9t/H3Y4cekM3PEpxg/Uow6kXlRpUPI91h+
 SqXp5Re5h573RHVnTataP8HI67rZ4/zltkYiHLb82x+FFR46w8Ahfs3NVrVpgdwTVs/SHdZR
 cxcccmc/cfvPjD+MmZXL586Rn6HEUpyRaKjFXFScCACoGIURLAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXncvl3yawYwbEhYXtihbnHxzlcXi
 x6ovrBarH+xntZg6aTO7xdu9newObB6vDqxi9zgx4RKTx9k7Oxg9Gg6vYfTY+G4Hk8faRxtY
 AtiiuGxSUnMyy1KL9O0SuDIeXNrPWHBCumLyjQ3sDYwvRbsYOTkkBEwk3m5czNjFyMUhJLCb
 UeLqjO1MEAkpic9Pp7J1MXIA2cIShw8XQ9Q8Z5TYPGUuG0gNm4CexP9FC5lBbBGBNInms5/B
 BjELdDJKzJ68GaxISGA+s8Tn3dwgNqeAp8SuczfA4sICARLtZ0+A2SwCqhJne9+D2bwClhKH
 V+xmhrAFJU7OfMICYjMLaEs8vfkUypaX2P52DjPEoQoSP58uY4U4IkqiY+psRogaEYnZnW3M
 ExiFZyEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwPGlp
 7WDcs+qD3iFGJg7GQ4wSHMxKIrwtwrJpQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJI
 TyxJzU5NLUgtgskycXBKNTBZpcySP+Xw+fMmu+jgWpXEEt7I7N4LHledg/f39JxsVu79NukZ
 95zk5bM6HX/1RWr8uOg2a+0nbR7Po+76socXt+5ODJwzb9/XfAVT/ZZF39YGdWy+cX1bckrt
 1AvXH/syn318d+Wl8vx9IkrL1F9f/jvr1A8l57sJE0LtfX9KvdbMPnng0eWpZySepdjmr78X
 JLI4omJdjZZ80OayWaKfZt/LsnzI7GC/K2Tp9cRTJs+eSuSk2+kVK++eqXNs/ffvbKaRO894
 bzl8Q3Fh86UKHs7SbL7/z9bPPh7vKqDRFlBc6r5G/LmMiUizLI9F2sSSxbk8q9+cf7hWx8NQ
 7QDr7jyNA5MZY4xlUo7tO/NTiaU4I9FQi7moOBEAQu5kJBYDAAA=
X-CMS-MailID: 20240416233317epcas1p26420d97a49b662dedb5ba8bfd1d36f0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240410085657epcas1p4c824b9243f8e2c6e8bc84e51d5cb1deb
References: <20240408210619.3749231-1-jonas@kwiboo.se>
 <496013c1-7a57-4d12-bf31-c5257f35ee8c@theobroma-systems.com>
 <3b2643b4-dea7-43cd-9f9c-da63e6588281@kwiboo.se>
 <ac394528-ca53-41d5-8c4c-7c10943a7c92@theobroma-systems.com>
 <9b62bbedf2c6d52b76a8ce1ce57dd35d@manjaro.org>
 <CGME20240410085657epcas1p4c824b9243f8e2c6e8bc84e51d5cb1deb@epcas1p4.samsung.com>
 <8fec34b8-8d04-40ba-baca-5394762a4d27@theobroma-systems.com>
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
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Sent: Wednesday, April 10, 2024 5:57 PM
> To: Dragan Simic <dsimic@manjaro.org>
> Cc: Jonas Karlman <jonas@kwiboo.se>; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung
> <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>; u-boot@lists.denx.de
> Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match linux
> 
> Hi Dragan,
> 
> On 4/9/24 21:28, Dragan Simic wrote:
> 
> [...]
> 
> > Let's keep in mind that the troublesome DT properties describe the
> > capabilities of the MMC controller and the board, not the capabilities
> > of the MMC storage device.  As we know, eMMC devices provide automatic
> > detection capabilities, to allow the host to determine its supported
> > modes, and match them with the ones the host is configured to support.
> > It's all described in the JEDEC standards.
> >

I didn't see the above mail in my mailbox. So I can miss something.

> 
> So why do we have those properties specified in board DTSes instead of
> in the SoC DTSI? Logic would want us to have this defined in one place
> only. I assume the issue is that even if the eMMC chip itself says it
> supports HS400 but the HW routing or some other issue make it impossible
> to use, we need a way to disable it from the DT for that board?
> 
> > Having that in mind, I find the approach in the Linux kernel rather
> > reasonable, because I highly doubt that some MMC controllers support,
> > for example, HS400 without supporting DDR52, or HS400 without supporting
> > DDR52.  A reasonable approach for an MMC IP block is to make it capable
> > of supporting all the speeds below its highest supported speed, to make
> > itself capable of supporting more, if not all, MMC storage devices.
> >
> 
> That's true for the IP block which is self-contained in the SoC, but
> it's forgetting about the other part, the eMMC chip/card. It depends on
> the HW routing, where mistakes/limitations can happen. And I don't think
> we have a mechanism today to disable the modes set in the MMC controller
> for a given MMC card from DT (aside from /delete-property/ in board files).

The both opinions make sense.
But, It doesn't set to all capabilities when nodes has mmc-hs400-* property.

That's why it's describing to each property is because they want to clarify only which mode they use.

AFAIK, I can't remember exactly, there were some boards that even though HS400 is working fine, 
but HS200 was not working fine. (It's depends on which IP board is using.)

There were too many cases not to work fine because of *HW* design. 
eMMC and Host IP were supporting the HS400/200 and all modes, but there was a problem of handling clock.
So it couldn't use HS200/400 and other dual modes.

And We needs to know if it's working fine. 
If we want to use hs400 mode, but board can be working to other mode without any error.
Of course, we can see a mode as log. But it's at least approach to limit.

Best Regards,
Jaehoon Chung

> 
> > In fact, I'll probably go ahead and submit a Linux kernel patch that
> > updates the descriptions in the binding, to hopefully eliminate any
> > ambiguities like these.  I hope you agree.
> 
> I for sure do not have enough knowledge in MMC to argue more than I just
> did, so having people with more experience/knowledge have a look at this
> would make sense, let's see what they have to say :)
> 
> Cheers,
> Quentin

