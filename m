Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAADC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86CA3878F1;
	Tue, 26 Dec 2023 10:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MFFsHIqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 777818794B; Tue, 26 Dec 2023 10:50:24 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B370F87687
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so3322457a12.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584219; x=1704189019; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dgz0BcBdZUhwTJb6g6gbD1bkfA2zP2lFeNYR05XcjFA=;
 b=MFFsHIqgSdOh2Z5+XHLJfge+F/uf8GBmRNyoMZ5F0/qId2/HNOrOAbEyi5QGxEs/rV
 OBW2Eaaszdv2PYa2J6mUU681dnfvSpajXZz5eJMN9qos8b4iIlGnvqFbMw8acSZNwSdV
 nI4MDJZVGD7Caeg3b9Cig6ytPLPGJTuw6IHI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584219; x=1704189019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dgz0BcBdZUhwTJb6g6gbD1bkfA2zP2lFeNYR05XcjFA=;
 b=Aq7/VL6QhXxon+VkqSdUSO9Cszo3nzzWQ7BaR0qirYQhW0fEFQg6XRndx2tJT9qRdP
 rHDmIfd76wbTXIhvEqCqGJnnU436utfmbYQraePTOOivpqHFsn3GvQcavB8lpq6m5uA4
 ilKxSH7NmvXqTV9xaiAgg3oV3Pvn8weKLTmhQFTDbOibu5qeb8q4xdSw5294tPeEva0S
 M6nshODS++v+IdS/2rRX0u8xYCDkbfcPu7gebbpzTamcw3o7C1VfXTYmvDRBATcJdsDh
 MT+hvVsAIVdd2ecu4QsxAEAaE7wQ6IrkOt1jdR+osEBH91Unu4c0/xYXjiqN1qSZ9Sx5
 soUw==
X-Gm-Message-State: AOJu0YyWqbbNyXtF7UyswI75epAJZ8RfQchh/l/S72wrcQjDrekyPmts
 MCbeEpd4ZbZdX7GH+dRbxNmmncvCcH/kfauLG972eQ3HRPfh
X-Google-Smtp-Source: AGHT+IFb8++DRpWbWZ2HKpJupUHjmm75rn7Y5iTJkyqhUFbj0BB4RntmlzP9NGcNBixc7SelvsKfKGI1GTlFU1UT4iw=
X-Received: by 2002:a05:6a21:32a6:b0:18c:4811:cf69 with SMTP id
 yt38-20020a056a2132a600b0018c4811cf69mr9604356pzb.61.1703584219708; Tue, 26
 Dec 2023 01:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20231211122051.1240855-1-lukas.funke-oss@weidmueller.com>
 <20231211122051.1240855-3-lukas.funke-oss@weidmueller.com>
In-Reply-To: <20231211122051.1240855-3-lukas.funke-oss@weidmueller.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:07 +0000
Message-ID: <CAFLszTjU8BjV2ThHwDEoKB2vdy7oWNreGYx8XTp=YsinNs_P-w@mail.gmail.com>
Subject: Re: [PATCH 2/5] linux: bitmap.h: add 'for_each_set_bitrange'
 iteration macro
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Lukas Funke <lukas.funke@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Dec 11, 2023 at 12:21=E2=80=AFPM <lukas.funke-oss@weidmueller.com> =
wrote:
>
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> Add 'for_each_set_bitrange' (from Linux kernel) in order to iterate
> over each set bitrange of a bitmap. This becomes handy if one wants
> to generate a cpu list i.e. for isolcpu or nohz_full.
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>
>  include/linux/bitmap.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
