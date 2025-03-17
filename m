Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20458C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 15:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E2D8122F;
	Mon, 17 Mar 2025 16:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GP1DSd2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7C2380F4C; Mon, 17 Mar 2025 15:25:43 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B33AB80F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so3560004f8f.3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742221541; x=1742826341; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2InU/U4wE4c9WOJ7N2sX+RNi59qKMUPDtFSky+6dHdA=;
 b=GP1DSd2TvBvn6aogatdy4JMkh5WoLZC5HRnuRQbEWLOCuEWDYZVSS64RlySFLMQMFF
 0oQg6UFeeSCXHZ+S8L+w9szbaVh+MTYh+ouVG4hWuYTi9TRZvPE7Ix7dJsAK7LtZ3cxc
 wZfOwnnLCEkDV2ac5Yt9ZfYz4oDAIQYy//yNjGdT97aoZHHJvLJBp8KBJBBy3wTgIfWh
 sHai4q8LIwNrJOdL6aCiaDFDuuQaJC+y/GswdPBBS5uSEwhHD7bFH48et7/kUF4jLyke
 7xi2Wp++0WREEF1c0vwVVWde91e5awaZPorAnV8am1Ba3i553OSI6D3YefjJj7wV57v+
 BY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221541; x=1742826341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2InU/U4wE4c9WOJ7N2sX+RNi59qKMUPDtFSky+6dHdA=;
 b=PjoF6vJCrub405NRNEREJ50s9wbN31p8V5nD49kw6eAeRJlsKrFNio6UVs19C9DQNf
 0p061egB08ujqJ06nqHRYOU9y3ivb8QVwk5DnX5E9W+x0xRBERDmkDzGDAu+rBvGCFhW
 eM7cMP94csHV6zFnS38zmIWgMgrCDSnsUjykZWQBPsKy6jR0vGnIIiJN8d/iZ+taKKit
 nzndnSzDapVTgD2H5Embn4iig2hIH//RNceB3z/hLcWOqsdXGGW1SrtMqTDegIKX/Zha
 Ly8XpCqVWG2OPKMPWPvmpvEl8G9FAls8ro9HiPXdYGBLwq3zUeXnEP+EH820CPBKQ+Ic
 iniQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZKVQoLd4ETKH1TPv/J15v77qknA4v26jfDfM4PbY+Zrk9q7biVPW1hqbWSfY0MF9ovZs9qBc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5gfSihbPFg4RcgoUc/aHpPb8wNDRfdJOx5eN4Vw5K8C7vQkyv
 F4yTZlwhM3C3yM8Ip5tI+rFW1isYxye6ApDRw5HJ0exs6CoHz1Rv
X-Gm-Gg: ASbGnctNLv5g0ZBTZU79O5BE1HpnMjAcm87whMwwM4rUJhu74pzzZEUfx273s1hf+eO
 MJwAYGJfBZ+B9vjZ7sNDIvPIX2+Ebsh3VQKILK6T5U9bgBkwMGNMkgsD2oQqnHcFfSOm6PopK15
 sduHkBCXHQHcdRWts749DrXBeuobqQN2PmypYQLSlIIUc5XnCYUdrKcdX/rF0xPQaARInKBjYp9
 qj7PEBBIMubXSIQyWNefEvs/YCvhKqoBJWXs8MnXlqQrdKUpXRDtHcgFAHE987AWGlQHExSO+Nw
 NNtjXodvmLTVAtDNEa/P0ITrZTw8b7GPr4fWseVBLUpoMp8N9PykrY8=
X-Google-Smtp-Source: AGHT+IF8PdkOao94ZyKMtv5nJTT/L0wH6datlVjBd/TGEbvoIeHvCBuBHrKoGHJvRb0Pzpof/O/17Q==
X-Received: by 2002:a05:6000:4709:b0:391:4390:97e3 with SMTP id
 ffacd0b85a97d-3971dbeaf46mr13264793f8f.33.1742221540919; 
 Mon, 17 Mar 2025 07:25:40 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:390d:d6c6:8d5c:eb6e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975afesm14842359f8f.47.2025.03.17.07.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:25:40 -0700 (PDT)
Date: Mon, 17 Mar 2025 15:25:38 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: stefan.eichenberger@toradex.com, s-k6@ti.com, w.egorov@phytec.de,
 n-francis@ti.com, emanuele.ghidoli@toradex.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
Message-ID: <Z9gw4nxqYy1OGLgh@eichest-laptop>
References: <20250314100734.23777-1-eichest@gmail.com>
 <20250314163422.GV2640854@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314163422.GV2640854@bill-the-cat>
X-Mailman-Approved-At: Mon, 17 Mar 2025 16:38:15 +0100
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

Hi Tom,

On Fri, Mar 14, 2025 at 10:34:22AM -0600, Tom Rini wrote:
> On Fri, Mar 14, 2025 at 11:06:49AM +0100, Stefan Eichenberger wrote:
> 
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > The get_ram_size() function fails to restore the original RAM data when
> > the data cache is enabled. This issue was observed on an AM625 R5 SPL
> > with 512MB of RAM and is a regression that became visible with
> > commit bc07851897bd ("board: ti: Pull redundant DDR functions to a common
> > location and Fixup DDR size when ECC is enabled").
> > 
> > Observed boot failure messages:
> >   Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
> >   Authentication passed
> >   Starting ATF on ARM64 core...
> > 
> > The system then hangs. This indicates that without a data cache flush,
> > data in the cache is not coherent with RAM, preventing the system from
> > booting. This was verified by printing the content of this address when
> > the issue occurs.
> > 
> > Add a data cache flush after each restore operation to resolve this
> > issue.
> > 
> > Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
> > Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when cache is enabled")
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> >  common/memsize.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> Ugh. Is there not a chance the problem being that we need a
> dcache_flush_all() in the K3 ddr code somewhere? I'm just trying to see
> how we got here and I notice now that yes, this does look like it
> finishes what 1c64b98c1ec4 started but in hindsight was that showing
> something else needing to be fixed?

I am also not entirely satisfied with the current fix. I rechecked with
U-Boot v2024.10, where we did not observe the issue. This difference is
due to the cache always being disabled when get_ram_size() is called.
This explains why it was working before commit bc07851897bd ("board: ti:
Pull redundant DDR functions to a common location and Fixup DDR size
when ECC is enabled").

I think my previous fix introduced this second call to get_ram_size()
when adding:
void spl_perform_fixups(struct spl_image_info *spl_image)
{
	fixup_memory_node(spl_image);
}

Doing some more tests now shows that probably only adding the following
would have been sufficient:
gd->bd->bi_dram[0].size = gd->ram_size;

If confirmed through further testing, this patch may be unnecessary.

Regards,
Stefan
