Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C7C606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d40E0WtT;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJDV/N84
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 539B9812EE;
	Thu, 22 Oct 2026 23:06:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HS70yT3Q4D1i; Thu, 22 Oct 2026 23:06:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 86DB48140A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792710391;
	b=kmT+zkicg4hit5GgqQPApisTDT1coir8YQwNi48QfnbJ9/P3FyB3hYvjxta7Fy9z1loe
	 jDC+XsYDDWfcB5LfrYpUAa1KNDTAiSs0dTVJZLdbY03GYrL9ZgqMAe2IDFhcY4AauDSt6
	 I0ELtmgAGpbxYCVCuNqdpTh3e6X8ktDjZtIDnXbE/7ouvrNNkJKD/y7FkVPwDicskOqnJ
	 Sq11WsDImf09N0cLZOtgZcrpF1cCGzmdNvBTgjkWqx2jBTsFjimLGmYRpkPBRNMH12V02
	 mceR3oAfJ/4D+SIeKOnz9HRKMFwyj2ZXlF3DZ5OCURxaljWzMKWvLXt+9w+ISn5mQpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792710391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZBZ1GzVUnErneE3NqoLloiIKrl/7lWPcOUEON2TXhhM=;
	b=i3O1xOZMofVDVGah6lhl1sxWGiGtzFHhshT1YhwciTvBZvRCl9G+eEXFmqEHTH8WDzkd
	 zunSsIWbNpubuHmOHeimu5ZDIRP44CwqkHkO9nzlPtVbhBtC9aibISep/0fG6UyhWUBSW
	 jFcyRPOoR5/zwZeE3g0pZ/XJcAybKuFQEmwIJotAeLSjX2zdt4WHjqFK4kMusjWSXEGjy
	 Sjimx/+ugGKGnZhOHpk09peywIObdk8JlgSwjHmwHZSYupeHptgEkRJORLW81yaJvilUF
	 wijkuytQX0vvAKKLVZ4GvFFLG1XgXf672rqQTFrW6aJjm8eSmvo8JSz71B7oiCrAdNg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792710391;
	bh=ZBZ1GzVUnErneE3NqoLloiIKrl/7lWPcOUEON2TXhhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d40E0WtTi69YoePrEzbGykt4w7LjIJcf/qIdJDVeAUHnUwVWC0iVnvqB1duG0fDtS
	 JpxfAHzG2QGvUleXW7bPTf8eJ64OzTdw6wDdm1NVo9Qhqr+OYZuN7y0lHcqUBsCi6f
	 a/S3bvmYfXECz3J1ugu2pTexUy9nDloxipb1CrXSkTjwzz9pxay7WdjSpmh+N/g/O1
	 igMcFQb53uutP6xALCQxIz2fhEKdx5GJj30oy2b3JJTyJEyb+4BlG2+nNWoJCW3eRf
	 +uFA5Q6Pbs6dHY1YlkNALoCAa8zIvh+nGtv27xZdOlBmSTHa1TB69Poz+/587NELe/
	 OyZpPssn5j/NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86DB48140A;
	Thu, 22 Oct 2026 23:06:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B44B0356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 99D52608C0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Or25GRkmJmm3 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:06:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C813D607E4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792710390;
 b=mlvzFZTAORFkTjASGwIFgGJyd4fXh1KNeC8jTfc/dsGvPFgkNEb59Cy6z8JZUv0Afvzd
 /Q5d741S31vgSxxPxXt14YspO9A7I6Ij2uUs9s/ulD/Lifor9wGSc67kv9Nh/vsdoa3D4
 0naptCCwxhrBm9u0C3IvNzjWksbaYKB7+Hb6BnlIU7GWEUJ5Ju2fdO7y6uwA8ckBS/W4H
 jfDS9XL77JfUFEX4sv/lgTt4j2LCUvR0L/ziwQ8jOtc++pVnLBqk8zGqMdnfB0qXGVyKv
 ydTaZ0upiSrnzIT7gx3YUEwSYE8qQV8x22SlSEZZuYvPtVL2Gio9RXEwLRQrW2MP4RA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792710390;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=ZBZ1GzVUnErneE3NqoLloiIKrl/7lWPcOUEON2TXhhM=;
 b=LHFj8etF//JClqahjCVbBx2yvu7oIlwgQpcTPLEksghoeIeaxgyVZRZ21mz72+DiYQU1
 u0J1fJe1UXdmX6s6fFq1CtQhmlSYzsXaA/KWEnqMHIupymF64Rg9LH3fjRe9uZo2onqH/
 nn8QnrpRRgo3DnXKyPuWsdAHZATOUkMGuTbjeRJoPnhSxjGd4fOhs98z0RzdujrD3guBs
 YTokHw7pbCOr8mlSR6eTmshHcthpzSjWHsBpHZKo/wzzDWg9jjBJcQZaUGTJpruHcICUB
 gWNu2W4sG/+9tCf6ofG3G07oKXI+X+6XrVLe62MiS3MLiVCtYUhI36SFRaTCrXekxww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="EJDV/N84"; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=EJDV/N84
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C813D607E4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:06:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 08B276022E;
 Thu, 22 Oct 2026 23:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432891F01825;
 Thu, 22 Oct 2026 23:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792710387;
 bh=ZBZ1GzVUnErneE3NqoLloiIKrl/7lWPcOUEON2TXhhM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EJDV/N84NoZxx9I5ShjRG7xePxDr4EVXYSgW22Z4/bT7/Bu4YMaSdqBrNhCiq4GTv
 XCHxJE3HffbeVSuZEclG+AwnCcYCjQRccdT1UJul7k/IOTZ4KIGMVF7B54lNd6tFUu
 qK+NdnnUVJNHdFR/iuS0UWrrR21DEPcKJ9yTuko4tgDp/WO9drhttUCMHfiLrnls8Y
 SsUOH53o/dwMzEQnfZHVBVWg/lOgA6ZE7grAxHfyK/adhphR8T0lcQHGneude7VQ29
 PRtWkzoZISNV5e0d/tR5g8t9DHyOpZcaNAjWlP88OKW1Nut7o5gNnVfDnFLvQ/glRp
 C2HrR06e0omoA==
Date: Thu, 22 Oct 2026 23:06:25 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: Dave Klotz <DaveWK225@protonmail.com>, u-boot@lists.u-boot-project.org,
 Huan Zhou <pericycle.cc@gmail.com>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Subject: Re: [PATCH 2/2] spacemit: k1: fall back to the other boot devices in
 SPL
Message-ID: <20261022230625-GKC125937@kernel.org>
References: <cover.1790975598.git.DaveWK225@protonmail.com>
 <f492bf72faccb8ea1b91b77e2a28a9ca2caeb40a.1790975598.git.DaveWK225@protonmail.com>
 <CAH22mJyBGC1pN93yuNX-utLOfw=vsq9METWngqwqJ52xaA4jag@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH22mJyBGC1pN93yuNX-utLOfw=vsq9METWngqwqJ52xaA4jag@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eric,

On 16:15 Mon 19 Oct     , Eric Chung wrote:
> On Sat, Oct 3, 2026 at 5:31 AM Dave Klotz <DaveWK225@protonmail.com> wrote:
> >
> > spl_boot_device() derives the boot device from BootROM state: the SD
> > API pointer the BootROM leaves in SRAM, the boot flag register, and the
> > boot strap. Not every BootROM path is covered by that. On the OrangePi
> > R2S, for example, the BootROM probes a card first ("try sd...") and only
> > then loads the FSBL from eMMC, and on the OrangePi RV2 it falls back
> > from the card to SPI NOR. If the detection names a device that holds no
> > image, the SPL stops with "failed to boot from all boot devices".
> >
> > Provide board_boot_order(): the detected device first, then the other
> > MMC controller and SPI NOR when this SPL can read them.
> >
> > Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> > ---
..
> 
> Reviewed-by: Eric Chung <eric.chung@riscstar.com>

This thread is broken, and Dave has sent out a new one..

Thanks for the review tag, I will added it manually when queue this patch.
no need to resend
https://lore.kernel.org/all/cover.1790976767.git.DaveWK225@protonmail.com/

-- 
Yixun Lan (dlan)
