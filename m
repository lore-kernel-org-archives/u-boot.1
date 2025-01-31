Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5194CC0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 22:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D7CF80FF9;
	Fri, 31 Jan 2025 23:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cXLJ8Obn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 906E580FC9; Fri, 31 Jan 2025 23:07:03 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7868880FA0
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 23:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d900c27af7so19920746d6.2
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738361220; x=1738966020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQNKGOZICDM4bZQ51EvPJ4KP1FPkvzw9noYoH4Au+HM=;
 b=cXLJ8ObnnQj7fJr72DH27MWCBMDQqxe4+e56WXSoiXTa3yfA5aFdNArCGmCrUBoagh
 U0ovkclspyXrYtwVcwT4TJr1BJtDzaBYylQ/sZ66DPMvkOGt2pcSCMYxRLtwYhtcaruC
 CuUIPBmar3wbctwR7KgCLuGZQdpznIYlgZBYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738361220; x=1738966020;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQNKGOZICDM4bZQ51EvPJ4KP1FPkvzw9noYoH4Au+HM=;
 b=iHRfrnclKqneRXFawM5FgiiRn+atTnuFqmJvEmxgj+OGjOUW3RMckKLQPwB+I4MVpp
 3Rhz0e7N3WTPHdlRPpeN5ss0PvPRHTLJ6kJqamQN22Kyfs5EdMzVJiK6Q3+LO+p2UzH+
 B0JpyheLftC7Q8SnapZrjXdefoc57dD8EXCNPgNPeHeJOpoP8Rm2cS+ApzQqOa6J2srf
 tZ7A2SI7QaLf5Men/5HQWskwUjZYRJq6aojSGIE/WkKFE7BiNG5vDtaiKGz2CKGX0icx
 1i4/la6qX3fk+UpfWaBzcZdblB8XQzl73M0nyowh+t7FOnHFpXYET+WKPgXiNYWK9Ref
 i+TQ==
X-Gm-Message-State: AOJu0Yy/vWzy1FEn8nh9ADekv3FmtTKqzE4Y/xc7OZmZuEnTyvP0UTH2
 iVvw0MPSJV5OfDfqoAPqTdMnbV0mVu8gDmAcrXQ0D5yzy+Wb6ub5+y8DNtyEKBXzW0hsYXISx+L
 4
X-Gm-Gg: ASbGnctY28coGZxUzKafFyu11aph0u2qW9/n+aYe13omwz6eNosCMfyWHV2teqyWNAh
 n72JSyBwGt1RKPBqNSaJjb6tTOVFaPM/fPpkH5ntoIYXUJmdXHNN+8Ze4+xktDqJOAKEJoDDsaA
 HcPcKZD00BGKk6UA+fJC52So2HC6UXVh3RG8kevIrMhcWbPRAI2BoysmnM/qp8Ck7Lk45VuVX9H
 OhZdNrPn/ia9B1w4iIXKP7c6zCw0n/SndWOEsy8PEXvy9RgvLqhlGD7fc6dtIQdBkjdguErQcAQ
 2SVcwxIHrDw5EA==
X-Google-Smtp-Source: AGHT+IEfC+ist2UGWWqC630UORCtatIwbF70H/iR4mk14RwL1pJfGQ9zLZ3KJZmKKCsWhDt0CFuvxQ==
X-Received: by 2002:a05:6214:f63:b0:6e1:9126:4d15 with SMTP id
 6a1803df08f44-6e243bbc135mr159880856d6.11.1738361220430; 
 Fri, 31 Jan 2025 14:07:00 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254819a57sm22141986d6.45.2025.01.31.14.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:06:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>
In-Reply-To: <20250115020729.230536-1-trini@konsulko.com>
References: <20250115020729.230536-1-trini@konsulko.com>
Subject: Re: [PATCH] configs/am62x_r5_usbdfu.config: More completely
 disable MMC
Message-Id: <173836121844.3060818.13379091338936368256.b4-ty@konsulko.com>
Date: Fri, 31 Jan 2025 16:06:58 -0600
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

On Tue, 14 Jan 2025 20:07:29 -0600, Tom Rini wrote:

> As this fragment turns off MMC in both SPL and full U-Boot, we can turn
> the whole symbol off rather than just the MMC driver.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


