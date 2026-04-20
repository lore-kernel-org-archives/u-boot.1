Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880FCF588E0
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 14:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED835841C8;
	Mon, 20 Apr 2026 16:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jetm.me header.i=@jetm.me header.b="Fs0Hkx4O";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="KjP5tyuz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ABEB84258; Mon, 20 Apr 2026 16:33:22 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410C383693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 16:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=floss@jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 76F62EC0485;
 Mon, 20 Apr 2026 10:33:19 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 10:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
 :content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1776695599;
 x=1776781999; bh=PVG2naPZ4lUPw1ecCRFexfiinGzcQeqAgzceoi5f+NM=; b=
 Fs0Hkx4OLZKHLvU788FCjM2wFarlmPCmjUyolWSGlmAIxu+30TuVFJoz5CyMWmHX
 QdnVkFHzf2zBx9nBNvxmYMvcEdxHY2VjjNK7Jv1/O3/GD6yD4r8OrskrTyBQQFAi
 SEO6E4fGnVn5tRrpQtMBXz+0U+tb/2QH8m8CfHQ/pihwkBLqGa4Ua+iN8ICwS+qT
 Nxs3nbVfFzGGDkwAy9mktylqNzx/dRGwkfbLcsZ28LA10NaJi0rEHLkirYJT/QdP
 1VMoZ7JDtcl0iPj9W266cVI2c4OOXuwHHcXnAiFl3pu9nuvUAV7O0L6lep2UqsSC
 CQisSDbEiXTwWzS502WMZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776695599; x=
 1776781999; bh=PVG2naPZ4lUPw1ecCRFexfiinGzcQeqAgzceoi5f+NM=; b=K
 jP5tyuzoR5Su6D607YAP4RuNBUAWmeXmpxJCrS2TR9Q3MDL7pzXD4V8LLXIksKjJ
 z7L6LepMS4y1ThND5QwN8dcpYiwlWR3VnJjIDaZx5nFNjHHlTAXeoW/QT3HnEbQS
 OdJbgko8xBF2vUcX/Zalh1lZvYiZomLopc493jFH/8MpK4YhOXCU4XB7cC3+fM0u
 xZUfbXZ4msnLOsnAZ5luL43B4u6CRBWaohLmERBmcdN8ix9ZkxO/Qmuc0zT7nms0
 L2f+aRV176yfL2SnKBSdM6348Ne3FURezqHhrgswFCYJuzZiZ7dWkaRiz/tuE9Jg
 4lOwoRRXgpUs6qcWrVoPg==
X-ME-Sender: <xms:LznmafdMyueH6xd7KmUnV8S1jSNc7VF5Fzg0MI5g5MdI6NH8mfWlWg>
 <xme:LznmaQCDi3OKUhwHZYK1MYgNT1U-BG3WXUf8EtofvbvItMf9VO_dJJbrj-2OnY-tJ
 fLisfr5eGibY6Uye4DCBbFwz1ydpGvuohNVh3m27huwgLrB4HB1QKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkeejjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdflrghvihgv
 rhcuvfhirgdfuceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepie
 fgfeeuveduvdekhfelgfeljefhffeuueffieehieduveejhedvleetffdvveetnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
 gvthhmrdhmvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
 thhtohephhgvihhnrhhitghhrdhstghhuhgthhgrrhguthestggrnhhonhhitggrlhdrtg
 homhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthho
 pehilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorhhgpdhrtghpthhtoh
 epuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:LznmabGgqvDQHd6zIEZYzIGCFNpsiG_SAFaUzoJx9KOAUxRqLBFgEw>
 <xmx:LznmaWJ_UT9YTmAVHY5CX0Hc4HyDOtqrZ1o1t_ZXs6PtHgZ_66OX1Q>
 <xmx:LznmaXl-vkUEcjAKHZuyzfjfSKSKPKlhI0uvuyBDcdeZuEZ4jUBeFg>
 <xmx:LznmaWTd3qu0BQGKUNlpDncPMzMyufRJ31-djxXdozIpPy-UZp7iDA>
 <xmx:LznmaR1lkgKB8d0VJNRClxDQhI8mIOT5LDXp8arAXA-hBefEOR5t-yuy>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 186D81EA006C; Mon, 20 Apr 2026 10:33:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 20 Apr 2026 08:32:58 -0600
From: "Javier Tia" <floss@jetm.me>
To: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>,
 "Tom Rini" <trini@konsulko.com>
Cc: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Message-Id: <d922cb58-acf1-4f55-ad7d-b858767d0e7f@app.fastmail.com>
In-Reply-To: <20260417173345.6559-1-heinrich.schuchardt@canonical.com>
References: <20260417173345.6559-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] Mailmap entry for Javier Tia
Content-Type: text/plain; charset=utf-8
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

Hi,

On Fri, Apr 17, 2026, at 11:33 AM, Heinrich Schuchardt wrote:
> Javier has left Linaro. Forward to his new email address.

Reviewed-by: Javier Tia <floss@jetm.me>

> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 337dcba5545..df143d7f31b 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -67,6 +67,7 @@ Jagan Teki <jaganna@xilinx.com>
>  Jagan Teki <jagannadh.teki@gmail.com>
>  Jagan Teki <jagannadha.sutradharudu-teki@xilinx.com>
>  Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>=20
> <jakob.unterwurzacher@theobroma-systems.com>
> +Javier Tia <floss@jetm.me> <javier.tia@linaro.org>
>  Jay Buddhabhatti <jay.buddhabhatti@amd.com>=20
> <jay.buddhabhatti@xilinx.com>
>  Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
>  Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
> --=20
> 2.53.0

--=20
=C2=BB Javier Tia =E2=9C=8D
