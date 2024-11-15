Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC97D6DDCB
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B39A896BD;
	Fri, 15 Nov 2024 05:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PzCWaqIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E043089326; Fri, 15 Nov 2024 05:27:48 +0100 (CET)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CF989693
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-50da1fceeacso163561e0c.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644866; x=1732249666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jS6PllYP0kEqbWb6I9HkmZ3d++w9BFDvuEY2WUrx19g=;
 b=PzCWaqItlLYXWv28z9zKUnZVw1p7HFbC+N16oaEMrPeoai8ewK36XpGxJfnWtYRzyg
 h6sNYP7F23jfVksrszu7Dk0bmyuG5vognNKnIRKPG4JhfcNLBDnarB2afABlJolflDl9
 AIfrue+YPKEcrDZd2pH2AqtNPCSDd49aeWPQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644866; x=1732249666;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jS6PllYP0kEqbWb6I9HkmZ3d++w9BFDvuEY2WUrx19g=;
 b=qebTEKztj5deQY8ceaW2HNEA65ZLesCKCXrItKcP2un8cfwEtAwUY7ciegyW8418ae
 Ld1KALkX/4Vbvq6sCmpuUfhcvqgxDq8KKj2e+NQ4Ow07F647NxV4wWcbzQwjxrSCog8t
 0RExOnjNy9N/PhyJaNKtNAQS0djb3T7UXaMZXQAMuY4atk+8NcSiPB/NGy9tsO9OVSN9
 bpH99h/GUJIzeh3EMu/kZj3/8SAoJNkxhSL5zeeHSUczuyTgdTlAIEJxIgoXIkk09YdI
 wfU6H851Nv/OQObfRKghNv43i5vs9CTiEowTdIO78kafpryCBbv4RujlFi8LBhz0SK+L
 xIIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWLUCqvcnazI2bqKpx9FsQOlRdloDbwSTOkBDka0YEl499J3+byf8JkszKgOQy1REmzlKVF4o=@lists.denx.de
X-Gm-Message-State: AOJu0YwIPMAjLaZc+jfYqOAsJ9WfKM3W9HnkX64dpkD8B4Se7L4xcNIK
 URBLj1jaNQdbokJqaClUBIOMWucQzFYTHxNtg9D8BhKLgeo9zWA7bXOpL7UI65o=
X-Google-Smtp-Source: AGHT+IHUK+f6GRv34AkNRD59c3Dpar5IdsXglbSkae+Sm+iM9lEI61Pzl+h5uQ+d3LNso5yN/ehKvg==
X-Received: by 2002:a05:6122:a15:b0:50d:5be4:c39d with SMTP id
 71dfb90a1353d-51477ca19aemr1740449e0c.0.1731644865777; 
 Thu, 14 Nov 2024 20:27:45 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:27:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20241102063226.39388-1-heinrich.schuchardt@canonical.com>
References: <20241102063226.39388-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] lmb: do not panic in lmb_print_region_flags
Message-Id: <173164486334.1205089.6522401417743393535.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:27:43 -0600
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

On Sat, 02 Nov 2024 07:32:26 +0100, Heinrich Schuchardt wrote:

> Commit c3cf0dc64f1c ("lmb: add a check to prevent memory overrun")
> addressed a possible buffer overrun using assert_noisy().
> 
> Resetting via panic() in lmb_print_region() while allowing invalid
> lmb flags elsewhere is not reasonable.
> 
> Instead of panicking print a message indicating the problem.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


