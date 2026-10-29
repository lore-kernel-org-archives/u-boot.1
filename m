Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D1606A31F
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kJEEcY/H;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ckIIN3HJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9424680F7B;
	Thu, 29 Oct 2026 09:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4X1_ASYwUvTp; Thu, 29 Oct 2026 09:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5B3E80E34
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793266529;
	b=UmxaaqAX83AIDaST2IaGI9Erh2oNuMoEfbXkVrTOwOuMxvJUCP8qcde83LaxCT6sXjSw
	 HfB6sVWwhUc2yhTfXkMMn8qFiXZLKB+13u0RY95LFGVZAttKtYPrVcbFQ0+3DdP7y9iFM
	 tG97vQEv+dazaL9SzDLkvDph8S3UyTLOCxtlHVRm+zAdPqIMNVHR/vb9Bqo7QuvhS619F
	 qiolhVEDIfIt5eiiryRXzqC4+QYQdE80/pN9n4a1K/qRjj+O+4JQaOBXJjtiUe+VsHBwf
	 cXiXbZZl2FZMJElxhud+co0IFP9F0CQHKSJfeIj0PktxaB/ECHVNJ1aHhzIGfyG3HzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793266529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mA5Glu6H7XGCQAmQqic7Xq8PVYvtkMBgaiNQbVje5OU=;
	b=dtofCaK2UEL4/yyBr831CD9y4j+0m6obTyOVQsQB9DKiGIimPFUww1BWnVNQdLYv/t63
	 ySxR3VOKU887ghetar8pfS8L+TCvwPAuZUK8Y3mO52nwvdrUqET2/VBG54IrHa3Dy/tkO
	 /+3pztSWXZtPpzKlGZTnQwT6b8NVqTW+7mpvNXmXfyl/6upUuzvvonnLUskhlLHzID68x
	 J1qK6eJCYvtWT3flCLiDoOBSfPIgJmFnC9qyBEwn+RmOscXJ7l+j/+w1EReIVvn4SGFoq
	 3yjFn4rEksF3QR2wH9db3fLyJmlsdD5ONtjYcPJ3j/USLyd2N8ELYjR6x3heMLBOaUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793266529;
	bh=mA5Glu6H7XGCQAmQqic7Xq8PVYvtkMBgaiNQbVje5OU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kJEEcY/HuMOVoCK6LJ6edXS09XwL2YZCrEOqFVHqx52L2VzS5E3+zdX7z30gI8TzB
	 QQ9fhMF/9623Hl7l5zT/Jj+8D0pIM/N6cvkLVLFyyDuJ0EmJE5cUzpyWkIK/pl/evm
	 ofnH6QMXiFPMNbt2v/DPj6xid9ng2nzsOVyIX9qXdF6AKxPQOr/X13vioeiwTmk9yZ
	 rfPrO8YPggYTF6F4N+roc0Yl4RGyEyIdBaCBX7MKGFSKE5+v34vZaEXn2Wpj2vwkHk
	 xoGYA2kUXKocgEfAeL6GE0RzTKsONnqxRybUhdQLj/DjULn/Ky6YwkdNfxEmUaXaPE
	 DXUiMesvvCSng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5B3E80E34;
	Thu, 29 Oct 2026 09:35:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 14658972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 058076067E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CVAQMk6LS9Jl for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 09:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E228260686
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793266527;
 b=lJTj5P+f6CX8CFM4dHWMH1Yi6/NdvdEIGwNW2tLiCaAl9FyHv4n4Mps2L8HZf5j9W9on
 UsZMD2djF311p9aCj4CyFImQzy625Pe4Af/UWbrDaxvHqdbQmt9DFDiIzMfbJIkL2ufWD
 87gZ71YNraipyLbvS7eChcBL3iOPfPCgieaqX8WiGdH+Uu39IkOoaLJnaL9lvbEMj6xkx
 I8ywPB6veCE20YwbuYwggyAmuTLpCl+hZuo53Lx9RU3WDY4ifstOPZ9qI/LPa54S6a3Ve
 EN7viap0pHegKQP++eb3YV2vlBsxSQ/hM3NDuW6VVyGIT9qEs4/IyDW2ssYlsSILZmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793266527;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=mA5Glu6H7XGCQAmQqic7Xq8PVYvtkMBgaiNQbVje5OU=;
 b=BHGSHlDEuMDWl2iRbwgwDRDbo738FRtHA97yuz6khtXM5fOEZTVyjyeRaxTjbokp9j5+
 ckoKcWYxzXn1xcs+GjMZfVjbAoTyirQ5jdwiDpn/ChHBuSFgJGJkF7xNG3x+97Ox48Tib
 RZSeD4nrIIvO6TmleyJADXru+4w4U0kyfOHYnjzQZmSpJEY+JgjvrRh8u02F6Evgrb2uH
 /bQssxFsRoieKowA+JOB7Pz6EhZBZ8i21EyEAK1XAghPk+N3rm2XjzgrfQrOF6LyIKLr2
 imyv/40KLHRqQZMK2a0Vd9B15KSqTGoymBJOuIkf6caUFsFGo99rN0qFlMj0ZP1S3qQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ckIIN3HJ; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=sbabic@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ckIIN3HJ
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E228260686
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:35:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D4E7C10629B; Thu, 29 Oct 2026 10:35:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793266520;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=mA5Glu6H7XGCQAmQqic7Xq8PVYvtkMBgaiNQbVje5OU=;
 b=ckIIN3HJUK7InosP9Fpb5cmbk+ZvF1XbL5JhrhSThgrEZT8hPNxlYlmffwIY27ziOhQebZ
 V2J4c+u/3CS9YRlIDxkx8EYx6v6lBb65hxZL+ooy1LOqjxCIsPILLdiw8x9F70W1BvlEpO
 N4sCkWDC+uDywguyrvpZphPC0obZk4XVb4tomnUbjVQNos8BgIfSc6WY1eQYTnI9SF61Jt
 fH/dZGcbyYXj3uvRbxhKBnnahG2gLay+O4wGqfNcfD9ps7nJ6+KPptflkEgngzkRKnNKh3
 enc6gRCljM9RBrFGJwJAKpZ72VFjCydeq7p8r9SyIMgs2WVCRFFUZVCbHzSRGg==
Message-ID: <d89ed73e-c2e1-43c5-bfd3-06d89d14c77c@nabladev.com>
Date: Thu, 29 Oct 2026 10:35:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: imx: mxs: remove link to Denx's mirror for elftosb
To: Quentin Schulz <foss+uboot@0leil.net>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
References: <20261029-denx-de-elftosb-v1-1-4e07964ae377@cherry.de>
Content-Language: en-US
From: Stefano Babic <sbabic@nabladev.com>
In-Reply-To: <20261029-denx-de-elftosb-v1-1-4e07964ae377@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 10:30, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Commit 904c31fe9f08 ("imx: mxs: Fix location for the elftosb tool")
> update the wget command but forgot to remove the FTP link right before
> that paragraph, fix this oversight.
> 
> Fixes: 904c31fe9f08 ("imx: mxs: Fix location for the elftosb tool")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/imx/common/mxs.txt | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/doc/imx/common/mxs.txt b/doc/imx/common/mxs.txt
> index 372062c0eaf4..a177d75affe5 100644
> --- a/doc/imx/common/mxs.txt
> +++ b/doc/imx/common/mxs.txt
> @@ -48,10 +48,6 @@ NOTE: The "elftosb" tool distributed by Freescale Semiconductor is no
>         otherwise continue to section 2). The installation procedure of
>         the "elftosb" is outlined below:
>   
> -Firstly, obtain the elftosb archive from the following location:
> -
> -	ftp://ftp.denx.de/pub/tools/elftosb-10.12.01.tar.gz
> -
>   We use a $VER variable here to denote the current version. At the time of
>   writing of this document, that is "10.12.01". To obtain the file from command
>   line, use:
> 
> ---
> base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
> change-id: 20261029-denx-de-elftosb-40c522702e8c
> 
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>

Acked-by: Stefano Babic <sbabic@nabladev.com>

-- 
_______________________________________________________________________
Nabla Software Engineering GmbH
Hirschstr. 111A    | 86156 Augsburg | Tel: +49 821 45592596
Geschäftsführer : Stefano Babic     | HRB 40522 Augsburg
E-Mail: sbabic@nabladev.com
