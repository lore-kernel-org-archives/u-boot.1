Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2D9C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 14:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFE28769A;
	Mon,  4 Dec 2023 15:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gnudd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7417787927; Mon,  4 Dec 2023 09:42:34 +0100 (CET)
Received: from mail.gnudd.com (mail.gnudd.com [93.91.132.248])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1C587896
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gnudd.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=rubini@arcana.gnudd.com
Received: from rubini by mail.gnudd.com with local (Exim 4.94.2)
 (envelope-from <rubini@arcana.gnudd.com>)
 id 1rA4X8-0001XK-HQ; Mon, 04 Dec 2023 09:42:30 +0100
Date: Mon, 4 Dec 2023 09:42:30 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: marex@denx.de
Cc: festevam@gmail.com, u-boot@lists.denx.de, rogan@dawes.za.net
Subject: Re: [PATCH] tools: mxsboot: pre-fill buffer with 0xff, not 0
Message-ID: <ZW2Q9quBCfffClG7@arcana.i.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
In-Reply-To: <a9f1fbe8-d604-4df0-b390-2be147bdd965@denx.de>
References: <a9f1fbe8-d604-4df0-b390-2be147bdd965@denx.de>
 <e7b025bd-3498-4899-a73e-c55ff7a81f7a@denx.de>
 <ZWy2Chxgz9mRxGQN@arcana.i.gnudd.com>
 <CAOMZO5Ajq2L9-pNLqq0JGUmWdn5Lw=SeQsoZZ1YNYJbC1gJZQQ@mail.gmail.com>
 <ZW2JNHXCeO+Szif6@arcana.i.gnudd.com>
X-Mailman-Approved-At: Mon, 04 Dec 2023 15:39:38 +0100
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

> But what about the bad block markers , do they get erased when you write 
> this U-Boot image into the NAND ?

The image includes OOB data, because the rom-mandated map is different
from normal standards. If OOB is zeroed, blocks appear as bad (correctly!).

By memsetting to 0xff, before filling data structures and checksums, we
get a binary that written with "nand write.raw" works properly (the rom
is happy with the format and boots) but doesn't mark blocks as bad.

[actually, only the first half-a-meg is with-oob, the trailing part is not,
and the image is partly written with "nand write.raw" and partly with
"nand write". Hairy things based on hairy vendor choices in hw/rom]

But tools/mxsboot works fine, and saved my day (or more).

thanks
/alessandro
