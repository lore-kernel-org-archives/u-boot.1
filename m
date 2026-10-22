Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA019606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gikTgD6+;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=PPZpfAdM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B719C813D5;
	Thu, 22 Oct 2026 12:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YPYmWj-MahLT; Thu, 22 Oct 2026 12:55:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A2F0281387
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792673742;
	b=eYpHmha9Q6Ne91SYo1Ck1yRvz3X/Xezr9jLujc0I8Yks6oTl2EI93qR+CBPwE6TmVqO6
	 GFsaUPQ1vtI8uK/bPYEvQ7F16WZoOXJgfnhVie3V/Cr+sjq/PFaDTmK4rJa8gLMiTcD+3
	 32aya4118+olE1EaE0PaTlsuBp36WHJIJF3+kYk2EunJOl/EwSYljZ5m3MZ2LyC5JwWdZ
	 VUK1JqX6jgnfcB5GVN0gunb7t3k58uR2LRyFuUw1m4WJcTc8BuRo2HpOwuNLm3KV+w0to
	 6JaktP/3bDYIuEPXtS7TYyqcajkw899A6K4ew7a2P7qpYv6r/XoJIn9QDMCQJjdfh2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792673742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Gki+jQCmOFdC8cQDeCaXnBGRskDIXC/lLvNYbGJx6xM=;
	b=Kv4EIlG/pFwvJKvOf71AYMulpkskOsHUdOsBV+YN14gaio7OSwgG588+j/g2eMHUpxrn
	 GvHs+YFmy1XjPMwje+ZSp1eRBaa4fOoFfew/z2UOV8wiWHNkfqUvWSEq38goEUFCMpU4M
	 sVmkGCgCgInVb6wEUXPvPImSud+XYeENyY676rcgpR2ZMwBN9o0sU9qxR44dYD7M3fjJu
	 O6qc8LvxCGP1kjvfwDH9VM9MBFrZM206Fxv3GAsxTLbToCYAQCqc8Sk5V1Xjz27IlzrOR
	 vjEQqmSstzOf2FmjP45PVxk/nNSRtyPivmMNthVynnNTDiUCv7CbJPgipfk0amAsQ5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792673742;
	bh=Gki+jQCmOFdC8cQDeCaXnBGRskDIXC/lLvNYbGJx6xM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gikTgD6+xOKxeLip74SeGhrr/hvfCQLIWVgk7MBZjhQuR6hXVzmXVdrNyF8HgXIBk
	 vhGW2MGTh/4aHu9Fa0cVyA1ATV5Nuc17dBBAUBx2E/FqnGKZBQ69h/3renONl8y1RR
	 alOEUVAkzltXCroeV+G+UbdGlJUwAVz9YI3hx0i1A5HhlmiUrinySmohZT+hvY0GTA
	 nOlipra5JGYhjyGLxgxxXDVfbDRUVDp+S5ktmRfwDdmZV40ntZoHHPFDpSlBcwa6pR
	 d0Jd1HN/BBei/HwDiuA/Xl1Yx4AJFP7Y5QiQ5zzifiHdTUPIEgeXWaTcMETbY+x8CN
	 OMPlhNTsMfL1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2F0281387;
	Thu, 22 Oct 2026 12:55:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B5A183A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7425409BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Bh9_UloWjxX for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:55:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 82B33409BA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792673741;
 b=cBOL8xqb0fToBhuxSD5s2Lf5E6RYJBF81BwCUtM/zLBT72vdF3XLVvdQGadZdbfsSq7N
 wDF4AOdFpNG6wXLzUgnOO5Vjm1P+7k53gaERvrfbLFbqhVQDBeT9B6e9dgVQBTzgWDOJZ
 HjBGqAiwc76La1nlRmzuTHDMqC6rmpOeetnAZ2dyMI5TwOFZlH4fViJsgpydxGYLnqBGS
 707Rl3uboIYvxCSwW5Yi62ZsJUbTmQj5389cKnaebpetznlsT8xqLGLxi94c2F1dexlwr
 Aswc+SapPrX1bGrWj6j9IyWnm6Ivt+pDFHvqxeZ06HVv4D1l8hxBDH/JkS6gBE0kSyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792673741;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=Gki+jQCmOFdC8cQDeCaXnBGRskDIXC/lLvNYbGJx6xM=;
 b=j6WTmk6kUGz9p27lvDDP/A8LB3cRe38ZCVWTnc5EHOWo3V88gt96aIpocWplL3/JobFT
 AzH1zyc7u/0QlGjTVybnAuS88W4AOSJxpVqKkHBxLh5md2PDleVZgcYyiBBk72pczHzys
 5nvUoLRslSt1V+RJp2VEC0ipGwgjfKLzxjLs7ekoDFnhQv84nJb89BVQzE1nSF6yeDUsw
 UF8lZ7+9lKC+TUkYix8It5pPel41OqLSKQNau0uIZ1kNtEJvb1cclyKWllQJJHnVzsP/R
 /EK2m1Vt4GL2fbSK3cqbIFIVzWalxOI7MbC9mVx2sUaoQhl126i/OhDTJEDyd0uQ+RA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=PPZpfAdM; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=PPZpfAdM
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82B33409BA
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:55:40 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j9R2w5LWXzKnrb;
 Thu, 22 Oct 2026 14:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792673736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gki+jQCmOFdC8cQDeCaXnBGRskDIXC/lLvNYbGJx6xM=;
 b=PPZpfAdMIUrRm9UykizUYgpFYRgi81pdqd1HhxIT0UGTvSpQLCe5leD1IwoN+QBm0qQZVG
 4/YEEbHMsubogVblijjusLoHezRLd9CLpKI5zEH3JBnXSseBdRtcAQTcmicn2AQqvReW/t
 zV5quNwmHnTbvIro40B4xBRY2NLl/X2gorHKrRYbMW/IXirdHlfxSeIWgPFENE2HoVGJZ1
 DeRdML6bDZCDHoEFnPIdUImg9CsbwnCm/T5CiPOo6C3xCsXI/m5STVqhxjc3ceU+9Cr7mj
 UzCkdmLdzcE13NJ+c6r7IcXFNvJAj8RyiN5V3gmQTGJL4rNTTIds0iHwlqKn/g==
Message-ID: <0a33d5b6-0001-432f-811b-c1134612595c@mailbox.org>
Date: Thu, 22 Oct 2026 10:38:12 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] usb: ehci-vf: use usb_get_dr_mode()
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261022070900.616265-1-mehmet.fide@gmail.com>
 <20261022070900.616265-7-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261022070900.616265-7-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: uorquoebwh7iqk3pq4mmgwa57i85bgwa
X-MBO-RS-ID: bf0da0de948928dd14f
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 9:08 AM, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> The driver parses the dr_mode property itself, through the flat tree,
> into an enum of its own that mirrors enum usb_dr_mode. Use
> usb_get_dr_mode() and USB_DR_MODE_* instead, as ehci-mx6 does. A
> missing property still means host, for legacy device trees.
> usb_get_dr_mode() does not tell it from a value it does not know, so
> such a value now means host as well instead of failing the probe.
> 
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
