Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678B6CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7609E404EB;
	Tue, 29 Sep 2026 20:32:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NywBmmG8zIsx; Tue, 29 Sep 2026 20:32:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B6C29403FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713961;
	b=papS+lYFYjdJSod4McLdGQPtkK2Iz60N+oADjH/eXT7ZzVrxYPIUTbyNLE+5HyRJxefp
	 qjpwwtVgPq7LecRUYV7jc9apprbTPa2RtcO/IjjjT+wVtO/Yk1aG5KBMwacRBgsfCeq1H
	 xpzFJu1gE3xa8M6ZqXqTm6oJmXeth3oT/6ebQ9GlAA0WcMV0Z3i+90I4lvVA1DJ6XH2ih
	 XZmD8jpo453eZubSB2Tx5g/7P4xUv0crTovDOORFyHWV72v72YmjI7qyA/Jl/M+wxhTVy
	 4+DHZlp8LAQ4vVdtqi5OqLj0YqS5TguBNgSJTZQzAKYZ4KErqIXfsCW3sWzCMA0gxAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ay6si2tSqi0zRUPuyi5zD1k1dWeg1wqA7w8pM/vxUsI=;
	b=BSwVYa84px2vek6ATX16Lq7ueCCwRmF2I0DLm7HQQH/8opHFcWSuEuC2kwSqRGE9reVr
	 Y4K9/yojP4S//nSu+kFAWR2PI8i58LsJmWVapvZtx9kv8hWxdR8ERdknuQcj/IEET9gCN
	 go7gncyoqFBs81YlPNhiXi2Sc/Jb0nGYMg7ZG6aL/mLGVYj33b8tJ1HsOn4jCkfOcYhpQ
	 R+S8vPMKgX7REohcO1v9WKNXiEG8FlY3TAqK9YqHij2yzHPLG+p5bGfKCt74roeSHsmX1
	 wFbDTb2XwlfuI/FwPRW0Qme7oyR04WpZi9U/8+aSXxFYVH8YCSP+vU7zcOrgiARusNQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713961;
	bh=ay6si2tSqi0zRUPuyi5zD1k1dWeg1wqA7w8pM/vxUsI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WNdF0elRSnNb3BMSNvh42DHDLgZdIu7Ii/Ne+4EOIuvF/98tEJePqTXVdjCBDD3Ov
	 /Up8/zSxBX7umbf/Cv5vPkfILgFYMAycFDRdJFMaGSmhbcCnBOaa+ZY2UYhCxbEahU
	 OkOjW9Oxh2LrIcsedpwQA57G1kiSNYMcE2ZePbJSX9k5OjZblrTsmKlXDrtftIxOHo
	 TK2cfqtr80KdkhdCJ6jsprQjg05hp/DiSViEq435IROK2LuXzwkc6mpbZ5xb4j2EoE
	 iInhDni3g17Ji0G+8rZcppRTP6evgWwN90N/Ad3Ygg947j9fq5d6xRx8zjZTyweJ9I
	 uU+qLwCXfb6Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6C29403FF;
	Tue, 29 Sep 2026 20:32:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D0D124E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8ED576071D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TlvLaNIxHq35 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 17:52:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E08F2607A9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790704366;
 b=bFOk5avDzOQ8TYP1XC+LVkCEEQOpXh/DL/GgIpVXhDC6hbvdw7pfPnMnXD5cgqrypjb+
 4kWhnsxizP8DOm5umZDyFqNrVbKlTjLyIuv5ljT4oHsvTy5xPbfUTKcsVU/fz4AY0kXgj
 liTKkI+VIiMiCPScpX6ySx8TYr3yRNYDR8nJi97JCKQR3/qVDjUGHszC8G6EmDfJ34xfy
 vO3XBvzfzyGQ6VQtmYTAq8sKKurllBxaspdb+0Q7hxEIN3qjPR3Pok+LqcyMwawunLCL/
 8VdXjt6/0sobiBA3B9XcPi7lVWgjEDTxQfL9dvGBbrPM6/FG2FzhB/SVfcNCZYp6zXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790704366;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=ay6si2tSqi0zRUPuyi5zD1k1dWeg1wqA7w8pM/vxUsI=;
 b=MzcMiVM3v5TaAqRB3YqJ/jiG4JL0+elMdqiHxeO60JDtPaJACKx+tWDxgRdvsNDDll6R
 JilGqPQ+vbuPWw+JN+tkKW4dRMECSSivtTDzoBsWrXEPRBeQR+ElP7NSWHk+rEbkStsWG
 Pty8JlBgDNPce5lqmokOcVperoTHHUtwRICZK8bez/SdoBHeGIzDI8Bkng+ciRV/tEigw
 Cb05D/Rgrytuc4eam/1gJO0KElq1hK2fMO/rzHBicodLDtTZkZfswawi5kSXd4hbOlhf+
 rtPFL6VC2R3ETHfag1H8T7/7q4/R5uXXiNZDuNX4fzP/q2wTsBSd+2hWxeY5xQMg71Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=lYsU+gjK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:34::e;
 helo=mail-qk2-x0e.google.com; envelope-from=sanderson@brivo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=lYsU+gjK
Received: from mail-qk2-x0e.google.com (mail-qk2-x0e.google.com
 [IPv6:2607:f8b0:4864:34::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E08F2607A9
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:52:45 +0000 (UTC)
Received: by mail-qk2-x0e.google.com with SMTP id
 d75a77b69052e-53315c1a1d3so50627271cf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790704364; x=1791309164;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ay6si2tSqi0zRUPuyi5zD1k1dWeg1wqA7w8pM/vxUsI=;
 b=lYsU+gjKZs/1vyiqjF8UcaJaAAVe86SZRKlI6TU8TIAHqenP46oIPfan4bhueyRDfZ
 uLIKM95ZDq2XFWkomaCTCpGQ1n2GwwHxuJXbXqFw5v6wP2fAR7ioyps3fVq46NMEkXK3
 NwSZqCp8qA73axsXI35IhFP8v0QaXy2SzzfWj3pg88kYN4oKcnpvBpLjKJcbGe/VYDyE
 SOTIPAUOMb4Lj+bT3xxacUasw6OVsZ8NSR6tqslg/GX4jXrJDSBX5YwaZ7WneqnXYrDR
 B23+9k018pcIOdC5DRScWL5gKkuFtsN+wpbJTHXCszUW1hNShhPSG4WfFmQF3hkl96IE
 tETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704364; x=1791309164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ay6si2tSqi0zRUPuyi5zD1k1dWeg1wqA7w8pM/vxUsI=;
 b=RsDtld5SZJKQw5VItDDwsYiaE1wsJH2epeEdZ8PjJ3bXhLq9kEBnd+SMDxqdiYm2hN
 1fdhpTY6tLbSBf6EMNsbn5k1ooo/5Di6+Jjsi+AlMX/4KQ5V01F4tykdRQZUbV4ZmyjW
 iLcjfcv7GWGfT0XvwTe7PqyqJG5AifMcMq57gzwh88iZQ7qflm64UAEHB8tgZIoJuxHa
 rSSJ8HUbKPbhUjIz2Rhi90h2i1w8rdG7qSmuAQeP/72hXaQ6a+ozjCOG1VU1aWneANeo
 5t5QdeHOdvwA0WFSGxQ9q93oZP1OxnV3s95WZSrAfA9XfaQ6Ew1SI3Ums6Rco8cJmpGr
 SWVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzchC7wqhImFyBh87pABWYhhYKf7UWmHdS8rbZssOKbqfy3GDbrqHHNSjk/oeN2ICK5eHJ2kWE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n1LaftZm30JakPMjJ1mvGy8Dz+fI1FG+qHYSOdkOr03U9VMaPP
 Kjp+QOAtWmKsCaP+JLVOf4YF/PcvHC/AnjXF4lgClPNl4J2SnspdXyB3ZLMxMTTysq2znRUadwL
 X+BM6h5eYHq1ljqhoeY6LtjLVL/75o4Ykm6BRUbUsxhKSgptZ7z7k5VivO5OVbnt1xpZIWIp5FT
 Gbcrk=
X-Gm-Gg: AYBFou2VlhsJlmYUZ2xdQ3WOFjXrWPkMeX0H3TewnYWh+KttAQw852daWv0iKuRyndR
 0jOxuurzvVvm+ZkBWGwfXLveE8Qg2EmaxA7xqpHuhQTFb50fpJOq0f67VKXxO/IxViQ/FhhgE9r
 VGfGjLFid5wn0eCMw84seTtwgId90bZ78zieBgXqJiy1lg9hUWg7Sdn/N5JDVWarfziEK7xZFNJ
 B76EVLJjWr3FEEMykIsM2g9mHVmQ/3Kow5n/qwFulLBkrfolNPSaBiHNP9GeQAKiWc0EmldSuKI
 ZRPk02j5azpMbg1cVuGGTS1lkE3Xn3XylPPPfiM54ls2Er5bSWyKuMuPztxDUj4WR423NgB5FAY
 UglOhVJGg43fkZ2YcQCad1qiqyqw8PObBJJVn/XtSCZcChR9NJ+qJZ11OHVLCcuYAfk4QVNz+0u
 iwmxrJpM5iw1GbsI0Mtn35mq0kUhPSqlwrJucIstcKvAan0goq3aYBcG6nDUwPHqbn
X-Received: by 2002:a05:622a:30a:b0:531:11cc:ab4 with SMTP id
 d75a77b69052e-5336a388fe7mr43881cf.23.1790704363834; 
 Tue, 29 Sep 2026 10:52:43 -0700 (PDT)
Received: from strozzi ([71.163.254.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53369bfd390sm718711cf.26.2026.09.29.10.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:52:43 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Sean Anderson <sanderson@brivo.com>
Subject: [RFC PATCH] pwm: meson: Add s4 support
Date: Tue, 29 Sep 2026 13:52:36 -0400
Message-ID: <20260929175239.3298566-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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

On s4, the devicetree clocks are the direct inputs to the PWMs, so we
don't need to configure the clocks in the driver. Instead, we just need
to grab one clock from the devicetree for each PWM.

The PWM LED isn't working on my VIM1S, but I don't have time to look
into this further. I'm posting this as RFC if anyone else would like to
pick up where I left off.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/pwm/pwm-meson.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index caa7af085fa..654b138d224 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -273,6 +273,13 @@ static int meson_pwm_probe(struct udevice *dev)
 		struct meson_pwm_channel *channel = &priv->channels[i];
 		struct meson_pwm_channel_data *channel_data = &meson_pwm_per_channel_data[i];
 
+		if (!data->parent_ids) {
+			err = clk_get_by_index(dev, i, &channel->clk);
+			if (err)
+				return err;
+			continue;
+		}
+
 		snprintf(name, sizeof(name), "clkin%u", i);
 
 		err = clk_get_by_name(dev, name, &channel->clk);
@@ -488,6 +495,11 @@ static const struct meson_pwm_data pwm_g12a_ee_data = {
 	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_ids),
 };
 
+static const struct meson_pwm_data pwm_s4_data = {
+	.parent_ids = NULL,
+	.num_parents = 0,
+};
+
 static const struct udevice_id meson_pwm_ids[] = {
 	{
 		.compatible = "amlogic,meson-gxbb-pwm",
@@ -517,6 +529,11 @@ static const struct udevice_id meson_pwm_ids[] = {
 		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
 		.data = (ulong)&pwm_g12a_ao_cd_data
 	},
+	{
+		.compatible = "amlogic,meson-s4-pwm",
+		.data = (ulong)&pwm_s4_data
+	},
+	{ },
 };
 
 U_BOOT_DRIVER(meson_pwm) = {
---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: s4_pwm

-- 
2.53.0

