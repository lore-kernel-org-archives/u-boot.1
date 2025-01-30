Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C365C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 10:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED178206E;
	Thu, 30 Jan 2025 11:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aSbHrp4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 085EA82012; Thu, 30 Jan 2025 11:24:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2463882074
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738232685; x=1738837485; i=xypron.glpk@gmx.de;
 bh=rx8xBBy2iwpm9BYLh93Tggy4cSMRVsX/MnNkB4/uvo8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aSbHrp4cNFREteS4eRQO/BMC+YSZkKRTstbyN3qOmvKdddlW3UrAl1eHG1B607A+
 2NGDRkCPUcqTaUmMNBTyN3tITnrUFZtQsJFT72zA5Z1fCimJx0XOHMKTsSWcYp+SV
 YPy619L7qv5b10ffbQOhdlbqx1wLpzePD+XbAJYUpNeISMYkE4fkxIgB4za8euLl7
 WmXjrjd3/eJoaYs+i8MyfDNwW3YFYV9bbfbaRl1v/3VayL3v3CIb+TZFsquNhvMIU
 lnlfvhaEdeF+m0mG8JFYiZ/jG/X1Fx/XSz04rAiGl52kYS5Zno9t7+eWY4Wi2hJOF
 raIrnzmBIw/O6/5ggA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzBp-1tuhSf3hJJ-00IhKg; Thu, 30
 Jan 2025 11:24:45 +0100
Message-ID: <22898270-b5b6-4bcb-9c4a-f3d62dbf5c86@gmx.de>
Date: Thu, 30 Jan 2025 11:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] arm64: Change mapping for data/rodata/text
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-5-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250130072100.27297-5-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ijo2sqd8HBlspacTOTiS/6T+VHBAxYMW0HcgR24TBxCTkRHT0ms
 wigEjexP9vbyvHNdheB2rOgOh+3u9g40E5yJc8LF2Ipf+KtsahynOJYGsM1PZyuFHUMlGXO
 IpA2WhzFRma0TY1VdjY2B/oFLOcqqrmdOZH2eIMMcAgdbCXyyi+rKVRHoIYQZAJwcQvzP/Y
 PUBQmwQXntXrydDIDC7VA==
UI-OutboundReport: notjunk:1;M01:P0:foLjoS5qnYo=;F1KSey/REmd/Kj1Vg5Vhuxw1VQC
 aA7v4ux76ndgAfsHxl49bkQNxIiTIyRmHvNhKnSDjI5vwj1giQblDx8TV7na2Rnd5hNQTuIid
 0V6+scd5Un0OE2Y48/rQAbFyy6LgX7mMIWocZEfUP7EHwB9AKRTJa3lHa+odbgElOnQJqAu2c
 KfKJrCMA1JIPMR1rgJ6CVDz0yLoM6zy0S4dSy6iiFhOnhxDcbnBwJIBN24JtKgBklky67C51F
 19yKtjJYm8Oq9eAKSXkHYT/StSqJp8RlDpRE3/tls+ep6SDrrNflIg+oonkRAT3rWr0F/8xS1
 OmznG7wul0eyUXXCG6PGV1g5jZtoBjdcSP+uoZoDcCpdD3wIvPDzZUjpLgQjivaV6d5CRkYIS
 4CY9t3+4YGsRf324T4+4Kq6KonnXXh+V2Ta53JanZ8NFcJm25Br2zpRaulxF+BmdbCbxyxgSP
 vafxEImKND01Aeaa5rWQAAfOhja0HMvkEIxhc35JAExODsZ7DFvMGnkl5c09ZFEMzeGH0D9CX
 xkGq8dQDgMS9z4MMOR/RNFzgsa3QuaYjFBy4Oz0Fjq6vXrG+H9gRJoRN6CrdbKilU5/cYEebK
 s2fAI/M9rM+cmXs+MuBPw2gvEO1zxHG51AQK31rSt2d8rrzWjlr2dEjwh06y5HUoymkY8MoSC
 tktIOeoZ9ErTI1NTKSxgev+MUqTRXlgOxsrmMAiOTr8DD5z4aTPuwUtY2axBoKp5onLhu0bd6
 1h3fxSmmYMoFCXIcV2bGJAQEVh7IZKyLgjwiD3kbDW0hYQZOou9NdVeGL8m8kexpTzGjxh0LM
 v81DhCMqkx8YqPmj8Nac+4e0stDHqKG4Yk/euSTF5/5+xomP/j4TKj3tESMryDg2memkY4sni
 NpJEj9SgFDkJOW2Zrx90XQyI0K9GKAetv1+VwTx3pcbBzmdMl67VWg4X1mKlXvbODBju4U69U
 HTsbIM5OZ3E0V2oriDwwx+fPf0pvOCL3a6RxW3lnD/4ZUEfACiNgRwuogmeXaBc9HszYHUJp2
 3OMBITFeVaC8wnUsYb1qZkpPdno5qY0X9JwSIhv64bVbNudTl5AZ8tofrnw3ELjIaI2XOfQbe
 OeVFGe6SRABJ+0nukeWnnDddu3SsjWuylEUuMjDhTCL/eebsZuX8txoftTxIac95elIKgNO6O
 qho4ti4YYHbZeivZUGW2o0198htSDOlpPrljGH8svxA==
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

On 1/30/25 07:20, Ilias Apalodimas wrote:
> Now that we have everything in place switch the page permissions for
> .rodata, .text and .data just after we relocate everything in top of the
> RAM.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   common/board_r.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 179259b00de8..38944f600fd6 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -170,6 +170,13 @@ static int initr_reloc_global_data(void)
>   	efi_save_gd();
>
>   	efi_runtime_relocate(gd->relocaddr, NULL);
> +
> +#if (IS_ENABLED(CONFIG_ARM64))

'#if' should be replaced by 'if (CONFIG_IS_ENABLED())'.

Shall we make mmu_set_attrs() a weak function which each architecture
can override?

> +	mmu_set_attrs((u64)(__start_rodata), (u64)(__end_rodata - __start_roda=
ta), 1);
> +	mmu_set_attrs((u64)(__start_data), (u64)(__end_data - __start_data), 3=
);
> +	mmu_set_attrs((u64)(__text_start), (u64)(__text_end - __text_start), 2=
);

Please, replace 1, 2, 3 by constants both here and in mmu_set_attrs, e.g.

1 -> MMU_ATTR_RO
2 -> MMU_ATTR_RX
3 -> MMU_ATTR_RW

Best regards

Heinrich

> +#endif
> +
>   #endif
>
>   	return 0;

