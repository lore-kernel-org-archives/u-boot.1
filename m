Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1180606A33A
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qYCJbhpx;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GirL+VBo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA96480F70;
	Wed,  4 Nov 2026 09:31:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eUn-rLE-Lg_q; Wed,  4 Nov 2026 09:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D8E580F3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793784694;
	b=IefXbdmnjIyjI6r1cm5BTXN12j1Yz4dZIxu/Fq65D1hcKGeBUiZTLpGcd1JNG95lTxZL
	 oOdVqVeFJttBS1c0D5S+LYYxz9U7UU2vds5K7MFJT2XZaMf+RChtF5o5FqGgC51xgLijV
	 kH39QJ7zUndJexZUdGSeaA629CBxPgeYx4svOkOUpc24pV6Q6hyUaw8prRI5NHhQuDkmr
	 ow8tQGEpakx1PaNdY+f1cMUWHQE7pOzv3MEv0/4dIqsD7KyHomtDoCkOYTbS4n7dw92TJ
	 Qtah3hVFZ1DRm2SRgNIxnnX7LVWUmcurOVmOmQ5F4fIT0zVOm7VDto2BNyoYLqXVUGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793784694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zdFAJdvdhu4o4sYBaLhfPIFxAUXpCJqebd1JY1s8Ans=;
	b=o2EUecHGlfIZNN/OJGK+idQzXo1V+H7BVSlItYMPm3u/fmWd8SmquR+oCX3BnYQfQeDF
	 EzArK3nvAUZR3PW+kqKEEk28Ef61UcMtqA+RuRx2877RWK7Owh79LepwET2Uowqvq0smE
	 otvlW3nPombitv/BvuEJYEvjOo0KB6Bx5d5gQY4IOWe8JVK/W7/aQaWvfZReeMpXm1q8V
	 GzOIlBH4VJllJuPEDw8kUc/oExav2cPaIV0ipLkNpGO+2Nd0Z7w2oK7qBPc3ZafllxhUC
	 EbtpodS5Iec0ofjIqj5ULW3zDLn1R4Drx66Y2DLO8nskJZ5/2R4HhNOa2jPPzIcjnug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793784694;
	bh=zdFAJdvdhu4o4sYBaLhfPIFxAUXpCJqebd1JY1s8Ans=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qYCJbhpxjdbgl7KHh7cju+iAYCYTq4Gsk7ShX4PPYFFp3ldBCeY9RARKtVLQANsZU
	 WV/T2X7oj+t0L1TrwkU+6Zs8cYZl/t3PjYc94hipDd+lMmUKVS8BP+DRL5+pggre3O
	 mabTly5slEg4cBnPKCXwDysIHzLZ0Cb3oTqwU0qqqNvCJiIoxBaSpxauJPR/110c4v
	 Hr5OkUROq9hB2GXSCGtZtUzqpK2++FGHaZzcezzpa+Fh1dC4xSbbvB5ulcMtn5EIo7
	 BuB61uVrbgy/zQpirj4ObeMLfcWXKz55bJwggQTG08wcaiGhOs7Py+58AB9wygP3v4
	 e5WAD2ffvx+bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D8E580F3E;
	Wed,  4 Nov 2026 09:31:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 046F4A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDF546076F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8HMEvHIwDoDk for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:31:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5671260759
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793784691;
 b=af06TNrC7hQmkbU+pDmcunsiJ0HT1hl4Ra7CAgIIE8jm/Q/oRW0nUFzjC3E6tTt2K8DF
 3jTGU7q0K3PBexRJqAog9vgckP5JtXyC52Ifq4t+Mqt7UQHe9En4hqPidngbkBx9mn/1C
 EkYVNPPVSWPVLzY2KatoMNNes//hRrh6zGgXe46/EdXRV0FCHq1PDjyuRX/Dy5W4rFSDL
 Gc0bNlA3h79H9Tcc2pYOmP1Ckaj5KRDDZ9Q/M2urQzmGpIBL0HKl79Jd/afZqS+shotPT
 MgZ3Ycpi/wvM2cPxQ/RYZ7l4PAXIqXHrGG2i/TNbVMCCB/GoAeLNh6pDPPc25e1pBFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793784691;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=zdFAJdvdhu4o4sYBaLhfPIFxAUXpCJqebd1JY1s8Ans=;
 b=Ewwp1fi4gUczcHn1MC9eswZqGOgHtqKeI2VwD4jqzgWJiBdzc23vXOn8Un+tV2eEDUc3
 v2jk3vG4cCoal8XKaTrRpjqtKiGT0a6C81ykPhmmTtGwM8BuweO9jBDeyoKYJpF5YRkWM
 aqtDKvpXKTgAMXZhE7zn+qWzfyi9lNT5aqJk/+yB4UY4jEMtv4+43lFgMpjPuAVFJckwB
 4qR4lgKG26s5WPKfUfNhmmJ8kWZT/Gr8llxtXq/81fvNcTzeY7ogCKgZdiQhQc3nQmHCd
 iUmxns/mCpMkFc+xXEYcmjSjyQ8CCAzX+lT8VyonMC8aqHERnBLWoynZ0qsCkRxCvlA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=GirL+VBo; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=kory.maincent@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=GirL+VBo
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5671260759
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:29 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D2679C8F46C;
 Wed,  4 Nov 2026 09:32:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D26F160770;
 Wed,  4 Nov 2026 09:31:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7551C103291F8; Wed,  4 Nov 2026 10:31:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793784686; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=zdFAJdvdhu4o4sYBaLhfPIFxAUXpCJqebd1JY1s8Ans=;
 b=GirL+VBoGGSEtj1/2NYKuX3lHr7vg6s1cm8SMSdj6P+k3Dz1u4ehLVQcW49mHRVxUn36Wj
 Ajtma5cnuk0hZIurffsWqzrnD71rcyQiy6DONFRPQGDxqLbA0LpFoHO/64ns5bq9iiF6pQ
 7Tn+kckK9QdVmD7LGoI6WYXbA3D6ALHDdRtdi7GU+y2iF+8rWI+TP6u96skFXRil8jkT2b
 sTV/pxs3gNlxpjClpuwOQ95WVTEzr/uO29Qxh3muIuOvOVl13v8qHYF1hM5pVCaShW60yp
 g6Pq0xpHt6A5dCKBNrW0c5m7TGtmgMLXd3L2j++T9f22vZ0WW/aJdEmjHbyjxQ==
Message-ID: <b015e288-5d96-4f3b-b7d2-c7de3c2e6a03@bootlin.com>
Date: Wed, 4 Nov 2026 10:31:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 29/33] boot: extension: allow longer overlay file names
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
 <20261104085036.4012238-30-dario.binacchi@amarulasolutions.com>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261104085036.4012238-30-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/26 09:50, Dario Binacchi wrote:
> The overlay file name is limited to 63 characters, which is too short
> for the Linux overlays named after the base devicetree, such as:
> 
>    st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtbo

Oh wow!! That's a long dt name.

> Increase the buffer size to 128 bytes. The structure is never passed to
> the OS and all its users size the overlay field with sizeof() or
> strlen(), so the change is safe.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

