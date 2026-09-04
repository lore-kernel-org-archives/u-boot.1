Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCB3C79F85
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 759EB40B78;
	Fri,  4 Sep 2026 19:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6U9C7disMBSA; Fri,  4 Sep 2026 19:31:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 39C0340B8A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788550277;
	b=KO9Hwg0PUx7T1AXQwf8OuBURv2jUlJDtoRVR7XMHsGly5luRvcLTwkZu9NmqXX6bfQUE
	 KNhewj33nPFc/SyHpF795oQPHjOV2z35o1undzLZ30t71VWYeh2OiotzHVc/6jRBxuim9
	 mDbDEJe4Onck5DH3qTImFZUQZiMxM/SlrLjLBDtjOWKdwrVzWHC+ZelUbi1OAmN4S/dSy
	 T9FcbaxnxFi1IFo6YbXi5rkLgWEkQLqbVJADA/9PQEnzh7x9Z57vB4IvEkBT5yuv4Quhs
	 QzIVTX3O0zkA3iJFk1Ipplo9VhZOjAnlyzvz9+I3gzIHfNvGZN1cdMrhY0ZME1g4JjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788550277;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rEQEu4YmNQn2Toikh7OW6SqeZVl3jyGQWP135Hh2Adg=;
	b=UqdyZjiNiEUb7WYNn2t3dBch4Rk2be2ya/Wx7258CudPpjn8OSLLXBQ89pl9dtsRARNN
	 SpWy0Kmw5QBkkjSBS+B7PySaOwL/ru65ESSa0xoVHjoDdReI7TNvhH09YElb7iFkzpaXl
	 KNbTAhQIYUfoYJGdgOL+5ctpoO+7jg19jZFjT0c8HP24ToLLm/mkyLVdr7SFJzBmPJm1V
	 /A5l3nXX1tzEQk3NCqoZbx7FfYej+sKSuGYsMoyH28XBgNYcuFRGkS+nRrB9+eHwwhlt3
	 obFR1znHgowCyi4EEnc6P3O1a+qE4zjtCPpCn7a+JLHykZZqXB6v29T2cSAD2rSB6Dg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788550277;
	bh=rEQEu4YmNQn2Toikh7OW6SqeZVl3jyGQWP135Hh2Adg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YHgJXMUtTQK041Wcfn7BeENUOTUUf5yEY/HnTZinxaN3DHRsc4WCcK6lSso6z/k6U
	 k7R4NsKyf4jIwmMLsU7h5h0yXn2QWZ1AaCZkwuWwUE9oZo8eY0HGYJvbeXm1f2Zw8B
	 MrbhicBK3aawzGyEZmYiVC0jHF4QePXatNA1gskeTFTgrU4jplgVShB3zzAg6Kl6XJ
	 k2+wKKRBEgwWSqqp0v8C8ILOyq0Dw6Iy+uVGVC5UICtRnycV0lpCzX5KhapA3ujDVn
	 eHrr+9ePFdBvtjrrX0MAQNJWrZLLpOtefe5M/twSerWHhBLGMh05xTjFfBlq+e+O9V
	 S7GvrmhhnYtnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39C0340B8A;
	Fri,  4 Sep 2026 19:31:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 490FC724
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A9B98113B
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5tXY2q5ylbg for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 19:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 02AD281100
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788550273;
 b=Udx97dXmdDP+6HztZ1oYm6Hzgdhi2G3UulpdQ9RiNBlA/oTDd/F/USzSJdXgJ+sDXGox
 TFtjfCpBH2baBZ34yxN2TndBkcyNXLE6gYE56MQnDb/OlbLGo+WZKQPdJOLe7T5OvcPgA
 8B/BW9WbMsoONQdt+UoeqWWbZyw1JyE+qX5PLqv+Yf/l2ABvyWHykVDlhN8W6vvil10rx
 VJuuFQqZnvBpoH5zuIEAsat7841vSnMGXkFAmHrRDf/+h2N8L2NDhEw55pjyQj9P9SMUZ
 i3x03PvgCB5A9A/m8/Wd8JvNOudEbSoIIoHgEDyeR1fyvIbxSmJsMfJ+bua3zWK6OQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788550273;
 h=Received-SPF:Received:Received:DKIM-Signature:DKIM-Signature:
 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
 Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=rEQEu4YmNQn2Toikh7OW6SqeZVl3jyGQWP135Hh2Adg=;
 b=hEmNsODioZWHlFOyAc4++U+pxnZeSyyDDOSmSOOVXn5iAzIS8wUKTR1Ig9ePWeuv4sui
 bMK7QccXGIgW9fvCshqsDvtdxCvwtP17elv/z51LI/Jo57wMFqteF3lFttVcRHG5yjZ0q
 ivX1lX5b1b2Piu4JJp4UJfYefAmCnNTrjxpSVfrmaBtm1tI93+0PaqIVf+jgOEaLGMDAK
 RTrKs8Zr6W0TlC4VQlbWkIH6MDsCQxSLqEhmhbMS30YdF/s+qqJdkWwAZHqTp5ObNcZJO
 7NcWTour3pLjSnm6/9U9L3x5DgGcAOIOng8UFdcayU1iXXrSWHla/Aijkg+lzXe9fqA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=jannau.net; 
 dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256
 header.s=fm2 header.b=nLBhDUrw; 
 dkim=pass header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=BE5NiMFZ; 
 arc=none smtp.remote-ip=202.12.124.154
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.154;
 helo=fhigh-b3-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm2 header.b=nLBhDUrw; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=BE5NiMFZ
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02AD281100
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:12 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3A3B87A00BF;
 Fri,  4 Sep 2026 15:22:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 15:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1788549779;
 x=1788636179; bh=rEQEu4YmNQn2Toikh7OW6SqeZVl3jyGQWP135Hh2Adg=; b=
 nLBhDUrwxP4FV89RdeeR8S6++2qTZ3jhliBRq4cQghaTPlY+9DmeYVpN1JflQubH
 hNZKTcc134IKSsEPoXiO0jCZMy6Iqi8OT/tcPijVKctvGrGxlIDYvgkE4sSPJYfQ
 ctPQAoqK4G4TJJKPkRTcq4azs5s5m+6m1ew3Sob/ok9QPuXGshvfuEnVBr9KYiwo
 BQPRRIffxf5yeR1KMVItOrlk/2+6OwHychtAIW7302iJwGzRNwShsUERWLNmlDbU
 8hT896yJRpmfktR/ieNAg6AaoY/CK0Yq2CDjBPjg2USCaakiBMqPPsbG0NT99kSY
 rjQru1MxvhNj9LfV7z6Rhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788549779; x=
 1788636179; bh=rEQEu4YmNQn2Toikh7OW6SqeZVl3jyGQWP135Hh2Adg=; b=B
 E5NiMFZNHbtYejTCXVcNPwNYMcJbfnpfW6AiOwmD4A2xc4UPWBLPaPlj8NGTh4Yx
 v3iRfhEH8cljfQfXW4xKGh0RwmCIhOBOaiIH1kp8rYKar6e++B+z8Uox9l+juRqp
 SFR5FLZPQNjoSRQMo4AvLgSn9qehplRdjDj1LthovG4HIpTp3WqM7cR9dHuZnjiB
 NMHvJGpe8UIAxEX6sTMs8d96W592HQH/UBsxM8Q7Qj8+ilB1egmm0ishsgPEt6jY
 X6GS8rhtuK7pMGzGhKL5FadmPhsAEyzCceJbzO0XgGB8/ZI4Ffn4/MHksYxOsk0K
 5WtN89+w8Wat1CNgIL0hw==
X-ME-Sender: <xms:khqbamy_roEfoyZYX3b1rJyuEYgEaVfZFvBTpCyL3vgWFja3v4xTvA>
 <xme:khqbanM-f2SEnSeGBoAIfpuBVaE_zZ9OuDnpodBMfk4DdWFeiXsZb1-jgYCRgpvzt
 VfGF8DVRpVMYyHk_09ISExGuG_2BDBZRKTyQ4rRfaKRT7NaMYqKBTbe>
X-ME-Received: <xmr:khqbaskYzenLDuOWLX0kpI2dyjQobs-ygJpyRPDSy7G-jU8YodmWElF3CYQB0QPwMhKO5-ZqYb0RbdzQoaUrG9sGljNiGHWsTjhURw>
X-ME-Proxy-Cause: dmFkZTFhLblgTp/RyFQl23C14rT0SEBDcNw88qFkG1Sjc//VwetKpmOdtpxYzmQ4HKpCRi
 WBWnCVMU2EGydlXKZXpN4GNFt4Po4D+3kDHVhKtDhcrmsA6vMw/aZ4CLxA5j0ad2EKcEfs
 SgNSkNyyQS622tAHjfnflrHQwlqXX8UQ539CSLwQKOb+S8QrnE+JnVdQQIAtSW9EHnZH+J
 aNzX4d/wSKpvcjAN04RWhdS+sJxOsdXy4Qem2t0VBqF/KObmyr/C5/zcL3D0YFqBmBPB9j
 zxTYbA2s4UrrRjKj0xA8M8I7z3kvPT/fbYJaDWqg0cwhkzJJpeLlqeJigRtHef77+eQAGq
 V6BbQd2Y61km9k61BEZNXQiyrTXdu0CYEnLF0hX5OLbLLDA71F3ObKXSNbQbnut/SQWPnZ
 xDOJY50DxRrE/tX+ttnDfv3mH/WUK0tT/7oNtK7eaAb9T0Am+O3TzKFFxFZRz1jkqY1v3M
 qiabcP0H6AxK7dboFg+B+xQbRInh6hbbhuNZ/MhU7c5odbxuTcIYtDo0JDhElsjop+RlkZ
 57lWXJ6bVBh1kdatrjNIexsV0mglxAack1VP1Q+0Xsldfh3ftZwks8ToWkLro8vIZyBgmQ
 RQhn8/BFKzR8krB1gUgx/HN9GjORG8+xtBpoqbQJldlemgCiSehqCjyOeS1A
X-ME-Proxy: <xmx:khqbasTZhQk24k_I8hL5y4c2iyRMbGVohsOo8vc48KbIlqAFCDZ2mQ>
 <xmx:khqbarXMWtH6n6IUuStTOOhYPbByX7GPVsmW19tjqTJe7GWn_hCClA>
 <xmx:khqbagKuO9yp9xWnNtj_pD8af9ycak3-plm-adRZy8STj1ndefcsNQ>
 <xmx:khqbar0bPf1igDp-FcPx2cvP8DS0k0m9BuKvanwQNccpkUHaQjSw5A>
 <xmx:kxqbaqZoDmVQkgHUcJweDLDRlBfGz2qHVnV91LcIjv0Al_h35dm2M8vN>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 15:22:58 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 04 Sep 2026 21:22:39 +0200
Subject: [PATCH 1/4] nvme: apple: Don't set a DMA direction for commands
 without a data transfer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-apple-nvme-fwabi-v1-1-f7ede661c469@jannau.net>
References: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
In-Reply-To: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
To: u-boot@lists.u-boot-project.org
Cc: asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>, 
 Sven Peter <sven@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Francois Berder <fberder@outlook.fr>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=zvMkw35f45O44XzDQ69MlImFxUFXeB1NL+qnGljK0T4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzZUr1L3p6dk7v/QNKUVS8vsyYzhv+58Wfir2xf4SD1M
 9GnnZ5GdJSyMIhxMciKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZjIYT9Ghnn/uzzE7hcXsltE
 9QbPL192/4DzB83+bW4fix3TG9dIBDIybDS9M7f27wXG/TMnbZ2zZPfVx11chX08n1b15oqxHj0
 SyQ0A
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

Setting the DMA direction for commands that don't do any transfer likely
triggered the PRP NULL check for which we needed a chicken bit. That bit
has disappeared starting with macOS 15 so let's just do this correctly
instead.

Based on Linux kernel commit 94dd5804938d ("nvme-apple: Don't set a DMA
direction for commands without a data transfer").

Link: https://lore.kernel.org/asahi/20260806-b4-nvme-fwabi-v1-2-bde19ce8db04@kernel.org/
Fixes: 50333c94f2de ("nvme: apple: Add driver for Apple NVMe storage controller")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/nvme/nvme_apple.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
index e674eda8344..dc94988e2ff 100644
--- a/drivers/nvme/nvme_apple.c
+++ b/drivers/nvme/nvme_apple.c
@@ -122,7 +122,10 @@ static void apple_nvme_submit_cmd(struct nvme_queue *nvmeq,
 	tcb = ((void *)priv->tcbs[nvmeq->qid]) + tail * ANS_NVMMU_TCB_PITCH;
 	memset(tcb, 0, sizeof(*tcb));
 	tcb->opcode = cmd->common.opcode;
-	tcb->flags = ANS_NVMMU_TCB_WRITE | ANS_NVMMU_TCB_READ;
+	if (cmd->common.prp1)
+		tcb->flags = ANS_NVMMU_TCB_WRITE | ANS_NVMMU_TCB_READ;
+	else
+		tcb->flags = 0;
 	tcb->slot = tail;
 	tcb->prpl_len = cmd->rw.length;
 	tcb->prp1 = cmd->common.prp1;

-- 
2.55.0

