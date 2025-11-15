Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76A5CEB2CC
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 10:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CA683EE3;
	Sat, 15 Nov 2025 11:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="d4h3qqTr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 389E183EF9; Sat, 15 Nov 2025 11:57:24 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCBA8399D
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 11:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5505410AB0A; Sat, 15 Nov 2025 11:57:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763204241;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=PR8h0hNub+4ynA9iAACXEpFXwfvoLsE3n9FfbH5lOEM=;
 b=d4h3qqTrk9okLUEgvqC39J1l7nvPRzNoC+kaKb0UcM/TzIlBTzDuLPdO5y6jo0SZiDFNos
 8k1WMgjTOExABlhTs8AcUg8e2EJo4/8OAjxnBc0IV5cQrWNn0zAISljzyYPsNWi7Mdfk7D
 qESutTGY125r+iJX1LUY8eFXmfqtDYiCIGrNo6QB3Z9Q6FeC7Sigxg7b6Q7fRsmPNEtROa
 2pkBJ6HqbEqB1vw3pdcC63UfKOsm7g0v4+Y6x45bv542J4r7PO9zc8sdb0mR43h/y4otQv
 86Yxi25MpPbakG+vOLC4l6D4UzJGx9sXisXO54Pd9pR7FkTGZbgdFBkb3I5s3g==
Message-ID: <30a3bb1b-d80f-83cd-f4dd-3526dc3064ec@nabladev.com>
Date: Sat, 15 Nov 2025 11:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: muxes: i2c_mux_select/deselect() should be static
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <28bba1e65f25ef25586916d6069261efb6b26242.1762506549.git.michal.simek@amd.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <28bba1e65f25ef25586916d6069261efb6b26242.1762506549.git.michal.simek@amd.com>
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

Hello Michal,

On 07.11.25 10:09, Michal Simek wrote:
> i2c_mux_select/deselect() are not called out of i2c-mux-uclass.c that's why
> they should be static.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/i2c/muxes/i2c-mux-uclass.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Applied to u-boot-i2c master

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
