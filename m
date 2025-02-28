Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7332C021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 04:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A5D810ED;
	Sat,  1 Mar 2025 05:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OK1MAW3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C1E810FE; Fri, 28 Feb 2025 17:12:18 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FE5E809D4
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 17:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c095b5365eso148964185a.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 08:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740759134; x=1741363934; darn=lists.denx.de;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=svx9lmmghFPPB8wh9K1nlefdRcQjdK7UsEHTH0USelQ=;
 b=OK1MAW3/CQa4OzrICPBSomyr7LFq2H7VSXEJ82EP2Fe7ztKdzSpco4U/oIiy1TppDF
 VTEikAdr/sYxDDIWonZ4j9JA8XAvXdrdDz2GTFgd1opBZ33DA9eJ3xw0luXqRvsxvzs0
 N4UvAmmSTzNYB0vPsN24MwwlWjb0u6Z9gllCdHLC68nwUCvIsBazquCw9jkV1AfEmpRg
 dKH3OGgMaQfQNMfW5azgGMFDeOESsEKa3Nz1DEVg3g5mnenc7BdZmNyFxxNWDf0XsSG0
 5jkbU7XthrWwtSzhdZkQfgCbUifVk6KAnsOMbHiZiQy/ULxZjSHLaAxVBiV7tENbpfVV
 Z4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740759134; x=1741363934;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=svx9lmmghFPPB8wh9K1nlefdRcQjdK7UsEHTH0USelQ=;
 b=tXDYeRuPNs5+Oh6GMagw8FJh6pmn/F5Ha0mrcAnt1tRIQJ8+Lu6dOhvkYO+vN3ZpGw
 f6wVPw1HJM91xfvmzv7JQvYw9yyJNChVOFAYxFXpIO2vVd+CooZN9e9wXdzN5YdJB1aP
 2ThXeYQo0NS8vl/YwrHb0OwD5kizX2+Be2WdYB52C+dCkPaj1Inv9OGoQZ3oMp8PPbrA
 yhiB94aRGRQwwniH2Jtw9Z7C2CXrD5Vt8/9kLF8IQzpMggu5JAgT99NPoL59SQDvaKeX
 q0TGDISAr9wM1w/QnZk4x5aAE+uSBm89tL2fWgbyeTizGjo3emmxG89I79WS12n6kG+3
 0jlA==
X-Gm-Message-State: AOJu0YwLmlJnfmqE9A6TGlSUBE8gry4l9JZ5ySERJa8i9rs2Mr/mxdGF
 r9Jk+CQabrKMQ82g3CJYEpTIL85W6IwjLH5czhyO8/3zx/+VaGvyAPvRqVMB5k0=
X-Gm-Gg: ASbGnct1/MKl9o7MvYt8NrCnXV2fYzVFvrTrt4VbbJWrvhw7Cb5n3N4KXIOooRyQkVr
 aIl88XndA02MYev8mibxXl1p+3km8LUKON3ZDyTB+T2lZCoKJfEd6ObrpnjTvGawHkEuDzRJqF+
 sm+QVeM4Vp3mhYGhfnBstpuXfVLi88LEqJ4ZpMUep2qRi2KKbZo1Ekh2gSNudZ1OfwwacGIkgRN
 qJWe912rcQkMshckMCm0E7u0ePCgUUqXy6JKBNZ4hfkTMCp7aT+wDMQLobh+FFOurXWqQ5OSpGS
 k5fPucbdB6f5hQxa8vicuyr7qVBqROJfAwvPD6cutNHSCk8YwEY9btRVDCsVRI7kJkGwZqMGV1Z
 +UXrKMkQ2y3RdoQ1GBA==
X-Google-Smtp-Source: AGHT+IEvRED7ghOex+yiSbodOYKTC/uvAD1xO725/vc9WyyMzZL5ShOcVC9n+v7d5DZ+R2T0sqkRGg==
X-Received: by 2002:a05:620a:24d5:b0:7c0:87e1:658c with SMTP id
 af79cd13be357-7c39c49fc50mr539932385a.10.1740759134378; 
 Fri, 28 Feb 2025 08:12:14 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com
 (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c378dacc09sm262394885a.102.2025.02.28.08.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 08:12:14 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfauth.phl.internal (Postfix) with ESMTP id 8CF841200066;
 Fri, 28 Feb 2025 11:12:13 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
 by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 11:12:13 -0500
X-ME-Sender: <xms:XeDBZ0TLLCfzRf8pQEXn4xUj12RQoxtPvjw-zTLGL35eOqYgt-rWig>
 <xme:XeDBZxzAV4-wpFEfBpR7VgFJ3wNiD2uaKbH62tLmLCDmZvz1oTkCqMHrylHCvBnTU
 0q9fq-xCrBTkQoT6_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdekfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
 jeenucfhrhhomhepfdflrghvihgvrhcuvfhirgdfuceojhgrvhhivghrrdhtihgrsehlih
 hnrghrohdrohhrgheqnecuggftrfgrthhtvghrnheptefhleffffetvdegueehgfefgfet
 tdeivdduudefueffgedukeefieeiffeihfetnecuffhomhgrihhnpehgihhthhhusgdrtg
 homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehj
 rghvihgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudehvdekkeelhe
 ekfedqfedufeeigedvleeiqdhjrghvihgvrhdrthhirgeppehlihhnrghrohdrohhrghes
 jhgvthhmrdhmvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
 hpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepihhlihgr
 shdrrghprghlohguihhmrghssehlihhnrghrohdrohhrghdprhgtphhtthhopehuqdgsoh
 hotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehjqdhhuhhmphhhrhgvhihs
 sehtihdrtghomhdprhgtphhtthhopehsqdhvrggurghprghllhhisehtihdrtghomhdprh
 gtphhtthhopehsrhhksehtihdrtghomh
X-ME-Proxy: <xmx:XeDBZx1MJjgQ-OEJLnitg3XLOnzTwy0KgQ8lXislyxTSa9oYfUPWAw>
 <xmx:XeDBZ4DiT-ZAcW6VmWv399XE9It01ZU2mANfU2cf0n8Ay8Zz6E6XBw>
 <xmx:XeDBZ9g0xt_qBzxwuOyZc0w2i5SbM4Ujnt5YHymOqZupt6Cb6nNFEQ>
 <xmx:XeDBZ0os5eJ3nJjbseN9MwO-w8gJe1qbzcn4yvoonbKS4Y1GL7oImQ>
 <xmx:XeDBZwjpM_ReXpHzKzeBKD0XGq_LuS-kAYhxSO3091Tgh01u9XiSSfYk>
Feedback-ID: idd3648b2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 5E3EC780068; Fri, 28 Feb 2025 11:12:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 28 Feb 2025 10:11:53 -0600
From: "Javier Tia" <javier.tia@linaro.org>
To: "Siddharth Vadapalli" <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, "Jonathan Humphreys" <j-humphreys@ti.com>,
 srk@ti.com, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 trini@konsulko.com
Message-Id: <bf08cb63-6df2-40aa-a542-f62244f58dfd@app.fastmail.com>
In-Reply-To: <20250226103504.1841697-1-s-vadapalli@ti.com>
References: <20250226103504.1841697-1-s-vadapalli@ti.com>
Subject: Re: [PATCH 0/2] Enable USB MSC Boot for AM62, AM62A and AM62P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 01 Mar 2025 05:32:55 +0100
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

Hi Siddharth,

On Wed, Feb 26, 2025, at 4:35 AM, Siddharth Vadapalli wrote:
> Hello,
>
> This series adds config fragment for enabling USB MSC boot and USB
> Storage devices which are applicable to AM62, AM62A and AM62P SoCs.
>
> Series is based on commit
> 8dd7186ca7 Merge patch series "Remove "saveenv" functionality from am5=
7xx evms"
> of the next branch of U-Boot.
>
> Series has been tested on AM62A7-SK, AM625-SK and AM62P5-SK for USB MSC
> boot where the bootloaders were generated in the following manner:
> 1. AM62A7-SK (AM62A SoC):
> - tiboot3.bin
> 	=3D> am62ax_evm_r5_defconfig + am62x_r5_usbmsc.config
> - tispl.bin and u-boot.img
> 	=3D> am62ax_evm_a53_defconfig + am62x_a53_usbmsc.config
> 2. AM625-SK (AM62 SoC):
> - tiboot3.bin
> 	=3D> am62x_evm_r5_defconfig + am62x_r5_usbmsc.config
> - tispl.bin and u-boot.img
> 	=3D> am62x_evm_a53_defconfig + am62x_a53_usbmsc.config
> 3. AM62P5-SK (AM62P SoC):
> - tiboot3.bin
> 	=3D> am62px_evm_r5_defconfig + am62x_r5_usbmsc.config
> - tispl.bin and u-boot.img
> 	=3D> am62px_evm_a53_defconfig + am62x_a53_usbmsc.config
>
> The images were flashed to a USB Flash Drive and were connected to the
> Type-C interface on each of the boards which supports USB MSC Boot.

I have access to a TI board. I want to test the USB boot.

Are there any special requirements around the flash image?

Would it be sufficient to flash the WIC image generated by the Arago pro=
ject?

Could I use the same U-Boot images with these configs to boot from UART =
and SD card? I meant, if these configs will create conflicts with other =
boot modes.

Thanks,
Javier

> Logs:
> 1. AM62A7-SK:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/d1a6149d54d352eb9969=
29fa6db58934
> 2. AM625-SK:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/594938bd7a0b059e6045=
26142015266c
> 3. AM62P5-SK:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/47f5ed39818dc67d6ec1=
1fa4066e4586
>
> The following device-tree changes were made across all of the boards:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/2afb913838c1d4005bc0=
59910c09ab4b
>
> Regards,
> Siddharth.
>
> Siddharth Vadapalli (2):
>   configs: am62x_r5: introduce fragment for USB MSC boot
>   configs: am62x_a53: introduce fragment for USB MSC boot
>
>  configs/am62x_a53_usbmsc.config | 20 ++++++++++++++++++++
>  configs/am62x_r5_usbmsc.config  | 22 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 configs/am62x_a53_usbmsc.config
>  create mode 100644 configs/am62x_r5_usbmsc.config
>
> --=20
> 2.34.1

--=20
=C2=BB Javier Tia =E2=9C=8D
