Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AEC606A330
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ui9gLUtK;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iTCmgx1T
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91EF34076D;
	Wed,  4 Nov 2026 12:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qEtBfsk7Z49b; Wed,  4 Nov 2026 12:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BDB3240738
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796672;
	b=niZCbGmvQ8LFlRCkER2OGs2K2NMXvEaEJCfxQoMGRnAl3dpX8B/PrS/0QQ24oFS4E8oM
	 IA21cqoEug6hRygmWBRMA3gnMVt/UuRqliYWQk4iSTbyFkRVELmkVkGyanUrYslBeKEHO
	 VPT6lqmWlmxqXJbyXmthnnLysQwQlQ7Kr68P+CG2yGuS/eg3wHx9gn6s/YvETk0g8qCjL
	 AGb3xdJoZjr6p0oKEWztMr4IsSKYZqDcL8fiThe2KTv1cwVQAI+qcM97ZqagfrLgakegt
	 rtXYP2Qi4W0S6pkUz45hTkDsXm5YWSH1jGdRhNz0cyrpZxm9iIf5CHHf9EW5tbG7+Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
	b=qQ3UVJz/hJqkqJcMPnsZJdJtODCjVG534nV3kBVvCk0FqKUlRKNSVOR/f3HkGyAIgQ8e
	 2aBpcag3amnq9V8qVb4R8kxq75Oygc5Zzqg/+9ACSMq6aF9iSknyst54uXYYyl2Tdeaiq
	 2IwPxHg9gEiaqCjN6UhMIM+LikcCqRg8QQUpBesEo1YySfhdiHYytfgFjoAxdCFMnh+ui
	 HaqdbuIv7tT4M0sZwAdqysE6EmW7iOV8BEzI6A3J2NC4lnJN4oa7U82kc47sstlvHU5x9
	 02dxxH8rZZwHr2iPBzIWOU0bNeTEA1ORKnMoQaEsAmlPMKdLEZ8QXxfleJOszM6RGGg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796672;
	bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ui9gLUtK6JuxQokDfKbDAJHetWcZk9sWcCgP0R3C7tos7hYVZw2+rvDM9ZlS8EJuA
	 9epWNZf5on480g8p4i8UbWbKxExkxexWzP1SPTZ0KIJtpBOmSHeQb2vVVMKAbxvjLF
	 Zu0a9Iyr+9qA7zAOYC7LltMs6eKHd3/BIpAZBkAynKfVak2dyvO3buyi+ZBQyGeHGl
	 OoCShRI0zyJwsaUYV5OTrdKmKwhsBx5LkHoPqcBWFxYFKgbLTlOd66QGuIf+gPc92i
	 GwgWpxw/Y3Vhmbty+fQgQqRvSGQCsSCzXEF5508kHrmtZuV7AxtWcmo7ZfbiO0kp9Q
	 1/D0P2z1vfWlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDB3240738;
	Wed,  4 Nov 2026 12:51:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3422F34D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2544C8108C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5vkUJvOM9W1 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:51:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B4D680FFE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796671;
 b=qSXA4azrWTf6/ijeq7Y3GLd6RFLEoVPY1jffGIpBO7dU2hTREUWBiMbMPy/Tkf0fX1fY
 ccvL0tvjc23okY8sIUL6sv/xHx1HUqz5glOiSrzOEHVVnHnhIX4j+QERoqazEHbagN24B
 Yo3dV8pJUnyIvsQQ9V5h1Jr9hnknLz8QkFMqIKNrv6Czi8N2YYtB7GUiexhF0YIRLHywQ
 Xm6v7JvCDiycrK8Rwcr1REvYmWaHiQgfVFv2UN4r/hQhbFW07g905O3GSLsRm54az8bLv
 kxHs1jDdw9eiRQIuJ13nQB9ipQyjkqbfLQuu1zzahrkWV9O2aEqnbtUF+dW7m2vyjKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796671;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
 b=dizc1gjIqAKhpTYlSz/SSB5orjx8A1QM7dONdzZu53SbQn2Gj0+4joZsMmJmIMM7mY4g
 SBF3HYLA+z4ig9aqJT/Gjnb6AQ3A9195tYmkAglCaphZFmFUS6PJCZ/RzQk9KwAyrAgWk
 logOVYh1wVNm5Rbu+8iWzw0SOcmxdGnL/9TgiOIjJGONLw5+/1Py23CqYcywUF1zgPMWt
 cwI516+CuhJNi4z+yURPz6ifmsrEWmtiA35FdaiaqYCVw4xJTP8PyAr3nHX+bBmseHtS4
 IVCs+BKGQsrQRk3w5brf35pKcGfqYcOz2gNqX3v7KjYonIfiCBXB36SPwDQtJxXhqeQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=iTCmgx1T; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=iTCmgx1T
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B4D680FFE
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:10 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so582651f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796669; x=1794401469;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
 b=iTCmgx1TQlhoGKXLj9jYvWwc9Y76ftFOF8tPB/4RQUSz0c3DAIAlxj7nCVQB3NIiP4
 K10skID4Bu/f7Kf4k+UcOFJX6osE/hIGnU8Vy/xnZm6yZG5FedGrGChNYjzDDCl0tOsF
 fbqitismpZLpUcWOl+px6QqaIYTXtHNBonW43niGa0L/njfqq4UEHhFDVki0cZDiTW3t
 89CpZiycuCJxBC5v/2N7yExb6qvdT96DyhIhX2K9sr4+9ZswOu2xiZs3AW0Jo9zUZKPS
 HktlfK/epGJCrACk9Paik6m4f7tQPKN4zBToWdZVS9d97bLquILl9NV2wHRDLojWFukk
 jwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796669; x=1794401469;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5OQpxBYyaWTt4U4V54U7sAcvKTBOG21GhwAApjP23dI=;
 b=V4beYEiYR/ZJWzwHoslbS2Nx86bSPBpWZRiOhMbg9qI0EeuXY5OYoNUFLdqftPrzGd
 +ZYEo1oukiuJETQAAzJBLX4VHUA3/cvSGV43JALPxOo8ep01Hk5SdbndiQ13Y2BFO7Dn
 wUUpzoRj39ubSKdhwFqHLKDOgwXtDJ+SQSUcY6WHf5vrPTzMs+28IFs/DR5FlxtVhk9f
 3NEQb6KEpCVYwAvlCelzt6T7eoX4rfL63H1jXRbblRrAFlakD3ZANou7ANaFfQj+i4Np
 fvQNoDgiMp7H2K+iYIpjmgCdol8tnFTdUwTpDnkcShTsQjx6nN2gz0aN8uFoSSxmCiFF
 2MyA==
X-Gm-Message-State: APuU4Z9rYRR4uHXMyR6O4sf0W+UZw+jG3Vx9K2cUCw/EnLJrr9cB2SWg
 TIXQdKv4oLSmiTyIn04PBhbMJTQbPLa8iuJn/4ft+64F5oRJyWafvCaoFmNbIUjjEEs=
X-Gm-Gg: AYBFou2+SxOXebVoHdEsXA9IE9WYVdu6kub61Q8BN5T4Wfcpnn5SlQAO2yxWyiMBm0M
 SfWxabRzTcxHzYYK0Ccpr3ajmnF1rkXk1LuVEVTZlWj/C9u5/ts7yC5s1Ccu6Qf+zbwPV3JN8LB
 GW/xXmF3agaTSJj7bLg9rDiJ6NY+mzTy5dRNQqgNsL7lTychajYMQgqWlxicNsxd2rglwn2XUsM
 5ZPmvFLt6aLu1rGzLm1TEhKSJeDOaDdo8eSGpiZ3uuJLWeizMBV37Ww7Hb/kBShGyZ7x0hiIfBy
 m7QHoqeeNCqNvTQ4OQzOcQQxReYTU1oR/cWz2aStlW6a+f9j8zEW+hMNtv/bxJAC39N8lEkPEMz
 +Sc+CDi2CJLWgoJ1mlGUAOoSa8VcJ3rNu/kX1GmTDD3gfRG95bmS3iCRj3liH1xMvkNgwKjbige
 OYmKmOjz+4scZfTGgguFl1DKMlnfn6WEQRA1ZpcgaZ69/yqObGrm0ujuvtKkAZuxxvfee3BYjQK
 F1l+WyCKSJeWCkIV9TRViCcVXn/h2O6Wy9cvTXz4zPKb2ClxddbgZUabihWgiT66wkMPaUYeNdB
 y0CcrprIBx2H2WMAYhBsEZxqy5wpLPA=
X-Received: by 2002:a05:6000:230e:b0:48d:f831:2681 with SMTP id
 ffacd0b85a97d-48e6e515fe6mr35661048f8f.38.1793796668454; 
 Wed, 04 Nov 2026 04:51:08 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed5538basm3559984f8f.44.2026.11.04.04.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:51:08 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 07/14] nvme: Skip a namespace with an unsupported LBA data
 size
Date: Wed, 04 Nov 2026 12:51:06 +0000
Message-ID: <71443b69-e5d3-40e8-bf9f-d3075168752d@gmail.com>
In-Reply-To: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
References: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

nvme_blk_probe() takes the LBA data size (log2 of the block size) of the
namespace's current LBA format as the device reports it, and shifts by
it: 1 << ns->lba_shift is undefined for a value of 31 or more, and
nvme_blk_rw() sizes each transfer with
1 << (dev->max_transfer_shift - ns->lba_shift), a negative shift for a
block larger than the maximum transfer size of the controller.

Check it, through a new nvme_lba_shift(), against the block sizes
blk_valid_blksz() accepts and the maximum transfer size. nvme_init()
skips a namespace with an unsupported LBA data size, as it skips an
inactive one, rather than create a block device for it that then fails
to probe, failing nvme_init() and leaving the namespaces it has already
probed on a controller that failed to probe. nvme_blk_probe() checks the
value it uses again.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v1)

 drivers/nvme/nvme.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index c815a967137..3df9b531bfd 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -15,6 +15,7 @@
 #include <time.h>
 #include <dm/device-internal.h>
 #include <linux/compat.h>
+#include <linux/log2.h>
 #include "nvme.h"
 
 #define NVME_Q_DEPTH		2
@@ -701,6 +702,26 @@ int nvme_scan_namespace(void)
 	return 0;
 }
 
+/**
+ * nvme_lba_shift() - Get the LBA data size of a namespace
+ *
+ * @dev: NVMe controller
+ * @id: Identify Namespace data of the namespace
+ * Return: log2 of its block size, or -EINVAL if that size is not supported
+ */
+static int nvme_lba_shift(struct nvme_dev *dev, struct nvme_id_ns *id)
+{
+	u8 ds = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
+
+	if (ds < ilog2(DEFAULT_BLKSZ) || ds > ilog2(BLK_MAX_BLKSZ) ||
+	    ds > dev->max_transfer_shift) {
+		log_err("Unsupported LBA data size 2^%d\n", ds);
+		return -EINVAL;
+	}
+
+	return ds;
+}
+
 static int nvme_blk_probe(struct udevice *udev)
 {
 	struct nvme_dev *ndev = dev_get_priv(udev->parent);
@@ -708,6 +729,7 @@ static int nvme_blk_probe(struct udevice *udev)
 	struct nvme_ns *ns = dev_get_priv(udev);
 	u8 flbas;
 	struct nvme_id_ns *id;
+	int ret;
 
 	id = memalign(ndev->page_size, sizeof(struct nvme_id_ns));
 	if (!id)
@@ -724,7 +746,12 @@ static int nvme_blk_probe(struct udevice *udev)
 	memcpy(&ns->eui64, &id->eui64, sizeof(id->eui64));
 	flbas = id->flbas & NVME_NS_FLBAS_LBA_MASK;
 	ns->flbas = flbas;
-	ns->lba_shift = id->lbaf[flbas].ds;
+	ret = nvme_lba_shift(ndev, id);
+	if (ret < 0) {
+		free(id);
+		return ret;
+	}
+	ns->lba_shift = ret;
 	list_add(&ns->list, &ndev->namespaces);
 
 	desc->lba = le64_to_cpu(id->nsze);
@@ -899,6 +926,10 @@ int nvme_init(struct udevice *udev)
 		if (!id->nsze)
 			continue;
 
+		/* skip a namespace whose block size is not supported */
+		if (nvme_lba_shift(ndev, id) < 0)
+			continue;
+
 		/*
 		 * Encode the namespace id to the device name so that
 		 * we can extract it when doing the probe.
