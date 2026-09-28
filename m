Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F56CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2666780F75;
	Mon, 28 Sep 2026 15:18:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nPNla0PxMG5c; Mon, 28 Sep 2026 15:18:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 25BDC80ECF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608734;
	b=cwT0+EJthX2M7HlnRlizQYWVVZZaBeUUE+vLd0mMdPJh9ZetHsepuSQpIH4a9PCfIYks
	 UIK7XsOEkgri4+6x4vzPpRaxXFSXVwjoLR/GJL9NYtQCHDDhc61lGOoBywpQhUpnWzVKU
	 w7+0Jb2TpszA6II30SEVWN9zfHA43FE3ovI6jyhgNTToL2cJDRJ7BIturFKve7V2J3qyL
	 H6M/RYNC9aw6wtIIHmePR3amVT8VZWbT8TF8V4/z9IMPvlIbNYyjwUW4FbFn3NFjZAWCR
	 2fusamjCORuEs+yTVNlCdGcpP3QlONyOTeQiPP7pL8VWR6V83khPUxb8bSlY4dRv93Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608734;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0QjBnE0InTaZfj0r9CdxsFFUbRULfwolbUShsQ///KI=;
	b=aiaW7UP7T74UQ3Bh5kejcTy9b1LRywHzj0zXkUKObNHotrWU2xOkRuqYnqshw8G58vU2
	 I86whtUrGWJR47oqtqUob/WzZGvYBCprTg5vfjYH5H+gGsdjO/EV+8Ckjf/yz5OKCJXs4
	 u0yo8ZScrTO3ZADI9qcMiphmcuAw70TeVXcX9xaY+l9N4M2RWXEhkZuLtLNC/yM5uEbmB
	 kGY4IBjRWz5mFY5jOki7Ofh2w9YwT2UWQiVkWbGyFldMlVIJxqHZ0qAf6a/4RjjoKZOJn
	 upi5W/ELLc0qbJcdJHVzbgmHa4LSpzPLYW0YMTPMvQVyLTwojMPKTydNn1QvWg44fGw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608734;
	bh=0QjBnE0InTaZfj0r9CdxsFFUbRULfwolbUShsQ///KI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U3rSBlWH2iSx1QcmfADFtge8WrEE9TAFrUreYz3tX2pxaism9apsCaGGimVU92nFY
	 vIdZbPUgMlTaR18ORU/L9xnSKrtgYvFh5uHzbt6ojaN9mMU3MctGkWCEODgAxEFOLD
	 b81A29vC8WD567RDUGllf/gmKGrGlge2/bkCFyWAGkH8GuTohu5Lc3azA/v+5O5RWc
	 dYJX1FC8Mp4zDe8F7vz+4z5NfsvQ8yYmk8pIiLuGk8grKE989xpkzlZbOktwMdL+/P
	 805MfE9yvX/Oi/gKZuQ2R2DLYEVWww+4pkLgAbney1eDQEaFA/lFCBoFfdfWssaMa4
	 lXd8UmcLnWiyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25BDC80ECF;
	Mon, 28 Sep 2026 15:18:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24EAC2B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0ACF6606B0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:18:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ggDdBNC3rLo1 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:18:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C65B3605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608732;
 b=HRHlfG8vZZJdFsVCvPC0rK0r/k+njIUCPGoSlUeTfmN6p90fs1wRka4TkzXrxM+UXElB
 9QPG1e0XazsmEu9vGluOzGNcLPP00aBOZ7l9V3jOdWo0wMUFK8a7bMmxwJKQLUAFldBm1
 5lYKYoO53l+x0Ul6xY9w23phBfsIvQuR8DgWVf41oosCq1QWHUzSXGk609S6oolew5CVO
 umJz0R8Gi9Lsy0fs4ZQBhSeqpx/GogXkx/hpe86Wf2vAjbmH8nROPW+yOl1ahWCSKNWj6
 LJmrYArTdMFeRNRBH85dHXBoM7fN2lWsKxfpxgGv9o+bfne3VGAUtwKyYtjseeCrfjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608732;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=0QjBnE0InTaZfj0r9CdxsFFUbRULfwolbUShsQ///KI=;
 b=BE5yh8g1SPLNfM/qO3lxRSM+6X94e3blx6VcvouWtr/2u+laHC0GlrrBrYzkezFDhytd
 N+piZeeaBhmQhjWU2rGRUtgvA0bVNVgEtnYJ8LN8y7r4VPFfj4ayrF78bPIcx2IKHnI8B
 GUa3NyXqjQuuuP8F19WPcy3cvNZlyQUStMZGpuzuNivoj4UkJBVHB8bNPge3TKeI3LcQB
 xjis4q9xuyti419/kT9xqHZUb2m2CaFfCY6ZsjngTTlOjnloLE+Aywyv9w/9QJVWijh19
 rjK2Wgz9Upck/k+EW/42SIBV5j2/F3CG/hAtn9Ct0+DHX4pCK1/QpzPfOjIH2rD0yvA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=az5Vkuf+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=az5Vkuf+
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C65B3605EB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:18:51 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6abc27842b6so2764257a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608729; cv=none;
 d=google.com; s=arc-20260327;
 b=U86gJCdBCPJepS7MNNTfm8pmu/gy6oJPcsc+UiOvb35kxjkvfzEja9iqY47fT8fVUb
 cx0Bsftnzxq8JReEGYTNVSDMm1JCZTbVYza83lLDBqJHNF5Rk32gcjNZRHWGnij7mAal
 p8QBGnm8dmNP9EYKpf1r2bSnN4USvx2kH5+b+wMGwDlG+SSF4fV0O+9tPlmUGmjfUEq/
 DBo0R2PXPVNDQnOKSgy5MtGkFsYvebErzyg7yFPNH7/xtFAXLBekF/RN7RjqqVUFOLBv
 05TvgfxxU7Rr/LV3Q/m9vntjlfwCU2Ns+VzDImJD3HUKJEzRRefPz2sGRkKH6DOTrcTD
 pGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0QjBnE0InTaZfj0r9CdxsFFUbRULfwolbUShsQ///KI=;
 fh=8DuR7XNy5AEjb4gBS1/LVK9PjPsoKjz3k9sgz9THXC0=;
 b=Zrmlt9gGmMVYH/Qtu8VSTLKVh87URtlwHquCvYK2b9dW4gzp+00YgIywg4xk5fmpUa
 IJae1gp9/zpTeYPgm2PZ2usMsMF7GmD4A4///CHMXxuVm9misrozGjfRvXyov0ZxRqxS
 /w8BL6BbUTsWRdBX3GlZ6nazs6iAp4ZvkY3jqB3UzUq+ED3/oUzYoHDHTtAheidYv2wd
 MYNGP8vINEf8DKezkHgDekQ1hLFDkJ9zZvxFEU9vI2zLnrDXkVUhdlr64BdazC2tqcIF
 ohrAWSBWFAw6Tdx0LhwWb/BuMX8soHWHDrrH1en53CbRCxTowYcNxqwF4QwLK0SIsAwA
 0EfA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608729; x=1791213529;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0QjBnE0InTaZfj0r9CdxsFFUbRULfwolbUShsQ///KI=;
 b=az5Vkuf+8WNLKTRna0sFf5rnMAuUZgsk6K9tEjM/7xwCZ3G9brK/D7Mi3Whft/T+sj
 AVzIqm3758oxloJZ1Si0mMa53c/Wl0r94aEM6MiJdco5DcChdSvK+GdQ9A0uk/S0xbPF
 YP6FAFM53xcn3k0S6t9q5vJGQqf5YU4/5g43s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608729; x=1791213529;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0QjBnE0InTaZfj0r9CdxsFFUbRULfwolbUShsQ///KI=;
 b=hU2EWZxxyW3R6UWm5ceKXLyIBMJ66oALcPJ1cgyPOTR0lqZCyhWR/tOcPGrkkii6LH
 suvqXhlPHr6EJkIMK7DEPWyJiHvW/kTMIOhoInYDFOvGMFvmrFsgOQ6DqwPAUKzao21w
 Q15oahDffHZ8MRHJAzzEkSw6DYXlVlj7CBQu8AxmPKfpGU1OpK4Jl5hvILmOAKRdVlST
 Cq3phFfYelsSNWm0d3tg7WJ6pmaSiSe4h8XY4V3bvlE1gPJT7xd2ljoGHZ95i81Dir9X
 qvrMX7GKRCgoYmhaZr02HK3ZyDUB7UrQHRAVFW9nGLBwY43VmScUeK+RswdFPENsJzrw
 XlHQ==
X-Gm-Message-State: AFq9FYKj5BYtAuRFzx+6Cv1uNDO02eVAtmJGY1orQPGYtnv8U/vQtUpu
 q50s/DgmYkF7sg/aQ+Y85ABszisuC2dHepv/HSvgX8tCdgURbsHbtLGhY+vl8PTlJlbxUPbzF92
 H1rw9s2xWJwtTysnTrae7S3H/sT9Af+gSf1zfrcjt
X-Gm-Gg: AYBFou1r6TD8osCs5bMQ3tOGhimYu8zVlnIytedCZ++8iKIfAkFdrUoe2kXIRNkoWt4
 hbAf4ND6kIzkmGQbn3zwnokZOd/eNH5Q5un5LH7ufiZdrHEWvFrnT0ynw9AH8GOlOZAoKky1btH
 s1NvFDhHv8c9vuLXIShZcMtaxGtpgejBmZ+1wahapQOVwM4By7+hWOmdHMgQj043Ydwknccke02
 N1mQdAtdjqjsaOR6hm5LI3z1CBgblMGprDqF6LN+/7A4qCs1PgzGnhYsje4I1TDIq572GSety6K
 OAF2UP7MP6+Cq6Sc5ANK+G8bLHSIOtZzHt6JtmNvGRAPXfNceprCdw==
X-Received: by 2002:a05:6402:21c6:b0:6ac:8de4:2804 with SMTP id
 4fb4d7f45d1cf-6ac8de42fb6mr1405789a12.1.1790608729145; Mon, 28 Sep 2026
 08:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260922123630.608961-1-aristo.chen@canonical.com>
 <20260922123630.608961-4-aristo.chen@canonical.com>
In-Reply-To: <20260922123630.608961-4-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:18:35 -0600
X-Gm-Features: AclHuK9pq70YB4rm4UD9EjbibEYIBMC5ZhhiwAapRbuR2CqV_r8pyTYrUHGi8aY
Message-ID: <CAFLszTj36tTmOsPZCiwmNN=n21pb8gjCnP_DHgC+tbVSyh62-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] tools: mkimage: resolve image-data references
 between FIT images
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Anton Ivanov <anton@binarly.io>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-09-22T12:36:21, Aristo Chen <aristo.chen@canonical.com> wrote:
> tools: mkimage: resolve image-data references between FIT images
>
> An image node may carry an 'image-data' property naming another image
> node under /images whose binary data it shares. This lets several
> configurations load the same payload at different addresses without
> storing it twice, as described in the 'Shared image data' section of
> the Flat Image Tree specification [1].
>
> Resolve the references in mkimage after any external data has been
> imported: the target's data is copied into the referencing node, so the
> later ciphering, hashing and signing steps see a normal image node. The
> property itself is retained in the resolved FIT as a record of the
> sharing relationship. When mkimage re-processes a FIT that already
> contains resolved references, the node's data must match the target's
> data exactly, and fit_resolve_image_data() skips its own pack and
> rewrite of the file when no payload needed copying.
>
> A reference is rejected when the target does not exist, when the target
> itself carries an image-data property (chained references), when the
> node's existing data disagrees with the target, or when the node mixes
> image-data with external data properties. The last case is caught
> before the import when compiling a source file, where the combination
> cannot be legitimate; a re-processed FIT carries both on purpose, since
> that is the resolved form with external data. Since encryption happens
> per node, sharing encrypted data is only accepted when both nodes use
> the same algorithm and key together with the same iv-name-hint or,
> when neither uses a hint, the same explicit iv; anything else,
> including the independent random IV generated when a node provides no
> IV at all, would produce different ciphertexts.
>
> [1] https://github.com/open-source-firmware/flat-image-tree
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> include/image.h   |   2 +
>  tools/fit_image.c | 358 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 360 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
