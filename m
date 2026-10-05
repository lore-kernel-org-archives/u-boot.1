Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE927CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 08:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABC4640665;
	Mon,  5 Oct 2026 08:01:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xvF75I_fdlh8; Mon,  5 Oct 2026 08:01:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B1C1240687
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791187314;
	b=W9cg326hPReU3P6qcZ2nt7Ulwkuvh8PRqrbRoZFLZ5OMZ/JvWNb8slcasOzCLwkQNheU
	 ka/eNMhL/6e0o5mOjn0mTGXfTqUQIodh1sp7/SkR6PbtDrLKesia26QvzYaB/bx4h1c7L
	 52nOrkYwAFicYzztij/YDX510x5dLO4evpOBOq0xzJRhHuJrlgrd1/QpmqHbVTq2Squ1p
	 Zcy5mq5/MlAlZQmd/AYzKZwpfaunLrf72pBy+G4Up63C9MFH+6X9iuIK57Vybd+J31PjP
	 ZrrgZj8vlYSDkW86M/BDC1ea+9yaaDYRle0++p6HqoLVkpLPmnTPJZFz1WkCa1v/NiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791187314;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hoAR4URBdn4HdP25L+foMatEeHcpJgwH4+wRtZWaILE=;
	b=rXrkdHHjArW3gIyyp+dh/XkrscHCyWeX/vVms/jXbqWs1xsuqoVSuHF3feQ9Aq2VIuKf
	 buYzpAHb2mazoBBjKjXFonuRkp3S4XikUH60l7A2dC+zhrRHnOvImY6qSbueAQZUoyGUA
	 f1ChwehC+bysa3A9XJkKqHkpYrhqX1mg0dBwFtTUZtX7tuK9GChYwIzll5SqlYixHt0qn
	 M02dLmA3ZrAfipBy1aZ9Mk2T6aHkbryIFz4gE/Xpoxh2bV+C12uam5XayjxJk3XwmmK61
	 sEe8sUdNzgDcD5Ga8nML/FIWydwQ3fcbWz4f3LbQK5sX2KZqJzcUdQx+9qulNWV7pBg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=dP2edr0z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791187314;
	bh=hoAR4URBdn4HdP25L+foMatEeHcpJgwH4+wRtZWaILE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u4oxWDwCvDneMUffVI4bvbkX5r+PywhoAJ2OqVqsr31iSbIHBH6vy34Zk6IjJdaPD
	 drogOxL3oNgJwope3YoR1J9sxdqKtduGZJd91O3qaQlJ4OgynR3kPEYdSJ2Snxq1mV
	 B5AO4ClJcFbp1p5JrTzF8/mX5i5gveT/u28U2dUOhC8Ea4b3tCT9Z1ET19lJS3GMCu
	 0qvX+CH/O3lIJ5it7ZXXIvxZvoMTfafYyW45YgrYeTE4vFrsue/73aFzpBHdcbAjlT
	 nI+pW7CPoA5a+z6qMNdp+d3yMh2dGk3+uV086Hg1yvhY7F3O25EL3xmPQSi3UtaAQQ
	 vPOsW+kmCUMow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1C1240687;
	Mon,  5 Oct 2026 08:01:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CDDF34D
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EFCA4060C
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oacjvNKc2c8O for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:58:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7C1894060A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791187105;
 b=DH0ZqMFc2U1PebRmVU6gnKO07kQ8ffD+MD6Pvc6HKc0ob+FRRoYLGQ51CIukav2bV+N9
 vCZukA95P1UR7Vvzu+W3xUnpSitRi/jOQWLZ5U4sViLvnfGZYlMxqvzKXoBSmGsCnVhtw
 3Zne4SFn7hE4cEhuj7gdHbrMDl+nfr4DUvtWcIHMBS4nmK+98kZLsuVM5npjwKvx2rvJ3
 t82Yj3S89xPLxaxkXZH73djaeJcHUHQWJ26J3rgBg1ijSsq3CT3hbUW6s69Ytfsj6Le5c
 58XX34QNOP0IYOPhXhzr3aNJqcmh/+0dfB+/tzhruJrd/3SkDzWd7E/UMr7GBBEWO4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791187105;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=hoAR4URBdn4HdP25L+foMatEeHcpJgwH4+wRtZWaILE=;
 b=o2FBlvEv+PcfCDFk2fGNvOjJVJbiemz26LtGgM0tLoFmadpmt6Nx879/3rO2NJ3x79vW
 EBy8jsFurLSi+q3O27kLZ4qo72PB/UT6O4cOwDWV/veKiiIoxnMkAJz5qN0H9lWRi97aK
 10XJ4TSVwrGyZUDrKuoDgSH4JMN2DH4SJfJCfzUyR3JWF+hKjh0BIFg/4HKCAzS5lci9r
 Ga1WDWn1ylwicIJ8cgyJl0jlhaSAV/eDK+slmxGyyHHxpZLxBkRfZJTwXKyQCJ4ki1qts
 1ySVPGOuJRsqj03ajYsxxf7JgXR1d5VZ0FZcpT9B3lrvyoVxxsILUMTnoQvNeUmHnGQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=dP2edr0z; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=dP2edr0z
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C1894060A
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:25 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hysFn5dB0zKmYj;
 Mon, 05 Oct 2026 09:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791187101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hoAR4URBdn4HdP25L+foMatEeHcpJgwH4+wRtZWaILE=;
 b=dP2edr0zyWKkQ6Kh5oBgsHDsi99YdmYXSIJgJiUauRVAqMct2/YOVcYbqnGxI/lYotzGbm
 bcNzN7k3Zlwlasf4elhm9MK0HPpKfIn2a5AIKIFooS+H/09Sa7ad3LwBKrhnRfwVZ/3GMO
 xRQD/W9U6Ck+eZGWWFMczaSMB7kZcxJx9msrf5Ylx3K7VcGnXV6bqyG4vJqQkjzCLVJIj7
 KvD2F3Hb23TP6yKUdzVeuET/oVMGkV52JN0DkFMHWUmFlmQGSpi8lglz16CrGOQYadweMo
 477jqmXZvyunU3QHXg031lJO9cwiR5c6+t1QDxSm66bdykJ84qBJkcMmBj1sWw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Igor Velkov <iav@iav.lv>
Cc: u-boot@lists.u-boot-project.org, Dennis Gilmore <dgilmore@redhat.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm: mvebu: helios4_defconfig: enable device tree overlays
Date: Mon,  5 Oct 2026 09:58:10 +0200
Message-ID: <20261005075813.601288-6-stefan.roese@mailbox.org>
In-Reply-To: <20261002-helios4-overlays-v1-1-2e03eb306e38@iav.lv>
References: <20261002-helios4-overlays-v1-1-2e03eb306e38@iav.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: deesroqtwf8chsrz4botc3hwzrtcwwjo
X-MBO-RS-ID: cf8d34d5f97f166baf5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 02.10.26 21:49, Igor Velkov wrote:
> Enable OF_LIBFDT_OVERLAY so that "fdt apply" is available and boot
> scripts can apply device tree overlays on Helios4.
>
> Signed-off-by: Igor Velkov <iav@iav.lv>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
