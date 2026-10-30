Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66869606A31F
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iIIZGnVt;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ma1sXvae
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 396B780A06;
	Fri, 30 Oct 2026 12:47:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ylMxJL8AWAow; Fri, 30 Oct 2026 12:47:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5A9EC81092
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793364427;
	b=KUpHhmSQ5equSYdLYfaLpqrKkihXbrXb/SLGIvBhsTyc/IJBFfQyrRKyKo1leZJGedFj
	 YSIPO7fnjeVd96zXuKFByGPE0TjWGhyZfH2xosnN/eYijfb+pXOtHvlWrbBNuEnl8Nh7h
	 UNS7igS0QsiMrJUC+wRlam5cn5QRnpdq5p9Mp486qKLGcxb8LDXQ65tZ0n5BbtHwNsFzu
	 Q6I8tBIPlqSCeWLumiCuoCgjejcL1Ze8XT3kWLJOw6XPhrPQzHQ8JQz1nHzTpETQxYrPO
	 iG9zxZJzm1s2GHFYvRrYW+4T/OuBrLpqTjwpKaKKwSKI+Gq2VeM383bkJyKfAwNOJsQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793364427;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/4T97wihfQsIcfXmyIARZREdl+D43+Ij+t5bQ97SgUo=;
	b=Y7M0BTJJbKsMhxw7ye5d8TCJReJyp/kyDauWkFRxuMk4wgYDEwv5tulem8ck04hRbD/Q
	 XoBDTT9OkzBi/CSSm1F4/kprujq7HDBPdZhWjClG6qXAzRT/gkPA8zJH+7QDULjiiqMms
	 726LgDyhrkokLL5Vm2SelO7Ul2LXKrKdnrDOUqtLvElfqEw/W/icHUwIDhRv0Ko2Qx9tu
	 tlQJqzaPo3egaS3utUYVv3UL1hMWWx+0QW4yhW5AoEfG3011sQmlGGroHVRdEfMPfZpRH
	 HMue3gCBQUHnjkL3m1lk4yxSXQLNZR5QqNFPLOsegvoQHov5C7MQh5IkduL/sBNpQpA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793364427;
	bh=/4T97wihfQsIcfXmyIARZREdl+D43+Ij+t5bQ97SgUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iIIZGnVtoezNlzx6qIIlIg/lu00erNM+rEpaES/jgOuRnZt/i7iea7oGgksw3LuZC
	 xHaH3wTwf7rr71XXnTHXO1PnOitfDt5x0NElBxaiqkVF2e6sjxjWF2nBuFBGNlKjye
	 KHfTfuLbMrSq64pa/D/y320jT0INc+Yry4y3d5dnee5Ldg/sXdjJUbzksSFOkNWHcK
	 TwNAjPHBHV+n+n5ROXnQ8pIq/Gr3Sh7en+O4L+pBvXPwCistHrP0ZgYO6eLMJd8274
	 foRcUK61X56hqT0kfrVf6nhME0C/VqV9iJpYzoFGFsCo7BSKi0Zf6ajjGQtzKbBCt2
	 W4wst+mAWVDkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A9EC81092;
	Fri, 30 Oct 2026 12:47:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 89B4A529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B63840ADC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:47:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sdxQ6265Cr7L for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:47:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62F3740ACF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793364424;
 b=q3cdqaooXnBQvu3oixbVgTWqTy9jNmKDPcx5SwMJYut+m+vG/J4vsIcvGccGR1WbQCON
 qYajeDAYuQs+FW5l7k62cw2SpOXX7YLTt9cCYZMGZrs+RFOL2M6brE++wFvezlrYtF0TZ
 B114yXGZGn3PwPaJ3ExTUxDSsF8NfbZk+bgw5C7qIK80knBJzC6VlwHFHKYVy5iBr+JF1
 UBad6XqFE0dMrz433uh5mz3SnenV55U5XJkKwBzsQn9+Dmq+vwPfrzzSWU781ws7Mx7pO
 PgKQu4VKnVYsMql6V8GHQgN+gFffa63+dqaRMRoHIQ1cpwQpcdIVpAFNy0DZ/Hto7ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793364424;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=/4T97wihfQsIcfXmyIARZREdl+D43+Ij+t5bQ97SgUo=;
 b=PvHGmKvKepA4MSxYYSyK1iUkRcAP4Lx2GpBJ0UvG9evVQhXGPzc9IeYU/kim/OiPtldZ
 f9MtFxpKoiTAebKvLiwBL5b8F9mpU+wSO+NU4L4fpFbuBXNz9mZ6eYmgo8ExmmZKPJdS9
 pOY2wPBKppBCZvBLM9B/oOB+zzuo4RZz7mInhv9hPKfAa2rvl2iDJodHH6sjl3lNDCt5Z
 3AhQnYuM4fBwh9rMlqRlUGdsKaXq6D5JeZ74T9IzFnwg9HL/POk3LG5w39UwW8Nxwdsji
 qfrc+1+blJVfcPQiFvZ3TZkOv4JS858naaThgpO31zNUEDx1ylsn8agAeFoJK8ttYhg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Ma1sXvae; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Ma1sXvae
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62F3740ACF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:47:04 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b05bf699easo6101617b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793364423; cv=none;
 d=google.com; s=arc-20260327;
 b=OVc/8JcaFpu3iDrt7fe0qFmfF5rCEee6nXEnkTnyMhdKveptuArlPqi0wTTns2HKcV
 1XNL7cxRi+7Me0BcgFifuFmHfk1/YnvxnDC18y0049VpoxMciiiLMX+yBHQQKupI3wwx
 A2mzNBFiFtwhn8Z9bfMUW1L8V0/XY7n5evGgGUKuuRS5VaxMnOOwXtfQplrCpx2tQRLu
 5nS5nonfRdCaEnIQDe/ttHZFuB4ahlLXOiyMByK+3A/9ouS+NNQWhWkydrwLmPsVcPUD
 hGWxNlpv/mWA8BCJcptpCZA2ygnM4M/F4+gU1exvqVFPgFCrnm5Uk79a9rGz6vMEbF2v
 7cOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/4T97wihfQsIcfXmyIARZREdl+D43+Ij+t5bQ97SgUo=;
 fh=OhOSfS6mWstEu/irkSxD71iDNWnMeRBAfsy0D3wuTYI=;
 b=A6qxCeHsTdA3XWaWw6jbglECfgjYKfvY7Yuz1HTsHPIOWzjuuAc457TKMdg6V1R4yZ
 RbyMf4vH6nZsPFhTg2Pcm0IC1najWrEB35OtyJ83HWO4LfpkRmPINXsf+M47LnDVz44+
 rf0D1AXwTSVm7ygDWl6YUT48CysInfCXVtIs6qC8ovAzKbKcMxed+sHWvsd9BpAtluT0
 kTTjJL1/62IroR9xuK4pB6qBhqs7tbejZBnt/SWzHnvPS5uIHWEcIiDFUi9lDlhP4Yp+
 f0KU3qCpHJTqb+g6gM7VjyfKoCyCIJxA4J5ofQXTDKUfV87VK/9VSCUKw9aLTP8ijXRb
 OicA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793364423; x=1793969223;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/4T97wihfQsIcfXmyIARZREdl+D43+Ij+t5bQ97SgUo=;
 b=Ma1sXvaelf2O+2AhZCQ5yXrvpWpDv/h26eIgcjJ+4lvaGRd6M4vJgMjWJjeviYZXcA
 /PD8tKLCemLxLVctTTB57sVpoZ4VTJCL3YeB0XtqMmIjabwWEBerGFkSm3q+EcBuaz4B
 sU3+UWzy3KUPNyuCIRbc81rt2Hyoqtof2TWQIdm5aKiMznIzfUPQJsIk28QcN5FB79dq
 7XhOpSm+8LF9zwQZh5Bg85KVD2qeH0Yqfq7eNTq/Kl85VOJKkWYYRN/AmaIoXd3kRolt
 zooWFcqhhdYbfE3V7JhPO2FpdF+nqPrfccJBK5qEUF9T6xCeW1SBwpHGwSXu4TIuW/+f
 T8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793364423; x=1793969223;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/4T97wihfQsIcfXmyIARZREdl+D43+Ij+t5bQ97SgUo=;
 b=u7aI8EfOjXh2h2xWNUY6QIN29TSsBYMMeeGGthNiRsevqaH9ajSZuWhWQ21az1O1DJ
 XsTMZ/9Lx8bM4sOnIW1Pe5eTqTZUXmVboAbbDi/vOjyOZXoLIQaDy/bBwtzlyxoJiuoS
 rd1CTM1XYd1yXDwlMOFXa6bmSUDNA8biRA+RYCVVE7fPmQaFcKsXn1Y1fceBz56hS3BJ
 35lxK/geIinzmA1WZqN4Nf01iBtI8j5YDkJGkOvxqux5FZZfgxm2pQ6NGHX44buOmcTW
 nnobsrzY24iR9K6+t+Q91VMDu9VVsI5+ASupPusANU7J6C5KFSqCFoJhZaz4qF5RzluV
 1uGQ==
X-Gm-Message-State: AFq9FYJ8MKKYMU6UcYBpbKuwPMo7riXcQIFNYEMcVtyBj7/rNwe+Hqq/
 L/A+kHYqseB1KYeLQbJ4UQZBdQLCcSpACi4hHLtYUq1yg0EnbQdfMiRdgPnHCIMCmGrHm726GdA
 UzdzXVLFsE5KaR4SFlQDXGg2BoRHNrwPvz5BUg7JEOw==
X-Gm-Gg: AYBFou3s7gEr40PsGl1VX2mHnbBCQVP2S6oLEzyNybtXWLArYfyibPp1M4MWnb6tYN0
 +8nortrwy+LKM1KeNpNyaXkIWsS2xU09NlOy5C3t94seh9kPkTLb9RVos/jeBqAEMWFAjRV2jOa
 amuHMqCYxOk0FvVI1Fk78LnJNEqgs7bomOI7Z90s+6HGjrDHOxhf7Dm1x/xGgiNxPmeoFzcnXZ2
 2rOJfB39SwLZCzajaq6HJFpo61pn7rS3pPi8enaVyJAG1/wxDANN4fdlyJpRVa7T9VREqHl8Lki
 jyAYpxrVqtEDA5LsgMEB5R6FUsLBXGp+lxjsx6hxal97teHVNmUalttzULXovsgsRaefNTA7SIU
 zjrHOceybsyd9eBrrkypqHGwX5ThsKYgW+JnMuLGekjS2zceoRx2gpQCBc7pcrKzKDGR8Bw2+1N
 7QY6c6etZIIDNPX+ECHtz++/pOlriwrVt228DDLFFol7BJVdhbfldlUksWQ1Dxp/xWBANWrgOhC
 uAJwB3QlFFefpMimqLpzTBcXclkIjaXMtZEjZoFPiRmZW7ovmrTW4cyTjed3vSW1Yj8PvTIvYEt
 eV6UzsYRw1rRpoBHecJP0vGyKDk/At4STEmnxdDYmYITbDhgYNsPJPLhX9WrOwzFPHxJvdMQKTY
 pnDrj7XMvSlzJLMLAyIB+Nj89eX+fCWxMk7JD4t2LhspoH28UNanJI47pUyHgQC8qXaSyPzJgS8
 Donlxw6+UEjVvBeHkzeEGRYrYTap+Pezytmck=
X-Received: by 2002:a05:690c:e28b:20b0:8b2:9c73:95aa with SMTP id
 00721157ae682-8b2b67dfa04mr8929597b3.68.1793364422768; Fri, 30 Oct 2026
 05:47:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
 <60ff1e72-dead-4ab8-a1a2-e6dfbac3dc91@gmail.com>
In-Reply-To: <60ff1e72-dead-4ab8-a1a2-e6dfbac3dc91@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Oct 2026 14:46:26 +0200
X-Gm-Features: AclHuK90LHX8M78iTnj5zEk24gnbO8YrplWjiHsVR3w9-6-KzqA02PNOJicXEYs
Message-ID: <CAC_iWjJ=SDj0NDDTvJXjcv1DRSEYmNRgDszxBVFfVZj6_Oe6vQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] efi_loader: capsule: check the capsule header size
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 at 07:49, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> On the capsule on disk path, efi_capsule_update_firmware() is called
> without the header checks of efi_update_capsule(). It only checks
> header_size against the size of the FMP capsule header, so a
> header_size smaller than struct efi_capsule_header is accepted, and the
> empty capsules of the FWU multi bank update are handled before any
> check at all: fwu_empty_capsule_process() reads the image GUID of an
> accept capsule at header_size, which may lie anywhere after the
> capsule.
>
> Check that header_size covers the capsule header and lies within the
> capsule before handling any capsule, and that an accept capsule holds
> the image GUID.
>
> Fixes: 8d99026f0697 ("efi_loader: capsule: support firmware update")
> Fixes: 86794052418b ("FWU: Add support for the FWU Multi Bank Update feature")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_capsule.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index 54c118736cf..e8835315e86 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -445,7 +445,14 @@ static __maybe_unused efi_status_t fwu_empty_capsule_process(
>                 /*
>                  * Image accepted by the OS. Set the acceptance
>                  * status for the image.
> +                *
> +                * The caller has checked that header_size does not exceed
> +                * capsule_image_size.
>                  */
> +               if (capsule->capsule_image_size - capsule->header_size <
> +                   sizeof(*image_guid))
> +                       return EFI_INVALID_PARAMETER;
> +
>                 image_guid = (void *)(char *)capsule +
>                         capsule->header_size;
>
> @@ -544,6 +551,11 @@ static efi_status_t efi_capsule_update_firmware(
>         uint update_index;
>         bool fw_accept_os;
>
> +       /* sanity check */
> +       if (capsule_data->header_size < sizeof(*capsule_data) ||
> +           capsule_data->header_size > capsule_data->capsule_image_size)
> +               return EFI_INVALID_PARAMETER;
> +
>         if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
>                 if (fwu_empty_capsule(capsule_data)) {
>                         if (fwu_empty_capsule_checks_pass()) {
