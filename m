Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BF0CF6BF0
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 06:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5D083C6E;
	Wed,  7 Jan 2026 07:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0016783CDC; Wed,  7 Jan 2026 07:06:29 +0100 (CET)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id 8EEBD83C4B
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 07:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hayashi.kunihiko@socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 07 Jan 2026 15:06:23 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
 by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id 61EC92091484;
 Wed,  7 Jan 2026 15:06:23 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with
 ESMTP; Wed, 7 Jan 2026 15:06:23 +0900
Received: from [10.212.247.110] (unknown [10.212.247.110])
 by iyokan3.css.socionext.com (Postfix) with ESMTP id E1AD510A003;
 Wed,  7 Jan 2026 15:06:22 +0900 (JST)
Message-ID: <689907b7-f185-4357-8d84-f9ef23036701@socionext.com>
Date: Wed, 7 Jan 2026 15:06:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [FYI] ufs: rename split across commits
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi all,

While reviewing ufs history on main, I noticed something that might confuse
future readers:

  commit 1de63f1be48b
     Message says "Rename ufs.c to ufs-uclass.c", but diff only deletes ufs.c
  commit 067c1b033282
     Adds ufs-uclass.c together with .post_bind changes

So the rename is effectively split across two commits. No functional issue,
just a heads-up for anyone using blame or rename detection.

Sorry for the noise if this has already been discussed.

Thank you,

---
Best Regards
Kunihiko Hayashi
