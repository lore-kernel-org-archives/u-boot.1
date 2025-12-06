Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EE8D3B7D1
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 14:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F5D83A28;
	Sat,  6 Dec 2025 15:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o98M76U6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94B9A839F1; Sat,  6 Dec 2025 15:10:57 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F39C839E4
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 15:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c6da42fbd4so1620904a34.1
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 06:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765030254; x=1765635054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWjYo05SDfosHzWQwUJDhuBjn18f2CpKm6ViYVVgpOQ=;
 b=o98M76U6iN1RoEiBKILM2bk+hxu5k4g5w0Q4OgmyucST4LGlm2ZJHhg7Lwwl3oI9es
 93Op9m8EhInNT4dqj4IxhWGdLv/0a9P6xIJ3nvWlcnv5D4qUP5CWlg7CdLCTYII/pmkU
 rSysJ/jkHBsNUp6eJfvoI4gQUNFrfjUIqQ34k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765030254; x=1765635054;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FWjYo05SDfosHzWQwUJDhuBjn18f2CpKm6ViYVVgpOQ=;
 b=nKlKRHSbhMbe9Zd7SdOkIwjLWUgzqjGGJD0tzaIEeiyYSJfNO7kTDsQwum22FRXjAN
 Fh9rs0dl0CwcxT+r/DKXekCrsIeombPkxZz1vxSsnSF/O5HNZwZ3BAz3my749/thfyRJ
 NNWU+nVDUXUrMdTG0Efnm15q+jnQZYkmSF1elmcQePFt8c9pkZ1j9j8lAPlLZj1QVVJO
 WfJRa8FoW5/bdgbvq9rpgL+JqMrWRl1l6sMHFtvFi8lKH/1dXnk0orlnDD8R+tYT9rll
 bvXpWxu+s9PK3LUuaT2wErhAhDh9NkkiI/17W5y/gLzQ4jV5+aZYwoZ1E8kg5JDndWSS
 vkAA==
X-Gm-Message-State: AOJu0YyVVfd3LqP+oXaxb/E2i9jV0SzpmMU22vakEWWVBh4DkMMNl79n
 rBHAuocCN9yDCKiSIWBfgjg8PsrS+xPrVdi+I01muV+Cu/y77nfYvIFnsNBNlqR+3gUTXwotiiG
 LXu05kLw=
X-Gm-Gg: ASbGncuBuYhcKeExhOn7itfGkDNA6LZUlOvdGtv1DSR2FMsU/NITW7aGCVb0wCvKLvk
 RPyt4ppw76Q++96I25Zrql51M9+ITvmwxz0mXvr3ZClCbf/7ag+9mgoyvb/3aNBO+K5CsbtxI1q
 opZLLh1pH/gk7G5/NFajUtRrLKSxKnKtAGFAkhvg+OoUnmPSyg8k7tKqI0Zt7JumXJOOSofm5Xm
 EQVq7VI6yhpJcfyozHfYbENN4leabi/TAtkCvaS6mSpXYNdVJpSoQ6WZ6xF8qOlz+AuyCpYIQt+
 XjkV76P88ERsxmhH7m/OiuTPN5VYfsa8A+PvtVOozObL8TurNy/dRcDvh+DTobTSL7cFLn6iU9Z
 lPrub6gC0RAp0eoWc3lLfMnJRqYvTmYC7WnhjF5D8YoMoRup1EHpIuG1Tr0HtJk34YW+Mdrobt2
 zWEX3G0myPenIAIk1ALk2LKGa6vnCmtArSdRclNScr8wpqJLNjOnMErucN66A=
X-Google-Smtp-Source: AGHT+IECV5ZVTxB/RGcfIh/NGcjeXas+AeODkIGY3ezF+yOtkpv7h6u+J8ibZ6zhiWoU7IYHMD0ZpQ==
X-Received: by 2002:a05:6830:25c5:b0:7c7:62bd:7fa9 with SMTP id
 46e09a7af769-7c9707bd9dfmr1496810a34.4.1765030254262; 
 Sat, 06 Dec 2025 06:10:54 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acd733bsm6078499a34.26.2025.12.06.06.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 06:10:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
Cc: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <BESP194MB2805A8A998129AB7ABA1B929DACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2805A8A998129AB7ABA1B929DACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] fs/erofs: Fix realloc error handling
Message-Id: <176503025356.2523567.2665481656657366190.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 08:10:53 -0600
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

On Tue, 11 Nov 2025 13:49:30 +0100, Francois Berder wrote:

> If realloc failed, raw was not freed and thus memory
> was leaked.
> 
> 

Applied to u-boot/next, thanks!

[1/1] fs/erofs: Fix realloc error handling
      commit: 1c1be32c31cbec61d32f7aaa498ccc25567ae3e0
-- 
Tom


