Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422A2C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33B2F81287;
	Fri, 14 Aug 2026 22:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wgGe1HrEIiX2; Fri, 14 Aug 2026 22:31:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 947A080F0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786746712;
	bh=7rdFgcx7za6P868vVRIyyxPwNvaPLZVI7/KOPXQ98CY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=StTNt8ln/xYDm0PotDqpnEzJZhw8nzmBikiCKvxa18u42kxiIyw9FJtJq8YwPWn4g
	 4nAoAx9gLPwzZ95fheOp+w0YgK9G3P4pGax0ibPY5TkDcgC5Dlf8vOb4S2bSKFCESv
	 JHxxNdbLV0EsrWehxtPzLhJIZfQlRiHmT71JVL35brVS3wJoyfb6IYiIJS5j5O6NdF
	 L0TaX5vcJvpZ665OiRsQCnZlemmoDRvgBw2X+J82X2ncK2M/Omie+LsL/XJK154xQe
	 Xiyd/pa2go1YmIIz5m4UVYILnw5CPWbXS+6LOjUX8OwpNz5dq09w3LPwVwhyngZSDW
	 fn1KvegNwsqdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 947A080F0E;
	Fri, 14 Aug 2026 22:31:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 41312139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 274A6409D4
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:31:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dqylD6pFv5gx for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:31:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3C58D40770
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C58D40770
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dlXmwZ5C
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C58D40770
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:31:50 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15cb6f5c12so272802666b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786746708; cv=none;
 d=google.com; s=arc-20260327;
 b=R+y40vq9RR0YZdJQSGSxrQLWzW1LFg4PzJJCMEs0vSeY4SMo3gJfQmnPfmKY5zWNPe
 LXxoVa9s16zNk51IRoKH1A8h/uqHWKrcljJwb6DKO29SiwHDAJvV7fVqA+QPij2zLNLx
 teQPG/XmbvR4Scbfr0EFjL91m4RYFDkkk33WVGOOIHwahXqTirfa81TEJfiUkoN4vCN0
 8PRg7r6/ABdhqV64vHH9PINJRQlKe8XxQY0KJondiCA1BM1GDYY8JosyQAYnM2bkU4K9
 8WMOj26c1XevQFFipwzrC+06TO8nn47QgRFsK7Fe9OXFMUAWTmqW0rgA+PAJHIyBUA6s
 bmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7rdFgcx7za6P868vVRIyyxPwNvaPLZVI7/KOPXQ98CY=;
 fh=LiJebNsFtj8Y9yM/8yaWrJodERuv1qeuIvtFmGImJ08=;
 b=l30RKBHR5YUv2/S87I6EvQ96WGTtCCf0+B3zbX9xl6sBJdUle09/0FfzIcv4piHC60
 Hbjnyhoyrfs16CafL+vNbtMybzyDGJVFb05DE5cQREXSc7YEeJl/8xIyWXWGgV4UdJzL
 OyL7e/NwTd2Sxb4PzGH2aNBQdPPS7h2ug1llUBa+Qe+yFhODrvFUSRJTJdojIcXBDLvU
 1MQafQmTUlC/OMZxs6v78snW1Tz9V4mTJqkqQQWtYI/2M/tQCHUT0E5BYNgLz60Lg1T6
 OYIDdjKgGMB5wadmoTpCBnQiceS52gTBMukoVXyK6oshpdIdpb8+1nZY0PukF4TF2oix
 0OzA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786746708; x=1787351508;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7rdFgcx7za6P868vVRIyyxPwNvaPLZVI7/KOPXQ98CY=;
 b=dlXmwZ5C2cHXIVHbUpGC7IiSdMqc8LxL92BcNfa3zhw54aBOekSof1xWc+ggnOtABM
 e6iLVagdHFAxd9ixQQ/PnWMeqQRY1c/SEUtpaCr9tV9dEg1llE8nDtE2YxkL9VpE+SB1
 TA+uiI22XV/kpKfyZ+E2eLXRp0rdssd1YQF98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786746708; x=1787351508;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7rdFgcx7za6P868vVRIyyxPwNvaPLZVI7/KOPXQ98CY=;
 b=NYv0VuBdfe4KQQkeXj/9jYGWfqgZ4banUxISiU5oKDlzOkC1irIoMtpc4IKYO6h4BN
 HXL8mFWjcp2AWyaceTB8yC+bE/vCB5lo4L+/mHB69ngQ95bMCFh+/+Ev/wm1yf9mKyhh
 2lAPPx7NhzL5mrkSM2rYUCw+5Qn5KMmUA0CybZIujLcK45Icv0rAcpyAp+wV9ch60t0N
 bMb7EB8MC7ZK+pJZYAv8Y4XYLENKkprAfWyZZHbM2erUJtavxPZXDlUhKzjaZliBe7dm
 aQOS3V0HxfufqtnMxzF4z2muuBVqKmA8PVjrpFUI4ymLtWHVOePrtzYGn0iTkNePo9Bm
 ItPg==
X-Gm-Message-State: AOJu0YxOIRJ2yId6shEZHK2e4PcLXcyV3E7SYRoVezbVdtHzv1P6/ArN
 jhVgTbJJNVGLJHjRCLxGbQN17htGVAoXe0eYLeTOYImRhZvnYxE7CuEbjFCmxTJJMBXVV9204gW
 tJ2/ye6tiF9kWfdwhUKmODO9X+6m4TAih/9OV7SrJAa0xzpFhpa8=
X-Gm-Gg: AR+sD126LcHqnMLnrDeYmH/WEKggpsyuDEF/HvKbrjvstAjeYMuuSRAa0FRZGL08rmO
 pY9KMmS0wuf7bmLjxMZQS+jTp6h8r4K81tX/zMnebKRlp+oFkNonxoe3PnQ6umjpNqYMY44kmPN
 OALTrpEnfRe4saP4IJegbKSmYJIOdAPmhfG53G6qqmQ2KRBrwkFSiM9zOokAEjzGXsa43/V+dQg
 fM6UEn4/iyZ95ZPhAFINIkiYbBpIdXHOMpB3Ogb2gG5kUtJfQu+KHaT+hKOQBOZMCxedwi7lX66
 hhMQ8u/Vrglflm+jOdRBcVKuVP1+OAbnHpknGn84dyY=
X-Received: by 2002:a17:906:7949:b0:c16:2dc0:e1ef with SMTP id
 a640c23a62f3a-c212a170817mr403065466b.14.1786746708083; Fri, 14 Aug 2026
 15:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
In-Reply-To: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 16:31:35 -0600
X-Gm-Features: AcwNN1Vy_eQ8mfBNdUWo06MVnp5jfzQ0j3jqO67eU0kRQNpiEX_i44xzopID2m4
Message-ID: <CAFLszTiAmCFn0pt6x6uNfHdG3YBz=AAHT257ArJQUBCpmZX-wA@mail.gmail.com>
Subject: Re: [0/5] binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
To: jeremie.dautheribes@bootlin.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi J=C3=A9r=C3=A9mie,

On 2026-08-14T17:07:09, J=C3=A9r=C3=A9mie Dautheribes
<jeremie.dautheribes@bootlin.com> wrote:

> Patch 1: introduces the new etype
> Patch 2: updates the imx93-u-boot.dtsi description to include the new
> signing nodes
> Patches 3-4: documentation
> Patch 5: adds test coverage
[..]
> The implementation is largely derived from the existing i.MX8M support,
> since the two share much of the same signing infrastructure.

Given how close this is to nxp_imx8mcst, please say in the cover
letter whether you considered factoring out a common base class rather
than duplicating the etype, and why you decided against it.

Regards,
Simon
