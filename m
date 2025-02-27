Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22346C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 15:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 570FD810F4;
	Thu, 27 Feb 2025 16:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mx7dG/5F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C0E81111; Thu, 27 Feb 2025 16:23:11 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 254AE810F2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 16:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220f4dd756eso23051655ad.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 07:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740669787; x=1741274587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16RGuj2vt96BrOHsWBKvgSMufyXMqdJpCQxxBh9ZBOo=;
 b=Mx7dG/5FN46NgQ9aBZDbcwn0Xsj9fp7DKFMsVmw9oPWAp+OhSIjzsq9MtwDwrFs9P5
 7LGdwc9sQdtBpgHoyxCV51nIWikDZzbi+md7eyKgDFfSUHGriJ70tD5stHUv2q05km4F
 Fe6HyasvJHPGr591CFq83pov/Ut0Pf5yMaJOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740669787; x=1741274587;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=16RGuj2vt96BrOHsWBKvgSMufyXMqdJpCQxxBh9ZBOo=;
 b=HIrX70uevhc2bj9x/XjpyF9cN7jhKSumwb07AAEJIQKAUjZYRKPh3iL2MQsUyMjcIf
 H0NkJymniRu9fIJDnedpfV7fGhN2866wDRXd4e3+QHs2RH57+Uq0KSNH5njdVx3kfJDv
 2W6toqXA2VC1O8EAuAUkAr5kfZEZlUceMDdjys1dJKqKnNARF0MaPpfFSKdfzeCVZBDm
 R1JWdquOEIA0K4eTNE5cwZzi5nkOtvX8qqyrP7A5e4Vdbm+rDbqC2Ty9UI8k5ZLJ/Fi5
 53r3BVI0qqvwGLC0epdqKkCiTf4IUulgMo9//kv19YPKD2H2Q4sYuiEq4e5CPtiNW7pc
 VPhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZJGnZM7q5k5/g4U1wQwMN5V8GhTyO8OjE3ldJDyXUHb9xCuRv53q5KmVs9bjexjLyqA4NXTw=@lists.denx.de
X-Gm-Message-State: AOJu0YzcNvhg76u/3+pqBl1MfcdIWqq9wQGIgOId+7c2TmgdocIk76s2
 m58QGuTVmHdaytfxcXOK0K/frnn5fI/vsoRzkvYak03JLpQJQFuo1MiCni3UnbI=
X-Gm-Gg: ASbGncuulDG32M72b3bSbBXAjyEkytoABsLm3LvJ2yMVfRkfGqNp5Kz1do1VhS3fbsj
 Ovdui47KyTUeSE4Mx8zILdoRzcXi+vf8yOPbB06aIJuN5F90ruSIzw3xlYtlvRxKGI/nldsDTjK
 lgVKg7zagqQdgSpLtdsj4rc2a1kJrubtjsVvboUOu6ZXta+wd3BkPOW73dzK60j8rPK9LBmyngU
 D5bqdZR65fSWt3Eygo3hKPF90V1zgfC7qpE94kAsNFCUrvUXfTUQ+GbTjbQ0vq+TPE47LbaFEr1
 gOIYA3nefwgSXFNWsTUxQE0=
X-Google-Smtp-Source: AGHT+IF6mZ8Tyey+w8jgckpQp8MfJ2bSwswq0g2r41kpJjrK6WFCXwLCckriiVD8plIt0vqS0Z/iTA==
X-Received: by 2002:a05:6a20:a123:b0:1ee:d2d9:351f with SMTP id
 adf61e73a8af0-1f0fc99d3dcmr20157352637.42.1740669786166; 
 Thu, 27 Feb 2025 07:23:06 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7de3c4d4sm1383802a12.46.2025.02.27.07.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 07:23:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: w.egorov@phytec.de, u-boot@lists.denx.de, 
 Daniel Schultz <d.schultz@phytec.de>
Cc: nm@ti.com, n-francis@ti.com, d-gole@ti.com, upstream@lists.phytec.de
In-Reply-To: <20250211064205.45087-1-d.schultz@phytec.de>
References: <20250211064205.45087-1-d.schultz@phytec.de>
Subject: Re: [PATCH v2 1/2] arch: arm: dts: k3-am625-phycore-som-binman:
 Add custMpk to overlays
Message-Id: <174066978494.3965812.6528002106252735278.b4-ty@konsulko.com>
Date: Thu, 27 Feb 2025 09:23:04 -0600
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

On Mon, 10 Feb 2025 22:42:04 -0800, Daniel Schultz wrote:

> There are some device-tree overlays with missing entries for the
> keyfile. Add them to sign all images in the U-Boot FIT image.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


