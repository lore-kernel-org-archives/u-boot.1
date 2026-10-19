Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710ACCCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06EAC80F7D;
	Mon, 19 Oct 2026 13:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eb5BcfBnckoa; Mon, 19 Oct 2026 13:15:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 116C980F81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415732;
	b=R7cTpppCWPUVLc6BfyzOuWXjndLi/DwWyaXIk94z+OePiXQLQgOZBtB29Kl1fOx2jhty
	 pCZ0NeO2luII1L6hVuz8/dzpHEX0/GtVqi7iLSNVOGUMvEnIa/Gc3WQP8Mv0MHrPAmWzm
	 kKqurM16L7IPD4N/kGwNQN8jfpYWBhJOJ6A0btuI9uM2nk62hjVjHN0BzWYyLwILdjP1g
	 RQeA2ybLIQOlcY+NWZ1+ahpLkVIL0DxZ8/CQQq0QmzpF2CKhmg2xxTV6oxFl38FpjTF1J
	 4YwBITBTdAccm+PE9R9zyy8SLVk4LqYvbAHgwUSsZuoVMjX9/G4cBKtwJrzAMdZ4s6g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792415732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BNadmVO6rSZPwyplOhESt8ns28/k0wfythw9W54DLZA=;
	b=O8GrnFHJ9zPOtq7SUYuZV3bjG4vXkACG9o8ULN2gkNQ9pRy97HMUcCGSJLv21NUlughP
	 MzdwqXFQ8SymPmor6JxiXnGt1+0U0zBKgNklr2bOpNO+4sLP1JE5rIlTasrrW5qza82LM
	 /6p46BpMQZ2F/23RRACLz3KqZCjnKVE6NsXe6f9tRJR6WFj31bliyBGMeUymRUvqshG9i
	 415DIaqg1Nk2mf5ZxR3e9luTJCMY9rtY6HD0rVOwfFtFRdVOJLJOlw8774mZV32nuQmXH
	 OwJHaZcHQiNNTU3UIuocNR62J3FI4YBT443zoTmcRro6JoaltbHpvKhVlvuMFfZuJjQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=V+tvfR4v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792415732;
	bh=BNadmVO6rSZPwyplOhESt8ns28/k0wfythw9W54DLZA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wf8cpFHFSMA5IQePOY9CLQHwqWzFgLSc7IkLFFiaW68WHEiMhRP2r66S/300rp6Ia
	 GhElK7zYFv8rnZlGLXW7oDMt8kXAsJXH66glbbz6IjmGcPD8mzfR0/iH0wWI7LMrWn
	 +EcyPTgOYTRNKlZcl0sybV95CoeENK7omRHvDToKgaV0SNnx4/rgH1bVLAwZf26LHj
	 kz6szZm+3YzKDthy1X0W2tUco79phSwul0DscMPQBQfIuvG2KEq9WZthQXlmZVC8uP
	 VL+RStZv6YmkD/fFkJVtXiBWSeTyy3UBzQGvxA8DP3PrCly7lyPnNtV+6nfMb98jcV
	 szX/ou5TxTAIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 116C980F81;
	Mon, 19 Oct 2026 13:15:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EB89DC9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF9FD80DAF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2BIIqYw9mCTN for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:15:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0000980D5B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415719;
 b=kFuUtoXADZzlJgjGxdmz6j1FJ6iHtpvWIjFxsT5qJt7vZFFncWPw7ADxcNOHcR0TqvnJ
 MvMI+4BAQ/IY0ibC8VoD4b83sivOufjbIF1XN4F9ySO6ukzYNjYHXSiyVaV/TpY7WN0Ii
 gTXoKxQocMlXnLxXi0hB/kSQrOTjP8WplUMEIEF0zp6XteHfV/+kz8Lz7xrpjE42KNPYG
 guu6Hr4sYWspav4piUDiLhDJcl3gCQza7pZ6rzH11PKrwrjDAPRDTw70NFnG07BDEKoWc
 6W3wMZ3qztTV0bMEBDedo1b6myLxccEvIzuhr4/Nncf/t4PiaVFHTl8F4BEe6ztQ1QA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792415719;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=BNadmVO6rSZPwyplOhESt8ns28/k0wfythw9W54DLZA=;
 b=HbRToH/5s8xH24JdkGP97PCEAE1gSuk7XfbCQ+pbDVfz6Pgkp/iRMkl4NCfiWPVq+16Y
 uuwZgkDejqZDAh1GKtpJiMSBuSGKBksTLGgRzxN8+nTObeBFmkZxx3OhcA+FjnoPRYl+s
 VcECO8U3//a6p+wnSp+VetULsJZkqyXWNWeDQrN9u4C/2Mb6VP5lCToxWnOcr0S6d1rwQ
 l4ky76tCAErad7hrK4d1Hi9EgwHXBNdcb2GD0tUl/pkB0zbU7yQPIt0BpmgsTpPObGYtX
 j2TFOF5FyWBRxEjM8qzIPE4iJblghgmQr+HzcncqoAr4kaNskI0kwiZg+h0JHaaALqA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=V+tvfR4v; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=V+tvfR4v
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0000980D5B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:18 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa4d71e7so1982909a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415716; cv=none;
 d=google.com; s=arc-20260327;
 b=L8cr7gul6GS+5hKrUIZO4K7Tf5jEHjXFVzemC8jiEk+bt1wgzNWHAtIVTPaKUr28TT
 inBg28537itF4ZN3B6M7qvCmnJDnfv3L5ypKGAvjz1m9gP35PhElnUxXPqLjuJRVECUZ
 W5Zgvo3r7vamHxpoffuYS1x06o+e+dxryjFthYe4STFH09Aq+plqDPIf1INdAc300kh6
 WqPRFIFNMxJjIyeniUePZFyYxbIBA0jNY6JwkuCgjCodrzwPA6x9LaBdEk4wtR2ldl4M
 rQTx7pdyz2EarJvCGZJFYhYqYIWDm00rkEFDc6onF95R4G2Z+EXsByN5aqKqn4jYoiqB
 5aJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=BNadmVO6rSZPwyplOhESt8ns28/k0wfythw9W54DLZA=;
 fh=z++0GxboW14ybYY71GkZal+wuz+qAr0n6I4mWk1Toaw=;
 b=E92Wa67dyIMNgBXydY92lMETo/dpVWu6jlwVCjt7/WeUIB2k6Kk7X2KeG8mmn8vQN1
 LwQADzTv+xRnpP0KI3qT6AFddJgS3zjRJZM7cWpWos7X//1+IYgVskclPIqAU6jgAG0E
 Tk50VP1Aj+loChYkXDfLVg+JXJ3okdi2G16ImXOTZFoa+tVqCcvtGGm/EDaY18RoiK3s
 EEmHQlMVf7a14caziDnuDmuDZC5DJ6jborhxsa6FPU/D6dX2HeU+StS/c3sPJ0xWoLwB
 wr/I2CVWdRzQ9FQ+TLzR12iVCoW264blNg2JHrfU3uxgEKELF3Z/psCewcCyLzbAcuDI
 gaKQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792415716; x=1793020516;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BNadmVO6rSZPwyplOhESt8ns28/k0wfythw9W54DLZA=;
 b=V+tvfR4vnKn/sWC9yUyr1qMBkX5e9n492Y8aElgV3xoDJ9jSzi2DJ6ylSNSCF1XT1v
 kgcYTLyqf2cAwJyP1w5VfJVoz2N082i0iMY/V6fE2xoA3RBdR6oFMaLdSGlMVkNmt4oQ
 Hz7weHy8tyWle0yeAuO+wfSohVkIfmVvQfQn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415716; x=1793020516;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BNadmVO6rSZPwyplOhESt8ns28/k0wfythw9W54DLZA=;
 b=Xs6bsaIaM4A+n8OBrbqX0zy5laUfh7wtuWNku8/hGXknOv72h438Wd5jhWPhvepVAu
 ZGX+qXxhAL9/sg6QY26KSDaqqAiFwhIDzrPQw6jZrUErM5kTAxyp+bCNEpQ3zRO2u7I1
 sYBBY61Al9WtUCB4tX2P69Ypt6W4vCOjy/S3LtjoP6Wu5vMXcODc4nPkgmkAcfOvTks2
 Sjwg/RGPk+7xIgclkGP9B9XF9xPga1UwzgUKYBd9/PnQm3HwQu+6xmeHlvXTK70L05j6
 0OPXUX/1XjW/CQkEGflo27/t81Pu6ABkAD6vWK3PNb12PhaTvNO3KjwNL1aOY2eUQ4C3
 zHNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiP36Un7IMH/jIwG++u+7x1lQJnZsZCtRPno/8GPYmD/6e/kPPTVLy3bviKgTKT2fVO10aypQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJJphz8gpoo4T0Kqx4570OKALbWT9gILyrcFy70ESs+Hn8jgVmp
 vzJ70nlnI+DlHW2Oe8zlC0lZWVD8TbGZVqC/mLtqCQdQ3br+L5w8eKJjAc5AxMFcwRHtff2IalQ
 hfOcfHT2HRIKW38GNjPWsPNa1+VgXjE45AwvWoaKmAFQ2j2aY1IoGLg==
X-Gm-Gg: AYBFou3wct3GOx0RAgEJvL1iT3+3AZLmu8EbCQ2r/ZtPHSHEWCJg7KoYa94C2pzj7fG
 1J2StrIcwqQcKeS/wPheIVNyYBByuKohawHOYbueB8nbHog9aptRxpitWsuWlZ2tvNf1gqrqLT7
 nlDprLbCsS2xMKGrEyaP9u2b5M68KJ1zaFT/4oHbFuI/dnfBpJ6zkHLIpQXicHOZr+1uEhcL8/U
 yQ9BQ+nSrZCKWzaFuYFY531gimKo8FpAbjv8G96C5WK/2oA9fj7c7bjDDPsiMphHdQTvEh4DQiE
 Lic8i/1W/a4TVrmH5EUemtJJB1x2cpTqR++TNg+Z+FFarbJGzvm0aA==
X-Received: by 2002:a05:6402:234a:b0:6b1:c526:afcd with SMTP id
 4fb4d7f45d1cf-6b3a81760e4mr4813142a12.11.1792415716513; Mon, 19 Oct 2026
 06:15:16 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:15:14 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:54:44 -0700
MIME-Version: 1.0
In-Reply-To: <20261016065500.137544-14-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-14-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:15:14 -0700
X-Gm-Features: AclHuK9M_g884pwZoOaml08APr9ZFvlUXBqXE3oSxPb0OTMEwCV_KcqQPjayoAo
Message-ID: <CAFLszTiY-YiZ=mX_7bi_Wnkz1+gyfcvacZHDTJOnKr9adJ6xnQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/20] cpu: Add loongarch_cpu driver
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
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

On 2026-10-16T06:54:41, Yao Zi <me@ziyao.cc> wrote:
> cpu: Add loongarch_cpu driver
>
> Implement a driver for LoongArch CPU solely for gathering
> some information bits from FDT and CPU level config registers.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  drivers/cpu/Kconfig         |   6 ++
>  drivers/cpu/Makefile        |   1 +
>  drivers/cpu/loongarch_cpu.c | 145 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 152 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
