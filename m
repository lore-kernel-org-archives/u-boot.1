Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6557CC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 19:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6102283420;
	Tue, 22 Jul 2025 21:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bgq6JSyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 849B783444; Tue, 22 Jul 2025 21:46:11 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414C083403
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 21:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73e57751cd9so1799685a34.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753213568; x=1753818368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8sdB86iElIDOZBKjDepyPRN9b3E8kfwOCpVELNyJlg8=;
 b=Bgq6JSydSlChAnZBHMNSjEK9ZaEnOk5yiYmo02hEw1CN5LQBjWYQiAxvZ+A2euKrLE
 ePq1FEjckMWvB5YFxzwOG21bQRcq/mYEQuBcg1js+cCXe3vb+i+3uiGspuv3Jgnxra4X
 Uj6TfFH3XIijWSX5rZ5pQWwg/4brhiaD2AWF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753213568; x=1753818368;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8sdB86iElIDOZBKjDepyPRN9b3E8kfwOCpVELNyJlg8=;
 b=OT9acxwLlTtEJz30ZV/UtAuF/dbSU/6ZTu9CwbzVZcZjPV08+HJDWvfRy67ddEBnIL
 TQiK5ctOAvjMhzmWDdNDeoF8GZYB7r5OMCLy7/b8OzjP6j+vHAwCvdXdUri6kfc5QSWm
 znJl/MwHYAJaPOtIqjHAw2sLZ1n2wW0ZtNGFpBFBseuT4Pg9WNn+SpjAnstpt3+JJwfQ
 iF0Gi5xEK/AedUO8t9LaY5BOBo7R8VqnY987uNtLIJ6nyn+/VBq064zXq4N9Y3qgSECH
 am8fiIh6drCh5Q14eYNCGEMqNcFBea5hWkIehfVNvd4YJK5myoJxdGvVfMhETcOcVFdQ
 e8fg==
X-Gm-Message-State: AOJu0Yy/5uZaaxKTsrxFQQBPMuVSsS69HACtCmU5VGRD+TPwklg/v90w
 TXF2vRBezv0hMYDkCLjTm35I44sivAkpe7j1n4KxW+7XOlZ/z0k5CH5nTbaUIvRsw4720nzR7N2
 sx0dX
X-Gm-Gg: ASbGncsBS6P3G6ZFSiM+GF1htm/jHWIDBE1TtmAV5zSwIPxMzY6l9hXBWVv6sIsYo2W
 aMN/hsaYHAW7nz+vpPNgEWq+sYGA12KznIB8W2vz5v/roOHTNHZMt5zTxi7MjGnd4g2cKe9PLlF
 EqFfkYvJT+v7S6FhHH4pKEWKK6t4Z+CCVaaWtVI4bFjCAtcdLFVOpIKD4KKIqsAM9JQWC9jQXxq
 B6YUwGzZj5tnUdmGIQCc65iUvZHuFvAfC4n6WxLgIR6aBPyG+Imkx1auiSsztg/3cALY2+7QsEB
 cSsPP6qgs483D3hzZQE+IjWDSG9fSwEL/huySCGNYl7D8DJJs6+Ge1YeZEPPCI6qKSCnNAB/aJy
 3fRNply/0twfi1iLoufxcWeeinvSsFZJK071DgQXJWOrGzAO2NGDVTEc=
X-Google-Smtp-Source: AGHT+IFOuXUQpo/8P3X04sy5zOYVnmmEpRx8VqblnJ9zoo8QpdSEEcadNwRFWx02Os3/hu3VrT2goQ==
X-Received: by 2002:a05:6830:6a12:b0:73e:9cdc:a6d3 with SMTP id
 46e09a7af769-74088cfb7c3mr384179a34.25.1753213567986; 
 Tue, 22 Jul 2025 12:46:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0c3fbsm3749811a34.30.2025.07.22.12.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 12:46:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Holger Brunck <holger.brunck@hitachienergy.com>
In-Reply-To: <20250714111651.2450845-1-holger.brunck@hitachienergy.com>
References: <20250714111651.2450845-1-holger.brunck@hitachienergy.com>
Subject: Re: [PATCH] arm: fix lmb region reservation when PRAM is defined
Message-Id: <175321356721.77222.18282877244626762444.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 13:46:07 -0600
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

On Mon, 14 Jul 2025 13:16:51 +0200, Holger Brunck wrote:

> PRAM usage is not taken into account when reserving lmb for ARM
> architecture, this means that predefined PRAM region is marked as
> reserved by the architecture and cannot be used by other users.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: fix lmb region reservation when PRAM is defined
      commit: 01548afc43770020cfebecc4a62cfa0d8b05517e
-- 
Tom


