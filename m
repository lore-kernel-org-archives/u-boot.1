Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B914E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 20:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F67A80107;
	Wed,  1 Jan 2025 21:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BS6RBRKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63233803DC; Wed,  1 Jan 2025 21:41:49 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C7C803F6
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 21:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d8f65ef5abso90138626d6.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 12:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735764104; x=1736368904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1qK/YHIED7ifRS6AE0gy4UPNPrutek98NdcvWZ61SA=;
 b=BS6RBRKHeYvvmywjrVS+AkkU3y2OxV6CfVdAEBgx/Z4hGLC30ZTZLWeqhR5JBRpVM+
 tLISCtj0n9W+D0FSnR90Q4bKWPMe8uHQIjR5m6XfCYxeB5oD50LnJSVX1MmgGIXTPxEN
 iB5easgeR9aEuUI04pQqU42dEC0cZlg1Wwji8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735764104; x=1736368904;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1qK/YHIED7ifRS6AE0gy4UPNPrutek98NdcvWZ61SA=;
 b=IzdXSIHDOJVI1ocgud1FA6F41mnKgyEku3SpV4y70cGoRQjrJLEVzETxsjfbHNkP4M
 rnPbmc/l8W3ULIMh5sHCFbrJrFg/O3wbbB6juZ4BOCu2pwAQVYXg/1O/6771KdzytojH
 6qPhAsMdUUm/d9CFowyN48UAIBOH/ij/q5++6kQ3guG2fjDTdcRe0iwk+gpA0AZi/D8F
 jrxiv+C6UQRcmDw8id+gKCWSO4T43lyygT2Zof/IgR8OksaTlx3Es9tlmBw+YzVEmVdq
 cUayL5sre4kycHE+SuZuQoUB8Ki8W+ausYwdrhvPy690nh8carGFZN2t2Qxbup/RnqTz
 8HiQ==
X-Gm-Message-State: AOJu0YzbgQdBxLBRT27FreMvKAsXZ8b+Up6XHcQM5eZPidTUvGN3N+hI
 PmwcmS2VCJdTKc+LO6WYeqSyouYLUCYOXOEEReZ29O2P7vpDRc5YU+CE6ONiYoc=
X-Gm-Gg: ASbGncvngrfo5uFU1WVVfEYGzYRS6oRv8ypvJHGDNvI1venC5Fut8XCpcHGXEdGYIQ5
 8mJuZZBX16FbiFUbtOSsALWefM9R6FSU9w8LyYjGC/0qMxzNthqVOyrLxj81ivbsuUCQUqKfM1a
 fztHorQXZV+03wn5XRDzVXLc/F+Ea8B/ViK2IoB422cVAA1X39EXy+nc2RecOvEqZkpaxv1i/3A
 6KWjCWQ9Tcah1oTwsFOAJ4ZnrJzYYWsOlyt3/IjL1qoNKMMzf2nv6ia
X-Google-Smtp-Source: AGHT+IFnmN6mOfDEj5jkEDh+j6ctNySzgVFqJqCTHaJda67xtphk6eg3NVOqtTf+sKNWTUnD4zv3hw==
X-Received: by 2002:a05:6214:ccf:b0:6d8:99cf:d2db with SMTP id
 6a1803df08f44-6dd2339e044mr837646176d6.38.1735764104433; 
 Wed, 01 Jan 2025 12:41:44 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd182070ecsm124054636d6.124.2025.01.01.12.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 12:41:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 ycliang@andestech.com, tekieli.lukasz@gmail.com, 
 frattaroli.nicolas@gmail.com, Frank Sae <Frank.Sae@motor-comm.com>
Cc: yuanlai.cui@motor-comm.com, xiaoyong.li@motor-comm.com, 
 suting.hu@motor-comm.com, jie.han@motor-comm.com
In-Reply-To: <20241124073844.7785-1-Frank.Sae@motor-comm.com>
References: <20241124073844.7785-1-Frank.Sae@motor-comm.com>
Subject: Re: [PATCH v1 1/2] net: phy: Add driver for Motorcomm YT8531S
 Gigabit ethernet phy
Message-Id: <173576410228.1694690.12985744277466915627.b4-ty@konsulko.com>
Date: Wed, 01 Jan 2025 14:41:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 23 Nov 2024 23:38:43 -0800, Frank Sae wrote:

> Add driver for Motorcomm YT8531S Gigabit ethernet phy.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


