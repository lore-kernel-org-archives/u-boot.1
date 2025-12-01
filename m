Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160DFD116F3
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 01:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DC583D71;
	Tue,  2 Dec 2025 02:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="b8g4peGf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 658A383DBD; Tue,  2 Dec 2025 02:44:21 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B8D183CF3
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 02:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dL3Ts46bdz9v5v;
 Tue,  2 Dec 2025 02:44:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764639857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gr5aT0ceHEikuf6f15MfxoJY9jD/nOKyeamDivPeOL8=;
 b=b8g4peGfkbSUlubbAWtbfzoPrJqVDa89IARJG/58IUf0yE+PR/C2rvkTHqSOgsYLoQYZRv
 yPDIIw47s/7LBztIt1iF/vOTyY5vZ/y0j7RARFr+6IxI2ZRGCfumj5x+9ABk0sVrtf8NTd
 gcOMJhR5sFlBA0PNkrCdzZeYLMahHp0ylIoXwiEg+dROcP/ziQ4tCAyO7P1PU1EueL2qVY
 2TIduONaJtaKf0G3dzmEQRfCku1ayjdxO/CezJ3BuxkBIeO/3oXxLRNzs6qsjpF4JcOPqh
 e0ZcBjd/BT4BwKjrmKad1o2aLuK1Y3ql27C5B9btFwKoSWzl3+8F6xIV56GpEA==
Message-ID: <de3ebb61-09a1-4194-b5c0-1bcbc527ac1a@mailbox.org>
Date: Mon, 1 Dec 2025 18:44:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] imx9: scmi: soc: USB instance number change for
 silicon revision B0
To: Fedor Ross <fedor.ross@ifm.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20251201-imx95_b0-v2-1-7bc9851b7456@ifm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251201-imx95_b0-v2-1-7bc9851b7456@ifm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f970022e15b04457417
X-MBO-RS-META: rk8m4j37x1djodda7qozcxduiyb4ji63
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

On 12/1/25 5:08 PM, Fedor Ross wrote:
> For silicon revision A1, the USB instance number for USB1 is 3 and for
> USB2 it is 4. This changed for revision B0 where the USB instance number
> for USB1 is 0 and for USB2 it is 1, which is the intended instance
> number. Select the correct numbering according to the selected SoC
> (IMX95) and its revision.
> 
> This patch is based on the information provided by:
> "AN14750 Migration Guide from i.MX 95 A1 to B0; Rev. 1.0" .
> 
> Reviewed-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks
