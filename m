Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002B606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eJEyRUGQ;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=aCpsRXZ0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 609AA60792;
	Mon,  2 Nov 2026 09:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QpTF-hqJlDoz; Mon,  2 Nov 2026 09:17:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AD9D460769
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793611059;
	b=eK2yhV6h1N6fYSMsyxkhh/xt5tv0YLlvgqmsZ+af1ygS/wIEw+X6RXqnkYaOxWw263de
	 TW2lVTxwMCXWWQ9ggdUktMRCadnvgLIo30DWaddq7miCHZQEWuUxcLi9AUBpiAs+kAENe
	 eJLjutstO8TFGNT2bTWONbzj1E7fRWidNVlZoY1/UcPiwDhlb2L9/tTBK6O0pUjS9nPj1
	 rwIxe7zt6dNq54uOPpcGkGNUgOgtYQCSSr6CI01Yu76Fsb/ginqO1e7gu5YdTUY/XgjOX
	 IAHSqfS8bAOrOv4DaIiwBHmUpPUrA+woCzeA3483/OPxwDQyCZMzTd/R9AA9+XXyRMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793611059;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WETm2Id4IAzPB6chp8689M9aoR2461TtP3m8tGJr8NM=;
	b=O1uf5hpWW7lfsDuH86fy2rkb5wYDCcIX4eCw8NvLUj5bhW1+b66Z+nltrVsIchycgmBd
	 mv4UQBtp50tg/bz3Z1v21UiRf3VhBq+G+t7mMRa4Godi2yaxq4sMmzc1NaCCyN4M7iNpA
	 YA1OoyEI3DQjMCURIWrzOszcPlt6wHs8yWAhg1YoPODuE+lBhQd/GECrtvF27CX7hLspE
	 E2/kabzYozF5NEyelTnG3xHvJdB/EAh84YPqdni4Mw1e4iuv5xbOmkAma+qaNujKEnQ+P
	 MSFIGXCyrb7UCUwu6tuopMROa3vU/i3T/+flv/jZGHnO08yVhIRRZqhBZltiZhuLivQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793611059;
	bh=WETm2Id4IAzPB6chp8689M9aoR2461TtP3m8tGJr8NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eJEyRUGQJrf6B6+a2UszJgmqzlrJTs6YXjlT7tuN3dWWnOT+GO3Eha1+zS/7RsJSU
	 ycOQH+5+faX+xSYaZEz2wACnMi7dySNebvTJSExwJ078uaTvef2gjMBqQhwbRlDYro
	 TTFqwQXPQOjgYlZjs5whCwyPukQhxHqmH5amM6386Py0BP+OLPjkLC908sjacVvoMh
	 CODmCQ3NseL1TePJ5W/AaHO1i+W25JhNuRPlTaxmjRX0OReV4jtguqciQ+wThC6g8Y
	 77KkJ2GstXIYTQwX8UjAjzBoFuumSM0Ox+xDic1h7DS3qoJJiljI6/Q2fKw7A5ZPQU
	 4HRJqklYuLFoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD9D460769;
	Mon,  2 Nov 2026 09:17:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D2B0D3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E8B7401BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SpK74jndZ279 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:17:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 00F5B400C8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793611058;
 b=s45EhzVPndfotnGk19ZqU5RMG/kiUdqBhyNtrWtexFH93EiyJrStL64vBK0306Q4YnlW
 ndqW7Hq49uchjFRCCFcQ1JxdVzAubbU/8Qbz/c9IChF4c8bULqh755lawXTG7/2CBYrPT
 hMueJHdGS8VE6h1aZksijIOKsVUyIoFbt1LWZuw314d2walHbq3jsWG5HSLA+J4EH95mt
 EagCTYrRuBRGrpB5dWhUT11zqVhYGWn6WANkOr5qN9tuBGe1Z3zmugv2p9PFv+KNEGbZa
 yPCXeDF4hIFMDv3JJ42LLMv3KFsEKuRn8My+4osC0PfNNpidmPl239BC3sDhCb+MS/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793611058;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=WETm2Id4IAzPB6chp8689M9aoR2461TtP3m8tGJr8NM=;
 b=NvdebEVYO+fNAU3o7NFDZiuDoIl6qZjCN9D+00tigfD0rhEtcJhqCtmG9lnIbAPnPxAT
 bRWnJ7ssuHzSP6OL6IcR/4x01Ry0inIgeLwlYuYBZWJg0GtO+h25/my3PjAzAsQX45M7v
 JfySTvpXGJ2YExiFAfQ+ivMquWshw0m72uRti3kjU5gEoYqpvgNF7FPkHlILCNCaH0PoO
 5YUuhJ4t+j9UMz+rjnOXpobb6xISMrAaXJCImiOkSPwFCC2EspxwzPe2fdN1ZE1sEuNQJ
 Vw164bPRdM0qpxG93ZwCB1qfKCT6nSYSkEtbVi4U/83v+NPKdeIlzap8YPpyNkCbhYw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=aCpsRXZ0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=aCpsRXZ0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00F5B400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:17:37 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc7e79c1eaaso966333a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 01:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793611057; x=1794215857;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WETm2Id4IAzPB6chp8689M9aoR2461TtP3m8tGJr8NM=;
 b=aCpsRXZ0XrdZBiib8mafUDDyGE+mzEhL/Uk2e4lN+joAR1/QnQrJcOy+8UT3CssiPQ
 FT/rAm3KiUoEjDc7kXcN983XGoglPUIxpWDVNmsI9ix67SfKZYULtT0Fh9XkTwGh//N5
 5Ys0sPP8ahvwt2wBwtdIIFTn8/7NAE42n/wbOXWV4cAFt3vtP4JqSw5FUiw/eoP/3KIa
 UgZ3+g0Cqvobe+V4rOxnNgz4VnJ+vdORLlHLOS5AP/oIgtxncOA/8wtTNm1CkKl50Rdv
 dlPppeSLKiDRFiHEgtW7zuXVrRrCu5BpYCdYBYzJlMzd95BDXy+P0I8GXvkSXgaUu7Af
 eOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793611057; x=1794215857;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WETm2Id4IAzPB6chp8689M9aoR2461TtP3m8tGJr8NM=;
 b=M/gssMt30kLPQ/7lEwlUhwc5EZNEo2O+pvbc11ltjl2rLwQ3UacDKHlPx1r4SE9x2z
 geXKzoOEzD6xi2g7zzOGiRdumsmK1n7l981yPJ7qDQa87j7TEIYWUCYRDfDdGIu0fwmL
 TvbKKZu46+vjZ1at4k8zHFSFRqtEYiOff07qNwAYkOgOCH7vBaHM2FywT6uWlqebHHJj
 0RAmLMisQrZFovJZuaoVr1MYMYY06+6nvY0IfW9J5ksBqhlkvuZ72YOl6WUWq2GrePhu
 QAE0p9mRPhU54nrI6lWrogJE106PQV5J/uOAS2gMalD3Z0InJES0zefp4N8K6yEOkP3G
 6P3A==
X-Gm-Message-State: APuU4Z98bZDvBwLzvk0MFDYhuJVzpb4qb6J3LHlVAmXHpWvsCtqOo6JL
 8lEV9pmfrnWjRkSDsUxUDc9dZ6qDPIcAjkcnHgU+JfTlf4KF/DDWUiPyn/pHxjB7P3c=
X-Gm-Gg: AYBFou3XqjtmgCV4zRHo+zzxJrOQS5VI6n0IrPuO308kOnVZZ3fyb2FtKoxYC8glaa2
 fR+e6adjeg0aRom92FVSPfWzjgbb3hMkm5ZE2aOYheYkurLjlwnbxOWE3B9JqsO3CvR4X6sXaPX
 qFFOWxPxu+QbUSwk3FrQsD0YbwcFCKz/UH0P7yC+JPx/7iKeboqIjC2JMi7LzxpqhkBm0ZAivUO
 iJ3shCnHa7Nijw44PwW520bu6z7KyZDwr1YFbvGSw9ulXjFjwnD2UEOErAFbanXxfspNG5vHNsY
 K8QdszdakDIv+OMZvIHl+DJ01GXHamuwImuY461ZACG/g6OFq+ImFPkBxGpstuW0j14GLfZXbBK
 WGvptEw75ii7duQ/dW79/REcnKKN9lWCKRHeF6CXwhU7TF1bGBRv21B/vYKAMGYb/IaPXz+Nzar
 TIiZ0KGpRVwIAl4WkpHlNBPEYqxrXOpk+f6kse7thxwk5IZ1ancOzESElUK/nkXnoqxYscqpvcc
 C2E+ri/It4Gog2AeUQqLeMJN3CLJ+DfibY4oSDLysBqz/Gb1rrSwpUxojMfn/CFbjje515GeIaZ
 NjRKr5RHV3y77+oT41v7trWme2GR7gUgVn+v9ziWZGFy
X-Received: by 2002:a17:90b:5111:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3ae89772eaemr7214970a91.34.1793611056848; 
 Mon, 02 Nov 2026 01:17:36 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.173])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845429e6sm13512199a91.6.2026.11.02.01.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:17:36 -0800 (PST)
Date: Mon, 2 Nov 2026 17:17:33 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] board: microchip: mpfs_generic: Allow serial number read
 failures
Message-ID: <auhVLZphzST6Kaq0@lliang-1876.localdomain>
References: <20261005004902.3441895-1-bin.meng@processmission.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005004902.3441895-1-bin.meng@processmission.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 05, 2026 at 08:49:01AM +0800, Bin Meng wrote:
> The device serial number is only needed to derive the Ethernet MAC
> addresses. Failing to read it should not halt boot.
> 
> Warn on failure and skip the MAC updates while still processing device
> tree overlays. Track whether the MAC address was derived successfully
> so ft_board_setup() also preserves existing addresses on failure.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>  board/microchip/mpfs_generic/mpfs_generic.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
