Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF66606A336
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=06+G82jP;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cdqDBSMX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 278F940A6F;
	Fri, 30 Oct 2026 09:52:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O19VtmaPNvCg; Fri, 30 Oct 2026 09:52:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5955C40AD2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793353970;
	b=Mh5deih3u0qkMPcHdZhAFQp5ZoBLc/4sUuDdMf3uDLLnYJI5dSwtNBb4c6ZtTnxf1Mv4
	 OSasrTejzDbfPZNjq7Wp2PJ/H36cPtuwuqzXh7jOqtLq4Ygntcv7i3B9ugN0eczt2e0YE
	 OJcJzI1eYPSi8+zqzVwqF2kZ806UMznhSewh3Lc5tGBSgpK6rYfGbtWyUJc2BK2yuIbUV
	 +sGRvDGm1Lk8VRMAmaFyatta1gixFKF195dtIVYb5aFsYpDHJ6vgV2MpLDSPWLN3L4DPc
	 aid7IYR4GCcDz84VdmDVQlz6gZuhJl1DIMQfBtarGh3Tw9phbngPXtkixYd/QQcPr0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793353970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PkZ0R847VjJ0g9Fy++LnV4j5ZWAHXj4QpdHMJyogHLQ=;
	b=RxGxs0AKMl+xlLWyvYbCB6Ofs3Mt9d7ZDYl72pG3DWaSHBRYcH5DruR3lqAJIvqN5nrB
	 DSb6MTpCzk/RhpAmWIfqCEeq9k8ys4TbBPOHmlWDywtlT+MzdXSKkVrpQFGjg0PTzCecy
	 isY0NEvsVumQo/9Kvy05dmE8PyPh1aLvJ1ufCk9bnoyt74wY0v6SZwaF5PTWLyc24X+nC
	 OCCwiDxyv5skfsHlog+yXn1AqYkifa0KxNf6GP/WzR6JbmbTbiqi2qqJXgVBwHr07TTBy
	 FPEXOUDKKfzqCfUxtDMQ5pUsjIIr7jKyWHzIqrNYmmx7u3Prit4qZO+bwDH6I5Sl9tg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793353970;
	bh=PkZ0R847VjJ0g9Fy++LnV4j5ZWAHXj4QpdHMJyogHLQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=06+G82jPn11Td+kmbL3R1FDpn90pkDQpgq0aBZFTLIjda6ov2atxWd7FiWJjMNe4S
	 CaDN09v369Lf9Q8NAJdOr+zdJr5s9sQYF+9f1CpZy4XZuY92v1c725yKMB8ucpwFmF
	 6+p+GPYYaHuWVhqvSZ1AL61IUW+t3YBGLeLpOeyjJN7wgnt1ZBXhuBI6NWCNcvuoHE
	 Wx+JIhvJQp6/aLFanPbu9Of8D+ZfcegXDCOUbjaOYGf2kglKQmPTL676vriVIWuSHs
	 dP6y5qeyx7xcPGvV8iUXoSqmO70ORwNPAVi3TDzbZEd0FeRo/M4VIEBTjBp0DIxn/m
	 Z6zwfvADynyvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5955C40AD2;
	Fri, 30 Oct 2026 09:52:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B153D3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A31364009F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:52:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jE9Cz_wv0E7a for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:52:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9002240063
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1130"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793353968;
 b=gypaLnWMXO0xhGlvdbaJ8OWUG4ozmnlzi2qa1b9rY9D34k6WJdewl5QIkRCalJ8q07Ct
 koXWep2ge002tsIT846TM5pd21GP+EuQy6PYYfRYH9dRF/3g1Mm4SKIkTnnqKxZokK+LP
 y/pGr4+mu5r8LRr5mROeZATSYt0uV1Z5hDjS/y8xk8mBipQWiUpfTwGxpuTecxPj0PBd1
 wBwUHo1YyLdinzR9wj4IXyhWWDGSRJdn8ubM0N1EQ2JZUCm7aZzcMKBzYVfIOK54tX1w2
 hm1r0TPfFrtPKPY+Bdjjdi7PzxdW+eutJJXpl1c9h7dlTf93fxerwvD4eWu2HyriepA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793353968;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=PkZ0R847VjJ0g9Fy++LnV4j5ZWAHXj4QpdHMJyogHLQ=;
 b=mJLQXrtjEPDl2gtUM3jiVqKYDMEwNWmFn9bNGnVlsOW0WmJC2Jb076qFiYVJOGcAr0Af
 cnaUTp+1WUSfhiGZgjOy2WzJR4D/BFt/06cND38F9/ermbC9CqFKGlUXnVNZh+SHuG1xk
 0hnHnR9h1+crTcwuDYguJ+dRdPY4Qkk11/Trd5hhhGFPXTAEMA4lAVc1qbleuzwn7/eMA
 iDbI4NQo1ImeFpV560mUV2JmgMCoC1XY2tm0FozKoYH0MTO/HezEnxyecDgs8AhcphtXe
 759zcM85SaMgCU5nDiOYSERakEkZh24/B5L7OKrP3LUPUd30O7udGvlXe+OVYYUJ7qQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cdqDBSMX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cdqDBSMX
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9002240063
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:52:46 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b12b1ee403so3036257b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793353965; cv=none;
 d=google.com; s=arc-20260327;
 b=ihdNSeAaCTrHbi7/zLjSZVXHgP9/pss9C8fz9DdGjR/Om7Gix7Ydcxf1YgXao40afH
 5UsvcmdzuPYTBKzVIk+XChBUZwlhOy1sJJiWdJtU5AJBGap3sMlllwqFF2CAwKD1xcXY
 Aut8RBCjYKfXyTHDAYDtCEQLXJKoYdkoco1KThMiljGnaDfiVABHh0H6lZiLYkuqeb/n
 5Pg0wkY2B347k78c7sdaHnlVtpEY21noTzSJ0ZbobtLB5OVX2BXqPSwjgLxWvo4zYK1l
 qdlRGC3AMBvPJAHvrsLxyQna9Tf5H+FIacS/ts0pOzur/RMmF6ENnQ/2Qh9g4vYPrOom
 +cRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PkZ0R847VjJ0g9Fy++LnV4j5ZWAHXj4QpdHMJyogHLQ=;
 fh=7QWwyUnPAQm5WNln6yz2UnPVMLv30rqCuNC8nkM6bR0=;
 b=oubu/kaCIA1bB4zyEPZDpE38PTGiqWmiYO3+X9VxRSUBQ6+MnRu2eRv94YSRwmYx+D
 1WElrPN7G4cKdyz0hb1FNqY1eEfcMFB8GyT0MBR2QCN5KvbtW9SffVlQ262jqzgl3yk8
 65FIMYygVj8sI/ZsK8Xv78XH1pBogAzjqNK0deHzBcFKdXgkg2iFJJMPno1hGWNEpC6T
 a2u08dSPTTsV+DOkcw0mAAzeTlAACUdthIpj+6d6o9+fYQW4PN/Mw8R69516oROrhaxn
 kpaNgtj6v5xX7rU0/JKOh/phH8d5na7NmjscA0Nxc1kVb9xlJ8c0eHE0fMFsbW/ZfbTf
 OH2A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793353965; x=1793958765;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PkZ0R847VjJ0g9Fy++LnV4j5ZWAHXj4QpdHMJyogHLQ=;
 b=cdqDBSMXuS+xWo31g3hmlVhICv3iP6JmEQBlLBig2yNxz4eP7OK7awuXIv7A5kGxMB
 CjBB8xULgY8WeuoCG0kkiMF0izt8x11AgpolUsbNpr6Z+l8eymYqilwU1jFa6srykwnr
 bBwo5U68puAxAxDzP8iwFLi5AEjdSZ/7DoQdsdsOYLjXdfVhmlCjSn+xde9N7r83YiLt
 nawxH3v8LbR9KNiDEm+9KBhE93PndGzYWpstzZ1MCqC2x8iOKs7MBIChMZFGgGgH5gvY
 FNyIV9UTdz33vGVYpC4C0aQK5OexOGeBCNrzIX2JX7UqM1inllFcWmOWbFpcWXRjpKxI
 5KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793353965; x=1793958765;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PkZ0R847VjJ0g9Fy++LnV4j5ZWAHXj4QpdHMJyogHLQ=;
 b=dwCtarfi/TMkMENOFVshTYzo1nKt1yMbEG5oPj0qHeZa0UvTRkVByzIQWZHvN06sTg
 mydWEfs7Itqt5PsV3Xi5/Fk+aW0Kl30kM1fNjwlxQBmwgeSt3qLi9fTMNL4OGJTxOlJ4
 YLWRNQG1de4oeeBA8BszaaSsIN7CE/WtzVAaMHjYbQkWO6EVNsLGPYVkKGcj7YzNJf62
 LTBQizOhex1n3lwnaXI3QKcjDfz/nY5hHQnglbdDDtjE3p/EUJV2WPzaTknjNsAIlFWA
 CHHOYDmgddTghi1JS6TQOzkgotps6Z6Mh5wNWMRt1GxJioO+VNDRXjvpRNVrW0FjYC8Y
 413w==
X-Gm-Message-State: AFq9FYJhwUtOGJvTood0UlWzMwxpjYFwwimlBLybSe6LdzMChkByz768
 rzpTwZnN1REUfUeREhUTbVNxO8ruH/Yhn5mrDcXNVFYwlfWBWSw9X5jdJs7/Tt7yfppRkr9c/+F
 VZI+X+DhKRZlD4a6p8bkBelqtgGtCDLKowhVpTJnitA==
X-Gm-Gg: AYBFou1UyqKlMYBY3gSOML/WGQlpoo7doa6z6qUFtzEfxHngD6rG/j/hp/lafcjSoda
 O2eYH2Xh5TjW9XPltrOy4m3f1QPqwgRPSbscMualgJssSll3fRg0/Rj00dJ8gNbgP1LaRjShfJD
 b4EAqPhmj6z5VvkX3giX0EXTrEh8vmVlAXJwHoMmY8LQxs+UkrOprIrAUfyKO1P34Bc2usZgPCs
 9sS3dw3MC0Byh4MRU2aHJyYMFwd+aPmT5RMwpUcKaBB+TKwS4KTQifDiwntO2sYRfTxuoty883a
 hYz6QutWpnxje/DHNNXnhpujPWthSVXtlO2HZ6GwGLP8iALB177n0ZjhumV/guWnZzxpBeTXJIU
 g5SRgSHPf7iirUF9NPv4Ut3fFVF0nE85SD91SJo9LdBCa13fYwZGJlA+3ISY8ytpd9empCfiJcC
 depgywyVPb73JbesIw3maRD3G+7T0mB3/w6P1g4Xtn0iwjSORIBMVMzOW0FQgu7DpOQ8QxMGlut
 rekSQ0UgGDZ3k33uLsNaBB7zME95CrVC8AIgyDMhkG6LCM54fxT5lOLgT8QWebSnfPr5yHEvTDK
 EiTyqZVkpPrQkNhMi04JZyY95+0xdyU1RdUr5kbKT+yajN0YKU6eF3QE3PpSo2w4+v4vc1/VR8x
 x8mLVN+au4De9M+waisjQS31NWYSj0cUyiDa+AkdQ4nXXvwrYM/iCe+K/JxmYewD0u3KiVQhmKl
 pWHIVe+9D5ewXYiVXAfF93eefD2DVkecCDnpo=
X-Received: by 2002:a05:690c:800e:10b0:8aa:5af3:e420 with SMTP id
 00721157ae682-8b2b6710f42mr8347157b3.11.1793353965234; Fri, 30 Oct 2026
 02:52:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029150906.1558380-1-tkirchner@emlix.com>
 <20261029150906.1558380-2-tkirchner@emlix.com>
In-Reply-To: <20261029150906.1558380-2-tkirchner@emlix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Oct 2026 11:52:09 +0200
X-Gm-Features: AclHuK8OhIzFoGa6MoLzSGcElDjRBKuiN1_6IW5dmrjSHwJu2FFCS4WZCgGECqA
Message-ID: <CAC_iWjL2YB1wvXTx+XVcDTnoSD+TWj=H_UyUnYqyOneWOU0W=w@mail.gmail.com>
Subject: Re: [PATCH 1/5] tpm: check allocationSuccess of TPM2_PCR_Allocate
To: Tycho Kirchner <tkirchner@emlix.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Eddie James <eajames@linux.ibm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks Tycho


On Thu, 29 Oct 2026 at 17:09, Tycho Kirchner <tkirchner@emlix.com> wrote:
>
> TPM2_PCR_Allocate may return TPM_RC_SUCCESS without performing the new
> allocation, e.g. if the TPM lacks the memory for it. This is only
> reported in the allocationSuccess field of the response, see the
> TPM 2.0 Library Specification, Part 3: Commands, TPM2_PCR_Allocate.
> U-Boot ignores this field, so a refused allocation goes unnoticed and
> the board reboots into the unchanged allocation over and over again.
>
> Check allocationSuccess and return an error if the TPM refused the
> allocation.
>
> Fixes: 9d2bc92ba7bb ("tpm: add TPM2_PCR_Allocate command")
> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/tpm-v2.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 4c7dfc55650..137bbbd9593 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -596,6 +596,7 @@ u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
>         };
>         u8 response[COMMAND_BUFFER_SIZE];
>         size_t response_len = COMMAND_BUFFER_SIZE;
> +       u8 success;
>         u32 i;
>         int ret;
>
> @@ -642,10 +643,25 @@ u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
>         }
>
>         ret = tpm_sendrecv_command(dev, command_v2, response, &response_len);
> -       if (!ret)
> -               tpm_init(dev);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * The TPM may refuse the new allocation without returning an error
> +        * code, e.g. if it lacks the memory for it. Check allocationSuccess,
> +        * located after the response header and the parameterSize field.
> +        */
> +       if (unpack_byte_string(response, response_len, "b",
> +                              TPM2_HDR_LEN + sizeof(u32), &success))
> +               return TPM_LIB_ERROR;
> +       if (success != TPMI_YES) {
> +               log_err("TPM refused the PCR allocation\n");
> +               return TPM_LIB_ERROR;
> +       }
>
> -       return ret;
> +       tpm_init(dev);
> +
> +       return 0;
>  }
>
>  static int tpm2_get_num_pcr(struct udevice *dev, u32 *num_pcr)
> --
> 2.47.3
>
