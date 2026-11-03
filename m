Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E00606E6FC
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m/73Hyy9;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hO3PQKCB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD0226070F;
	Tue,  3 Nov 2026 14:49:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BPsD4pIKmvYx; Tue,  3 Nov 2026 14:49:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2EFB607C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793717366;
	b=f2h8i7FUkBIXbcl2/uIOSxwAFWUVERigho3uQM7LDxjgmBJn4v5+J7QLnoEmnm37EGDU
	 z49gLhfTCtLJtHPCpBNYDxo35AchkGcuedL9ow+60gYCI9mFa8HdaAwXytGNrgUIvI13w
	 Kcntp2rdRcaQkqKWBTawTidmgy5UNaeaxTDch+ZodfaYo0H9rqajEbvznGQVx/rnTSxl7
	 b9lxjN3Ji82BWTAW/6NF4OeNw4cULFNyjuII8RtzafmJFQfCjdGGZ+3DYH4pJ5XlqzcUX
	 3TRyqNDxWx+iGt8tclUSpSCQZflk/Bko47+VpL36XYaCrjfRUN/PRRvk1vPKWqJ7Taw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717366;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eegAjoYz6qXAug0MjeKaIi3BV17RwA5tzpvEeA24tWI=;
	b=H3vl5/sP6HNkwEixiL6l6LFCKPi9Vc+P2CZ+zZzZS6aNpd20tBMvFoXFqP5x9G2chO7q
	 8ZaHe4M7ijihckULBHkzmbpTaQOrS1D97Z4XD0E+tMSvE9SfGESG+bNU5cVPl9NvuC89D
	 FBoloDDXhxl3DERe47uZrRQJBZqhOgKeSqUr2OrUwifONewaIxFpPdakLlbhoyUXNNzqM
	 Ii8ZfOPdP3LYqLWT9y58XRoD4HZVDhdDJgjKS33lqm+oULEeH+VCQpl3DSZPGU/Cws9RV
	 f/yqaXOSP5K6MlZQi5Il4nq11UXh05OXMNQJ3+8SC6JJeBNVBV1OfmIw2HztCildgxQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793717366;
	bh=eegAjoYz6qXAug0MjeKaIi3BV17RwA5tzpvEeA24tWI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m/73Hyy968+jvVcBDxF4j/QP/9DxanHL3T3J2/g9llucSggRniuT8vbdFG0O77CSl
	 c8g/E0iuB86kmNDroTbTn6+5i2l1HoaX2cewzwJriQ/Gl+5tP0bwTmisX1WRzxUkaB
	 xr3GQ4awFxPVYqb9mDxn60+emaGOg2iFgMMZ/TkKh+keVyfJOB/StOKff4jk3Gvk8K
	 5J+JcwDpKmfwSeU5+PdtF/bP57bGoyUaMys/1CQX2MpKH2ctZCNZ5fxRwocGT41wyZ
	 XfQSIvLj3TKlTknhy7vthWO+1JoCvya6sEn1xGEAQLHWMaDXzPh2OdMXkm8VXCGkcH
	 Xy1xccB77gS5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2EFB607C4;
	Tue,  3 Nov 2026 14:49:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 407FCD3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 324F4400FB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:49:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QULmKuER1u-l for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:49:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4ADFD40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793717363;
 b=V1uaZRqx17symcGs1eYs9aOuPNsQPgjJMoBdrBCKCqu0sFoR7fL+pOSs2cUqKYaOWRIE
 DCaatnz25KDwwB4tufButASuvl81aa2rZggWlxC+Tf14JnNdyE4Yz2TjVFdF/JCikjNf9
 TCc1TjHHeHx6Da3K3VIfmh5RJGEEkMkU/BJ0Rm/EK0BsWMBS0UnBPEkFPIKAo70cCgC+R
 jdO0WjXLHUUSZ22MQy7D6K9PV++HZaHdGdo3zvYf4Hy8qCXWYfVVkcnqK6DAdYcFFgpgk
 Yu5yIVcPJwqJFUEb0BkSYes8x6KpsM/jyeNQhg2PP4EPmlsHyG5R0X303PUgmZk0WJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793717363;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=eegAjoYz6qXAug0MjeKaIi3BV17RwA5tzpvEeA24tWI=;
 b=gdy2Sc0HQVc5H0nyaSSmWAxsRTifSCviZLqJ+iDfUmZC+e8yPyVRzXD0d5t79XzL0+Sv
 PmaMo2Z+O4SjLaTXMcM282IM44uL7yi7OkJ1RAWy7Kdvm6ZKxkM5vJTkYnGkI/o+5lYle
 z9dzmDykQq0k5ZuuwSY0EiIKyYZTt4QaG5z0wAnzWhmOlYmxY6VS0Q61lVE2mqy4W9OfG
 bSKKp/PdLdKT4sWdL3cRQcg1l1ruyQ7fVPxHpDE6v5k5o7hzUhTKwRgEP45FXf7k2mWAq
 rkppmrpG0QemnHyWZHOQNQp6YwxGstlX3I2iMiI+lgnC3s5hqVPO3+Q2lKqzyQZbCjg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hO3PQKCB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=hO3PQKCB
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4ADFD40068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:49:22 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b3dc272dcfso5677513a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 06:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717360; cv=none;
 d=google.com; s=arc-20260327;
 b=TWyZquS1Fqxi+FxqVWq5/h8u4+bI2jpyNcJ1YAAZVL113Zai13uwp7gqvPN+OeQWnz
 lzGlwjPYxrlgZjWGDTmQkUeoNWwu8hvn7FNzqZjZDjgGNouzrunfZqEbItpEUC2LLxJq
 DLPYxQUKwgcbcI6Zg8Vv4zX1ggD/jGlXTFs6tgyuiFuVHGPNhJPsFAnIlJFR4p+1OR4E
 gDIMRF/pMW4lhHwKLdh+/Ok9R8zN35naiP3poHLFIHBApoXfPd5i6BKtMH8okG9iEWAM
 BYNirX26tcYx5d5h/O8Ge7UVwT6H58Oc/+dSjJ10ELzH0j80rJrn/theVmefh127mYk6
 OINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=eegAjoYz6qXAug0MjeKaIi3BV17RwA5tzpvEeA24tWI=;
 fh=/DD+xZkoNTprFhrw2DcgvRFrzcYjpf6tnw1WZgtxNVA=;
 b=D82i7vHQcqn1mfVue9FKV5dBI0A0LfyjyPeke6qy0hzl46oZIrAvgML0j9cfuAcL8/
 9vPR9A+JJ4ohiMjdDWm12ZWIpjqC49AM2HN2bYL95quJwd0fdrX2kBWcw5dcHRzEVIUI
 LKSWrAdt3mq5Pz3tJPQwndwXIOAsHX98DxWnQ5PVfaujWo3O3TP0+Ku4nCt1nYF5A52k
 cqxSE+ZEO90uzmeqbRSD/SN0CbNdv9eH5T+olfzjaKtQ2CQ+F6gIDGA1npmAQPPfD44g
 WZz+lEZbOR2Y2CMagvKOMjesg8g/XtVxjaNKkmkYW+fz1Idnq2rfnTGSi0AgTuEpT24U
 3fLA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793717360; x=1794322160;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eegAjoYz6qXAug0MjeKaIi3BV17RwA5tzpvEeA24tWI=;
 b=hO3PQKCBR4UT8/tplargAB6yewRS0NWmN48A+O+sqzzotzCDs8tFQy/E54n8JJ2/IP
 ixgbY7OkR9msnYKEQ+y9grYTCe14gUThD3JWZsS0Qg8t5D0HMJXQ3dEfr6/Mggob9v7E
 yWxbAxOml2roAhVwBaZZuNiPFpxLA+B5sQE8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793717360; x=1794322160;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eegAjoYz6qXAug0MjeKaIi3BV17RwA5tzpvEeA24tWI=;
 b=hTanDjp3FFGMESgpj6pT2ThHPcfS1TTYFUD5OxjLKQHdl4cZIRAfnnx6SadRgIHVkf
 6Uvdmgh3OYyT9P4UiWk7+JAJJCPyF1RYktceWbmVj7MeyJBi1UMjEd1IH/egffnphQhA
 ZgfDw4JaSQHyX0EMMdnE7rdyzJdLXj9v9f0VpInbayvEsKvJD9dBYk6On+UwIrUNDgVC
 yjow8mmgY0R+PCM0gN5FTrGltse5qS0Q4u0coo6Ul38xTRIubOIOGQ6wGqkF7x4SbJrg
 f3xwqs1sXqDyL6Dp9TBchLmGcAllp9BJpqwBZWLFBgBCriulQOMYLCQH+RpuRo62ugEa
 75CQ==
X-Gm-Message-State: APuU4Z9gVk0EGADh69lMzVxLETuKqfxvbQZUaDatdRCL9ANMiDyY7b2A
 SBRQlQ0IXiZVCqwEzgfwx19qoI3s7+11RaHQBm3vj5bhA11IGKDUcj1ovlJ355J/jml2MUR+k7f
 NXztcDSxa3e9+CANIXwxxg+OIblGh/Vm59mkar9gy
X-Gm-Gg: AYBFou20JRO3qXKI195LIFAuzRiwhZPHywPaaxBOnxwk0sXc5TFo4UEQ7cYD+NFdQdb
 dFSVMP+1szt6jLY0Ed4M86NeYyVIPNWrGjA225ABHKd1zcnvhLyxaSFpbiANdiht3m+bVFYwqpA
 d3fVGbRn+TF/s5nbEp8Q7xpW99snzGE9FUpS4ChHypEINUWpXtv6h4JuJcQNCal7QWxi16nyH39
 Vxry1PLtCejHprubnBJvmLcWvl5O22xlZK6IM8Gga+d/c0vpdWFZynNZFhcbeelOXS8qHZGpa8G
 3VxCVV5Bq9jLZu0u0RKkQ6amSdr7pJW2X9856vItNMjn0twRx1I/jdHA0l/cy477Hh7Au9Y7ByQ
 9mFF1uHjSlawk4maRzRq9Da5A+W4J3XfpU7PkaQbC+Zq76XmoJKIr6PajAjH6zI6soDFlmz0=
X-Received: by 2002:a05:6402:1ed6:b0:6b4:d7fb:affd with SMTP id
 4fb4d7f45d1cf-6b4d7fbb590mr8720612a12.12.1793717360405; Tue, 03 Nov 2026
 06:49:20 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 08:49:19 -0600
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 08:38:00 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <80c59fb264f9f2c8b325bd792f0a20c172394e59.1793588058.git.alan.tseng.cs@gmail.com>
References: <80c59fb264f9f2c8b325bd792f0a20c172394e59.1793588058.git.alan.tseng.cs@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Nov 2026 08:49:19 -0600
X-Gm-Features: AclHuK9nE2zhs11HiQzJSwuHW2jab6vfQtl0uINgY5rvd59kL45_erJPmigNe_w
Message-ID: <CAFLszTi20S-CDj+MrZR5LmfJ-0cvmv_wnOWSqBdB_+j6=mNitQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] doc: virtio: Explain how to reach the virtio RTC
To: alan.tseng.cs@gmail.com
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com, 
 visitorckw@gmail.com, sjg@chromium.org, xypron.glpk@gmx.de
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hung-Chun,

On 2026-11-02T03:04:36+11:00, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:
> doc: virtio: Explain how to reach the virtio RTC
>
> The date command only uses RTC sequence 0. On the QEMU ARM, RISC-V and
> x86 machines that is the PL031, Goldfish or MC146818 RTC, so date never
> reads the virtio RTC unless that driver is disabled. rtc dev does not
> help, as rtc read reads raw registers, which the virtio RTC does not
> have.
>
> Give the virtio RTC its own section and say this there, along with the
> QEMU version it needs and that x86 needs DM_RTC.

Please can you drop the DM_RTC part here too, once the doc is updated
(see below).

>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
>
>  doc/develop/driver-model/virtio.rst | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

> diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
> @@ -78,8 +78,19 @@ Requirements
> +``-device virtio-rtc-device``) requires QEMU v11.1.0+. The driver needs
> +``CONFIG_DM_RTC``, which QEMU x86 does not enable by default.

Just to check, how did you find this? The config X86 entry in
arch/Kconfig has 'imply DM_RTC', and both qemu-x86_defconfig and
qemu-x86_64_defconfig give me CONFIG_DM_RTC=y and CONFIG_VIRTIO_RTC=y,
so the driver looks to be already enabled on QEMU x86. Please can you
drop the sentence, unless there is a case I am missing.

Regards,
Simon
