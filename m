Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0602C624D6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 18:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 555B16080F;
	Tue,  1 Sep 2026 18:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ERNzcJrf7zTf; Tue,  1 Sep 2026 18:15:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788286504;
	bh=FV1jKMkb+QaW9mrYKNx63nI020M+Ep4n0346clbLAJY=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ykG6VxAgMhUoTCfr8+fBaPUFP7gbsfV216BEEcribiXYdfkDxUyWvKSYyC3JoxckU
	 cB8B8vJKY9HpP1iCdg9AHxi5qmsbOOQ9rTJYZdlGi5iQhanN2XtJ0oQr+mCh+ZVX1c
	 NlPOnxgjegRJtZHRB5YhYeArLOeJ47cIOX9Ek3aT8/Ofn5rA/BPrddY+HSs3yqtBHP
	 mMFFB9YIzi1WBIsQ5BuGevxwiJhgzs3if2MT9XhY2vkERH6fqgj/jVyfqvzUqTDsyN
	 SwF1rF7zppMMxwRVG/AWLdTDG6LvJn9TEIN+O7v4Bb2RzUc6ACDGUWH88GJt9ax4V7
	 yWIBfHi0SiPAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 458E0607CA;
	Tue,  1 Sep 2026 18:15:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D0F9B279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE7EA80DF0
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:52:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bNiOetSyvq8o for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 17:52:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=34xcxagskbrw0wzkcq1jcpiiqqing.eqow-dqqvnkuvu.fgpz.fg@flex--yuxiaozhang.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org; spf=fail
 smtp.mailfrom=flex--yuxiaozhang.bounces.google.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=B8sHeirK
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C8B080DD6
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:52:42 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00FE5840D8; Tue,  1 Sep 2026 19:52:40 +0200 (CEST)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com
 [IPv6:2607:f8b0:4864:20::1048])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA00883EEF
 for <u-boot@lists.denx.de>; Tue,  1 Sep 2026 19:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=34xCXagsKBrw0wzkcq1jcpiiqqing.eqow-dqqvnkuvu.fgpz.fg@flex--yuxiaozhang.bounces.google.com
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="B8sHeirK"; 
 dkim-atps=neutral
Received: by mail-pj1-x1048.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so159768a91.2
 for <u-boot@lists.denx.de>; Tue, 01 Sep 2026 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788285156; x=1788889956; darn=lists.denx.de;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FV1jKMkb+QaW9mrYKNx63nI020M+Ep4n0346clbLAJY=;
 b=B8sHeirKIb0bnWF7BTNlnMAuXUFB1dq+PRNwDn9z2yimlov2e850VTct+XPfdX7xZL
 e9Dcqgtd8s1W6lg1UBxryUT3iOd3plRAUFv6RiB/LRiU8+YOhO6PdCCdudy/1cOZHKx3
 BsY3cAY/8yZktI5YG1QRJNetJD+csp7BaHBrYdr6x1zRwdEjgc2QVSdeeb7V+yyt5Nmm
 PNi/CatJ/ELzTvtAcxQFhTuN3osAWQ4Lf0n7R2Ze0J+1nlL8OBgU7sYrVBGqZ3FLOv/0
 rZowiB0sXffR6ozmYHlw2AJg1VyEGagA0jZTVgXquUPmus1yjSiBYo05w9ncH3AqXoZa
 dFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788285156; x=1788889956;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FV1jKMkb+QaW9mrYKNx63nI020M+Ep4n0346clbLAJY=;
 b=mhmFU2T06OyGZcW9AkscE3293oUg0OLZFWszlNAwjf4tbIEzH/5I8BmQXU6TCsWlqq
 lYARQP3kDVuiMfVWtY7f74Kae6nHM9408c41DIeTRmyuuW9WloJIB/j3OxlkJc04tzcu
 dBxGHBc6F4Fv4TmUgUUgGyMMvQ+eE6tqwLzO9FUzmC8FdIuT6QrsPh6MpDZKECaR1Mf9
 9eUkr5cTBW/Mj71qi9XkTFUrFDU6IX91kk2e9ChVAiBuYyGkc6g/PKS/nbbTNDLC8Eq7
 s6qps6jfENLy4mxt3N+06AMgcLCT+VW39HJgd15FdJ7O5ixauxz8b4Qia5V9KX/kLDg5
 OIAw==
X-Gm-Message-State: AFuF++lw2hgIQnKrLbBVEyKgXSBU642XsfG4nOrCEU2P7zUSkaf0eOWh
 m+1MGzejgbScXKSvcu4k1G3R6N7dRkvjpv4Qv+HmaFzrmHcHjhUBTvrx/oKD9ZAqZkNvnYU/Mp8
 KInZA13c0gpY/cwPEQLOam9CgR5GnEogHVL8TmWq5Jngr+Udac90320jwP9zzNSnUcnJwugpFUN
 v6cZp6nmcjJyXKy+RjqyVQANYAzks0D88I0x+/Mf0AEJNL6D4FqAAsvcoirgp7
X-Received: from dldz2-n1.prod.google.com
 ([2002:a05:701b:4182:10b0:142:e77e:11fa])
 (user=yuxiaozhang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c8a:b0:398:dcfe:967a with SMTP id
 98e67ed59e1d1-398dcfe9ebfmr21870018a91.17.1788285155610; 
 Tue, 01 Sep 2026 10:52:35 -0700 (PDT)
Date: Tue,  1 Sep 2026 10:51:42 -0700
In-Reply-To: <"<CAOOoKeR5oAcouuG1EO2fQNubKsfVB=O5qf0aj-FhSSGJeOH-LQ@mail.gmail.com>">
Mime-Version: 1.0
References: <"<CAOOoKeR5oAcouuG1EO2fQNubKsfVB=O5qf0aj-FhSSGJeOH-LQ@mail.gmail.com>">
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901175210.482943-1-yuxiaozhang@google.com>
Subject: [PATCH] u-boot: fix error check in eth init
From: Yuxiao Zhang <yuxiaozhang@google.com>
To: u-boot@lists.denx.de
Cc: Yuxiao Zhang <yuxiaozhang@google.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 01 Sep 2026 18:14:57 +0000
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

eth_start_udev can fail but errno could still be zero which causes the
function ignores the error silently. This fix catches the error
properly.

Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
---

 net/eth-uclass.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 5c437143a30..07ec59b97f0 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -289,8 +289,10 @@ int eth_start_udev(struct udevice *dev)
 	if (priv->running)
 		return 0;
 
-	if (!device_active(dev))
+	if (!device_active(dev)) {
+		eth_errno = -EINVAL;
 		return -EINVAL;
+	}
 
 	ret = eth_get_ops(dev)->start(dev);
 	if (ret < 0)
---
base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
branch: main

-- 
2.55.0.966.g6673acef38-goog

