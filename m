Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EFFEA71A4
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617FD8422D;
	Mon, 20 Apr 2026 04:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mSIDEueD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2209842B7; Mon, 20 Apr 2026 04:56:29 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD6B083FF5
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba5b107eaa2so249093166b.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653787; cv=none;
 d=google.com; s=arc-20240605;
 b=fDDmUshkoeX5bxdVxyvnPHGI2HejPHtwkOClloSyV7tGe1t2RiipwVy2zoVq7cseOW
 UDKuB02tSZ2OqArNUIGKBpi6VUEMOoBjWxTsLo3UreNkzVhq2+uBrd6R1jrzzaBZBjWw
 3n8mdSBo/rrqCqHNAhmiVITXweXQ05akMS0v5mr8DYaT+7q0ZCuYWLeL96GeFDegktcy
 5iu0SxZ1Uwl8Bu/U4FZcDTR5o66bGzxZSz9rB6MGGMSIQ9OLhsv3wTnDogqF+f5IXelY
 gwEti1YsMJV8J5wpq5DqieuMRss0diCsv4LaOW3ja9+DrADO/OjfnDhfdLCAswxXeyVK
 K2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/ajt+NzgkDI4TpK8YHeIedNrVS5cNke2Y/2wYQOhC3Y=;
 fh=bAhO/2+dJLNIuyiSCWCsiQQck7gcMCfIwltRjKz8q4g=;
 b=ekDr2ayF5SceiAmWLA+Xm7W4dPITaXGf4eKCQ2fp/cCNx9nvNK8oGLyiwKF0RxZPag
 hJowa4SSbikuoepty3AGAeYMpUKySh5Zv6FhC5LMdfa9Oc+H7/oJcKXoqwBsrEiSKKdF
 0RjWL7GOlfPVlstGdMz6g8woyR0pc5ZlmfGIg801ZGHHecgHOthuYhEhdnoY0HbzGlyZ
 qznnu+346+JhAT9lhf/QFYF+jBUVh3f9OUiSx8fqpRz6EcOJ4EKMoxY/SFCTpnmJTs0a
 3j9GEysGicRhiqT3tGQCXVsESZLDIBHBEwweY1cCQDUgBDd1dbdaRDuy2/jQUAUcN5o5
 vZMQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653787; x=1777258587; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ajt+NzgkDI4TpK8YHeIedNrVS5cNke2Y/2wYQOhC3Y=;
 b=mSIDEueD9nP2j+ckJIUqqMU/PnZRcqdKhOMx1bBX8HzZNuy291ITfywvlEFLGCVieb
 wM1EA21FGA5rey6G8L1/pIXumKyzUPm2c6lK82ixr7RIBDivKgHpAoLmYoC4in86vm7F
 1ogTq8iEE3ExF4hzp0pfQ6HHW8T+RynpRHF/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653787; x=1777258587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ajt+NzgkDI4TpK8YHeIedNrVS5cNke2Y/2wYQOhC3Y=;
 b=nAQ9C7/Y25htTJNgdKDsxyfinNUokIBwhI3BMyOCGPIyhBRObusISGtwpWCoGsc/Qu
 baWbeh5gn8kNXLLdf/g1h5ilXgK4WVAwodb46BPyfWp4rl1tm6Hif6NcY3Avai7mwm2X
 um4Cel+MzvpgewCGeXPMOpIAtq6n2CyjI7LLtPEI0iWKB/ZyzxyPrsiWWKgQfHXyYWP9
 sO1/lrAxWGcYrb9s3qv8axq6TiwDhr/CYDy09NL+JM4tnAk/ZkVwl8R6BmQEEq3alJgM
 NqAdMVS5E0GT8H7ZZgEakTEwlMxK4idlSi7963bCBYjsHBjJP8Z/TaFnD7GSk2Kcod43
 Pp7w==
X-Gm-Message-State: AOJu0Yza4XRXsB0sNHh0Vn52yjkqB2d6Q9P3h0vlD7hsMD3/3EZ23Kor
 U5oXFwzC9qRY+2OOj/++YP+8JN0yqVIzNKsCOgJSgkbeT8epBbGSSE/sx8FXXOheNnBxmtS6kCi
 6c1ZtVqwoqfSr+n/ubbDbii471VwYOiKOMpUR9LoZ
X-Gm-Gg: AeBDievPNZhbv+ceFzugHn1TYyFfFKM4FXM3pzxAzhGKDkfIMY7loIy2cOBHjHTAEmC
 giVjJ4FUx4QGKVhjtRQKFbis+wmG2LVd/W0t4swcIddiyEYsePEaw3Fo8sGSoPL5RPakv8BFZwA
 oBAcOqdte3nrQFt4yG4fmR5zX/7Fyg0qUq3CtEjMZWHS0Nhd5COTTM8sDRzpCWFj7pY+qHqw5pQ
 9BYqngl76ZpjIW/sNltrF7lN8Flfk+PDa2cdb40L/TGA20f6BUKOG7GX92XgL596aSLIs7vUSpe
 RafdIbMs0zrIVZE81RPc
X-Received: by 2002:a17:906:99c3:b0:ba6:3d61:6f51 with SMTP id
 a640c23a62f3a-ba63d61730cmr235608766b.20.1776653786986; Sun, 19 Apr 2026
 19:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <ae8a42e7a46b728cb9df22a9f47eda3192e13158.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <ae8a42e7a46b728cb9df22a9f47eda3192e13158.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:56:15 +1200
X-Gm-Features: AQROBzB_vlPd7Ls7d5VFdkklmuP8quN2ayodHJZQGARWp1BkArl_E5qWje4KJ5k
Message-ID: <CAFLszThBjowUW_CQJ9=_mGoo09sApZs-61CGiuoSn8Li+sPBmQ@mail.gmail.com>
Subject: Re: [RESEND v4 09/14] mach-sc5xx: Update image load address
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

Hi Caleb,

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Update image load address
>
> Update the load address for the image in
> each environment to match the updated partitions
> in Linux.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> board/adi/sc573-ezlite/sc573-ezlite.env         | 2 +-
>  board/adi/sc584-ezkit/sc584-ezkit.env           | 2 +-
>  board/adi/sc589-ezkit/sc589-ezkit.env           | 2 +-
>  board/adi/sc589-mini/sc589-mini.env             | 2 +-
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 2 +-
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 2 +-
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

> diff --git a/board/adi/sc573-ezlite/sc573-ezlite.env b/board/adi/sc573-ezlite/sc573-ezlite.env
> @@ -4,7 +4,7 @@
>  jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
> -adi_image_offset=0xe0000
> +adi_image_offset=0xd0000

Doesn't this commit actually update the fitImage offset in SPI flash?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
