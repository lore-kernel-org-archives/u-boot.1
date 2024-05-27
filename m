Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A153DC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 12:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40C8188354;
	Mon, 27 May 2024 14:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FB087EF6; Mon, 27 May 2024 14:48:00 +0200 (CEST)
Received: from mail.duskware.de (mail.duskware.de [91.199.88.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB7F488258
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 14:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin@duskware.de
Received: by mail.duskware.de (Postfix, from userid 205)
 id A3A3AA7E02; Mon, 27 May 2024 14:47:57 +0200 (CEST)
Date: Mon, 27 May 2024 14:47:57 +0200
From: Martin Husemann <martin@NetBSD.org>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v2 00/14] Introduce the lwIP network stack
Message-ID: <20240527124757.GE6853@mail.duskware.de>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <20240527092301.GA7851@francesco-nb>
 <23a33323-35d8-4ece-b57b-cdfbc318d3c4@linaro.org>
 <20240527094522.GA22281@mail.duskware.de>
 <ce97ef0a-29d1-4735-b44b-0ce517bb82d7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce97ef0a-29d1-4735-b44b-0ce517bb82d7@linaro.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
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

On Mon, May 27, 2024 at 02:45:01PM +0200, Jerome Forissier wrote:
> That certainly would work but again, isn't it a decision to be made
> by the device manufacturer or more generally the one who builds u-boot
> for the device?

Very true, and if you get the verification part working, your full solution
is better!

Martin
