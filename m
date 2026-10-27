Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84301606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AGUHFgwS;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=Y/r+aVaq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91FDD407FC;
	Tue, 27 Oct 2026 17:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7-UptpVVO3VM; Tue, 27 Oct 2026 17:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 43CFC407EC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793122401;
	b=NSqY+6IsDh0Ux11VrfuWNusGTNSM0qxfJXYFuEbUVeIQkQkm1Nj+5N7Z4yDUnAzz0DGz
	 OPFvErajMzvQcv/RnwA1iIKUNEAVqxHWFuDfFgko/WE2kBhN8vOn+os4fObsku0Vb+fZD
	 6uSCxWXOsHBVN6sVTNDAIAjsKoIs0hepBUcGW3OPOdjIKijYpYXJQeBbXzwDwYPSA0MvZ
	 ijjZtX/TppcYYhZXZxgeFzmEiMr9XTBDKC5cb7e756AdIny5dRfIouBInbyAXHe91Bmt1
	 eqx2Lh9TBORQEHp10vle+gzJmDsf4Z68CZ5A5la59PDgVlvzjhWkdDJYan+M1jmeIzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793122401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Uwxdryz3p31eFSBmrcjcRQPzwpLVYLXFvHAnAI7dXzY=;
	b=TEinvLruGpK6eUU4Uc1cBDxL3rvJJTL5LIdQtZktXglQgAX9xCT1uCJ2KPsKO3ehjyYw
	 n6qHJtrLadrS2nDRqGiFPZjxptPVG5+rk9N5tJ9S1n9PgF520wpeTwNQssj1t+q5MqBHL
	 /lGUzG9RysNKiv5N25uKH7jPbNacaDZ9MM/5zNFL6MXFU2dmTLN+8zJxRuU495Vetw8WI
	 J8xyH8d1prcbLa2cG5J74ZnnppnV5+QRNxHMQfyP1bokGBWto6O/nKJZpa3Z+LwHcRytm
	 aYJNPIHxYUCMPYxdlRO75byQJO4EwD0u8hgHqExXI4oy9PAjGMN5uqcH7EEkyBGi+Fw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793122401;
	bh=Uwxdryz3p31eFSBmrcjcRQPzwpLVYLXFvHAnAI7dXzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AGUHFgwSc3tYIF1Rrd0277H3u2tLDJzDMTnA83cNwjtHLHWtE2yOI8IbM3NlbF3ic
	 TL9pLrwtADG8O9zPxhmidrYeKmEQLpXh8+Z8c/DEd/ahIY+3E5USwRmD6wxwAFhi1h
	 2pEeUIIjrYTbRy2Lrw69jblLR0Q+JRdRyjTukzrgw4ujCodqp6PGtrIyr8qd0LoY12
	 XvMjwUFBXRFFF0q+aDhM3bCBKKvLF3XqX9pr3sfZZlIMuo2Mc0UOYBgPbrXXY7GKpx
	 U0KTFCE8KooQyTuba+UxfaGxKCGmoZDs2cmLW2cuvSheO9m75cT+EWQ2mgrjer9tjy
	 ioUMNG54KLhxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43CFC407EC;
	Tue, 27 Oct 2026 17:33:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 55FEA72
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 47BCD6068F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wsbGqU83bu90 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 17:33:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 051BE60613
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:fff0::bc0f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793122397;
 b=WeUjlJ3fpp0ap4mkc1YlO0jiM7+giqrCofSXLP9SNY/hHL/evXwotO86RlI6jHLHelrJ
 hUVIMB2IPdtTLSnpUE3FhNt+hHyPFrs5mghAdfCimgNaSD6fitsYHVWJL111pWo3f/ynv
 J3J9PAyKcfiM6Z6cSFA6J5UuvdDId9C3eVBYsZlNoT1MbrZO3EVx+xXM7ioiycEKabCnj
 KQQhSmMT4iHSSqcMh6eDYa4byZLMz8w3W1ltoDIGAnReHaFU4IZaasra+Zze4ZTRnkCgo
 DERg1F66CYQM63Ook5+0TyRKuhLPw8FYIZyBdW4XCU/OxM2qHzC8EUhRYhOSj3vs6cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793122397;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Infomaniak-Routing;
 bh=Uwxdryz3p31eFSBmrcjcRQPzwpLVYLXFvHAnAI7dXzY=;
 b=J/nVf9MLCRfvzwZLKxKy5fxp3/ResL5fqf06HkI5e6v3q1O2oLr8qUAjmYd5rfzwNjBU
 xpxjcFQNmc23wmPMEtoPofCi55UL2+Hhemn5inms0bSPNAQhJln5q4uoO7lsMkVa0xdSf
 7Z5QzG5nlVcfIMbxlHAi4uw9E6ks+yo/6SaAQMhnv/mTBuiECdBWBl702WVfH3a6UwRqf
 Cd4XddJafBmudIzUQ4KMDF1guhF/DH8CuAEuKE23IO4lJWqts5b7yZL4R93Hp29r0sxFf
 PDnq5RVSipS5UHaSDUwVPRTiCeWUZoQ5dXdylUeIwDJSPK4yt/GdZkXG6OZeTZ5L9Eg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b="Y/r+aVaq"; 
 arc=none smtp.remote-ip="2001:1600:19:fff0::bc0f"
X-Greylist: delayed 589 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 27 Oct 2026 17:33:16 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Y/r+aVaq
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:fff0::bc0f; helo=smtp-bc0f.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::bc0f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 051BE60613
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:33:16 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jDcch5j8cz1tGT;
 Tue, 27 Oct 2026 18:17:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793121444;
 bh=Uwxdryz3p31eFSBmrcjcRQPzwpLVYLXFvHAnAI7dXzY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Y/r+aVaq2/DTrUiTzlM2gkuwWX++XzeyhdCVAUXrJriPN79ehOG7YmXB11L53CsBX
 7V9suP9Q4MsYTrE88xG0tQRro+kogH/zTUKLnhYunkg82R2j7isCRDk3dS9una0cKq
 mBQg41uwQ9vIoVVo/N1CXhzy2CJ0Cgr6q1sIAFtXa5/pxC2J4EBeV5AVe3I/csTAmx
 P/Km9hIdanLaiZPQvk57p9YIFoG9krXLMO//IrexcVoxNWSBqOuOv9zy7cg4Mal84B
 vVuf9dgOKBbxOTpkzgYuPKMLohzRc9kMssxPAu7GOQmTMnPt6KPJzkuAZyJWMnIym3
 6hySnzap7/+kg==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jDccg2MQpzQ1y; Tue, 27 Oct 2026 18:17:23 +0100 (CET)
Message-ID: <a8ccf1c4-2979-4b20-86dc-9d089ee86126@0leil.net>
Date: Tue, 27 Oct 2026 18:17:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] board: rockchip: Add Xunlong Orange Pi 5 Pro
To: Dennis Gilmore <dennis@ausil.us>, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20261012020134.621305-1-dennis@ausil.us>
 <20261012020134.621305-6-dennis@ausil.us>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261012020134.621305-6-dennis@ausil.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dennis,

On 10/12/26 4:01 AM, Dennis Gilmore wrote:
> The Xunlong Orange Pi 5 Pro is a single-board computer based on the
> Rockchip RK3588S SoC. The board provides many interfaces, including
> two HDMI output ports, a PCIe-attached Motorcomm YT6801 1GbE port,
> an M.2 M-Key slot, one USB 3.0 and four USB 2.0 ports.
> 
> Features tested on an Orange Pi 5 Pro 16GB:
> - SD-card boot
> - eMMC boot
> - PCIe/NVMe
> 
> The devicetree is taken from Linux v7.3 via the preceding dts/upstream
> picks.
> 
> The upstream devicetree muxes the PERST# pin of pcie2x1l1 and
> pcie2x1l2 to the controller's dedicated function while also using it
> as reset-gpios. Linux switches the pin to GPIO when it is requested,
> U-Boot does not, and probing pcie2x1l2 then hangs. Override the
> pinctrl in the -u-boot.dtsi to use GPIO function for the reset pins,
> like rk3568-rock-3a-u-boot.dtsi does, until the Linux devicetree is
> fixed.
> 
> Link: https://lore.kernel.org/linux-rockchip/20261002025746.3284691-1-dennis@ausil.us/
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> 
> Changes in v2:
> - Add Link to the Linux devicetree PERST# fix (Quentin)
> - Move MAINTAINERS entry into alphabetical order (Quentin)
> - Add Jonas as reviewer in MAINTAINERS (Jonas)
> - Drop USE_PREBOOT/PREBOOT (Quentin, Jonas)
> - Drop DISPLAY_BOARDINFO_LATE, Model and SoC were printed twice (Jonas)
> - Drop OF_SPL_REMOVE_PROPS, use the default (Quentin)

I meant to only drop clock-names from OF_SPL_REMOVE_PROPS, not the whole 
OF_SPL_REMOVE_PROPS.

Do you mind if I apply this patch with

CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks 
assigned-clock-rates assigned-clock-parents"

added to the defconfig (I'll mention the change made in the commit log)? 
This would be consistent with the other more recent Rockchip defconfigs.

Note that the first 4 commits are now unnecessary as Tom has merged v7.3 
Device Tree into the main branch.

Cheers,
Quentin
