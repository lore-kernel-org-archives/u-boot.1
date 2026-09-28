Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A05CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEF2080848;
	Mon, 28 Sep 2026 22:33:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kL_IchGJEon1; Mon, 28 Sep 2026 22:33:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E5C058085F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634792;
	b=bYU0+i3D9cXduPcAZ4bGmS/FV2RxniADg0RzZvadaTrdHFyPhmuJy2Q/bX6cCeBgtA5j
	 0PltCeRlt59anbUISODZo1rPbp+Yod2H+ZnkNZievud/rw8YgZtvwCg3rlYSFySNXIO9E
	 /pzVw/ggwburU78HxA1vX9oF314WP1fbYjoCL2r47kZwfBs+OaW5LoSB2TUCp21iBgPUy
	 BDQiuvBhoRLMXQk04lAdHY1SXAwO3ynsa/w9Qb9BiMuzRZVYzLWWFOJTd8BVK9XReOTr6
	 JoVc79ctjVVgIsFAl5D2lfWZt3LTeXMKxY/tXLRm+ymbFo/Q1hRCwT5/6Y279eCft9g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634792;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=o6AtvqfCmZQ31is2u9w3G4I9njLnZ9qpt+z/oc2slDM=;
	b=TbSNoUaHbIR9ZKfmI3QVu198QXVigGzq1P/7KQay2pN9D345dD+pfQ3jEt7LUKlZxk9Q
	 OGPb/Cqm5VWaSgSE2I1xV1mAcx1DPD0UQs0R19YbNkVl3Osgp7+rCcBnQ2SzXb0icselZ
	 9zvveij+MeTsQGRU4LXEby81Bpo4XpbJbJHfQofbSnmsTC41PuEQfQnjGV6Pe0bsqUCdT
	 uZTingjFp6p7DTXKueBMsUlJQksHJoYF9MpXVYLDLp07DJuNFI89CnyQFxwxiHW4suW9d
	 CVtFi6AatCfinKr21PdWYNv/pRWcbQRSGWLXQ6yqBlp3ACjrH7/VpbdHSw20X1lVtsw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dYn69O72;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634792;
	bh=o6AtvqfCmZQ31is2u9w3G4I9njLnZ9qpt+z/oc2slDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YS2LSWlCL3rxhQtPgT6gpMGTN89wGRtvobYAt1XjkZULh9p+vfwmtt3JtX4XgJAKZ
	 g7ECVyxtI8VpFiFM+zPsch5UEydph/lLcWj24yRadyMiZGqjV/7L3JQKEo/DEOKL5l
	 CblgtrNylFWvqJKs8Wn7Wqcyqmc9fYyg9nP5mMDyYt1e5cB1KSjTZ73CzLrnczJm9E
	 w5psCM10FQdvuDWtEcU9m3rTMWUhPTMyHkpk5Db95yxV5Xz5dx/A48rOKIv9o24N/L
	 RxxDM39d1yZ4t7cNQ7QQWkXQI6qWs5/cBORNr5x45pj6Apq4X0d9xP1WfbVzgTXzD3
	 dkfHtmFh1o8Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5C058085F;
	Mon, 28 Sep 2026 22:33:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 45FA3417
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B3B38085F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:33:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kol4B2xFQn5b for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:33:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 02C8880848
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634789;
 b=kU+I1naswps551P4caFuIRz9+Ef8YzlTIas9gC1kpH7iLByCZcqZVvU6ORH33NJIEUrw
 PQ5QsfCNJSkI13G2YFck8ybKMONhrbeJF5hJcWLLHkB266v+dCiJ8QGsdXwaT7T/2/F+P
 QrfRAGnrTERWliXeXA8dNAWUYUcmn+F3yxdAbTdFxXaPnQhikE81mgTjn2O90w/e3wrBZ
 V9vUbSCwBkJ/mxPci0bmNrGYZ2vFEu72STRPpUlqPwS7vZ5aAgPQPFQbGKhPY6Dxg++/K
 OlVMij7EXkKjCo5UhJr6tR9LaTM+cEOe3+Si/8fu4wxdtCvFMtFhiBqV/gE4RYxibUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634789;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=o6AtvqfCmZQ31is2u9w3G4I9njLnZ9qpt+z/oc2slDM=;
 b=rQ8EP0OAzkJVqT5tft+ADJ4HkX4phc3KroX0jY+Z3GBybV/HNMF5SIHqTn2cBVGnWFFK
 uIXrk1+Enj52mGCTd28Ok8bib0Ox+nZQ0M+9HESet9OGEtas80cnHgTwPQ5KMP1KTtUq6
 zeH54g6AyFJmPGSRXDCcJajUm8wpj7GWpBoOi9JCuilZ5nLe95Ye25j/GY5/qPduxE4eN
 tpIoHrOtC7/B29GzKff8BIA7qSNIMm6131+HqOr1blMPd+Ts5eSrg/MHGVrWJK9l+w9Ew
 9DldABM9hMR2SW2jYU86vPdiaUScdLQu9M/GeTJjix6BHqhQcEDsPsK5J33FQB49bWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dYn69O72; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dYn69O72
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02C8880848
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:33:08 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aa1d00daaaso6189493a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790634786; cv=none;
 d=google.com; s=arc-20260327;
 b=bsBwZ+T8iw6tHeuQLPyEdxQpbUD2W/IUdYAjnLALrCg02vRxTZl9Ju0lpLpw9eYQTM
 6tRXK9E+f2+QxLPRIbzF+c5jrdmPy8vVvCl27P5HkfooWXUwMu13+Zt864rkoUYPHpWC
 GnnTolmp7noJHfLeZ/1PnLGGoSclnGgd71jhF/rPKF3VBQHGP2rsEDtU7qCh547rwN61
 Mlx8pN/l/PJmERptuv6ufcF0iLIXXEkXvvhhQX/s+YVhn6uu/bIB+GsHCzPRA7/NgQps
 jPtt4qZdfatvMf3bNHidxHgKtcZ7SXZiQ/h8k+Z73u4dEUxKd+7VBZLTXwBFuGQiquBP
 btaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o6AtvqfCmZQ31is2u9w3G4I9njLnZ9qpt+z/oc2slDM=;
 fh=bHRVhoDqGWMB/5/BjGsVL+p1LGA9i/9t2F7dvN2UEmQ=;
 b=OzPOI0KexE9soL+OansVFfzJXtiMHEPRqUxP2Ea030er0hQUH2pyCwgPBNFkRvFzIv
 6ZRPJyeAK3Drbmgr8NIXXUMAesu7FVvFBOZyPTGg4Z9F2iU000Gt9klAy9ZnYYq4VolF
 fp25uPkbUWPIUqnYjtNwaCbgId6YofVpYAEq40dMO0pz/T2qECrp82DqofIUKDFZvw+F
 eBQz+f3suTSLHzppkAXQt2Eo8uOp2X358RL7Y1LFQQRiN2D9bTJZwC824vjWajCiNJEj
 vhp1kvuArVn1c7O3ZHzsLxn89+hEbfMsFTkjXoE2hvBXM63/uPpFSx4XHw/TD1OFO09Y
 fgcA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790634786; x=1791239586;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o6AtvqfCmZQ31is2u9w3G4I9njLnZ9qpt+z/oc2slDM=;
 b=dYn69O72AW4dJA7lfAiOQZNh4gd5GTlA/HjnkPhn71mJxK5Jr6mgvR/bmz8sGZ1zSt
 otE79WTTI5KbmrwtH1/jOgjBqnClo4c0ax/9nPmxw5Ox8HwlvcFVX5tJML8PscQvo8jY
 bu1de0s7TyKtT+w8t8+c43Wj2kFBGrBPhAh/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634786; x=1791239586;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o6AtvqfCmZQ31is2u9w3G4I9njLnZ9qpt+z/oc2slDM=;
 b=M/7EhR7ChcApJV0Z/BnlcaiWCQZ0npxL6hH/07nyZ2LqZB/I4IrTgU85+dgMJ+0C6A
 b6eTVEGziyILw4Q8s00/R8vlkdD7pG4DBi7CAepk5B3POL7ga9X2wglKstSPh2AcilKd
 sJxzkT/Qz9WyrcIIfh9NgmGbkMdsZk9JQkhf1hEinv7wNCbDjsjrRV6bDiICfPKC8JSo
 2i2wS8yimTh/f1kn2aInzFm1D+Us83KCZPs9g5wFOfK3obqHr1snwNMp63+6E8tlKzTV
 Sbfz851Hgq0orNO3ZnKnvJWMPCSywWGstKQbNQvW4qxqP2tNtzfv02gX6aInF4293tnn
 g1rQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDUa1rUlkZgylK/dbLCXJZrvZbDZ0WPw25AN3wvK84/iZzocRsXcuDyFJuKa0YDQMLLUUMG5A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLFIg6eSVzGM18R+3+BbCPrbk+UcqDBQkoCcWDb9DL1CBd7e5V0
 bQzIrZMV2tfej7L+18QhP1AU6Y9udRADaNKEHhcfyocQow8/XXkD+tVNyPYFfmzMo35uaCddl8o
 4wtUW+fQfRk4gkFR58naTht170guT46BAM+M+wpS7HI2kkynmF8vg0w==
X-Gm-Gg: AYBFou1y8IEpLYfejAct4CIbScnebWFsSyP32yIcBE7lEWUi3L9V5SaE+o2p31W0lVk
 YQBckBWniJQ8KRIiVdAXUqGGPcrW0jO3UeSOEtHzGSkLA8+n7nI1kyZVIrZy1brNBtF1G+0bqd6
 tUSJ/5d3HZzZbtx43z42kh0fDl3Mu3a7lgwvihBsxd5PCLoN/ltRN3PVkcLNiDlUf3jyWcgbZjP
 U/66cUxChS+HpTmlXI++aGnWrV0m78futehd/3LTYidjd6rlrM7mYbVh2uuW75AUAxCXaPilMgy
 qZ/5gEUHZaK4EgAGEtxXslk5oUOljSa4PK1YW2jtMZU5mo2z7OJI+y3wvA==
X-Received: by 2002:a05:6402:21c2:b0:6aa:7ff:4ebf with SMTP id
 4fb4d7f45d1cf-6aac8ef938fmr9691214a12.15.1790634786318; Mon, 28 Sep 2026
 15:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DxpBces5Y4VVHdYM7Lq7JxP-rg+pwqi12LMqsPrUVTgQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DxpBces5Y4VVHdYM7Lq7JxP-rg+pwqi12LMqsPrUVTgQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:32:53 -0600
X-Gm-Features: AclHuK84CiwJR_4EyC0mV5UUpv1pOV6RTXlIZ6HLJx_pu0tW8p1HulTkOJN4So8
Message-ID: <CAFLszTjFsdOx5qQUsWFEA1E8=AK=_DNJO7vbp1CbsQUGrE8VFA@mail.gmail.com>
Subject: Re: Review of i.MX binman patches
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, 
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
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

Hi Fabio,

On Sat, 26 Sept 2026 at 14:19, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Marek and Simon,
>
> Could you please help review the following i.MX binman patches?
>
> https://patchwork.ozlabs.org/project/uboot/patch/20260910081200.679031-1-mwalle@kernel.org/
>
> https://patchwork.ozlabs.org/user/todo/uboot/?series=523074
>
> https://patchwork.ozlabs.org/project/uboot/patch/20260922051838.526368-1-hs@nabladev.com/
>
> Thanks for your help; I appreciate it.

OK I think I have done this now.

Regards,
Simon
