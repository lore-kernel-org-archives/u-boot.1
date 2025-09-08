Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44ED2CA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77BFC800B6;
	Mon,  8 Sep 2025 10:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TqJYMeDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24BA282B20; Mon,  8 Sep 2025 07:54:40 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E918782A9E
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 07:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sidharthseela@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-25634c5ebdeso6664065ad.0
 for <u-boot@lists.denx.de>; Sun, 07 Sep 2025 22:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757310876; x=1757915676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVJk4bRKfP+aEmAc7ri2A9DoE3MxpzIlI28sQNfkB34=;
 b=TqJYMeDe6QgVu2qFD2G5qCObaiZirvmY6kron7leVyKOlRhRtqNm+fOHdhitvcbDIx
 Ka194jwYA4Gs4wdLPxp1VV+b6q6JoPfijyEwb0yXIoyYzfp4GghgC0kV+3SwHMNWHes0
 7O+6NhdEbkFCU9cfJnftS+/Hk41zd9uhZAD5bn3/eDEzi+EqcgdxpOl2gKkVtFEEuY93
 n9zxemcNyhUaFXpkO5tnsc9LAlAhebr1CzK5sD6WCPsePQhsrIDdaqg3yY9GsDHp/I5r
 7NYNeFYhEA1qytb79vzp2a8333Y3+LktkbHC6SDHD+3v3gFhG6VGQkfD2HwXMCB0glip
 541g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757310876; x=1757915676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVJk4bRKfP+aEmAc7ri2A9DoE3MxpzIlI28sQNfkB34=;
 b=c0Od8xIv50lzLFJMVGc82o53uV7noVYCBy71GrU0z99DgDPhJ2GNIjCw+KcR7Cy7XG
 rqn2pA80X6DqxWSjrUD4AZ06FYxAG3vrIDfW6ltaAddhFeq2nzNzM0i7NSJjk1EZngjb
 P4arfRaEybgA2QU6dy466bjiW03vqjqvf09aZ1B+r5N3Zzk5EzAgBoQ+Cna4lkmuUtPB
 p8DLdaG6+/ML5riBsy/SRxEE5NOVE4Ci4/FWxA64hss/ieuBwaCEWGuwhYNISurEn1+/
 EDFtugnF6pBuLPDGRD5YokqR43H5DR6ZskLkDrQ1HTCG1GKCnNhUxSZagaiM9hy/rqju
 4pjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKJGqPSD0JghYrBbuckB91yk0jLmPZz1/5eTtuXGBWMDdSC1KAv2QY/37YLWPrerD/DXXNonY=@lists.denx.de
X-Gm-Message-State: AOJu0YzGdM+9KVgenWkkucUEQP8u1SIRR/93q5kHxC4W2D+Miz4or4BP
 QBdFqk0IblcJN+P18O8emI4eDbm4OKiLILSe7eyhkkAhq9ZvXsZNLXTe
X-Gm-Gg: ASbGnctZacxQsDLx3oHLyUcvfdUz07Tvq+IvPxGAT3V45GoZZpZKW4dtRpxgEvEpIPE
 HIhZiqLZQwoiJU67DC1mbCQkUOFqE+EGTfmZqW4rfCA69LrjKz27he7Ua7r6U/CE33tkLerCnm8
 4xVUems9XUxfrdvSj/cF3Y3cb0E2CGf2rkpQ97jzqCONsW9trS8dfJhqSa6FOJvPz1fO4V9mo5v
 xyacMlGN0J3HKvaelPzJd6PCqUGJCuvAs0jLYC986VCOUQ1PlgDjBf6rGP5jjVVYj2ls5FOJIFV
 rfWQ5EtSiACvVU7uB1kbsaT1342N0fiKrwqK4YUNg41K/fc2iEGyEQnzzDyUniNXWekmWIaYv+s
 NlOrE6Q2iuUWXqpMJ7rnkE1RAYhujJqPUHpR736yPcpGFi2JItg==
X-Google-Smtp-Source: AGHT+IEsqjLS5LVQnDS3YbkaVIoNzcEZVja2KnughSO7vX6RW8kS1896KzWS9cyqmjnpxCXlxIMBZw==
X-Received: by 2002:a17:902:ef07:b0:24e:e5c9:ed0e with SMTP id
 d9443c01a7336-25172099d9bmr93778735ad.43.1757310876209; 
 Sun, 07 Sep 2025 22:54:36 -0700 (PDT)
Received: from y740.local ([2401:4900:1f30:6301:8e4c:5f89:616e:1e82])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24cb6b5b8d7sm110057305ad.72.2025.09.07.22.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Sep 2025 22:54:35 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: sidharthseela@gmail.com
Cc: trini@konsulko.com,
	u-boot@lists.denx.de
Subject: Re: [PATCH v1] doc: board: ti: am335x_evm: Add documentation
Date: Mon,  8 Sep 2025 11:24:29 +0530
Message-ID: <20250908055429.598536-1-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250903202043.285746-1-sidharthseela@gmail.com>
References: <20250903202043.285746-1-sidharthseela@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Sep 2025 10:08:50 +0200
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

I am confused on where to place this information of the
configs. As the new configurations need to be added to the default
am335x_evm_defconfig, as well as some unused configs need to go to make
space; to enable falcon booting.
