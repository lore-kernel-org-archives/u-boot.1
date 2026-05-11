Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AE5CD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD05C838BB;
	Mon, 11 May 2026 20:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g/6wHnKM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 658F180398; Mon, 11 May 2026 20:08:10 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEBE68341A
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bcda7765d64so291650666b.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778522886; cv=none;
 d=google.com; s=arc-20240605;
 b=Y0j5mNNVEhsKjzTP55wI6ccCblqRsXoz9n/y5TdQ/Bwg/XqYnEuj0Cr11xWaVv0Okp
 xG+kzTV+Blok1ZKLxhnL3JLZgGlg5h6iYdu7FxDRkE2dTQR1dcNo/UO+UuuJ7DtJavjA
 3fQJUht/+dE2WHCrCnKiBVaieJt0VYw1v/EEhEut/yC/IBPY8w54LOUY7hhcer5ZDhP5
 M1zPvzpn6NhOwzWJIrTg7Z+CkU6aTQP6tZVF8ZCT5vuUedIUYytWK4GHgvF70DcvlZMu
 E0epLZ2hnC4JWStHDtqzeDONqRRA4hTUJUb0b3kuyO2fuTPPgu+l/QclVqeeqHvZ7rGW
 BR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=geQUIbsdF6ZO7DPffX3jx2YFnn3sFXKfIRF4uTE0n8Y=;
 fh=Scn8Joqle4yweNpfVUSjPYEkltLEef7DfonlSmtQc3M=;
 b=jb2koysyj9EPVkPZlGd+Tlf65yxYHycdmc4wk4araT+zaljeG74Nh5kGmxV+Oz0hOO
 32CSmPnP5lGB9x6doHU2vRhqDg6uS29iCl4Z/FN74QTflX5U2wFFtdrMIRg/8Mp70Hfs
 ZFovzBF+wCq/ZXuzWSmdKFRSBdKViWyyyLewwlX7RV7h0TfDYdj35vvUFV7a2wwY76jy
 UU77gIUmvuBnVklVy2rEwDmDIMo7TR1A78aMP4kmm4TBatPyW+CLDzNws77JLS8O+mY7
 FxRGTRw39aIYAwqmJ85gFyqvvCxvp2w+3M3YgbnWTgVc+I4s6HyhxHn4vcub8m7Y1AlW
 0GSQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778522886; x=1779127686; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=geQUIbsdF6ZO7DPffX3jx2YFnn3sFXKfIRF4uTE0n8Y=;
 b=g/6wHnKMHp5nsAt7iX2b3VTOhfrF20PSptSkNXrnwfDK3O0GEGlk9k/mk/raNCU3fI
 vYvD/nbPiDgevBLPm9Usn9RwX2NwtlfWQ0lUvc/BQpzpCFv4CJhc1XXWPrDZDxa7YNVu
 gb/08oWxGf3BrwxfVB1FHAYyGmbxYAjz/7BhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778522886; x=1779127686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=geQUIbsdF6ZO7DPffX3jx2YFnn3sFXKfIRF4uTE0n8Y=;
 b=B/KqfzDszcqN56qcs1gXExF2l73umx1UYMpNSot572mPn3Sk1nVnhYqjvJihkTz0F2
 cYbYCWgnTpK8aF2oAzRwh6mCy2ITYn9cmi2Ef7hSB+jq1gL+vr8QrMgq/NSNxFBPMTTH
 SKXInLtDQOD/Fz3Pg6kMtmFbNDonvbn4DHQXjInex/0OG1dme+gtl98LDEG0ZJJeFV/m
 fYWt4/89t7MyW9VrAINLh1DghDb12m8pnk1y6MOFrSIsnekpb20Ukulk34TvlMptR8rq
 SWGgqEH3BdLxKsvb5JCbvmI/QHmvViw8sPebPbq5ZhalH53aFVWH3uGTsxk4dOc1OeOF
 urVg==
X-Gm-Message-State: AOJu0YxLipHKEgfFIcfScjpG8JkYUu7hl5knYpw08nIH7c31U38aft7w
 yOjrXvlX8QcbU3MBYR/0JYs66v2ofG9ZLoGiafdKTTV1kyYVUEagcTqKGY5cYm59FHOuXEehuqS
 czTjSwe4A4vS6agbc+ZQPJ6qqpu4uU/WfqFOBzI/AeX6lg2JWUfA=
X-Gm-Gg: Acq92OHscYbRLt9oqTySwKYksIAmmHujn5p5fSwgASsCl9zbX0k+bSoP0XymSixzd3Y
 TZbZyu2H+Rp4UMW0JgFjPX/qViQJtY+uzMsaLBb+O75TdX7x3g+KbFS/EEwin2q9wYtStIJ5HhK
 rvRKffEx3xG2cp64bVAFgBYRNd3kltUk1PeAilGE6mdq4PMi5Bb2YlKNhG9iayf2S/z4RQEvAv0
 LGbpu+J/g61y/eZxh7gyujJqmX+sE37NRmCp90loJTURnzB6h5B7dTjqPKKDblgrzDmC6FzVsEv
 80z41LGNiSsNRnfc
X-Received: by 2002:a17:907:c8c4:b0:bc6:bb4b:1726 with SMTP id
 a640c23a62f3a-bd23bff618emr38994366b.22.1778522886331; Mon, 11 May 2026
 11:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-11-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 12:07:53 -0600
X-Gm-Features: AVHnY4KV3Q2w1jVIxWWT7pQZ24Wa2GZKxUpXlvgO-reczuUdd9KBMitLR69Yg14
Message-ID: <CAFLszTgpRsBvTdM9=AfBSZ6nv=X7f7va69hNjiS4QASNfNPqLA@mail.gmail.com>
Subject: Re: [PATCH 11/11] video: tegra: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>
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

On 2026-05-10T17:16:56, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> video: tegra: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Acked-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> drivers/video/tegra/dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
