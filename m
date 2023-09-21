Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C069CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D3286CC8;
	Thu, 21 Sep 2023 03:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cAdWn50Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40EB986CB8; Thu, 21 Sep 2023 03:02:51 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2701A86C9E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50317080342so817035e87.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258167; x=1695862967; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HKebkDk0fHIqaIARZQlODTfAnIrCkd0UZcX3w8W8FJo=;
 b=cAdWn50QdgVu004yekLpS3QDWP6F7WzO5gYvPLbGUQLXI//4saFpkj6nHTGQXzpPBx
 MBxR51iKYoDTqyGrPuCK36iS7/Ai4+d8/VCQZZM7QfM/CQvonnzlfcp8XxHRya7tRMO8
 //FpR5QU8GOHrG0X7tsi8S1WucrhnnF9UYJ6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258167; x=1695862967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKebkDk0fHIqaIARZQlODTfAnIrCkd0UZcX3w8W8FJo=;
 b=L61axlC2Rn6Z7Pc8WGWd01ESkKBBmjrG1PykhqLMze93R+E4dJrcWcJnkQGhoDpNMh
 s5QdoEK+tGTICknW9PJ1Me+6T3j8PMKYTeU9sGPqZOF/nm/AqeoxRqzyatWfiaGALKIj
 pD/MiBFsBti+6pipGFb1uf6ZvE1CBFR6Kw+CtgatYqEAF9Re+u3iPPVGHN3LVUvFpmX0
 ejxHMhE7p7SIQkvUEFNYSSAWI59u9iAa1WR7jkiST27xjcQY4BE42rw4x7EOwJhPf8m+
 ZIa1bjOXPpfJQ4sjZVvRFEktJmO1lzkbU1Xp0369e79a2LFA2oFv5mK9ry+xU3tyMA6G
 rs1A==
X-Gm-Message-State: AOJu0Ywa45K/n5c006xY4j/9N630CXdlow0uiKU8VHw8ZxPWRtxo/xLs
 8e65RE3R7Zr69WCN3OfjwNwg2PHJc6HcOXXDb/ei2k7DFg6vp7ULgIU=
X-Google-Smtp-Source: AGHT+IGnIHDILK2WmX+mEAGtY96WVrmocPB0mEDSax61R06uptldg5QjA7xn6L9sJCHY3Z7jUApnK1Dh1xidrVGqKvo=
X-Received: by 2002:a19:6746:0:b0:500:c348:7efb with SMTP id
 e6-20020a196746000000b00500c3487efbmr3599633lfj.48.1695258167399; Wed, 20 Sep
 2023 18:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230912213504.65513-1-seanedmond@linux.microsoft.com>
 <20230912213504.65513-3-seanedmond@linux.microsoft.com>
In-Reply-To: <20230912213504.65513-3-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:32 -0600
Message-ID: <CAPnjgZ1Tob33znjJKxg+jBdHC7moGhg61VDUidOaWgH5946zBA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] fdt: kaslr seed from RNG device
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 12 Sept 2023 at 15:35, <seanedmond@linux.microsoft.com> wrote:
>
> From: Dhananjay Phadke <dphadke@linux.microsoft.com>
>
> Add support for KASLR seed from the RNG device. Invokes dm_rng_read()
> API to read 8-bytes of random bytes.  Performs the FDT fixup using event
> spy.  To enable use CONFIG_KASLR_RNG_SEED
>
> Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
> Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  common/fdt_support.c | 36 ++++++++++++++++++++++++++++++++++++
>  lib/Kconfig          |  7 +++++++
>  2 files changed, 43 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Note that with VBE this is deterministic, in that the kernel declares
what it wants. See bootmeth_vbe_ft_fixup()
