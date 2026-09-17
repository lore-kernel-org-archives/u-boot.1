Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B57C982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C24440828;
	Thu, 17 Sep 2026 14:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zy1sLptO88Bn; Thu, 17 Sep 2026 14:03:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0AE5240817
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789653799;
	b=IC4vLLmvDaouiVlFYpaNHioXoVCiBvd1gvmA6YCC9hpbi84QwmY1ZfqekBu6Fl59Sz4d
	 BvVFMWhYZmEG4whNA6mwkwn+h7UfmncB5RK6PEzMZVeTHWSYW+PWbCduVAxr7dvj6AhQw
	 8gWOoMY0tTp1F0xWCjwdDmhK0E2DOJB7hBGzJ3h95JPeY+c0Eg0pdwJGGMxBBYZlZQNQq
	 duNoMST6Pnf4AZsGr+zxe4gYiEGhoeWjTecj0hmpeK2BIxUuaZ8n9Pu6iDLuSHLJ/eE9E
	 7pvAtaOBxXv2xu3NGPBewAjKOh7AFreV36E0kbcAlzdwre9bqpAGy00E63W1ZbKNnoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789653799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w+ONaJmsBdbKSlqfG2Db2VNG//Wj2GLHd0gKPk8C4Q8=;
	b=XmSbgOQCfeBpO5k75TvMrXpnzEkVS0l4qU0PIfshuTyBl1B+WhzipSR9uVV+BiC3n6b0
	 nYcMaN49H/sWZqrzSSPDqS2ywwYEBOGWl/nQCU/dvP1JRj5Rds3iIpK/qBf40zC0wf8rW
	 LBxrb5LrV6HCdLwb+cxRUvRKHDTq4sLpJWlkIDSK7BoujcSt5cndcZ21CS2di2Jf4HDxr
	 c7QKpn9xwWH0YgUe3pnCetI2ApvEkfD9MNdmBZSnsQmVBPJnHmc/48HKoc0wSoFRSOZtF
	 Kx9ia7ccnKg+AYQ8YrceYkJMw8D2w/OFFBbmgvE1CLPqFxJATB2mmjBA7GxscwLE5xg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=TJd6CVYY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789653799;
	bh=w+ONaJmsBdbKSlqfG2Db2VNG//Wj2GLHd0gKPk8C4Q8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FgwTjURj5aLB1ccKT3oc6J2JrX1mfKiqsniVEG3LOKBayhrSnKss9mkBDCZ5Ynh8G
	 0FqWyin9duaTLboeey4u5wm6oRHJhDoGv+kVMS2ORd7XC5k3SSO1SatN/RukyMTGF1
	 5JFGgsIPHd9HJMbxrq2PvjbXccrppq3e8ChdfiQ5WbRysxnq4BlGsmcg0NlUxvk1mC
	 bYtHBdo+4F6uzUqXu8MrTQQtXooudw0+nwLPsc7deAhaaGXltWi8f3YoCWi0+t7l8H
	 H+p9J+XIAqYs8P6Ov5akeeXDqeHxzvaYACA3RnbX47wZyZ+6dciz6jSD8T4x1e41jm
	 m/mT8iiMPHSkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AE5240817;
	Thu, 17 Sep 2026 14:03:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B0BED23F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 975D8407D0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VGc6srYS1RuW for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:03:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5B24740586
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653795;
 b=hozgwYGfiKK9/yHOgVBOAK1GpXn34FfNSzXsMTY4r0TGSp/4dv3XpOGHFjrdnFx3H9vP
 WfHrckDYDsF2vVkdDbqDKiMbG9DWGxoevxLDhjlp/tOKS42Q9THUzZL5zNR8lw7ZpG6Jb
 pyFkH6wsZLmB63mkbhMW/a+wWPHuU1oaybwmX5+cr/aykV6GgSAgO1jV6ZB/vk+HiTpzu
 1p1E0iXAaFWtc29wPdLo8UCb9xxNKGBK8V2eo3cUrNYQFs45L77of+p9xARj+rjiKByAV
 nAXuqBGBACCK7NuvQYWI8rMpmV+ItOp0Us74wAen5Wr4WR3t3Xv4Ic7ivvZ3ITg/0TA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653795;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=w+ONaJmsBdbKSlqfG2Db2VNG//Wj2GLHd0gKPk8C4Q8=;
 b=STnxbK+yo+bi8jYssFzAUlN8O+jddUKez+dcp7QnYZsmv575pYfc5QF+UeJOx7co7RHj
 z/JyU5rkvw1g+YEwxrsVRvDNjzE36doDTTSmDthR/s87r43HjVaViVAi9Sz+QlW9T1iZM
 2byJh/yXc6S5Pi1Q/uoyaTXTpcxpmz2J80LzxDycSOGRHofIg+Bh66yzwdSU87WMtXiwB
 Dj8f1ZASW0Pz1NWYumWeZ5KDOvRSxy6cUXvttiLbtIT7E5A4BrxWWia9rBAwjMqqb+aaV
 F50imCzTpPICg9h8kICoNKXqN27JkOZe9tsun76/6Vipnb0jxyfIi+nBQUc21sQfMIg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=TJd6CVYY; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=TJd6CVYY
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B24740586
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:03:14 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f62ccdb1so309953f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789653793; x=1790258593;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w+ONaJmsBdbKSlqfG2Db2VNG//Wj2GLHd0gKPk8C4Q8=;
 b=TJd6CVYY8Ks43uu2OcE6aRiq45o+s8RUD13piZKnLuTCB7TdU1Br1B9q6Nct9fzlR4
 QQY6LXTA3i5yV9Ed1luwOEsIYmP9IAkYjOvuSvqUTIMpmr5czqvCi9whnftHvE9FXuC/
 fvvDon6peu5/bxe/6LEZd8WOArSe5wSHJF5B0aHrOS9+RZqnuQAUNKInbTqtFt6CFE+p
 4jfFYyynY4KKt+XqhjYhALa8mQHLR33yBrY8bB0G9rExtR1HgJGQ51R00pLDfp3O8kn4
 OimKWMiqX+LQtabFSjyTGX/IwZBtuUGEZssyOBP9/NLKsVuxsjkSZrGt2THs6g98LR1N
 jtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653793; x=1790258593;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w+ONaJmsBdbKSlqfG2Db2VNG//Wj2GLHd0gKPk8C4Q8=;
 b=KRbmykXyq63qxuNO+6WutVNgG+nOnG029jSEVqcAljVVw6T2f66IGjzgdyuyAVDqg5
 A4Kbm0vUbod8ngSDfLuytxhfcz4JxgwfNlTMZxhYsZaDic6kWc+I3EFONfnct/hiVGXe
 0CpGWNGmrCJ2NlJM8Of7dYiVbhsT/FOTqa60Iv0axjCcKATBVEdY4s4r/4tXnbnisfBs
 G+MNOeXt1cqU3DSiuzK6Eb82KidfROp3+WCTkn3ZYKIThIvX9fnwes6zuGfndOAYjAm1
 LyiZEUFWHIER484DhCbAij82sdCSfVrJfpOe007sD/6jDe+RPyvU7XGXa8NcLt+dzfHW
 8JuA==
X-Gm-Message-State: AFuF++mDQ1EMvEcsmnYqfDKMiSI21qZ2quCkgMhfj0jDXdFdEdTGl5QO
 I1HDaulntNMnDkx4Oe7UkeHpLkZfeqygzwXjeJNqzP9LFe9745oJ2tTfgXW7/H378zI=
X-Gm-Gg: AYBFou2FwMq6R3n7/7VUaiPwxHAoE+Ws985YrKn6J70jF7/78CTfZJf56ez5DxFKOCG
 OYGL3XziezfMoW7OHhPD6gt78JCpPp+fN4fZ9yMVKVTMnel1CC1s4FmehdB8xNDVLlqapt5V2+J
 EGCePgmK8VyW4w411uiLVcwegPWRDnJlm0OjMh2AZVCiT7jTjlPu1bNbY5IFTdhRgTf1YGoBnTV
 D8CF3MI2uT+1ZPjKiZ7zOcG/oRT5hD83nLyAm4v/ImfOWxmzxxZU6Z/iA/+CHKvdWttiGhbEIlN
 4Les/jiMfxfAjgiSVjb5cSD01ZMGbasLvUshMocw9dVDtOMlfm3qGrUTtMO17norOO0zbKUH+0p
 tTnW2ReX7nj+FZKDcY2/EMra/lPO4jLVQickN9xPAK9RTIAsTmwlyilDkLPBULQqgpbF3DQjecP
 VN2dceDnRx8GZ1p2tQocFfZH7e7K149RJ5Lvl4oIjRQmPIqGPN4F0ZHYYomuOI7khzuS9Mk+70U
 C/8g1sUnoEAD2/4otmKPZST5P5t9DePy8nE6YLvUodHrfVbEFnW
X-Received: by 2002:a05:6000:614:b0:486:e3bf:606 with SMTP id
 ffacd0b85a97d-48713c01017mr5993584f8f.18.1789653792688; 
 Thu, 17 Sep 2026 07:03:12 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16893905f8f.26.2026.09.17.07.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:03:12 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 17 Sep 2026 18:02:29 +0400
Subject: [PATCH 08/11] test: spl: Cover FIT image decompression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-fit-compression-v1-8-7985ac56ee9e@flipper.net>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
In-Reply-To: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8430; i=alchark@flipper.net;
 h=from:subject:message-id; bh=TNWAms+aV+x4hefat2KVvrJXajz/Ybc6u4gYtoiHMXk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt/vSbi0ug5ED/jx8GV5obHI5+//My5OzWpWFHjDbcu
 fUrgveETcdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTHTaDkWGv241Tkjy8Ly5l8LzKuRTGtHxWjO6uyQsutDZm8oevWbKf4a+USH7
 rPqUuOR5p0WtXLOwFpp6OKnnwhLf7/7IGTQb2mbwA
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

Nothing exercises the decompression in load_simple_fit(): create_fit()
only ever writes compression = "none", and the canned LZMA blob is only
used on the legacy uImage path.

Let create_fit() take a compression, and load a compressed FIT both ways:
with the data inside the FIT and beside it, since only the latter stages
it through CONFIG_SYS_LOAD_ADDR. Point that address at the same offset
sandbox_noinst uses, since otherwise the staging corrupts what's currently
at 0x0.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 configs/sandbox_spl_defconfig |  2 +-
 include/test/spl.h            |  8 +++++++
 test/image/spl_load.c         | 52 ++++++++++++++++++++++++++++++-------------
 test/image/spl_load_nor.c     |  2 ++
 4 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 11f16f5d6220..bec02ce7bb1b 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -6,7 +6,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SYS_LOAD_ADDR=0x0
+CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_SPL=y
 CONFIG_PCI=y
 CONFIG_SANDBOX_SPL=y
diff --git a/include/test/spl.h b/include/test/spl.h
index c5349b06e290..ce0e636d2537 100644
--- a/include/test/spl.h
+++ b/include/test/spl.h
@@ -30,14 +30,18 @@ void generate_data(char *data, size_t size, const char *test_name);
  * @LEGACY_LZMA: "Legacy" uImages, LZMA compressed
  * @IMX8: i.MX8 Container images
  * @FIT_INTERNAL: FITs with internal data
+ * @FIT_INTERNAL_LZMA: FITs with internal data, LZMA compressed
  * @FIT_EXTERNAL: FITs with external data
+ * @FIT_EXTERNAL_LZMA: FITs with external data, LZMA compressed
  */
 enum spl_test_image {
 	LEGACY,
 	LEGACY_LZMA,
 	IMX8,
 	FIT_INTERNAL,
+	FIT_INTERNAL_LZMA,
 	FIT_EXTERNAL,
+	FIT_EXTERNAL_LZMA,
 };
 
 /**
@@ -131,6 +135,10 @@ static inline bool image_supported(enum spl_test_image type)
 		return IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT);
 	case IMX8:
 		return IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER);
+	case FIT_INTERNAL_LZMA:
+	case FIT_EXTERNAL_LZMA:
+		if (!IS_ENABLED(CONFIG_SPL_LZMA))
+			return false;
 	case FIT_INTERNAL:
 	case FIT_EXTERNAL:
 		return IS_ENABLED(CONFIG_SPL_LOAD_FIT);
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 34ddc49d2463..1fc0b8e9552e 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -40,7 +40,25 @@ void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
 
 /* Local flags for spl_image; start from the "top" to avoid conflicts */
 #define SPL_IMX_CONTAINER	0x80000000
-#define SPL_COMP_LZMA		0x40000000
+#define SPL_COMPRESSED		0x40000000
+
+/**
+ * image_compression() - compression a test image carries its payload in
+ * @type: The type of image
+ *
+ * Return: the FIT "compression" name, or NULL for an uncompressed payload
+ */
+static const char *image_compression(enum spl_test_image type)
+{
+	switch (type) {
+	case LEGACY_LZMA:
+	case FIT_INTERNAL_LZMA:
+	case FIT_EXTERNAL_LZMA:
+		return "lzma";
+	default:
+		return NULL;
+	}
+}
 
 void generate_data(char *data, size_t size, const char *test_name)
 {
@@ -77,7 +95,7 @@ static size_t create_legacy(void *dst, struct spl_image_info *spl_image,
 	image_set_os(hdr, spl_image->os);
 	image_set_arch(hdr, IH_ARCH_DEFAULT);
 	image_set_type(hdr, IH_TYPE_FIRMWARE);
-	image_set_comp(hdr, spl_image->flags & SPL_COMP_LZMA ? IH_COMP_LZMA :
+	image_set_comp(hdr, spl_image->flags & SPL_COMPRESSED ? IH_COMP_LZMA :
 							       IH_COMP_NONE);
 	image_set_name(hdr, spl_image->name);
 	image_set_hcrc(hdr, crc32(0, (void *)hdr, sizeof(*hdr)));
@@ -161,7 +179,7 @@ static size_t start_fit(void *dst, size_t fit_size, size_t data_size,
 }
 
 static size_t create_fit(void *dst, struct spl_image_info *spl_image,
-			 size_t *data_offset, bool external)
+			 size_t *data_offset, bool external, const char *comp)
 {
 	/*
 	 * The name goes in twice, as the description of both the image and the
@@ -219,7 +237,7 @@ static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 		return 0;
 	if (fdt_property_string(dst, FIT_TYPE_PROP, "firmware"))
 		return 0;
-	if (fdt_property_string(dst, FIT_COMP_PROP, "none"))
+	if (fdt_property_string(dst, FIT_COMP_PROP, comp))
 		return 0;
 	if (fdt_property_u32(dst, FIT_DATA_SIZE_PROP, spl_image->size))
 		return 0;
@@ -271,22 +289,23 @@ out:
 size_t create_image(void *dst, enum spl_test_image type,
 		    struct spl_image_info *info, size_t *data_offset)
 {
+	const char *comp = image_compression(type);
 	bool external = false;
 
 	info->os = IH_OS_U_BOOT;
 	info->load_addr = CONFIG_TEXT_BASE;
 	info->entry_point = CONFIG_TEXT_BASE + 0x100;
-	info->flags = 0;
+	info->flags = comp ? SPL_COMPRESSED : 0;
 
 	switch (type) {
 	case LEGACY_LZMA:
-		info->flags = SPL_COMP_LZMA;
 	case LEGACY:
 		return create_legacy(dst, info, data_offset);
 	case IMX8:
 		info->flags = SPL_IMX_CONTAINER;
 		return create_imx8(dst, info, data_offset);
 	case FIT_EXTERNAL:
+	case FIT_EXTERNAL_LZMA:
 		/*
 		 * spl_fit_append_fdt will clobber external images with U-Boot's
 		 * FDT if the image doesn't have one. Just set the OS to
@@ -296,8 +315,10 @@ size_t create_image(void *dst, enum spl_test_image type,
 			info->os = IH_OS_TEE;
 		external = true;
 	case FIT_INTERNAL:
-		info->flags = SPL_FIT_FOUND;
-		return create_fit(dst, info, data_offset, external);
+	case FIT_INTERNAL_LZMA:
+		info->flags |= SPL_FIT_FOUND;
+		return create_fit(dst, info, data_offset, external,
+				  comp ?: "none");
 	}
 
 	return 0;
@@ -325,7 +346,7 @@ int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
 		ut_asserteq(info1->load_addr, info2->load_addr);
 		if (info1->flags & SPL_IMX_CONTAINER)
 			ut_asserteq(0, info2->size);
-		else if (!(info1->flags & SPL_COMP_LZMA))
+		else if (!(info1->flags & SPL_COMPRESSED))
 			ut_asserteq(info1->size, info2->size);
 	} else {
 		ut_asserteq(info1->load_addr - sizeof(struct legacy_img_hdr),
@@ -781,10 +802,10 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 		     int (*write_image)(struct unit_test_state *, void *, size_t))
 {
 	size_t img_size, img_data, plain_size = SPL_TEST_DATA_SIZE;
+	bool compressed = image_compression(type);
 	struct spl_image_info info_write = {
 		.name = test_name,
-		.size = type == LEGACY_LZMA ? sizeof(lzma_compressed) :
-					      plain_size,
+		.size = compressed ? lzma_compressed_size : plain_size,
 	}, info_read = { };
 	struct spl_boot_device bootdev = {
 		.boot_device = loader->boot_device,
@@ -798,11 +819,12 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 	ut_assertnonnull(img);
 
 	data = img + img_data;
-	if (type == LEGACY_LZMA) {
+	if (compressed) {
 		plain = malloc(plain_size);
 		ut_assertnonnull(plain);
+		/* The canned blob holds what this seed generates */
 		generate_data(plain, plain_size, "lzma");
-		memcpy(data, lzma_compressed, sizeof(lzma_compressed));
+		memcpy(data, lzma_compressed, lzma_compressed_size);
 	} else {
 		plain = data;
 		generate_data(plain, plain_size, test_name);
@@ -815,11 +837,11 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 	ut_assertok(loader->load_image(&info_read, &bootdev));
 	if (check_image_info(uts, &info_write, &info_read))
 		return CMD_RET_FAILURE;
-	if (type == LEGACY_LZMA)
+	if (compressed)
 		ut_asserteq(plain_size, info_read.size);
 	ut_asserteq_mem(plain, phys_to_virt(info_write.load_addr), plain_size);
 
-	if (type == LEGACY_LZMA)
+	if (compressed)
 		free(plain);
 	free(img);
 	return 0;
diff --git a/test/image/spl_load_nor.c b/test/image/spl_load_nor.c
index f53a6724e27f..32265f6346f4 100644
--- a/test/image/spl_load_nor.c
+++ b/test/image/spl_load_nor.c
@@ -35,6 +35,8 @@ SPL_IMG_TEST(spl_test_nor, LEGACY, 0);
 SPL_IMG_TEST(spl_test_nor, LEGACY_LZMA, 0);
 SPL_IMG_TEST(spl_test_nor, IMX8, 0);
 SPL_IMG_TEST(spl_test_nor, FIT_INTERNAL, 0);
+SPL_IMG_TEST(spl_test_nor, FIT_INTERNAL_LZMA, 0);
 #if !IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)
 SPL_IMG_TEST(spl_test_nor, FIT_EXTERNAL, 0);
+SPL_IMG_TEST(spl_test_nor, FIT_EXTERNAL_LZMA, 0);
 #endif

-- 
2.55.0

