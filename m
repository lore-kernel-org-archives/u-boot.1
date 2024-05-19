Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA47BC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 20:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D18D87E0B;
	Sun, 19 May 2024 22:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="TA9Xc+5V";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="kEa0taqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B8587E0B; Sun, 19 May 2024 22:57:25 +0200 (CEST)
Received: from fhigh6-smtp.messagingengine.com
 (fhigh6-smtp.messagingengine.com [103.168.172.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B957D870AB
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id DDC7B11400E9;
 Sun, 19 May 2024 16:57:22 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Sun, 19 May 2024 16:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716152242;
 x=1716238642; bh=uNNTFYmxdPAWUfTG802VoCo4BNirKuGE6Wv13vbHgLI=; b=
 TA9Xc+5V8nQucPZ2zIAJT920kxNrPtmPhcenhNYJGue7OtBMYTEf7LfIZFysxRz9
 +ozD6N7PSz3qT+mt+oCd4DnmgvnMQmrq/nImC8BlBxjRjl0CUHdhuc7E4wXa8Zqg
 NI3SOZGqzTla53bjxg50iHkczMa2K7N1ugjHrfpTXqP1hJJ/QAhVbBRh8dP3/dLw
 4MbKxCjyXGglP2HSUQqc+2rYIHNb/6OM/9JYLUNuWowVqJ2bkJM+tNmk19Vq9asp
 wBiGBXx2nRlZJATayypnIYynJUbhj8/wui0nuylgA78tYxZSR5+IrcyHRUT+ZOBe
 4ExdAT+u2T1izac3VldMxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716152242; x=
 1716238642; bh=uNNTFYmxdPAWUfTG802VoCo4BNirKuGE6Wv13vbHgLI=; b=k
 Ea0taqQ/GDKwFUFU+yJqXnFzW6rltYyR/5VkUaw6RLLp0JBMeFvdb5CSkj6Iz2ok
 BTszSNheK5n2TyWN6IxxtT5I0U20omumsUIqrVOiYvD6sQ+d0OlAIzQ+alCGDc+f
 ofDpwUXBgQ5nK78Ussx7ES99tbbs/3uu2ddkMhWLVYjek3ZuD+BBAtd9AiHt18TK
 WJDOmPXFGUGxwGrQylmonTtQkqE6sLy8n3SN+TD3OVG8GmA/LgZn50DW9+S4G97s
 HwnP3yYM8OGk3z6pGUeE1G4T384qOe5IbVYE/zg+J9CUeRtgNbgARZ8p/Dym00hs
 3fXGfmtSTvskF7DR4MHKA==
X-ME-Sender: <xms:smdKZu2v9tedXLNTwHlzBUfkJTw_9Vl3AGE1Av8ClrVbTQFGyurvGw>
 <xme:smdKZhHyiZLftDnrqF9jbFPkT42AEFzvAsokZXZmNGIKEK3XY1wXIDnHpCOOIgPzD
 NJsvw91svmv2rySf1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgudehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
 lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
 homheqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefh
 jeeugeevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:smdKZm6vQzHNrFE8M1kZDfzk6BLJerGTgwyeg29Xf1_uY4y88dQ6xg>
 <xmx:smdKZv3xuSusTqa7WAHWZiOaOY35a-6Z80jyT7M-Dc_gMLFqLlcbQw>
 <xmx:smdKZhEbFWUDt7TpfRWKSrNO3jBKHIASaqAg6fJQ1qkSO087-SbZLQ>
 <xmx:smdKZo9o4DIUCuLmT_MVP_nR2lqvcXZUiZtEhztlPjzf71yrE7dwqw>
 <xmx:smdKZgCM0zE-x6W3qxERd8ubeB2H4fgkQtsMBjWFQwYSItGSt8Mr0Vxs>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 70AA336A0075; Sun, 19 May 2024 16:57:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <56e0d09f-2499-4f04-9e52-8c122a40921a@app.fastmail.com>
In-Reply-To: <05c8e427-0bb3-489f-915c-d6a7e743f63c@gmail.com>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-11-1ea7d23f4a1d@flygoat.com>
 <05c8e427-0bb3-489f-915c-d6a7e743f63c@gmail.com>
Date: Sun, 19 May 2024 21:57:03 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>, u-boot@lists.denx.de
Cc: "Michal Simek" <michal.simek@amd.com>, "Tom Rini" <trini@konsulko.com>,
 "paulburton@kernel.org" <paulburton@kernel.org>,
 "Simon Glass" <sjg@chromium.org>, "Lukasz Majewski" <lukma@denx.de>,
 "Sean Anderson" <seanga2@gmail.com>, "Sumit Garg" <sumit.garg@linaro.org>,
 "Jonas Karlman" <jonas@kwiboo.se>
Subject: Re: [PATCH v3 11/12] MIPS: boston: Migrate to OF_UPSTREAM
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8819=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=887:20=EF=BC=8CDaniel Schwierzeck=E5=86=99=E9=81=93=EF=BC=9A
>
> Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
>
Hi Daniel,

Thanks for reviewing the series.
>
[...]
>
> should be 'select' because the switch to upstream DTS is permanent and=20
> it does not make sense for the user to be able to deselect this option
>

Do you want me to send another version or are you going to fix
it as you apply the patch?

Thanks
--=20
- Jiaxun
