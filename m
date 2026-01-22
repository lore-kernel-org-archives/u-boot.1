Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ADBC44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 11:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC2E8397D;
	Thu, 22 Jan 2026 12:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N5dpo+GU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Jxtna+fw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E775839DF; Thu, 22 Jan 2026 12:22:14 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD59B80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 12:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dxdv64M0gz9twZ;
 Thu, 22 Jan 2026 12:22:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769080930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LaqrkX+3QZArJilC3e3rGIVdqSvkrx+qhSFUR6yFbdA=;
 b=N5dpo+GUjRoLXUO7Ym+pBeb96af/hC4RcbXskFmftFBCMOJ5mvwFlBg/GHqFF78rBeRbs7
 EtXWcawUcsstp9TtPP77IZ3UA+Voon2oU+0/3SzFyCI805LPRCtAYNnBIUjbTqktBrbzgY
 Cmp0jH/VPdk/5GCtVO4Obb/dbI3DpVhh1wuxtOiDAr9CpzyFSniv4e/KdErQAo4osKyzTE
 CVVCWyjkqDhLQADfcZX2VTxytcvGyZndovscKgG+26QQBgmwrUAZYfPyFnJPrA08Gwgnk/
 qbGqiZ1KYIcZ5DxxiDtl6CO6pj5p3isVYIzETP+bv7WyZaGTvNoayJL5CgmtSg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Jxtna+fw;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769080928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LaqrkX+3QZArJilC3e3rGIVdqSvkrx+qhSFUR6yFbdA=;
 b=Jxtna+fwzosUWc6gSim49JY8+NBsTLtT0RT4wg2csac0MGpUAyn/AURl7T1pDcihTms/eT
 OMk/8m+k3PJuDkEsMd8L+nFaG84W8VGSNCphu1hq7G5dbNpNtUMu/y5afigoKsi3eccdAc
 205osVixr22Swa8mhVAfsQlA9287jXpkKO915sxbUX9k7xhMQyjO7XhjqJ3FsIPYEkqvqP
 yiUQkSMpBXDErhlJeABjcg74SmwAJnFFIO3ed66wpETGI8QTW/fUNfRqJMbCTwt5dPvvy5
 98075ubd+WTQSS5Vtd87+BRXQPvhSSPKymNhxOKhVRcVLZJHuRKvVC0n7PwI5w==
Date: Thu, 22 Jan 2026 12:22:01 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
 <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yh4aumdfaw5dowpwyuk3ew9x41n5zmm1
X-MBO-RS-ID: 87f6b719e876043fb1b
X-Rspamd-Queue-Id: 4dxdv64M0gz9twZ
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

On 1/22/26 4:33 AM, Fabio Estevam wrote:
> On Thu, Jan 22, 2026 at 12:08 AM Fabio Estevam <festevam@gmail.com> wrote:
> 
>> RV1108 is also an ARMv7 without SPL_SEPARATE_BSS, so I believe it is
>> also affected by this change.
> 
> The change below restores the boot:
> 
> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> index d780a5060774..fc2b7fcb969f 100644
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -40,6 +40,7 @@ SECTIONS
>          .binman_sym_table : {
>                  __binman_sym_start = .;
>                  KEEP(*(SORT(.binman_sym*)));
> +               . = ALIGN(8);
>                  __binman_sym_end = .;
>          }
> 
> If you agree, I can send a formal patch.

Shouldn't we instead find a way to surely align ONLY the 
_image_binary_end or __bss_end symbols instead of adding random ALIGN(8) 
into the linker scripts ?
