Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF139C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 00:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DFB188543;
	Tue, 11 Jun 2024 02:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M2uDG/Ta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAD99886A6; Mon, 10 Jun 2024 22:03:32 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5CC886B4
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 22:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso42015266b.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718049808; x=1718654608; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=65+Ab1bNjcvKB7scTxrIX9lcrJsxMSJ57iQZdYUi0ds=;
 b=M2uDG/Ta10FHC3dLRMIdjrBsiCtrv6mbzyZCRdHgTd1JzQV/R2fEoupuDN2JSbujtS
 wP9XVdgVoJvJIEKTR8BUWO64B/rHeI34h+aiBi+xO9yfvstIgjaugoLl36pjuDgbxQrV
 9jMxFNaZwgYJ+z6VOMm68DVPvS2uXeqqjt2gtq8TcD0Zmz+LkQcWo6l3soMIZV6x/ovh
 bDx+OGhCZUyB80enOWnGDE8p2G3tf3mKRTSm0XflxIGwehQEKMvOvStjDaeUL0tB/4/P
 nh9/zNkX0VGIXKj9SwUK+XF0cP2Dk3/I3gt+wvOYVPTkTcYNq34qbdIPnJJftKx1N9fe
 MXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718049808; x=1718654608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65+Ab1bNjcvKB7scTxrIX9lcrJsxMSJ57iQZdYUi0ds=;
 b=hIKFU6lrfWcq1khx4SksylFSaH5Tn1+MzW71eDaBXSNN6cPVEm0vrs07cnRqCIG6qj
 mxwVNjKBFpRt8IB6TX57IywOwK6yqI8gpUNkgv8RZUMaCQDQsJImS4CkEpT5AXoyN8yu
 pxxQpKw0OAHBYsNeZ8AqCXVEx6QQNCoaVD0oM1/BB2CmradzbN5yf36huksxWW3egso3
 yHZWU6ueSnWxuSzTUmTdecsjH6VVi6hKu8nQ94SnRIorlPyy/87VBOYgYoJhOmBU36F9
 ywPHJkE8aTvyFU5H1c+7Lgzg4hSc60OplyHGL6tqk5LVqs3ftPTjH/IWK3uD7DlULcKW
 UdFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGBJr0rRKgVulrgZ3hQQKCXblbeIDBFzTmlig4cJXWPQbp1uXHbz9AQYHGeb0dHDRhGNfgPyoBWD/jpSeqonBFQ1QXnA==
X-Gm-Message-State: AOJu0YwJPXyPnCLgIxjFy1XnXiWmAgisYwp/uTBjzPzrvtb+EdzsDI1m
 2Ag34ibLs6vEBMf+TpqRo9HNkAlHsqNmydSzSMOzG+8KsONhTQQ+
X-Google-Smtp-Source: AGHT+IF1XKfmWlPDcvw3DZziAiwEMw8xaSu2m0hNzetPgo2UscWtlB8uARNRj8KFayzjoA5sZB6aKg==
X-Received: by 2002:a17:907:7f87:b0:a6f:20af:49be with SMTP id
 a640c23a62f3a-a6f20af4ee8mr258985166b.51.1718049807870; 
 Mon, 10 Jun 2024 13:03:27 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:ed15:c026:8826:cce0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f19ea7620sm222787566b.53.2024.06.10.13.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 13:03:27 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 10 Jun 2024 22:03:25 +0200
To: Tom Rini <trini@konsulko.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, hs@denx.de, pro@denx.de,
 vasileios.amoiridis@cern.ch, quentin.schulz@cherry.de, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add support for FAT filesystem
Message-ID: <20240610200325.GA364896@vamoiridPC>
References: <20240610185116.353604-1-vassilisamir@gmail.com>
 <20240610185116.353604-2-vassilisamir@gmail.com>
 <20240610193747.GY68077@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610193747.GY68077@bill-the-cat>
X-Mailman-Approved-At: Tue, 11 Jun 2024 02:20:29 +0200
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

On Mon, Jun 10, 2024 at 01:37:47PM -0600, Tom Rini wrote:
> On Mon, Jun 10, 2024 at 08:51:16PM +0200, Vasileios Amoiridis wrote:
> 
> > Add support to save boot count variable in a file in a FAT filesystem.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Thanks for doing this.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
> Would you be able to do a follow-up that converts doc/README.bootcount
> to rST as say doc/api/bootcount.rst ?
> 
> -- 
> Tom

Hi Tom,

Yes I could do that. I will send a follow-up with the change that you propose.

Cheers,
Vasilis
