Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30DFCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 15:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB0A86E2F;
	Fri, 13 Oct 2023 17:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="afZdS0Dl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26F2486E04; Fri, 13 Oct 2023 17:56:44 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0986486E04
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 17:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-991c786369cso367472766b.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1697212592; x=1697817392;
 darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6GJFuCPh4Su9kpbHWUPqrea6dDdePw6pY8DY1kVw14E=;
 b=afZdS0DlEz5obe6jcYE3a/4cbYTikDiFZUHZhCE4P7EjmXZsn4ZlRpVvJz89GwN4E+
 A18IhsYOOBFsmB6HsFIF8VzjUylVZ+eO8HXahr/y2VwobHy2sPdrXz50IuvxVb1ZXdbz
 77PGyzid5+bmBwZyfELs75MDbcLyOjEjyK6k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697212592; x=1697817392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GJFuCPh4Su9kpbHWUPqrea6dDdePw6pY8DY1kVw14E=;
 b=gqPrnYTUs3uetRZ6Xhy/99WZEePkv+a4+TGYG8dyRLInIaiq91pNBjbDbRqxy8iQar
 8fcB/+easn3n5ULzzM07r0B48zPH5jJPLNcqNBelkW9tsCZfiYIQu07m27VTWVuwHIrw
 T++gvr2eszdOqDGv7OZj8Y2qIzx8JgPIHabT8uHmKuCvdXxcRZCAP43mzvFtah2DOiI/
 kUBGfTlRVXFWAI1siZ7PonCbt2yl42h/xowlMOG/wUiVU/51eyhFYg4L90PKY+9ox3HG
 zkfPfF1iKL4BlvveGJXhbvRG3rJkPqtzegCh77LMNz6TYq5rdlHvr7mpbIML4AlShkYJ
 s67g==
X-Gm-Message-State: AOJu0Ywfjfzqu1xo3OmyoFfKAUvDbJXe0h7WtvzxlUKIOxGv5SiDBT+e
 RhS5jUP2M2GLsgGx7Yl9djc14g==
X-Google-Smtp-Source: AGHT+IFhpr90xPbTUOHGXoiejLAN8KZ/AOoNuGsK1upstHCPyQm5z3CW7J539cbvApVUem4KZVe3kw==
X-Received: by 2002:a17:906:10d1:b0:9ad:ec25:825b with SMTP id
 v17-20020a17090610d100b009adec25825bmr21386054ejv.58.1697212592310; 
 Fri, 13 Oct 2023 08:56:32 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i (mob-5-91-24-118.net.vodafone.it.
 [5.91.24.118]) by smtp.gmail.com with ESMTPSA id
 k16-20020a1709062a5000b0099315454e76sm12473342eje.211.2023.10.13.08.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:56:31 -0700 (PDT)
Date: Fri, 13 Oct 2023 17:56:29 +0200
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/2] dfu: mtd: fix the trace when limit is reached
Message-ID: <ZSlorVIGWxaLF4eb@dario-ThinkPad-T14s-Gen-2i>
References: <20230605075208.55221-1-patrick.delaunay@foss.st.com>
 <20230605095147.v3.1.I442ff110f3340ab844d07bfaa40ad621f1217b03@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605095147.v3.1.I442ff110f3340ab844d07bfaa40ad621f1217b03@changeid>
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

Hello Patrick,

On Mon, Jun 05, 2023 at 09:52:07AM +0200, Patrick Delaunay wrote:
> The offset variable = 'off' used in the error trace when limit is reach
> on erase operation is incorect as 'erase_op.addr' is used in the loop.
> This patch corrects the copy paste issue between the erase loop and
> the write loop.
> 
> This patch also adds the 'remaining' information to allow to debug of
> limit issues.
> 
> Fixes: 6015af28ee6d ("dfu: add backend for MTD device")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Applied to nand-next,
thanks and regards

Dario
> ---
> 
> (no changes since v1)
> 
>  drivers/dfu/dfu_mtd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dfu/dfu_mtd.c b/drivers/dfu/dfu_mtd.c
> index c7075f12eca9..b764f091786d 100644
> --- a/drivers/dfu/dfu_mtd.c
> +++ b/drivers/dfu/dfu_mtd.c
> @@ -86,8 +86,8 @@ static int mtd_block_op(enum dfu_op op, struct dfu_entity *dfu,
>  
>  		while (remaining) {
>  			if (erase_op.addr + remaining > lim) {
> -				printf("Limit reached 0x%llx while erasing at offset 0x%llx\n",
> -				       lim, off);
> +				printf("Limit reached 0x%llx while erasing at offset 0x%llx, remaining 0x%llx\n",
> +				       lim, erase_op.addr, remaining);
>  				return -EIO;
>  			}
>  
