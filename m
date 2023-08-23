Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82556C7113B
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 017FF86456;
	Wed, 23 Aug 2023 22:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mC8q8Uk1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F933864C5; Wed, 23 Aug 2023 22:14:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6522F8644F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 22:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692821661; x=1693426461; i=xypron.glpk@gmx.de;
 bh=CJjmcoNziHtRhDHhQh/u4LpARBBXmt8A6cHpAktlk14=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mC8q8Uk1XZq8p1gzNCPORd3xIVR64orSK5a5aZfI/Lp+nvPZyUo5Cn5rUg7QFZam0tkTEcE
 R0BemRuokFdAxN76coOO8kN84boSouzsY23Za/WWqb4f1L0wPEMPTALXKmg8h5FMcyrOBl068
 e7tj558vl4F2268U3O7CqEEbUkq/MIHlZ5M81HMhAlrFu029O3lrF45zITgPzESGKZ+cGt7S/
 HzY5DOFl59YjEF1FFUXyrdUKrYrePdjeUC0fRHx8OO2HYP0HQseM03PJS+gVDM3awiVXPR/W1
 GW/rniG5OTj1r/wTreCzxr7+errugbnwAKy8OOdkH+bHmnWEysjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1qcm7j1wkE-0051tx; Wed, 23
 Aug 2023 22:14:21 +0200
Message-ID: <6f1ea3e9-7284-22d3-e2ee-071523b7dbac@gmx.de>
Date: Wed, 23 Aug 2023 22:15:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/8] spl: x86: Avoid starting up PCI automatically in SPL
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-8-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230823184746.842091-8-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Szgz7CjRI+3U9o8NuIq99qTGQKWuaQFXEMdvpJDymB9df6f8XRs
 26VJ3qBKvLNwXOr88zNyDIYmY9jtaGub90P9bXh053IC+yJcGRrgjqo4OCtwEMg4uVi4SaG
 h66bW18XV0/Qugy8T7Li3ywo6lGKm5ajz9vbfUMbBSYgjK1trFJQgPXEorDgTVKRgaVDEbM
 b1b665BoAlikRbN8vLvQw==
UI-OutboundReport: notjunk:1;M01:P0:mMYt7cClRsE=;XTnm6oId48u6j4Mbf/OEOChJ7rX
 2R4wrjbOQwPUylC/aH54ER2DHk4ICLSKZ/wPPn2S+8WV6PLqEcjNW9NwWNUviLfWuD2Dd7BJY
 pCzpm/z2ij1qVexffV4NbgFY2MKDSVttqdcA9qikThQ5lazRHmVSsBTlDvU6F5jdjeULUWFK/
 ryVIrEk3+n9kl1GV8Jonz52jLLyFv3VoxmSkFdze4rnamTO9bRmn3W1SaG4qbH6txof9LG8yD
 0yJIebNmVgegKzxdEAr+O6SU1hLpLzNeGO79bSLHi/HlX1mt9uc/t9a/x1DklGen5c/Dfc5SL
 X1hTO1WYfH8FxdMGa+K53QXq89RHhV5LYIq1/dstmgprx4oZXUT0lGT78e43Z1KLey+SOopA0
 DRQXfv85uJ5xjWbntT6uvhN1ZCocC3UOOeLiZKq9S+t6jHPTwsYjNAo8VRGWjHdyU7EZK17Dp
 8AcjAY7wIuwHKifdz5CNOaubZGHk/BfJ1gZc8/oIkLTFzw1kwrjRBMUZ2oip5GPkS5ZNhUZxp
 EqH+SkfbOwn+IHpKfgQP1A4TCZ0W+ts1T1GlsT10a42pq2glBXJaWrlt8E/tgxAyu9fre3C3f
 qNxcBb7oLZnGWhVy5haUwKjxl+gvZMOj+IqMAU7jOWGar5pb3WjJpRaqywpKtfl9IffPO5fx4
 /aLbXsWHHtAl6xP+zcP4D/rH0q6geyTHj+cFRdusQi+mTf7OhXn3gI7Iw9Y5K9EVdWpuSKyes
 OB3ruHiysEJilj7K+NmqBc+eiJCvZUMS1Qpgq+UZrBUztd+Z7ULgRO9GmyZsEbvdT17yZR31N
 m/10QPtzzavI0ALj51CLS1iiyZ4iXO98/MXbj5fStJRu66QfERKrOSFVAkUFjrW22JpAYTTRb
 TEWM+cxNysNQcpf0BUQ3oLjbEtRJGOT/bdnevuR73jeUPLJ7D0KWYhY558RUghJs5FqVBetTe
 2wa5+oFS/q1JC7HVuRtTQtMS9Io=
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

On 8/23/23 20:47, Simon Glass wrote:
> For x86 platforms, PCI is core to their operation and is managed in
> arch-specific code. Each platform has its own way of doing this. For TPL
> and some SPL implementations, the full driver model PCI is not used.
>
> A recent change enabled full PCI in TPL/SPL for all boards. This breaks
> some x86 boards, so adjust it to skip that for x86.

Could you, please, give some more detail?

* Which boards are broken?
* Don't these boards have a pci_init() function?
* In what way does calling pci_init() lead to a failure?

It would be preferable to have all architectures and boards use the same
high level API. Excluding x86 here looks more like a (necessary) hack
than like a target state.

Best regards

Heinrich

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   common/spl/spl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 0062f3f45d9..13d7b1a742f 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -800,7 +800,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>   	    IS_ENABLED(CONFIG_SPL_ATF))
>   		dram_init_banksize();
>
> -	if (CONFIG_IS_ENABLED(PCI)) {
> +	if (CONFIG_IS_ENABLED(PCI) && !IS_ENABLED(CONFIG_X86)) {
>   		ret =3D pci_init();
>   		if (ret)
>   			puts(SPL_TPL_PROMPT "Cannot initialize PCI\n");

