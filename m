Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B449C369AE
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7668C840F5;
	Fri, 11 Apr 2025 16:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R6iRGedA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6C35840E0; Fri, 11 Apr 2025 16:49:01 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A28840B1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3f8df49e75fso648708b6e.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744382938; x=1744987738; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oMtBkHV6XU7ANC14zH51CVRvqSGH2f1Vogj/F4nAEGo=;
 b=R6iRGedAXFo9ZDQyaMvLNI422KcIhuPxpvoZ7mRFYyz1KzrGHPFX3mLnGn207oBOsG
 EaQDRtBed2sBC49xyugvhRwqhJ06vyvgkihCPU9KNEeR2Jq6Xo+cvXE1imgx1uhFIiEX
 oo3vzacG9YvruWl8TParkleZ3ALi0U8J4uIBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744382938; x=1744987738;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMtBkHV6XU7ANC14zH51CVRvqSGH2f1Vogj/F4nAEGo=;
 b=Wo6Kr+YU5mXJg68IBa61R+M8Rsiriym4YSHTB0hYogkJMYofFQ24vH64sTjSTZKVJe
 REeLiMLMKyjnJGvFvpaGposg96h8uwvk7X5ToGheKxWVgvvPiEWAqVW8xQu/WdMP8fUu
 vniQdtxUJFtjxEfjyyIHPv1AuGKdN06r2n38+azDl5sXpMH4aZW/Y7YzDa68sOz1x1gU
 sGqWc/044sogSyJJ+bpYVbI0mz7GNLpkL/QjvkbtebHl6CQqoCaRHtx8N8V8kzTBbHZV
 BNODi8DdQ56c8I2/3cgfQeEmA1i/dAb0hxb4QEgpJAA01BKLHFnI6EakHyNTZfIsjgbh
 aesA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwjHFrpzclrB0EYdkNE8U4sncs4NN8ecpvG6hqJsJf2DhigelYrxMQb1W2kqnM9GG5gwFgJaM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxh7ymuyAx+OTomWpkK6Y4OefbSZsI+4GIebohLV4AdSe+uB7ex
 KxVIzVDa4EbnP3hUR7HHnfxTAxLjlWUhd31x1qaYzC37blAwsM1EfXDAaSbtL7o=
X-Gm-Gg: ASbGnctE99iFcwt+OdFfh/QIsRYsEOCl52rzi5PTtovFmcvZJwY4KcMRf5cNMEZkxvl
 PNw/2iKR3ed3ZU7EU6SACk0OiuP/LE7Z22UxJ/1trFy3n7fzRn+oJ7BwHfYxsEae7nzP9QUtwxr
 i2ke7riR1Klh/Brs9aTZFN7k++T7xmoSrly5QGuGRz1qx8qSc49I4/G67rDLOqr34lFC22usD83
 OZK/Rfg6KsFV+mtuf6OzSbyFhk3E4cBYI1nw8CQL3FlrIMkNlDQGVIHvuIU5rJCRI2pj6sObaqv
 O5zoNXlX91zSCEuZGFP1LhCU8oPRnI1axzmqKUv3ZoTcsSj+7cTd0ztyNp6JXYAbWIl8RpUdfcZ
 6mrKij8dfQ34=
X-Google-Smtp-Source: AGHT+IH3wIWBcXEnToBVtYmVPfEfS+bAg5wn5fD69WPgcC3DnmTAfF3CFrR3Yl/2kztt5Ms80VvRtw==
X-Received: by 2002:a05:6808:250c:b0:3fb:7114:4ba7 with SMTP id
 5614622812f47-400850ccfeemr1715580b6e.25.1744382938250; 
 Fri, 11 Apr 2025 07:48:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4007639db05sm954732b6e.33.2025.04.11.07.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:48:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: marek.vasut+renesas@mailbox.org, neil.armstrong@linaro.org, 
 lehmanju@devpi.de, u-boot@lists.denx.de, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250401100959.1571297-1-quic_varada@quicinc.com>
References: <20250401100959.1571297-1-quic_varada@quicinc.com>
Subject: Re: [PATCH v2 1/2] dm: blk: Add 'erase' generic block device commands
Message-Id: <174438293749.3201192.8797538713392630216.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 08:48:57 -0600
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

On Tue, 01 Apr 2025 15:39:58 +0530, Varadarajan Narayanan wrote:

> Add support for doing 'erase' using the generic block commands
> framework.
> 
> 

Applied to u-boot/master, thanks!

[1/2] dm: blk: Add 'erase' generic block device commands
      commit: 6a5177a58cd481792a652bc7b5c34ed5e76381e0
[2/2] drivers: scsi: Add 'erase' support
      commit: 7dd49a9264a6de349343a873e465e1a5fcd459e3
-- 
Tom


