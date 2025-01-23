Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E54C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 23:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 292EF8083F;
	Fri, 24 Jan 2025 00:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I43MKTan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E4408083C; Fri, 24 Jan 2025 00:14:12 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF3F803B5
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 00:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-467a3c85e11so10676761cf.2
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737674049; x=1738278849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/MoW8oirDeFgq+x1X459QT7q5PEXv8PaIgZ1D1yoHI=;
 b=I43MKTan7CybAxv9u2C9nzZd9F1W3cYfXBrHwBfPq0uHGW4kMKxahKuKHW9W97hdWq
 VcNvP5EBRKG4FPxrsUq4efhYQTOusyMSHiLcuHoZg53Ukd8cdPTodgP3CquyUbRzCB2k
 TcLDKlng4am7uKdRQYSIrjLA/vqd7456uAF/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737674049; x=1738278849;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/MoW8oirDeFgq+x1X459QT7q5PEXv8PaIgZ1D1yoHI=;
 b=uEY5cpkB0xOf6JyY0EXW1WS+pUC2DfVysiUgCQwFa6n7cssFoxvXWPkLWI3TPsTtWl
 S65ypvTRvtBK6+UtFvXsM4tEMJ7YLe9ulz+qDWwaRqri7F7Kiz7oqaM8oNtRp5jbSR9E
 B5RXMkV/nULEhe7IVaGwx0K65cnDUzvQ0iBR1B5iKezh8RKl/hgLnHoXywUMECDkiC1o
 zLNcExHOZ3zB7vlBLqKpEdwWYThL6fVcSnuWw0my1+Sdv0ZnJ3q48eF13X82x7c2WpTu
 f9Ckcg4RAJmEfFx/tXla/o6rhAoWCMqPJjAmuUz33kltHHINUO58js5mcNYxHtK9fBXT
 iMFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdUN16d7BN2LphM7MrOIVXSCQTETYy+f3l4rWKgdCyEHUsNlpAve8BMU+DNdUYIUISJkD9zjk=@lists.denx.de
X-Gm-Message-State: AOJu0YyJYGd0Glr+Q1AQQMkthULJQtAWDy3dWA3FnI62vJlXrm5ZId7+
 lyOC/s6Xy/VDmhiGM6aydf43mku9FgXu66jQg7WO8PYW9EV5RNDdLcwzdPCP2fw=
X-Gm-Gg: ASbGncsH/eMuuSzK4FFdDwy7C5Dsj1aMsfzZKksUqvvTK+/uDzAJ7BDovsm7WnyC0rQ
 zna8MdmFqigrxA+cAuYqOcDjU/wOx+JfE35XNibCRQosC7ua5Bbaryq7+anM3kpNYbRNlxHak0Z
 MdtwXZ8AT3Yu39NuerphfzCwbjVmJJYpSf5dO/49CvBACz46XXo9bZg/sYOyVEa+NPlwzdTGiZE
 0/vO/PMIWcLbEUOwqAwyeR9cSB+BqQ1B1kVLBY1UD3ethcGFM5toKj/il4UNnImlIQZCsDIL3Dk
 LsU=
X-Google-Smtp-Source: AGHT+IGSnL5TuM7mzcF8koaN0WFG+muza9k1vVHb485uBi6+zqiBiUuIPsZJRNS3Dz9MGaehfWg1KA==
X-Received: by 2002:a05:622a:180c:b0:468:fb3c:5e75 with SMTP id
 d75a77b69052e-46e12b688e8mr400615501cf.38.1737674049327; 
 Thu, 23 Jan 2025 15:14:09 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66b89811sm3753441cf.77.2025.01.23.15.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 15:14:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: w.egorov@phytec.de, u-boot@lists.denx.de, 
 Daniel Schultz <d.schultz@phytec.de>
Cc: d-gole@ti.com, n-francis@ti.com, mkorpershoek@baylibre.com, 
 upstream@lists.phytec.de
In-Reply-To: <20250116112932.1983801-1-d.schultz@phytec.de>
References: <20250116112932.1983801-1-d.schultz@phytec.de>
Subject: Re: [PATCH 1/4] board: phytec: common: k3: Add missing boot source
 to env
Message-Id: <173767404815.3025404.14369078109314327792.b4-ty@konsulko.com>
Date: Thu, 23 Jan 2025 17:14:08 -0600
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

On Thu, 16 Jan 2025 03:29:29 -0800, Daniel Schultz wrote:

> We set the boot source as environment variable 'boot'.
> Also include 'uart' and 'usbdfu' as possible boot sources.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


