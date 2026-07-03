Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A87C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 182BB84AA1;
	Fri,  3 Jul 2026 14:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="tdznb4wd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41372846A4; Fri,  3 Jul 2026 12:19:27 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39AF7841F2
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 12:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 7AA20C79ABE;
 Fri,  3 Jul 2026 10:19:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9EBC660300;
 Fri,  3 Jul 2026 10:19:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4BDC8104C83DB; 
 Fri,  3 Jul 2026 12:19:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1783073964; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=eXFm1dhydNimOIaCa8dzKEa76edAEPMgHsZQjRr7R7M=;
 b=tdznb4wdHqH2FFfgsPk04SscmQpRwbcpZSKphBqZ8xAbrRk5G2TN1YhfK4d7gv6aO7RbOX
 +8Mr9tXwa3nGS2qg/q6IKDG0coxfgsk3y7z9p6asW09pyZHeEE2cyBZ46/5vDNUVDxVhzS
 Uv5rZF1Sq2f41kfgtt62oMByS/4jn3Q4N07FT0Jf0xziXFSf2VnueMYtYv0YDGjWAThFiC
 fW7wXb9jMDuEmSNUdLpUDj0a051zLENiuGGKRZ/rpqp6YX+SZlX7TK4WNwWr9ntWQqlhpu
 UiORm1acj7nWhdfsalaTd+duQynaTVYeTX+1x5LuEWPCYBmMB3XHDm8j/xTONQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Bastien Curutchet (DAVE.eu)" <bastien.curutchet@bootlin.com>
Cc: u-boot@lists.denx.de,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Michal Simek <michal.simek@amd.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Andrea Scian <andrea.scian@dave.eu>,  Tom
 Rini <trini@konsulko.com>,  Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH v3 6/6] mtd: rawnand: nand_base: Don't overwrite
 read/write_page_raw() for soft ECC
In-Reply-To: <20260702-dave-upstream-nand-fixes-v3-6-3814352982ad@bootlin.com>
 (Bastien Curutchet's message of "Thu, 02 Jul 2026 15:08:46 +0200")
References: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
 <20260702-dave-upstream-nand-fixes-v3-6-3814352982ad@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 03 Jul 2026 12:19:21 +0200
Message-ID: <87qzlknzo6.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 03 Jul 2026 14:59:42 +0200
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

On 02/07/2026 at 15:08:46 +02, "Bastien Curutchet (DAVE.eu)" <bastien.curut=
chet@bootlin.com> wrote:

> On writes, the Zynq NAND controller needs a bit to be set in the address
> register for the last 4 bytes sent. This is correctly handled by the
> zynq_nand_write_page_raw() operation but the callback is overwritten
> by the core when soft ECC is on. It leads to write failures.
>
> Don't overwrite the write_page_raw callback if it already has a specific
> implementation in the NAND driver.
> Do the same for the read_page_raw callback to keep symetry between reads
> and writes.
>
> Signed-off-by: Bastien Curutchet (DAVE.eu)
> <bastien.curutchet@bootlin.com>

This solution is aligned with what we have done in Linux as well, thanks
for the fix which seems rather straightforward this way.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
