Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7309ECAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 17:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00875833BF;
	Thu, 11 Sep 2025 19:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OhOGkN2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F718833ED; Thu, 11 Sep 2025 19:12:35 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB4BB833C0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 19:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-30cce892b7dso454433fac.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757610752; x=1758215552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTpknuxvnXWl9EWDJSp+cE1RwxbNfLXBzVtmqX6UM08=;
 b=OhOGkN2HKN0Dg76FMI0jsHgadbaP54AjFuCK2XSo/VjVH/uSwXDF+1x3raO5li3h6c
 4oXNjSD+3QhkyN6QCbKJM/IWjasfGUnETCSrsl5mkfwlzhJFl/T0V7B0YfOYr025uWYn
 Mt2yyCYVBwvJqWsG/HNCx68Hd2ZHzbXjMzUI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757610752; x=1758215552;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTpknuxvnXWl9EWDJSp+cE1RwxbNfLXBzVtmqX6UM08=;
 b=FIbNIQDXUGyk6cSvVSgVbElcQDBoFvGyRSUcc1ZSLKpmYgfSu6sZnzP8MDwPCkF4g2
 uJhGFx/bpAnQ6+2316IYonlk8tV+YANXqZpbN8GgwIghHqYEDw77uQCVQ3Wz3Rt179Aq
 ML3LJqIcEO3jeCxZy5yelf4cq2cMdFm+OJTUkBSobyR7+4/YfGHYECm92aabHFNQHK9c
 J21wQV70jDf6qzWC1RFBmJIBzWuJ2Q9MmRXFw+sLzc8jDqrPS5/lFzIAlsXarsrqVndI
 5Gtaxbre5s74kVOwWpakaOWpCxqrov23A8eT8pu07aOK4QLn66vyUUScBA0b1wVmcE4N
 Il7w==
X-Gm-Message-State: AOJu0YzuHKzO9HEUXFbtrwf+pgkV+Zoa1r7s/KCv6Vl6Klv2fp5a/Mr7
 NWI1NSkoAZSPhbzGHWBItkvjeW/+6IFSqo+RXuGxJMhofSug5pzvQD63jUib2Dhyif8=
X-Gm-Gg: ASbGnctrjc+Rm1T7ub+f5UGrSqem9ZEiWlFktY5o/RNygrRxaNWPbjQNFnpt9VPXEYO
 ZmH+2UsR6ig/Ya+HL4o0ft2UnJbBsXeP0T4Hg44V2Ea0CIsGTCUb50QnD4BFYo0kHdUlM4XlRQx
 QjnTYIXXar9Vd91pfSlXG28FMiZRF3VT2X5h1xBQoTHGUnad3hJG6bCkGH3I4YhAzs8OTI5XiP4
 XJz/xvwsVQrH1ACbo9Hgj6xSl3BaczYYWRWGM7TrF6K184kQq/pDU/lGWV7ZN2v1NUOC3Vd0ivx
 QDt8FHmgRD0/YJ5SxaS4ks9CrQElH/9MXUJTre82mZTJ/6/364SAi1oQkdJYWWedWJerRKNffr1
 CRBxbT6k+BstNXEHvz+fKYRAjvYBfuYo6Y/1MEt6eX+5rf4/zGdqF4+3orD2I92yDaiPJVEtc/H
 V1
X-Google-Smtp-Source: AGHT+IF6UWoVm5ZpzfKqiz2K8px0AetEpQQtj0Hw9D7sTlZrW0RQ/1yWgOaALM9AfvTBoRlu3EuWfA==
X-Received: by 2002:a05:6870:9f84:b0:31d:7482:326c with SMTP id
 586e51a60fabf-32e5457b8edmr5385fac.14.1757610751624; 
 Thu, 11 Sep 2025 10:12:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d33454175sm539312fac.10.2025.09.11.10.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:12:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Heiko Thiery <heiko.thiery@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Michael Walle <mwalle@kernel.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250911093223.65323-1-heiko.thiery@gmail.com>
References: <20250911093223.65323-1-heiko.thiery@gmail.com>
Subject: Re: [PATCH] env: fix config dependency for
 ENV_OFFSET_REDUND_RELATIVE_END
Message-Id: <175761075036.2771962.696597894177423832.b4-ty@konsulko.com>
Date: Thu, 11 Sep 2025 11:12:30 -0600
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

On Thu, 11 Sep 2025 11:32:24 +0200, Heiko Thiery wrote:

> Since commit 5fb88fa725 "env: Rename SYS_REDUNDAND_ENVIRONMENT to ENV_REDUNDANT"
> the option SYS_REDUNDAND_ENVIRONMENT is no longer available and should be
> renamed to ENV_REDUNDANT.
> 
> 

Applied to u-boot/master, thanks!

[1/1] env: fix config dependency for ENV_OFFSET_REDUND_RELATIVE_END
      commit: fd7510e516b519864680c4a56bc14dabdc91607f
-- 
Tom


