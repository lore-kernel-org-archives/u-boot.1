Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584A4C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BFCF405A9;
	Mon, 24 Aug 2026 13:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4TildeG-7IGM; Mon, 24 Aug 2026 13:13:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577229;
	bh=uVmlphgFDso/KfJwLMxSg17kapZDouLbcwdMAF4K5o8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yi+E/Tu4HJuak78NtooDfg6y0P9QcPlFpLinoQlsLR5DxyH9NrC/rRnNcjxJlozQw
	 38bNi4jOcJ78q3EF9TCsfvNojMsVGs/MKArTTgkf58lJCKEVUZr9UKjkK5iM93s79p
	 wE4X2c3O4Bgo1PQFg0jLkxroVuK/iEjwNOZ3LGlvt/EwtStaJG+jJafD4RQiFGAaY7
	 ZfWfUFUCTh/yL6qk7VC4NM3mdIeDfUNtXnZ2VOou95lj7YnHQnvOhtSd4/+3XIt7D/
	 lBR9L991W5XWjIEG0XXujV+BkE9tZoxmQdIeYmZAXIjcdKR7f0k/ExH3FLH1WJidh/
	 tq43e7s7MKOYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B6CE4071B;
	Mon, 24 Aug 2026 13:13:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 16345386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 085F040097
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cO2GBBYR1Yv3 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=ocgEVAqN
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D732540029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:46 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47db714766aso2609050f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577224; x=1788182024;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uVmlphgFDso/KfJwLMxSg17kapZDouLbcwdMAF4K5o8=;
 b=ocgEVAqNnIL3RdzIx53GWr68P0YaKScPnwVqAsI0bJQKSYr+Xnu/2vXU9g0x0y0+O+
 MU2ZxvzZQWXsBJkSM+R525fU/5xd9msBVeZHfA7UlS3K/eePFU74o1T7WNKrdJq65Iry
 y6HYyI8pIF0SnPSzWcCaWtQUVHxsvwmnIirWeXKGm+1NLuwLFJ8O3jgku5neilzTGtgJ
 4lZ6vsDB4NSLAl6f3YTqRq8cfGjNkHbBVY7odn+jR/A/rLUJaw5lah/X+Pl3/NpNy07n
 un78zG9BgcYMSdPIE3VXBn44edMl//+gn2T2uPQxJD2AFZVKAdzASBMU/DMAwzYDMv71
 gTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577224; x=1788182024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uVmlphgFDso/KfJwLMxSg17kapZDouLbcwdMAF4K5o8=;
 b=cnx2aDwq4ZGU/GZfdymIOsFRyWEugplOMfPIovRqv3s9YlgCmXwCflWXcRamTDgNE3
 NN7y3we/PCIpcVKZ0s6MWmG5WSxtK+AZvhEI4QXJV9OOcvRH/yDsjC5l9ryGontJt1Ji
 Ya62QABnCjIBv6SBEvmmS4CmN7xZ1Tb/mZUO1r4gqIILlV+1N8TYT+m8Bw+MbWHdqlIb
 1f3khWEah84aIhkSOuGXbbFXQ8Z7lkLi5rOc97aXjpLr/5Hvv8XtCb1cO47bSZF1Sueu
 tYxgXq9DmpqcX4rQi9ZQCHCmfqbRqxqw7zqW67jxpuk/R0SM89M9LmWJvsjHnx261HIg
 kMiw==
X-Gm-Message-State: AFuF++nXyYR89xuftiEpKj0XYjabn+K7L8l+NAYX58+VGoSrpomOT+/4
 SNegvXP/qRBy+usZ1+w8Pxk1kz0iM/+VA54vCtE3q1OeSni3AjubVsI7IK8ELyzfIYU=
X-Gm-Gg: AR+sD12Fe/aAZem5bITDHXZVZDFqalhm41S205zJg08XQoF0a2TKNdFOP42ESlXxJix
 ISQvc8ZI7aqF32PyI2JZeymM5XZrgkj7fnYa+cZPzORSkYwlht8QV0j5QdMCWYVRuo7STIYW9Qx
 6Exowozl+RFJM7qLGTNfy/zqSLek377hDSncjnrP94o+wRxU2bnufFyTv2sPDZ0UmVAx230E37e
 IVljRh1UYd41Nfh1NriGldPhzPubJrW2ZOKokA/fI4lIejAaILl5qsAgGuAjF2dtHHcoJM2ci7x
 fOQh4DsPFoZ3us3XJ3Xop5WJ1Z2rurvi/eNlUDibz0SMYB8+jJ9995/gTFPMqVSAws+xh2Wz+Oq
 UGMAdTxyCWgUl8H6zzxVt0Glxy4qq/U5Rr5ohH0s6rNY+DGSnymOGr/0XfYTWQM56loByEgyiBz
 vxJfDx+zDLf/3zwY7NnstoDpalW5ZhwSmJCBwHt6J51Whm7YBd9LTDvTa2oJzCR++heW1fXia8k
 kViBrA8OSdwcwzsoRwQcBIViyEvN3dUcxc7WLshnSEMccQJq4NJpw==
X-Received: by 2002:a05:6000:985:b0:47f:e746:dcab with SMTP id
 ffacd0b85a97d-482c1184819mr31439625f8f.10.1787577224148; 
 Mon, 24 Aug 2026 06:13:44 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:43 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:09 +0400
Subject: [PATCH 12/17] pylibfdt: Fix a typo in the next_node() docstring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-12-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>, Thomas Huth <thuth@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=alchark@flipper.net;
 h=from:subject:message-id; bh=bGxfrpv1b+jK43JU2xVP2Z7YSGqo3MIMoTfMqQTXFps=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGf9P3Mv8fgTXy3Ja+aHFp/OXbF52dTaQ7lTFjwSt
 1Lq+/TXv2MiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICp3rqIkeFhi9OUYMnyluIrT/8HrBHcaiPbd0G+Ju5E7lrtFBX9NBlGhi6ezUq
 rmqdfmSMyM1dm53WVla0LN+949/NzpYBR0MKMvdwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

From: Thomas Huth <thuth@redhat.com>

Spell "Tuple" correctly.

This is the pylibfdt part of dtc commit 205fbef17b7b ("Fix some typos");
the other files that commit touches carry no such typos in tree.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[adapt to U-Boot, rewrite commit message accordingly]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 2c8efd57a607..2179515a144b 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -166,7 +166,7 @@ class FdtRo(object):
             quiet: Errors to ignore (empty to raise on all errors)
 
         Returns:
-            Typle:
+            Tuple:
                 Offset of the next node, if any, else a -ve error
                 Depth of the returned node, if any, else undefined
 

-- 
2.54.0

