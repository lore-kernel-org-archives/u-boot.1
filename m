Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0DDC61DD6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 15:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4282660757;
	Tue,  1 Sep 2026 15:34:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s_tqaL9-M9VL; Tue,  1 Sep 2026 15:34:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788276892;
	bh=qBI51anOU3PE1zcxWfr3a/9u1eJO0cW3wVexyyClQCo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zN0aG1Scg8lUPLAzmCifjYihVy+D5tLRsDhMiPpsNwrkCNnR9rknBkXGSCXAVKGX8
	 hXrhnoiqXdHy7p+CWviKkNp7luyzVHkTQuUhdO/mWiwXdJvywNo2rcy+vROHTQLFOy
	 kLNxQPP93Cjr1HE3Cm4zHoBfkmzxANFgml3M0eboZqSAtfwhqsAk+HYUETC0uKllNm
	 Y/J2oX1zzeMCRkUoGlO9yPpilS6LbehHeGs7gAB5aD66X3mGs6GY43o+WFyQj0VR+G
	 5401yu9UJzqlMvoMZD5S18W6cY9LeyHQv4CHjbttwjE4WFAIT4VsoWnkdrekh+glFb
	 06FsZk7ZUXMQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF2E3606E5;
	Tue,  1 Sep 2026 15:34:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E4913127
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 15:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB07B80D09
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 15:34:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vAHyg7Zu3xYF for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 15:34:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ztI1bHtb
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC01980A55
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 15:34:47 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-938cd95b06eso113831585a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788276887; x=1788881687;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qBI51anOU3PE1zcxWfr3a/9u1eJO0cW3wVexyyClQCo=;
 b=ztI1bHtb1dMHlAfeXPIDzPogy+feLq8VMfcbQ1zmbfKBEQo1dwc068T0wx2u4QrvS7
 Bkopeu0/RD6UX9dUKc0Y/qHw6RTf/lXMlEaGJUY8lwPRIcDgJrwlXfLG4qRWnNBsHz8k
 YUk4HWD/JE3XMWBTKA1VbypAo5PVqfG4PtkSrJ1lNccdN8y0covdIuVyuCKH7y2DK1Qj
 liLrlO5Ml5QGxNWxFmYU1LwpxcJMa4dpRCsfhQezN6MLDy8dX/IJCj5NdSCL93T8SIdi
 vNkIMqHSQ2Ii0QrPfPC8dcrNG8ZUiY6ZdnJ0Ai9aNneGdX/wG8wj4fSx7YfynrmXIheh
 1mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788276887; x=1788881687;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qBI51anOU3PE1zcxWfr3a/9u1eJO0cW3wVexyyClQCo=;
 b=AmA3dGpjuBbOE6dceFpHQs21DgtjtT8ZQFAbWq0nL/ArzZHwAxg+Y1nmxHCHCaFJP3
 nCzN/Dcew9g46FwgIoWunvp41us7sZTnxgarACtItc1BOb7cjccWWAfWhtLTqtiqTWKG
 ExEIYZQPvTSVsR9ubr69Jphyo9NRhCexOioHjZbVQS6u6hDhGyWxqefG8EVOxz8KrZM2
 lnPVKniLUeBbj5XpRnE8qpBssXSWxYl36Viwt1D3vCIFKhJeu/Photwgs8H4f4QSiKW1
 vUQxpcgf5MUE9kkXIUIRFwslC5v/pBdut84+bHx90TPqvf3Xw/bf/iBAOdgf9eD/0Jkg
 KytQ==
X-Gm-Message-State: AFuF++n3dNthIL2OXkshIweHrVOSPXB4pshUAoALh+Ql66zRyXQkcSBz
 OcGwaoKlKMWDF+eb36AnjNmE04DeKdl/n6OXkp2kKnblRzuhQ7ZpcPaKeMRzxe4BfuT5ErDOpKl
 5EpMZ
X-Gm-Gg: AR+sD10cFnT/jHfd9Et6FdWnNP7IpDscdFi6W6h+slPkaMbQV9YEdEMpvsJYXimTv5i
 fhHv9HXAfwPI+YzwSCytlnG/Vty8dyrEOb32XXGY0NHClysVKcq+21MOSEbBCLaK3yRAB3QUGGA
 10X41Q0SFRrBA5u9PE8xSHdchR1o85I5f6K8BYa9SXhbNdmb1EJEJjGvCvcSw5PY8HC8MmL1iRI
 V5rfLZuDevF+8QTrkufQPty7QOnSgm2yPPWhRJsOJ1i1b1PiHgwVQ2fhDUjgOYvol4oMy4DJXEe
 IYbJrqJAMi9o0/yKN/gmb5z7UaIsOzl1oZq6AdNwFEo1nyaV0EtEWe1aLAYONjs2kmaN00wWSRg
 95SV2UwuMjcxZ/PgeWnSvtWQm4NGbmSV7eSsYqfBegKT9nAhK8/4SuC1CCET0OVFS8OKXuuTijs
 OmFyk2Qvdlk2kjnvTMEUn5ZBc3Lvg8i/08YTHkPdlDX4G86v/P4D0vRQ6qozEDCNQbxmfYT1JNg
 pjLe1bfSZf27G13f94EcHU/9xyALOAbzzFgC0m/7JbIyNQC6eQk/j1I
X-Received: by 2002:a05:620a:5d92:b0:92e:fed1:beba with SMTP id
 af79cd13be357-9394bbd5cfemr646785585a.3.1788276886553; 
 Tue, 01 Sep 2026 08:34:46 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9391740bb62sm1071452585a.43.2026.09.01.08.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 08:34:45 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Tue, 01 Sep 2026 11:34:41 -0400
Subject: [PATCH] dfu: mtd: probe before get_mtd_device_nm()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-rzn1-2026-10-mtd-v1-1-516e2177cd20@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJDwlmoC/yXMQQ5AMBBA0avIrE0ylWhwFbGgBiNR0iJC3F2xf
 Iv/L/DshD0U0QWOd/Ey2wAVR2CG2vaM0gZDQommnBS60yp8hYpwWlvMUk067RpDZCBki+NOjm9
 ZVr/91oxs1vcD9/0AyUvZMHQAAAA=
X-Change-ID: 20260901-rzn1-2026-10-mtd-856065fbc00c
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1788276885; l=1538;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=uJZFgPNyYLuRa0lO+CU8FcQseFTJ+pE3wLK46pdWn58=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QK9wrBofYy1KHgGLLGdWkMjNDHPxCyNRqfhV3RvkzJ9QgIobQBHliXqjMxKs/Za8Md2MDVVrNTN
 nUf7t00EBCgs=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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

Parsing dfu_alt_info depends on matching MTD device names, so it is
necessary for all MTD devices to be probed first. Move the existing
call to mtd_probe_devices() accordingly.

This fixes a failure of the "dfu usb" command that occurs when:
- dfu_alt_info contains SF devices listed as via MTD
- there is no persistent environment stored in SF
- "sf probe" has not been executed prior to "dfu usb"

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/dfu/dfu_mtd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dfu/dfu_mtd.c b/drivers/dfu/dfu_mtd.c
index c36ac09189f..da19bc21492 100644
--- a/drivers/dfu/dfu_mtd.c
+++ b/drivers/dfu/dfu_mtd.c
@@ -289,6 +289,9 @@ int dfu_fill_entity_mtd(struct dfu_entity *dfu, char *devstr, char **argv, int a
 	struct mtd_info *mtd;
 	int part;
 
+	/* register partitions with MTDIDS/MTDPARTS or OF fallback */
+	mtd_probe_devices();
+
 	mtd = get_mtd_device_nm(devstr);
 	if (IS_ERR_OR_NULL(mtd))
 		return -ENODEV;
@@ -324,9 +327,6 @@ int dfu_fill_entity_mtd(struct dfu_entity *dfu, char *devstr, char **argv, int a
 		if (*s)
 			return -EINVAL;
 
-		/* register partitions with MTDIDS/MTDPARTS or OF fallback */
-		mtd_probe_devices();
-
 		partnum = 0;
 		list_for_each_entry(partition, &mtd->partitions, node) {
 			partnum++;

---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
change-id: 20260901-rzn1-2026-10-mtd-856065fbc00c

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

