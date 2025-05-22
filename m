Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61A6C54ED1
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 22:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870B3831A1;
	Fri, 23 May 2025 00:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cxPfNe27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163BC831BB; Fri, 23 May 2025 00:48:39 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2938831A1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 00:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2d0920ce388so3438918fac.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747954116; x=1748558916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aozQt/w6+HiQZflUk7vyQWh+YaWCK//04zsIMTljuD4=;
 b=cxPfNe27lB/uFdrHcxCguNYPcWagG1n920e+DV8LTmWjBXafyRhuz5cNdyGF47RqLY
 4nF8YVmNr5+XEWcbDkxF+NfaXXUNbrbLPCPwo66ox4MUT+OU4e2adwSMULDouSsrXHR9
 WsFqciHPvQcd5+t9RQgOm4/KJbMcQ5IA9zPyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747954116; x=1748558916;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aozQt/w6+HiQZflUk7vyQWh+YaWCK//04zsIMTljuD4=;
 b=Fy1oMJt5mJzK7RV+RLf5X4jasaTdiivUDwA6OaVrtFNFS/9tVJy9PfWBa1AVzkrC6B
 Z3UXecdKIc9grFqVNEPj3gnUeTLljt4Fj0hwZh8B4RwPlMZUQ5Wl3jjrhl8SCN1j9kYv
 GIYMJzuPzx1PbWXnKpTQl+FBfmMh2ujnmkFvwwFJfRTnldONRC+Tu5hdmmMQwxKcZXxi
 kGVdDMSE/JEcDlvbHs/Vz1oxXMQ4lG/UIlm/35cG9gQW5LCYPfLg/TaY83xotIp1sKOv
 XbrunNXK411HLjPTRnoeCQ48TEnBIQyco8t3a2ntSov961XuxfhWy3x0wp6M0csn70w+
 jmEQ==
X-Gm-Message-State: AOJu0YyYWOoQRVBJtsWluiz8ngyAzTvlqfeSCuR8adYXBPqGFidC2IVa
 Px8gxLdzc3zZqieJf5zo0CH8nnW8QuPedgs1SxgFScBjgjEkzprXGq0WAYRAMQIvbf8=
X-Gm-Gg: ASbGnctRgXcANVS474AQdCye7QzXH130R5QnaWYG5iVFqegCt1M2gRtBae2g0hZCvLX
 lGSXostuua03QnIbfwqJDn0s1vZiy25M8LVRhcmW6FHp2sC3c0IuOID1ropav7LD1CXMx1k/Pk3
 KwFrj3NWyu6dBCv6EnW4umThMU6HWizvsfFQzxT9fsPa+Oi5F+BRTqE0QINEHtlCevSozN2raWV
 pggxwfaDzmUTXkPGRYMNHU/RXnXFXbTkg21Tbq3LaI/LLYp2nEc+kXLTDTDQM8J/Abm1kHivlle
 mLwihb1i3l05YmUDfqtawgRGOD0kBd58K1eBzO4bUwpTABsWoyW4xwzdYU+4M2ZugKybcp3769e
 p0w0Dl+jptgE=
X-Google-Smtp-Source: AGHT+IF8YxTXeU/vEVz2W+uNrAbbHwneIV82PAQBOqHw7wbPjkVGzM19HV0eeqBFlTKsMXUqwKmTOA==
X-Received: by 2002:a05:6871:215:b0:2c7:6f57:3645 with SMTP id
 586e51a60fabf-2e3c1c9ba0dmr15298300fac.18.1747954115700; 
 Thu, 22 May 2025 15:48:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c060af78sm3258534fac.5.2025.05.22.15.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 15:48:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Apurva Nandan <a-nandan@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250506-non-optional-v2-1-f58b12aab913@ti.com>
References: <20250506-non-optional-v2-1-f58b12aab913@ti.com>
Subject: Re: [PATCH v2] arm: dts: k3: require mandatory firmware in binman
Message-Id: <174795411402.2210140.4792669162135634506.b4-ty@konsulko.com>
Date: Thu, 22 May 2025 16:48:34 -0600
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

On Tue, 06 May 2025 08:11:45 -0500, Bryan Brattlof wrote:

> TI's Foundational Security (TIFS), Device Management (DM) and Device
> Management and Security Control (DMSC) firmware are required for a
> successful boot. Remove the 'optional' flag so binman will emit an error
> if these firmware components are not found
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: dts: k3: require mandatory firmware in binman
      commit: d47af3aff5f8697d64720a6e1e01bf6e95d8a510
-- 
Tom


