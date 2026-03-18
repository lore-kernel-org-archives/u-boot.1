Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5F110775E7
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 17:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ABD083F8A;
	Wed, 18 Mar 2026 18:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dfxj8tQh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65995839DF; Wed, 18 Mar 2026 18:05:29 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B491083C51
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 18:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d773a4af0aso45631a34.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773853523; x=1774458323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXrfgnYMnoJUrEYn4fEd9YHoUkyfd9AT0Bru66Q3zrE=;
 b=Dfxj8tQh96FRGA0P4fO/NVuS+apEYQ8MCSIlebU406HPzlpes1NdxCp37jFYLd01Ay
 OKguTSn4Jjq67oxFHQi63HsJTXGcUzKGx82er5D1qp9tF9qvQvk/3bMy8uJOuKQEhAlD
 El1QT65P+LdE2sMuCkFf2QUIpkh8aXr6IZa4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773853523; x=1774458323;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kXrfgnYMnoJUrEYn4fEd9YHoUkyfd9AT0Bru66Q3zrE=;
 b=f4nSkrMqaoYGp71RqqnuARnARHt0GjAvzxblw5jDR9zNqDYdXYAGqqoCxx+7yNPbVz
 snf43cqY7tZg/ZqES1OFxPs/+wjsw4OMLZMvW4snmF/wTfDQ6l59WcfgRDVxOMKtaV0n
 D3/ggwv9L9lEHwAFkHzj3WFdLBDQqDuL9pDijQ9CsugTaTdQZhxNeDd+1ryUDGDRPfR6
 9VOnYqULltA7htflFl5uhHCDtUQIJMu3VLYZxSd1shGH3u3YGWCm+uaFMhbWB3JfvZ+L
 yXYlLZXdB3E6Rv0cs2fLVFY0pH66bk3E6SkVKdguJXsKtKYo4F3o02jPp3HLg6Tz8XOj
 S14Q==
X-Gm-Message-State: AOJu0Yxpb2iK4WKf/izQe4Sq+I/aWU92sj23uAYoI9eoyuU2ASTWd9cD
 fAPE962CIUpvRnt3AZ7d6VfZ2KHl+GSiJe/DB9EHbaqtIxpgDhgMYf2YmeJMXi+QLxX3JtdwTTf
 ZR6UWeTo=
X-Gm-Gg: ATEYQzxpEAf+exXb3H1gpn62R5rnxOrUwRUVTKyyFLfHHiVJQ9ausbbqZoKewthaF56
 kWPGPyZ6tOYozd7sCyOShorX5nxXYX5tNbjx2OhqKKz7Lz8kJ4OQ2qSqW5lxcOnJt/j4LWAaLuY
 qxRC1xHKcdcrvFIXQ+4F6qpTRWPV/5fORO9YIFVjf/vVNMu2df7/aOvlCJDA0xYWZYI7YB8DpM+
 1PQLFTl0RB6x7gI/zWv7psTiOmUWaX651/PlzTR8Cpq2WAA4B5kNT9+PgSbCrB1sLdJP0/uLPj8
 BFIMs6RWKbRURqtBkknH0OqJPbe0DnS/RNlmCySRh8JXaLkj8Myjho5WnP51im7Fg+aEjcYjoJ/
 O9M2uyehS9/lljGfvzztgzLm+o35CXWxs1pAUg39qCJhsE0OsTguZkEj9gOGxzmJXlS1KYpYJCN
 OSfv8cq2nXv84Ii9CK7BTXbPjYg8OIS8uHWt2FEMnHyL0+mRA57FK8eI1N+MVLTpmlJMD/nr4pD
 J9eMZCb9a0/nuWgrAHYxJfysvqo3Kq3m394j35RrljtGG1VbLdj6z0KKA==
X-Received: by 2002:a05:6830:730e:b0:7d7:b7dc:d9d6 with SMTP id
 46e09a7af769-7d7ca267045mr2482197a34.0.1773853521803; 
 Wed, 18 Mar 2026 10:05:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9985c1dsm2611442a34.11.2026.03.18.10.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:05:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20260317225650.900269-1-dlechner@baylibre.com>
References: <20260317225650.900269-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-next-2026-03-17 into next
Message-Id: <177385352026.1201153.2143833120446810203.b4-ty@konsulko.com>
Date: Wed, 18 Mar 2026 11:05:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 17 Mar 2026 17:56:06 -0500, David Lechner wrote:

> The following changes since commit a27980786cfb3c430aa1c05da8e79180c584d221:
> 
>   kbuild: strip sub_make_done from test-script environment (2026-03-16 10:41:40 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-03-17
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


