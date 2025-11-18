Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4447CF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B54EC83DE0;
	Wed, 19 Nov 2025 00:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TEuHbzz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37486839AC; Wed, 19 Nov 2025 00:33:19 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 037BA83B95
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-656b32a0cc4so940496eaf.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763508796; x=1764113596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeNVJut7mXS10ZFGGCuLnatwA9yTPxCGuMLd4ttoOWE=;
 b=TEuHbzz07aNIebkcUUbGMB1c1OjC+ymsUJfeeRWmNRXQBFi+Pgj5f78CL1m0mf3ENL
 oSQ8ANXXxKFdcet0CmxC9KR8lrs96HcTbtq8ZTj0zEmA7u4J7yjSndVNA8aiAGDubErK
 brnlJaPGwwheecduH1yZrUo3p2BNcgFTebRCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763508796; x=1764113596;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OeNVJut7mXS10ZFGGCuLnatwA9yTPxCGuMLd4ttoOWE=;
 b=Gl2UkLKq+WHO66kXGjaoMLVm6hWRTMOpQd1D/+XPXd4rCtYfvW49bW+hgWOnE1vbYZ
 lJIlmUA/auyxxJr+zs4+d71d2rdWfSVYzv92w/JX8cvNVT1CQ0Yv2FwPMky/GyrD+E9P
 D6ECQxcBWYA6JPoaozNIISDpKW9mfniWeCfr8f+V1S7pPqnXGtwuEYOkox55kfVuGM2H
 vqWN69tABXmYnl5omsJultgy9pbSzaJ08RSVH8RjGz5PC2qP+1VyuEToZ6P98y3E9Qeh
 +n0S0a3UDx/un3U0AQ1q3/f3bw1Lyc/cfkfUzBLF9Tagex+yVaC6+dipqa39R49zwccX
 Kkxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUp7GKn3oaFtccZPiIpwleliqSC+b06lbbay0jC9nZZ07w8BfaA5ZARS1Y6RJzpOpi6YJGuCI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxaqr/Qgj8J4D+2fVr/OIpSJAQuC89QQnfwlHQclRbBt1G5D3I3
 PhTe+J1kdHSi/vqzvBamdwqqqWCzh9fNlK5Y3eM2rtoFhDSYTbaYvS0bFTZDwCmXNRm+Tp9+IpQ
 W2oHw/mtogA==
X-Gm-Gg: ASbGncuxx9lHOMsXMCFZNolPCuC7Q8qQO5HscKTr5bwB0iEtqxSFaHqiCDi+qZ426/N
 ikTW9wzB375aQV9QOuGqARKi07UvHeNG3+8gvyU46onWr8u0Xdou5/2MItPa2V4w2Lixp6YWDi4
 LHPjOJVt3TxW1FFB+S7SKnHx/lgjAXu+zOop9JeWGpZAfSDEN7y7wqTspLup9dF3BDF2aY5RgSK
 QL1sZNdTvqxVtuRygeUYMZHehsO9oQN8ifMNqLyRvPxyFuo/8TbUf8Yief0P7o+GaCMQEkfgg2s
 NjLQ+ocgmtNZiyCYlexPzGHEPFEwi9GuexZEdZT2ZfN+paWjfMoBY+vgVeT8NQX2vm/cs7oidUg
 kKgkb55K/DfLoqn2X+RpryvAFY5xuJrZCaI68Sq+HzJYdlg3EWzrRtplB0pkEoxfWMvEPMwsUa8
 h3/3eD1+hxj6ZVBL+MJKfda1bDrxUzHRAe2fb8uExBzx+IyOsCsXQRfpOFYJU=
X-Google-Smtp-Source: AGHT+IE5+1hVmmDcfQM7K2HQqLcnVmvPSgz7SAhupSsQTZDYOPLfDSS2HSfW99SP/0HdKRByThNpXg==
X-Received: by 2002:a05:687c:218a:b0:3e8:8e57:a7ac with SMTP id
 586e51a60fabf-3e88e57bdc4mr5175835fac.55.1763508795761; 
 Tue, 18 Nov 2025 15:33:15 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e89697fedcsm4075794fac.1.2025.11.18.15.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 15:33:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20251114143924.155639-1-heinrich.schuchardt@canonical.com>
References: <20251114143924.155639-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] .mailmap: add Raymond Mao
Message-Id: <176350879509.654721.3268960243393034225.b4-ty@konsulko.com>
Date: Tue, 18 Nov 2025 17:33:15 -0600
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

On Fri, 14 Nov 2025 15:39:24 +0100, Heinrich Schuchardt wrote:

> The Linaro email address is no longer valid.
> See commit 4cad9faf8d28 ("MAINTAINERS: update my email address")
> 
> 

Applied to u-boot/master, thanks!

[1/1] .mailmap: add Raymond Mao
      commit: 829c2f022023adfa134810cca3ffbfc10c0636e1
-- 
Tom


