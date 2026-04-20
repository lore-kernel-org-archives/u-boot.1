Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C996EA71B3
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 00:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D9D839D9;
	Mon, 20 Apr 2026 02:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fb5lTFNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867F484181; Mon, 20 Apr 2026 02:47:22 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D3B9836AC
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 02:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so457827866b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 17:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776646040; cv=none;
 d=google.com; s=arc-20240605;
 b=c3a3ojM3F/BCuMcYfeIuDIQ9Zh24WtejvFHqsdQ++SfkHVhoQvYfb83LOJ6PMDR/It
 yxSGpDYDHdfytqevy0Di2Ej6jGvdOmnaJPpOp/OuZd3u1bEwZREBqiJz2bgXs/mxYHmQ
 o1cynYLQtdjsO30dOR+1ssU3kng/e7cuNBLKXVTn4pZidVUGJxDuDD3fxVpCc0cRKGSe
 6EzhqIhRK+/erh4/2+I+60tc2mtPN+V/RNPvtWrskYy0NNZihrZePY/WpZwRMn1pxEQ/
 I7MXZsGtAEFa7VPHlIX+0hoXZMBRojSYkjrSn7lZFr+43JltU51CidagvaecjoAFKofG
 lUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lmz30CSR2dMlBzKU4Jw5XcUwcpnZU+TP+msJthX6SFY=;
 fh=myhvPHvhoh1eP7Lwc9AHbp2tPfCPgIWg9Pt4xdW4Ki4=;
 b=T+8dJ9W3mCU1z39gc+6hn5//n53VawY4c2LKkHPrVdSDAOp6DcIYpTwwumHEoNmy35
 7bMxQkhd9rk3FDW/hVfR/YMK1GC7gp1jieRTTBX3PPq7GKhWmGO5IrU8xc6FpL9sRyks
 NRsRHAPDymfz1PZWBN9DmOgKaeGU4hemiwDBU12oUcz2kdUCAeIc5VnM6lEAQC96JqdK
 HQHzj2/IrNDhdSZ1HQR5CmDuQZU2IKnF7JDO1iCZasL4iiGE3HMPu+rLFG4+9QDkLTNh
 2sK3/h/WO2mwIZTt/d6E3HJGcyMS+pviUwLf7QoDLz+yA/PH79fV/HTedmt+LCcddSOi
 LAQw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776646040; x=1777250840; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lmz30CSR2dMlBzKU4Jw5XcUwcpnZU+TP+msJthX6SFY=;
 b=Fb5lTFNiooh3GVFygHqpzu87/amv0QHRGWFsxdSBdZOS4oCh4uzYQ4fTCEVFTAjuEe
 jvvAQ4XjLlzF93V19o0mtcz/rTParSeA0vPkjwGpD9dfHOOBLquQBQzdsjfhB3C11dF1
 U67WJ2fbKqfnheQ9I2IftBwP1O4288izG4G1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776646040; x=1777250840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmz30CSR2dMlBzKU4Jw5XcUwcpnZU+TP+msJthX6SFY=;
 b=dD3zI4z9XR64TWeVPaQfSCTy7McT9pqL1ft8HEbJrMRsdaCjPIJIY00F7RCuCCBEZr
 9ps6FLJWJqiQmugp3IZF3XF7BLHCpqflb4DoTcebhxcwsJDd8sxye89X03VB1XUHGSpw
 7uLZKAxMtjW/+jdbsS3MM2SZGSmfY3xvlX5uF3eBnr8E0ft7hueMsIcfMPQZN3bj6DLF
 P6PJQi7zjqNQy6V9gWD+dKHWG+qZOhpPONkld2UaDBzYn7wi7ojKpGlMSmkbJazLa+nR
 Elcs/HmaUyoyY3LmGvT/QrSH1vS1QOg83OANK4GACdsij/cAPfdz2xSRZCLiswfdyg+c
 Nc+Q==
X-Gm-Message-State: AOJu0YyZwEbpgsvr+uMdiRb1f3JFeufER8ZgaNCb7Gp61vI3Zpf1MYnv
 CQYghiN+9O7qmDDaHsb83RsMpkNt6k+XzWwO/eTxBYfCvTdNw43ZwLwTA+47mveIXuEdyUKttiL
 dvaVEZf76hRPHc7OSlkx4W6HKit31f4DuE73PBB2E
X-Gm-Gg: AeBDiesLxRwFDiiYLh6JK+sBO6ntdYVor5tCVIdLf9UjpkxXc5WmYJjTblA3y8Vat7x
 CVuty9zCvOi6isPljOQni16BWTFJPP0M0iBFF2IXBVyyj/EY4E3JmWIyUHmSQYaUh+mXjvTtEA6
 7Wm3Kd3gC4FxB4TMK+zatgdjb7kHIKzxJoluL/PzZgv0RBG0iJDlmJDL7M0Oc2JIDWMutPsOYpr
 UGLDPzQ8amWbn6ZYxgfN194dYu0jw2mfDjU07AiXYvgmbhQrfbSkMn1xHucJajem936YgEBcCQ0
 Qa+T2nKqViEiZFwdmPKP
X-Received: by 2002:a17:907:803:b0:ba6:a05c:ac3f with SMTP id
 a640c23a62f3a-ba6a05cb5b6mr191500566b.4.1776646040089; Sun, 19 Apr 2026
 17:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
 <20260419143247.437733-8-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260419143247.437733-8-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 12:47:08 +1200
X-Gm-Features: AQROBzCi1rEEUNu_2G6DrKJoSUAAAhO_-KiflctEOO4VcXDBd0wPZ-jsb5lr2OE
Message-ID: <CAFLszTiNC7yQk-bLhL+nobM+nED5t9e9+VnZcsvCe9egXH5hsQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] test: dm: fwu_mdata: add test for
 fwu_mdata_get_image_guid
To: dario.binacchi@amarulasolutions.com
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On 2026-04-19T14:31:40, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
>
> Add a new unit test for the fwu_mdata_get_image_guid() function.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> test/dm/fwu_mdata.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

> diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
> @@ -143,3 +143,51 @@ static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
> +     ut_assertok(event_notify_null(EVT_POST_PREBOOT));

Reviewed-by: Simon Glass <sjg@chromium.org>
