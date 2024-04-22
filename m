Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88989C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 19:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E77D889D4;
	Mon, 22 Apr 2024 21:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OyLIYw4P";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EfIiSJpF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEED1889B5; Mon, 22 Apr 2024 21:48:42 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1640889D4
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 21:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VNbQv4tjfz9sly;
 Mon, 22 Apr 2024 21:48:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1713815319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5InrFehZqt7jeVhbxGe5Lj5QJ5U2JF3LlQXHY3E0EFo=;
 b=OyLIYw4P+Kp+Ij6atC2midDEFx3ya4YT34FwoiG0hiy1wH0NiKSRmUBLxt7EXfAlnlGWQJ
 PjHTGBBHS9XRJSvG7MLFUcSkrhwVc0pgDLZKkj5/cqsWlnP1mdtHWk1nBDBfFIMqdGrvgy
 RLxTYeXisnEJfp78Cbr7nsXNUi4r7VI4I+q0TejmWYxxwUJJnakF+CMece36Q7+OrqfC+B
 MJWRVONSoclx0Jc5S+o3bamWJt03z4PpZpT2Q364k7c2Xt4IRSocDwgEwg5/6wq9PqoD+/
 94vtBOl7IjnXYbaCHiBIPrNB2QSuv4vO14G0H+R4VFSUKC9L5xww27zbkSfmwA==
Message-ID: <8f024225-e616-4a09-a1ec-d19f64794aa9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1713815317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5InrFehZqt7jeVhbxGe5Lj5QJ5U2JF3LlQXHY3E0EFo=;
 b=EfIiSJpFCfJhitjNqlnPgbk4pWeS+oB4AiU8nHfdSfkAV7Jq4JWmsP2TeQTKl26Scgbt4S
 /ygktM+WfVUb+F0oaM7pjfRf9zO7GmsTI+I9+fgdroALikhLhPKuvTCnnMlhRMHDtAnJOQ
 a6GheCV8G6Vd2j3vkgZq4YB8ya0eknLcS5YwdnQe4DTvKjVjulF9gdoK3yow03CpF9bvsf
 tbkjrGlkcwOX6UirMv8it8MIEl9ypwlr0MXNhDT6AWKTtGbdYn46mLK7oSxVSIpV7fy5LH
 aczSdrN/pSbZTccMDQh1HSUI0f45QdGyRD6CGPaIOr5038DUNvBw/2jjr9Qcug==
Date: Mon, 22 Apr 2024 21:47:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] configs/rock5b: Set NET_PREFER_ROM_MAC_ADDR to y
To: Detlev Casanova <detlev.casanova@collabora.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@denx.de>
References: <20240422135927.23582-1-detlev.casanova@collabora.com>
 <20240422135927.23582-3-detlev.casanova@collabora.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240422135927.23582-3-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hohs5wk9jio16y73eftcrzpt51a8f9po
X-MBO-RS-ID: 8063b92f22b3bd5fff5
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

On 4/22/24 3:56 PM, Detlev Casanova wrote:
> ---
>   configs/rock5b-rk3588_defconfig | 1 +
>   1 file changed, 1 insertion(+)

This patch seems to be missing commit message and SoB line
