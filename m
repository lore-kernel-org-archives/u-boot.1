Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9A3C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BE1F809EB;
	Mon, 24 Aug 2026 13:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJd6UpT5ABs9; Mon, 24 Aug 2026 13:13:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577207;
	bh=HZLpIlgwzThv271HlyhbMfC/wloK5rXNGha5SLnNYDA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0vfG2HedXy//fxs33pi9BTVHNJmFsqbjyJV5fp1o0EM/eUZDjYM1/AnrCpGbaOFNP
	 CUPJcuxjg157rQTN2xBBUKiJizqT8RwH8ZxT/3IFg5NBlgYzyQ51o+tzOt2ZQplxFc
	 X9W5dY4DlNr/0IK98FRKJJdDWWzUQtn4tQsRAF2qWjO/0kpYAa1VLa+W9hJ1HKD9wy
	 VpkWKu/PPTO0HUOzJO7x8FNJMUBwCKSovcx6/UJpi5ChGns0iMNVBdZhYHeBAWC6Cy
	 rpUlGk72tPf4j6xpu0fq93cJCYAkxty76Ed5dpPibwbw3HsV1Pu6U14aavti8FhGu6
	 E5bBsAqYVwmnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E09358095E;
	Mon, 24 Aug 2026 13:13:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF32D396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9590240050
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HnMVqqPyPd83 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=DYbndqOd
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1B0640029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:22 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c1c50c1e29bso557639866b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577200; x=1788182000;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HZLpIlgwzThv271HlyhbMfC/wloK5rXNGha5SLnNYDA=;
 b=DYbndqOdCvVG+xaD6dazfgmOliaAubP4X/eYJn+mhz5Q/33Sk5aX86wmvNgNxa+j/1
 SgPk2kRLUfSp1l2GGWzSeLp1cqpFqGxKPFmNYdvdf+UCx3FtT8b6Knft0veG2IqIHnAg
 6BwbFi9rVICUpwA/YnkYjMJ2Bfw7BdhqfE31OIksub6F6APxikiajG0Na2CzXvA4VOKl
 XxkIBJiP5+RuKapk0g37wmh0U9AfNvrdspt0FmRuYg1zYF4e/yw+7mwxmY6pR7WZYFfL
 fsF7xdzHyky5EQ+raeHI7SqwoOjaaOuL68xllS9mE400WIpLm0bav5MDCIt5t9sP0FBI
 CDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577200; x=1788182000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HZLpIlgwzThv271HlyhbMfC/wloK5rXNGha5SLnNYDA=;
 b=B0HCDoNAop4oLPPG3+45OThjrpW55sUTgTGjagx4H2oXD1gJMnnQ40YDo1Gi+gsiL7
 NHc0wGvwC1Txmw5yQS6W6MyPYWz/QvdXmpDUpG9f7J0AeRPNa0G59Ox/P+9sZCkj+r15
 TewQPV7L09IfAZx+Jiq7mKCD8Eq9y84w8HqQQQE/rWYvUnRUaJrgndT2UxTYRLzFhg5J
 eKvCoH3DWOO9OEjRfmq0klkQnWCOnaXfRkxxjdlG9iUWyOZvKBaa6wlTsbnOSgajdrPz
 q7+jh7svV/EXJKLC9inNeYG+ore044tA+WS1Bdd8+QLv2CIT7EyOuJvD2ebrfjT3mh0F
 lNNA==
X-Gm-Message-State: AFuF++lZXUTKjF5Fk4u8Db3LqD0zqAHQH7eYoREagcDkxRRc3EXELC3n
 ZVD1pBv90JT8WnD+l20+F/IGyncrpkLFweoBzfiPD1Qg9j1vciHOjxBSVlZInANL6k0=
X-Gm-Gg: AR+sD12+WLMKQ051GYBlgCiSjTqSNxPAGoywEJxxktU85jAy3W5c7oYXC7Tsun8NTqV
 eAjERmNK2bBwKSu3FYEDWLm3NNxMEVCmt+75VODsYeR/ypkyVKOctCo4DLLKxwMUxgNATrZx5k2
 1ZWhCLInlp+JgS62f7w/9G+19kH68jkRlN0Uckm2IjklIaKuQcO3bvWp5/D+bAS+1Yf6xm9QjhF
 5eEWOjZGYHEj7SQbbfCscT2kyjaa1Wk0g37JWoHS9CW3OU4kDBKa+Th9l68U+Iw9TOyd4K0ZZbf
 Tow8fl34tEm6GHc07ZBxqDMSdz18ckRmgWsDb4WaTvMLeZ5n6rb5HjuNQF9x2iUWZ4IUbbBwejU
 5TAex4VoX4zkU2lvMgb68cUBngwkuGBEwteSHTOrt5nb0094w7sXvRc6/TQ90GhTJPtCBt3VveY
 8k8t77C8WXF68qQoMuVFwHDHft84u09aRShHO3n9mFvtA4w8FCz3HOPywwHcvqnILzrE5vbDim/
 UCKxSTheOboAf1jJUtUUw8nVRsCjmGuufRhTQJUoQ==
X-Received: by 2002:a17:907:d12:b0:c15:f26a:3438 with SMTP id
 a640c23a62f3a-c246a6b0994mr3216470266b.24.1787577200144; 
 Mon, 24 Aug 2026 06:13:20 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:19 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:12:59 +0400
Subject: [PATCH 02/17] pylibfdt: Restore the upstream bytearray() in getprop()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-2-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=alchark@flipper.net;
 h=from:subject:message-id; bh=xx4Y7kDCIGio8aV+VVUgqDEJpCxm/EO2qaHFedQ2ZUI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGcGTV61Yq7gVkfBrZcsLr5SePwg8a8eI+OUC/aT3
 76WnGPzrGMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpvsrJyHBjz55T4QmvTLWykmvW/Nr8dLmR/aWnfJqebg+qJn19pzKNkWGObLj
 fm+nb+3XX+M1xadIPeX7n4ZaWnBvSOaVrguZMOMQFAA==
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

Commit 903fe17aa8c8 ("pylibfdt: Sync up with upstream") replaced the
bytearray() that dtc uses here with bytes(), without saying why. The
result is the same either way, since Property derives from bytearray and
copies whatever it is handed, so restore the upstream spelling to keep the
shipped file mechanically comparable with dtc.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index eb075c0b92bf..55170431357b 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -421,7 +421,7 @@ class FdtRo(object):
                                quiet)
         if isinstance(pdata, (int)):
             return pdata
-        return Property(prop_name, bytes(pdata[0]))
+        return Property(prop_name, bytearray(pdata[0]))
 
     def get_phandle(self, nodeoffset):
         """Get the phandle of a node

-- 
2.54.0

