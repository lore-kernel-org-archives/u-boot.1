Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64CAC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 17:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE97801FB;
	Tue, 21 Jan 2025 18:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="YPC9wknd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1FDD80283; Tue, 21 Jan 2025 18:05:51 +0100 (CET)
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFBDD801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 18:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1737479143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hkn2pQwaeqbEW+5u7qKYoEdl9Kut6DIs8spOkTtfTu4=;
 b=YPC9wknd8eNjqZfzACzMDa3f4rhOXvLf3Ip4Wu8IatTHCCjoGmi8HvyeujFWSKoplOf8m4
 hdKDSwl0NCtgXRuiiKi/W8wk27EqdQHbl7ySIVgDdNlsRVXqxU0EeCJ7copcLMDqIXNX3w
 IqnQKQPWbVQIj56CSn6y28qML8nNwPDxd0/4ey1+j+OuiiRNhTU+hEFP0e5iQ1M7XTpdjj
 2fgtxi6UjQPk8gasZHOhTGHFq2gi/R3QpkYyOz1nBcZO9jHAAMdmIxCmjwHtwvTEBKodkK
 6ALK3JcKgvh5Lxt7wpF0wNWbs0LaeKmcMlo/gw+QAc6rVT627zM9hoKpehCt9A==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jan 2025 17:05:14 +0000
Message-Id: <D77WXXXKK4CI.1LZZHRJQ98C3V@postmarketos.org>
Subject: Re: [PATCH v2] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: "Simon Glass" <sjg@chromium.org>, <u-boot@lists.denx.de>
To: "Jonas Karlman" <jonas@kwiboo.se>, "Jaehoon Chung"
 <jh80.chung@samsung.com>, "Tom Rini" <trini@konsulko.com>
References: <20240127162922.284598-1-jonas@kwiboo.se>
 <CGME20240403000039epcas1p46afc0540b893679113e0683d87227ca8@epcas1p4.samsung.com>
 <d7a2b5ef-ceb5-4f8f-b2d0-fcd6f2d6df1c@samsung.com>
 <33caeb3b-2945-49ee-8756-8cf8aec1c632@kwiboo.se>
In-Reply-To: <33caeb3b-2945-49ee-8756-8cf8aec1c632@kwiboo.se>
X-Migadu-Flow: FLOW_OUT
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

On Sun Jan 19, 2025 at 11:35 PM UTC, Jonas Karlman wrote:
> <...>
> On 2024-04-03 02:00, Jaehoon Chung wrote:
> <...>
> > On 1/28/24 01:29, Jonas Karlman wrote:
> >> The alignment hole caused by cmdidx in struct mmc_cmd cause strange
> >> issues together with the peephole2 optimization on Amlogic SoCs.
> >> Following was observed while working on SPL support for Amlogic SoCs.
> >>
> >> sd_get_capabilities() normally issue a CMD55 followed by a CMD51.
> >> However, on at least Amlogic S905 (Cortex-A53) and S905X3 (Cortex-A55)=
,
> >> CMD55 was instead followed by CMD8 (and a few reties) in SPL.
> >=20
> > I read your RFC "https://patchwork.ozlabs.org/patch/1841495/
> >=20
> > First, I will retry to reproduce your case with other compiler.=20
> > After that, I will inform again about this patch.
>
> Gentle ping, this patch has been on list for almost a year now.
>
> Have you had any time to reproduce this or can this be merged as-is?
>
> For some reason only Amlogic seem to be affected by this issue.

It is somewhat reproducible with gcc 14 on Amlogic S905X (Libre Computer
lepotato), except instead of CMD55 followed by CMD8, I get CMD0 followed
by CMD8 directly:

[...]
<debug_uart>

U-Boot SPL 2025.01-00633-gf79293cffe53 (Jan 19 2025 - 14:59:34 +0000)
Trying to boot from MMC1
CMD_SEND:0
                ARG                      0x00000000
                MMC_RSP_NONE
CMD_SEND:8
                ARG                      0x000001aa
                MMC_RSP_R1,5,6,7         0x000001aa=20
CMD_SEND:0
                ARG                      0x00000000
                RET                      -110
CMD_SEND:0
                ARG                      0x00000000
                MMC_RSP_NONE
CMD_SEND:0
                ARG                      0x00000000
                RET                      -110
Card did not respond to voltage select! : -110
[...]

And the board refuses to boot afterwards.  Changing cmdidx type to uint=20
fixes my issue as well.
