Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2D3C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C42EA812B3;
	Tue, 28 Jul 2026 11:42:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bKyVzANxvx5G; Tue, 28 Jul 2026 11:42:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F125F812B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238957;
	bh=NHaBw8oeudKYwVdxxckCQQ/P+sl4HOKJP4zpaLNT0R8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YujHCWOnNQoBtnCeJr49+5BVt4j23U2zlhC97/NJTYzXrR6zmhTuU1B0L6ptTT3qf
	 eyQZmvSWRoh9txd/gc1B0HOyG2nw007PzPjyx7Q7Rl5L9ulE0FQCHh9THZsbdCXmz4
	 tdVcOk55V8oNQ8aewqbXR8auLfd3B4tQRMbbwx6MQbK8d2QxTg9C7kKrxj9Fu2yXv8
	 d2YpUROUxtQqyhA4KXkRlDwhIQHK0i7aW8Dz0OzRXMs6MzCfNcwNSdzQsvxIdx/bnP
	 fkmsVxhk+vhjla883PzBo8UoNvGMNi7maveUctH8gwz3IA7A88xU9+gjJ8tcytHCPU
	 TXbDQuLXcXnbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F125F812B6;
	Tue, 28 Jul 2026 11:42:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A42626C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97B2F812B6
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HfXxWUixMlls for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:42:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9AC9E812B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AC9E812B3
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9AC9E812B3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:42:34 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c1c52d920b8so501994366b.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238952; cv=none;
 d=google.com; s=arc-20260327;
 b=G2eYQMhw3B62CQL3VVuIFEczKm0QcCn66SEJeygKWw2zEvMdbYg87xMesLSv6a2/dX
 TL+rg01aWz7tFnmNktLRvTIpix765NdstyxpIdL0VxmAS7H5s0fovF3TRAk++ByC8HLl
 1fnCCviiKMGEkhkz9ZUhrbcbdhLndSIVOCJVqpQngPBnmFlpze948pO6EfbHHYrqQS91
 EH6swKmjo0zcF4s7nCZ43vcvDU845q0T5EoDR3QVb2OdLgFs/Sj/lwVH5tiYlJpiKCvd
 1gVG3negYuIApfxsaIJcbWTipwx0qzS/HXuzG6YBZBe1CZ1yA4hgKANdY5wUCsKsPyge
 Ycmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NHaBw8oeudKYwVdxxckCQQ/P+sl4HOKJP4zpaLNT0R8=;
 fh=o4+3yAcNzIrfuQTnaqG41tL6VHcvX8mHRNTBqgCZpXY=;
 b=Td2HXtIxkE8VVbreoimPJAHEL70c4acoaV0eU3ld6/wOibhBx/ydrLPq1tJtPY0jE3
 mvd41fHkhjhuZAd8Qv/vPT6IsC6q7nL25WeeeAWGLnVe2xgjptpR4XVsOwORMktQOq/h
 cIRmoohj+f0qtRvbTSWZMVYBap3X68Jr4sbqXyEYJP7M5KTTXAwpGTTjhmKYoGWvrqpW
 Q5tPwErs5mAHMfADXxKer21QY1rw740gwor+4x7Xq/jxjKR4reNPfwWLxtkm5ViAONa4
 95asJIM6gkTqUlGEHf7EDpwe6t5RBjPxMIKOcPIaZJ6ZCPaubr17FLbSY1hEi5PUKGKk
 gMgQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238952; x=1785843752;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NHaBw8oeudKYwVdxxckCQQ/P+sl4HOKJP4zpaLNT0R8=;
 b=sKX3oEL70OOoEc0Vy8UA2Q47MMjI7L+0cIzXm4SSkpkFcd+P1NYZKscEIP3vaUNNhU
 a+TXZIIGxUz3N8fOHY6GUnbOIaP9CJxzlKN01DmEePImtWAUVys0nPuEkahIi5Cv+G0k
 f57Wg7XGLoKiQ+RZJqR7rgz2GTVYxIfJ4KBtiyWgfPLKIJUuhn/w9Vy4RT+nG6U+xcjT
 YN1mhiYSE2q+0Q7REMEL4d76VqaJ4+OsuMaY1ys7LfBxUTKb9YPYRhmx4GJlck0gKT4V
 sow04YBLJTsv0JGEHpRCbWYr2Uip2tsAeeAjivbjrYYvKgRdKSw/c7pJRYmh/SiuJsYY
 CADg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqxT9c3STqltHgn6BmSlfE38fAg4Y9fmuENE7Ps0wnFAptQsDbyzt6PBvgnG0EwhgxAZZnP0s=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy9VzAneOUG2Iy65N4z0kyHfeMHdsj9VokRQW+lT0pUqS3AN0Ur
 lOhtlVNsH6lNe9hvko66kBCCKZ7DDX0b2U1TyEQp4d6yCswbxytuge6tcX0ZglwUT5QBf/6BXFG
 6SQ4yVCYjiWIlmlLSO0rvq6WeoxM3LglZWQyFSFj3
X-Gm-Gg: AR+sD12EuT+H5MDSMvosf9cTA9U5tDnBHqbh3PH8UYagVlk2uXyctx5Yu28z/ek29i8
 Bvlg/+PqJpQ3MfdGig2SfFL3eFeV6gBphWe5dv7471z1bKeugPsfXCqNsb+7NNTbJETyZmjYmgJ
 HR68c9bYHHXJYVeqlxP7hFTCNkZWHN5jYR3YmSoGhb5jSNIlyzMpXX+AeKS5/Omt9A7HJpJF/LB
 CaYdn2h41VV1Bht6G8KjWfaoV8rWDdFiPrcfQoEGh6nMSMYbjdxECK9IhYy
X-Received: by 2002:a17:906:7304:b0:c16:9ca5:e547 with SMTP id
 a640c23a62f3a-c1f727c1a1dmr98925066b.62.1785238952308; Tue, 28 Jul 2026
 04:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
 <20260721152110.283998-6-aristo.chen@canonical.com>
In-Reply-To: <20260721152110.283998-6-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:42:19 -0600
X-Gm-Features: AUfX_my7-_T1XnFmcp_QL8ctf7mcKjw-ocLSUT3BS5FGIHqlJHot2v2TZhroxfk
Message-ID: <CAFLszTjhFDE8nk0cGis7WgNsz6BjOLg44L4FXfz2U52e-6Bdrw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] tools: mkimage: detect overlapping load regions in
 FIT configurations
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238952; x=1785843752;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NHaBw8oeudKYwVdxxckCQQ/P+sl4HOKJP4zpaLNT0R8=;
 b=OWIfHw7RSWOb6SN3SxMR1//ttDPIFBD3bLiUowUqj8V/Qm02sDwTrPd031rp9yzoY4
 EHdKyxhvTF7eA4u3uDWQHyk5pJTv7syedeUZXImaATfjADC5zG6cl3NglI6fM2sJNecV
 B46r7yREcrCCTo0y/OLdRAWo4s24kk79vb1Mg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OWIfHw7R
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Aristo,

On 2026-07-21T15:21:05, Aristo Chen <aristo.chen@canonical.com> wrote:
> tools: mkimage: detect overlapping load regions in FIT configurations
>
> Add a validation step to mkimage that checks, for every configuration
> of a FIT image, whether the images referenced by that configuration
> declare overlapping load regions. Images that are loaded together must
> not share memory, and such conflicts currently go unnoticed until the
> resulting image corrupts memory at runtime.
>
> The check is strictly per configuration. Images that share a load
> address while being referenced by different configurations are not
> reported, because only one configuration is selected at boot. This
> matches the layout used by the TI K3 tispl images since commit
> c85bf61b14f9 ("arm: k3: select tifsstub via board_fit_config_name_match"),
> where the mutually exclusive tifsstub variants moved into per security
> state configurations precisely so that static tooling can reason about
> each configuration on its own.
>
> Images without a load address or without data are skipped, since
> nothing is copied anywhere for them. Compared to the previously
> reverted version of this check, the missing load address case no
> [...]
>
> tools/fit_image.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/mkimage.c   |  3 +-
>  2 files changed, 101 insertions(+), 1 deletion(-)

> diff --git a/tools/fit_image.c b/tools/fit_image.c
> @@ -1031,10 +1051,88 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
> +                             img_data = fdt_getprop(fdt, img, FIT_DATA_PROP,
> +                                                    &img_size);
> +                             if (!img_data || img_size <= 0)
> +                                     continue;

Just to check: img_size here is the stored data size, which for a
compression = 'gzip' image is the compressed blob, not the runtime
footprint. So two images whose compressed data does not overlap but whose
decompressed regions do would not be flagged. For the K3 and phyCORE
loadables this series targets the images are uncompressed, so it does not
bite in practice, but it is a real limitation. Keeping the static data
size is fine - there is no reliable uncompressed size to use - but it
might be worth a line in the patch 7 docs noting that the check reasons
about the packaged data size and so assumes uncompressed images. What do
you think?

In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
