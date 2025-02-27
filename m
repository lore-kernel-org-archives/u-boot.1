Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514EEC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8798980F12;
	Thu, 27 Feb 2025 15:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uqrzCR/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4166580FE2; Thu, 27 Feb 2025 15:06:51 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F36D18083E
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22359001f1aso13106175ad.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740665206; x=1741270006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jH4e1b4Dvl9YAOcDsXPbLiZzWwlAwadE/lvnBUMyfok=;
 b=uqrzCR/6/HrCKWLHyyeHvp9AQSf5gsncGLKTI5UBU/LfjOQLpgLX2bI7bF6rsBeh7S
 JgoAowxTulJeTt8Cacm84urZQS0g0Xg1wjCiDGdcVcTH3we2/gTMWMT2hvD3TqYIeobW
 v2pEOEDnYxnRV3Z2xDfO9u4FVG1Dqi+uI8+SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740665206; x=1741270006;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jH4e1b4Dvl9YAOcDsXPbLiZzWwlAwadE/lvnBUMyfok=;
 b=Gy2Wpj/DlfOPngcevBv4C49UrEu128K9Cxenj/lCzk7tfh6j63X5La/O8wGTrsCiA2
 0S3n1cfirCEw+POzWdEnNLmO82G804WnTkt03+QP4/4L/vzFlxo/i5+3AzwL//TsTmdc
 tc/IVRVnxobrBsbhIyWuBk9PpmwrcI4S71zihyGwriUc9B7B+cU6OREGRmqjnz62Vljh
 9BZPJfoOMM1NpE97TtHLQXu/xUURf+3IzooZ/0IhEibB9WAsa0LM8Z9TyqXwGLUc0eDV
 7Dz/ouB4ULQgvjpypDqlnWGTGk1KazyoacLEaCxR1YamWqzfwJe/Zgyh2VNjnb75QJg9
 cIZg==
X-Gm-Message-State: AOJu0Yz4OIC6o/7bez+ZMjhX5hobcb8Z8cvbx+7jlopLZ58RtX7T8Z7W
 epE2GxtGiQ+95W1DvkPFDQVi3a+XrMAOa6etTTK8plI4X6tkNktzSZ59tTUyplg=
X-Gm-Gg: ASbGncuCCYsRnVaP+Q4PbxKqYQ5CR7jT22I3Q18kNcD/J8IdDoXQCGS2gcVzE6GmUg5
 CEfZoCU6F0rq1Ey2lO/K6o4CL5NR1T/HBrl2vzzT+iL+Z7YeoYldukgupLdQLSl0Ugv0Ixvbw0L
 uPCh1/c1An81ELFUQeJX1fJzms7hO6NWTv99NIKPA2H6EBbIfFGeL/2BCeRxaXBxjOFVk14+lkI
 TAg2B2NyoWsdOO6v/fFkzpvvccyyp+MebnJ9XRtHWzSx7GbQhG8sJDI93LPWhqdJC9FRxz2Jpdq
 k2Njq0YALVFM9/ifae8hNNk=
X-Google-Smtp-Source: AGHT+IEzDnv4+TKWfajc8qlBIY4KC23TZ2Crva4yPRhl+/VwCMo8oDH+hxOCPVwwx4+wO9OB56xwGg==
X-Received: by 2002:a17:902:cecc:b0:210:f706:dc4b with SMTP id
 d9443c01a7336-221a0ed71c5mr330386835ad.13.1740665206250; 
 Thu, 27 Feb 2025 06:06:46 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f97d9sm14811025ad.62.2025.02.27.06.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:06:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250226193518.65593-1-marek.vasut+renesas@mailbox.org>
References: <20250226193518.65593-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/next
Message-Id: <174066520524.3960001.10363372631891221170.b4-ty@konsulko.com>
Date: Thu, 27 Feb 2025 08:06:45 -0600
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

On Wed, 26 Feb 2025 20:33:58 +0100, Marek Vasut wrote:

> bbmiiphy clean up and DM alignment, finally gets rid of the static bbmiiphy
> variables and plugs bbmiiphy into MDIO framework.
> 
> The following changes since commit 8dd7186ca7821446c6f46b6cccefab502912f2e0:
> 
>   Merge patch series "Remove "saveenv" functionality from am57xx evms" (2025-02-25 11:11:32 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


