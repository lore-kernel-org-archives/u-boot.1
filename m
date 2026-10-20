Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08343606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CDSa5Qw8;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=jDpXfPGt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA2AF6073F;
	Tue, 20 Oct 2026 22:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OguoRcoWbPrK; Tue, 20 Oct 2026 22:07:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C9FC46071D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792534030;
	b=UEiIOimmCgkHw0KhP8ejKzkg8u69yAgEZCV3kEtP28ZiSVbhnAGBFLeQRielw0GlSJ0E
	 EDV4rI08Zo8+IauRPZ1GavgPZEhTti4Wu3Isa5PL47su+oHek2iCdyW1wvPWoKnjt8ljl
	 7GNe94RWFNEaz6VeoHGWKPJ8GqRR+hPIlvQHndL8ii8kmjOqw6FMiMNIcy0cWs1GJOFKv
	 hcCqP/Nd/M/80QGAtkSzScp+lmefqizIPV/XwWrJyyvoSL7AJFhfycEaFd2EDffBNcwJu
	 m65x+VfjPLR1Wyj+ZcP78/cBECTo5rzvmwC8JlFxLvO3LELoI2aMK5z+ugN1fJSpRjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792534030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=W6xnqFlbMLrBVVib2eYPluvtlWaUpXfNMPDufEJdOJo=;
	b=CV1q+rrJGtaxw3RxITIk8tcoXv4QajQf3PFUMTK/hff1vXGUB8CvskiC2NHKszzJONwk
	 ZgYE9aumcU6DFkLA2J0bMezo0VRmKB/w/AJzI9ulE/1sipxTrduCZVAhrJcYBPLvPA+D1
	 E1NF+v9InS9T7FB22EW7mL/MBTwwgOPiMV+cHhD5jw3azxugp2qS+5W+XTuHNA0gQl2QE
	 3c0g9oYhKoawgP6BKBQF0ST9hxEzWpjvrpVtR97ExGlRhsnkapWE77h1A+dpxGxGV0sTn
	 l/euyG6lP59Sl+gWyZabylU4qiZCbXbZs3lOZhdqkJLpTx6u5GYEKhu/fk4+r+OYw7Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792534029;
	bh=W6xnqFlbMLrBVVib2eYPluvtlWaUpXfNMPDufEJdOJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CDSa5Qw84iPW6/IE4BbWicStjlgYf5ME13u+kNpxTJdd4Yp7ysxAZP+6eo6vXa3Gq
	 l+3iJly2sQreoHQxPciSUFz/82uvzz3tdrbaWGO3TPY6gkw60Q8oV/v6hrVK05D+a9
	 gJVyjuB4J+OVxVq23hRkxiBMwd1Bq0f816JaQEmYRpcvRVQHet+ysThThQaoBo7N+J
	 c/0t+DaSylyNqdgggeYiz4Y6xoaD3tNaT4GRfRmvK2NaahED6jcG8u69SrjMe9L0PS
	 XRrTx3qq9O4WDWCNmEf6+koYjU7ELAvMxp8EfnKXU9oAX2G16iva9463wRZEq2x0/l
	 AAFOyA61BZyhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9FC46071D;
	Tue, 20 Oct 2026 22:07:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CFBB5380
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 22:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1730400FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 22:07:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KXGRJz5ULQgx for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 22:07:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3DDF6400F3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::15"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792534026;
 b=nfgG3//WbgSLw8gpgpNcNHiq7GNOd8ZT4R70Ag/Ct/0qrR2SUpAC9XKlEQM3SFRMPp7T
 Ch85fpDBhSf+ePwsjn45CgeynmMOESLw2PEYBsGKiDfmgSu+pFj7ZPGBWwzWNaLjy5Wto
 zp6IqGhEHs8cI9Qp2nDIZgjVK+YYvVh9WAVYPde5+iJtCt6cOCG+PpzVhQl7vS/4KOTz0
 hqOfilWxgybeHAYjTBkTqzkWNkjOUy3VIfQoWPVlFFVMgnApxSwUkv0Bfp8QC17/rBfjE
 nd7uCYv6/YBLWbA/8q1L9itLPYhKgfAQAUVXYcb//yHfTTY6V/ntMYOUptZ5IPQVVQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792534026;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=W6xnqFlbMLrBVVib2eYPluvtlWaUpXfNMPDufEJdOJo=;
 b=NWtzxq21KDekz5s+YQYe6aCzECnVEf5Wqi3pAKn2pCDncObTc6AAuJI6v9AxHGfmyxEP
 ZYvlsbu+d6lXlzM9wwdERKKP1IYybo9gb9pp/YvaREOURx5rsCjg1RAmWn/N75Zlkyp9N
 HxeO48imYnoqSk9iNCWTEHJvwNa3T3PPGFxQJFQ5qDtVVsdrEObqX0+OlvWaiWya6o+DW
 oKrILR2edeu2JaMM1IHbrOzUnItBCSMyxF/PIicOpZYVHjiFxaW5R3Vdfb2SzOVSkmHPK
 teXaPU7D/GifvLE7WqP6MlKH8a65eJ7DJ9a6YroSD/x7OWMGHFQRjTLRI/rRZzAMYww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=jDpXfPGt; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::15"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::15;
 helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=jDpXfPGt
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3DDF6400F3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 22:07:05 +0000 (UTC)
Received: from L30177.local (unknown [192.214.194.60])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 0B9EF78117E;
 Wed, 21 Oct 2026 00:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1792534023;
 bh=Od8Nhn8bx5Eq0A/SLjTG4H8VOCNrViaaOZTQ/mL3lTE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jDpXfPGt/cDPzjFNES3mHbR9BM5x5fTGYGq36lb+EZm8McBiOd1iCpoEO9/qPQNXU
 j8nv1apE8/74N/tBLg2hGuto8y4aM+ODR74+B6CV35PsmAgZXFxlWDHxThDMdjLIat
 pg4Nw0G1OFZx+lBMlJdETP8TdomzMu1FBFFzy9GXlYL5eBSkwAX0y1PeR36Qt26O5x
 ZmdNB6y79e8hYL3VWPoTQHjbu7hXmKjGgk4rIX7xBFbXmlLis1LY5PwzWEwAsXEIh9
 FidrKhBof/oC3MqJTKudx8KoM3OACUzZC0GeoqX2jtAPPDP52P0F+jPCN8ZQJ3KekB
 TjFH90knlqkVw==
Date: Wed, 21 Oct 2026 00:06:56 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] mtd: spi-nor-ids: gd55lb02gf: add SPI_NOR_DUAL_READ
Message-ID: <atfmAN9lrS6e5NyV@L30177.local>
References: <20261002075854.1828080-1-vjardin@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002075854.1828080-1-vjardin@free.fr>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Can you pick this patch for v2027.01-rc1 ? It has Takahiro's Reviewed-by:
  https://patchwork.ozlabs.org/project/uboot/patch/20261002075854.1828080-1-vjardin@free.fr/

Patchwork still delegates it to Jagan, who left MAINTAINERS since the
commit a79edd52a80 ("MAINTAINERS: Remove a few inactive people").

You applied the former gd55lb02gf patch,
commit e800cc67f5b ("mtd: spi-nor: Add gd55lb02gf chips")
could you apply for this one too ?

Thank you,
  Vincent
