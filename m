Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05966CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06FB086E0B;
	Thu, 12 Oct 2023 03:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ad8Czt5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD8F08615A; Thu, 12 Oct 2023 03:56:50 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6347F86DD3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7741b18a06aso30561085a.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075792; x=1697680592; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+bLSC5iV7BxQkLJ4lgkeH62TZ5HwMdvf7J9RZLJ6wM=;
 b=ad8Czt5na0T+H/hNoXKYIgTGH0BR76CL5yb52MNr84OayIKp312fQXUZPCNIX6opoy
 eXC6aAuG6l6wP4dhD9yxL7u7MH0yCkYJFtW82XaPDF08FOaYDg5l4qkHSE3llsjURxw6
 QUg8s4h9S7rQ6aJn0WE81+KrX9F0Ei4jxU5CnKM9J3Gw9hFdGp+hDxoipOHMxVlFZKmJ
 3FZzENVoT/yvPN5V3KoPkHmK4AL8rIlnLBLtIunaG088ROdFHsaXPpuNTULdQsJLUDeu
 mlTrm+tkhrgGF1jdK7hEmx0/N3FUxYlIgufcdC5tMJRK4xSC5Cyuw/PPdg3M/kgYEkZV
 21ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075792; x=1697680592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+bLSC5iV7BxQkLJ4lgkeH62TZ5HwMdvf7J9RZLJ6wM=;
 b=LYKj9zhmDqiJoezVn1rbn2fH2+C1dUcI+BmCamtIpfm/Bpv8BQq9GGhfImvJt7Y29O
 0YRk74hlhEhpfM3elmboXtNbA3kDbPgdtZRITtelvxIaAL7mH17tRP+E+3RVEAqWUsqB
 yJl5s5GsT/Ji5ShsCOXNbk64nfWYv1zUy7eq4T7Be6S1UnVxuvINhMQDHosWwaUuKQQ1
 NkA2575++TwQVvBiiN88lPfkrsmrUyT5odmkz/waRwN77zg9l8WoixoKpuUGb7hzqqyB
 GJLCAmzDVBJC/r+ROBDQG5I/WJHgIbURCk2LaPaTJoOdcPCp1mFn8srAKhBxaynS1prb
 Kk9A==
X-Gm-Message-State: AOJu0YyKmAUJ8mdvDLtY72RLwpYTFGdegAOyH5GNSiWlgSDf13JgfwNc
 NNLpqfJeX82cB3yEiz1O/WIcuNvwBcrETg==
X-Google-Smtp-Source: AGHT+IEq7ZwJsDrTF9c8rvmZddrgq62b0WP2fNNSt9BHqUl/CRfq15e1WbVmU/U2MYNZ/VVxeUlObA==
X-Received: by 2002:a05:620a:63c9:b0:776:f5bb:f2e1 with SMTP id
 pw9-20020a05620a63c900b00776f5bbf2e1mr16003234qkn.26.1697075792226; 
 Wed, 11 Oct 2023 18:56:32 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 d4-20020a05620a136400b00774292e636dsm5668022qkl.63.2023.10.11.18.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:31 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH 03/26] spl: fit: Fix entry point for SPL_LOAD_FIT_FULL
Date: Wed, 11 Oct 2023 21:56:03 -0400
Message-Id: <20231012015626.3487451-4-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The entry point is not always the same as the load address. Use the value
of the entrypoint property if it exists and is nonzero (following the
example of spl_load_simple_fit).

Fixes: 8a9dc16e4d0 ("spl: Add full fitImage support")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/spl/spl_fit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index ce6b8aa370a..e3cdf8e5c05 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -884,8 +884,10 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 		return ret;
 
 	spl_image->size = fw_len;
-	spl_image->entry_point = fw_data;
 	spl_image->load_addr = fw_data;
+	if (fit_image_get_entry(header, ret, &spl_image->entry_point) ||
+	    !spl_image->entry_point)
+		spl_image->entry_point = fw_data;
 	if (fit_image_get_os(header, ret, &spl_image->os))
 		spl_image->os = IH_OS_INVALID;
 	spl_image->name = genimg_get_os_name(spl_image->os);
-- 
2.37.1

