Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D70CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6981180821;
	Mon, 19 Oct 2026 09:28:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p2vVAiHgInN7; Mon, 19 Oct 2026 09:28:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A348F80F51
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792402118;
	b=i+b0QT3o5HD7Yvq+qLtIImB+yhV5Ra5g8pEt1eUbbXoanJbvVINa3TqYIawTPFfUdiAh
	 XjVPrbXoSe5IvZEUqqTKyLZkw5QqEMhoJTSAUjdY9QBO6tmoo3LV+r9fTyVyFhyUPvTT4
	 f6Ycq9bvKVhhmGmglLzJJVnkXX1iqHTpNRgSqUDLQIwQaGxX8cJAG5E8iEGemAyp3ePw8
	 TTJWS7rOAmZIuN4/xKTiRAZmBAA1gjCqWxHzxbpA1MpPVEEnjboQJvHrxRzhnKR+k0lDL
	 uw7iHOpySGu+fEYxwR5+VPFFLZVE5n1KRT5VmK54sBXw2n3UQPZgsbflfQ8UFTzwqGA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792402118;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TnXAWIy1BTKlqBLbzJ+O2iVfHBuYJHQw1IMtuF4dRi8=;
	b=pX9Cn3pFDmPd6V5W8WZk6HUfm7QkHXNRxzPoxFAxJOwYQyhrbBHz03YOOBgTzwZro01K
	 h+QrZBglYnadRpu8zIjQcBcHqXu5H8Sa2J9E6zrys95dld0be3wn/+eDw+WT8Q5J3/2K8
	 ldx7C4SHuUpzvgdJmzfWWEfuX9C+O2RIyexh5gJ993doBZtdfpuLEv05OG8b3aGVJ9aYY
	 lB75lESNmou6EldC0PLHxQ4qfa16b0x4gY5tiNNzUlK2wpc5xkkAhq+bfutSzFHF93EQZ
	 7fdKcPyvIx6LKpbDiM0aSZlO6hT0UmIGEIVm5G31xhUs4YCuebsj98R/q+CdjvpCsEw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792402118;
	bh=TnXAWIy1BTKlqBLbzJ+O2iVfHBuYJHQw1IMtuF4dRi8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sC/qZ6IrSR3YzcBcfnfR6cb9jQgC07GMmRqbbG49XKDWig+aqrv2zyxzsAd56Xs3i
	 zSv8Vgw0TsFG+/lziKzPonEM55nAuX9pOm8SkzsQSUvg0pEx7gjz1EsuQYBQblFuoy
	 p4gnQSdFtv7Kn9HjfS2Dw4SXw9jJ6mOXuvc8fVshTL0UAu9TJOFQID4tQoysCD0Rh/
	 l/nkpbaFTJe43k7yTu8NZQqwpKTvmGhLga9dulykC9l8X8zgDfOIEdv3GqmaQjaxCa
	 cGgKCs31nyquGXPzNM1tEgSasxvUVLq4YDPRZFdLD6Qxuox9URhLL4c18XMmv0iwVr
	 IflN4PrqK1yEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A348F80F51;
	Mon, 19 Oct 2026 09:28:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 820B12A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67E4B605D4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:28:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZYF-FA7n9Jvo for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:28:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DA775605CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792402116;
 b=Ub0Z7okptJ7lrMrBq8g1ikDAKhtPrKrQ04AL2mAegYPnWlLAnglrAU5u5rUCe2qUXRGd
 YhiIShxLswP32TlGgerWx0Vf9V3TlXFI5tLKILLn3b07oVPWnFSa3wGpIO5bdPw5mU8tB
 BR12G+UpdpL9nA64PC3xiu+PNAPoo8wEAU8Bmxkb/LEHP79mcPpKlk34VsmjMI2VL28t0
 VmbAl7feRuuc2J+Gdqd2zgTh9iMHdYHaNh2MyyZ8X6VGyE2JvVrY67I43h0dsVnolj3Eb
 GcI92xtNfrTa6z/vX0QSykL095X2Pawn58iOqrlKIx8gp2kHtl/KSBnSr3RWrNXhkBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792402116;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=TnXAWIy1BTKlqBLbzJ+O2iVfHBuYJHQw1IMtuF4dRi8=;
 b=O0lBy1/IXWNxQbqJ4Qeqmsbn6usDvGljel2XBgnmK3foSpWfYK/KapLG/Sk9l6F3yYAe
 lt7TZzfcu1E7myVWFtMv70upSWIfFUVH6ijmueUEmcg/j80eWuhE5LhBUYJe5jmVLO6IV
 ytNQfOul4f2RD78F60rENJAj9zfZmag+qKy/oshHf8xjk/zKHpAd8Cnxyd0NJD4VsxCia
 RWw8rt9yNPwLjd42+tojIzSR21OIsVMGSUUe2wrG1aHpoKw+hK9ZLMR5otW+4F6VndRgd
 MvSQrdaUGf5Szlz6ibtfbpCSjPUhBnF9//K+HPe23kfvv8nHuDXA0yPKd3iE7SFAqJA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FJcmQPlj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=FJcmQPlj
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA775605CB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:28:35 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso7175345ad.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792402115; cv=none;
 d=google.com; s=arc-20260327;
 b=mBWtkC4iTwMoSPeyKnByLE9FSPIHp1gGGBrQLV3Y80LwLaQu09i9RM13KJoPde8IFf
 rdFwbqqUDw1YteHAZJhdl4bFLPkhAAMHq6Dr+mNIlaYjuXFA8aJgTvJGzOojFpnDXG/u
 QameQ6MHYEEidp/Q886RD9WOqQx7xyDIQpxJWeHAAN1xnvt7cHIXVsnDL8RpaMzRAxia
 Vc7Pi5Z2QNRstWudXB9xclXMgGx3+3TaUs8F4orvAibYAlXoqRXEPIKXQq7QNalAdWa7
 Q1UNiqQJHqNlad7ITSohA4tqewsqpODr78A52ZSxW4bkbOdqToKOwmD9eR8/LNdJVdsR
 ATOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=TnXAWIy1BTKlqBLbzJ+O2iVfHBuYJHQw1IMtuF4dRi8=;
 fh=foHa1jey+Zd3ZUQULBmfvN+OWcMIoZUPgiQ+bZgnjD4=;
 b=iGOV9Z7WAZUQWEHxr8ivMJmrC6jyKa5LDcJGiU2k3/IIy1EQufQ07uXnhDt71AH1Qz
 6fKvQyFKPiRxum4GpohR4WQb3+y9Nzx86yQ9JzyVahPnw13gMESSD3uZB9JGywy0u9iK
 996f5RqpqwDKKTDJgHevuwtFDWOCsoUySq4LMpIn9td7xbtlIt1CnJUa/kOalRtux0sn
 SnMMGRiiu+CfTROe0V7P7AXKjvzOelVnDmGfSElXiA/VzfeCUsoRlYwUh5dtxYJ4QAcA
 1qrQUIk3tFjxZ8yTr4eel1QfPBllfG2KONLtdFxCyB1KiZxMroVjFPuWEms2vsRv2eT8
 mjOg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792402115; x=1793006915;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TnXAWIy1BTKlqBLbzJ+O2iVfHBuYJHQw1IMtuF4dRi8=;
 b=FJcmQPljlzBzDYdXAWCTsLv9jk6joJ7gKNL5rwfKb8VWJvNcEO2ukAEjsPen2MSjsS
 WTf/WOyevvfT8jz09YgCT0Dgb5Nx+c/lqMfdvyevm2ee0drrviN+T2qIQmrNWdkgsL80
 5rBoJ+M/UHxUZ4aAzeZk8IjFMjjMwBFlKV3Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792402115; x=1793006915;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TnXAWIy1BTKlqBLbzJ+O2iVfHBuYJHQw1IMtuF4dRi8=;
 b=NciVbYcvkzk1+BMUnT4JIMvHv5Wl+GqnDazpXanv9IipslzZ1CLyCBqaKSiWCu84MQ
 2QxPDdnHiJCswam0lzn+0Nq8dLL2dvk+TxvYEdIw4r9OSSuohCjBSZ7/NaDjRRWZ3a/w
 BGBXH5X2C2ezAjeYDEpsLQf2WG+trGvs7000qH+okSPCLu9qXd1hqzWGHSjyHe1NxULi
 YhyVNBxZbVuKcQ9Ym3eA7PWu6J6GOwTUEfx8ZD03BvTl1rm8wBOMHMfoqVmvUK7gVZJ6
 5/c3kBcbUwz97iPTr9sHji98NR7YJk1hFSKIWELQlFpWPSreJ75QOKRLB9OYlYrbp+QL
 ISnA==
X-Gm-Message-State: AFq9FYI2nnbJPq5TBFKxFBLKkAhmDttSLI//cHx4ohdQRTWd22FBrX2Q
 oRolz5TWjTwJS8Gijop64+uPov8ChlgLVNVgw5hJdOTW/5P4BebMQsa+/n3Mpg+BY5qq8nv4F+I
 7Sl2AQwHpUVj1vAH047VBnkSCqbxSvzyLNpcYlfY5
X-Gm-Gg: AYBFou1ettagdnrtZpBoTMQZ5bMLqFuA+h5PFdj76F7Itq6MnfEJAtzzmbwUUtdmcYL
 ftYkjAU4nVKUJAY+7IamDEojTSA8uWVkCxzo4YnKUpCgKnnfFH0F6KGjGVvNIaKwYrAEs9yr6IQ
 nHTeCek9Cz5XXV39eubct4td4lcudS6oC4YTZxr520UDmgP6hCpLwmb5KElCWr2kQjPf5hUASVs
 17DtSVonr1lVpIbhuTrWuIQ7TRVenfIf65ibKy+i64+d2opZp4yajUKAAe6A5LKCkBUk2cJpauI
 W2LUxAbsnkjHBU55SKL5bYAUD+EpoFlJ0LvM0LSlnj2ypooEMK573A==
X-Received: by 2002:a17:90b:2ec3:b0:3ab:e588:c295 with SMTP id
 98e67ed59e1d1-3acef51e29dmr5782021a91.42.1792402114840; Mon, 19 Oct 2026
 02:28:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:28:31 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:26:42 +0200
MIME-Version: 1.0
In-Reply-To: <20261018-qconfigdoc-v3-1-196dfc8ff05c@gmail.com>
References: <20261018-qconfigdoc-v3-1-196dfc8ff05c@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 11:28:31 +0200
X-Gm-Features: AclHuK_tEbn84KYYlUcMMZ1AjFZy61BtLT-HiWJ-AQiyEKy17dUaNNggmq6_xuk
Message-ID: <CAFLszTgyDNSgkc4FkVAB7TRQWPc9fC6UL-J56yppDyt3Mh=TbA@mail.gmail.com>
Subject: Re: [PATCH v3] qconfig: Improve the documentation
To: massimo.pegorer+oss@gmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

On 2026-10-18T09:58:12, Massimo Pegorer <massimo.pegorer+oss@gmail.com> wrote:
> qconfig: Improve the documentation
>
> Specify where the database is created and under what name. Add text
> value lookup examples, including quoting, escaping and regular
> expression cases. Update other examples, or just their output, in the
> section documenting -f option usage. Trivial fixes.
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>
>  doc/develop/qconfig.rst | 59 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
