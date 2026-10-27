Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9874606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H2qedka2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlaLr9LH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 434436069F;
	Tue, 27 Oct 2026 21:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tUQzBPX8YZQt; Tue, 27 Oct 2026 21:48:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8804560670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793137723;
	b=PjBMsfxZX6Dw/0Vi8o+EdJ6FDy/DgI+P5FJY/G4W/GBvAEcDyTjG2AFXacazySVFzodA
	 aCeDweBZQxxA5FR6l8Zz8Jn6HkpwRl/bZx2a+KIbkAQya/hPQ+4uE4bD6gOTUaGMjkgYb
	 OUMnUINgHHoUwlBsv8Nspxu9TLnpRGb6E7bKHL+v0pxc9iej3O0D/uVG1OGiYHBFIAmIn
	 EJSYhUounsQkX25aBWZi9TC3+xa9rrgQSc+lCcQl71q4SCO5KEUWFWnT/c9bXEg2WzfEz
	 wNU5rFnPfbI5qSlxu/T8DhjFsniFevd/tr8iXw3gJMAtRZoQNfoEwvBIKyI/4iunWtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793137723;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LE6Jb5jSxBRV4iQFy3bKQBY+5pi5c5S7745W69zGXYE=;
	b=U6vST7c9uQ4Hr1eE8A1noRFUPn6SHjaJy2Hrs1r5kVkfVo/ISjNk3SvQeSLG3Ijm2Tgy
	 v28bf1Z/BeLRuVk3nRyu6nQsAUVupF/ENS2iqXex+Tsf0FIPVLi8/zHvbUjE2Tb2gMGkM
	 9cfeOh9KOfyfEcAxF9h/qrUl/QXa3Qo9eopy6wpgHENyFnPjnS0I/nvaHxWpnqJ4SZhqZ
	 nGB1nzrt5+YOBhtvmiu0FCkGxS5SPo17FyJ121JxqwafD5OdvCh/Ygne5z0c/LVRpisOO
	 IlFCthMr7+Fm3LFoooU46yF8sGqcSpnsZQNE9rjmozJHH1tpGwmZkfSthX+7ecR0Vmw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793137723;
	bh=LE6Jb5jSxBRV4iQFy3bKQBY+5pi5c5S7745W69zGXYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H2qedka2V1XGBpp/eCSeW3kVdzYYGBT6dJp3lMABbv/p7QnzSYB/i2QS62kng1Ka3
	 C7gEBFb99qORdI5riFvr/7ODMhVvOkHChZrk7eN9VtNd44DVN34iIh2V3KuW+yQkEj
	 8NEZ7SHzMiXupq3o0hX9iv/+sYEiUB/O0aVoSirV9vX4g4Hl5RLVvK941qeM2Zc8VO
	 0zO9sBJxsxpRbEA6JiUMvU+aI154bKIuj2MZ5e26Jihz840XHzMkbS1n+VoIUuTiMP
	 XI9BxdtKx4Ys3NRaZaJSGrI1DgvgCISHsIJaNtipfXmCGYQKbZcCB7z+wUMGr+3I+6
	 jwW7abs1hUu+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8804560670;
	Tue, 27 Oct 2026 21:48:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 177FD4BC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 21:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F222C80664
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 21:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lY8lPj2Mfhzq for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 21:48:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 20A6480BCD
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793137721;
 b=Lw0i1MX8fkBep+sR23BWaAZt9HXMx0amkocCqpreF8O3EN2hBUmZzi/8ZktWqSFiGOd7
 EzauSupUt5lEuVR+uXwHZf/TMUSlToXSiTAVubkiNk+WDkh8HD268PQfWVBDvqb7Oh9nQ
 +LuvdYeCb54gUtwVKsxAJQUThk1L2tQ97Q+Bh2swpSxZwT581Xn3cfkamWz2UhT0gAo29
 /9xYEYlh1iRF/LXHXopECVvjfhEu5Le6vyRXgx5sL4DID6TamSHUsoCnCjtZE90OMUeDD
 qEAxx7RZfS/r78KVhTm/lVHX6igELvgC1PaqIKWY+O3pJBptbSNT5qXH8uYMZN8IX8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793137721;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=LE6Jb5jSxBRV4iQFy3bKQBY+5pi5c5S7745W69zGXYE=;
 b=kVIy/URCJNZUsztRpBLqiCjrNjEhKqegiTa6fwLanDVDCKsPORR/qRTOiwlzmh+h3fDo
 FmdT8NVKSN9hiLbSDJnjl+ti4Y/EerUp1gtScpJPtBD6QnuY7vbGghEcczQ9aBJg/eTZW
 7Uyd6NcXS8V0WjG13huar7JknCFtaTMCEtALPVnbxO3EnO6YK0Gfn8QNsGfcXco7sSbpg
 lvsRAbE+qLTiruEIlchJkXQiOQhnXg+dgPaMIw9IpHmC9A7zaQXYxukohJ12coJYz6egX
 HVWJS4185z+d4WgD+nVjCKlmcgGql+yaxfXFDL8k9ssIwl2jQEgDzy6+Ed2GkcqfYSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mlaLr9LH; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=mlaLr9LH
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20A6480BCD
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 21:48:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6284D6021A;
 Tue, 27 Oct 2026 21:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9384B1F031E5;
 Tue, 27 Oct 2026 21:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793137719;
 bh=LE6Jb5jSxBRV4iQFy3bKQBY+5pi5c5S7745W69zGXYE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mlaLr9LHo+MbER+708bfwkBfR508wNNmxLtNvb02niHd2Jh/RQTWUJZ6kFVumwhoO
 L9XQeVe6hZo7qIH9oC2+IpO1tfW6tabSYOwGp3bIcSrIz7GjRlAUHnyI3MhOAn4T61
 yPUbmVYSBSpZZ65i+c1QpO4PhindEAD4cs/fZHjdM/75Oo03C3im2pH8Oq5mwQkv6f
 VikQKLwBvg0YkkuvVofivcjeCE96ingSalDT9MyV8D5y7EkmCCyrvZaiN687GTW9nK
 QE7skr5EVzIbk8SG6HvVMsytlkZfl3ciQkzt5cYDsZ7rsFHlk//2I1ONiShgSLt8H9
 B7ducn2S8rELA==
Date: Tue, 27 Oct 2026 21:48:36 +0000
From: Yixun Lan <dlan@kernel.org>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <docular.xu@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/2] spacemit: k1: two small fixes found on a Milk-V
 Jupiter
Message-ID: <20261027214836-GKE125937@kernel.org>
References: <20261027154347.1392094-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027154347.1392094-1-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hung-Chun,

On 23:43 Tue 27 Oct     , Hung-Chun Tseng wrote:
> Two small fixes I ran into while booting the mainline SPL and U-Boot
> from an SD card on a Milk-V Jupiter.
> 
> Patch 1 enables the GigaDevice SPI NOR ID table, which the Jupiter's
> GD25Q64 needs; "sf probe" detects it on the board with the patch.
> 
> Patch 2 initialises the EEPROM index that read_ddr_info() passes to
> read_tlvinfo_tlv_eeprom(). It is build-tested only; on the Jupiter the
> current compiler happens to pass 0 already, and the DDR TLV fields are
> read correctly.
> 
> Hung-Chun Tseng (2):
>   configs: k1: enable GigaDevice SPI NOR flash support
>   spacemit: k1: initialise the EEPROM index in read_ddr_info()
> 
>  board/spacemit/k1/spl.c       | 2 +-
>  configs/spacemit_k1_defconfig | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
for the series, with

Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
