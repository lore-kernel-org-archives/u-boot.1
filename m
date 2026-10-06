Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DFBCA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 21:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26EC160B64;
	Tue,  6 Oct 2026 21:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dPWOac6Ii0Qb; Tue,  6 Oct 2026 21:48:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9E2B16062D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791323305;
	b=BrTfHshJCZRy0Zg2bzJOcyP4FvcjUQbNXsv+TeySr26clTUxWCIOEi9jM6wpmDhXqfLU
	 5hjRbtvtugrPSWNBd2piIPX62ygj71hdSJ/XHYLmIGHpn+Gzjwy5EIwsawRh0A6xaU6Re
	 UPHPJ11Vy3mkq4aXJLU2v6cdKYLK+avrDBJRYL8AC6cA9WmhKVmzzhV9Z+BTr6J5Wuo39
	 2HHnnUefzwHhC7YAkk/YrBXBW5vJ4u/7jsvwllrP/+pHxdpxL+Uw46ltTwdOOMr6SQBzz
	 git34ZpEd8e4E2JuoOaVFZsOLAqM7SItobEN+UBbdTqXZRA2Utw3sxyvd7H88MeuBFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791323305;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=63/Cwtd2ZPOzqazrAvY3RhjbLxNwGE/iFRUL1it+uqU=;
	b=sRYT8ra/+mx4vvRxZN317HqQaSsjpJgdtGK4YhiYprhXB+JK05X1tjFwi/tUa3Mz2Wyn
	 pjXNZiC7TWdrRYaXiy4MjZNGwEEsYjhlryjxOzf06luvONeEnRj0e1QX3/Ll7iE6Bt/Ob
	 HRiL+bQyXMO8YVWTKumxjoy1RNp9dfiuRCSAqyYV6nAWUppXpd5zoaJEskzpA0dOQtc6X
	 EJUOH6JtpChN+glVYpfR0eEPYsHbCv17dUcBqA+Kz2VdFfVI1B+qzSp6g5r0nvM1/MF59
	 1FH5uNzyfsC6PkHphoEAmTHEWmZWfpCN5mTtw9d13hoNVsj3Bi7rOyth2N1ro4eq1Fw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=N0NN5kkL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791323305;
	bh=63/Cwtd2ZPOzqazrAvY3RhjbLxNwGE/iFRUL1it+uqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S170MLh6YVRiCKBwgY/1ed/+dNhmQEH/5kvtMIS3O9vcahOY0Fr1t4FFQJKWlD9sd
	 b7b9/lyQokLj9iEETofsndTdDUmUzo7RyazAXqBE05FC7YLzXzrdO2NhgTgvfX0a0i
	 d9OmqHrB7lIaCFZzkRY2Grw/bUMOg6163CCZ3scF9Rw2lwBp4cgaxVjiGF4h9ofKjR
	 pjkq+CdVApIcQjksAwWGD2Pt3DvYZhGi6KuJqGh1p/6vy9BKTeSc2H93TjlvG5Da97
	 vcobdQPs0joSAoxlPeSHT7XBKNEwxpp0XvsmKgksn+h/7/rgh13ZXP9/MR5bhFhtwI
	 km4nJ3LyBXD5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E2B16062D;
	Tue,  6 Oct 2026 21:48:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF50032F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0874607ED
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wpxd530wXOC9 for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 21:37:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EF70C607CC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791322647;
 b=qQGt5KJbLmFoKiSNevxdkD0iNS6xWEOa5WbJlZY37ngFZTteEHw7Ga/wxrEtcdoArovy
 mqNXwIxsiSOW55tXuGmRtdkdLuCkBBUaWWBALTwuOwMTIGSpp9PCP4Tn4r6MjMEFIUKzI
 Dklrr46eSvNLfNFo4LO2AfYd6mfgdtCu0tlSKTGhfUwGisnb3XoLULb0V/vl957NfPSI+
 8p4sw/jBODuxKdyA8PQnLTfmLOVMzkYS387qmlI8O7uT5mmRjfpU8XAnacK2cry4qwTSY
 DESvyEdrEVGD13Q/s9RpRMt5AHV0TsdglMMSrorCHKb3E8DEBw4reBwJUtGQNnDetog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791322647;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=63/Cwtd2ZPOzqazrAvY3RhjbLxNwGE/iFRUL1it+uqU=;
 b=CBJchxr71j+XeM7dMibpjWesJmy2n159LDJwG4V1/46NK1mLRsrb55NNsczQSvWuK2bF
 JaGkFtdmVTbQgErRzLnZWAnIU81/RpxPrFVWZA5fp+kcAyXO6y84jIRJhLxtNjBMiRFAW
 tGVOIGwNY3Pp9lu4iVHk60f//QG4vagp3dyZgZC6HEjvxUa+0NPPqfy1NgP2XPhqaKxMm
 rjn6buYUkmBjjxn2h0WwVPpHRmHO+3KusgfnxBrF9LgVj9bSbNe+uwRBQrF/ThiWzbhJC
 tUO+7qhCkgycrFx8LIVRrKhyK+RiyLcYqwlfzjDjv68+NBMYgQ1a4/3iXIPfJuGw6NQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=N0NN5kkL; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=N0NN5kkL
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF70C607CC
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:26 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-81579d03929so930034a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791322645; x=1791927445;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=63/Cwtd2ZPOzqazrAvY3RhjbLxNwGE/iFRUL1it+uqU=;
 b=N0NN5kkLS966TonsgBlfu1NxQpgY03yq3PW4fnwriyZXhkg1GFyhoPIgA4WyNiodEv
 759BHdeEuGbyYDwKwLsYy6yoXqAQe4V/t5oX77wEpPLI4WjXTeJDMExjGes5GnFNDtmS
 QaWjHen2jtaExMwd3HXx+HPbmDvKw+nJ8HSzlMYDOD23ClwimFyxqGM37IU4UtDm/sks
 rSZ+mXkoDcx+f0agKBbC+jmUEoFi1XWdIljUIgHvC6ueEZ+rwQAkvJbWDi4bSG00DCbj
 HrfP5pWh37s34663Wtoi3cSfXWDrqKmwhs7OAT6GDHRqpTT93GUFrI8au6vPSH8R6sxc
 zEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791322645; x=1791927445;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=63/Cwtd2ZPOzqazrAvY3RhjbLxNwGE/iFRUL1it+uqU=;
 b=mf0dbbKiY48njZmHxauzv6gqT9k6A7Gt874XHgItiC/MVK7z/027B1UxZmJ8eGFxWf
 gJFDen0J9UJ6sEX0EEYVEa0PjQvi6mL/xdbPQyv6hs064BqYEYTo6Ol1Zzo6gO3uRmyo
 oSpz0V+X4GZTkpUpBYXWpxnmASfmHta2HAGlk8EtDBsVlbbka70C5SF6j/ulV4bF+axg
 E+PAAKkpXyGAhDoYCm5ec/nxMdW05XuP5uoITUPQ5CKL9YIPW0/QUecFnZQ1CGC+NpH1
 mSZxzJPVdbKUQfBa2ZCS4mAufTASKD8B+Jy9Y5QuCp6siTdUVXWrJIuTy/RAkiiXXeDD
 60kg==
X-Gm-Message-State: AFuF++k+aiO7+N0Ln/0U7RqZFo/bXQfb0YAhr8Gl9WDV1blaixoVrjRU
 lT0abxYhUljDRvby1Fae8YRMPx9sj/kqvRnNerQYTdRw64lpDhRmEIFDH8q+urpYWec=
X-Gm-Gg: AYBFou0EbiRXDxRlRTDVykMjT1JzsN7jSYo/xk89ZTEDA8IgXyjE6PAFfOxgpBRCAi9
 4oKBgUnu0M6E3suy854W3QO8JjK98FMcZVH6M19jXOLVYT3vIjfoN+r1+DwyM7yxW31tSNHpClt
 byCSJuhFhxdxn4tPzNbGIt8ocLFXyJjKD7xPh+09meWiI8swUdec6ub4VLdIMmlXoQk2K8eU5P9
 +bXvvRH0Po27F7RUOf4SJXNFo53zb9dqO3khdkTV1BWq+mVdddHFsii4TnOxEOg/1wDI00syOnA
 39rnyVyWrU+HUzwgTkpVLzTrrfCmkTRhhSL3HzaI+zxCHsQJ2HYWJDRje2sb+6mTMkxz8HE86Ze
 UIJd27bhnE/p7R+lRm5x1XGdgQUuQBKG1BcfoVrXMjTYN3wu4RFSMT37t9bqigOli60Sn/Q2qEQ
 Pbfb/Md9sd466xhAx/p5E20pmmS+vzkD3XI2aSG+Uv1mJdcLlU+RsOIueYmLpcESBTUj0WG1XpL
 ICqk56uaCb/
X-Received: by 2002:a05:6808:4f4f:b0:4d6:92b3:c1ba with SMTP id
 5614622812f47-4fc47abcda9mr680732b6e.61.1791322645344; 
 Tue, 06 Oct 2026 14:37:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4fc4953f89fsm389386b6e.12.2026.10.06.14.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 14:37:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Oct 2026 16:36:14 -0500
Subject: [PATCH 2/8] video: mediatek: add MT8189 DSI display support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mtk-genio-720-dsi-v1-2-7fa10e9c4506@baylibre.com>
References: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
In-Reply-To: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6538; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=cHUT7CS2PRGZW31aT75ZiXX55l9NdLSR+g0duHM8vBk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxWnd8WA4Cf+KQywb+ANbGdT/IMrf/Qg81+iy4
 7rQQBnR4riJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVp3RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A3X0H/jDF49JA4rXeSmwCpyifXLbokZMCkCdSvXo+t0A
 cW+fHIThjIbyH7tCZZrnvvdeu9a4wRbuTLbCUTL68QeVkhCgw7ars/sIHbRzw/2sIDwhV7c9muK
 ddFrCRf9XevJDKZSpUq2ufdQtghlAURtI7LahOodUDsmVmbyHwI5ZQLb7lzSAjmjS4/PU18OrAl
 RJPvuuikYPBWtL5x0xdy5BWUlApWsFzjcWw/v8nFmacKYvQRXu83iKVINtS2YTPO6rmReZniszw
 zXQAzWFlTeA2z5FITZKjTWlLdHdjTtAtX9SiAhiNsig+V6rPq27OyZe7iHiDyOVebmi8sYsYEHA
 GIQU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add the per-SoC data and compatible strings for the MT8189 vdosys0
OVL0 -> RDMA0 -> DSI0 pipeline. It reuses IP that the existing drivers
already handle:

  - MUTEX: the SOF selector encoding matches the mt8366 generation, and
    so do the OVL and RDMA module indices, but the DSI sits at index 22
    rather than 13, so the pipeline gets data of its own.
  - OVL: the mt8366 data applies as is (10 GMC bits, SMI id enable and
    extended colour format support).
  - DSI: the path and the mmsys display data path muxes are the mt8366
    ones, so reuse mt8366_dsi_path and mt8366_ddp_ovl_to_dsi(). The
    register layout is the mt8188 one that mtk_dsi already implements,
    including the command queue at 0xd00 that has to be sized explicitly
    for long packets. Unlike the mt8366, which has no shadow control,
    this SoC keeps it at 0xc00, where upstream Linux has it for the
    mt8188. Match "mediatek,mt8189-dsi", which the in-flight Linux
    binding documents without a fallback.
  - SMI: the larbs are the MT8188 IP, with the ports controlled by the
    secure world, and the display smi_common block needs no per-SoC data.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/memory/mtk-smi.c                |  7 ++++++-
 drivers/video/mediatek/mtk_disp_mutex.c | 19 +++++++++++++++++++
 drivers/video/mediatek/mtk_disp_ovl.c   |  5 +++++
 drivers/video/mediatek/mtk_dsi.c        | 20 ++++++++++++++++++--
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 28f026c3ed9..da1f0de121e 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -74,7 +74,7 @@ struct mtk_smi_larb_priv {
 	unsigned int enable_count;
 };
 
-/* the MT8366 larbs are the MT8188 IP */
+/* the MT8189 and MT8366 larbs are the MT8188 IP */
 static const struct mtk_smi_larb_data mt8188_larb_data = {
 	.port_sec_ctl = true,
 };
@@ -149,6 +149,7 @@ static int mtk_smi_common_probe(struct udevice *dev)
 }
 
 static const struct udevice_id mtk_smi_common_ids[] = {
+	{ .compatible = "mediatek,mt8189-smi-common" },
 	{ .compatible = "mediatek,mt8365-smi-common" },
 	{ .compatible = "mediatek,mt8366-smi-common" },
 	{ }
@@ -279,6 +280,10 @@ static const struct udevice_id mtk_smi_larb_ids[] = {
 		.compatible = "mediatek,mt8188-smi-larb",
 		.data = (ulong)&mt8188_larb_data,
 	},
+	{
+		.compatible = "mediatek,mt8189-smi-larb",
+		.data = (ulong)&mt8188_larb_data,
+	},
 	{
 		.compatible = "mediatek,mt8366-smi-larb",
 		.data = (ulong)&mt8188_larb_data,
diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
index 1d987ad06f8..99e46711db5 100644
--- a/drivers/video/mediatek/mtk_disp_mutex.c
+++ b/drivers/video/mediatek/mtk_disp_mutex.c
@@ -74,6 +74,14 @@
 #define MT8366_MUTEX_MOD_DISP_RDMA0	4
 #define MT8366_MUTEX_MOD_DISP_DSI0	13
 
+/* the MT8189 matches the MT8366, except for where the DSI sits in MOD0 */
+#define MT8189_MUTEX_SOF_DSI0		1
+#define MT8189_MUTEX_EOF_DSI0		(MT8189_MUTEX_SOF_DSI0 << 7)
+
+#define MT8189_MUTEX_MOD_DISP_OVL0	0
+#define MT8189_MUTEX_MOD_DISP_RDMA0	4
+#define MT8189_MUTEX_MOD_DISP_DSI0	22
+
 /**
  * struct mtk_disp_mutex_data - per-SoC mutex data
  * @dsi_mod: MOD0 bits of the components of the OVL -> DSI pipeline
@@ -132,6 +140,13 @@ static const struct mtk_disp_mutex_data mt8366_mutex_data = {
 	.dsi_sof = MT8366_MUTEX_EOF_DSI0 | MT8366_MUTEX_SOF_DSI0,
 };
 
+static const struct mtk_disp_mutex_data mt8189_mutex_data = {
+	.dsi_mod = MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_OVL0) |
+		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_RDMA0) |
+		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_DSI0),
+	.dsi_sof = MT8189_MUTEX_EOF_DSI0 | MT8189_MUTEX_SOF_DSI0,
+};
+
 int mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev)
 {
 	struct mtk_disp_mutex_priv *mutex = dev_get_priv(dev);
@@ -170,6 +185,10 @@ static const struct udevice_id mtk_disp_mutex_ids[] = {
 	{
 		.compatible = "mediatek,mt8188-disp-mutex",
 	},
+	{
+		.compatible = "mediatek,mt8189-disp-mutex",
+		.data = (ulong)&mt8189_mutex_data,
+	},
 	{
 		.compatible = "mediatek,mt8365-disp-mutex",
 		.data = (ulong)&mt8365_mutex_data,
diff --git a/drivers/video/mediatek/mtk_disp_ovl.c b/drivers/video/mediatek/mtk_disp_ovl.c
index 865372a6263..da02e25671b 100644
--- a/drivers/video/mediatek/mtk_disp_ovl.c
+++ b/drivers/video/mediatek/mtk_disp_ovl.c
@@ -233,6 +233,11 @@ static const struct mtk_disp_ovl_data mt8366_ovl_driver_data = {
 };
 
 static const struct udevice_id mtk_disp_ovl_ids[] = {
+	{
+		/* the MT8189 OVL is the MT8366 one */
+		.compatible = "mediatek,mt8189-disp-ovl",
+		.data = (ulong)&mt8366_ovl_driver_data,
+	},
 	{
 		.compatible = "mediatek,mt8192-disp-ovl",
 		.data = (ulong)&mt8192_ovl_driver_data,
diff --git a/drivers/video/mediatek/mtk_dsi.c b/drivers/video/mediatek/mtk_dsi.c
index a93e99d66ad..781dcec559a 100644
--- a/drivers/video/mediatek/mtk_dsi.c
+++ b/drivers/video/mediatek/mtk_dsi.c
@@ -145,10 +145,11 @@ DECLARE_GLOBAL_DATA_PTR;
 #define CLK_HS_EXIT		       GENMASK(23, 16)
 
 /*
- * mt8183-style shadow control. The MT8366 follows the downstream mt8188
- * data, which has none, unlike the upstream Linux mt8188 one (at 0xc00).
+ * Shadow control, at 0x190 on the mt8183 and at 0xc00 on the mt8188 and
+ * mt8189, as in Linux. The MT8366 has none.
  */
 #define DSI_SHADOW_DEBUG	0x190
+#define DSI_SHADOW_DEBUG_MT8188	0xc00
 #define FORCE_COMMIT		       BIT(0)
 #define BYPASS_SHADOW		       BIT(1)
 
@@ -271,6 +272,17 @@ static const struct mtk_dsi_data mt8366_dsi_data = {
 	.host_cmdq_off = 0xd00,
 };
 
+/* the MT8189 path and mmsys muxes are the MT8366 ones */
+static const struct mtk_dsi_data mt8189_dsi_data = {
+	.path = mt8366_dsi_path,
+	.path_len = ARRAY_SIZE(mt8366_dsi_path),
+	.ddp_connect = mt8366_ddp_ovl_to_dsi,
+	.cmdq_long_packet_ctl = true,
+	.shadow_dbg_off = DSI_SHADOW_DEBUG_MT8188,
+	.vm_cmdq_off = 0x200,
+	.host_cmdq_off = 0xd00,
+};
+
 static inline struct mtk_dsi_priv *host_to_dsi(struct mipi_dsi_host *host)
 {
 	return container_of(host, struct mtk_dsi_priv, dsi_host);
@@ -1161,6 +1173,10 @@ static int mtk_dsi_bind(struct udevice *dev)
 }
 
 static const struct udevice_id mtk_dsi_ids[] = {
+	{
+		.compatible = "mediatek,mt8189-dsi",
+		.data = (ulong)&mt8189_dsi_data,
+	},
 	{
 		.compatible = "mediatek,mt8365-dsi",
 		.data = (ulong)&mt8365_dsi_data,

-- 
2.53.0

