Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A081CEFC4C
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 19:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D8588EF8;
	Tue,  8 Oct 2024 21:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BVceF0PA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA1288F14; Tue,  8 Oct 2024 21:41:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDCB588EA7
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 21:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728416488; x=1729021288; i=xypron.glpk@gmx.de;
 bh=aFMx2hRj+6q5J/6Vg7pCm4ntoecMMjc7hfNmC9CexrI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BVceF0PAP7pg6MUhdE39Pus6KoSKabw/6xouWV8W/DBvil5fMTkefAzMuW7n8t41
 5XzeqVyhBy9zx1TLMwOhOzUSPSI4wsgtYIIlgGBOA4Pkjrj/uZ/VZioRqPiriRs1Q
 8RWI6qzlqWGEevzKMhe4ssof0p8v90OtHcTrfh9ePScwwEYJiDAAIbFnfqsVgOdt2
 VCmzDPvRovTnHZtGVlrYJANitMRGB7DMGt7kksXXZuh7QEi2wOUkND2Sc9ZuhTIQA
 Vp8HmfvPAlF8E5l1cp2d0lyIQ7Z3DvOiXgFF7pk2pcQKbC7as59l4sJF39cpe1EtV
 BqINlhwcFZFgrLYijw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V4P-1tzBlH1TdH-00zja4; Tue, 08
 Oct 2024 21:41:28 +0200
Message-ID: <b14f0b32-15d4-4c32-ae71-bd513fea5503@gmx.de>
Date: Tue, 8 Oct 2024 21:41:23 +0200
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
X-Provags-ID: V03:K1:NX41AUwatfP74OOJUroFQ5+XYSSw4aiFkUxaMQGlDizmXNryEcO
 7MBchx03Cwtnrf53RiFQjZy0Qoio+ULM7LsZJL8GT2OaaeXS++MlEBYzzmbfk3/ls5tky65
 Isq9MWZdBCYlXhb3FzN/XJtsGnH2DoJmIqPns4lrDNARa4gTkPUvDFsyNObgw8629JgM01L
 b7KMBxWX7/QsvfSUdgu9g==
UI-OutboundReport: notjunk:1;M01:P0:fyQMdAwassU=;e/at+fUzmG9oWcqmVX51o5OadAh
 fIXj/JEDHhKSjrCNwONXEW0OlRdebDnmdahx8ffUpGiU8N0oWlrDMw7yyl0LEpRgVRhocdkjC
 AtKp375HRFbI5obJfzvCrC7qEr1ulMbovjdO2AfZT2d1/8WBciK80AFMf4ERfM3UxKsrTghKe
 kmXAFy/hC3gmlvQtf0ia+ZMWuKfyyT5ECVOdu/E5i241wxnFjwVnYZWskddUbzY9pA0qf9tS8
 EtysVPf7S9Auj1QFyV2UK+oyS7ito7Gphewy47X6SyOIA6Ql96v8hVV7Nzem0U8jnhUw80gMJ
 NyzoNVW0oojKgQUj8S8e6yglHrapg0L7HCs2/G4Z6JokX9tLydy2sHx5ynSzJDO+0J71X16po
 5TbEsAY5rYBv6uNtl03zQNeeZXpUcPMQ3uvOi8YF532mKSWDkQDrTFPLnEOIJqmtFzlBkgDxE
 zDFKeyhFvTiGrNoHSc3chiCaKGI9ajGqZv47HUp5K6Qi5R3oUV5p8L/BbFxUldT7Bo7MfwYiS
 OpHFvH7OcQY8UqML31BpXtEqhDMaWWeycaGjl3DC9oAdvqKKWFggOw1jlg38ROWYVe8CVF4xm
 /R4PC254Gg8ulRdJ/tIo6fh+4iueSAfm7dKaAv1hVvfgOEE+BvUymWYfO8/cc5/S4xa/SWZ9m
 nyM5lZ03rk6OLNFQ5etRD0hOSVVsHTLByoL2pY6tpdhDQpzPrr9i+j/3O3WwiLG2gCI7XaepJ
 svRK05mZc4JavqjVm1PfnUqYN0ctlSHXSgJNNXliiNZzXvTaRwyIxZhV484mglOI+wR0DKip/
 V5VrKR08hA6OOUm9Y7d7CXrw==
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

LMB seems to have restrictions that EFI does not have:

__lmb_free() fails if the freed memory range extends over multiple
adjacent allocated regions.

FreePages() in the EFI specification does not require that all freed
pages have the same properties.

I don't think this will hit us with this series as we currently always
pass the same flags to LMB when allocating and LMB should be coalescing
adjacent allocations.

But if we will go forward and move the EFI memory map into LMB to avoid
double accounting we will have to rework __lmb_free().

Best regards

Heinrich
