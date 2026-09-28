Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609DBCA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD84580C3D;
	Mon, 28 Sep 2026 22:41:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2jqAVZhRor2D; Mon, 28 Sep 2026 22:41:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F00B980BE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635317;
	b=cRdSBK04aCgf/bJepA30uwEzi/RbXEAKcWHxsqA+CZweVsfhA9iBk5MJsmy7ElgR6LCV
	 CohxVvyxfdTg3DA/59OriQ3T6hWTQwG/x+7Bod4wzRAxxa1VPI1+yM77n2IXUvr2rWcgA
	 STuXmnFXmc7mj3HmMvU5yD98D8/qD0P4Hfv1q1G36Y1EwYMaV5HG5WByZOQSiGSLkic+1
	 WaXxBmfTLzt0cQZxqkTo/H6XENJ8uqz2fELzAw0mse1pQfD84vwW/Cs3bl1N+NiisPDL6
	 u9Rnq10azfTlLbVgp+skqCUsfMX6fk/V6LnnrbU0JpzTJC4MRzi6UKP6sz9nz92b61A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790635317;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=t2EPcbeYVTZgmiUiIUDp0n6xP6x8OXKpr3c7AohSn7Y=;
	b=G8Ygf6QASLeYDZ4Q+DfkmUReE+diJT5KAm+j+i0tZgC8O/cqbpEGnY0Kb/6iLh0xg/wt
	 hiiplXMXoOlafbTo/P6/MrHFdd+2nfd4fv1PBA3vbx0z22cj84xvxKhcP+qJIBsJiChux
	 ByD/bD46KEow7DLefg7RNl4EtQTuefb/zMJG3phovqW4UUGIm3DKYpLyenzPzL4BR/jPh
	 1FClavd3ik6vr0NyoZiYJ/S/aRqn6Pl4HRTrCCRNk6OWP5Bk1gW+VXKu/wjPQyCpp6kDr
	 dptAsNaj+jh73mKTvc5ERs187CxFG/VhduOyXo6JX8VHeco/ygSSOKLZzrVUhQk+m+g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F1XMyan8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790635317;
	bh=t2EPcbeYVTZgmiUiIUDp0n6xP6x8OXKpr3c7AohSn7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MggY0cviXYgzXduM9AiQtKYLtGH5P3w6Y9lmFlIJSfSwZQMmkPedEF4Qazl5WiZed
	 KcsrxzSGYbTClsd7jpcDebMSPQRbDf33PMWNXmhSH2Q4AERxYBHGZ2OWuc27krvpx4
	 Fv5kyju41lPWTLGWBdQLe0RBnWddb3HKY58gFcYgyuRTttbv7VeRZjOisWHRt0xxaJ
	 lxua054LPf9zQga4349lBMjKyYzNI9JBzJtBVf0Mo9r5uPDA8km3+5v80EPKHf3j97
	 x+7op4a393BrpvV5rYqG2fHAOpOgwb/tux5zv4cpEENE6tbIXgFQslMzxV+zhXyHJ7
	 haEkIZ8sus7Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F00B980BE8;
	Mon, 28 Sep 2026 22:41:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 58635335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47AFE80BF1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:41:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1wlyIh7jUNK for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:41:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4CEAA80BE2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635314;
 b=phtjNuy3dso+bJo2bonBvBBeb+jXdTG7NSJ84frffQAZy4sFVzlJzMA0dysEKfvOtKLO
 RPHfiGxiJ36GvAy2jR46l34GWsRPGGWmb97zpkDyK3l6OsCjZHjfT5A94EbbEEAwoM/Z+
 vWIPempm572+03yopqkRrugdjW6Fmp69pOYRIpCE6DPSxz6pkZqdKTY97HzYVH5U5m4X6
 ZPTtKYZ0Ym17uplySocpivMHCJS95gs3ilH82JAvGpH3PVZRB9DOGUVkGj7mogXbuvu3C
 i7pHwJ6rCgg1/s2bg3404CtdUJC+/ethHqQfCo7fQ3Bhy/TBTvYjmjwBKdMiob1wTRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635314;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=t2EPcbeYVTZgmiUiIUDp0n6xP6x8OXKpr3c7AohSn7Y=;
 b=ZqgKknETE/HZXLXAfeL7Id/TLDwIwJr3Rwe1EdL3MpZroM6gsCMDxqDMBDfp2k12JZtx
 v+oCVnKPLU/vpQtjDH4uVQ/nEtmcFh9Ks388HMgJAPihnyKCD4C4qW3QJ0Mh7iIi+7bwO
 I7QyqKCQ8j7iME0vcTcwq007+DL8LJehys2M9tgBcf23NPLjWymTjqNFmvePdCYKlAbUM
 YWwYP9vF2aWN7ih7Pxie81zhJAALCIrS/DMU/BM3LN9FZWjS3+drB+tkb2n0EOlVezlLR
 maZeV00/3PLtp8OJRnwYINtLitftUrK6DOAofdXbQ9uaoPtYKJcH8r/oti5nTV7bXGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=F1XMyan8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=F1XMyan8
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4CEAA80BE2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:41:52 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6abc27842b6so3460670a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790635311; cv=none;
 d=google.com; s=arc-20260327;
 b=LbudcSz/msX8/Hp502E/dyyywrFsc9+gDIJh3SjVnGBLsrKEJg2mJOYMt19wqHXa5A
 6vcR+NV4wVUd4SaGAcURLs4q3vOrEsZymxhPLTzO6b1hAv2V/DaVHYLnvxdON6bLp53j
 VbXdROqwWCy1V5WcAXZTWXRy2L1I67bfXUSXgci/L59JcLOXDTHzAOMut2uWYP9ypTrP
 +6uDL+l4fuMOY0kWZSSpKkyQCO1pAZhqQ9IhqOf4p/xdnUM3lUa7oFNCq2Afp/Pw/3Gt
 QG7/cRQI5tFHbiFHoyltDbgb1flugB8x7I0eY8ftgw+rGEb8JAqJMQYFNghcx5LQDtlf
 uItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=t2EPcbeYVTZgmiUiIUDp0n6xP6x8OXKpr3c7AohSn7Y=;
 fh=I9pAqm+9cfODlHMltk6BNE0sLr6sP5gNN7Hz8exSDdA=;
 b=QiLkPPPpnW1Fky9grWzi6q0G12kbNi74hOIE9UYIPq0uJCQ1KR1Hd4v2ylDRA5gr7/
 tEd9NbDodsnaXBCADWX5zU7/YfacjfcG99IMna473qtcgyDqiGcathrxU7CZvKG7uglz
 UJKckyFi+mSATKpEnpLF87KsWeoNpjvC5IOGu/D1LZ9Wmh7Ch/QEc9PoYnYSwBhhe/E9
 w7K4Fdo9BA83kovHYddrEr7ZAnC1CRdfxy38iy44187DFkI/Il5JpwbMgxfNy8K6yuZo
 2KM8SNyID+l57jcdXdk2cmjU2STvcKHaA1DPCJwpfqtdvKgu5t2e/hzU+waK1F/6Dzsy
 evPA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790635311; x=1791240111;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t2EPcbeYVTZgmiUiIUDp0n6xP6x8OXKpr3c7AohSn7Y=;
 b=F1XMyan8ue7InfIOlLXof36nRtaH8/Fq6zasu+FHoq90A5oYCFwxJS1ph+JAw2h3/B
 rpO81nPWlEKHIU90uCJWyivK4Tx52opwqCv7J5wRE2WBRfrfHTtKb4yxbNbNhoyZQnxY
 v8frGIMVRFxbJUnJVeVX0KBqQq6xFsAzNT/0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790635311; x=1791240111;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t2EPcbeYVTZgmiUiIUDp0n6xP6x8OXKpr3c7AohSn7Y=;
 b=CwQCfcnzXZc9r97AgwWfpnM2JgaaFXs7w5qttAct9Ks2+s3uJlVRRB9w3iGR5gHxQg
 M/4PGdUbi8MI4XCOgHCujkrZn4KnsDiCKlVulodvzDQZhx+mAIgL5b5iHWXnZITa8umg
 f6dDjIGvamyXz7SemwzjHT67hhyN4sIYCHrAtqM4vmN3NFNdKW/0aKP6mNaxmpURSM+8
 ZrFizE1AcW4t1RuriZ0ZjNdj1/Ed0D0v6Sbse89Y2LMKsLI7UiaFK2Qtn8ZUjGxT2+Nm
 2WToyrE3XMwy4Uty0Te7GPLyintokPrh1TN240TI+4/3zbzkyeAuID2O6dyS1QePcVov
 s20A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcP5Oz8Ke/Xl7MpJ2FJ2jDJhJN64Rcb0MOEP1BH5h4ZeWCYVfC9aPUqmUCLCOmjlyfbJWiEyQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ4kricMv7hVt9yYry9vUF15egdnDp9SgCPEYAeLrH/HVkmiiv4
 E18+4DEpy+R9CeCdn6jZSr8vPlEhOOP5pc1B+HrOTnlADpHXjMuregAnA/Ul28wJIpbZdUF/D72
 2DTw5Qe5eijNovdlZM+88PF2aT7N47ViA7brJLDYT
X-Gm-Gg: AYBFou0x9jSUrwBBfeFT6PsKscP3njuSO9cuOsehLTzK0RZxoVKzxAd+BwuNyBeLwEh
 gOm3dBBLue31xvSetkGkMsbEALYPvac9Qt4mQPu5R374sGRW387lCMeXArgt34CyP8UlBjlh41+
 Tlu9Nfl/keRN8yv/vQHSxnPVnvOVBvW2TZQGKE4BXcKaVQPMD/p0HYZsXt3tHaON9ohNzmDxgbg
 8rmX40t3CeV45AQbV+hZaOCKDdgRRl536yluMocjTwEyVb5Fwfl1JJ5N7T3Y3SjfOYdbC3GAlhZ
 GC38fX25LCy9kq1KqD3koa8PHyZE8QhhM8jvsLy1BlxtpgxQC9aNP/4Lkg==
X-Received: by 2002:a05:6402:52c6:b0:6ac:6318:ab1e with SMTP id
 4fb4d7f45d1cf-6ac6318b6e3mr3807939a12.24.1790635310910; Mon, 28 Sep 2026
 15:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
 <20260928064041.1432227-5-sumit.dhami@oss.qualcomm.com>
In-Reply-To: <20260928064041.1432227-5-sumit.dhami@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:41:26 -0600
X-Gm-Features: AclHuK-2JbzFKcxKCdBacj8QTdy3uUbmKxIgDpRui_amPJLWh6kum853fqlHvhA
Message-ID: <CAFLszTjJ3Q4SiV4i0q85qip7D+_EvdfSVJ9gK_Dnt32xXpQAfw@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] cmd: gpt: support setting full 64-bit GPT
 partition attributes
To: sumit.dhami@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, mkorpershoek@kernel.org, lukma@denx.de,
 marex@denx.de, balaji.selvanathan@oss.qualcomm.com, jbx6244@gmail.com, 
 vandhiadevan.karunamoorthy@oss.qualcomm.com, 
 dario.binacchi@amarulasolutions.com, sjg@chromium.org, pbrobinson@gmail.com, 
 quentin.schulz@cherry.de, varadarajan.narayanan@oss.qualcomm.com, 
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
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

Hi Sumit,

On 2026-09-28T06:40:33, Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com> wrote:
> cmd: gpt: support setting full 64-bit GPT partition attributes
>
> The 'gpt write' partition list syntax only allows setting the legacy
> BIOS-bootable bit via the 'bootable' key.
>
> Parse an optional 'attrs=<value>' key when CONFIG_PARTITION_ATTR is
> enabled and store it via disk_partition_set_gpt_attr(),
> so that gpt_fill_pte() writes the requested 64-bit attributes value
> into the partition's GPT entry.
>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
>
> cmd/gpt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

> diff --git a/cmd/gpt.c b/cmd/gpt.c
> @@ -592,6 +592,17 @@ static int set_gpt_info(struct blk_desc *dev_desc,
> +             if (CONFIG_IS_ENABLED(PARTITION_ATTR)) {
> +                     /* attrs */
> +                     val = extract_val(tok, "attrs");
> +                     if (val) {      /* 'attrs' is optional */
> +                             if (extract_env(val, &p))
> +                                     p = val;
> +                             disk_partition_set_gpt_attr(&parts[i], simple_strtoull(p, NULL, 0));

A typo such as attrs=0x800000000000000g or attrs=abc is silently
accepted here and a partially-parsed or zero value is written to the
disk. Since this is a raw bit-field the user cannot easily see
afterwards, please can you pass an end pointer and reject the entry
when it does not point at the terminating NUL, as the uuid/type checks
above do (print an error and goto err with -4)? Parsing into a local
first would also bring this line back under 80 columns.

> diff --git a/cmd/gpt.c b/cmd/gpt.c
> @@ -592,6 +592,17 @@ static int set_gpt_info(struct blk_desc *dev_desc,
> +             if (CONFIG_IS_ENABLED(PARTITION_ATTR)) {
> +                     /* attrs */
> +                     val = extract_val(tok, "attrs");

Just to check the round trip: 'gpt rename', 'gpt swap' and 'gpt
transpose' all go through create_gpt_partitions_list() to rebuild the
partition string and back through set_gpt_info(), and that function
only emits uuid, name, start, size and bootable. So a table written
with attrs= loses those bits as soon as it is renamed. Now that patch
3 populates gpt_attr on read, I think create_gpt_partitions_list()
should append ',attrs=0x%016llx' when the attribute is set (and
calc_parts_list_len() needs the extra room). Otherwise please at least
note the limitation in the docs. What do you think?

Regards,
Simon
