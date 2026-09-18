Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610EBC88E75
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 127C9811E6;
	Fri, 18 Sep 2026 06:36:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RL7nKxp7CS9G; Fri, 18 Sep 2026 06:36:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2D8FA811DE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789713377;
	b=TqteKTMPEwVqgopiRl6hzbUqjDmyhwiXgsx3cKqHn9b6g8Se/mIFVjgIyLalC/qx414z
	 YX+n6oRcSVgpKj0XJBsfcYIx3cbxSi1WNcmUoZqNbTDaMVQ8mVGy+gJbcVXaJdVDve4tY
	 n8XqKKhyX7pHWkqLNdiQzjDpowIKOJvCc1Zjd0xs5+v1MDsBXeRK2lYIhhcCJJCQl1MOa
	 ZN0zT/Dog3RpTD+ALq8y6SYK8Tsnr0z9kU4Zdf8d9vrFm/qSCmvY2PBkGrH6bJR3jgGS9
	 /rV1hUljOQ2Do2RAJVvDJybZvJ1+5gSbgOaIXhfCympcoU57yJnoMjTp7qbPF21Mdvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789713377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cifhFfZ2n1KOqXXiwaw93sa2nYbp1IzQ/oYcbdBTCw8=;
	b=UeCmOmzB82/K0cBgIcAtyq8QHf+4tLuE1/krb92jfcmiA3Sq8Tcvi2hmp4kvVm+ToRvO
	 kJXHTkiWoCn+hVZOg5HVNSoje8wW9OjHMJkwiqGgG+0Vwf7BtR1Wbs3mu3vSxdhqZ0Rzi
	 LuApyr/OkfR8xxlLiPpCRb0H0CTVelpMbB9pK4d9klvV+r/36/9+UmINibBCGSF2xIaMh
	 ZsMR81SIo9W1pib9g6V53LWlnaGYAxqf7YuLguWtzRvQDyYCscPk1ffKgsHnJ+hpaT141
	 BiSCgUFY6FFKJtDdRGAegYAVc1tVU9hygvVW75+9mfL+lTpNU0prhBfJj7KmdnSgMyQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=0GegzE78;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789713377;
	bh=cifhFfZ2n1KOqXXiwaw93sa2nYbp1IzQ/oYcbdBTCw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qv3UD74x7k/CQXqAFf+2T1tZr301QoV4xERGd9MrxkzUOyqZEktv5qBARd+bt71ki
	 /Ub3A2rsv39clxIeQDPYUh1ZTQa4fHYTpEQlOfschMd7oL1U7h06rOtztb0lLFlIAj
	 0tR6LdHtn1RtOJC5BqQqeqRbJaoOeOrWnAfsz0rGEiqpkjBNkZ9C0aCRyUB1gfBWmI
	 gFmcJP0RkGXMJBsv0CvOyrguOpR0Xq4nBx4coLED/vWfzUxPAI5MUrZmZNQ8ejZYZa
	 oagiGEHgYd+9WASA7v7HEa9S73/Dpir3g1TgPdPHC1I9DGElfld3/7dVTsEqMtCvZ8
	 gYMXdk5vPc0mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D8FA811DE;
	Fri, 18 Sep 2026 06:36:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D06713D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 635B1811E4
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vFQado7hT0Bn for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:36:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4E164811C7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789713375;
 b=EZ/zaXGRW1oFPLQWFCFZYFW5L2/+Tur+90L1eSRpomDLulIXq1vex3Lpc7oMtVD5B/oZ
 zi+0WPhz1pQD5aAbGOWN3yqHd21n2wcv2PxGHD3/uig9IkbPqnD1yLAOc4KqPdSQcA6FC
 93KoRYcISKXKfOpUryJfnIAcuccCiwy5ED27/C2duajaQW0BjWGbHValBRd1Yg8aQ0jmB
 ii4LsoB5dHW0yKFkPJxWUc572g1i1ad0KLDLL9X35EYSqWvQhH77C6cUV5pROOlORGfTr
 m6Yz51Jdd7p5AZYwNpGwDpcb2hzDJQwwpdDlu3pNLgnXGYFrtjKooAKYok1/3kygjRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789713375;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=cifhFfZ2n1KOqXXiwaw93sa2nYbp1IzQ/oYcbdBTCw8=;
 b=XLLjwWf40r5qhHFNVlOV3t5dchmFuI8g+cd0aLAD9QH8Y1b7y52k+Cf5i8lNnEVVQT62
 BevUvW+qZiciQRe6qXIi6lDyu9A4RujX3UFjK/1Y40wJMhS97xykJoUq6pLJY7iP29e75
 DlAi2u7NF7kP1DJx8gW1OeIXVFzDPT1wEZobsjP76t2TpAItYSMz9SUYOmzTuAea6yXjW
 WfnkTWwtY4FlPk5+Wtx7zRDwfJKiQY1uNZ8v3RdY2oWk26bomzNkxmFUSNuC7Hj4hAlyD
 MUjCpcMZ9olOrBAJqLrM3nUTWpu16kIPbFWOb8ra/jBl6zGEia58S+1fCjYxUJ00q7Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=0GegzE78; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=0GegzE78
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E164811C7
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:14 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso2811065e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789713372; x=1790318172;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cifhFfZ2n1KOqXXiwaw93sa2nYbp1IzQ/oYcbdBTCw8=;
 b=0GegzE78Iu0/3DrV7JFkqnNBh53GrjjLWsrOw/UbY1IsqG17fCInFNBzbGOogF6mv7
 1+8tciP1i3ME9DuFHEgkcUAK3L8IGMZPIcew3137lXzN03C4151aR5lZKvwVo+t4bdlh
 mgIddUSJjVOzLB++D5Mp4v9GxsSkPAa+a+6jyFYF23ER3dfqSb/8OGQvGb0dyBPWrlVZ
 mizIR8ziH447rzno91ETxjPBbWbTySgyTtIklhu/x7DAT5ncUvr2knvr/RvVzALAiE0U
 KLbGDuO6J1srzFj1qYI9iwPi4Iu/bV6xOw3SiYuSa2Mzezqbl71y7q+Q7ea0NdURiBB9
 7h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713372; x=1790318172;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cifhFfZ2n1KOqXXiwaw93sa2nYbp1IzQ/oYcbdBTCw8=;
 b=Fv1idRuoztTL92nHXR7pl4958jSIgUP5v2SVXqRigmeNjejhTI53+s7SgxCPBZzz41
 hmtFarxdKD5/bsidsqItbyzjRcmOi6D2hga4yFoDv3zYlfIy1Bkpc9PCUBprIVsJbS1f
 MrNoNO1N/OkwoQ0lsuHunUwB4iMl3u23Wd0ZBLDeQwjDsE2PcfLwxZ1MSuzcb0UFbaRy
 3hC1HkxfC/nImG25yZO9A44uWMOD6hhGIfz8PeireE1n034jZwKh52jhR4DtJA2VthYk
 vSF4/6dMCEEiVIRAw1Na/KtLzjBZ9IEgSdKRzCxY15411wMzhb2XiMZXjRpiNSoQk1Pc
 jsmg==
X-Gm-Message-State: AFuF++lA8/txIDgaw7Gu6XikGAz2NVK/XMHRiBmAylCqO5q4gMiACY4U
 rxF6pRcFhlvUoyHr6/FtjleoC0bBeDvRsJjhT5IRY1Ao9CA+ZeWFldjItWQT4lIh/Mg=
X-Gm-Gg: AYBFou0cD1tWlrFf+2B61UNroDfjyZDwRKdBeyDQfYJL/UZMvoLJ6nnP21KOpAIFnhJ
 vxu5epXwJbLsW2Ky7it/EgeYxly6ErYQ4THkMxArAz5ni3eUouuS08VH1lCj8ctRiQ9zrSgSJOi
 dS5h/ZMSwNe9YlRMJljyjJ/iptPdTulcHNSTmH/DwZZ4eNBqzyUIJ6RgejYPXX8hKQiThNSnPj/
 OpvomGSpwaPFDTM9bR0jsdLciG/SBkNIzl5LIe0gylgl6jMINZIndQFfLq+i0WnPU1W8EZSw84J
 +BaW5NDugR5FfXHKDbIx0tzFroresXxIJjay3xWK9vFLZqoSIssO0px+Ptsx+0FteBK31d/EMhP
 qpLjVr2ayy+my44XGV5OqlwKIM/0jovPTRXQMBX+qUxJGMEO0h9d6gDIBBj9VXo7J0grIKuqM+R
 YJq+A8fbv5RdaZcS1Q50AFeIZfgVnL1BSeoStGq28gz1+IxdTfCmSB9aO5dWNvdJMupli94Od9v
 HfQtkCY0qrkJ6b9xq/cyMkpG4BgJmT+VXYCnOJKVO4UWNSFONo=
X-Received: by 2002:a05:600c:6995:b0:49c:dadb:18a7 with SMTP id
 5b1f17b1804b1-49fc56873a2mr13231575e9.10.1789713372413; 
 Thu, 17 Sep 2026 23:36:12 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cba562sm17725845e9.2.2026.09.17.23.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:36:12 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 10:35:44 +0400
Subject: [PATCH v2 03/10] scsi: size a well known unit from the unit it
 stands in for
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ufs-spl-boot-wlu-v2-3-8a63e372bb6e@flipper.net>
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Denis Mukhin <dmukhin@ford.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5594; i=alchark@flipper.net;
 h=from:subject:message-id; bh=quf8/Ab8zqIKA3dKfhe1j75hTZRg0aZYhvxNHKG8cxQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStuX3RJuZ1UML8nsbdUb6bJKKKZ60pfWJ5p3+Gc4JfG
 f+jzjsNHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1GVuGX8wqm7UTdh7e6m7ruW5+3U79crcfb+K1eb2uS9WwKtzO0GH4X3bxdSF
 Xbx2znNMbtS2XDmlP2TMlZNa8WP7SHiH7+A42RgA=
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

A well known unit can read and write fine while refusing READ CAPACITY,
because it presents another unit's medium rather than one of its own. The
scan wrote such a unit off, since it has no geometry to build a block
device from.

Ask the controller which unit it currently presents and take the geometry
from there, leaving the block device addressed by the well known unit so
that the device keeps resolving where a request lands.

Note that in cases where this matters (e.g. UFS boot W-LU) the physical
underlying units should anyway have identical geometry to be usable in
the UFS A/B boot scheme, so switching the active unit should not affect
the geometry for real-world use.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/scsi/scsi-uclass.c | 10 ++++++++++
 drivers/scsi/scsi.c        | 31 +++++++++++++++++++++++++------
 include/scsi.h             | 25 +++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 54afac6eaf51..ca6a16cd8206 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -50,6 +50,16 @@ int scsi_get_blk_by_uuid(const char *uuid,
 	return -ENODEV;
 }
 
+int scsi_wlun_alias(struct udevice *dev, int lun)
+{
+	struct scsi_ops *ops = scsi_get_ops(dev);
+
+	if (!ops->wlun_alias)
+		return -ENOSYS;
+
+	return ops->wlun_alias(dev, lun);
+}
+
 int scsi_bus_reset(struct udevice *dev)
 {
 	struct scsi_ops *ops = scsi_get_ops(dev);
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index aa7f9f1004d0..a60843e505ea 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -504,6 +504,7 @@ static bool scsi_unit_attention(struct scsi_cmd *pccb)
  *
  * @target: target id
  * @lun: target lun
+ * @wlun: true if this is a well known unit
  * @dev_desc: block device description
  *
  * The scsi_detect_dev detects and fills a dev_desc structure when the device is
@@ -511,7 +512,7 @@ static bool scsi_unit_attention(struct scsi_cmd *pccb)
  *
  * Return: 0 on success, error value otherwise
  */
-static int scsi_detect_dev(struct udevice *dev, int target, int lun,
+static int scsi_detect_dev(struct udevice *dev, int target, int lun, bool wlun,
 			   struct blk_desc *dev_desc)
 {
 	unsigned char perq, modi;
@@ -584,8 +585,25 @@ static int scsi_detect_dev(struct udevice *dev, int target, int lun,
 		return -EINVAL;
 	}
 	if (scsi_read_capacity(dev, pccb, &capacity, &blksz)) {
-		scsi_print_error(pccb);
-		return -EINVAL;
+		int alias = wlun ? scsi_wlun_alias(dev, lun) : -ENOENT;
+
+		/*
+		 * A well known unit reads and writes fine while declining to
+		 * describe a medium of its own, so take the geometry from the
+		 * unit whose medium it presents.
+		 */
+		if (alias < 0) {
+			scsi_print_error(pccb);
+			return -EINVAL;
+		}
+
+		pccb->lun = alias;
+		err = scsi_read_capacity(dev, pccb, &capacity, &blksz);
+		pccb->lun = lun;
+		if (err) {
+			scsi_print_error(pccb);
+			return -EINVAL;
+		}
 	}
 	dev_desc->lba = capacity;
 	dev_desc->blksz = blksz;
@@ -599,7 +617,8 @@ removable:
  * (re)-scan the scsi bus and reports scsi device info
  * to the user if mode = 1
  */
-static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool verbose)
+static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool wlun,
+			    bool verbose)
 {
 	int ret;
 	struct udevice *bdev;
@@ -612,7 +631,7 @@ static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool verbose)
 	 * size, number of blocks) and other parameters (ids, type, ...)
 	 */
 	scsi_init_dev_desc_priv(&bd);
-	if (scsi_detect_dev(dev, id, lun, &bd))
+	if (scsi_detect_dev(dev, id, lun, wlun, &bd))
 		return -ENODEV;
 
 	/*
@@ -677,7 +696,7 @@ int scsi_scan_dev(struct udevice *dev, bool verbose)
 
 	for (i = 0; i < uc_plat->max_id; i++)
 		for (lun = 0; lun < uc_plat->max_lun; lun++)
-			do_scsi_scan_one(dev, i, lun, verbose);
+			do_scsi_scan_one(dev, i, lun, false, verbose);
 
 	return 0;
 }
diff --git a/include/scsi.h b/include/scsi.h
index 2520a8b8fe63..72fb6e4bd90d 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -296,6 +296,21 @@ struct scsi_ops {
 	 */
 	int (*bus_reset)(struct udevice *dev);
 
+	/**
+	 * wlun_alias() - find the unit a well known unit stands in for
+	 *
+	 * A well known unit may read and write fine while declining to
+	 * describe a medium of its own. This optional callback reports the
+	 * ordinary unit whose medium it currently presents, so that a caller
+	 * can take the geometry from there. Which unit that is may change over
+	 * the life of the device, so it is resolved on each scan.
+	 *
+	 * @dev:	SCSI bus
+	 * @lun:	Well known unit to resolve
+	 * @return LUN it stands in for, -ve if it stands in for nothing
+	 */
+	int (*wlun_alias)(struct udevice *dev, int lun);
+
 #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
 	/**
 	 * buffer_aligned() - test memory alignment of block operation buffer
@@ -336,6 +351,16 @@ int scsi_exec(struct udevice *dev, struct scsi_cmd *cmd);
  */
 int scsi_bus_reset(struct udevice *dev);
 
+/**
+ * scsi_wlun_alias() - Find the unit a well known unit stands in for
+ *
+ * @dev:	SCSI bus
+ * @lun:	Well known unit to resolve
+ * Return: LUN it stands in for, -ve if it stands in for nothing or the
+ *	   controller cannot tell
+ */
+int scsi_wlun_alias(struct udevice *dev, int lun);
+
 /**
  * scsi_scan() - Scan all SCSI controllers for available devices
  *

-- 
2.55.0

