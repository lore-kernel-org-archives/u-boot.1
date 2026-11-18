Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5E9606A884
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y+zvETg9;
	dkim=pass (1024-bit key, unprotected) header.d=netbsd.org header.i=@netbsd.org header.a=rsa-sha256 header.s=20240131 header.b=CPbC4GPA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8203F80D0F;
	Wed, 18 Nov 2026 08:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 56uye8fYIX30; Wed, 18 Nov 2026 08:38:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B33F580D6E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794991107;
	b=BiRLXGOdLYckQPxoYjxQQ4fA/iU0YZgZwriwh8gdTN6GOFdo00p17xvRt3snoDDjTaom
	 jtgjw9YJdSAKdFfBRfp+SBcG1jLceZVWRQC7PnczcFB9zAsvUQRb2b9ltlqbYVUUjIITs
	 QnULE7+o2FaS62hJJx0U4reiu2yuF0VC93DpjWOqj0K+9IImkppCHurTeuhXo0jfrzkVX
	 X/vaA27dX5eUong60hxBsaIcaujbTG7JrFAr1wslnXSMtwuH6tolrF++MTfakvajf0sqF
	 RfQWWCq//a5p9X9Ovf64k1skId5ZEVUTU6Rvgj6d+sl9Pi26vMpUNeUd5x6JzXMAPnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794991107;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oM9JTnvayx9w9R+E7PW2VCzfpIPJUrCTjVuv2gTG29E=;
	b=HTuj7dbyU51RFOy/OJjq/7hRn2ONoeWYsCrolGjDHRBiAiFAKT5SseB7npPNlrlQyry9
	 gMAueQs0aU7IMmubauEb9XntR9SKpeUbPXlHmij/LnwObGVEzkrB00A6R2Myq4mC03UJt
	 DIPf1WHb9Yg2/eNba+TIUlISs6fVFM5vtB8Jh4OGGgAszMeWKKq8JLz3SZ+Z125yFINQF
	 bwowOunkUSgvV0pK1wtWVMfudlhCRXM+BMWgoJq4e+5TdRzo6aTLlX/hJ5IMgxXnCTiC5
	 qr0GQvJcEGrWxDa1qwPHXFkAI6lO+tMmZJF5W5yNoUOHky+lsjDK6UX4a3g/CvwimdA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=NetBSD.org;
	dkim=pass header.d=netbsd.org header.i=@netbsd.org header.a=rsa-sha256 header.s=20240131 header.b=CPbC4GPA;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794991107;
	bh=oM9JTnvayx9w9R+E7PW2VCzfpIPJUrCTjVuv2gTG29E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y+zvETg9xjIcxrS7CjWCgi9DEbHm6jNqHfZ9M/vNzkUizlIfBlrl0OI/iau8qJGSm
	 Xa6sHV2WIgO5q8WCmSn8FQojqBUZH57JbxeBRLBaqSPhvgw10WcwMjRQonxWWzq1Xn
	 UET8kETtaJbMUR6v+wVIErej98kFjQdqfdxAyVWkXbiGcQF86Ac3OWZ6FNsJSsQWAg
	 DRkhluN4XASxgWCibbeFJKiA40e2jH4FE98NZI8lKYVCcgl6qgz9ouv1ACNsh5ISLH
	 CrghtbmZKZ8uW037M9OTF94qhtarBaAM2yI1A334iwVo5NY0ppc1AjEi3/CJggbZZw
	 pjVRrxKfR/46w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B33F580D6E;
	Wed, 18 Nov 2026 08:38:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ED15349B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DDF3780DA9
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:38:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8WPnquJ6vWE4 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 08:38:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D898380D0F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:470:a085:999::25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:470:a085:999::25; helo=mail.netbsd.org;
 envelope-from=martin@netbsd.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=NetBSD.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=netbsd.org header.i=@netbsd.org header.a=rsa-sha256
 header.s=20240131 header.b=CPbC4GPA
Received: from mail.netbsd.org (mail.NetBSD.org [IPv6:2001:470:a085:999::25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D898380D0F
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:38:23 +0000 (UTC)
Received: by mail.netbsd.org (Postfix, from userid 1214)
 id 3BE5284DE5; Wed, 18 Nov 2026 08:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netbsd.org;
 s=20240131; t=1794991102;
 bh=oM9JTnvayx9w9R+E7PW2VCzfpIPJUrCTjVuv2gTG29E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CPbC4GPA0rhxTejrRtZ7XKJNbrcMBlLen4emJcIql4MlENYFKez7SmiGnGvZzliSw
 p2UqhIuBq43ZGeSTJWMDes/ZOts1OPNWHrAv94VmaKKQg1YwpfLGZLvcgEtiemaQPS
 SGSbwa/T1YiS9PuuuFeesgdxHatZaRDhTU1qnVZM=
Date: Wed, 18 Nov 2026 09:38:15 +0100
From: Martin Husemann <martin@NetBSD.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: StarFive VisionFive 2: NVME not responding randomly
Message-ID: <av1j9wAgQcRp_y5o@big-apple.aprisoft.de>
References: <avxWs2PzYcvPidNw@big-apple.aprisoft.de>
 <5e9eeca5-6772-4aae-b2a7-d49b1676f6d5@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e9eeca5-6772-4aae-b2a7-d49b1676f6d5@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 11:55:36PM -0800, E Shattow wrote:
> My understanding of PCIe on JH-7110 SoC is there's a hardware design
> flaw and the "fix" is a delay-and-wait that was rejected by Linux
> upstream. This presents more readily with *some* NVMe drives. It was a
> hot topic for discussion and based on that I selected Samsung 970
> EVOPlus 500GB and 250GB models and I've never had an issue appear with
> the 250GB on which I do all my RISC-V development as with a Home
> Assistant Yellow baseboard hosting the Milk-V Mars CM Lite (JH-7110 SoC)
> system-on-module.
> 
> Is this the issue you're experiencing? What exact make/model is that
> NVMe module?

That sounds like it. I can try another NVME for testing.

This one is:

vendor 144d product a80a (rev. 0x00)
Samsung SSD 980 PRO 500GB, firmware 5B2QGXA7, serial S5GYNX0T302900W
NVMe 1.3

Martin
