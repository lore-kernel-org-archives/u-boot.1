Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B42CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0E2E80C06;
	Mon, 12 Oct 2026 22:31:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xCF6CJ5VhoQR; Mon, 12 Oct 2026 22:31:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0F41880BED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844313;
	b=opTrPOkELiHj4Q3c+ay9OqoTqwN7bYhRRQlF0JBFx6judo+jS0n9RgvWjAgXMlaDd1Jd
	 80c5B5wuy3kpC20plw/CyRTH7+3YWTQxwby2Nc0tEpZRvjd8+wXS8CYKXM2wXnf41LkjF
	 dBiCzJJuVlrDIRiEOAbIbZFQ/8RcPu3gREVWHKkf/ehENxBwUIhQL4JmJ+jReb+wtcGKO
	 7zd0+hkcaJywdsauZng9PuHneoTxzFBzLFG2fVeaSYuDUcEqT2P4/o+Wq0m/rNNpM1OU4
	 77WtW1SSWkog13Cqg+WxAYF0RPUfkrdV8eOOs+jlkS0oZbPLtsCvehSxvGnkAGyVWRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=402rDNrxL5De9/uJD7NLJvhKJtSHNB653jVvPuVTn0M=;
	b=RkqmOVPjY/jbYL1zjjMgqtBH/8JcM8AYEHgEikiEQOE0qY7b+QBzStHdf+6fj+KEKWW5
	 9bHazxWH/StgE7ppLgUInvy3FLfQYOLyzA+wS74nMZ3DPBu01OrxkPIUqCA+/MuqCHOFT
	 Gsvpa5Xor1zcyLjroR3p6uyv/UQ/e5Z4k5d8FRbb5pQs8dMPWpZjRsJ8F/BDMW1CeKtOH
	 0GeosqsQxa0YkyMjkjozRIlbiQG3KwSd6OAeaS5YL8RAT/DmDIdD56ZoEH6+FHp0cMdBo
	 Y1gvYnCFh0B28HQwgeh9xhl29HvK7sTPZcZAO5rVDpT+JXCQt3K7ZvV8tIN7OZ6pRtw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844313;
	bh=402rDNrxL5De9/uJD7NLJvhKJtSHNB653jVvPuVTn0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=drgpW8FXMB5yBBAFVUJ2YGSl5cnQikemLwCDJlajDJHeTBIc/BjcKQ1kdiqRV06IO
	 d3Xma7qOIlpsIhLbIduXlPHAkb6HGuVAZMh5LbH3coZBFaqqGFdD4Vey2YK8Rb8hzf
	 FDSlb5EIqv0Aia5xL7x3TBrRw23Yxp8zIzXB5W1mUCdUTAJ8PyiXW9PkQaGUA5PXDG
	 pxuWzxuiufOcYIPZO01AvHdhaT/76J6HhJCQ75Wn0FCgiBmkPgGjTqDsvAYluuWR4S
	 +Wbwnl7L1M4ZlmRskhmCZvORGFQRY+5TJXFIsLchRENSJ5DSGMoMyKEQrakjaxtq8g
	 mPSwCddQ0kDwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F41880BED;
	Mon, 12 Oct 2026 22:31:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A25CD105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9468840568
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:31:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9pOI8ClzFZJc for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:31:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E1D6A40528
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844311;
 b=UHLXbJ0chpNnz+/Z7SfkdPrjQdgmuIdRSlk6dbsYYCklf4GwL+5bQgcBL2R8CsDgfRGb
 gt72clASAMnyanV6yi31UIwA9eOj9AEXT6n9JtjPap9XUYKWekER4/CLOjdwv6KnlxeIZ
 LqDHmWfx2EkExRHtS6s72GgBTv8IQwY9sdgwwR/smorerqQG2Kvkr1/HTvjLQ6ZxHgSFr
 aSC8VSrgoEZVdhHKTUW9vBYR9hrnwfMDNB1fQ15nZUnyBdOrBeNsCXvr5fPzZYDWMz8gh
 GVr3fhpoIV8AaN+50RhDvSpxU44WtUObzzRc6MWxJOVsPtgWJbWB/mhymwRxC0bEAjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844311;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=402rDNrxL5De9/uJD7NLJvhKJtSHNB653jVvPuVTn0M=;
 b=fI/0DECIxAQuj14oWYMUdxMYBOgYF9wrtsWuskJso6ZdGs08NjLB312aIVU2W7MA/Dg1
 Vx++CthjFLunIBaiSNM/QJrRmyiM6Myo+JhA0LNArWLT4g51mo+tVARPpzkJhsxPm5/zm
 N1U377RSsAydVqSQeGM4WKO/U8hnwB4Qv7B384KnVXD/Drv3tbFeBMabM7QjLv4UbUPcB
 p0KiZrCTa+Y7aQIcrKJo7gp+8A5Aktn7532qsuOSHWfGbALgM6P5c11qIHBG+urrTdCV3
 0lwizZh5quY/+MXlwsqXrweByK85ysK4YIXc5HF1v4OM5G+LB+fUiDCM+H+7pCyVlrg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="QVjWn/dq"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QVjWn/dq
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1D6A40528
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:31:50 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6d7e06dbcccso1432773eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791844307; x=1792449107;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=402rDNrxL5De9/uJD7NLJvhKJtSHNB653jVvPuVTn0M=;
 b=QVjWn/dqJeBqmKKSSZQ58dxl4gbMQBK9e2+NJObSBj8PmQ5K91ZwlEDecjXK6QtP/C
 WuXJ8Rj57+30g04lljIydcn/xh2PNuBv+J89jnEykRYdPkerRSeCFTEShzuIV/Bf9eUY
 0uGK67VVrxR0ZZ0NbJiEMX9qDWZDI4A9pzBjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844307; x=1792449107;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=402rDNrxL5De9/uJD7NLJvhKJtSHNB653jVvPuVTn0M=;
 b=2IaH3lSS6trF30cOiSeHPHTcRTOXZo4Ii9X/GrXNddNKFhuBjgtG4TrinJVES22VlO
 mSzPOJuCckdigGxxDJ5hqRx1nQONWT2aqIA9wTBm71dMhj/XDHK766DFP9lV24m2d2y1
 C3KtkVCh7ur1/vF022viKjaIEuKnRzGhZLZscOhgNm6Tuuv9Nlsa6Jfq5hfkiaI0Z4O3
 56bri3dA7dkkEkHmPFaF8XqMBJaagbYhVzpQMNqAUlYrOJEhOPb2Y3BELNEsFDNUDtHd
 7JEYurY2EoEtoamRIcspeuHvjK4awUJZIui8mIVFgYQIMSPI97RMTeosQsDfrmpWD9eG
 9Ehw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtt9k3fCsZuykVCApPS0g+iAnrKSHunPG34VnGufFsYGHbPI70A3AXR12qdQQbaLKqkLbNnew=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNXNddVFJi96o2b1AN5gllNGY7oIr29+0wZFwOnh8yMFP38Uuw
 GymEWG0OGmpe4IyiW8O1GeQOX8JmfWVXrJG6g76D1OFzJMKAu989s2+2UD7HAH3nB7g=
X-Gm-Gg: AYBFou1mZ9vZ7Y/95JKW4e+flrlv1+uCKq8DNcpPu0Bm0+sbk4wVmX49i936+UuInwu
 S80Rc1HgstudCOO/VvV3rs1VS+lW/idOQX8g5q0MY2fbCu/j+H4XQQKy9pzSfHOfaIsb4yyx9az
 dOLeN9Fi6kK04XCOp8oTnm/Ve4weMWYpdsaMgydljPtGdfQazY17fmgALWqKB0OtXjA9a/Xjc3y
 1StWNrzC1Gv83L/QluhmKVWM8+LBRsfXDK17zgvUUhdBnzEf56N5T3hR8jGq86mYBuCU8NBTvoF
 6rkhw3ZujEX7Y9lV+SHvTQpXPZcWloFud6ZWXWF8YH1JkYgNVtLzxEzDgb3vtm5PrY+BkGmVldy
 3+Ym8Xj6wroUwTg/ktmXlle7VIrG0y1EJsiY/nGwFLrILJQyRNWPdN2xPHP0WHWSOZnHgyjy026
 tV0uha5t82iW7wB3yrMSLqg//tBxkmSIq1PgA4vDa+Wsf8FEs7F1eZA+kh2EK/sREgJqqQSYm4/
 s/iFK7/9LpsPGNPnTFp7C5aOboC5lGf/JWt52RH2RAglydIxQ6zQ+2xpZX5gM9QYNAmkZIqlOQO
 jcmoSCc8H87ysl8to/o=
X-Received: by 2002:a05:6820:6ae3:b0:6cd:3fdc:6006 with SMTP id
 006d021491bc7-6ef11a30b8fmr7693980eaf.87.1791844307541; 
 Mon, 12 Oct 2026 15:31:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6f6ed64de8asm3153599eaf.5.2026.10.12.15.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:31:46 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:31:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>,
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com,
 Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 1/9] fs: move struct fstype_info definition to top of file
Message-ID: <20261012223144.GL3722450@bill-the-cat>
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
 <20261012140048.214059-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TyB4zb+Ol+rPGVkJ"
Content-Disposition: inline
In-Reply-To: <20261012140048.214059-2-heinrich.schuchardt@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--TyB4zb+Ol+rPGVkJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 04:00:40PM +0200, Heinrich Schuchardt wrote:

> Structure definitions should precede code using them.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/fs.c | 86 ++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)

Should we just shift fs_ls_generic down in the file, since it's not a
"dummy" function like the rest but rather a reasonable default?
Otherwise we should at least explain that we're doing this for later
changes.

--=20
Tom

--TyB4zb+Ol+rPGVkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas1fzAAKCRAr4qD1Cr/k
CkuwAQC1oqmwnAVrIym2uraYzw5sI7t3JCxBg5jY/SlBB03qvAEAxoLYfrdZB+NY
F70RddOKg+0J/N9qvsLanBT1VjMBkQ8=
=9xIq
-----END PGP SIGNATURE-----

--TyB4zb+Ol+rPGVkJ--
