Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D0606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eqqeZ21m;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R6Dn19sH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A94AB810AC;
	Fri, 30 Oct 2026 07:23:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j0-xKrVOyY6z; Fri, 30 Oct 2026 07:23:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD3DC810C5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793344983;
	b=SaZyUJb98kH8kJlNsV0ue85DvzIpwWO3kmxEcQmsn/GAtn9ZrLb52tdwC9qN71SKjaO7
	 E4D9smCyzyIZtVXts9IwRmNHGJOUeQRrlC42z0h7kopmIK3MOKkWXOPbw8xnIK6nr9X7Z
	 SqQoHz5XGR5WEU2etHG1m8KnuEdq+DWBUhUR2G2e7/wI5T/YP+I26sjKVVNY9A1OFWTVc
	 nqKVP0wBz9uR6SXJUpzPrHFG+HSjuWtW5OFn7A5J2crFhkUA4uaZDlrc8LLoeMbx6vMG5
	 DqwND+XiB+E7eGPsiibVMTqn2KRNdJEVnjFuSbpVUwa2hsv20VAtpQjIlZdAvf4ckGQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793344983;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=al33yqEWrnmYB+98d9zRu/aF/OfyVIm5JkdnTMmJkec=;
	b=UjI++y/H0pEg86bTJVwf1I0fJtf9n3pygcH+WZ0RU4jsjVfhTB01B2sxjFL7H+ONdH6O
	 kpnwa6sw0Txh7rQefXHEmxUKjXwCMJvWG9IsuJh2/93DZ1JIaglGZQJP982NXuoPGy0qM
	 3YC8k5Da5BBnsCVs2rkpTs/BtDOPTc78ix5av9vSKaAVD+m0bH4WEyNIN0Nq8qP0cPBEW
	 T4/+rCgOOc7HzwTPtUXosaXbA6Hyqv29QbLTBxiwVzBmealkUEcN2yZg8zlBV5MtfoOGK
	 nEpkTydjtpTCkuZ65skM2pgQx3xsF7N8HvcVJFFtPJ932GbguLwgfkWwqyDCnWKUbIQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793344982;
	bh=al33yqEWrnmYB+98d9zRu/aF/OfyVIm5JkdnTMmJkec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eqqeZ21mfH9hFI1ilJ8VIWbUsS6U9rwdp5o9x+xqaqzbgHTA8KVJRrCp5SFmuo+sh
	 FGHI19efGel0HBLWLTNx0CFMkJzrRdKqZ12ebTseUJM9sTY+toTkca6itR7GlAKKkm
	 CPx4hDDF0iEnKvopPToB1tudu+3l7ZSmI/DDF/hxBn+YNBIaYQfOtIjEJeAKkMfiqr
	 WsNtaUTlrFYaXxg5lfptp9nT1shZIKT79CLxuZ62y5icrbYLLlROpsSMK5VkX22Sfi
	 5qOzVcUZ5bomenHEpSuRPss7VB3Xz7jcyUmNEjRDpQwqcWXmLOiOQHAsXq7JYUXPRl
	 Bs/joKy7ckPog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD3DC810C5;
	Fri, 30 Oct 2026 07:23:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E62524BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D709540AAD
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ztUZPAGElfhM for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 07:23:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C632940AAC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793344981;
 b=U7qm1SAF/FWpdgqvzE92amp413JjEaxmHge1L4cBbzqrxERs+UMoAmrTmZg2OMeacRc8
 yKuqVNmX8ho9OE+HKJB8ItPOW0r3LXnI6ChZ9WbE/DnICpWhig+JE0Oo4cenTa+kksHJC
 W+G+4G7ReaubVDNfL0ceFlB72sdKv0NxM44qp5+7noYfyTz1LrhJCvGtq6OxBWIHL/OWR
 uot90euvXHv0z4k3k6JQ0Cp2H5Xzu53+rLzCO75sEZPjYGJYrkvvAsbX46Dqc25xLz602
 5kiojC3LxSLLtsJbnB8AMov7IjTs+Cx+QOeBaQ03ZPJUzQU5iBZJuRCg90/rABakr2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793344981;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=al33yqEWrnmYB+98d9zRu/aF/OfyVIm5JkdnTMmJkec=;
 b=RpItk4LC0Kq5uo2LAR5JKNtwqlu9cC+zvaIFCTUdKZn+Nx2GNKyyIHB+G+ZqWYSSLhaw
 YcuweW1nKr331IZIlJiGQY7LPoFPh47IulOjLY3of6ubbzgt9q7pfp5nZvtxsACGtzPFv
 EKUBwFno5Tiq+GTzOnDoNhbHUKYOG0h2ldViyfcGPFo8+u7oNXvMPjLZZtsYSNE41jlf1
 H5pPVpUH3SCX7u/x8yQgnhTl5c3WELYMmaaxcIYXevWE+Mvoa1ESUIJBQFhXy9boFgozc
 oOxUfFBlUllC9NQHUsOEevK496qBPnk1jhCf3wyb8+i8OMVd6w49f0goPiYU3zHrQoA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=R6Dn19sH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=R6Dn19sH
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C632940AAC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:23:00 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b125371596so12239787b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793344979; cv=none;
 d=google.com; s=arc-20260327;
 b=RqySsWRaWO67jmnSyqDPv9xu9qAjY5pBR5CagZ19uGssFFtzy5kLhWBGn+q9itA1Y/
 as3tSKevSoHRBw9z22Qkao6iG1TCAYklgECO/oCATDPs1+m1kXokZ3dSon641Afnjgf7
 exP5UgjeYW7K02ejjlAJDOTVklU+gT6RF+5R3TG3p7M754+s3vJiSzDUIWpeap3nOg27
 5lsIHmPA2CKoHOHJflha6/qKcDP9akM/uRre3DSDuqYSTBBJ1WVA9LxzENeDRJSnyZQm
 s1IXUWqJDPqbbrSr9uk6jViLxyL0gK8az6xXE2Qx9gcxgQh87rnZ8F/vMJZUefhooe4w
 kkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=al33yqEWrnmYB+98d9zRu/aF/OfyVIm5JkdnTMmJkec=;
 fh=OhOSfS6mWstEu/irkSxD71iDNWnMeRBAfsy0D3wuTYI=;
 b=FhLFtb09hquOQrbfPsEVKQcdsbPFF9rAYJj2j/9hcjKho6AW6lQX1a4UbV+AIM5u+w
 QSfKkDRn7pTetghb8TT1fvoBEd6c7F1NQIRuGc2GSzsXU5XZkKdjAaY+BQfrbVmZETun
 pnWhnnDLoqiDVEgkAzDIMwTDLbZ0akHtfMxhb0ux5rJksHIl0U4v7v+sAUZwanLv42Aj
 4IifPqew/wraGUCxhf5JXR9nwXcNBrmw5hDDl0glLxDu3j7Uvs7xs5G/HN/y0GFMHpSo
 R8xYRFn5W2g6OOE+ivWJCRGq9nfAL89EugI7fiTkCHd/m4nvahAv0z13OJmAK3WiU5Hi
 miNA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793344979; x=1793949779;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=al33yqEWrnmYB+98d9zRu/aF/OfyVIm5JkdnTMmJkec=;
 b=R6Dn19sHbXi4qKgLoZEXIvbe275yq7Wtnp0Yrv9wMeNks/Y0vdRFQJb+q761e06fan
 gn/9blUzY4r3tsnETrlAWDV74k48QlY4lkRfxU2ZuBHpZ3MMY5rPLS+bIpqmYGf5g61w
 +0IJsWI/pk/oFVhnTIxMyI81rdxK+Xml3E5E75hUl7o0/Qj1lUpBZTd+eOXtJxbjdIAC
 yY4zzyylag3k2y3AcAr2PA2kESRtOzy7duRSfLcgOdT6SC0il2r377/Iu/voFOmU6kS8
 AokkF/+EJeebusJlTQCz1wyt/QJyo6MoCccXLkHxkXoAilnJMXqxwUKqZS6gXGIR7K4/
 8RUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793344979; x=1793949779;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=al33yqEWrnmYB+98d9zRu/aF/OfyVIm5JkdnTMmJkec=;
 b=WR65JFSsFTGFQljIZTsxjI3L52mRY8zwfmLYIWvNJH4krwnI68Jll5vGNxjPxOkXeI
 hmMAtWccR/vxhFvBbAlzEDtwnpU3ytJ/C5KT4AIOkN7BD0EEQfDMNJAZEDGReS8pdlbh
 pNZRKuzQV0ob8CfvbaxgJxuz5yElO3Pv0ZwRWXBRelF75lHU86OD1skcTnEZm2OBr3Tm
 oMV1+pHVmLzG6ryYs+B7cN6B0eJEShKh0W2LzPrYVnWsb8f639gs+dUf6s2hr81cgWAb
 9KvN7FU9CjyKeWkwGB9ex/h7z+jPPphpqMRRMw/f+rPuhB6UMn4E5hiS8Xtx5Mx/Qd23
 eeng==
X-Gm-Message-State: AFq9FYJ7fqQp1dufLWNRDpay6FUqaZi4W43bHAr1odEaz74tblggSBNo
 pzuVpEMoUVL13UB2hSpMGK7gFZUWfW4f1EueDAOu5Cn18OKaNwR8QRqOxgaRrGZ+5VZqvlvCheX
 BxoIkRhCkD3W4xW4NleXZzjHeZLXoeiPTncxgXFDNYA==
X-Gm-Gg: AYBFou0c5o3F08fSzZFjNYOU1qiafwB5/ms3ah5Exyq3nl14l5LvgSQ+vXvyjl++uZL
 py14lA1uekhjYI+TpjGlZ6iic9aSTCm60A5GUAk3n91ehGad0uqv1Rt18XfxLRuqexXXCYbAvUV
 eTidYa3pTv0C/eREPIls0IA4B5FoC9Bdzk5sx/8AbMcHy/jlD4lpPYEmOve3aXkP6k3r5ye+P5y
 fJEfa1KotJ9EsV1y71efK2SsbrP6Oi2eEJEmtUqc6QqgKYbwSgGZsW8BT0mYSZ/vcbyuf0gb7zI
 YDD8OZ2j1oFGOsWy1PvBdx2/IGkCvbInnhO/cp7lWE2IVtWyNrWBkZQYkmJ96dfx4SbZxoBa6Ey
 96LxNIqO3JPJON5GYAPFcQZUPMu+oQeWd0ht+Xzf2U8HfuzAeq+61LAzz6wPB0C5CDcAS3NeAC7
 P1HetXIonc3a/jOMUyAZDYz/NracxfFG/Xdhi+0BqLHK4h0lz7pIHo9yr1sL2JunFJ6jhpJYNmB
 qvOms1xgXh+NYrmemK9Lw8SxEMMtkk6Jf0OsDfADRCb9okfZMHW6l+/o0HuFhzFm+zgHh2lrFEs
 bqVsSaB+fW4C5Wks/d46+h5AndzNwDlFhLBkzZlU1zdPNGOiFPhobOrR/Cv8WUB5kJE4QluIv5Z
 RLrvSn5iuZL3ZZZW6JfNvZ/hRA9hS0WYkQnyo5wQt8U1/Bu9YHr0dgWkN0AjP1ieJNeVZfTo73+
 PzRbpkhX0wrlMnyzjRvWbF2bAuCUZO0/bVAUE=
X-Received: by 2002:a05:690c:85:b0:8a8:8945:c41a with SMTP id
 00721157ae682-8b1c656a434mr40629157b3.3.1793344978881; Fri, 30 Oct 2026
 00:22:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <be672b54-42c4-48fa-a7ad-994a7ab47ea7@gmail.com>
In-Reply-To: <be672b54-42c4-48fa-a7ad-994a7ab47ea7@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Oct 2026 09:22:22 +0200
X-Gm-Features: AclHuK_SPack5Fvmkzc9siTKVXzpDqbAT58rzAyU4j8NUBZ2wRchwyfOut36SVk
Message-ID: <CAC_iWjLuP0zLWHKCnaCzGL-iG1bR4gR7AqumaPm_yQ9MqgBfrg@mail.gmail.com>
Subject: Re: [PATCH 08/10] efi_loader: do not load an image that cannot be
 measured
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana

On Fri, 30 Oct 2026 at 08:14, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> With TCG2 measured boot, efi_load_pe() measures each image into PCR 4
> or 2, but it gives up only when the measurement reports that no TPM was
> found. Any other error is ignored, so an image whose hash cannot be
> computed, because efi_image_parse() rejects it, or whose PCR could not
> be extended is loaded and can be started without being measured. With
> the range checks added to efi_image_parse() earlier in this series,
> more malformed images take this path.
>

This is a policy decision. The logic behind this is that the OS is
responsible for catching wrong measurements, not the firmware.
E.g sealed keys etc would fail. If someone cares so much about
security, wouldn't EFI secure boot be enough to verify the image? IOW
do have use cases where people rely *only* on a TPM for security?

> As EDK2's DxeTpm2MeasureBootLib does, refuse to load an image whose
> measurement failed: free the memory allocated for it, which the error
> path leaked so far, and return EFI_ACCESS_DENIED, so that LoadImage()
> returns no image handle. A full event log is no error, as there: the
> PCR is extended all the same.

Doesn't EDKII also disable the TPM if Tcg2HashLogExtendEvent fails? So
does it allow to load further images without measuring if the
measurements fail?

Thanks
/Ilias

>
> Fixes: 163a0d7e2cbd ("efi_loader: add PE/COFF image measurement")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>  lib/efi_loader/efi_image_loader.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index c4f64f102e8..c33b693c4ff 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -1166,12 +1166,22 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>  #if IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)
>         /* Measure an PE/COFF image */
>         ret = tcg2_measure_pe_image(efi, efi_size, handle, loaded_image_info);
> -       if (ret == EFI_SECURITY_VIOLATION) {
> -               /*
> -                * TCG2 Protocol is installed but no TPM device found,
> -                * this is not expected.
> -                */
> -               log_err("PE image measurement failed, no tpm device found\n");
> +       /*
> +        * Do not load an image that could not be measured. A full event log
> +        * is no error: the PCR has been extended all the same.
> +        */
> +       if (ret != EFI_SUCCESS && ret != EFI_VOLUME_FULL) {
> +               if (ret == EFI_SECURITY_VIOLATION)
> +                       /*
> +                        * TCG2 Protocol is installed but no TPM device found,
> +                        * this is not expected.
> +                        */
> +                       log_err("PE image measurement failed, no tpm device found\n");
> +               else
> +                       log_err("PE image measurement failed\n");
> +               efi_free_pages((uintptr_t)efi_reloc,
> +                              (virt_size + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT);
> +               ret = EFI_ACCESS_DENIED;
>                 goto err;
>         }
>
