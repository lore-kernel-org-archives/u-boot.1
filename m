Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00412D11192
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 19:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 308F383A98;
	Wed, 26 Nov 2025 20:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CD3ZZHwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 097B883A98; Wed, 26 Nov 2025 20:10:32 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A010A83A84
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 20:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-450154aa53fso28264b6e.2
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 11:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764184228; x=1764789028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GYQtQv2OgdwNlbN0KZa4+IZPNOMEQA4GQe4Elz70iXw=;
 b=CD3ZZHwDxjK4Y0L8gCGq83KBp9V8C4ai9ckqC/J79VOspW4dF/HycNB+QVtPSVrbSP
 SqNFbI9r8/MlH36jAvLxM7HL3scRDveSrX7Bx6kjcKJNclkqQQGvya7mo0CFHYjCViUp
 n1whUehPVfiT9/FJnq/RbvoAuLujoFM4AzEFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764184228; x=1764789028;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GYQtQv2OgdwNlbN0KZa4+IZPNOMEQA4GQe4Elz70iXw=;
 b=xOkpkrYL1S3TtIyNngTkjlGaEOvhHAGq9OmnGAKCYBEAar9VNXRhv9ixVpps0RPwZI
 vWs0ZJE+vmbI9H4Nd/JbSD2Tw1bxKvSAC3OTWq2skOwXexIZA//xME3Jhw9NcxX9nMSp
 c+CO4w9unCw/K6/Ldh6tyW8U7+g1IdwgI9s8HBshmlz5Nbo+iqWZMlGQkI3AZL3HfaXn
 xlspMuOBKVL276LCBPWHsZXuHI5p+xbJMuy9ad+NV+IIZ140xS7M138MhcrmUXgD3Oi1
 5VhNbvux+0AoGoQBRbmHxOMNdFCYtCYmsk8TkF6YDYRTvUQbIxIKNEywe+eacjXf3i4o
 mzCw==
X-Gm-Message-State: AOJu0Yw/etWLOKQdnixqkPIk8q4dXF5W+KUOBtht5c3VF2FOmQsIrf8H
 GF/5KWxl44l6lj/o/gVHhRHvvaqnnO3C8jaPlOld5r1gQ5Dba+5U6epPc1NlNr2Fybs=
X-Gm-Gg: ASbGncus4gnvOGmApO0gV65vTtrqZd/8US6UcexBwl/eGk2oPcBtgFeg04yc2EJ37r5
 R9Fo8eGDFCRi/NTwxg/fHDickGoLgRdItio+g3Tw41xfnEz8iGEqEOSr4JuCLuVULilWp9K7v1z
 FJnHRJmhB7ybzYaSozGEabumwcHHSQdDDO8CXKiYk8IUZTLNZIUT4GV6cpGm6jLnjVbiTqNsXoN
 0KfZlntcJ6qL/6BMW+sAU/7Vh5w4F4u5tOCsd43EOF7d7Rr2IAWecMqtCXqwKP+bgJ48Ihe+eKd
 2mC1Axn0dnYUNa1BvrTL32SV3puYlNCLZh5lBuWvsdVoxilbd7NBOrw1wiyjOHHVae6GPiLlB1u
 R2cGKz63PhlvLDdNL9gFAALtppztmAqUfVrIXUrAW8NySmwx84XoiU914aQVLHdNRXuF/biRRha
 MjgBYwgFNZpmf0K8KbdfqNVB4widO49h9EhEiO4eiYskig/1CXy30Vpn/CPGw=
X-Google-Smtp-Source: AGHT+IHmuFVc2zJQi/o7E/hedN3OQ8sO7QtaZKSeVyKYjOmNx5bpOx+Qobe0spECLjkIYJrgF/WdaA==
X-Received: by 2002:a05:6808:d4b:b0:450:c877:fd5f with SMTP id
 5614622812f47-4514e804277mr3196675b6e.49.1764184228341; 
 Wed, 26 Nov 2025 11:10:28 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782bacf02sm5227803eaf.15.2025.11.26.11.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 11:10:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251126162407.3767965-1-trini@konsulko.com>
References: <20251126162407.3767965-1-trini@konsulko.com>
Subject: Re: [PATCH] Dockerfile: Update building trace tools slightly
Message-Id: <176418422772.3800471.17792469215815159777.b4-ty@konsulko.com>
Date: Wed, 26 Nov 2025 13:10:27 -0600
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

On Wed, 26 Nov 2025 10:24:07 -0600, Tom Rini wrote:

> We have not been picking a tag for the trace-cmd build process.
> Currently the tip of libtraceevent fails to build. Address both problems
> here by picking recent stable tags for libtraceevent and libtracefs
> (trace-cmd has no recent tags). Further, as it is often reported that
> this fails to build due to a race, stop using "make -j$(nproc)" as this
> is also small enough of a set of builds to not be an issue.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Dockerfile: Update building trace tools slightly
      commit: 4dfa4c14b8e5b37885f9eb281b3bc230938c5972
-- 
Tom


