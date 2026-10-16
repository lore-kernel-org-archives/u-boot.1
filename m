Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F44BCCF2C1
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 14:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAA0940790;
	Fri, 16 Oct 2026 14:34:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCEie1OY939L; Fri, 16 Oct 2026 14:34:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 326FE4076E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161278;
	b=TwEKnxLV99T+ac1w/RZ1ImskHod+CIHtAuXv6tsM7hDuX9grLlcVDua+r3GavvduQyza
	 w84kLGergBW3AM0/OEMlw9KnUJ9OcZ+K4fMqzPzRhLHl1vlGOrkCxvmAhNsxGzz5YN8ZX
	 toKFnSBWRBrIxEuNTTEEr/1geJXxsUoTyhFOHoZWICUFj3GLVJaII2ukPWlZsmEeeBbiu
	 T6DS5if1821XA0CTFzPDJR9EOA45F7N7rm9e2lzgM5amMbBYVSdWjtArppIA90DInELcJ
	 xcXBmpgkn3XTxG+MqCtyGBikRvGATxOywRtuC41CESRxSpReoK5xx9j5ApOy/JPjuzA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792161278;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o4rtLAmx+ijbNavGtZtywsogMLTb6d4H4/FbXdq7dNE=;
	b=KrtOV6XSZO39gal/CksttvfdVUT9Kcn0vKjY0j7w0y22fgwPyWmReaJJ0sskzcmmv2W9
	 PPOPaKTzhTfq0a6rtKAbPH3NNDobL0GWpGF10yDY34C1P2yUIrEy9GCdD3h1ln0ZeW6QP
	 TiCJPQL3OxOPvIoLXcQtS851IUOMzZHCBNpD79OZXVkcKwDEl7F0HOquovLqDND4I/jXz
	 sknE59a/+T3irKdIZ9nBLL/ZrJy9zylVPwKMmLr9l0imcH1KgzeTC/89WEAufJlyMzEnn
	 5PBADBiWFTLkd3R8qum+qI73sWfScFBvJao8e55Qeqow3BEEa//cUTvwKtSEEoKbSRA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792161278;
	bh=o4rtLAmx+ijbNavGtZtywsogMLTb6d4H4/FbXdq7dNE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n9HdbdYfFtRuKs2lOyC+fEIY1HxoMyVO9rmfhswmYNBvwu6bR2eCPIYysc3iALXtY
	 4ZZLdcUqkMQudKGKqduSLLdCnXr7BiKdwbsJRPZLmlTr5KVCNJRCGdCQM62HTLQPBr
	 q+KIFdUCoOpurYZb3HI2o/tJ6q2pHA9f4HZvPgsPEHKoOeMw2FnZg7gymg8MXKi3it
	 IGr8Wy0n1Kkj4xxLGqEy5nqL1HHIvfoGD6qjS4pBjMf0+jFATFST6xt1972n4Lf6+u
	 dZciG4Fh9xto98hJJzFX5o3g1zB/pdP4pAzJKJ+nkKi/cmtrCcxUdJNui4KghNUKNA
	 QlhsDDMB25oDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 326FE4076E;
	Fri, 16 Oct 2026 14:34:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3900D255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FBAE403FB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RXmlJKl95C57 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 14:34:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 768F440042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161276;
 b=i22M96M6xp26Kzund6kzOfFt4J5QG/p3X2+2IsMeYSDitSY1B/7k1racHSQ73ScVbRr7
 1ynbqvCrvA76ynjiI2vAksDsAFC5/tgj1nH71Wp5EZszKOaBu+8Yy9dTbNIfYXI/oHRMk
 ZcwGvbMXAY6KUN0Uu1aXDGtc1+p71VefI6Ak25hRQz3CrAy+/rMa6H9XnWCI5LRH/JiSv
 iZ5GuzcHfY+U52fDOO3ZhDJZXatzXrkNK1t8wtwhClq9vjEhXXy4k40QZrZrn+ynIadQt
 /Bd/FGyHQt3FquNo1xytJdBXgyYjIqt3E7Wy1QaB8OVOx/emj2kWB9x6BSWzqxoJGaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792161276;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=o4rtLAmx+ijbNavGtZtywsogMLTb6d4H4/FbXdq7dNE=;
 b=eR5a60NARavgwXJ90FbqG7dOkAe+NLnLYJlEkQrbu2adsnyOhQ8edf29OsvqZr4MAY5k
 8bUeIK1VLovEe6KYpjjsJ9QG7/6WfCpTH2iDTe5w1HiYMK3T5HB1SBN8bneWE33F58dHT
 gGRuL2pXubD8xakzZwflwkveiJNRByFG7e3ar3AUU63xuwGf0dFwvlmSQp2Z7TNCd0oFL
 AOVOdEyqzvPg/R5FsbSARNyYgYsovcjKQfjISKPFZg1rbnxVg0XCvqxyE2LrkFqJ0Z/pm
 D1a1DjUJBIF3O29N+6BtO5QA/Pp72dkt7MAldU1bW1nqpObLhdPDdgPPXLWwM72co5Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RbJIDVPn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RbJIDVPn
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 768F440042
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:36 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-ccc6b11a19aso16791a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792161275; cv=none;
 d=google.com; s=arc-20260327;
 b=qmoVOY9MvI0B9Rcq+LWQQGGWgjgn2QWPeh0WIZYm89LeHE22xYFI+039ON940DRFwj
 qrAyQLhisSrJiLwX2kiXY91LK2FIalExRbMH+QCKyhLdHi3B6T0exOzd9JWl6y37q3/E
 uE0nkaXlVPmvDppBLudIcMl1n+XsVKo+TFjOrUYNaRcuSLzY2/5p0ixEhOfzXhMdcMcm
 tLJyxYiUuqGMDKjqHUJRnmbrvvkYBEePwFJIkXsYAHrB4t1MGlefmlm4snN2Rsc0J+hp
 IVQA86ZTsPrxX1VpNzTq0yBwjdSr5UyTh9Hbxf5lOKofrk0A0Ihvb2KLqf0h/r4TDfW+
 Dsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=o4rtLAmx+ijbNavGtZtywsogMLTb6d4H4/FbXdq7dNE=;
 fh=OXyc7g7zGkuVcti+45Kc0Jph402z4kgnVJMefjzAAJk=;
 b=XO2qvphMhLMkSqNXjNO8s1fZ600VUgH+jJHEwShmTO5X5BEhMJrWi0hRumVXdfMA0E
 wCzfcBmRlL9soFM6+mTQ+7A69JslCtCMwBhKt6H+QfKZvZIBiTCAXFMnXW6GRpYjdL62
 WVH+Srxy93Whib8p1rXU9WT+Vp1XdE1TW3R9DhgI+FarQ1SJC/FpyxXm15oKRdI5hQMo
 TlCtbVaZKMq6bdAQso+3aQ/mIGIXGE8lpA1FKGROd6osbWdn8lLBy/WFXQnCU2RjmGKB
 U2l7Yl/+KGqZjW65IxqNWVpmjuONWf+mEUejP1McOHQQSDnk6ETf1+2JX/ZXIldsXmbs
 8Diw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792161275; x=1792766075;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o4rtLAmx+ijbNavGtZtywsogMLTb6d4H4/FbXdq7dNE=;
 b=RbJIDVPnI3eJxuZSw8bsataNjoU4hfBr1zdpm/+FXHsn/jA8ePkF1GkRviPeI3ifHp
 4KGk4Lil1h+LhskU7RCPgjmOkiJcsCnc3nQeySDTTwpLUQjsLJnwmKZRYoWB+jkbsg0y
 ICXDC+ge9qDHQMQBsifCXNQ/IpbXxAXBUsLg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161275; x=1792766075;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o4rtLAmx+ijbNavGtZtywsogMLTb6d4H4/FbXdq7dNE=;
 b=0Er1ekzYdZaOn2HHWkQY2RQq7hX6f1Ij5SlUdxgN839TOIlFLioJrdEQ+tydiph1xg
 e0x0w3ToxEycU48Y7K1Nl47MN3FZsWJmjvEu2uMc5IGd3qy66Mbeaw10PVKdpm7Jih9g
 pf622/s2hMcghuV4q2JX5eZSXGiWAcdKJV5FBqjeZ1IwJvqAZtUJ6EYprHsA9SfZnhHy
 3oA/kMeuBY1DygiWUIkUOiTD5Sa2EfbH61cqW4rGejkERiJliuTZoy9VC1No9LhweXpg
 Mz/tFILUD3sSq9OmyELzvYYiC3LAmynWXRxRDpxyOHg4Njfjw+qEQM8jwfDL9bvcr3Qu
 QlWw==
X-Gm-Message-State: AFq9FYJRLgGuyrWOoQcHmhmcFBEVKazFnfZZaITHd3A8e/O4H301V0Wq
 H25Ttr6SHhI1/UmfqIohbdlLxtjRtMHF8JEch2hXXWi72eUTgBkju4u6KUadP94T1Mrwk1vvbzG
 UMRfkOCBRbLRVJDXdF0aISaRtutwcLKkI3lqw1yLM
X-Gm-Gg: AYBFou2LGkJmORFyL+1YSOSqJyOKVRdooCrCnCgcInkPmC/eLWD7q73pG/9CRe2IvES
 0HFLGujup4uCOwwNrJUrgTCPP5lr+8FKb9WjY20ITvYh4G95l6Lay9xoTekT8/BlfKLc3tVavsn
 hE+9uUcDu/l1Mk1J1IVGLs2QkcTvL64FujMRGRp7Ax0tTryNxjJDbeHQnnY7bW80K8YrGob5nm9
 zMFV3y7mTGy3BmU7cYmoz6ylQOu6V1CJhH4JFkL2uJrRTHSWHM12ApdUVJBdy/gnF045azpSn85
 foKwldF2uz2PC5H2K7OVI9Lek0RuogTWjgVzlxHptmr2DrgmKDEH4Q==
X-Received: by 2002:a17:90b:2e90:b0:3ac:8897:7baa with SMTP id
 98e67ed59e1d1-3acef0e5e65mr20890a91.40.1792161275431; Fri, 16 Oct 2026
 07:34:35 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 07:34:30 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 05:59:27 -0700
MIME-Version: 1.0
In-Reply-To: <20261015111328.1269775-6-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-6-bin.meng@processmission.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Oct 2026 07:34:30 -0700
X-Gm-Features: AclHuK92q6lLlEnpkxc5f4co_mxCoWZKDNvCQ8-4jSmG362CbXAQpXI1LckD04w
Message-ID: <CAFLszTghA-CEXD9z6yEOz7HzjycFhN1a7rW0S=86PDdOuUt8Og@mail.gmail.com>
Subject: Re: [PATCH 5/8] virtio: 9p: Reset the device before releasing its
 queues
To: bin.meng@processmission.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>,
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

On 2026-10-15T11:13:15, Bin Meng <bin.meng@processmission.com> wrote:
> virtio: 9p: Reset the device before releasing its queues
>
> The 9P remove callback frees virtqueues while the device can still
> access them, then resets the device. Outstanding requests can therefore
> race with freeing the ring memory.
>
> Use the common reset helper, which waits for the device to stop before
> releasing its queues.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> drivers/virtio/virtio_9p.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
