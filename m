Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43221C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 16:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8212983A92;
	Fri,  1 Aug 2025 18:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RnbPFrBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B25C83AC5; Fri,  1 Aug 2025 18:32:05 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD0283A81
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 18:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73e810dc03bso463626a34.3
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754065921; x=1754670721; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5V3U/V+/n1vJIH6/RNrF1PPgD+sfcqh56Lcq3QEqnA0=;
 b=RnbPFrBDBPyXizhr3bLa40f28DExgZTgLNaIFizAVi52i6Yw1WGJwgL+9VEHqXtVIf
 fwg3LEapoOuSyAdgsOSN85+ew9Sm4qBQXuvwCSMuhU+fy37Sr5sPMbYHOx+5kwUBlR/Q
 IqU/bVMabfFZQV1vU6MHMauPeXOi+M7hJ4MjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754065921; x=1754670721;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5V3U/V+/n1vJIH6/RNrF1PPgD+sfcqh56Lcq3QEqnA0=;
 b=Nf7wA1Tt2wuvzA5wH+5wjB6h7noAmO1QUEzhC+vP+pckS15gvllqh3OL86Iq15DYJt
 8kG1YmrtB/4qCkPU+Cpe1Qm0zSn/5P2pnbzgSHi1scbw7dt19x/8TSem5UM2pSPMpQP3
 tzp+z545IyL7HaK9r6TDrzxUbZLkoBNnTrk64eOEt2ER2rQAljKAKZYPeJMqEhmLzJPH
 JjQadeWrOIQ6GhufhpvS6jKNU7ugpolssT8Yjs98k/h1BWAMkZ2zTin5wYOPCKiCM6ls
 Tx11bn+dWXFlK6FqVDzFG+rmwr9LBjO1xc+XHeiseBvZ2mW5/Miom6uBTUrMQuPbYu+y
 CO/g==
X-Gm-Message-State: AOJu0YwasatKZf6EnBIN2n//aY5FdqiMbH1VdqHpqN6grl/JOPqg4Oyw
 nI+GyR6t6LJS6NbCpvd5waZmoi+KX3Q1wLLCKgWrObnjeWUTdITK2DBFmllVDZG3d4Eyc4jGdDf
 VztezE4Q=
X-Gm-Gg: ASbGncuQCHGZRt2l98yQ8W7/iH7OrbDUjN/SAlkTkC+K3U/93zRmxXa52wFDz4frXis
 ADbpaJdutgdLzci1M/Dluk7jcmL9VJIF5RJaf0b7xNUCKpOX8FRhkFlZolWLKFR+1dKtTjRq302
 0VCUjjfCQPgE/1u+WGsWbSD6z1h3JVyuVl5R/ikzc6OgjBzLeLt03f17nV2XvSXrj+lWizYRW7s
 J5F4VNZSW4eh8tr/GvoT2GybEmF7+yBOMzAiNDuN30Lek0Q4ofHSnOmE19BPXP9xPjyVlzS2II6
 z+415Jy9X0FltnPB8vCnoclgXDwE8nA1Yyi0KS+gQe7bum4D/YCJ+xwZOarRxLelKLEVc9E6Fny
 I0eHk3QF/tkRwdnF1uGBoZgQpuRrZffo8jnG1yE6BO8YxSYCo06o3Cuo=
X-Google-Smtp-Source: AGHT+IGkVJ5uvX0XqnOmuM8JVkrnL91RLisONFxoiymtALLV/t/xy3rwgiWwQohylnKFNqVmqoQALA==
X-Received: by 2002:a05:6830:d05:b0:73c:d14a:cb0 with SMTP id
 46e09a7af769-7419d0f8bb2mr72233a34.6.1754065921097; 
 Fri, 01 Aug 2025 09:32:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74186cc4d2csm841099a34.14.2025.08.01.09.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 09:31:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <fd7715fe-1d52-4b29-9a6f-bd0f36de0416@linaro.org>
References: <fd7715fe-1d52-4b29-9a6f-bd0f36de0416@linaro.org>
Subject: Re: Please pull net-20250801
Message-Id: <175406591913.3981651.11422641948301751352.b4-ty@konsulko.com>
Date: Fri, 01 Aug 2025 10:31:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 01 Aug 2025 12:34:15 +0200, Jerome Forissier wrote:

> The following changes since commit f5e968a28e7cdc2c4365f5a382e02f074ee03fac:
> 
>   Merge tag 'u-boot-stm32-20250731' of https://source.denx.de/u-boot/custodians/u-boot-stm (2025-07-31 10:04:32 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20250801
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


