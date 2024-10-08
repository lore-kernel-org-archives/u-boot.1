Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0229CF0427
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 21:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DF5288DED;
	Tue,  8 Oct 2024 23:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mHXIcEC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E11688E19; Tue,  8 Oct 2024 23:48:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE86F88DBF
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 23:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728424094; x=1729028894; i=xypron.glpk@gmx.de;
 bh=PvDScJ9vsMFZImKDY8uyuNpIBQtihlHAWguQcg+uNR8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mHXIcEC0fII4kPkrM+0f54uHVPoIupBbKArjpv5fTTkBPaEHZouQF8RPJxzS7i8R
 7lhTlC0dGh6RaeF2mQmE4pf9DFu5UG6X+/3Q3c10RVJc0WZ1JimPg46KXTuXXOUav
 xqo8b5mqbTOSNDup0KvL8gTZ9/sryuQu2actZ1odhSuIe7lrQTfN7isW6xnCKPTqw
 Qlj1yIfA0F3s/DYbqJNjniZB+EpW/IUs06ih5CdoJyvtsV3FLtxq0H1T/+6Cg3nsR
 HceLdvroSHMj20uZg7DFweXL6UHouAIua8muec+VAgD5gqvbtMZL/lJiIz2Gv/GUw
 a4RpL/BWW20kGOPM3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.109.97]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1tEaYl1y9l-00NtxN; Tue, 08
 Oct 2024 23:48:14 +0200
Message-ID: <4027a24c-e5e3-4fcb-bb57-cd391a970bd5@gmx.de>
Date: Tue, 8 Oct 2024 23:48:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Make EFI memory allocations synchronous with LMB
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JxvGl1tc0n4hialoUTGTeKriDC+ZFis1gPEv5jHu01nCC2VKfFB
 iwriS7CWbd/NxrVtcOOl50lm36LH7RJiXOrtLikW9ifFl9mafZZgeXwe396RhchN0aGjL0o
 WrDDFSGlvhB5pxtsZvyciFEFrSol9ear+ABwkdri8jT1a8g46GKaYVmdWUk3evFsZIMYpe5
 tfC94gCiPFjoQUvsbRu9Q==
UI-OutboundReport: notjunk:1;M01:P0:CpkYhz6B5S0=;Igtu380vyqOfIUwJ9D9hy5JHphZ
 CSdp5SQksou2euGHPLq9DMXd/BJS4ufPJfOOLCkf3CozkACbkhCSkHYVEuJ/EIvagfyU3osgT
 oAszjDtmRjodYwIR9HxJNBdqAK9WKb+SFrltNX8oi5DgZxR6zCGg0KTJET9CiQEbfovdajChq
 nUNeMQqu5K3dJkJY+KNJkzuXhyj7ZrTgYZ+XydaU2l781AAUYmeM6jBQjzoE8KOMBcPL8MKvY
 lUsEnVPHuxNSyKjDwN4T7+OfkF/tiU00v7EJB2uI64mxGz4AeSn31Ea0SLB+QuBZcWJ8aznhA
 xqWfMpidC8F3ex7uVD/4KZmFBiOf4gKS796p1tpWC0u2AD4VQpaj2xLUmJBfhB4lNl6Bpj/i3
 dmio7b53XbDySfkqTJGm6SLnl6pHqXhgORxsDpEHdnAZ8KkMnexnYvP1iQHojKJYTHiYW9wah
 otZDFQ2qHek4mG7hC6S5DLaDdqDbYLA6rY3ZJmpXkVlPyKNu3Rib79DiS0Gok+6bzOdsCm8n8
 3zqi63puUBcnYsNgB5MsIwUgX5Zcw4Zksmmp/Bw1OXo1awO1srzdb0CsQhmm+m1jzlrZo8mF4
 vvuMlUs6vzgvizK51ex1J3rWMBtlVuVW/OPH8DsQOyv/b01/8/cIwEV9k5/zM++j1ulvHQ2Sz
 xP62xlxCOzdnQZX1TgPKF+WuGVhIM5htdXlRwJay2Mc4b11OJcgUkcZXflHIG5mr1j+HuKe0E
 ac8veh/x12lGvMBt4jlvgKDBfnHbqN+wpAGpv5m7Y8oYJ9Nt5yOOnpIIOIiT/pQW/Pz+T6hfJ
 vizjs4RdC3i/xCQPEvlNKTJQ==
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

On 10/8/24 20:14, Sughosh Ganu wrote:
> This is part two of the series to have the EFI and LMB modules have a
> coherent view of memory. Part one of this goal was to change the LMB
> module to have a global and persistent memory map. Those patches have
> now been applied to the next branch.
>
> These patches are changing the EFI memory allocation API's such that
> they rely on the LMB module to allocate RAM memory. This fixes the
> current scenario where the EFI memory module has no visibility of the
> allocations/reservations made by the LMB module. One thing to note
> here is that this is limited to the RAM memory region, i.e. the
> EFI_CONVENTIONAL_MEMORY type. Any other memory type that is to be
> added to the EFI memory map, still gets handled by the EFI memory
> module.

With this series the UEFI SCT fails in the MemoryAllocationServicesTest
on arm64 when running on sandbox64_defconfig:

UEFI image [0x00000000182e5000:0x00000000183b7fff] pc=3D0x99d4out of
memory 'c=3D0x99d4
UEFI image [0x0000000014139000:0x000000001416dfff]out of memory
'0x0000000014139000:0x000000001416dfff]
UEFI image [0x00000000140fc000:0x0000000014100fff]out of memory
'0x00000000140fc000:0x0000000014100fff]

Without this series the test runs fine.

Some guidance for running the SCT is provided in
https://github.com/U-Boot-EFI/u-boot-sct-results.

Best regards

Heinrich
