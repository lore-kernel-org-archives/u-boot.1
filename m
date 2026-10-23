Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3C1606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 00:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FjkwHjFz;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=k6DkTlQ9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BB4240637;
	Fri, 23 Oct 2026 00:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u2E6L3Ojbut8; Fri, 23 Oct 2026 00:50:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 89A3C40647
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792716614;
	b=T+3wu/KzOZfohCjIuONdyQcmPS3llNhjJ3yUJnMfJM4e18grOfScJTvbH/9s6Fqh6iOX
	 hVhVkAY9IlWANnoh1TlODtapq42qxBXSYH24PnYqghsFoYAOrJScGgLP0aq2RJDOUggvZ
	 CgbVbWxq6jaLiEgT5LjeTkgo+A3CEFHlpecFyAzoAARepxW7euQJ2yrtZIzmZBA6Xv0uC
	 HSljqPpHpS3Pj+gnogzn0ms4izTykEG9pCm1oZxaJo9bQcahztfZFru7jDidgmeF3Lf8P
	 BkzVg45NoiqfHToIsU3PScc0xZQeAPMCJXoTMlDL+ALN3dTDJBy8IcWLSRZl0c2q0WA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792716614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Phx9iekK7xIN2lQjvTREk7vutV+zf+ic7I2qp00bo/8=;
	b=r3umW4pbDjEbI26sBvE7RgSsSLOI6adcZCSBGzTUF+3OtuEO00PSMT0YcIhU9XEl5/ox
	 zApvFTLfngxFb6t5RmaRhfIRsTmioIJAnfwG5k5+mx+937R8ubasF6UjQ7zhsqLPOzIp3
	 45b2w3g3boq79hbQnTkgjh/ywGI93Q1GksW1lVC4n7hX5Hlr8RtkNk/1+nRdz6suWRDQV
	 IhB0mMprDlIRS/hWX1+7RP2P8rqDUdUa7D4LMw3r54dEYte1vKGA0WNV+0YRNzLNjlnE6
	 IArTE0KJ61Sw6tWY6Rxshz535pIA1M2BQMazq7RLAeeyiVW7cbul28S/V+Yb2u/GibA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792716614;
	bh=Phx9iekK7xIN2lQjvTREk7vutV+zf+ic7I2qp00bo/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FjkwHjFzMWDSiwce0C8qPYZfQSryRYvnUeG4ez6ny9TcUaQmTOHzbtFpJjmSOUsjP
	 ftUBcebZQEnqdYcTlp4rziq4Vdy48injOR1AJYSSnMtFxeOmCQlTglsc0ye97sVVP8
	 XkZu84SHsCaFoMDyhukImozl/UGZfwrROaR5mrkabp+NkXV7bb2/yTDtINDYxCZEOP
	 y+7kjjMn+h4znufnT1iO99QfTvjIr52UxEWi069jk1f1d4oAb+BxGHD/Si8bjkllSH
	 cWhuxLOMLeg8WDmApsvicYX1p4rlYffrRsW56sjKnTjbW1UK/EBD2KVwXJw1qRqAel
	 F1eoasTFiVqJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89A3C40647;
	Fri, 23 Oct 2026 00:50:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 610F049D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46D8260650
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:50:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PyGSmP0mPjoL for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 00:50:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0192E6064E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792716612;
 b=KVi9jrOiuIuHZADglziWafhUt1f75pKAcpe8biL1agMLbQ7tSy/Jvx5iTvF20k2zEhSa
 purAERCcivUwRi4XRlD4EJwk+PLeGFSAWtxqA2lqt5oQtlQ0vydMMmP1k374ASnZH+oYn
 HrR93CEDX2X+yjrWv0tV9K4ctpHjUtKqNIY2mnlwr/+gQzproJBIbw10I0Z0oqE4IJ1oo
 jiL8FDnWesf9+Dft8BPsERVO9FbDMgNpnM0Jk8gwKtXLk/axOCDq4I2zedREyBzcReGqT
 1kvXpNAMwzPo+eMW7mr5D16R7FINqPi7RPdPksXz+2m9p3gkPKz4DUVzgM8llWGZcBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792716612;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=Phx9iekK7xIN2lQjvTREk7vutV+zf+ic7I2qp00bo/8=;
 b=cRgBz5efKqO29vIKZSqwTKLoOxLqS5esqGph6Bvtu1XtkxbD2Tbbw1w78HsKF9jZDxUC
 J0P8NHvZuh1fbXLZJBJ6j4LtL5MSGkVT7QAQtn56PO5hevKBkjlnHui+YSOMSXwmgkdxq
 aukrbcTEDaeEo+AEtlOXju4H3h1jNP9hZC4s9Z+IG5nlLob2ZSvZrIZgBrmta2+La4vdj
 m+me7o2X9f/yIsXZPUVazDRKXtISP2Dvnpo5blIF7lDH8AIoRMAsJ+kGc90aK4s5puOcw
 SsnTdXNneXbQR3ySJ9ZVR+rB3YrIWoTB2xT7f30MOtgpmAQU01t6CkCHGnYu5N2m20w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=k6DkTlQ9; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=k6DkTlQ9
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0192E6064E
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:50:11 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j9kvM5qntzKnxM;
 Fri, 23 Oct 2026 02:50:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792716607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Phx9iekK7xIN2lQjvTREk7vutV+zf+ic7I2qp00bo/8=;
 b=k6DkTlQ9DY1Gd4YDzlmW+8J1pHvnmGdVesxwhV2UQaoSZ8YHUZJbL/RIhQaBG3/O78tQr5
 zGmu/zTOK9CzxbMIgdG1/ZpFN3GD8CwD+hj/SAY28cx3v9tX2ebZPmU0CMntMOv+xHbFS/
 9D4lmoeJ/dikDIyMAu8zQwnrhV3pbCSLgkCCsSENNCLLOfOftTVgQqAE4xs9Fs4HH4lqd4
 1rZSY1+QhT20sZNKADg3PH9ZBlfDFJUQfpK1LdQwIs7lZHxS8zxASLP2PGOA3IsYaa2sEe
 saffCv5AllpuvzslloM63CjGj6K84GxU6DVMnJEHWCqSmkTcnu4eOJY0DIV4gA==
Message-ID: <66a9c580-05f8-48f1-8771-649e1977af7c@mailbox.org>
Date: Fri, 23 Oct 2026 02:50:06 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: xhci-dwc3: Add DM_FLAG_ACTIVE_DMA flag
To: Jacob Procee <sn125164@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.u-boot-project.org
References: <20261022065936.125731-1-sn125164@gmail.com>
 <20261022165835.14798-1-sn125164@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261022165835.14798-1-sn125164@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 936d4w8znyx3kic1w4suai74fukiz3r5
X-MBO-RS-ID: df5fde521b24059bb79
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 6:58 PM, Jacob Procee wrote:
> xhci-dwc3 is not removed before U-Boot hands over to the OS, so the
> controller keeps running after ExitBootServices or bootm. If a device
> was enumerated by "usb start" (for example by the default preboot
> command for USB keyboards), the controller keeps polling it.
> 
> On Apple Silicon machines (tested on a MacBook Pro M1 Pro, J314s), a
> USB device that is connected while U-Boot runs is then not detected by
> Linux until it is unplugged and plugged back in. Running "usb stop"
> before booting avoids this.
> 
> Add DM_FLAG_ACTIVE_DMA so the controller is removed, and its DMA
> stopped, before the handover.
> 
> Signed-off-by: Jacob Procee <sn125164@gmail.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
