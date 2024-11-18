Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9BCD49221
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA8218946E;
	Mon, 18 Nov 2024 15:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lEgnSNWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B5389396; Mon, 18 Nov 2024 15:19:42 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E8A89456
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-46375ac25fbso16503991cf.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731939579; x=1732544379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bj3O/NBorNS8fsacWzvUBKVX1DUg2lrQhe+rKTOWC38=;
 b=lEgnSNWKk12AyboSIZE+jzLyBSID/yAZwZRqojHuV3BHmqXf8JjNlkra2gFU05xWm2
 MwD4jjubJDCOGCwK9BRQFPtBpEvcFF87/Ie1WPDFnsEp69GiCvNLV01F5jb4C5BX2ckz
 s7KfFTpbnoKgMKx4fVg1Xvswao8M9a1XQDXYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731939579; x=1732544379;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bj3O/NBorNS8fsacWzvUBKVX1DUg2lrQhe+rKTOWC38=;
 b=JZsTrXCnu5RMjoedZ3QLMxAckqw+bDU51By+Ac/ciJ+xE/jBS39/n5c2kdYX0BRtO7
 MSujF7DcGoh2dqcNay9y3yVk76HUS9IQdBI1HXhaalDvo8Uwr1IuTr5T7110ieiK/zNc
 56vNB2Qd+Gu6rqHr7DagCZ3r0QJBPmYvZgyAheoDWyedseA7a2lqob8XBZKNmZc9Pt7W
 IKWkZ+a/0EuO7SXI4NLT3DsTH+QJDLWGZ8UxuykugaA3khAywWLeP149+z8HQISmu9sZ
 O+CNq6+8AvMkxaefjbda07Bj2jrxm9Gbiv6aTC1AiW0adJa8WcqlYq3Tz8LqKe/dwknM
 3Cxw==
X-Gm-Message-State: AOJu0YyvuWz6ZJnj4lUUMCxbdIwQ0jGMlVacMpXGy9dYzx041UkXseIU
 URbHGgeMxiicc2nqeAGL5rML1WHEZ3k7j414Uve3rIH8Ntu0Gxko9LOsqvdyjE7fh3gz1vxLar8
 2
X-Google-Smtp-Source: AGHT+IFWJI/BmWrxkaO2E4Mw8upj5Ao94zskSHjAbbjidLxxAe9XKg66Xe+r0WCev0ahz1M7x+iOVA==
X-Received: by 2002:a05:622a:4716:b0:463:64ce:c282 with SMTP id
 d75a77b69052e-46364cec678mr150016221cf.3.1731939578940; 
 Mon, 18 Nov 2024 06:19:38 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24e44sm59075981cf.59.2024.11.18.06.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:19:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Love Kumar <love.kumar@amd.com>
Cc: michal.simek@amd.com, git@xilinx.com
In-Reply-To: <6cdcaf03750eec78ad7e577edbe81c3e50350aa4.1730797426.git.love.kumar@amd.com>
References: <6cdcaf03750eec78ad7e577edbe81c3e50350aa4.1730797426.git.love.kumar@amd.com>
Subject: Re: [PATCH] test/py: mmc: Distinguish b/w ext2/ext4 partitions
Message-Id: <173193957784.3366111.9236040417066571943.b4-ty@konsulko.com>
Date: Mon, 18 Nov 2024 08:19:37 -0600
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

On Tue, 12 Nov 2024 14:27:27 +0530, Love Kumar wrote:

> 'mmc part' command shows the partition maps and shows the partition type
> by displaying number such as 0c, 83 etc. Observed that ext2 and ext4
> partitions shows the same number, i.e, 83, so, using the fstype command
> to distiniguish between ext2 and ext4 partitions.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


