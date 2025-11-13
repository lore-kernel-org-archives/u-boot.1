Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEAECD6E6C
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 14:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E9883E86;
	Thu, 13 Nov 2025 15:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="jwe0WwG+";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="Ll6lgoXR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B36A83E96; Thu, 13 Nov 2025 15:39:27 +0100 (CET)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4529D8394E
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 15:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-cnd8.prod.antispam.mailspamprotection.com;
 s=arckey; t=1763044765; 
 b=GAO9B3WjEnMD5r62yQXBw1u+gh7PFeRfDh0ibbPDqJcs012lkgLSYS84IjsL4rJ5rilvV8pmYi
 jpZ2pxp2Y5RS0jwicVe3yx9cGvwkic/f1cG0K7gY/uIime+CBBQOHfghSAT+FiUJdvty6iNReX
 QNfjWJVbMbRpnmt7iQezFaDl93w4AUVIk5GA1ahbAZrDTZcBYRzDd7pIsAHtqjL7WE1JTR+x6t
 6aKDPpzp91xyrzn8Yohcmomb4WGtWfpyT79UR4pBP//A0y9Dnl1cc8N04zfjHdZk3ei5sDZVxN
 kaPpxTLW+1JdUMlus2CKwsWZKbGN5OFOlf6YXA6cDMw4hA==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-cnd8.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-cnd8.prod.antispam.mailspamprotection.com;
 s=arckey; t=1763044765; 
 bh=NeJK8em8Z5opohseF6YgXbUEJndECdJgV4+PP896Bl0=;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
 b=iCwHptnW8t59zhgH2hq3Mz/kRycoait6rWks89NuSQgBPyIZIs9B3b480koFCU+Rc8hYPebA49
 q5NLQHq7BEI9bDMhh5Kh/xa1bC4bleAknaRGHw4M3XVbmypv321V0j7i3r9AhQYor8SWmC0hkK
 /WLC8qi0Wb68Vpy2YSizuhGxjlEARtShWn5Fl5kxNSPgvIE+DxQ758dw3eEBd9Gc7po2p/IYoO
 lz+5jLUhqmz70PhZw3YhLj03cfzBzbYS0YzNVkuLKKLTy+aaOPbmkYDIrhnfG3vG2ET+FKXSrv
 2e8Dn55IGhi1YkdRbI79ao6Iaeiyi/sqS+/vMVN57Sr6jg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
 :From:Date:Reply-To:List-Unsubscribe;
 bh=KWcdzDZsHZh73TlqNxd1kybmZoiKu+HW5adhOrPXiTg=; b=jwe0WwG+l10IO/sy8ZX7VTUbPe
 ifUT50TbuVfp+VQDbSxtO5xDfid8lg6HmCZmSz7aUV7gJ+vSXsgFuZJ1+zZurb+tkI/YcEMdhozr8
 ZBfobX54UJEcqjnHVswfvqGAomcKId1nZOpHx6GsVRhB7HonXWQ7JQp4K43uD2G+Zjhc=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-cnd8.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1vJYTq-00000004TW5-2SUx
 for u-boot@lists.denx.de; Thu, 13 Nov 2025 14:39:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=KWcdzDZsHZh73TlqNxd1kybmZoiKu+HW5adhOrPXiTg=; b=Ll6lgoXRV+tb2DV/N97qhPcpAX
 uEyO7kp/GYhbmQy4teihPW1BJ/szfN9CbAuZr4enyONO7X2b+uj3rN3pCjm5e5aE9obcFjsrjVjV3
 zUQQv7lAMQvnUWHMdtF7tcKwkEgbonkM+MOYDzxgHPJjRR6DR7M8JlWnV8poJo8REO80=;
Received: from [217.201.253.235] (port=36171 helo=bywater)
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <francesco@valla.it>)
 id 1vJYTl-000000009Ly-1DLY; Thu, 13 Nov 2025 14:39:17 +0000
Date: Thu, 13 Nov 2025 15:39:16 +0100
From: Francesco Valla <francesco@valla.it>
To: Javier Viguera <javier.viguera@digi.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH] imx91: fix ENET1_TD3 pinmux for GPIO function
Message-ID: <aRXtlIBXvl-nBriQ@bywater>
References: <20251111-imx91_pins_fix-v1-1-f9347f896cd4@valla.it>
 <CAOMZO5AD6BQP3WhcP_NBMm33Fs2Lxao7yvbC9DWrPz8q3_5nNQ@mail.gmail.com>
 <dff97ea3-5b81-4624-b120-ba43da8b280c@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dff97ea3-5b81-4624-b120-ba43da8b280c@digi.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 774e49e0289a8848e1e2f283234eb951
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vJYTq-00000004TW5-2SUx-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-cnd8.prod.antispam.mailspamprotection.com; 
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

Hi,

On Thu, Nov 13, 2025 at 02:33:05PM +0100, Javier Viguera wrote:
> On 12/11/25 22:15, Fabio Estevam wrote:
> > Hi Francesco,
> > 
> > On Tue, Nov 11, 2025 at 10:19 AM Francesco Valla <francesco@valla.it> wrote:
> > > 
> > > Fix a typo in the GPIO function for the ENET1_TD3 pad, aligning it to
> > > the function specified in the datasheet.
> > > 
> > > Fixes: a9d562daa3c3 ("imx: Add iMX91 support")
> > > 
> > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > 
> > Nice catch!
> > 
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > 
> 
> Just for completeness, I think there is another one:
> MX91_PAD_I2C2_SCL__GPIO1_IO3 should e MX91_PAD_I2C2_SCL__GPIO1_IO2
> 

Another nice catch. I'll send an updated patch with this fix too (and
your R-b tag).

Thank you

> --
> Regards
> Javier Viguera
> Digi International Inc.
> 
>

Regards,
Francesco

