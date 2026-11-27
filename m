Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55014606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GeWqgs+p;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=YyAxGNCQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B77EB40AE6;
	Fri, 27 Nov 2026 21:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qdSQ0SXmntwJ; Fri, 27 Nov 2026 21:52:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E572C40AD7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795816330;
	b=jAAMj0H5QeAe3RI9/gPraFfVId+QKWgSNpu46awyOrov20atE5WvCqS9kZpeM+rVZdjq
	 xesvhT8i6RrW1+xpI35YIQ8slT1KA1adfdfB+PoJYceClAWNabZ+9IZeacvKSe9R9o3C5
	 zq53VU8C2LNF4PYDnISGytovVuRJog4uu52EvVKxvSQnnXzntgtoOsePZ1jrNmQ7iRDWF
	 zUqwRUIovP6jmaZoC/lWrEgAPsJvmtitdFa3t5E0UrxMf6iT7fVrkKNKpkcbWbQRprQfJ
	 0rJyvBK++Pzcjv5J2iQoQhPgUPMYyPuESoBKXJHc6lUPBF9EM0XCsL/o2UaQuSSX5nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795816330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y4kq9g6BAMgPa8zS0MbbF/ahn+tVz5OI7a45LcAtMQA=;
	b=pV/Qb5OvRgV4uxGhI3DvnhPZnst0qMKlXbCoz3o/Cfpllkg42MFtduukC2jycqPo75Pc
	 p+iXw8Fk2ssJ2tYs724XDh78iSJphGZtHG29XNLQP584efa0/zpK0n0H0g5s/FxE4C41i
	 7RIVPcFpy7/NmMGAunOp6EMwm3+VZBtpBLPxy0QzSxlrerNrBDXH6V7GFumYD2dPiqJV+
	 q++BlRqLVpy4lN2kwAmOSrmNy5ILtU+XIZkbE249Tx/49bI5tbkMB28ElSYZXuoVmSb6x
	 OiriKB2towSV33UdCPkPYOExNIDx17YR24h5iTIqngT98VNVeNAO2sUxQ+wpcTUFu3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795816330;
	bh=y4kq9g6BAMgPa8zS0MbbF/ahn+tVz5OI7a45LcAtMQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GeWqgs+pxcas1y8XQdR/Zn22ARMGtjYHIlmzMibZYxfW9vilUFKOpExklCUy1Yjda
	 8BiqC6dc2i+R5m+PPslUWezSZYc0ykyhhvye4DA2xo0UkANr2GuGEEkxgRbg/G+Puo
	 6KcK9UsapP4rCCEHz0Cx+qGeycOYwGrTNfAl11s0163Bj/GcuO8q7ywunL82CKlF5q
	 LYSjHLxWf9dC4k33VJc7+ZlFJoGk/AEx5SIMK+kLCsdVy+5MzSD9rm5nUjc21W9QCg
	 LRbMBZiM6X5LZh5tEE3nGbIPZNFw6N/tYb6Xz/2+74b5Z+qJJ2E9/MrmJO52CcojI7
	 1uuf0j81Rdd0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E572C40AD7;
	Fri, 27 Nov 2026 21:52:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F2CE49D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 21:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9207607BC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 21:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YnZxqvIdoiYZ for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 21:52:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E51A60716
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.4;
 helo=smtp4-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=YyAxGNCQ
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E51A60716
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 21:52:05 +0000 (UTC)
Received: from L30177.local (unknown
 [IPv6:2a02:8440:2604:bcb1:9487:132:7b93:c36c])
 (Authenticated sender: vjardin@free.fr)
 by smtp4-g21.free.fr (Postfix) with ESMTPSA id 9FDFA19F5C2;
 Fri, 27 Nov 2026 22:51:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1795816324;
 bh=5iDcAIHC5UTqj1LH6H8CCaqGlQii1S4vtt8eOtJz9B8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YyAxGNCQRrDEc5qMKxhsymAXC+tzTSpkrZwZmF7Vm6cBG4mIflfdYBv08i5E04FNQ
 wX1TLvA98zCrUqYw/tLJtZfHV8JW88rwdXquJnV/c8h/KKe2IaVsvzDeiwpCzElB6c
 ZSmYTXsl/Alxd033xg5VP8uYzViGtYrtA02XDXa+aZEVSYBC6SvEHgKZzjw65B7u99
 lQTKO59s+KfX8OKWgxw/iLlOJ9B4Y2sVwZiVY3qK7EbxwOqXJmsMhR+EH1zFXwy8FY
 vXWBI06fH1oK/68ZnKpoqGXdOQcb+fhfAwNR0JDMdsbIUBAqhPw4UtRWObvN6RSRwS
 A5a63aig2yK4w==
Date: Fri, 27 Nov 2026 22:51:57 +0100
From: Vincent Jardin <vjardin@free.fr>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "jerome.forissier@arm.com" <jerome.forissier@arm.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "maxime@leroys.fr" <maxime@leroys.fr>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>
Subject: Re: [PATCH] net: ldpaa_eth: track the open state in the driver
Message-ID: <awn7fYjK_R3biZ9P@L30177.local>
References: <20261127081721.788638-1-vjardin@free.fr>
 <6642ed077e3af23939ae1f15a06368b3e7ef8ce9.camel@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6642ed077e3af23939ae1f15a06368b3e7ef8ce9.camel@siemens.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexander,

> I'd say, the Fixes: tag could be 267c5146d3f
> ("drivers: net: ldpaa: add DTS based probing support"),
> while 44340456475d exposed additional to non-netconsole TFTP error path. 
> 
> Other than that and a nit below,
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

thanks, I did apply your comments into a v2 and kept your reviewed-by:
  https://lore.kernel.org/all/20261127214450.865924-1-vjardin@free.fr/

Best regards,
  Vincent
