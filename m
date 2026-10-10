Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D881CA9EC3
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46B1B608E0;
	Sat, 10 Oct 2026 13:14:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6_xoGeQmh_e; Sat, 10 Oct 2026 13:14:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7ECE960A39
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791638093;
	b=kvTt+/ODTsy1LOfIvqzFHTGJkBM7++KiEkzYwgnH8j/lUf+qOw6qZ2vtCk8OdwIsUl+H
	 UQ7MhNMkMCN0NoxdjE1c+pxPmZ55cuggJxq1j/GC7NAejkvRrKpq7W3tF7sIwTz2qrDa8
	 ynOjRDU4bd2OGXJ29Js3HXaxg3vA0mI8Jt/+BUqPMSn7NjnM5RFvsSbLJ0DzORRGj0WN4
	 XdcAX9Nuiw4QeIrhdJtc7hJs88LRGwFOTUBqad9Jrsladmrd9RGJudSEEU1LpsV43eeNb
	 knf6cst49pQVL5rfoGyU/2QGD4pX94oHA1MlO2T8FWV1wbP484TVBkKjRby0X9APxOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791638093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:Organization:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uHE/jjCzpjkDAz4iiaVp8eviUAo2ZaUxZZ5G7TQkqcQ=;
	b=G2f6lUzwme4i7GaRSRVEwWAmSmQLlNkPCbea2dQEwwComBuwdgpFUq8WgQ6rN3GAqvad
	 GHSFE/hcBEvtG5Ykqo7CmL8hu2ux3a7BxGfh6SfJimkIwmqtmMvC0K2qxiHuFy3kNjo/P
	 Syn7iLn3iOqMsxqxttXsVkcslY5iVOxpUNFmFf+gDQGLFikowkCoceL/YeaZ+jPCYqqGs
	 yTEUzhnjV35XAe/igL1LK6FgSevZaL0oZkogReSaCud1e4wMg1y+EM3AH3KNdACGzDqmR
	 yy13xyTSowMJoW6U67vAP1ehXyXEpJ9IG90JazHGmko6tOCJh+l5lq3+sghfTIwMkVQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ReFXV97W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791638093;
	bh=uHE/jjCzpjkDAz4iiaVp8eviUAo2ZaUxZZ5G7TQkqcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qz2c9n4ydm5H4Jvlvff5rvvS/dK05nYVdTXav8XRfkSrpgFFZJ5Lik0dYB8h9M97C
	 xjAQsq+jWYY2iqOnxSIPwjcnhcQ2Gw0Vl7uICNF6AF9MK8tWVS8hl0KfLJTlNgzePs
	 IOsgWieEbsRs+4KwrQldZcSqwG11Z2EpIjJ1r4KredqvDFUHOEk6cygDWV7zCTBloa
	 5giB09rTFgC2eUHnSv5UzT/GFuKmGYcWbkdHDH2u/G+DVjPOsU3JY0xrN9i/8xPCed
	 BWJbomU6GJm3nExn4jMjfaVxtTnH0v9vpTIIsOhPrmf2AhGJ3Z6pZWJEOPoNkZICmd
	 HLk1i2Gcm7j6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7ECE960A39;
	Sat, 10 Oct 2026 13:14:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1495356
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EF096067C
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id twGUNiSllyUW for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 10:59:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3524D60670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791629976;
 b=PyOkrqMLfBQO5Nk8KC+u4ehzanKXc0R+DkedOq54QrkDo6nC70JoOVPay6rfaybsdW0L
 aS9IME5twonOEK4KJVPOQGtzFOIwSarx9WPE+z2Jvdjo0D95tFWeGFpe+iScAy3cM850v
 mfPokEdt6SgBQyHSDGJZJqVX4LVI5CR5W59oB3BGP4wC3KOubUwbKssH1BnaO5FM1T2/Y
 uunpko4yIPvGdoFZNYC3j4nMfQAOy77SpOMfweVC1R1PrY+Hxr1xhRbNROzXWJZQZOmB8
 V1l9UXeCqrsnKRnHGuSgJ0MLbf0LnRXxrOCtqGYoWCcjlglfmy8cRIDqaaU6oWjXKlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791629976;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=uHE/jjCzpjkDAz4iiaVp8eviUAo2ZaUxZZ5G7TQkqcQ=;
 b=KXddGg2vl6PnDRBPDxVC1CHiYZNhP5g2EuqMbws6swqg6HSljPpdCepZBoAZEIogTBVb
 mXww8PpOGIpV/znSl/WsVkVZvPuVVQF7yjKocSsyIuHE9o4uz8SoCkM2RlFEm2tBXDDJC
 tpyEnUn26W2zOXyBjoEc66D+NJQBajkx7gNncepxDHTE8R9zW/eRiZYYVVF25fj3dk5+p
 emOD6RN+OU4tBsHUct9UNL07TiStv96w6evEQK9UT0kInLjHIQs+jCATRkdqpbkZRIo3U
 9B7UsD6w/gf2iCvz0wYezDRXsNLLLyjGwd4uFW4lvEAcaPjXWPey2x22yxAT13ehWOg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ReFXV97W; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=lukma@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ReFXV97W
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3524D60670
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:59:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 51773108641; Sat, 10 Oct 2026 12:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791629519;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=uHE/jjCzpjkDAz4iiaVp8eviUAo2ZaUxZZ5G7TQkqcQ=;
 b=ReFXV97W6zozNfFyg4zwaY1vmgBcsgTg/hcrWcJLMEsfkuHeZCcOVrUjsXvzgEeljDokfv
 jTeO1Id2brSXsYPqDxD/Ir4s8zJuCpUIQvA98aYWS4+mhID/sumID3kF9A3SDVBkTRmJ+h
 xdrHVP1Q5MWFQMUdUYuarQxgBwldb8uSylRhzspfxL0E27fJBROf8e761kgSTAqQLHVc0X
 MXYo83jluVO8dSWQx20wBZA0Uyu0ZQZViXz0fKq6FBW2XdHsJYMy+OmdERP3qoXTzbGyUi
 EdS+u8/1N8764s9/tMtK8nwlabygGD2VNjOIgVKs1a48Tiu5A2gj2+Hib71vRw==
Date: Sat, 10 Oct 2026 12:51:49 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bradley Morgan <brads@mainlining.org>, u-boot@lists.u-boot-project.org,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Marek =?UTF-8?B?TW9qw61r?=
 <marek.mojik@nic.cz>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Alexey
 Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>, Daniel Golle
 <daniel@makrotopia.org>, Fabio Estevam <festevam@gmail.com>, Gaurav Jain
 <gaurav.jain@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, James Hilliard
 <james.hilliard1@gmail.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Mario Six <mario.six@gdsys.cc>, Michael
 Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Pengpeng Hou <hppiscas@163.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Torsten Rupp <torsten.rupp@8tronix.de>,
 Vincent Jardin <vjardin@free.fr>, Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH 01/26] board: powerpc: Remove MPC8548CDS support
Message-ID: <20261010125149.5b2ec50b@wsk>
In-Reply-To: <20261009215538.GG769217@bill-the-cat>
References: <20261009193704.13061-1-brads@mainlining.org>
 <20261009193704.13061-2-brads@mainlining.org>
 <20261009215538.GG769217@bill-the-cat>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sat, 10 Oct 2026 13:14:42 +0000
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

Hi Tom, Bradley,

> On Fri, Oct 09, 2026 at 07:36:39PM +0000, Bradley Morgan wrote:
> 
> > MPC8548 silicon is no longer manufactured, and the MPC8548CDS board
> > is obsolete. Remove the board and its SoC support.
> > 
> > Signed-off-by: Bradley Morgan <brads@mainlining.org>  
> 
> So, globally. As has been discussed on IRC already, please take a more
> neutral removal message in v2. The problem isn't that the boards
> aren't manufactured, it's that (likely) they aren't being actively
> tested and maintained in the community. We're fine with "obsolete"
> hardware if someone is maintaining it. Also, please rework the CC
> list (outside the cover letter) to include the listed board
> maintainers, and then only people that have touched the relevant code
> recently, perhaps with a manual audit or exclude some global or
> common files, when looking for who else to CC. Thanks.
> 

Maybe I would add my 2 cents...

There are a lot of MPC85xx systems out there - and probably (my guess)
is that at some point some customers would be "forced" to refurbish
them.

Some companies need very long time to realize that their crucial legacy
products may be removed from u-boot. I would opt for longer and more
"broadcast" obsolence process.


I had similar situation in the past when some Samsung SoCs were removed
from u-boot - nobody was willing to pay for re-adding them upstrem -
this means that they were kept out of tree.



-- 
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Managing Director : Stefano Babic
