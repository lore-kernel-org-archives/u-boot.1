Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E71C88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B95C606E8;
	Mon, 14 Sep 2026 14:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5s1nieBPpCnT; Mon, 14 Sep 2026 14:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 66747606AF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395998;
	b=ejI4GcHZpWxGqyUkEjs3NrYc+1mEvWmZ5hKqn8mGOU4LN0L/2BGxAIYbua6C90DYAtoh
	 V+SH+tRpK9gdbW0oOosRYMBnFRnSXn85BKU8dbxSI5NX3qjfCS0w48iCI/m9lEJE6W6sZ
	 FpAn+GAQmixxi5STHX8LGrFAT1Jn7L84EmaICNVAc2PgdiAVAF3iK0W6vuNuxwYzEjzPR
	 RNa0axe2WcpyGK1zDRPj6UdZEDraSPHU6uO6mXd2TQ+9mzLhQ121xJBaYiNjHU0iJGUPn
	 Le5eR5pbzYi9imTafvvuF21/2tnMH+9n+GORTkfrvO+BAORLNIpKlcV+lPbNPwiCgBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395998;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zVlbntJQ2vf0SpXE9Ll7yQeXkxsBPNYBMl0NOfmI05Y=;
	b=G4WJPV0tEGRU3rI9RWEjzDbKXtoK4KOhwuBXXm4KP4Bb6qXc5GcECwJgcc6WoEPia1In
	 vcUQVf4/+ZWODvcgrRkEfU8+9SYiFTNNvn2rMPgqHB0Kwde0IoFgaiucAvxKkKg2LZQ8t
	 o38n0au/f9cjCV3XhlYKWd9+qbuAKQgZD5I0QOz7/uUD5fWA93tK20h27wjMeKfSsNTmr
	 lp3N6Tp6RT0PXGeEZbROdwOlcNmL4pUfPdHcz10E+KrTFifZj9NFkncqxXyFOdyNS/Ajy
	 PMVvFjH9EPLDQR7+SscannAgzhPhlQeU8pKC5zPRzxlWWp5AV1FZgncvO0ERG0AgDkg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395998;
	bh=zVlbntJQ2vf0SpXE9Ll7yQeXkxsBPNYBMl0NOfmI05Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EjWx1TX0G6ahkXS3j45zTIUrDThDzp1HZx4+3318pwKXE6xdoIiTTBI6+1w2h9DQ/
	 Of5cqXQ7OUZCHhzGtzcT4p5dHuLj1jkfcx4XRDnb9GSQWb4mqsm0RQcqceRkl1Jldy
	 WJMDUfcQJ3AxOoCI5+YOci6ZWGfScbhKFEET4759Xk+NZh3qeryqirsBX+yLWYyams
	 bYFEOYxEJ5urUvBmS5AaWOsjuffkK96IRIRHWIerpdWk+WLnOeehx3Y1LXr2NjypNc
	 OxXTGCVEmChf3er3937BgJ1PkO/cbKGukURcJdaLkKr44+gDx5SJuxJEcmw67Qaybr
	 RnSQSj7jYhjPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66747606AF;
	Mon, 14 Sep 2026 14:26:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A23FE259
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 14:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 940AA400E2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 14:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ku0lhTGl89Hi for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 14:26:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0743B40080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395995;
 b=h9527ddkxxrrBR5benyKxYYBDk6ovJh1sgd1rrXKEeAsm61ohfxIdKuxRIQ80nE1bIeE
 PW6gMCud/l1sHl8Wv8a7Nh1gQvGLQO+rKcPNN0pipq0gNpJ70az1Mj7C/0c7DKePeyoTp
 LuhIq+0scHxUjf9UiBIuJfAVL6Fxs9AyvZPxdTprhia0WaDVGxB/GKDFVDrWK6alCKwJn
 ZEHVjR9bRrPtfxHz0w6rkZFKuT+4ukAgGEkVf/eCCFOeHkYD4Tdyp5ZcvoNoPj6XVgQxh
 37h2S0VUF0v/O8slFoMX+sXKubuRbEclnBR4+uzULbogRVNVg3iY5pniBNvk31bCAhQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789395995;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:Mime-Version:
 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
 From:To:X-Mailer:References:In-Reply-To:X-ZohoMailClient;
 bh=zVlbntJQ2vf0SpXE9Ll7yQeXkxsBPNYBMl0NOfmI05Y=;
 b=P8UP7PKBA4syCYvPFejcxTF+6wIBFI6Z1BQHhvV5DxKlDHKkYwWAijaP7v1Iojij3k2J
 1eaKhvWAN160JAgguEn/ZBImPLy3hSV4pgvlYDJfzfloC0n5IPrR8zxUIMFZwKciLolp8
 OJF5OYT4/x4u/1+ZkXoplIVDYDFzwxk1ejgSYTDfpPyBIVxCLUKeiiDM/RRUqDU7T+2FF
 Yv+G0rR8zc/X0OylRFfQ/R3+velY3NFMexo8UgY16bzXcuJhEM5DtABN5BPd/27ScyZ4x
 urD1aVIP4tGTnvnSoQPrwl/HoOhSCwzROdLNiEVevqrtUJ8+DWTwkZFqq3JHE7tFcRw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=hdycfjcP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
X-Greylist: delayed 1803 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 14 Sep 2026 14:26:33 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=hdycfjcP
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0743B40080
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 14:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789393247; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CgJi5D+2ahzQA+plNd9h208+FDj1xv4SXdy4PSMgQJhvXMn7ngIQMqC8qG5QpyQLMAA7tBnFz+KA3cOQj0PTYPYC4D1ysigvUdg50NT+8RC64d9y6Gj0xBL3jFrxJQy0zvWNLZHgPYt4S2ud4jsdsTzy9qwI5jV0KHwNaIFMMQw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789393247;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zVlbntJQ2vf0SpXE9Ll7yQeXkxsBPNYBMl0NOfmI05Y=; 
 b=SdiQedLomEq72uGGmHZ+G4Spt1WvjY9gx+6zei+KkGSDR23mfCC5n5hAvsLwkcZybSSmLi3WYhpQwquK3chIwDrLn5TxFi3J00Lat2FudUODGU8+Ub8Xb0509e5oyoPUEQf4MtbtZHg3XZuCGGhhyTsmUsKEB+qzXCHrnGz3VA8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789393247; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Reply-To;
 bh=zVlbntJQ2vf0SpXE9Ll7yQeXkxsBPNYBMl0NOfmI05Y=;
 b=hdycfjcPEo6UnyyziiZYoVJvEyqofUhKY1dbrWZGa8m1pTJ9YLaCeuV0pbmqoOs3
 WUvzJF0fvL35rY28pyz2XKeI15ed79qI1GIaRGVtwo6bROUUGYvk8b6tZMUKJKTdxn/
 lwibYcpo2hyWhlLRx/wuN+x26f3e08bCQ+ZpJzX4=
Received: by mx.zohomail.com with SMTPS id 1789393244931384.04903856238764;
 Mon, 14 Sep 2026 06:40:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 21:40:38 +0800
Message-Id: <DLF2YPC4AMIP.2P3Y1FNCF085N@pigmoral.tech>
Cc: <u-boot@lists.u-boot-project.org>, "Tom Rini" <trini@konsulko.com>,
 "Quentin Schulz" <quentin.schulz@cherry.de>, "Simon Glass"
 <sjg@chromium.org>, "Daniel Golle" <daniel@makrotopia.org>, "Randolph Sapp"
 <rs@ti.com>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Kory
 Maincent" <kory.maincent@bootlin.com>, "E Shattow" <e@freeshell.de>,
 <spacemit@lists.linux.dev>
Subject: Re: [PATCH v2 1/2] tools: mkimage: add SpacemiT K3 boot image support
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Yixun Lan" <dlan@kernel.org>, "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.22.0
References: <20260909-spacemit-aihd-v2-0-780e98cf2fec@pigmoral.tech>
 <20260909-spacemit-aihd-v2-1-780e98cf2fec@pigmoral.tech>
 <20260910100231-GKI2330@kernel.org>
In-Reply-To: <20260910100231-GKI2330@kernel.org>
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Yixun,
Thanks for your comments, I will address them.

On Thu Sep 10, 2026 at 6:02 PM CST, Yixun Lan wrote:
> Hi Junhui,
>
> The patch looks good to me, I only have a few minor comments.
>
> On 23:51 Wed 09 Sep     , Junhui Liu wrote:

[...]

>> +#define SMT_AUTH_SIZE		0x100
>> +
> ..
>> +#define SMT_FLAG_CRC32		(1U << 0)
> is this a local flag? how about defining as BIT(0)? which is more readabl=
e IMO=20

The BIT() macro is only available when building U-Boot itself and is not
exposed to host tools, so I'll keep the current expression.

>
>> +
>> +/**
>> + * struct smtimage_header - metadata header within a SpacemiT boot imag=
e header
>> + *
>> + * @magic:	Magic (must be SMT_MAGIC)
>> + * @version:	Image version used when anti-rollback is enabled by eFuse
>> + * @secure:	Version slot used when anti-rollback is enabled by eFuse
>> + * @reserved:	Reserved
>> + * @image_size:	Header0 stores the image header size
>> + *		Header1 stores the aligned payload size
>> + * @load_addr:	Unused
>> + * @header_crc:	Header0 and Header1 store the CRC32 of the preceding 24=
 bytes on K3
>> + * @image_crc:	Header1 stores the CRC32 of the aligned payload on K3
>> + */
>> +struct smtimage_header {
>> +	uint8_t magic[4];
>> +	uint8_t version;
>> +	uint8_t secure;
>> +	uint16_t reserved;
>> +	uint64_t image_size;
>> +	uint64_t load_addr;
>> +	uint32_t header_crc;
>> +	uint32_t image_crc;
>> +} __packed;
>> +
>> +/**
>> + * struct smtimage_image_header - fixed header area of a SpacemiT boot =
image
>> + *
>> + * @root_key:	Root public key
>> + * @header0:	Image layout and load information
>> + * @key_data:	Key metadata
>> + * @oem_keys:	OEM public-key area
>> + * @signature0:	Signature of the image configuration
>> + * @reserved:	Reserved
>> + * @header1:	SPL payload information
>> + */
>> +struct smtimage_image_header {
>> +	uint8_t root_key[0x100];
>> +	struct smtimage_header header0;
>> +	uint8_t key_data[0x1e0];
>> +	uint8_t oem_keys[0x800];
>> +	uint8_t signature0[SMT_AUTH_SIZE];
>> +	uint8_t reserved[0x3e0];
>> +	struct smtimage_header header1;
>> +} __packed;
>> +
>> +/**
>> + * struct smtimage_variant - SoC-specific image properties
>> + *
>> + * @name:	SoC name passed to mkimage with -n
>> + * @flags:	SoC-specific image flags
>> + */
>> +struct smtimage_variant {
>> +	const char *name;
>> +	unsigned int flags;
>> +};
>> +
>> +static const struct smtimage_variant smtimage_variants[] =3D {
>> +	{
>> +		.name =3D "k3",
>> +		.flags =3D SMT_FLAG_CRC32,
>> +	},
> you may want to define a macro if adding too many more variants which wil=
l
>  make code more compact..
> #define VARIANT(name, flag) 		\
>      {					\
>              .name =3D "k3",		\
>              .flags =3D SMT_FLAG_CRC32,	\
>      }
> but I'm fine with current version if you're relunctant to change

I'll keep the current form, as introducing a macro wouldn't simplify
much and would make the code less readable.

> [...]

--=20
Best regards,
Junhui Liu
