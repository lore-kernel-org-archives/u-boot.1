Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B783C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCF8760830;
	Thu,  6 Aug 2026 21:04:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mh-ywndbonik; Thu,  6 Aug 2026 21:04:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C7E3605CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050261;
	bh=geq+CKfKxxpWpotoi+2npW7wRCZflTwQopSe1nIyKOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SjphxJds+QyReJHtXOqB0iVJ83+2XH7iu+aZryXu3JM+KVREAkWzhF9OD/QocPto8
	 udG9H/qFPFzY4rpXl9t5NQphYyLUc+HnWMyXGL74f6PPm4jx+ILKmAEClKORPC6gzw
	 dtOJvW4NWuI4P8sMBfphv2Q69K9PjQOUQq3pafzxk2rfzM3JmhOXXnslxivu2wckfn
	 Y+BrF7QttwV589BZyHqkxgNNUCR5QTXL68MHQwWIQFOXhJl0lQiTSmW5UY3vyvbaQI
	 AuG+F2ByybyNgsVNPtxpQ/imfxQqlbY2u3C2SJkSntJOCXGtzYAZnz9UyLFJD67cZR
	 pmJPfCBEIa7zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C7E3605CA;
	Thu,  6 Aug 2026 21:04:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 57E98218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E8EA4086E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1zbCJCxQ3bQb for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:04:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2436D407FB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2436D407FB
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2436D407FB
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:04:18 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so4299373a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050256; cv=none;
 d=google.com; s=arc-20260327;
 b=XzmU0WaXADZFE8/AZxR1s+YrZAcZIL+qfWvpMrcoEpxIO55OvTqQlgyhOmIByNSjgn
 PoPwVvF7NTJ6xxDi3NtlfoRTYqbaGEF3cVyXCP5n1qB44VWALg+9vUV2Xoa+ZSfGUB6u
 sHekw9BEiVycX75rqrZ9fX7xb7j1ZDbo5JJ0kTmQgnIptYipmc66rF5lrg+HbClfu35j
 aK69SmI/kUXpG30AOSz51ab6sZZw11eP9tKJI8ghJwMaUz7TRguB/SGurXynFH88LfBD
 zRw6G7t8QJt93zDNQGFgZCz5f2S2OG5cGYURlH5Sm9W8VewHfnlB070GixAKhvnXA+ji
 QCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=geq+CKfKxxpWpotoi+2npW7wRCZflTwQopSe1nIyKOc=;
 fh=Ye9d8c9UuIgjdEYE5AmpFdHtipkFyQbZju95WIBagdg=;
 b=Z88q5CpM/Fyygdf825XH0ajc9MPePvZm0CIo2Hut1dvr+ae0HKXQMS8ZSmmdItB+4I
 beXKVLyRVgCy1WljofNBtYHtGB8FKrWrIjteigKSPu6vKYP+4wmT7gqRxlIMCzrVdShD
 Ag0bQkgG57vujTo3pwVtGkyyrg6uos/eBHBF4+jqgLuuBQGPKvhNMe5UUt1d4mONLDxl
 /nUsVkXe2k1aBSRx+I5RWpZLAyVi2sw1AEbIJ4BtXtui0CQY3CWiUyMbOEmbYpYcZYXJ
 r4wJUzgxqQ4TWJ4us3dbnyOk+zjHlRvXX3YWzh2syVxGlEhhtJ4WiBfmqzjwP44mi2Wk
 ZNmw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050256; x=1786655056;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=geq+CKfKxxpWpotoi+2npW7wRCZflTwQopSe1nIyKOc=;
 b=pkPXVPaN+Kivgak1iXU+y/u5Pz6neiH64JYQ9p3+qTBgZfDOYiAld2u2HZpHywY2/A
 flmAci003sseYmG41Hbw8Ejt3Bk6V11qLWrxXGa2rLLTWc3eS6X5MZkhsQBdrPDnEmzN
 RMovPsG3VrLlRWKXIY0MUXztMjAZViwc1mUJq5FabychCD3sdyZT429PF9fF41eKgHyK
 oz6xbOM0gN2nJgbxgJlGB1g0g1+a/xNCSuuAy1VUBk2iXMS/dOi4X6CxzwXtuGe1nORk
 OY6Ov+Tjvi34iO0GGkMYP+YLuTQWIBrmKBxs3F1L7+jlBM0V+lYkL7OJsaMPUwRm4oIy
 7ooA==
X-Gm-Message-State: AOJu0YwbjJfK8XaNvY9PT3/XdDsM3Inu1gsXE6lV2PoklMqEviuMhhTj
 w7AG5K1+R12XTd30vJAysALwfm6v+kQwNG1WbSZeCNZALuuJPoXeED4t91OXiRh4gpvu8qPnkvT
 LB47xQTE982GJOaSqbjzKgTyPWSlC6nIBekszaNlo
X-Gm-Gg: AR+sD123Xm46cstM07/BZXapZLvCiDiDB+AZmaQBMUCrx43e5oXR5pHHy8WRtt6hdhi
 xJ6aNuCvEnhCwFNi14IpsRVri7xYvtAiRV3jA5lg4VNvy3YbvcW8w7ElJAtwotVIyYrKhcpJtMv
 vJpQQ8znuXT1K/44ORy3L7M7Am1+CgR4ssV/HSjXe84c+xN6eBA4ojym3D/TilOut8XxLV9Cojm
 Oaw5OTAPOgZAMsNE+vyFCvSEJKq3XYGregszPHUy4wo+fIRDKaVRAL9IkpQKRxDc8Z6+LrCg15g
 R+4chTCsbkba6VQGw6EQorRCiv2YW8PB6rD+stLYdd4=
X-Received: by 2002:a05:6402:534a:b0:69f:aecf:bb2d with SMTP id
 4fb4d7f45d1cf-6a14f26b856mr7608480a12.17.1786050256168; Thu, 06 Aug 2026
 14:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-3-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-3-01746157643d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:04:00 -0600
X-Gm-Features: AUfX_mymskJR-zeJk89LIY1044INmzjHYCJnFF9lB3lavFSiD_SP4lrKTVO7wiY
Message-ID: <CAFLszTikZeewCL-wFJqu7jmY1perk26bqy3U+hy7F1fu9xF6ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] soc: add data to identify the am62lx
To: bb@ti.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050256; x=1786655056;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=geq+CKfKxxpWpotoi+2npW7wRCZflTwQopSe1nIyKOc=;
 b=eKTQ4/B+XsLYeZeGDimOlZCSZYfnfVK6EXL5chBzfr1mZJIStcStEt9MDpj7BCObOb
 ZzQWIEsudBP9aWETehZs2gbkhXoNnuiS0oWGwBDiMZvAfJ/0dqL7+GGEX7HS9BwxZmy1
 6TfI9mNpEtcXdamUp0V5X9x8Xi2Ecw9Iq29iw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=eKTQ4/B+
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

On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> soc: add data to identify the am62lx
>
> Include the part number for TI's am62lx family of SoCs so we can
> properly identify it during boot.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Acked-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
>
> arch/arm/mach-k3/include/mach/hardware.h |  2 ++
>  drivers/soc/soc_ti_k3.c                  | 11 +++++++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
