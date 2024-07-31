Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BD8C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 19:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C6388A9B;
	Wed, 31 Jul 2024 21:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z4xGnJYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30B7388A95; Wed, 31 Jul 2024 21:38:49 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1673E889D9
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 21:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db14cc9066so3809501b6e.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722454726; x=1723059526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OJMqI8HE7MIvmA82/1mgno38ZBqjzW3UByG0TeSO9Y=;
 b=Z4xGnJYMCP/RtoMQyi4BlqXKKBwCkzqftkTu9O7UvDdl7IK4B9ko6pW3w7AuiiQcdp
 sFgDbLUoeMIZacsHuOw/L62+cpmN91JeYwg210YwVz9msbAGqb5qtBg1DXRvu6PmpSfJ
 m1K0xGIy1MNmCmw4BSYW+kkwr1cWYU5DZNzCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722454726; x=1723059526;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OJMqI8HE7MIvmA82/1mgno38ZBqjzW3UByG0TeSO9Y=;
 b=YOpg6p7Qg0y+1itKvkj23BOBWUzNwQ0bYJzMPdzg/StBklOnWB6eo4jOU9ZEXY5S2/
 cF0a0I+oRfJdWf7wcYl49UZUEkPftZGbIjEoke7W68aO1qudnx/iDuK527vNcvK0PMCl
 i9e1Fl7SrMbzdSHKQ1V7+fXCxixX6SrQRN62IQiZUG5/ih0cGeK1VCb33ewquC9MtTRt
 oyvTBIQxuwAWhHcS29R70N0+qxV94JC3vjfE0q/chd8KYrwyZex040TA3o3KpzcJvCNo
 gulwQX1C8dVLAbnoLGpX/B9l01InPbK5VA3aux6TEAUxn2RtnCrcdnIP5tL2TYAdtlPJ
 degA==
X-Gm-Message-State: AOJu0YzW+lNIlyY2JChK6wB7wn7v9oGV5vG3JSfkjEdeSvSxzhcJnoAD
 d1pyjdXwrOSQjGmKKnljwTNlBAnw1iKK8UQgZafh7hsF8irQm2pVijNNd0crorQ=
X-Google-Smtp-Source: AGHT+IGJ3lvk6wNn7YsjulzZtR3kvqvwGqRAFSugHGoskghq6srzvPtGtnFR/FZbDBOhU5qgG5CM7g==
X-Received: by 2002:a05:6808:2381:b0:3d9:e0b3:6d1d with SMTP id
 5614622812f47-3db51237c54mr85145b6e.51.1722454725775; 
 Wed, 31 Jul 2024 12:38:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db41806da0sm817377b6e.31.2024.07.31.12.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 12:38:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: sumit.garg@linaro.org, jerome.forissier@linaro.org, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240725135754.1215368-1-raymond.mao@linaro.org>
References: <20240725135754.1215368-1-raymond.mao@linaro.org>
Subject: Re: [PATCH v3] tools: Add script to update git subtree projects
Message-Id: <172245472417.3951333.10077246740164949753.b4-ty@konsulko.com>
Date: Wed, 31 Jul 2024 13:38:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 25 Jul 2024 06:57:51 -0700, Raymond Mao wrote:

> Recently we are introducing multiple git subtree projects and
> it is the right time to have a universal script to update
> various subtrees and replace the dts/update-dts-subtree.sh.
> 
> update-subtree.sh is a wrapper of git subtree commands.
> 
> Usage: From U-Boot top directory,
> run
> $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
> for pulling a tag from the upstream.
> Or run
> $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
> for cherry-pick a commit from the upstream.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


