Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F050FD116F5
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77C3183D5D;
	Mon,  1 Dec 2025 19:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1764614346;
	bh=2jO25RLtTT7AhLSlZI06UXETOPd/r1eKJqjyhZDuudU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I9c5ncJx9GCuBvYDumYCtOZIZo0AWFdYS268ygK9WTO2L1BQvTsNJCB65839wu1wl
	 SoBzSEuZ5jeA7oAHQ9TqSQhqviALWWlalia33cAdDs4nz7m5vJeemU3RuZva2QINny
	 O/wjGLWJ3HeHApRXwMzfjZoF4ff4gj63tS7PNwq09lqzTIoH3sNGdwzTrhbXyvsqb4
	 uy6THczBGVRSpiqn+2FB1tbDWUk68iyisPyU5kAMDAeJewpGRObSJY0zZthWjbVQCl
	 F/QccpKJ9uYH6CAVEhfPSS6wqEPT8xwyUe6kqS5JRowyq5mduDJIQ9T5I5AcVGWlgh
	 IDaEeIwcopsyg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB8D83D62; Mon,  1 Dec 2025 19:39:05 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A15083D17
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="DfvlpFDT"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 504351038C101; Mon,  1 Dec 2025 19:38:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1764614340; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=2jO25RLtTT7AhLSlZI06UXETOPd/r1eKJqjyhZDuudU=;
 b=DfvlpFDTrW+8mlqBGKqed0Fji3ERqDSJ34tJtroWN+j8bsosUJCd3r7/XWpiknVEUv94Af
 /+2ts6ZGJh3PnTYvmTnxdrbURylWMfnUvyECqH0JfO5i6bObZA3V8kC98jYa5zYyIiG0Jf
 n+l9BfCMpFOsvU04/VCEnUg9udyzQXnrvVX0Wdb8zF2bPlcLgBhV0/XNIegdK0JDVfciWS
 TOxKjS4Jpb9ZKYhrp1rPaSW02SiL4A65z1loF68sKSuor29F11+ZF61naedxRjWL4n9wlA
 QIqy0fDQsCT2Kug+iheG/gfAXX34B68fL8lv5RthHnO3dOY+3s4MVB5GTjPO3g==
Date: Mon, 1 Dec 2025 19:38:55 +0100
From: Philip Oberfichtner <pro@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v5 0/3] Harmonize image size checks
Message-ID: <aS3gv_Mfv4h2ZL4H@eryximachos>
References: <20251110091256.2422534-1-pro@denx.de>
 <aS3evAXY7dTqGfdq@eryximachos>
 <20251201183720.GQ303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201183720.GQ303283@bill-the-cat>
X-Last-TLS-Session-Version: TLSv1.3
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

On Mon, Dec 01, 2025 at 12:37:20PM -0600, Tom Rini wrote:
> On Mon, Dec 01, 2025 at 07:30:20PM +0100, Philip Oberfichtner wrote:
> > On Mon, Nov 10, 2025 at 10:12:53AM +0100, Philip Oberfichtner wrote:
> > > This patch series aims at harmonizing image size checks, 
> > 
> > Hi Tom,
> > 
> > I don't want to be impatient, just to make sure this one won't slip
> > through the cracks: What's the current status? Do we still have another
> > reviewer we're currently waiting for?
> 
> Yes, Marek has said he'll review this when he has time, and I know he's
> going to do so as soon as he's able. Thanks for your patience.

Sure. Thanks for the update!

Best regards,
Philip


> 
> -- 
> Tom



-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================
