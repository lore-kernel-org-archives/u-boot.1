Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E757107BCCC
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 16:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D76684376;
	Fri, 13 Mar 2026 17:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BhVJXns4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C7C6843C4; Fri, 13 Mar 2026 17:52:25 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B759C84372
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 17:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-67bd152d3d9so1380631eaf.3
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773420741; x=1774025541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2l+ad1OnFJTzwKgVYoZkJsGgx335aThqjsIHti3VRkI=;
 b=BhVJXns4XtxCaldSXq43CmXUe6pqxOGEgjeFHywuYPfvAn85OS7JY0yV5iTxM+Cegp
 HrUdjWEi8PKf14Us+QmyVcVdXxDGF+PXjE5Zl5W2ibWLV6Y35eS943WpqhXaAwXvbdc0
 L3sPEe44e+sY+ogbbZOlSJU9SoRCFwV4PHoBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773420741; x=1774025541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2l+ad1OnFJTzwKgVYoZkJsGgx335aThqjsIHti3VRkI=;
 b=MQDKgPW2Ta6gsYRzPtpw8/aN0SGclRKWv+gFRxupqE1RDwBqI3OzxC/6ZexIaaG2mF
 aLdGr5BpCjl8c0rsVOVVCwivfWSudadC566TpdViNMK99RptqF/wBBBrOsNCV2zkmSLj
 z9wDueSaQpLPM0C3rsx2pCRF0J0EggmcvVubEmYRwf3dysCpunFlK5C7ohDZKn6NQg2q
 /WA8rb/uNiu8kUxgKhuTfL29ffPOg6ZnTn/5oN291syrXBMVYbny7AT8OnvDgg4hQa9G
 y+zxWyNYe01JSqpJ84mNecwsrLW//9HhQpPqSHYnW0oU6uWOGy2rIQvAWJWn8R5400av
 0Iew==
X-Gm-Message-State: AOJu0YzS7mP3XNHuKioE6+pXKOwc/bLbeP5p50fy8bsGx1143fk+FVqK
 JWhet6QO7ilt3Fj0SSpIuqnHWfHutcYdat04gWaBTuJMzel+SP6tk7/5jQfN77mnTrmxcDQnuE5
 moRyRZjs=
X-Gm-Gg: ATEYQzwQoK/8F8SvfWE2WsX9rGqYPDBVoedEgBw0SWL9IsjrxWlMIFJh0023GXUDMBs
 NKfGxLSH33TCVn8/3nOFaGyCfDO78WGN7Ck+OjOU/BbrKJsDLGkh2fKLUOl9HDdn9Zt1JpAsqVN
 BPvGxpmPfRt8cUnFx8/1fZcxG+E/EKBggFWdqK0BS8hW+yVaRQcJ4pVDFi7GnlvCD9+PMYILsYs
 qkWdRayBYGzLsdGDm3yGDi5KWSMxMyfx+PtN8jeQ8niidcR02ZjOTLt12sTeqy/CtdgmzNrjYxU
 OFiHKHUNyFKMJ+GCLorq6N6J6kn5u/wDjncVBbD48/0X+May4DJbJIxWTxM6UhNGGFODMqC7PBK
 vALOyJJXpFkGNabwrcIrijJXTq8vG9TiakZbPcdNClbMJ7erJb+zgaeOzKt9OABWb46tIwtnEFk
 tgIZbtGvC58oy/bBVLDDB4VKhK5CqZhQ9NHi84IKzx2DB3jHw7k9AQUrpgSIX+nX1csZgQDvUvg
 lbMRqpa+j7QUUcP7ZgXmRRYtnQWwUaw5zoYPSU/7mBDGuBjvd0=
X-Received: by 2002:a05:6820:4912:b0:67b:bed4:b150 with SMTP id
 006d021491bc7-67bda9bdd13mr2037703eaf.30.1773420741312; 
 Fri, 13 Mar 2026 09:52:21 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bdd612b6esm1241304eaf.10.2026.03.13.09.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 09:52:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Jerome Forissier <jerome.forissier@arm.com>
Cc: nd@arm.com
Subject: Re: Please pull net-20260312
Date: Fri, 13 Mar 2026 10:52:17 -0600
Message-ID: <177342068506.1062380.2381146307946745970.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <91fa5175-5eb1-4991-9467-fc3fe4f52105@arm.com>
References: <91fa5175-5eb1-4991-9467-fc3fe4f52105@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 12 Mar 2026 16:59:07 +0100, Jerome Forissier wrote:

> The following changes since commit ba7bf918dafcd093ad733b07ba490baeb20cf5da:
> 
>   Prepare v2026.04-rc4 (2026-03-09 13:52:04 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260312
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom

