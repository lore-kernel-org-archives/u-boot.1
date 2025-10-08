Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F02CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 04:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 164D9839DF;
	Wed,  8 Oct 2025 06:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tJkSBNNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6867183942; Wed,  8 Oct 2025 06:22:08 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D4798394E
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 06:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-79d36a6298dso2718892a34.0
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 21:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759897324; x=1760502124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1RS6tyaerF+EumpETlX2dqTrNsUd+jVrnXiglV1lfQ=;
 b=tJkSBNNGifws600IZtY9eUWZjVbdXoBPejkM+klXNk9le9zE+RqWJWL0h9HJgkbMkk
 wDqddI5iNAmWUaMnla49bR4/mlu0HQJn+Hhaewqu/PTcd+1mIKSsAmDiirmLLZQbtXEc
 VIClPa/ed3c417Shtjnx1aJkJel1HTwJLDdQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759897324; x=1760502124;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1RS6tyaerF+EumpETlX2dqTrNsUd+jVrnXiglV1lfQ=;
 b=gBRhfSxmoSFCNwPvrlr7tnhIW/BSRW04cwu3s2hAXNQ2sk0BD5xkNj7ksm9SlWVx3O
 hvYHltChS8bZrec6qdX/pQxW/52eWcn8Ye0ybwTLlDHntWurv/BVqfir2rvvxyLthY3t
 ugaTt+GGM33Seqjr03MO0sU7yA/eGzI73dcWDvBLqXr70UzlNiGD9qR5oAw/LQ7ISeZE
 t2POkkZwkt4lqw+JCs3OJeWp+TpxtkqtsvLXT3+hi/XzxbHXvxkJDA+6QRpMFhuIMKk+
 8LLRtJl3pSLy/ukeBULkkfca4lf3EVUIiifhpcllatiuustHXSWYCg8dVt+zXu5RZFbA
 L/Ag==
X-Gm-Message-State: AOJu0Yx+Vj03AkC2W8dBc3LoQi0J2Rs5YliykHgRL+CEuQQO9RqokhwX
 D63Ojgc30PeuBX7esKeHKtPYT6otottwnhpjQhXqjj2W2++mU64C6acJgfH2QjSOq+E=
X-Gm-Gg: ASbGnctRwmOsSxfQmi4V26oNCfZoLrMEJzFCNSXu/Kt4pKlpisgsAY5Ca8rJlzZWd+1
 qmsgvUmBOnO1t4/tWtK6BuRHKubYmovn1pajPVzivnjJniD0MI7IXZo/Lf27etIr1+LLM7wSsXQ
 XuUZgUtIHwOISzkh8ZDTTlnZqebyLcwhQrPhkU58fbR0mjilMOGE8LL1q8lVsvEkepx0Cjq0NhG
 c5m6J9eDPxcmSmeHCaW6WFJB/BOjf+s5uL1ZR7k4o1eYEM7bDDeX7N+uU9PuJY9Bm9/cII6oXDY
 Ku7SyE7eeuV6LxIEJ4/KheFfbeT3CVHeO+MYWEF0vx/kXmgrUsprHuUwYmm5NU5hW8zJ1bXxBRf
 pz5ez0X/EQANjwD9qqHf1Jjenz0XNrdX1S2p76As2uj7G0wsJesZKYW0blFPrH2Lmuoi0iSAPHf
 +FbkZ1oep4
X-Google-Smtp-Source: AGHT+IH1jSbBKCRtPxVuzn9uTJcJXSRCG9YesT7yU8C4Rt7kUkEW5Kpow//JBpqifNp5MxwaU5OcuQ==
X-Received: by 2002:a05:6830:6107:b0:745:91b2:d16c with SMTP id
 46e09a7af769-7c0df70be92mr1551669a34.10.1759897324006; 
 Tue, 07 Oct 2025 21:22:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e1bc7f424sm3818016eaf.17.2025.10.07.21.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 21:22:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>
In-Reply-To: <20250921223537.108188-1-marek.vasut+renesas@mailbox.org>
References: <20250921223537.108188-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] misc: fs_loader: Use buffer pointer in
 request_firmware_into_buf_via_script()
Message-Id: <175989732220.1794629.2334110174973452895.b4-ty@konsulko.com>
Date: Tue, 07 Oct 2025 22:22:02 -0600
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

On Mon, 22 Sep 2025 00:35:18 +0200, Marek Vasut wrote:

> Use plain buffer pointer in request_firmware_into_buf_via_script()
> instead of a pointer to pointer. The later is not necessary as the
> request_firmware_into_buf_via_script() does not modify the buffer
> pointer. Update the mediatek driver to match.
> 
> 

Applied to u-boot/master, thanks!

[1/1] misc: fs_loader: Use buffer pointer in request_firmware_into_buf_via_script()
      commit: 863502de82e9be02ce07cd581b20bbb5f39fbbf3
-- 
Tom


