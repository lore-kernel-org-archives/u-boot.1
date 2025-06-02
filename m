Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079C5C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 12:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B75A828BC;
	Mon,  2 Jun 2025 14:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="JCMBYWr1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1901D82145; Mon,  2 Jun 2025 14:40:09 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB92681FEE
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 14:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2DD4414805DB; Mon,  2 Jun 2025 14:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1748868005; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=51iZ8Qm+h9sF7ynWFnjBEsJm2LNL9SLlhripafL/HB8=;
 b=JCMBYWr15JnRZpopX4tdsbdidScyvUXsZCeH8WA5qcgGHtobqm++ZlFJlDw7pqqlMqM2Ba
 C4PFe5jtQM7E+Wiry0bQStqCTsc7F/2lfute5flLl6hT1I8xPYu04chUt2JWER61LJvP6d
 4YUFsZnZHRVYbSAPJ/87LUFQZxbrs1jAILoHgHozUHkuhvJ0iECwC3InQIfqEu5D9ZeMw+
 QF+8V1eucLkvklWjPbgBmH33rmVqFuRKCK/tf3R/M0SFjV25HNRlhaA9plMtupi5zmLZ0R
 Ko+e4EAvO63//3OOnxuz7YYgt7OW7Ob6+jpe00Z3Wu4r9Dd9E+uIGrTp2QtQ8Q==
Date: Mon, 2 Jun 2025 14:40:02 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Simon Glass <sjg@chromium.org>
Cc: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 0/5] Create FPGA Partial Reconfiguration (fpga pr)
 command
Message-ID: <20250602-fervor-pelvis-a4f4a4d5ef24@thorsis.com>
Mail-Followup-To: Simon Glass <sjg@chromium.org>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
References: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
 <CAFLszTjiRpYaG=Hx2fo5gGowpfkww1t4=W7iaEpgbU3OgWKbuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTjiRpYaG=Hx2fo5gGowpfkww1t4=W7iaEpgbU3OgWKbuQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
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

Hello Simon,

Am Sun, May 25, 2025 at 07:05:46PM +0100 schrieb Simon Glass:
> Hi Naresh,
> 
> On Sat, 24 May 2025 at 21:37, Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com> wrote:
> >

[…]

> How about creating a uclass for FPGA, with an API? I think it would
> help to make things more uniform.

FWIW: that uclass is named UCLASS_FPGA and it already exists.
You suggested it. ;-)

I introduced it back in 2022, but it is currently only used for logging.
There is no API except for the uclass id itself, yet.

Link: https://lore.kernel.org/all/20220930120430.42307-2-post@lespocky.de/

Greets
Alex

