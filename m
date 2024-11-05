Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4F7D1CA13
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 01:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD9888FD0;
	Tue,  5 Nov 2024 02:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bHzsJLr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ECD788CF1; Tue,  5 Nov 2024 02:07:15 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C619288FD0
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 02:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5eb9ee4f14cso2227005eaf.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 17:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730768830; x=1731373630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dD1Fjy+3wkiZxgpnBlvr347/5XfNqAU9EHJcgUZVQCo=;
 b=bHzsJLr24BHAZgMk5jVLWIm3xb4GhGRfdfbnoT+h8ytO9pvgF/EL46Hfk6qq82LV9R
 D708iQG4zIliJC3sdbZ+8zWFS4l29Ge4DgB4xEMQ7pHw9Isp4oAq6rhNubmk4P/C6m1b
 zSFRmjeQ9YerdQ7z1UZgfsfe1YBIZ5VheJif8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730768830; x=1731373630;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dD1Fjy+3wkiZxgpnBlvr347/5XfNqAU9EHJcgUZVQCo=;
 b=oy/bSMhYXgPXUo3aSMbhD2Za+se8g/FWuoJPBFiFuLUpJexp6/sZdwQdmhOUDoBzrz
 pjXOWh5VuBNbjjy/RQAs8PJH8Pf0Uu9qllScw4HiVpzuJlpX8VigEAOiNfgjsMCmMxnk
 HkjSBvxqXhsmgst4AP+c0fg+FQ1gFqHZ9/20YQH2qrYqIYmJyzHOcBj5TODIDyv6u45d
 3h0tJIrr8u7qaIibiGBIcK2dTumuwLYkp9Wj3XwkUYMS5ND746sp5AixrNuS2yFSuK++
 Y24wTCGJH9HKc2emBfgrlJuehFssBnkibq/LdEewi7OcjPmSDsy0zvXNk6JN/8lhhHvA
 9y9Q==
X-Gm-Message-State: AOJu0YwlS8H7MdTNpJdYiQeYy5jmDJw7sOLQLMs4KNB01wS7Qpd96QwY
 AlJP8kXooMtlM4Zx7JdoSdL/iTOPf6AdfVOVsSJc3IrJur162qbuNYmbiImJnj5sW480kkuMMlS
 7hdQ=
X-Google-Smtp-Source: AGHT+IFTMipLAeZK53guXaKc4L9LqYVJKFnrJUILUS8dqyi8PYdAoEnN2OnYd3XTdSCOSfsGIxSZPQ==
X-Received: by 2002:a05:6359:5047:b0:1c3:90ff:9721 with SMTP id
 e5c5f4694b2df-1c5f9a47e1dmr622820755d.23.1730768830417; 
 Mon, 04 Nov 2024 17:07:10 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fcc777sm54436686d6.56.2024.11.04.17.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 17:07:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Yuri Zaporozhets <yuriz@vodafonemail.de>
In-Reply-To: <ZyIx7WVAeVqZ7mY2@qrv-systems.net>
References: <ZyIx7WVAeVqZ7mY2@qrv-systems.net>
Subject: Re: [PATCH] drivers/video/vesa: use MTRRs only on x86
Message-Id: <173076882912.3917422.6576554652309812529.b4-ty@konsulko.com>
Date: Mon, 04 Nov 2024 19:07:09 -0600
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

On Wed, 30 Oct 2024 14:17:33 +0100, Yuri Zaporozhets wrote:

> MTRR functionality is available only on x86, so this driver cannot be compiled
> on other architectures. Fix this with preprocessor directives.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


