Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDD8C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61ADF86759;
	Thu, 24 Aug 2023 16:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="PfIFWDer";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7073186750; Thu, 24 Aug 2023 16:55:57 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B139865FB
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id BDAB330A;
 Thu, 24 Aug 2023 16:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1692888952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p1D+TVsNqKCuLpBY/Car4bHZCl3xd6V0XKxLVKgWlhc=;
 b=PfIFWDer9nQgfhct64zDzzWOCQl5YM7xsTjguwqPt7o5q3dZajlhqiFli10iBS0TR41IFb
 sVUwMGDfj7RYSS+W2OnqxHryghtGq7Ngo6Ky5HycBt6nAfXq6IbsNJRCUJGpSdfWq5Hzny
 XPJqCuQgpQiTrM2afg8njN9nZ+oC7a7OqIjNR3LEW6vdmGnqUU/N8zmcg+pc40G8jGyh/y
 EEUPRI+1f4sIcufWz4N9R1F2HIhzolB4pQPwtrmZfmRezla7UT1SYuPOWeA00HboRSigx2
 fXuqxNy0h1yGKul84N14Y6QOjrRksAsiOF9Oy3GfHh/zW7bV29aWzEVlpxC4Ug==
MIME-Version: 1.0
Date: Thu, 24 Aug 2023 16:55:52 +0200
From: Michael Walle <michael@walle.cc>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Dillon
 Min <dillon.minfei@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Kamil Lulko <kamil.lulko@gmail.com>, Marek Vasut
 <marex@denx.de>, Neha Malcom Francis <n-francis@ti.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Philippe Reynes
 <philippe.reynes@softathome.com>, Stefan Herbrechtsmeier
 <stefan.herbrechtsmeier@weidmueller.com>, Vikas Manocha
 <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
In-Reply-To: <CAPnjgZ0MNb5aAtmz9Yk+JiHxQt+qwhQW=WccgiiRRqfQ-a1OBQ@mail.gmail.com>
References: <20230824030304.1555547-1-sjg@chromium.org>
 <9f4019b9e46d3fae5bbfad6d06ff6bf9@walle.cc>
 <CAPnjgZ0MNb5aAtmz9Yk+JiHxQt+qwhQW=WccgiiRRqfQ-a1OBQ@mail.gmail.com>
Message-ID: <6cb6ee52ccd550d3c8fddd76bc84a282@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
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

Hi,

>> > This series adjusts binman to enforce just 4 extensions for output
>> > images:
>> >
>> >    .bin
>> >    .rom
>> >    .itb
>> >    .img
>> >
>> > Other extensions will produce an error. With this rule observed,
>> > buildman
>> > can keep the required files.
>> 
>> How does this work? I didn't get all the patches from this series, 
>> which
>> makes
>> it really hard to review or ack the individual patches.
>> 
>> Are we just whitelisting any files with these extension? Honestly, 
>> this
>> sounds like an arbitrary restriction to me. But maybe I'm missing some
>> context.
> 
> You can see the full series here:
> 
> https://patchwork.ozlabs.org/project/uboot/list/?series=370121

I know the archives/patchwork. All I was saying is that sending just 
parts
of a patch series to specific ppl doesn't make any sense, because you 
always
miss the context and for that you have to look at the archives.

-michael
