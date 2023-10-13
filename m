Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA08CDB47E
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 00:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED3D86E47;
	Sat, 14 Oct 2023 02:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nofTxTSl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4468E86F57; Sat, 14 Oct 2023 00:03:38 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A6286F7C
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53e04b17132so3956622a12.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234448; x=1697839248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AfL9YPFvBlaH9ZuimsO3oPZEC9mkIC+P1vK7WNDiZo4=;
 b=nofTxTSlMgdaJC1111loR7ddhhDijh9Gjmrqy2KaUf/JaNHGjiRWGcsy3o4GyPVn4i
 B+iSc2y55rCdU/skNpXB4AxctH9p2T0lcf8c5U9DoSv2MZXRPffXxk3F+u2Gz3PKja9R
 F/UwDvfWg7l1ACJDZzpwAP+9NLht6bDTfXuv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234448; x=1697839248;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AfL9YPFvBlaH9ZuimsO3oPZEC9mkIC+P1vK7WNDiZo4=;
 b=KnrXWuZ7YAiOHXNFFBnQ/nP3cX/CnFc9exE+2hfv3dQvgY3PKZuthrJ4FbQYtNqYNj
 kHCaDf3HCFzMmaSZopkLYP4qgzN75yByIRTbaVhUBFug1U/DW3xiM1zWs6/5cSs9yOa1
 ULBysvXh1NSa7FJSu7nhmLDOfzAU2/ckWIEgG//AfRRyPn+3Kukpo0LbqlO4LxBKlt8M
 VZHWeWPwh8Mm0FZ+y+576FYqbpAxzsTajR4BBQlgIK+0HWkfpxd83wg5ldyGGTCcb3bu
 FT7BLORmq0a4YgO21WMhJGF3WU1SpABR3EJU+hMZHCUhT0Hew3tmdpBmp0oZcBkP2uSt
 fw5A==
X-Gm-Message-State: AOJu0YxoiRaaW45jcD/T/Cq8ptH60rTEWa5r7Zm0SPyg7cr67zD5a9WP
 JlpCasAAFdg3c4Yi2rKqZd3WjQT7R/2w0/+Y6WfueA==
X-Google-Smtp-Source: AGHT+IFk9T+SaJIcthly0fNdacaLxoPqXqe8LqukxBcHk/MKl+yj/TQE1c/27BPql37WrnEDC1BzmaUp6NG/P0JjU7g=
X-Received: by 2002:a17:907:78e:b0:9bd:a063:39d2 with SMTP id
 xd14-20020a170907078e00b009bda06339d2mr2967428ejb.16.1697234447917; Fri, 13
 Oct 2023 15:00:47 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 15:00:44 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ3fhkvg803VwkfoAMKqMGi4zNtRbft652HxbVEHjAs4XQ@mail.gmail.com>
References: <CAPnjgZ3fhkvg803VwkfoAMKqMGi4zNtRbft652HxbVEHjAs4XQ@mail.gmail.com>
 <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
 <4ccdb1eaf4094120c496eaccba30cd2473a7b0fa.1695817360.git.matthias.schiffer@ew.tq-group.com>
Date: Fri, 13 Oct 2023 15:00:44 -0700
X-Google-Sender-Auth: 1Bw3Snk-kBI2HGLbVZ11QvHJjmc
Message-ID: <CAPnjgZ1Q1BqsKrr5r+1v1su4Vqvpc_4x3K4Vd_XzBGnzZ83O7g@mail.gmail.com>
Subject: Re: [PATCH 3/5] core: introduce dev_read_addr_name[_size]_ptr()
 functions
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
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

On Wed, 27 Sept 2023 at 06:34, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> Same as dev_read_addr_name[_size](), but returns a pointer, cast
> through map_sysmem().
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/core/fdtaddr.c | 21 +++++++++++++++++++++
>  drivers/core/read.c    | 21 +++++++++++++++++++++
>  include/dm/fdtaddr.h   | 31 +++++++++++++++++++++++++++++++
>  include/dm/read.h      | 41 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 114 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
