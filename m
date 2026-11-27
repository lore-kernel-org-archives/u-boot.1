Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE30606A324
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DEv9DC/I;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=m3baUYNk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26EC360B0E;
	Fri, 27 Nov 2026 16:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mRhCUwe3aicy; Fri, 27 Nov 2026 16:51:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8041B60A54
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795798307;
	b=Quf5mU1AMi4Qe+hp/5+40cBqvG6lgVLRcqdJ0bkJBk3anwjAftmdOJ5liKxExR9pGaaY
	 5H6QvX6a0pJ6ZCPkeYv0JzKJEu6iliNBO8hPofCwlDQU2R4zjRho/s7TzJ+Rq1BOyQ2fv
	 FjNfm9KBwKhuK+LJ1sI4kJs8COjX0/Wh3xy7S6VgNnTvKb4RtNGssB0WiuW+BEnYfutRE
	 NEc35w8gaZoPQYC3GfWrM+merk3Kb/JgnPQ5nyQvOQYgiNJurd0MuEZkgnsNKxi1vU+1p
	 8BoXTh4y7VsNb6hXVh8QJiPlFlGVRaHr92M6B3vSStDvpWR8WvQ+bta0Tch/HNYYR2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795798307;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vUt5umr4k5dSvBMy0dWtLRjY2PUjVb+LppSS01iltr0=;
	b=Un3ECnkfNLb+c/0FmRrwwa6FeEO0FlWCig5iOs2wD9oS2kHCPA5tQ89e9VAzHtW0ySad
	 YDB3knfQS4OZbB/C347f2PGNAJsdTHwY2pc9HJBzwO4mpC1tjCBle/ch+93JjN6EiHWwH
	 muolM/nQUun7eJb4dMwTmWw5o96b8np4MJ6IiILJPT/0sZGSPa1CV9sZjBjQ0Ya6snpp9
	 NPI00ydfEzoSQ1qPRwJLFtIxu08Hyvh1Oz7BF7TqFxDejYFEZ6UOapf7aKLFdlnAEv+T2
	 ZtLl60vuPQpyNMVUk1I0S4Te9y5sj80wJdHX6Jw9UrL2ZNBFkHwDGaX7URYd/TNzf/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795798307;
	bh=vUt5umr4k5dSvBMy0dWtLRjY2PUjVb+LppSS01iltr0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DEv9DC/I/sz92SXsNxDoDNMp3CfJ7ODUAWB6R72jrINuLCkIxwX7/YHwecRzsUmei
	 CNHhDUhih19WfayEvKlUy1VOtYPVTctdf98Xszxe/ewvoaq2BHX8ETqEaiCXKoheJO
	 5NBhGN9wc0JcLb68t9QmwPJSYDiEMwri32Yh2zykNQWfHFA4aTEJFfwg5pBp5DV5gm
	 t8PJt4FVRHSQLRD1rJNaopT0Mp1kJMeFkVbUW1MRk0YTdMFcAREhEL//gywGshd0r9
	 DaOgGCSkzMtoTNrBgoe/m5XRjR1GRiHA4J+9avaL+boVtC8uyDeVtoq9TFTwN0BoaK
	 nezr0WL9x03Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8041B60A54;
	Fri, 27 Nov 2026 16:51:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A94B1C9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17F38405CE
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:51:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MkjWlVuwL389 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:51:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6EB8740623
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=m3baUYNk
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EB8740623
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:51:43 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-71b47eede22so4936161eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795798302; x=1796403102;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vUt5umr4k5dSvBMy0dWtLRjY2PUjVb+LppSS01iltr0=;
 b=m3baUYNk6tw1zYprLSm3zPh+G3jKNt1DyHh+ay1BQroR3pEysc5PUu7YEVotQ/i8JA
 m+GfAJ0LPJSh9INXsL2TmT4v/x4qQVYuQ+vqsFb6Rz6F54uVIy7dnNGYHASzhtXe5Mxz
 lK8O6NxFExTjkJ7OIQ74YDhVbgkLj+NvLvBu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795798302; x=1796403102;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vUt5umr4k5dSvBMy0dWtLRjY2PUjVb+LppSS01iltr0=;
 b=BUTZK218ES32hjQ2moPnOrFcEAM55/olzrwJ4K6OyadblauypMFBiPUla8biaqfZGB
 UbhEvgiycCYgaH93pq39qCNJNewqsYRFsWo5CHoeFJBNSgFa7Hg/auCaIKualwc+ieYe
 f8I8CnvJb4lqeHoCs7PY7mP/EPtSGq62m8NLy9WDv30eFVa47yGBR9kDz1d+7wf+m/I4
 XGxxzI84Dv4vTWC9hYj60yhLJwEGnow0sVppnmBiNKOrjWHBLvfHGBHMyBqPW+QG/lZI
 hgRMo1BvNT1yd1Ff0+eg9KOLkSMQpVXZPGLqhEX48e2OOSF2HzFIJ8j7LNJHMOsJfwe6
 GpeA==
X-Gm-Message-State: APuU4Z/uVvpvmSuTlAV1ANeH8wmmkBwXHTOOeB/PJoU3aosL0sQ773WS
 uWl75208wBE9NMEndR/C0uoyPed2+yMo9MmsiV3NXg9xQnH9nGBQryj7VVNkH9PN+B4LlIJ2zAS
 yKTitJWRUoEJq
X-Gm-Gg: AZFdTZdPjQ8Mgj5cvrYd4R+YD6N0ypXzbOlbadCggYVp+GfALbKGhSrFqpNOxK9k54/
 XgwL6RGuauGu4jW+ppYTydMXM/wiUfpQBksMxveFtzsDQt0DgVjzgUtABetrVtMfNBMAFbcwcWd
 iFwP1yp9/eUuBzoaEmr79MThMRJnFWNE0tvncZbDW0sVKKPoQSHquKkZ+hJys+pW0nC4s+aqu9Q
 NPx42Jbr2f8xtnabv5xP5Ip8pOCDqzS0KMpBSNddzB+BqnrVXeUAbYJSnfIfjHLbuN2y/gJZZE8
 CpqRnttwwCFfnZ4XKh6hg5WPyURPVA067ucfTT1ueF44G9luSGaGU/I2ovvoGyFxZ85q85fGOpc
 gK4rp7krYS697VSXBYGy0chQC0i2MFQWGtoWn9Huus9GbnyZPvzs2bXTXwTBZ/NGlx5JZsvQ8rb
 2/PVfwC5dcCGX3+3LHBcqlMc4Y3i4E3I/VCz7rpkxxl265tbj3IZC8rQsvf+H9GxfNu3ByjBuVH
 SV1Bos6RaNKU4QTbXgyeC+iaf550q3fhZr9SpvXDwtc+L/GyqcwlYeQ6+QsiK+Zmbu3ZyhNlhJO
 Y5+YPW3f7d+Sh/irSS8aHYwWiHrqyZthoGzUCrtbzUg03vw24l8trohObfyVQ5Y770zkekXkyb+
 HNaXMFjMtIy6IPdlKIogb9EzyzhSqESI1xUrgsZT8kCpKYtdFobMXSauebL5yeIlaH495qmbsvq
 cJ091kniZE1ETWn12DXVKZl/KggVGSsQ==
X-Received: by 2002:a05:6820:4088:b0:71a:e62f:62ee with SMTP id
 006d021491bc7-71b39404b5amr18873191eaf.23.1795798302435; 
 Fri, 27 Nov 2026 08:51:42 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b37ea818bsm16973791eaf.1.2026.11.27.08.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 08:51:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <e0cb67af-02d7-43a3-8855-7f0403e00464@monstr.eu>
References: <e0cb67af-02d7-43a3-8855-7f0403e00464@monstr.eu>
Subject: Re: [GIT PULL] amd/xilinx/fpga patches for v2027.04-rc1
Message-Id: <179579830098.3550425.136547374421915134.b4-ty@konsulko.com>
Date: Fri, 27 Nov 2026 10:51:40 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 27 Nov 2026 09:38:43 +0100, Michal Simek wrote:

> please pull these patches to your next branch. I can't see any issue in CI and I
> would like to get especially spi changes to next to see if concatenation support
> is causing any issue on other platforms (hopefully not).
> 
> Thanks,
> Michal
> 
> The following changes since commit b7ed8d19d83d08d34b24b15c3dced7fd6c284939:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


