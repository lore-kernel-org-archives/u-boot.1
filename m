Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F93E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 21:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DBD68033E;
	Thu, 19 Dec 2024 22:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n44OgRXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C878021D; Thu, 19 Dec 2024 22:43:31 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9164E80196
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 22:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d900c27af7so11523266d6.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 13:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734644608; x=1735249408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ft4owGUrTyskKVSc9yLSVK5D8610fpBVZ8pn6F2vPas=;
 b=n44OgRXsQqGGeKi2Bhd5F8ydpK0TOhsqM89nndKmujyu4bdWCad+hoB2F8ELWexjIw
 3niCr3vGKagEGZp6Jtr2TMCsYX5W66KVWsFUtGZ8hWLi5V+iVI9/KgBveOUkbLNhm7CT
 A6QmEH27KaxctaA6HeIEpLvgD7vtei0erGAZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734644608; x=1735249408;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ft4owGUrTyskKVSc9yLSVK5D8610fpBVZ8pn6F2vPas=;
 b=fyApU3PBXwdLLTpk4gNpICbv+9HT6rWEEtuBmqYuyPcXsyK56Fj8F3tFV/A8tUbBDK
 m2X3o+gSr9FrZOdPJwScqImyKFkJwMevVF/MzLaFNKD/Mzz7ejzlhUu1c3Q3SJ9xW2Cj
 x/6XkLqcX01E9qFKJGrhzqn9yV8SEmKB8PDev/ARQv1akjhKs12x4ugCXv41lpiRFqfd
 JwYlgv55n57tbLnFvoE4tRCC7TMhesSYgJRUhV9guza1eBduU38X0RZIUNJ+/YU6nyBU
 NW3S3atEvLKpJ3L23eW+oK4H5Arepq+btjf6bycs+UDpuF5EefLPE2lZ6z1u0N1+W7Fj
 XHBw==
X-Gm-Message-State: AOJu0Yz1C9anYPV0vdR8yd1cKYBUCIhxIG8n6gtE8a+MY7eO5SaWowFr
 0qnIz8T6B+YtRyF/zqOM5rn0eFsjlQHwQvpgJWPPHIa05yv+4PTSLKCURiiQHjTU0r7Nv/A104C
 voGM=
X-Gm-Gg: ASbGncvmT9gGv7cJIgBUj2WTUDGzq5/P4hKqN3yD3c4yrUcp59HBjpkMUCsikrVX1X+
 0HPSFjrHY/nzgW8WGDZO1SQCu20XI6Lj5TyHjbqN6HGtcWwvcGFGTd2jWJl9140UQgmNOhlxJ2K
 y0Czai0teH+WOXtUhZxqfaDlrXLp7hxx2yS+8yIwYuWMJK1IXeGyCG9SfMm2TiYVkVb3jAOCrBY
 etgRPeMdZbdx+3CNcr1E9ASQP+9N2tckF5lrQ988l6+yl0hmEmMvdQ=
X-Google-Smtp-Source: AGHT+IFbuOT8qtASk/WWCxGu5U1C1BPFN4gheR/NZ/kTilIT+Aa3xlnMyOa/NUb6DhXUdQM/cWpNlg==
X-Received: by 2002:a05:6214:caf:b0:6d8:889c:54ed with SMTP id
 6a1803df08f44-6dd2334d31amr8749486d6.26.1734644608601; 
 Thu, 19 Dec 2024 13:43:28 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea824sm10410196d6.4.2024.12.19.13.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 13:43:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241210-b4-upstream-fix-ccache-v1-1-778d07f6d8ba@ti.com>
References: <20241210-b4-upstream-fix-ccache-v1-1-778d07f6d8ba@ti.com>
Subject: Re: [PATCH] Makefile: Match the full path to ccache for filtering
Message-Id: <173464460680.3661439.2860272424162333379.b4-ty@konsulko.com>
Date: Thu, 19 Dec 2024 15:43:26 -0600
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

On Tue, 10 Dec 2024 14:46:45 +0530, Manorit Chawdhry wrote:

> One can use ccache by keeping ccache in PATH or by providing the full
> path to ccache as well. Providing the full path to ccache fails as the
> current regex tries to look for ccache being the initial token during
> filtering.
> 
> Do a greedy search to remove anything before ccache for regex matching.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


