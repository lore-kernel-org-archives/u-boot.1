Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3A8CD5BD6
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 15:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C7686A84;
	Tue, 19 Sep 2023 17:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JqS8x0G5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C1DB86AD0; Tue, 19 Sep 2023 17:27:30 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9C186993
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 17:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53136a13cd4so2386239a12.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695137247; x=1695742047; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7IiDhzqVRViaPiP3Yrz/dU073U7qJAZKLNrsBgMV2Tw=;
 b=JqS8x0G5mvm3q/od3XIk3GZ+kte/+ENngEa1ukQDKw+2akBfYxIfECT/q7+sbbhuli
 UxAs9QFImLuyybDAhL5nMHqqqrQIJdxbLxvZxIx+994h6rBvOW2+uiGATxpLEkU9mJyX
 nxVzmzstLQSxkWinfb5CexCiUkTPsB+yWeVKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695137247; x=1695742047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7IiDhzqVRViaPiP3Yrz/dU073U7qJAZKLNrsBgMV2Tw=;
 b=w+Xlzvz35dxXbdG8Bsdm06jQfHxYv4fss5sYZLkluXqzabLobdAE5xW2qmqAWcxX4o
 Bv18aFleale72QAMBemdXiizICKiCV6s0o7bCCNy0Py7f+KuTWRTf5s0IgTBc2GQokz2
 I5JSj7D/LLk52Y/nYWmoYrd6hbRIMKIHmMcKl1BKQpdGQhi/QRST8GQ3LAktR2zLXKSz
 qoJVJ0NkMX89AIDblLSrgPmz8zEX4xDSQdkuPcruFEo6mHxW5gX0xj5MMyzGGfl+dHBQ
 KvraCBjEhT3XXVYAEKc3yKnNiH5xXx1csV7i5sRdk8PepY4oRPugHyAm62g+gNSesu51
 D1zg==
X-Gm-Message-State: AOJu0YxfBuCRbo6Ik/7LnCMzHXVJEbXj7MiSC34phkCLLwQuAfkwK9GO
 R2nI8YnFbvdARbz2ky2AYshz1zDFmnp9hTuKnxdRsg==
X-Google-Smtp-Source: AGHT+IEShODQtR6RpsbkfAzvQ/ybHrV9M952GG7Y+mw69LaMX/6Ci6R6Yot+oMMY9xVeekh9lPjb/tEBBQHmfDHNn1Y=
X-Received: by 2002:a05:6402:14c8:b0:52f:bd60:b54b with SMTP id
 f8-20020a05640214c800b0052fbd60b54bmr12402599edx.37.1695137247467; Tue, 19
 Sep 2023 08:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org>
In-Reply-To: <20230907214012.74978-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Sep 2023 09:27:09 -0600
Message-ID: <CAPnjgZ1Twk4Vq9OXEUeYUK4VXXC_niMzc47ZLk4Zf7f822K5iw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] schemas: Add some common reserved-memory usages
To: devicetree@vger.kernel.org
Cc: Dhaval Sharma <dhaval@rivosinc.com>, Guo Dong <guo.dong@intel.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Yunhui Cui <cuiyunhui@bytedance.com>, 
 Chiu Chasel <chasel.chiu@intel.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-acpi@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Ard Biesheuvel <ardb@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>, Gua Guo <gua.guo@intel.com>, 
 ron minnich <rminnich@gmail.com>
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

Hi,

On Thu, 7 Sept 2023 at 15:40, Simon Glass <sjg@chromium.org> wrote:
>
> It is common to split firmware into 'Platform Init', which does the
> initial hardware setup and a "Payload" which selects the OS to be booted.
> Thus an handover interface is required between these two pieces.
>
> This aims to provide an small schema addition for the memory mapping
> needed to keep these two pieces working together well.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v6:
> - Drop mention of UEFI
> - Use compatible strings instead of node names
>
> Changes in v5:
> - Drop the memory-map node (should have done that in v4)
> - Tidy up schema a bit
>
> Changes in v4:
> - Make use of the reserved-memory node instead of creating a new one
>
> Changes in v3:
> - Reword commit message again
> - cc a lot more people, from the FFI patch
> - Split out the attributes into the /memory nodes
>
> Changes in v2:
> - Reword commit message
>
>  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml

If there are no more comments could these two patches be applied, please?

Regards,
Simon
