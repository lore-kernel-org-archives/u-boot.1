Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE599CD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 21:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D651839A8;
	Thu, 11 Jun 2026 23:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="ZfkOQU55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FEB83FF5; Thu, 11 Jun 2026 23:48:03 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9194F838BB
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 23:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CB7AC11591D; Thu, 11 Jun 2026 23:47:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1781214480;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=vR82ZQ1SOqSPaOztVh8BVhCAh4ztOwyZqQgeImw47yo=;
 b=ZfkOQU55ROADZ1ZFXr1yvgU4Ky5RR4uFXnSWiUEn1CQLEeuecMMpv6denaofhgSxGpHvfK
 CA8/Y5uBN06n6imHVlMJwGEAe00nXvwPNW6vVh1phsyF8XlXNig8zNQNdB/ahhkU5v39pE
 HDOxiOGct3F7KqMaycADUoIzrnkt1SLeM7sOUz8aMQe3gNYqB4Zevz4sxqZz9hivDVrmBp
 18Qhmx5L7TmgBpZ0GOuwmuCtRvJrjQa/Lsm4IUBHqouRqvky+56cWgjvnAIZKUtaXLIwsU
 95qc2RhPsfWHxJNbz8VrbNRyjjE8fkKztgZwodBXJjdKt9WcLW9jdjvoZis9zw==
Message-ID: <e789a554-ff0e-4eb3-8604-d9410ebdd9f0@nabladev.com>
Date: Thu, 11 Jun 2026 23:47:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Use N: for NXP entry
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20260421225111.218951-1-marex@nabladev.com>
 <CAOMZO5AgST4gobvq=2WYG5cPL94inw9XQ5zPoaf8AHWpf687Zg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAOMZO5AgST4gobvq=2WYG5cPL94inw9XQ5zPoaf8AHWpf687Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/22/26 3:54 AM, Fabio Estevam wrote:
> On Tue, Apr 21, 2026 at 7:51 PM Marek Vasut <marex@nabladev.com> wrote:
>>
>> Reduce the NXP MAINTAINERS entry by using N: entry glob.
>>
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Can you please pick this patch up? (I noticed it is still in my tree 
after rebase)

Thank you
