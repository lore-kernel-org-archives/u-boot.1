Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FF0C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 16:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5865687E88;
	Thu, 23 May 2024 18:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="AqvFpHUu";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="kerfNVBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E1D87EBD; Thu, 23 May 2024 18:46:47 +0200 (CEST)
Received: from wfout4-smtp.messagingengine.com
 (wfout4-smtp.messagingengine.com [64.147.123.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E31887E50
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 18:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id D0BB61C001C0;
 Thu, 23 May 2024 12:46:42 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 23 May 2024 12:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716482802;
 x=1716569202; bh=m3jjgFTjP/S9MRcvrny5fNkjOG4A33TS+1xiZmhZRyo=; b=
 AqvFpHUuJT0MV56VViEfKNlkSsrfkhtLGQXdV5mJ1b7dfQrTqHQnlfmWm1+rTPuy
 6TkiFYfBTNliNUL+43xpvyUwdyi12gCrG5AJqJwS/a4V8lrZl7GkVlCFHXrMx5HO
 YjzAdvDaR/H3ttFk8IDcVy6KScfx0lGBva3JHLjCLklU62Bc+jsWIhydy4DITZGn
 R0bOiHKVauNon17UF2x4p10dkKiW/EfKOpliAk5u44OuWiZIzV7Vuz+yOgVM+aHm
 XT8Pb4cNtoJ/HWULGtA900/WkfjAEn2nvV/aH5hxSo47I1X7YoLjUasStZ4/axOT
 qPx+H/uu5UCP7COhzaGfbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716482802; x=
 1716569202; bh=m3jjgFTjP/S9MRcvrny5fNkjOG4A33TS+1xiZmhZRyo=; b=k
 erfNVBvqRRrnkKQZpaz0/zUoNNtIbvF4SYdWYpzek77OEdP8ONrRW+9WfRIWasHw
 NB6mgjtwzPj/v/7O+5gPwBh3bCoOOjC53npKy77FPjq5QCjELADIKcsM9weI9sLW
 aqXYzwe+0FoIbzQAvYT8b/A7jOWURvs2Y/AmlIo+DY2MbghuNV5TrGld+7LcAXsp
 tSOWFod1ncNTBXV97MKfDOUuhszgFs1aj1HNnd5DzKZFasmefHZgDaB2AX2FR7N6
 fyK0w1LzhCN4C0myBCqbJD9Tid44ASaFSyQsh1dX2frLVBoms2y2F5m82Snm6qQM
 6zxYlH6R9uK2BaIsxMzmg==
X-ME-Sender: <xms:8nJPZk5cSDQLPUzS3aY8Orgh4UMZC0aX4lwMiNDccppZh_-RiSWbnw>
 <xme:8nJPZl59m0mVA8YFXWYv5DIX2wsTrh32jJVzz4PJ6zaA7XWbL_g-MbXCaRayc_fCu
 O2hl0rwjgeEAuT_-iM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedguddtfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
 lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
 homheqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefh
 jeeugeevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:8nJPZjct3xetXwUW9hJAxf3522UB5HOlfQcCjXTr4ya0MNHYuVspSQ>
 <xmx:8nJPZpIWPVK7rubX-oBnn8bEXGH2Q1I5pgZNaDGc0j7UVz62GhYmHg>
 <xmx:8nJPZoKMJY0gPiv74L7-2BRFfohxx0Ujl-rtbCPBlJLA5cl2xZZg7A>
 <xmx:8nJPZqw7-Jl7xwfmMYNMUj6MPLAhic0k8RDISXBu4wxeRLQac7PP7g>
 <xmx:8nJPZtHGfqrYmDie853ZYzB6TnpGQdkmmxqS1QtAHUMIgsrjdsAgVAbf>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 328D036A0074; Thu, 23 May 2024 12:46:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
MIME-Version: 1.0
Message-Id: <70548c02-d379-4a23-9dd3-11542359eb44@app.fastmail.com>
In-Reply-To: <fc95549e-fd0b-462d-b290-2612de601297@gmx.de>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-16-1407e0b69678@flygoat.com>
 <fc95549e-fd0b-462d-b290-2612de601297@gmx.de>
Date: Thu, 23 May 2024 17:46:23 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, "Simon Glass" <sjg@chromium.org>,
 "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 16/16] efi: LoongArch: Implement everything
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8823=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=885:26=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A

>> diff --git a/arch/loongarch/lib/reloc_loongarch_efi.c b/arch/loongarc=
h/lib/reloc_loongarch_efi.c
>> new file mode 100644
>> index 000000000000..32a7d792103d
>> --- /dev/null
>> +++ b/arch/loongarch/lib/reloc_loongarch_efi.c
>
> The code seems to be very similar for all architectures. I wonder if o=
ne
> implementation could cover them all.

Not for MIPS due to differences on psABI dynamic relocations.
We still need to handle differences between Rel and Rela and other tiny =
bits.

I think most architectures have their relocation handling code rooted fr=
om
gnu-efi.

Thanks
- Jiaxun

>
> Best regards
>
> Heinrich
>

--=20
- Jiaxun
