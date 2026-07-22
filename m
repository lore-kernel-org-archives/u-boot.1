Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AB7C44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 288B040733;
	Wed, 22 Jul 2026 07:17:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n2spYJ52y1nq; Wed, 22 Jul 2026 07:17:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3DF7940718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784704646;
	bh=O9ndg3q7on8I7OgNaG2HoBB2hJ68cYa9Kz7HP+KtfjI=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VGSpVGLsZxqKNR+KREKxRkWd0CL9d7sWTVygUmNaFvqhLzu+tyZWUSc1LoFrdpoUT
	 3qFXbr2nSBqJ1dhteuw9njasnE5YzEVw2oexbaNoT0A5icfD+n+6fxRKtvmgMWkzFS
	 Cd9RN4kysxS9GL7Hq1G6xOhzYvXklVQR0wiBoHRiZjwYofA3WxDgAVg3o1XAM884DE
	 u2YN2NcVF6+4fza1aJW7PaxdtrB3wgIOHQUP9tIoh92IthyjXzQnDfqoZAa6xag12Q
	 cnxXROICcubGL+vp6hGGlCxqTvZC19gCyUvutkhB2DKpoWxdnOUmwUSyvxvY7SOod2
	 NzzPji+6ejLZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DF7940718;
	Wed, 22 Jul 2026 07:17:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE61F42A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C585760740
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zf3fRQ8PNzEZ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:17:25 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B205060739
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B205060739
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B205060739
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:17:24 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C090848BA; Wed, 22 Jul 2026 09:17:23 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF166803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:17:20 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 80C7443C75;
 Wed, 22 Jul 2026 07:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0291F000E9;
 Wed, 22 Jul 2026 07:17:18 +0000 (UTC)
To: lukma@denx.de, u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>
Cc: festevam@gmail.com, peng.fan@nxp.com, uboot-imx@nxp.com, 
 ye.li@oss.nxp.com, xu.yang_2@nxp.com, jason.he_1@nxp.com
In-Reply-To: <20260522075512.1291485-1-ye.li@nxp.com>
References: <20260522075512.1291485-1-ye.li@nxp.com>
Subject: Re: [PATCH 1/3] usb: ci_udc: set correct ep type in ep_enable()
Message-Id: <178470463686.167436.12520929123464154328.b4-ty@b4>
Date: Wed, 22 Jul 2026 09:17:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784704639;
 bh=O9ndg3q7on8I7OgNaG2HoBB2hJ68cYa9Kz7HP+KtfjI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=bjiByBYsd32erySQ20mdbNhR58PpfsdaRO3RA3TYquxCjWzBQyZU8cuEEGMrbUVif
 CxZxCe6qhk1hL8XZvDD5meYW2sg57UVC2DTFEf4l8SGrFU1S800Gx/TG6fjDhGGM57
 sMEZ26OGGRnd7GaMFeNTyC28QvzcaU1mK1wzsu/IM15DEWO6aJUrGiMb7XGRdIqv0X
 ARyw7XFCXdzSmdfnlq2GPkgXpC6MXQ+9SPj3R7oawNF+zU9LzVzB4UqpPp/BRDBjz8
 S6273i21BvrAWsMKvpCmB4JPRTTsyUtKoHTjUtUEF+97kM9kptUc0PqKhSrMe/BwLu
 M0jC1QrVJvhRw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=bjiByBYs
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="bjiByBYs"; 
 dkim-atps=neutral
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
From: Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On Fri, 22 May 2026 15:55:10 +0800, Ye Li wrote:
> The Endpoint Type in ENDPTCTRL register should be correctly set
> according to endpoint descriptor, not fixed to bulk. Otherwise,
> unexpected behaviors may happen.

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/3] usb: ci_udc: set correct ep type in ep_enable()
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/eed2ed75883bdf029be9325fb9dd9263d921372e
[2/3] usb: ci_udc: Update usb request status
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/b79147bbd47cd2d50836dc0a57376f4820663637
[3/3] usb: ci_udc: verify all dtds are inactive before completing request
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/b6056097247385c24c23ef39ebc04238336d11e2

--
Mattijs
