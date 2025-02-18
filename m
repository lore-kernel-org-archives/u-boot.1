Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C23C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 16:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928C080F6C;
	Tue, 18 Feb 2025 17:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tABUW/Mn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF8680F67; Tue, 18 Feb 2025 17:31:04 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC5880F0A
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 17:31:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fbf77b2b64so10686147a91.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 08:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739896261; x=1740501061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8gUye9K/zq47ZecGZ+9bygvI64tMe2Fh9uzvtjXVkc=;
 b=tABUW/MnsW6Oc58l017woFMDFJiGeHrJ5QqZWWclVL6eHvBM+q7rxhPAc/QPBOJ5uT
 oiyIUiyTqyfL7sVqMD2n34oTTdJwzTAHfb0AHq6xlPUqiy2vzyVFsCi4LR8IOHo7uviy
 Q53P7BxN/T2hqK0bZGqECXAnUiO4sPvw2/Hhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896261; x=1740501061;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p8gUye9K/zq47ZecGZ+9bygvI64tMe2Fh9uzvtjXVkc=;
 b=k40WIk/BBxHqlTayRbdovmoFCRwYxrjlG9Xq2WLrQWPX4A6Ii3Tc44O6ykH9r1jISj
 EJuk4dh/MmWP5mxfOLaaFHsAVTz8jjd2UA4z0K0NGKHBjAsQyoJE2jia/eDEK0Btzv1k
 jYsLv1A5XraMkPkCUrlCIAV970qcXiiGznZlFmdPxOVErNbUZcvHnmPRy9y7NfKaHXKT
 uHAmIjgrwU70eUgufcjb3XQEBFtfARAjoklEqf1/3OkLGZep944HjOWDDh+MmwhTt6Rt
 8I/VQbvr2wIY5yK9xr2uX6FxcoW+NIsfQnvftgJ3/IG6Z1r7R5l3/iDVSk+jemvS8Dna
 L6YA==
X-Gm-Message-State: AOJu0YwbSNRQA9DR3ky9X1ov8GTAM44fyFZb2PzIEKveoYACjIND6QeF
 BMDff3Ncl21R+wiShZaXu7cn+qRVTU7eQgSr13r4c0M/ruANV88bj3wjFY31temXqtF6avBt8R5
 T
X-Gm-Gg: ASbGnctARq9JI3tKRRjxyH+GIXa5Jj4WAgDUiqeLBsumkMCpq6o/yHB0zgjbixFyVhT
 jsMhgIQKFpf/H3gCtuAz+cn48WsbW7NMJe/iyFxARLCa7nTLY+9t8G0iCmkmpuqjRE6A63Bj87X
 1AMbAXTW5W/Qz65Y5ca4HYsNZ+TXr9HZc2AUOGOmgYd/t1DGUMGFKZVH2Fj+JHfIbXAChAHkpUI
 4Bi7EdBzZyI32Op7lQakqLf2lfUUqvsYoulbLerpSvm+9lD9Gr885Aa6oSIVmoLf1Q3py003W48
 P84Tt4eWqLyq
X-Google-Smtp-Source: AGHT+IFTnCddgmy5hBEJzf/r5wPm36FADtppSO6GCDNHl9F01AlVRgmRzVwAqujUaZ530PWVtW3n5Q==
X-Received: by 2002:a17:90b:4c8e:b0:2ee:53b3:3f1c with SMTP id
 98e67ed59e1d1-2fcb59ec4b9mr84179a91.5.1739896261157; 
 Tue, 18 Feb 2025 08:31:01 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ab1018sm10359230a91.7.2025.02.18.08.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:31:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: open list <u-boot@lists.denx.de>
In-Reply-To: <598ce065-3927-46ef-ae2d-1e49d53d6ff1@linaro.org>
References: <598ce065-3927-46ef-ae2d-1e49d53d6ff1@linaro.org>
Subject: Re: [PULL next] u-boot-at91-2025.07-a
Message-Id: <173989626044.448476.12208028929303506932.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 10:31:00 -0600
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

On Tue, 18 Feb 2025 14:40:03 +0200, Eugen Hristev wrote:

> Please pull tag u-boot-at91-2025.07-a , the first set of at91 features
> and fixes for the next 2025.07 cycle.
> 
> This feature set includes improvements on the atmel-quadspi driver, a
> fix for the nand driver, and improvements on the pinctrl driver to be
> able to use the Linux DT (also sync on the DT side as well).
> 
> Thanks,
> Eugen
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


