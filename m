Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F94210F2862
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 17:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94FB083FAF;
	Fri, 27 Mar 2026 18:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=online.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36B8C83FC6; Fri, 27 Mar 2026 18:25:24 +0100 (CET)
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE9483E7A
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 18:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=online.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=legoll@online.fr
Received: from [10.0.0.2] (unknown [82.65.243.93])
 (Authenticated sender: legoll@free.fr)
 by smtp4-g21.free.fr (Postfix) with ESMTPSA id 68F6F19F5B2;
 Fri, 27 Mar 2026 18:24:57 +0100 (CET)
Message-ID: <241ef12b-4b06-492a-8d12-eb24643cd0a5@online.fr>
Date: Fri, 27 Mar 2026 18:24:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/16] Add board support for Spacemit K1 SoC in SPL
To: Guodong Xu <guodong@riscstar.com>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, xypron.glpk@gmx.de, randolph@andestech.com,
 dlan@gentoo.org, junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
 <87d4cc89-e60a-4365-b6c0-efe5b20d0c7f@online.fr>
 <CAH1PCMa_+n-sVeFnUwKwXcSyRrpc9f9MeCPnR2WNbLA+V85XPQ@mail.gmail.com>
Content-Language: en-US
From: Vincent Legoll <legoll@online.fr>
In-Reply-To: <CAH1PCMa_+n-sVeFnUwKwXcSyRrpc9f9MeCPnR2WNbLA+V85XPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Guodong Xu,

On 3/27/26 04:10, Guodong Xu wrote:
> Thanks for testing the v3 K1 SPL patchset.
> Actually your result confirms the SPL patchset is working correctly and the
> build/test procedure is generally complete.

OK, thanks for confirming.

> PS: I added some walk through to the key lines in your log below (for you
> and for the community's future reference purpose), but for here please be
> noted that as I said in the doc patch [1]:
>
> "After DDR init succeeds, SPL proceeds to load U-Boot proper. If
>   U-Boot proper is not yet available (as in SPL-only testing), you
>   will see SPL: failed to boot from all boot devices - this is
>   expected and confirms that SPL with DDR init is working correctly."
>
> [1] https://lore.kernel.org/u-boot/20260311073741.80616-1-guodong@riscstar.com/

Yes, I missed that part of your doc, so as Heinrich says in

his comment to the v2, you should move that higher or make

it more obvious to see.


I was expecting to see some of what you had in v1 of the

doc patch, in "Expected Output".


Is there some debug macro to enable that output ?

> Back to the patch series itself, your log is a good validation of
> the v3 SPL patchset.

OK, in this case you can add my:

Tested-by: Vincent Legoll<legoll@online.fr> # BPI-F3 (8GB)

for the next iteration, or directly to this v3 if there

is no further one.

