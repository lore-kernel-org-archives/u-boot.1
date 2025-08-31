Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4582CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 22:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3AFF83447;
	Mon,  1 Sep 2025 00:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WitJccV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59DAE83447; Mon,  1 Sep 2025 00:38:21 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D98830E4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 00:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-74526ca7d64so3362076a34.2
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 15:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756679898; x=1757284698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LgqmVL/59pUIQer0KzSH8F19+WyQBg/o7Q0GWQgtSv4=;
 b=WitJccV/Z1LYI81/rX7U77UWROuwonk1m/C6gy3VVAtdVFUTJpy8Swpq99sQS2up+V
 yfBOGBQSy/O6BGwbUJs3SSZWA0FnBBv6Vc6vqglBF6x8GVNCjlIbdNgUEacnA+Cz0Afe
 KbU+qBbuw/rR9wh/zJvdKCTi75E956uU2CDaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756679898; x=1757284698;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgqmVL/59pUIQer0KzSH8F19+WyQBg/o7Q0GWQgtSv4=;
 b=F6f05dMFB32xpwNiYgFt7hRsumJBK1CM0rZZynr0nuyY7RKAKTJZ7fSVvxIyP0aTkt
 T6TqBLqwXo8QiY8jdijDt+CXAAVIIGoqtSmHn5bmY+YngyGJRW8ACwvNsbwGsHhQu+Z9
 KQx5WXO4etghD2xnX9uUSNGrmZw9nZ/jTxRPjno1FVW/unJnfMrnCwSfSlCl0niYCZXA
 zV0Yh8FGPIN//azgR150W+nhHwqYQDahT/CWgFgRgNFUmWWX93S7jmJ5/4Zky54S29Tg
 3hoK7MSBLIs+mdIh8iglgcVw1Ay0oexPCDdSbaQT8I04FbvbR6/tTmOtSqlwB6LqtQP4
 PfjA==
X-Gm-Message-State: AOJu0YzWBQgX4UEY4Zu9o2quDOzyYF4SF9YEVOmL481U7NO8VGCZDjel
 Wn4PdVo3JZMjdcGcAGjllI69brL5I4I+FAuH6jT2jeiQrfRbtL6KWmwNcri8d7F2HSGz0Svk6Ja
 C5btEQ4g=
X-Gm-Gg: ASbGncsJptjbochOXQ+CBn/3FioWyOnA2RjBRv0utVrr0R8dNHbW0yTSSBW8M6fqQWT
 wJrC1FYXNlL8xC4+8USnvXYaApgk4haGha4cbhV7NOK0K85j3PamSQCjRyR1dGAH2oItChGeiFu
 /HrC5BIUp105oVJQSniga4eH0dfu33nLqqCtKmR61OAYjzSvlypgTGGsi5IwoqY1hSfkLhtyq5K
 5q+EDpbWXQXLrmOpnZWyP+foEzsANCcqYrpEQX2TLgqzMKhrc+VL4PAnjQetphN7uBb+/DYBvqA
 BgNPGXzeQz2lRMycUJ9JuQKN6DtIrsJG5d3fJe0f5w41TEoxEKrqyOPKK1DFD9/UMpkatzkWbtN
 hHqo+g3z9mcajNY73i0IMvyFH6tS57IqVHs+EEo0HLUQdNkPXM1oWzH0=
X-Google-Smtp-Source: AGHT+IHnexiWnHe6RnMeAmyQT3GTxAbWzwryDBlPYtoht8fgbBXdxYqu7WgyXNozF9mAzYc2zwevcA==
X-Received: by 2002:a05:6830:3805:b0:745:59ae:8d16 with SMTP id
 46e09a7af769-74569ed5c24mr3030668a34.30.1756679897887; 
 Sun, 31 Aug 2025 15:38:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7457428c153sm692089a34.8.2025.08.31.15.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 15:38:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250704215021.3419863-1-trini@konsulko.com>
References: <20250704215021.3419863-1-trini@konsulko.com>
Subject: Re: [PATCH v2 1/2] power: Correct dependencies on POWER_LEGACY
Message-Id: <175667989658.2964020.5961555005739060219.b4-ty@konsulko.com>
Date: Sun, 31 Aug 2025 16:38:16 -0600
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

On Fri, 04 Jul 2025 15:50:20 -0600, Tom Rini wrote:

> The POWER_LEGACY option functionally depends on not having DM_PMIC
> enabled, so add that here.
> 
> 

Applied to u-boot/next, thanks!

[1/2] power: Correct dependencies on POWER_LEGACY
      commit: 31a309ff3eca5a9bb4fa8228d5270d792e7e0522
[2/2] power: Split *POWER_LEGACY portion of <power/pmic.h> out to new header
      commit: 9d875d674ff830a6036153a4c390c75267e775b6
-- 
Tom


