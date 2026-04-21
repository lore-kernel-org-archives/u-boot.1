Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C802EF5A8A2
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 01:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13164841C8;
	Tue, 21 Apr 2026 03:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="DMQuSZV/";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="GLzPnuFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D9A28421A; Tue, 21 Apr 2026 03:30:55 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F6F83BC4
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 03:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 13FD81D00252;
 Mon, 20 Apr 2026 21:30:49 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 21:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1776735049; x=1776821449; bh=KyOLGWoK+n0SPO9yqZ3kQ+D7Kt9ozpWl
 LkxLkm01ETM=; b=DMQuSZV/Y8tTZe+jvtMLieno4cmgwhRjJ/4dAhlz5DbAifm4
 bxQK+r2mfUU4qgaBkFIey//Whi7eMR0s2CDmdMWw2NS8xEmqHYlyA0FWKD6aCBiC
 lNdjpA5zW0HF0gXm90+krzStkGUCyNiaD1rg2v+FeS4KuXM9/Dc3A/hDiJBgdIuu
 350ZGwFkbu/4awj7AsYYk10b/BxIcTh2xFXA2EK3jr57S91LUwLM6v9Oe+tBDxdo
 LV9wgJRCMlwgJZhnTlgizOACwSFYL9+/wbR+eq5Y8KAoJooS3i3fwM0qpRgZa02T
 dfsbQv1TX9sIGk2Z2Ac44tfaogbjuvY08I5nYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776735049; x=
 1776821449; bh=KyOLGWoK+n0SPO9yqZ3kQ+D7Kt9ozpWlLkxLkm01ETM=; b=G
 LzPnuFhCAKnIak/CHFWIqgUSjP/2m01UWOa8UUK+mi0F38RAfnJspjQEPo6ccNca
 iRVGRfVhcPvgeAfVwShVSZz6+Y22zXUU5zTrsfW4fa2NcdaRVLvKf13nDgwEVgR3
 bYL2m+7CG4+hyHvLsm7Rzj4N28gLV7UdfIjOdnxpI7z/dH28KltQNcUUEzfj8Smt
 kcWA3LAVHCxshIva/Mf18wS6nW6F52+ZAbGnZ4+YkOa5FU2wefhB+5cbq9pkdkyh
 lTMFbm6WyJ/jm37BoLGGfYQRLC7K+lPY3MoNch/QsblGGs4To54S0dATbTagCADN
 hjf3xixkQQmNGYsMquIgw==
X-ME-Sender: <xms:SdPmaQMf29-UIN02UeHRioBPXniqexr134iExKu_1yHXS86fc4jsyg>
 <xme:SdPmaRy6ezqHGvG6Zkn-JSaYAdpj70T7Wufjeh-7XkN7Md08QBXfiWqK0lcFB87JP
 UKyWm7YIVfr9fJOUIuRAEsIG798zyB08v-iv0-aWrWN0zco_mQlg-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdforghthhgv
 ficuofgtuehrihguvgdfuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenuc
 ggtffrrghtthgvrhhnpedviedtueefffehledtuddttdduudfgtdevffffkedvffdvhffg
 jeeutdegledutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohep
 vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrd
 guvghngidruggvpdhrtghpthhtohepmhgrrhgvkhdrvhgrshhuthesmhgrihhlsghogidr
 ohhrgh
X-ME-Proxy: <xmx:SdPmae5Mh7WpXMszzNR0GGZLA6uGld96bI8VD8oXv9v4BNIfbAxFBw>
 <xmx:SdPmaV3e-1CxlO1N-miH6cZqXAcGle75kskOmm5t8XJZMHsKRQ_6OQ>
 <xmx:SdPmaVC5h1IzIvGrgW5P10wtX5_6M0Q9jEVHlLi0btb0mXIu4A9Z5A>
 <xmx:SdPmaX2yn-dsRI7fipF2G1JLq5uU-NbBrs4sDURjhjfYzLsYwEdfxw>
 <xmx:SdPmaaKRkU0UCYtNtmfzYu0GzM4hSj0DZQcbq5Vpc-Q3_1q_cr4XfaWt>
Feedback-ID: i426947f3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 678DE15C008C; Mon, 20 Apr 2026 21:30:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A4LigWOHQxmk
Date: Tue, 21 Apr 2026 11:29:02 +1000
From: "Mathew McBride" <matt@traverse.com.au>
To: "Marek Vasut" <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de
Message-Id: <d33dfdbe-f5d0-48ac-a2ad-5081d72fac01@app.fastmail.com>
In-Reply-To: <81f45736-4304-4d3d-b073-a34646d13407@mailbox.org>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-8-eaa81288e393@traverse.com.au>
 <81f45736-4304-4d3d-b073-a34646d13407@mailbox.org>
Subject: Re: [PATCH v2 8/8] board: ten64: start USB stack in late init
Content-Type: text/plain
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

Hi Marek,

On Tue, Apr 21, 2026, at 10:44 AM, Marek Vasut wrote:
> On 4/21/26 2:04 AM, Mathew McBride wrote:
> [snip]
> > + /* Ensure usb storage devices are available to bootflow.
> > + * Additionally, if there is a USB hub on the board,
> > + * it needs to be started to become usable both in U-Boot
> > + * and in any booted OS.
> > + */
> > + if (IS_ENABLED(CONFIG_USB_STORAGE) || IS_ENABLED(CONFIG_USB_ONBOARD_HUB))
> > + usb_init();
> Why not place 'usb start' into 'preboot' script instead ?
> 

I was not aware of preboot, but it looks like that will solve this issue nicely.
I will roll another revision with CONFIG_PREBOOT="usb start" instead of the usb_init() call.
Thanks for the tip!

Best Regards,
Mathew
