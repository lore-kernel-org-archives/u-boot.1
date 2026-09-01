Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D54C624CF
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 10:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C426580A9F;
	Tue,  1 Sep 2026 10:19:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4HlzhUAyM9sA; Tue,  1 Sep 2026 10:19:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788257970;
	bh=dk/C1Sw7gYAo6B38WIVmr8Csk0biIhNlfbtObS3JUEE=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EpXgNv3eQxVQpGWkN1aWGF1xp8gVmOEm2UHcSzciOQhFamXiUH2dJzkwx2CcnR4xB
	 BteArxFs21SQwcgmvtby2lOfuH96wuZLPwPQ7hxKIIU1Y4Ka+p+r7+vOQQrP32RcVB
	 t4HVcxXN69tX8lCWebzX05m4Nk/c5FoNqVMM4beBoQ3Ik41RdcnIIUMcUcJBh5/hjW
	 FcjQXxfmnvXSYGSGh+a9eSbO31mSkB2BhvbN9VVC4v/ar3Z22V91ivDWo2E3WR4nvK
	 zUT5Ok5/xR3MEwzvhOuorkHdYtUpPlo4CsulcZ00htOjBUSv5DSUlLJX2ceF+SiIVs
	 duzyKneuCeBYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EC4A80AD0;
	Tue,  1 Sep 2026 10:19:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D2B44377
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4A1A40648
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:19:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i79Y9VaUUqiL for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 10:19:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=naveen.osdev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bs7ruEZv
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F52240647
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:19:27 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc1e1ff659bso760780a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788257967; x=1788862767;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dk/C1Sw7gYAo6B38WIVmr8Csk0biIhNlfbtObS3JUEE=;
 b=bs7ruEZvgeHEbVzHx1jpm9ptSuhLGlxcuge95KRkQnBH2+oZ1vroxWa8K9gYJyXxFc
 o6xnNACxTovzU2jIK3q8NNU+rXiZWbGKGKbZzJ4G73/aNbK6vrMmr36YnuIMYJmit/i5
 G6x4oZVScS4bRriuogl0J6VpXZ3GGMp1I5e8aUWcIjoxIpRTD1aKvLJgSK03+FwAKaw6
 tSFbp1KcR96AzDvQFiDtL5azeWRJsNcWByozMXspUFKBrIjClJjqlQoBUS77WIFFfKEE
 m9NssuCpamUKJ+/AbLYRsTot/KTBGU6ADuAw0C9oLkjN1d4QRwA6vfobL6FOBmKzU2wf
 av+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788257967; x=1788862767;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dk/C1Sw7gYAo6B38WIVmr8Csk0biIhNlfbtObS3JUEE=;
 b=VsS1oabYT/hwFtBmk6ZN7xQtPoVe5msiTY7UtAUZndMvLHCXx2ZKHOiWOaiwTBmu4a
 p5tl3NRDW1dHBD/Jj5oza73qaPDUYrSH9+YH+WQL9BI2FoE9c4sT4+UeNuPJqZUJD2QH
 YOyUa69sRVGaZwb8r5jMmJDr6XSH8fMDxtfEfYONPUGJrO9ucl9NpDUaWBgZ6Bx4W9ap
 zG6Rlqu2NY8PZ+HX7RQi1KfAwVW3fscCNXgU5ek0eVaJhzIKl9DJvPHgIV9fhWMlZwsF
 oS7tUk+bf3SrVrptljfQ+sDZNYBIId4WLduPHLNTizrh5L7uBAcpvGRLi+Y59+BtNzk6
 1y4A==
X-Gm-Message-State: AFuF++lSwk1g1etMkRpklatQS1iBQyqCfR6rfYIwVhJ2QNkoL2mb6X89
 XUL0A3Rw3gTwxHQX5Flk4otQIfJRGlJA/2ztXKfXJDw+ZGWchVFiQSB/
X-Gm-Gg: AYBFou01C4yvhK1PtdxMmvKUu5Ij9rbGx3qgeP1qZjAFCzGN/3/4Aiuu51iXp7zShsW
 wH702jG7dQL9P540oj4ObhFJ8PGrn92JW+rLyUjiSHzK3KLfVmDlf6ZfY/BojwIPydAap8w8IVw
 6432btWiRaAYDaViwAqy3/R331LYCoPOWyB5VUY7w3ZnCMppEgKpt6z0ei2/wapojeLKuBTgeKy
 Fyu6EanQ/j1GpsKqqYOVLXES+VhZ6y0X8sOKYOSNQVkT34WQyo1bhW9cZlqgtQtimV2rl9pZj/Z
 nGq2HsSVKMjeby4iVvpHqRhQ6bNyzWU/uFJkZcE4NAmEDjhfJ+7GnFUMIaaPx+zJ6eAV6HcpuTp
 z6gQptqztPkM3vScX95rEVe/afm5KVjdJEVEn0tcJz1wto9GBeM1NcTsvS4Slgo4BynIkA0Gsk1
 xVl1jlMAsYfdSTjmLJS5vseE4cJs3KCYr43djICtEsA0rZ+IqwEUWzasytTWn7dg==
X-Received: by 2002:a17:90a:da8d:b0:398:d286:344d with SMTP id
 98e67ed59e1d1-398d286371dmr24283967a91.22.1788257966846; 
 Tue, 01 Sep 2026 03:19:26 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d482c0dsm5501766a91.9.2026.09.01.03.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 03:19:26 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:49:24 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: mkorpershoek@kernel.org, igor.opaniuk@gmail.com, trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH] avb: fix missing break in avb_set_state() switch
Message-ID: <ya4gsjjicokwdqwvqwdoho6cf2iwo2ecrgvmfoappavszwml2l@tnxffaphc74s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The AVB_ORANGE case fell through into AVB_RED due to a missing break.
It happened to be harmless since AVB_RED only breaks, but it trips
-Wimplicit-fallthrough and is fragile against future changes. Add the
missing break.

Fixes: 5d4fd877733 ("avb2.0: add boot states and dm-verity support")
Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 common/avb_verify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index b96cd1ebd7b..09f1534c3cc 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -198,6 +198,7 @@ char *avb_set_state(AvbOps *ops, enum avb_boot_state boot_state)
 		break;
 	case AVB_ORANGE:
 		cmdline = "androidboot.verifiedbootstate=orange";
+		break;
 	case AVB_RED:
 		break;
 	}
-- 
2.43.0

