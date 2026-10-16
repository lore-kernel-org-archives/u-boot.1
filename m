Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887DBCCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 14:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A31260B0D;
	Fri, 16 Oct 2026 14:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DnEq1BImpnbd; Fri, 16 Oct 2026 14:34:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 681A260AD8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161268;
	b=N7VXWqRTvMdystYGRZMpwg+Il6ovnghUJak527ibkLowfJ9AP7pzMs5imgR8Qa85WucE
	 cDbtE1BOrMrwsXtsv5FNeo6JsczcoIkPSD+BMke0YKvYRzy/QRW81pNF6U2TssW6J4laJ
	 1CWHDsrnl5ll0ie2ogY9aMGovpPlceH5vIupMFo+GJ497Yri0WkIF0T2pL9azgwWjiPd+
	 M9vCEHNsNHz1Ew7fZYBINFeS/KShCsDP+5JF0z1k5AepbcgluB58ebJoi3/uL0aFBU+dA
	 kpQBW9hvg5tzZeUg10Ghe8oB/ccDI88BnrwYT4wrvFzuYUziqrPQqgHuGkLezqCwBIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792161268;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6xcPLiapClysfeTAby5UHKdOMKKZXzf09o8lnjHX+OQ=;
	b=Y8y3PpYIIlXuCIv5EVF1j9VyN7ZxC67igpMl3DqKp3EnoCQA45Hb1Qtei7YkfeVUlvEf
	 eBeNDw3btbIEo8E8e+EfsHSkbTMPE5si2pNOdql4g7qFqGrqBatBi8ntzgy0Tf78VQbzZ
	 ggSvBYrsUpX+2ee7gE6WvES0Mrezk1OYEAOk7fMaiZ18ok+ZRJTwCRdRCwxofY1rzw6QC
	 9acNKIMI5wbZVShMNNQ2BBjGQa48YluDQkpGxNszO+B2fTsF/9QNZTW4+fYlfgw2wG4P/
	 Hp1SseH7OtOWteN57Nr/zaUCZFba5f1dCwZoyloqHaU4xixP1+92j7KOpxTl4Wr2FIA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QnOmLKMO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792161268;
	bh=6xcPLiapClysfeTAby5UHKdOMKKZXzf09o8lnjHX+OQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rv00Zx+OcwFm3JNwIYBfm5PvKqJen7HkKTpahQcssy/Ih54J40UPO7NF1UFMIe241
	 Bb1yQH1u8Uqf2XYhhulRvyhwRndkOvnm6yzOnTWPnPse9dCHt7zhEpA2Sv4lDzmxT2
	 sCjFq6sVyjqnVSE+OOfWbVWE7qTTtlbn+Uf+2A8vTkqeHe63XG6alhcaa4XeuLprbR
	 mphvSIJj3Y57zYkFoYtqwu+oZCWgoTyB7YeTkMnH6Xd4DwOvEkxuOEl9fQOwOJzq8R
	 83oURnxE6GE9ncV4m5N8p68fTpdWhnZgUkVHevB5Y7d/rKfhKQdNPOtK6tMiPfUgjr
	 VNNk238wOUPcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 681A260AD8;
	Fri, 16 Oct 2026 14:34:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 618BB79D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4781760AD8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BDMUs5hjBeaa for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 14:34:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9CB3860AD7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792161265;
 b=FRfTPhm/0Apuev/kf1p+YZJMi108iL5IM1MQfACelDt7Qvln9l13Vf50eOLJQUzsS+CT
 O2cQJKk4xVXBe+YcN1zxg3lDaVPkU4KvaPy/DVgBON4HnFK+Qf2Ibn2a/S6Flvhp3xMb0
 ImlpXmGf4+qKUTh/4fGHb+2yhdnweHFOSKAeVge9u+9RaIdHIODRwe+tPwwfRyxO7rp6G
 ysv2/YW5o2mJykwKvw1j/xZ7gJfNyPFRlnf0OEg7aAzrNC/5Z5fVyKFAzFjBmK9BXwlYG
 o5WJ/0LR5Iddegmglv3E7dcA+QEC8mMvgnceLYRM+/T+4m2FmclYP1IihuJxOYkxc6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792161265;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=6xcPLiapClysfeTAby5UHKdOMKKZXzf09o8lnjHX+OQ=;
 b=fVtgUuEtxhtNBBGJbgB510IhByktQgFPo+oMUJOMv2XXRftIzKZ4J6Lnef6ceP87e0/i
 809cumcVrek+dCHr5RiMKxxbo9xKrn4mq1PwTDzeaybrgJIlVpv5TbwvMZVeDpHvYla57
 eQdWM352MUjRnk4mTnLbZyMI/7G40chV7MPfYzUuIrLaX2qJk+HyFe2YyXJl4DnhU1y6U
 mw3KhhKjXrOUeeFBl2OKaJVWtfgg95lmzTM8+CHk9ZAZLs5s1AesY5lyae9Z+35Ozb+CL
 LHs+8rQ/2aAweZHUtzDpNkUWegRwjbVWgQ07XE48r8zzMtEwnL2+b3k9NTV5u/gcFMA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=QnOmLKMO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1034"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=QnOmLKMO
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CB3860AD7
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:34:24 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ac7c7b3a90so23058a91.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792161264; cv=none;
 d=google.com; s=arc-20260327;
 b=hBpAZgdrIF0qR8gALZ8PPBFQzIWaxvmdtI++sz3LqBDeIinj0AZ403AQuTf6tfOiaG
 x0sQ4ybmRz9LcjrMnxzk04gMMBLb3FvAUBcGDDDX4XqyXzdU5quW56CAFmKFW9K6gyJP
 1z7BZFocKihRA5cEyPEs9O5aMsHGUv9TCgjzn8iYTuLvuK3jQ1X/OXLmhQtk+sq7tTrQ
 Xlquc+ow0kHgvqHnynKm9yq5t09/uKHWXjwtmeefUgWA8bQ+HPu8BjnHNrMOIBARzCgS
 eyHJ6G4EjR6SR9ODX8+xHjl8hzpLKYUDGN48qdyXySN9vBVgro00rH4mKcEkORWQZxnx
 43qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=6xcPLiapClysfeTAby5UHKdOMKKZXzf09o8lnjHX+OQ=;
 fh=cC+VSyQ9vECMxTl2USSTVlNN20vTibmKCymGAzgBEUg=;
 b=tDtlYbS3UNqqaK0ZyRQFfdUVUYGijlGZimZyZwELeNWmSrQOLOuCD/O8E5Nr1XJLlf
 aqYIwMZK6m8fdSFTj68VxkrlxP23QAY8o8YOeQtEq6ITxXdbitgSbGD77pU6Cyfz31se
 jS205lP/i2w9yRW+EVTHEgNTvO/dIs9sSpjOUnFLu8b75RmUyfNS2WDsUHQxInoYxW2A
 wSN5HVyc77Pk3snBqEKvShjPayTzbDY1VyH9iNBPmmNcOHQNJAgPNFOCm8+gpUqKQvY5
 a0K+dS0LwMwcvwN4LLPkCdqfM90Hf+YKLcpBDx5ZQ4GPlH3EJhADMxYwYB68tkgVZauv
 Vwmw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792161264; x=1792766064;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6xcPLiapClysfeTAby5UHKdOMKKZXzf09o8lnjHX+OQ=;
 b=QnOmLKMOWqfIFMgdQGtBpS5BGKCmeXKN7dABVeWiUahlt9xO7gTS0WVINu+wwiKa3P
 IFwF+5N4UJfBaX9bo1vDP2L8FUl5C/B8e//iFqS23tqWJHu7GUoG5Mlfh5hl3poLQhiM
 H8moBE8qJnXvNv4mE1j917Ex1MNr8tum0IgMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161264; x=1792766064;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6xcPLiapClysfeTAby5UHKdOMKKZXzf09o8lnjHX+OQ=;
 b=0EZQF/DbyV8stv5XXpykn6cmdOHdr945ZKsiGmWJQVQduGth7sylZqU0o3kIq2fxLI
 j2O/hhDoQcOSPd+itdEfzb92+9FIYELY0cV8Gx2h9LbGmYO/DKIGn4crVPeox5ZNl4D8
 NKu0sPBkAG8y84SWhH6OA64JoU8+mBjTloBylKUSwUYors/LwehFlKwvPc8e84tvTTF3
 la4o3cAygnmyAzE93p/FJ4Hj9X+6tPHJ3dN2cGmTIIgEvoNiNIK+ozGnsWXz4fULG1fW
 FXTx3fza/EwTS2GFKzpJNT36p1OxkpiuvJcIVCE8z6t2etlSDfv+ZHMep4b0E5XcJ6DE
 wsXw==
X-Gm-Message-State: AFq9FYIWWSbjoY0qA5guTXCcjlV47AYNgBqrWVWpHbprswtBfdsFFv5s
 sKklu3ZdqE2WgH/PlWG5Mox+cNHk8EA/4Wb/V+8KAkFAn+MQLHysnOLj+8O7OIaec8YBelK15WQ
 2VUVH7bLWGNG1VPDuEfXVkX2CgvnvmB/qlyR/Dmoc
X-Gm-Gg: AYBFou28DFcxEMVdhTxoJ0bRZzRqjtfEOp55H2CJek3f8cbJB8vPz9jPSTHFKSHvtyt
 UZarJtWInCAgWwVxQxHEOdoZLVGQZUgcoWFfxw22Iu96/76OjjaHcCqK3mJQoppSviCLw2wb2Rf
 qD1f/5uo7+JghbKmFHsiu3Eb6AiD44UXvoAu/A8mhOPnomyEOIhAfJtgOy7zBqDXNomT8Mgh4zL
 HbTEg0s3+YjIFW+FIX2fH2kwUx4tAXrXfpw/KS0GtbkAdKa31+danKh4h0JUThasmKjyFO1AABE
 VHqV7V5/Judqr0ABTzGCrXUXVhLGJhJRTTEp73qESTrZjjTbnVUzyA==
X-Received: by 2002:a17:90b:570b:b0:3a4:fe48:d410 with SMTP id
 98e67ed59e1d1-3acef29edffmr17572a91.30.1792161263273; Fri, 16 Oct 2026
 07:34:23 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 07:34:19 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 05:59:25 -0700
MIME-Version: 1.0
In-Reply-To: <20261015111328.1269775-4-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-4-bin.meng@processmission.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Oct 2026 07:34:19 -0700
X-Gm-Features: AclHuK-J12nu12Zrc36ymdC60A9wzR_LX3TZPV76CKSu7thrIq0_IHxM3KnXjJo
Message-ID: <CAFLszTgqNbn2AWMWqHRZmyJvePEsdtY8yNw2ZVWqgD7RU37jng@mail.gmail.com>
Subject: Re: [PATCH 3/8] virtio: pci: Fix modern private data lookup when
 deleting queues
To: bin.meng@processmission.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
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
> virtio: pci: Fix modern private data lookup when deleting queues
>
> The virtqueue's vdev points to the functional device, while the PCI I/O
> register mapping belongs to its parent transport. The current lookup
> therefore treats the functional driver's private data as transport data
> and uses a queue pointer as the register base.
>
> Queue deletion can overwrite the queue's list links and crash when
> unlinking it. Fetch the parent transport's private data instead.
>
> Fixes: 550435edf810 ("virtio: pci: Support non-legacy PCI transport device")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> drivers/virtio/virtio_pci_modern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
