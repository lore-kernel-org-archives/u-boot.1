Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92721C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5425A60720;
	Mon,  3 Aug 2026 19:26:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2f0Wz0qCWf16; Mon,  3 Aug 2026 19:26:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A946F6071A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785785164;
	bh=lUSDEOIf5cQTvIYD71Y2EbofxxS5ojZqQ3ygwn5iV6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zvlfexYGQ62U2y5iCms+ngEisUM6fw/DYaMht1058xYavfjvYctDcIlvvaMSPoMcl
	 KSf4Yp49KhtLX1xin3+zQtqlnXUUXcjceI3nVH+Nh5UL3rS6BAoket86TTstpaMGvR
	 njnmV/9R5vh69hD4r3+IQJPAuXqAEBjBo17/caXICFEOua0BEKnQgjaphBU/xMfccd
	 Dy9s/Mhf2hxXR+EsTA3jDp3o0VhzOsu6buj1nSGJ0S7gjKw2VAirv+eATycqoX9AhK
	 /FNHNRUUuANmInPssd7K4Hnwvja5LKu2KV+ohUUffw7QeXyGix1klEYNf2JPBJTPST
	 OXVtozY5NGGiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A946F6071A;
	Mon,  3 Aug 2026 19:26:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 022892AA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F3DDE80BAA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:26:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jKRKmLBvkFrx for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:26:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1F2CF80B5C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F2CF80B5C
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F2CF80B5C
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:26:01 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so5989415a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785785160; cv=none;
 d=google.com; s=arc-20260327;
 b=Ja7+13b4QaX8kA+JyUCT5FvXP0/ysGnQWSgkfROqjaQD4GDOsVbzmgWz3d74QybXVD
 RUtMVdqdhN4qVIkphvOGz5PoBUckWrR5NDPAAFSGjAVK4DZv1n2lWXI5x8iSUQ5P9KX2
 XF3mFptfcX4VkZTLewm8ZGv0D6pAcWAgZHkkylldK7eb4MD6wFMvzKm9F0W85alaOc7J
 CZ6GIefUEdJ8iXpr2mRYWLbUuTU3ONgnV4z2NIaRf73TxJmSZpO3XO3RvrzuBD+Q9NM0
 6WtS7OVvZXAANzN2Kzuy6xX0/d4jb3LjNZIHB9Q2PT21FsC2KpblWJGajKHDSGYW+j6D
 agyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lUSDEOIf5cQTvIYD71Y2EbofxxS5ojZqQ3ygwn5iV6c=;
 fh=g23la8ArS4Nn34MD3HfC6B62YjLlgI5XK56hGUzBAPI=;
 b=BUlOXuDsh8AezGXEjnNCgbXBZYrNeM+AZoQ8zTC+YjMU9GegehnLmPNHR0q3Xdi+xj
 1VRNmhIUA/UrzPsiFbTLhu5n5ATUxHxG+zrNbQ7WAbX3qDOBpXJGNEoeKnQ9389NCMYC
 5d+9jQVtySVoPHFVY0i+zcnxFn6ogDCcQqCSvmaPEpJqtZup6nJ1YWWvzu+lniSD5EWt
 qqCAA0mO28CwAoM17UXNWNZN5CFLe0Z/kA2XdGhygIR56I55dGxi3ZUWSC/XAL8u8My1
 xLMpWl0kZ4eUMRyLfhhE6ZW6fvY8y3sLXzNMXvkNWrS1YbutjMxLlU8PbdqX4Dc4C1Hh
 UdqA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785785160; x=1786389960;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lUSDEOIf5cQTvIYD71Y2EbofxxS5ojZqQ3ygwn5iV6c=;
 b=X9JDgCGyT18DzyIU+RnCrf2GE2wed2ks/fbN4wILVLqGqea011ljrQAiaNHYHf6eDL
 Oo8auLfIczYEmFNjPUaZRktVSoz9eO2/h3Xk+fBNvt09i7d+cNpqvn3fRv8g/jU+YFE4
 wTyaaxR4iG9UvPMoX9vnYlleP+lQI+IHQxNEKQQFsEvZFIB14V4x5ROWT/ftNeGHGcod
 hjJjRfrmTUWWXY7yOQ/9jeG1BKB9shfdeJ3sSp2XeE2xwmx+fJBcW1U6NdcVwGweqM2K
 nzQw4TpqhUJAx47mtHtKAgveKY3PTtpwCXjOU1o3WYebd6vZ+ki9ODCYPE0AeJ+mVePi
 lLZQ==
X-Gm-Message-State: AOJu0YzJB7NAriQeUgTpsUBOd2SI8aIT9fPYcAiNLF4yoqsJuPYATjFF
 tXgVDD/PemcUGl+j63LqPkmD5AVUs0eXcbuHvZA6EeiKlw6k7Yf+tSvFrzNjsMGqw6vnzbDcOzm
 q99NznrcM2/xkv4pUEozCwjkrOCJdkVClhCB5NgXJUCfRiPN4hZ4=
X-Gm-Gg: AR+sD12xt3Wijk7OJ5qBLFrUaak486H4WA1QS+Q/O7nd8nBvhWkpUVc1OPhV6xdWtl2
 AsOY7WxhB0VQsAAq1kPLFyHFzAsAB/xXKmGn3vNY+VAWfZzfl75W2WBsXyAqLwhBDqen86iYCzo
 Zfp+1BCXtyOlJOs0Hln+nBsB7FY/cawAWC2HwPBkMMPMmLwsJSn97LjXc/OukF+ZBQ7Q/yx2WEo
 hsFvs9neis+Xf8YaMoiq9g+AMB71N45ldptx+eCzXPueQcUpZ04PJAOFLIgYpdITZ4rWEeu7n/Z
 54xzRQl0qtyvTbeuUzF2wFk5Sh5MLUJPf4MnfCZ7MdVM52YsweOT1aQ=
X-Received: by 2002:a05:6402:2808:b0:6a0:ffb1:9f65 with SMTP id
 4fb4d7f45d1cf-6a0ffb1a521mr3786299a12.20.1785785160049; Mon, 03 Aug 2026
 12:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
In-Reply-To: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Aug 2026 13:25:43 -0600
X-Gm-Features: AUfX_mwFIMtx2gL6BrBYVz9Mzeq__I3gdYf0R-MNnb7WX_dwYQeJQlNNKYKsI8g
Message-ID: <CAFLszTiOZGWLcwMs0Zddk0g5Tjx8fu4xxJk08a1JZ43ZbbcKig@mail.gmail.com>
Subject: Re: [0/3] qemu-x86: Wire up EFI capsule updates on pflash
To: elliotjb@elliotjb.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785785160; x=1786389960;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lUSDEOIf5cQTvIYD71Y2EbofxxS5ojZqQ3ygwn5iV6c=;
 b=FtlbrEzYo2EaHsnt6/dyRQIDbtH96VS8dqjDl7ukEx7qCT51lXFUiD088XW/rokUpw
 lyqxD5TzeAmZpn2To0ywLc2seN0dFZpX5xaJElix6ZnIpK5/2x8/RiQYIrfoTImTB+JR
 n1pkF8k4yBokVOl5UWxt4VTL2FBV7gPJSX4MY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=FtlbrEzY
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

Hi Elliot,

On 2026-07-30T19:37:45, Elliot Berman <elliotjb@elliotjb.com> wrote:

> QEMU's x86 machines map a CFI NOR pflash device, mirroring the mechanism
> qemu-arm64 already uses for capsule updates.

Please add a short section to doc/board/emulation/qemu-x86.rst
covering how to invoke QEMU with -pflash and how to drive a capsule
update. doc/board/emulation/qemu-riscv.rst already does this (see the
pflash and capsule-update paragraphs around lines 45 and 186).

Regards,
Simon
