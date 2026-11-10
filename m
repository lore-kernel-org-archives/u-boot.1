Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9C606A32A
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 01:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UQsNb0FV;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Nx2jwahE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B2C7607C2;
	Tue, 10 Nov 2026 01:42:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cd8S7gxyNlqi; Tue, 10 Nov 2026 01:42:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F310B60755
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794274957;
	b=DujX8cbnYiyCZpqgPyQBLme2jypUPa4KFX2WbEEbQEJ5IHpWf+XiecwUw1o1BphW6rv5
	 KtdeUBfMytdVV/mktJl66YrxKDlLluuitVgprosugUsYQz6IVdqOubeWYuQOmYOiAIvE7
	 jtjhlaP16/ITUaBs5lbrfuan/zbcGypsH9IG3XrTLIZRAGxsxgoQWcyIowQP+lOVjbNC9
	 9+W5rvcGMFLP08sbSlLkbSRVPSDAnMk70QXv5Ebc0wLFD1Rquc2dk4msCnx5V+YrCDIw3
	 kIp7F7B022H/yScppyDtMTLrbbwarcS4eBIgnbF0xKuH4cVxlIxEne4Q7SJmg1g2Lwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794274957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ICao5SURv/rRZg7H3NsXthDenyttEzQBR0AWNS589Fc=;
	b=btneMdT/ysckU0MCtMBsc/4jzNLdYGdh96dRzR+FfKhJUjHvoIcEo9iqvhmYyesRv5v8
	 bWyPflilaOsYkEOX9Gm3kct5q12bOTLyoWlZpOiSTXkbu3l4acNZ2zNdCOYZTynn7SJS4
	 V/JicbTXfynDHcCR42L5HqbVTTzDyTeFO22OnGLC14gwHT2PbfZEnDoXKJ/BBEF0iK5We
	 IbcZybrLdSmNfgFEG3uqUq6nvBupKo9eSmWkzHww21QyV3G3OZKJm/zHBCW6s5qBWLNf3
	 4Wabr4E1LsFFfjC8mG8xo1DOfY2ejeH5YwFCs3JvLWoUkTo4ru9e5Zd+jQkNijLlVJw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794274957;
	bh=ICao5SURv/rRZg7H3NsXthDenyttEzQBR0AWNS589Fc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UQsNb0FVRE1kRpUxWyZ6UBL2MqzCoUV3vJIN5Avpz7dhKOEaWtmKGPXfhSrnUoys+
	 hXaOp8Sqjlseo9dhC7ZpPZ9XWw+TPMxD19PhFhXng666mZv4LIY2tyUBKclsVcC08p
	 FN/RP2nqAkNRDoEkPU1b66WF2ldoqvBE8h9yry8Q+kPEvijBcsreZ2PFAXWA0wjMVb
	 iPkRFHTROFaV6de/e5JTeMcmR/NFTkl7LauTrnboLoHeeeW/zg5Fj7hxb9yg7TIOq1
	 WcCtLTiN4XRYTsUVmtWB0vaT7LPaiz/TMDGRyVIoAuw4K7a2i087dnig0zv3IyypWM
	 ngFl2tiZmcI3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F310B60755;
	Tue, 10 Nov 2026 01:42:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB48FCC4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 01:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8946980CB1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 01:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P_u-vINOKusV for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 01:42:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 48D5580CA6
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Nx2jwahE
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48D5580CA6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 01:42:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CBD8910D9B4; Tue, 10 Nov 2026 02:42:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794274950;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ICao5SURv/rRZg7H3NsXthDenyttEzQBR0AWNS589Fc=;
 b=Nx2jwahEhgSu/16FrLI/a7gJwmvYCY5N361tmHrPPznDZZvObBS7TQl65vxOCwbt64f7U7
 9IFf7XQ/mb3nwBffQMKaes85vd2vZVRu6SzPZIw6uw46xoDfWIk8Nu8Gn7e+/aeygnk18e
 mbTWiWDz5Y+IbH/dwKeaVWoPdbL71fBRqLmwnWvQpZHWJ+9SEdpboJbiKXOf8+JERNEiAo
 liNH9NlvS32OPsv7GjUQlIqZU+IlwCtweBoU4TqY474561uILWivymvQPkjDRtyx00NheJ
 s9cLUnATnUThstZ7IhssvVhT4W2LQcNZte+CbtG9Of6XYlOICFClRnczNte8vQ==
Message-ID: <a6365f6f-b87c-4d6a-8be3-c315931bf36b@nabladev.com>
Date: Tue, 10 Nov 2026 02:42:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx: Switch Data Modul i.MX8M eDM SBC to
 OF_UPSTREAM
To: u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20260902163748.1003274-1-marex@nabladev.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260902163748.1003274-1-marex@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/2/26 6:37 PM, Marek Vasut wrote:
> Convert the Data Modul i.MX8M Mini/Plus eDM SBC to OF_UPSTREAM.
> This is almost straightforward, except for the handling of legacy
> variants of the board, which is implemented programatically in the
> board code and requires imx8mm-data-modul-edm-sbc-u-boot.dtsi to
> re-enabled the old Atheros PHY usage by default.
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Stefano Babic <sbabic@nabladev.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>   arch/arm/dts/Makefile                         |   2 -
>   .../dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi |  12 +
>   arch/arm/dts/imx8mm-data-modul-edm-sbc.dts    | 997 ------------------
>   .../dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi |   2 +-
>   arch/arm/dts/imx8mp-data-modul-edm-sbc.dts    | 972 -----------------
>   configs/imx8m_data_modul.config               |   1 +
>   configs/imx8mm_data_modul_edm_sbc_defconfig   |   2 +-
>   configs/imx8mp_data_modul_edm_sbc_defconfig   |   2 +-
>   8 files changed, 16 insertions(+), 1974 deletions(-)
>   delete mode 100644 arch/arm/dts/imx8mm-data-modul-edm-sbc.dts
>   delete mode 100644 arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
Hello Fabio,

have you had a chance to pick this patch ?

Thank you for your help !
