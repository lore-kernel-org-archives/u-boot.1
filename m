Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F29C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 15:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206B08144F;
	Thu,  6 Mar 2025 16:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EtzKQXZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECBFD8141E; Thu,  6 Mar 2025 16:41:20 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB4A180FE1
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 16:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e573136107bso655445276.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 07:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741275677; x=1741880477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e8oe0JE2lVjxfBmoY1LNvAkdNgOYJL63uFryImG7rt8=;
 b=EtzKQXZVvEjFHnbzDfk2tGLgHe4YnQZOocqaCcV7blIfr1DxCvSObAxDEw+UJYd7Sk
 mqq9PMpevqVBWziAiWJmwUDvSOeGcIvRqWnpwLQ3LGfCFuaiOgOwrng+JjQxspzC60Ud
 RDgHJaNkN6Y0w2h0Q0q8xzKKjYAWwa7DuLuoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741275677; x=1741880477;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e8oe0JE2lVjxfBmoY1LNvAkdNgOYJL63uFryImG7rt8=;
 b=ISSJQgqnPzRV6zUjnqKa6AQ0r/Pjx4c1BVlltgMJAvBdflBDuiupD7hZNLstIL/Pb4
 w9CI3aBMUHf/XgtJvjwb0I04Kd4MYjzwugWTcRgwA7wIWE9SmJGYaq5Frb6vVi36yIoL
 rXW1whFYN/swwOXInI+XjeiAarGu2anxUjr7TPwB49S5w5kvHSRyv6m6ZyY1uct166jK
 3kL7bgfSxL3uZbtFmzIMJXf3ioaUZCHQ650P+aRAf6H86KD95aa9tmJoVPhqpL+aEOko
 OfVDgbvwONwFdq9BtpzeTPST3LoSQCCYTNrQe43rFWYBAbrvJdQ21ndjhPFaexcdqqvE
 zUMA==
X-Gm-Message-State: AOJu0YyizC05ZN1T+MycRTXXHBn6L8M5bSN8Iq/b5sOirn02HWCvXZBJ
 1eSRRjdJvl3TqD4V4NJx5hoI13hBH2HDtUa2iCcTuK4OQ3nj0N6PgX2gZhaTKI0=
X-Gm-Gg: ASbGncvTtQjoCq7EGx5VvtEJnrwl38qJ9O2RgQgbkrIlLwjkeEhy4wxx3AxSvsSztFm
 HgHocrnYED+P4cX9SeAkmPKmfL8j190+VdObusmi8SEuIREVUKA6RfCp6lgNh693p6/8jkfHfbN
 3JyP7rpwEiFPTVJHn4TsxUDrKSdDUXYTW3rgZ1bfhmdO3xyRJnte12HNTqp0bTBIqPCIW3gyUpk
 4zFLAK5GEQSxI7u9v7UjrQYvQHYsd03jK8khovtFSvjoA1TT1vzUOkxr16zWHamcTYLcX7UhFMu
 fSDRsQIZLZ5Y5YTHFXW+DCEjLACUGoMIrDhGDMGu21cq
X-Google-Smtp-Source: AGHT+IHd6t47ijiNKQQn7G7JYajJhGDAWlrXOcN1dX1Pioxkw6RDZNf8KsAB9xWVPk7DvL2O/YNuGw==
X-Received: by 2002:a05:6902:2a4a:b0:e5d:ca68:5f50 with SMTP id
 3f1490d57ef6-e611e300e35mr9815981276.32.1741275677656; 
 Thu, 06 Mar 2025 07:41:17 -0800 (PST)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b842f58sm348755276.22.2025.03.06.07.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 07:41:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250226153346.2736160-1-trini@konsulko.com>
References: <20250226153346.2736160-1-trini@konsulko.com>
Subject: Re: [PATCH] scripts/checkpatch.pl: Upgrade IS_ENABLED_CONFIG to
 error for U-Boot
Message-Id: <174127567680.3636414.933631099401797585.b4-ty@konsulko.com>
Date: Thu, 06 Mar 2025 09:41:16 -0600
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

On Wed, 26 Feb 2025 09:33:45 -0600, Tom Rini wrote:

> A problem we have today is that some instances of IS_ENABLED(FOO) have
> crept in to the code. This is in turn because with checkpatch.pl this is
> only a warning and not an error, so they were overlooked. And looking
> deeper, in the Linux kernel this pattern is allowed because
> IS_ENABLED(DEFINED_FLAG) is allowed if discouraged and a quick skim of
> the instances I saw in the current kernel follow this pattern. In U-Boot
> however, this is not allowed, so bump to an error.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] scripts/checkpatch.pl: Upgrade IS_ENABLED_CONFIG to error for U-Boot
      commit: 0fd7ee0306a88bd99d3820167fa45a7ee6fbc1e1
-- 
Tom


