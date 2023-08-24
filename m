Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB76C7113B
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 07:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32CAE86563;
	Thu, 24 Aug 2023 09:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="HlkOIMok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 581FE8655F; Thu, 24 Aug 2023 09:32:45 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F17864FA
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 09:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 11E695E7;
 Thu, 24 Aug 2023 09:32:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1692862361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xN8xQlNeGD7nuT2802weXMRaPuWF7/QzkZS29QGXJkQ=;
 b=HlkOIMokqqjvSm1/CuSU7m0/pb2na4THEoRH9P75RDwoLHJ4/wjkI6njoksIwN9Dgbj+m0
 8n2ydcHNGGn1vUzcMDuohMt9Aw7GOepIq0lczl7RwZm4A989dv8Kmvv7m4q9XMj+YK98fj
 c3yQVbDdMMA6nv2+uAF8tNJwbE8/rC7K/tEGD2DKY3IdrjRMvQ+tG7BzzF+mSfln/8t5Ym
 PeYLk8Wdnq76WtFiDH98AbDEUSg+CozRrIMdJPmgocQrkPXc+jKWcmy2VxQpJNex3svZYc
 yStmQ8T5W0OixbnEiuRcogHMmoV9TNWe7ovrYpuH6LWSmeQuEZHdFavxPfTFSA==
MIME-Version: 1.0
Date: Thu, 24 Aug 2023 09:32:40 +0200
From: Michael Walle <michael@walle.cc>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Dillon Min <dillon.minfei@gmail.com>, Ivan
 Mikhaylov <fr0st61te@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Kamil
 Lulko <kamil.lulko@gmail.com>, Marek Vasut <marex@denx.de>, Neha Malcom
 Francis <n-francis@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, Stefan
 Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, Vikas Manocha
 <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
In-Reply-To: <20230824030304.1555547-1-sjg@chromium.org>
References: <20230824030304.1555547-1-sjg@chromium.org>
Message-ID: <9f4019b9e46d3fae5bbfad6d06ff6bf9@walle.cc>
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

> This series adjusts binman to enforce just 4 extensions for output 
> images:
> 
>    .bin
>    .rom
>    .itb
>    .img
> 
> Other extensions will produce an error. With this rule observed, 
> buildman
> can keep the required files.

How does this work? I didn't get all the patches from this series, which 
makes
it really hard to review or ack the individual patches.

Are we just whitelisting any files with these extension? Honestly, this
sounds like an arbitrary restriction to me. But maybe I'm missing some
context.

-michael
