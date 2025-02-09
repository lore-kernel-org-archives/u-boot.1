Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47E5C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE9080BAE;
	Sun,  9 Feb 2025 22:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WKpNzM7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B41A80819; Sun,  9 Feb 2025 21:27:53 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021BB80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 21:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739132868; x=1739737668; i=xypron.glpk@gmx.de;
 bh=HrnbXr9pHf2taGcJvDQWt//jmozt5bCmJ/cYttZ6rgc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WKpNzM7jgth1S1CNYssoGri5QABANo+NSWZ/2Dgzka88sBxIZ3sCTHxij0mjWLn7
 qC2UlfNXACw7moOsqLHxVEqdVsQWuY0k1065c4o9hU9w7CJCCZlw1hayBzubSCNa7
 bo0vSgkPngYZMYFCQV7H/chHbvtvotr+mdcMEnEQmYo/R098qLC0ofxX8Bqt4SdrB
 55LJprlCmFmY7g5v0mj5HB6njYE6X2cmP5mDpTqoxDnRKDonALlgGSDRw6Ql634Gh
 e7HM7jhAWW5ducEnQHoWc6jNI7VzPWq5U0Zwcq40dKBMu/6TVR2n5RTpnquN4svhP
 ihI5fgaMDGC4dx4nBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.104.145]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1tCIs63H5l-00njHC; Sun, 09
 Feb 2025 21:27:48 +0100
Date: Sun, 09 Feb 2025 21:27:36 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?ISO-8859-1?Q?Pierre-Cl=E9ment_Tosi?= <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Jonas Jelonek <jelonek.jonas@gmail.com>, 
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_5/6=5D_treewide=3A_Add_a_?=
 =?US-ASCII?Q?function_to_change_page_permissions?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAFLszTj9zHTcvqoTGznB5WkWRoeBZ9EznVVAb1x7-OoOmYGu9A@mail.gmail.com>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-6-ilias.apalodimas@linaro.org>
 <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
 <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
 <CAFLszTiESUm8bqdqZdaLDTz65UXpyTLxm+rCoViZMchO4QWY4g@mail.gmail.com>
 <CAC_iWjJ7tiTyqq1CXupHMWpfBLSFTu3oEpE798C5N61-zVNo9A@mail.gmail.com>
 <CAFLszTiPkL=V_fAFThccQH-Q3Sj7XuUWJW=DJX2O9yqDF8AVhA@mail.gmail.com>
 <CAC_iWjJDNPWTVLXZS3_G42Tn4+m_nZtr+4XTJb-SKZ55UbCudQ@mail.gmail.com>
 <CAFLszTiys=22YpObG33wPWoGDfogtSLNk7MsKHxb2ecGmncHYg@mail.gmail.com>
 <20250209163934.GM1233568@bill-the-cat>
 <CAFLszTj9zHTcvqoTGznB5WkWRoeBZ9EznVVAb1x7-OoOmYGu9A@mail.gmail.com>
Message-ID: <93152001-E018-4E2B-BA34-39D961624FAD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BH8+E9YDOh0BKbI1UsJY8wei1lqWvUGcSDwEij3EhHcXPIElUl8
 i+CC12oA3V8Dy+u3Fd0dtr8YYu1guO/yFbzx6BF36dEiVv9LA0kqErBHLAav2ly1Fwz9tXx
 I1aD4WEqdXHzpMejzdb/Qom5bRllm+rTI/NDR4tJ37f+Jr+tNVjo8gckuVHsU+KEunTFTmV
 OJwR5d3B6a9mEWzYZ7uZg==
UI-OutboundReport: notjunk:1;M01:P0:FG9uJrrhCTY=;+8LF3F6xIyYGkt4TMBp7RPoNIGs
 B6xGVx9XhEMslnDhKdD92vT55YWZKPMXLaOZYBKngXFqc/r6ItO0MQ8+lGHP7L5ZXmhBXVjLM
 EpMPz3HS5Qwl9gs+S7AZpMUUyOjKJ4EeP6QIzQlkbjnzL5BMh8Mc+urNKCHTZBiaIhjNZzC0W
 nbH/TFNQpkII6kgiTpYR/3q3lVTjpY/36+p/4iy3lZPs33SDrJ49tkkqlkm63JR1IITzshAZZ
 jQoqaWQLr+E16KO9N8bgp8YpQNC42v/7sDvB32tVgwLhvwOHWjGh8/PGsKINmZaeybipfW8QW
 ACNxjCBgOoiLJxPhbYrQSRy48PlpJlYqTFnaL4K7ay3egqJbFH1yrCu4GxNKE+xQjjVTedqT2
 TJEa4Qlo5VasFIl1yyWKUTAU0bzIaBF3PGVEzoprqUtN7m+MvaDjjKOqWe4T7oYuXSdRC+5Bz
 wAqnzR2U41hCea/T+VFFsork51OrgLKniSjZbylB2ll64CbNpSKGgnzyymeqc01glL5IBdK70
 ubZ4tQZVdtTZ141iTIw8M1zoJOJ1KRAs9JB0VLvvh41pbJTC0aCwnLkxpzoxo5glpg0UlTxzI
 F3Sir6EjqoVu9arSpUnOU1YypxNsmsaLz81w2H7Yedtpgs73hF4FdMxgMJAASkURh1No0QY27
 3QL8lvcZwj+NQPAfujOAf8PSV2j2Q2bkIK1iydYIq9zYGUuZYXneyAdVO9gTT3C56WbO18E4N
 6MRvTSuQMM6ELaI/Aukv6CjHc+yZ0G/BQ3v/WI6WbvBTQaGQTThPAsvK7tH/89iLqTjxYzOw9
 xthrGw8WS/3NlKzc0wCY1UphfOknBAsg2ySJqmPv3HdxD/O/1KAAtbAg8e9+dXeTYmZv5xdUb
 U0KPADv1KNyn6/rHhLv9CukpgkbpImFEmUYvtI3GXAbM7z/4WD8oycMeGh+H8tneWh1PbCNCb
 8GENiIjeqBGT1U1+j6ImlSpAcb45vGCyXIqkEvraap/Ow0cTvFzHi5DSqoXVUpevXcmutesRH
 Sgng0iE6uEXkryxTpVLdL3opYxXYfcivYWZn6LLBELqng6jP6+npd0BDYfH7TPlFH1X6KK7XU
 cz87BHFKwBxUsJxO1GGjnbEbmB2bHXgBMIz/b5229YYs7xJQk6s8vpBoei8wFIPXDu9utYYkA
 SrbswWpE3A5kwbQK71/aDOSNffnhhnYwhBSgdAhWFIdzqmEEV/6FksfBhE6FPQQTcvnpm/kRu
 DduN0/lBI3UgwSXPHKTCxfXtnCtp9eBSyjdpYPuK0IqU6hcL0GdtEXt3sSI1eL8GOjlKOPDcj
 F7oeO+riZ+M4Vw14KernStpkNdTqX4e3YFLXkI+a8/Cn45TTRAt6zQ8bSl1ECoUYmcJk6Jyw7
 SAR+dxgmhZL6xT47SIrl5DEqrfOrsRUGfDh78kIFB76/8azn+j0lAsf7alnZnITXvS1uZMlXX
 bMb7uGg==
X-Mailman-Approved-At: Sun, 09 Feb 2025 22:36:54 +0100
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

Am 9=2E Februar 2025 21:15:53 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Hi Tom,
>
>On Sun, 9 Feb 2025 at 09:39, Tom Rini <trini@konsulko=2Ecom> wrote:
>>
>> On Thu, Feb 06, 2025 at 08:47:47AM -0700, Simon Glass wrote:
>>
>> [snip]
>> > Perhaps make EFI_LOADER select CPU, or depend on CPU? If that's the
>> > way you want to go, I'd be happy to do a precursor series to deal wit=
h
>> > the fallout=2E
>>
>> I'm not sure what EFI_LOADER has to do with the generic security featur=
e
>> of enforcing permissions on pages=2E That's something we want everywher=
e
>> that can enable it as it's a good defensive security measure and also
>> catches code bugs=2E
>
>Yes, it's a good thing to have=2E I assumed it was related to EFI
>because of all the mention of EFI, SetVirtualAddressMap() and the
>like=2E
>
>It doesn't have to be DM=2E I was reacting to the idea that we cannot
>add it to the CPU driver because hardly any boards have one=2E How about
>mapping arch-specific stuff to generic functions, like we try to do
>with the CPU uclass=2E The enforcement happens before initr_dm()
>although I suppose it could be moved later, or a CPU driver could be
>started up before relocation=2E Or just don't use a CPU driver, use
>something else=2E
>
>WIth all the pain I've just been through with the EFI link scripts, I
>would have rather seen some effort to follow the existing convention,
>e=2Eg=2E text_start rather than start_text=2E We already have
>__image_copy_start - there is so much arch-specific variability here
>already=2E

Like we did for the EFI linker scripts we should standardize the u-boot bi=
nary linker scripts by using a common linker script include=2E

Best regards

Heinrich


>
>Anyway, I'll stay away from this series in future=2E
>
>Regards,
>Simon

