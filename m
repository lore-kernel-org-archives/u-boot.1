Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32427CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 13:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B1E8340A;
	Fri, 12 Sep 2025 15:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PW6a/R05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C2683285; Fri, 12 Sep 2025 14:59:22 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898CF82AE1
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 14:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mathieu.dubois-briand@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 1F2CE4E40CA2;
 Fri, 12 Sep 2025 12:59:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EA01760638;
 Fri, 12 Sep 2025 12:59:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 99B6A102F2A9C; 
 Fri, 12 Sep 2025 14:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1757681959; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=wJse3IaL2YEnMqZyQ9xWCC1H+enn9Ey7vNWt36W50iE=;
 b=PW6a/R05k4n7EesMJIyqse6cXq/ClP/PX54yQbeQZ/H99YC6UA6YEKp40MrmcDgY/pGiW3
 +csg+Bb5WjO5a8jsEccYWeS0dkMCXwRa7Q7uCj3LVxnWEq3iC3YncBPhD/y+8DhOmYdH9/
 0PSUXkT+COg+U2AHIq+kBD4urt7GB8n1S1yXS/USyXkXwYd0cj227sO2qauXNXYjkq+1Jq
 lyS+4q3xAHRe9OdnTdLRyhVjU2YbaFJdYbAYfnmxyBNd+IWjfWjIrVdbO2EVXUkYgi1ens
 lhvIzjjh4cikBkw5ln4Rggdd9VNm9WZoSJS3ewKHivcTu4tMHmIYSjkbQRj1Ig==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 14:59:15 +0200
Message-Id: <DCQU92XFNAKE.31EO6GEN3WNZ1@bootlin.com>
Subject: Re: [PATCH] imx93_frdm: Add support for flashing board with UUU
Cc: "Stefano Babic" <sbabic@nabladev.com>, "Fabio Estevam"
 <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Tom Rini" <trini@konsulko.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250911-mathieu-frdm_imx93_fastboot-v1-1-c629d8b7c8cc@bootlin.com>
 <20250911151548.GN124814@bill-the-cat>
In-Reply-To: <20250911151548.GN124814@bill-the-cat>
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 12 Sep 2025 15:04:58 +0200
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

On Thu Sep 11, 2025 at 5:15 PM CEST, Tom Rini wrote:
> On Thu, Sep 11, 2025 at 03:34:28PM +0200, Mathieu Dubois-Briand wrote:
>> Allow to flash a board using NXP UUU utility:
>> - Enable fastboot support on USB.
>> - Add fastboot partition aliases with names used by UUU. Also add extra
>>   environment variables used by UUU.
>> - Set 'dofastboot' environment variable based on boot device
>>   configuration, allowing to automatically enter fastboot when booting
>>   from USB.
>>=20
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> ---
>>  board/freescale/imx93_frdm/imx93_frdm.c   |  6 ++++++
>>  board/freescale/imx93_frdm/imx93_frdm.env |  8 ++++++++
>>  configs/imx93_frdm_defconfig              | 13 +++++++++++++
>>  3 files changed, 27 insertions(+)
>
> This needs to update doc/board/nxp/imx93_frdm.rst as well, thanks.

Sure, I will update the doc.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

