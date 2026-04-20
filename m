Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60DBEA71A4
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D9783B99;
	Mon, 20 Apr 2026 04:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EMiofCAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 406AE8422D; Mon, 20 Apr 2026 04:57:55 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B4A83693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so22163405ad.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653871; cv=none;
 d=google.com; s=arc-20240605;
 b=SQz1mRFwaiiq4/mc2+sD6LUAZOVKX40Euww8ge6ZKNdqzJ5Y8yaHUMnWH+mZsRa75j
 gAm6UDbwYaiuxTnNMKeWf4QwL+2blCCoITPwCqeJk2rZWQMeP50L1MVqTdod76+01o8M
 mDNlqvnnG19f0SFsBd6I1s01v95VgPFOHGqPryXurSCPU80F/zQXiP31dRV7co3nXdsu
 OmjYK2uLxZoNiqoiNt2//7jw19LaD301uuaeuLOHuvp4XkOregOehcLRnVHwl4quHA05
 lveez4mgoIaDnmFDdDA4qIRMteVl1mx1nZ7Be0PCx/MBH46cpat3BKcoLYg+Mi9EO+EW
 sS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wudQF+Ja82IgPQ6GA/dv/UKo+eOEl2Zd8/MgT3T/RQM=;
 fh=bAhO/2+dJLNIuyiSCWCsiQQck7gcMCfIwltRjKz8q4g=;
 b=ULsj2f0reoAXlw0yGRot4NFKkQ99aSAXg2aaH607ffsD7FAI1V1luljouqkVQgcUA7
 OYrR5y393NngohINRGSbPVI74qETky1yi0UVvtbXv/R2LEUpZtNFFAnac/u/GSjcRtib
 3OQgdit6bPak2IUvNXBlPgVWvaGaZWCV92F0Ihu6K2dXFNOYbYqVPy8yoQO6i3wYhD49
 pJADY5PpKcIJ0bqVotXqVErXqHH1QkhfNNZJqMDWjdDhXcfGpIjzcE8lmO7/hGHjn3ZZ
 qlyuqfcLZjiuXRA3UhnNuNvo9j5oeXX590gB+XBktRtQM0Sa1MPgj4l9pdtG9zopfO4U
 9QGQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653871; x=1777258671; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wudQF+Ja82IgPQ6GA/dv/UKo+eOEl2Zd8/MgT3T/RQM=;
 b=EMiofCAbNi2gKMDOc7bvjV/QlGfIJryTAsz4EbQz7MYyYyLGJGwWT9VyRa7IBzEPC2
 iMTpL0QyV69xRwOitEqP+IrZoV0/Ft2vYwAiMehQa3czcsvsCSiUv+fMoSzsTw95japJ
 TF0/sTNOTt1dXV7tCZeJl922pZYUJUpJcap98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653871; x=1777258671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wudQF+Ja82IgPQ6GA/dv/UKo+eOEl2Zd8/MgT3T/RQM=;
 b=svYPkXzQ9Xab/OIB2UhhnJPOJaVsvWDBKq/qA+YxSZLQHlcB4AiadIKSzpliT17KE2
 3ndaVK7DW0k1vc/IIFfs/r+TFuOLpxtWJKA1Zl8m8nujy2nsxtLF46VnjyM2dTjGxiOE
 baag5c34YU20hHW5PLjBXaYGCEwCFXac41BXs3YSN9ptwn7C697xf0sT9c0E9OUVyvPp
 UEp321HPXljf25kal6UmnRkBe4vaRzXAeILHeKige/YEdV34/ruiT4MFHlJ19bU64Kp2
 82e8fVziMf13AQHEG+FIcJiM6GHrvZX45bgSSm4CqKfhByqqBIuEwgn0jgt2g3qk1Gwv
 SMXQ==
X-Gm-Message-State: AOJu0Yyqov6GiwQiM12mm7thJQIC3tr+BTvdIu8CyuztDHs2xPr6q+nH
 VWnLzJz1wpJMo+DsXPtMxLWyKmEriBUdbo5vDSDHBZC3HEhOmh24WDmKaGvSS8G3IRwyvTgpyaH
 OzNqTjfbsOPfg6rzANLXY5B2yJM/xorXQl7E/UK8P
X-Gm-Gg: AeBDietJ/exPZeSAhkbUTJv9Y8chQ5kww0nGZUzJkHiIehcQ7HFOR0LyNVY1LTwCq5R
 kJJwsKoi/ViKZASaKMFwXWWxk1dumEVwzoLFn/iHJ2fwjVuMSeVx387Z49n385DWFKMmmejFbzf
 xrVMYlK0YRliSe/npcmXInzBEp0qrs0192MNsvTRH/EZ2ojdo5NfjkQnLQ8YO1JcCY0ETdD6ZgO
 I1HKsymkEQN9bWychL6ppr3UW6Xl3NHsREqWXm95MmqptLvnlfgNM6bYbIkD9S0GHi9VY7kPtfr
 5hGhYOq3nBe5aFnULOsKxyDxWyX5ZI0=
X-Received: by 2002:a17:903:32c9:b0:2b0:5923:5194 with SMTP id
 d9443c01a7336-2b5f9fa70e1mr119346765ad.27.1776653870972; Sun, 19 Apr 2026
 19:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <d94f35e58449d36e93362ac5733cb5d6b6c70fbf.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <d94f35e58449d36e93362ac5733cb5d6b6c70fbf.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:57:32 +1200
X-Gm-Features: AQROBzAxZ3GzGRRBtsJjkcqEd1HO1ZdpovDwOGaXw8F08Td1Iz6xzSY7FaRSNUg
Message-ID: <CAFLszTgO96nwaO5_Za2tKbeWX8HnzxS-3m0yx=kmvNHFtvtOXg@mail.gmail.com>
Subject: Re: [RESEND v4 11/14] configs: sc5xx: Set default bootcmd to SPI boot
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> configs: sc5xx: Set default bootcmd to SPI boot
>
> Align configs to use the same default bootcommand.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> configs/sc589-ezkit_defconfig          | 2 +-
>  configs/sc589-mini_defconfig           | 2 +-
>  configs/sc594-som-ezkit-spl_defconfig  | 2 +-
>  configs/sc594-som-ezlite-spl_defconfig | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

> diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
> @@ -15,7 +15,7 @@ CONFIG_FIT=y
> -CONFIG_BOOTCOMMAND="run ospiboot"
> +CONFIG_BOOTCOMMAND="run spiboot"

Reviewed-by: Simon Glass <sjg@chromium.org>
