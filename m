Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD8A10775E9
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 17:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6246B83BC7;
	Wed, 18 Mar 2026 18:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oEW2FPTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D917683E16; Wed, 18 Mar 2026 18:05:27 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCCF783B03
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 18:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d74dbfe84cso50484a34.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773853522; x=1774458322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QCqBe92H9wCEHDykLw4bqx4TT6KbHhzjgMQrXd5tpBg=;
 b=oEW2FPTc9ne/QFx0oArHwYX5DVl1XEwPMh+VsNRskrJDMaAuUT5ZRv+9UsESPs1vlI
 1y8iVxGPt/APEjLJABrJCKf7AkxKmnIZs1q5zlTggLhD1VbIhsHVzJ0FixsePm/67PFg
 le5wrPdtM1CgRLuW6e/2XQtFlmAm5j8V+Vii0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773853522; x=1774458322;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QCqBe92H9wCEHDykLw4bqx4TT6KbHhzjgMQrXd5tpBg=;
 b=Mf8e+zyK1WpEG6Al8Uup2RWN0zvBLpFpknAgE/BEADywXAkmmUaJT55UJTPUvX8A7v
 MsutIQIbWkoOgGy3olNdA154WjYgQHWRSAhypJjtf18dcxhC3rNFrE8iDeJUipsaC9lG
 ZY+LqOTxcbG8h/xUDeo0+48Bvf6FzbDioAvXRP+k1M+Vx1cMNl55qEucQm2iFt+S7v6s
 qQ0dBJNhvqvstFHir6jmFHDIGflDkJ3wL9Cr4bjijeAflIfP8+CQHZJRK9zigYtRayzZ
 iZUOToHzxsHR5Y0C+NAqudoK7P8g3LR2Rk6590gwb5leAbCw+LyZXxe4UfMq5zQ8wztP
 IQzA==
X-Gm-Message-State: AOJu0YwD4qKgFM5LSbyudridiniLGMUZob0/h15msdbFGpL+nFG8snmJ
 XNQRzVB2hy4AWwZgAclLSKPcgW5ht9hZfY1sNsCq9+BwkBFHcb94rfytW+rxFciL3UD7pT4jbpr
 rmJvr0HU=
X-Gm-Gg: ATEYQzwb3qTWHP7ccbWzKq3f5taWu57VV2viUydn+EwZsJE5RMgQMt+LPK0x8PgpL6G
 HNGETz9y6Ro5WoDR8vEllxR7Yt4bftWmsrThlgOHRyV1l8olh8p6QQPC4BccMMCxD0gs+QvK3zE
 oFh0GbU4bULw8B887u/OQYL8wLax/3fWOyVo4j9Ekm3CrI2/ZdENymdLJHdFvfbI9IS3KzaU0hc
 uae1VewUlg/Qj9dfPY5zWrzq7Tur1Z5uI6KGYbUExv9UjoGvYRBxWbXnQHZcdXwRnHL/qqzghoz
 xFWPGXO9ADdLj+oqKnQBhZZb5uqjxj9S/BletB4g8O/+tXgyfaaHBn7IKZtiUNhkE1563qpZqgj
 LZWnvJeBKyn+oUWOu7anqdSa84QP/UIp1VwBH8DbpeMsWufahp0vrC23nzTeWRX5JR23aLtvE5B
 E+v+fOMe2ASPrRIwM8vCpyOqoPnCSNWbtSkTNdl/Fmm4CTGjkl1Tm4x99tiIprrfFod5G+Xu1Aq
 bqhjNWsSyz7rRJnY3ZKvkTZDTFiEtKDUW9dYNk6WNfs8IU=
X-Received: by 2002:a05:6830:67d6:b0:7d7:4a28:c27f with SMTP id
 46e09a7af769-7d7ca572627mr2483415a34.1.1773853522568; 
 Wed, 18 Mar 2026 10:05:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9985c1dsm2611442a34.11.2026.03.18.10.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:05:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTjdfHsp7GQs0fj06dnrOjUppbbNKd2D4-QnYcedATazPA@mail.gmail.com>
References: <CAFLszTjdfHsp7GQs0fj06dnrOjUppbbNKd2D4-QnYcedATazPA@mail.gmail.com>
Subject: Re: Please pull u-boot-dm/next
Message-Id: <177385352199.1201153.4137655265456719363.b4-ty@konsulko.com>
Date: Wed, 18 Mar 2026 11:05:21 -0600
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

On Wed, 18 Mar 2026 07:02:22 -0600, Simon Glass wrote:

> Trying this again.
> 
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29566
> 
> 
> The following changes since commit a27980786cfb3c430aa1c05da8e79180c584d221:
> 
>   kbuild: strip sub_make_done from test-script environment (2026-03-16
> 10:41:40 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


