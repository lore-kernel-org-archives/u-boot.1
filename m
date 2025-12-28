Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD12E784BE
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 00:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5629A83869;
	Mon, 29 Dec 2025 01:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ROfRl7aa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hRtTpK5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8762E83BFE; Mon, 29 Dec 2025 01:42:52 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B4B83759
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 01:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dfcrV2HDqz9tv3;
 Mon, 29 Dec 2025 01:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766968970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIlWZDJ/bNIzOdDmIth4U9B61LUH+q+vwUNlIpsA8eA=;
 b=ROfRl7aavv8UBPskveVLa3mrm0XplKr4G03sHgomBHe0ehCUX3rSYW9CnBlPLe7JrvPUcP
 XbFX4U6idcPUrIakPIXw3nBkZyfPETiRL4Jt0PgGcPFPRfE1uxltbY5tX2Ql6rIkOb/bqW
 okNcM2QsxQdxP2O5/YtzWsCTsU/iJ2ueotHhQ/7pQPiULomn5/VKEzbwt51gzBBv1h39WG
 jkDqlr+QkrLr9CVJ834Uxj8X02HG8vwhJ78vupN8PMwE8BoiHeRdyYYYBI95cgAV7YUHi+
 yWzSvfV+OC8FQnCd9P1V7aRgJvZ/ytl2C9dbwbXyAzmZo7qwCulg3AJeU6TUcQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=hRtTpK5x;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <1fd09fd2-0603-4347-b27e-4c041069db48@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766968968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIlWZDJ/bNIzOdDmIth4U9B61LUH+q+vwUNlIpsA8eA=;
 b=hRtTpK5xebyBeEFpFnGSoqT7CDQZ8gI3olwVIS0GslrGY6cRPO35LrR34p57tLMMpcJlFQ
 /ice+gszpo6IHUZ+EobSJdlBDM2pP5ydzGJgQqjOoB/EZzcMd0S0T0sU53/5MaeToOJtd9
 Kbu59Ey6QVSfHBgsvREO5g8nv5yAJK0dmN0HioyaF1LfiwzePzPU1F3d7LVJA8n56qJB6a
 Fg2dPTDNQebQ+WksdIRGoEumbi+WvjiRmMfc/zrIXrGjIP/B3Kuvw/6FoQ9D645l/Fv2lC
 7JTDV69w2VKxkKMVC2grceLFF5o1m3zbg7c9NRsepEkB3urOEnnPXAl1qSHGYA==
Date: Mon, 29 Dec 2025 00:07:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] clk: renesas: Do not enable MSTP4 extra modules on
 R8A77995 D3
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251228220717.3630713-1-niklas.soderlund+renesas@ragnatech.se>
 <20251228220717.3630713-2-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251228220717.3630713-2-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b6d2975d2b51204b908
X-MBO-RS-META: hnkegypfaim8w1afs6duns9uoiu9x83f
X-Rspamd-Queue-Id: 4dfcrV2HDqz9tv3
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

On 12/28/25 11:07 PM, Niklas Söderlund wrote:
> Since commit a2bd99549c61 ("clk: renesas: Tear clock controller down
> last before booting OS") enabling the module gated by bit 8 in MSTP4
> prevents Linux from booting. The bits 8 and 7 of MSTP4 where only
> documented in early versions of the datasheet and have since been
> removed.
> 
> To allow Linux to boot update the MSTP4 enable value to reflect the
> hardware default, 0x80.
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks
