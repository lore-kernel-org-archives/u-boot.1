Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068FA606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yDsB3go9;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G5jBNjJR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF03E40A5B;
	Fri, 30 Oct 2026 06:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vbFNhnxA5U2; Fri, 30 Oct 2026 06:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1207D40AAF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793340848;
	b=EVr2z5J1GUoOVoS6fWpF7QmYfIffXHoqO3GL6ClMtmYmQ8fc2lfJGU2a3kb2PJrm6Y7G
	 oFDgiZqCnePhwlrjZv6IZghwAU7XiOsLY9z8w1dxeNMLuF1J124iPS0qy7VCnvGrBUbTH
	 aCZQHmaWFoo2wxwaAjbp49tYCaleVFuaSEqYAWH3bndwv6ZXaBwDiHqIeZ/oTUVsb3HrR
	 jdd+C3VA6xkQT0PmQTd9mPcZD5xKO1lX1N+iy7+CeQ5/YWFddnho0ESESyWwgQ+nPANMY
	 Oh4FZ6MD8fD/wjC6jZLOOe+6zZr3eXWrYjLkbQQUxFUl7uxEgF83oxHL3YLtlDYNmMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793340848;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OghgDjFeH8rrWVDERLywasil033l89irtVc/9iFZKgo=;
	b=FDgpNKFcP2AuwiA5WbMaxnN124epjEkRrXJJuaJpekyzAAoDFduPVSn0B+R2sbIa4gUl
	 GILhKQfWBPLsg0m2a6hNixKd/eF0SHCynEFi61sPU4ffe+MLmnBfMhUSnQK2Cz1IIJhyZ
	 B8JR7jgmNRxCI1YODEgLcSVWW9jJvnOQ/Kjcfren+75Ri0pvWa0HD/DpE44Y6x5piZzl9
	 OIFD5J0PeORDOSMyuq4960Ym8reSFJLRWPhk5Tk56doRD+qQtqsiToecstB8+vnF8+QnP
	 k4Zs296bJKVmUMZf2Vcb6+9YRFh4OLY74Bp06aEEe6ttCCWVW25uBnHqQLxZ1sepLog==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793340848;
	bh=OghgDjFeH8rrWVDERLywasil033l89irtVc/9iFZKgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yDsB3go9lhmKrraPkiN6+fCfPDTFMbKNFpHtbf0WkBijMcjfTtNDCblAOGpLN2ccp
	 eBkZk3CR1x56ADwlvdngZJhmQVmsp24FGZjCUXqezuHoFwl6IFFpIsUpZcHh0Pwb64
	 YOaw+efePOVnWrsfHCIiPz6wbT4LbsubdJRqVe+UnanTvyvlIUkcWNc4pcNyqIjwSz
	 WCUvjR1Hvn496PscHFMFYhIH2LDu7duYR7Ee/2lF0XLla8bOpLxM+VfhippplrUf1m
	 8idvVX2AI7W2lS/FqGqlTmglwh2vqADzdv3EqbZHgO+SgRiTZcPCE8pLHWTmAhofw+
	 XtKytWJLx4TRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1207D40AAF;
	Fri, 30 Oct 2026 06:14:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 831FB712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68DBF4051A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P17KyE9s1NXW for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:14:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 96CB9402F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793340846;
 b=bC05CH6KJ+n+QG+xua/UBnuaWW8dlHWjicItmn7gIpTVX++PRZhZjUwivLjBDcgIPQZm
 +2jd6zUdo39+GrdzQ3+p0DwmAsUSu47DzEokMR0sbdAKxYL1R3hnTJNBTSb/P3mWPynH4
 4hpseycUXgdB0HOnes1B8nq6gotujlkKDfpHCYQhjpz+FErsHEWfXp57sIREGBsjdT+AY
 jENbNSM247UwbYqZ3XY4I6E4ZfrqWhWJM1h2heqGODfSeN5we1OYvz9Hhv+HWlEjqNdlp
 +6nNBDvM4sbqJfZyVfVu7+lBRJSim8wSYLiWh6JeaxQyam5zUpie7V5UPCPLcES+9iQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793340846;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=OghgDjFeH8rrWVDERLywasil033l89irtVc/9iFZKgo=;
 b=nMP+MrAMEnmM9LU093IrVE5nqJcDCkCRIZJkFzLcO0l3CIcaV3BNfGAuUkH11X3MgIyF
 av+Rbb6zyf/3SRU5VEnZY7A1Ee3MJCS1ccmxF2wn2mvgQr5HKY63M+lscQMhNBTrkDEqC
 4sMKBFLLopiypmoT8pW7gaBd2tOL2imJ9LpOJ/cGvoU8Dmap4gpRH1CHcrXPDfKdK1e7o
 ynvulKXtbRz0u+9kqe/hW0ZXfoAPBEO11vacjqfDX5oJRoSRvq1ePkfj7Pwye57VQ8n/4
 v8if81x0u1ks/4wM6Ogpz/VEUR9gYItVSAmsQ6PLlOMRC7ijuoolKBMMaIQf3ojAAGQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=G5jBNjJR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=G5jBNjJR
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 96CB9402F6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:14:05 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so2574915e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793340843; x=1793945643;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OghgDjFeH8rrWVDERLywasil033l89irtVc/9iFZKgo=;
 b=G5jBNjJRU9ZUaDBNb7lfl8NRPBzqZmuTMU31Gy9cYCvtc4vi7YzVYYXUGz4uwnkoec
 YJ7PW6OYRJJDXtxyX29EcTMzeaDzyFXLLjluMzNQlw2GriLlfSZStmS/zGUh9mxSWoPe
 9BrpxR8vgHgrQ/wtBbaWuOfrze/Xx9AhXZZB8gkc8CzB/vV2tUmW9WSmjnfmH7YtZxrq
 5HY4QfpcH53jRGSI7l7uamBV24TswS2c3jpgyO6aszLTHWbm3NB2WvcGY2dxaofmQkCW
 3yWjaGm4ia0VjqNi2EedH7i7G8g6Y7hjUEQYHhYPh6I1S2y8CItgDSDgKG70uXNLethL
 zmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793340843; x=1793945643;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OghgDjFeH8rrWVDERLywasil033l89irtVc/9iFZKgo=;
 b=pvcq4jtz96BeB73DG84RtEnh5wAuKRqZ4Gi+fNMxjDfXQr8zm3tFxcHQOEDeHC0KRO
 ossCDVwKF0Kf3Ttq1Tu2l8urg+omshP4e926rqcZzDPGPOnkwKl1CXOfhAuSpTJtJ3z6
 cut59prruTxomKKSh3iGp6GbFy8UL3cYt4lm2mkjTMke30zzB/xQW8FJuSDtJQSkivRh
 ebk+ZzwTvjr3RK8Cf4nLv1KqBk8VPQhV19iCF7nGvlGvBMkhfEsVIrvTUxPZoqeuqeyz
 9T7l+dwGSWaZjg/Ebo6WtGSIvBXH82rRqk4TA+UPgBbaPC10+YTfeFiIF0QhQ+yXtOpb
 UWwg==
X-Gm-Message-State: AFq9FYLPS9etYV+BEqSrUByE0ukDGXUbmxR050hD01I8vzeh+V7fPvj8
 dPs7BTJjIb8vHqH4OrkPCG1vtbOJkdoYquYQuB64f+sL5LGOFlO7iALne9oqkFYXl5U=
X-Gm-Gg: AYBFou3LX5HUU1Z+2jlGz//73MPO6FAEESQAfzg1/gMuYY3wYypkiKwF+702gzaUX7P
 4dwV9mbt5R29y0gS+yGcBTR9yVKsBA5x2NKg19oVrD1guA5MIuMYy4M5/HOr2/PBtw8DFOYzs0Z
 tAp1sJfDNuOSqfpYJlRpk9mNLDIjw20PLfl5lz+29Lwlieuq9wm8YAAqTj2MbPFYOddgoJuDs3o
 vkn7aY/qH9VzV5tnm53YldCOxiZk1AKkqQcTph7nMKLHFrYKzGnmXQn9mW8A95gzB67CXXZD2yd
 8wJ/O3eoeoR/oeyIgYAUqIwf+g+9hUvaVGeN7/wCVvM8HKMX08XzTvQSgu0R088YeSf48XW9MVq
 WnaExeGX67iScwgiAAQ7C7NJbeB3gVbXi8flY1Gk61Oj2RA8OSMg0ZbiwkiQfuWmCAZhOQ0ENx1
 y2Khc37hQpQlnhhOhJ6aF5Zct99CHojUfZSHOjuzPRNThsDFTHgcGEKl1Z2SHqJ3uvBh8jMbD6Z
 VzVBEbpMMa1nVCVRA0h/ohDtpeBPHDimhdTosm9nd+pO8KNwEEcBMSLj0vYKJirySh5PK4elVET
 OUVjJe7ZOGe4/w5skjFGsuA6u7mA540=
X-Received: by 2002:a05:600c:1387:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4ac1793e81cmr24914225e9.13.1793340843287; 
 Thu, 29 Oct 2026 23:14:03 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm58203635e9.1.2026.10.29.23.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 23:14:02 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/10] efi_loader: check PE section raw data against the image
 size
Date: Fri, 30 Oct 2026 06:14:02 +0000
Message-ID: <50414814-4aeb-48f1-8630-ab51c6eb9a9a@gmail.com>
In-Reply-To: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_load_pe() copies each section from PointerToRawData in the image
without checking that the copied bytes lie within the image, so a
section pointing near or past the end of the image is read out of
bounds.

Reject such a section before the image is allocated, as barebox, whose
EFI loader is based on this file, does since 552a54e4d357 ("efi: loader:
validate section raw data bounds against image size").

This runs before the image is rejected when Secure Boot fails to verify
it.

Fixes: cb149c66342c ("efi_loader: Add PE image loader")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index b15a662e5d6..7fd03ac6211 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -1075,6 +1075,13 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 			return EFI_LOAD_ERROR;
 		}
 
+		/* The data copied for the section must lie within the image */
+		if (!pe_range_ok(efi_size, sec->PointerToRawData,
+				 min(section_size(sec), sec->SizeOfRawData))) {
+			log_err("Section %d exceeds image size\n", i);
+			return EFI_LOAD_ERROR;
+		}
+
 		virt_size = max_t(unsigned long, virt_size, end);
 	}
 
