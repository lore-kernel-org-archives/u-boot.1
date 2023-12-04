Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E37C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EB4F8791A;
	Mon,  4 Dec 2023 09:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zp0aoOdB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05BE8878DA; Mon,  4 Dec 2023 09:39:37 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 094A78791E
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ca0288ebc5so8305841fa.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701679174; x=1702283974; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zBMI0qETzQApIf920zzQxrTmyQ4HIhsHSr+y9uvUYLw=;
 b=Zp0aoOdBlGlpMvybMEu0BnP9PP8Kps3ipeGYnztfXiKzHMD2iYYl0K4hxdYQLxO31i
 MsHQEd1kJGRExbqUirThiSQ64iadilQ+IemAh11c/LO/zIa8aBbGYVBnNRicuNGZbvaR
 G2pbH/uT/Qe9KZIrLA07lS6QS14vFIGa04E4Z92my4i2djI52YIuHRsLGvqAQ8xF5rn+
 5AEJLxR1ivCdb+luzC1cS7/6UW1w3qBgWVx/5O4ArcBFPB44iXta6sKfNVOXp5OHNWab
 6wTyO4/cQHRptRXpOWydD8kQF4zUaiGEzIIbeXe/NNQmRH77NKbXVMI3yUVC7knewW2S
 onIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701679174; x=1702283974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zBMI0qETzQApIf920zzQxrTmyQ4HIhsHSr+y9uvUYLw=;
 b=NGfPIyiwJSl/IAcfSCBgTS95xQKxCG9I2sxMWfGvRHWrd5Q7mgvBvxKqK4DgWI/WOW
 6dD4LasvHRoNfphcVow1Z7jhVmiMxPA22hHtwXgUF/CW5EbhzXLDhHr3t2sVSG17WdrP
 Jjy2rNjQlAmPOiMAenjVhj6UHzgJf2lkE3WNogW0GtAb16q4kGX8amYc5MM2lmueM23w
 mBb8+F0hrbeXo/2UxLOqteq/Bu6AyaFSRTChR//e2NSRngs46xIDCMHxWCRb3kyisMdB
 SenQUm23WvzIxWNBYnq13V/7k5JB6RTO8dsJ91zScdlvzCDqDHhvF4sPnfGMkqqnBYBl
 6sHA==
X-Gm-Message-State: AOJu0YwCOe436h3Y2tTWLzsE3ECr+/e/jrj5b6peQUI4TKzr5BtZLxfD
 ymrB0lhJthaN+ZR/HaoKbMO78m4YsTHJIVcjTOcvPuoQlRPqRNsFPC0=
X-Google-Smtp-Source: AGHT+IFsqofMzm0DgpnI4oCXPfNiEtzdqIbFkZql5Y5mvHRWNWsM2gQ+5/W4x5ExGDsxAVa3ZtzWuhxerxCzUPLmuQo=
X-Received: by 2002:a2e:8199:0:b0:2c9:ea36:2389 with SMTP id
 e25-20020a2e8199000000b002c9ea362389mr1552019ljg.62.1701679174343; Mon, 04
 Dec 2023 00:39:34 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-13-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-13-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Dec 2023 10:38:58 +0200
Message-ID: <CAC_iWj+z_g4JdATWyYXDuAuUuFgCOEHzsVSwn89phnimtkvtEg@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] bloblist: Reduce bloblist header size
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, Bin Meng <bmeng.cn@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
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

Ah I guess this fixes my concerns on patch #6

On Mon, 27 Nov 2023 at 21:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> The v0.9 spec provides for a 16-byte header with fewer fields. Update
> the implementation to match this.
>
> This also adds an alignment field.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  include/bloblist.h | 26 +++++++++++++-------------
>  test/bloblist.c    |  6 +++---
>  2 files changed, 16 insertions(+), 16 deletions(-)




>
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 745bcdd227..57625ea004 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -164,30 +164,30 @@ enum bloblist_tag_t {
>   * from the last.
>   *
>   * @magic: BLOBLIST_MAGIC
> + * @chksum: checksum for the entire bloblist allocated area. Since any of the
> + *     blobs can be altered after being created, this checksum is only valid
> + *     when the bloblist is finalised before jumping to the next stage of boot.
> + *     This is the value needed to make all chechksummed bytes sum to 0

typos checksummed and finalized

[...]

With the typos fixed

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
