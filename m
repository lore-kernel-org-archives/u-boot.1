Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AD8CD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 14:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDFF883FEC;
	Fri, 12 Jun 2026 16:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="dtAsDQny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809188467A; Fri, 12 Jun 2026 16:03:51 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C95D839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 16:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 878AA116F82; Fri, 12 Jun 2026 16:03:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1781273025;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=9zE4dE8MlU3jlcfGKzNGXGk6u8vBQ39MBUao2Xo5t6o=;
 b=dtAsDQnyAhdq3LHCetLxtqXSmVhgHDGXcfRHwf6QXq/VlOyLwoBZKpO93x5gtiyeEsN4+9
 7SENMsf16D3EhAdmBIvfwSAI+EM4C0EHXbSaiXJzLomdC6A5znqjCQoXCClEkGK99mXPVZ
 zr6GQGMXENLDBetPouhjSOjz1pRv+KdbbErrDPXRNGkDxgBubCGjqZgD/SbYQ872M4sxWD
 S/UL28ptPqVBD1h/3c8ZWwVApmoqc24deVWPE0cBKVbDsUMqiY+H/i1BO/Zs5CaPBFSILp
 br8DjiLK2twl1fuJktJuORLlyJ7SmikBjp0OC7kiiHdccrc+WOY4JkRtbngr2w==
Message-ID: <bc3a323f-588e-4397-a6fd-3ed1d3d697ab@nabladev.com>
Date: Fri, 12 Jun 2026 16:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Use N: for NXP entry
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20260421225111.218951-1-marex@nabladev.com>
 <CAOMZO5AgST4gobvq=2WYG5cPL94inw9XQ5zPoaf8AHWpf687Zg@mail.gmail.com>
 <e789a554-ff0e-4eb3-8604-d9410ebdd9f0@nabladev.com>
 <CAOMZO5CrpUg13jZ5PCaOhA_oUfnBbJaGoSH1Thi3TF6aeth-BQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAOMZO5CrpUg13jZ5PCaOhA_oUfnBbJaGoSH1Thi3TF6aeth-BQ@mail.gmail.com>
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

On 6/12/26 2:53 PM, Fabio Estevam wrote:
> Hi Marek,
> 
> On Thu, Jun 11, 2026 at 6:48 PM Marek Vasut <marex@nabladev.com> wrote:
> 
>> Can you please pick this patch up? (I noticed it is still in my tree
>> after rebase)
> 
> It's already in the next branch.

Ah, OK.
