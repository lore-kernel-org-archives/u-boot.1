Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AE0EE01EB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 22:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 779058914F;
	Wed, 11 Sep 2024 00:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NVu9OZ2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C938E89143; Wed, 11 Sep 2024 00:38:44 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27408913B
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-45693d58a19so44501881cf.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726007921; x=1726612721; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44mN4k6BdFycoZ5W5q7bZmIyLZSyCp602LxzlI9h2cM=;
 b=NVu9OZ2Huqwxt8tS8xtehMV5kfH3DPCqTtYKi1/fC+eNttIy1iOFlhJ76MHGYNY9n5
 Kt0PpBNtS+J6b6aAUmZKp1+OhLa5thN+LU8zn0It3mTSA9mEqjWylYInTYHE328ONwSM
 VoxJaQShmVG7gg9G92iOcsSU0YQbwhZB+sDWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726007921; x=1726612721;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44mN4k6BdFycoZ5W5q7bZmIyLZSyCp602LxzlI9h2cM=;
 b=RDZnTfeWs2u5YzncH9LNIK4ja1AgVefYwJFEfhKb3+hc5wZlFi2TpIrgwvVuDUOAa9
 Uprvz6vtuuMJWpr5AzinHKIsR/2GGcnGZq9VsXDuI1OX4OKREmYA7F/R7seZpHxS+QfX
 OWC/2a9cwlko/+TzldQYxLr3A+ErtcmKSyRwYXUeS3nopu8Sz+XCWjoTW2a3Yk8+spXp
 gMKAQCE5s39YtIG/dEhC7Ad1Cen5436lXOlqL24eCnW/c6vE5Qjn9KIplDVU9bz/cewT
 d8yf5Xh7wZWO1Xfiv9fBqvty8o3JgPObcbVxwZgGNVvcDbti/gaJPdIJoRzOelCioL4e
 qn8w==
X-Gm-Message-State: AOJu0YwCwjkKzeOE7huGa0dFE6lsMJ/9AAp2uX5muWISE2/QuN/UCNEs
 Cy+5p6QzBWQN4u2vIKsD83MTeHYjp5Y0gI62sY45AxAUfjt0CQk3QybSgT7HrZCayLr5BhtcgGh
 /pNM=
X-Google-Smtp-Source: AGHT+IGSArRNjoJyxk09eVk7Tbz0lzZ4xOF7mtLwEbyW9oNi8mCIPxU1xYkWDZHwEPg69nLAGUbD1A==
X-Received: by 2002:ac8:5acf:0:b0:458:318b:556b with SMTP id
 d75a77b69052e-458318b57b9mr104263651cf.35.1726007921552; 
 Tue, 10 Sep 2024 15:38:41 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e63873sm34009611cf.7.2024.09.10.15.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:38:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Love Kumar <love.kumar@amd.com>
Cc: michal.simek@amd.com, git@xilinx.com
In-Reply-To: <a7d8e32cea978727b902bab5c7ca9e8cf17a0d54.1725302269.git.love.kumar@amd.com>
References: <a7d8e32cea978727b902bab5c7ca9e8cf17a0d54.1725302269.git.love.kumar@amd.com>
Subject: Re: [PATCH v2] test/py: spi: Set the expected error message
Message-Id: <172600792042.367866.1743792911650555029.b4-ty@konsulko.com>
Date: Tue, 10 Sep 2024 16:38:40 -0600
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

On Tue, 03 Sep 2024 00:08:17 +0530, Love Kumar wrote:

> If erase/write/read size is 0 then it throws the mentioned error message
> when debug message ie enabled as per 899fb5aa8bec ("cmd: sf/nand: Print
> and return failure when 0 length is passed"), setting it to None as
> debug message is not enabled by default for testing.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


