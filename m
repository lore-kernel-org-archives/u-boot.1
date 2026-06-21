Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8BACD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 15:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 998A084119;
	Sun, 21 Jun 2026 17:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k+G5Vhsr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08C3C8499C; Sun, 21 Jun 2026 12:29:03 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA1784873
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 12:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dayalancse@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c07ea058c1aso544479166b.2
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 03:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782037740; cv=none;
 d=google.com; s=arc-20240605;
 b=baAMckLVvLT8By1KyV3EVLQEM1C65Yakfy2JRU+YXKMFmjko6jHWvd9vKljt/4KWsR
 QOJIW/7gANqbqHw1zFaZX1FcEcUzs3dK0pzU4m7YEpsW45p6j0vL1uyRNw+tvaRMrGmn
 H9xxTHaG+F/5EG7G4nF2yn0GUFLF70Ps4nz7AypWDI/a3I+XqNIvlpk2+y5qn9ZArOM/
 r4ZBmiypHg39DaFEhzaQu4kZxhAvKOyy2H8f++ydVx2v2xWw6h0zQjuxvag1/KPnpcy5
 gNe3Rf1rvFxWe18parJ5N5BtXYQyebse6T4hGGlLax2p1vYm7bulnH/xjV4Zb5f5Pnc7
 Symg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=0zn/J0V143cnogOdtwosIK0ZZYbeqU1kJ6FDNCKqJkU=;
 fh=iD0H1zGIvA+qt6AJweV011prSwEpMYd5z6I7jCXfi7k=;
 b=koQYkFoQ3ZunZXm4AvnwZ9X/juYKAR4G1p4rRfQFXAoQZ/srt0yrgxscwE9qCDxwko
 BUoP3mpZxcog9MAuNJNdNRxWJWsNp528SbKb89etcQo93YAUR2gRKueoM/cFfQ47Fchi
 dO3zlWpK2tPsmUVTo57i/Gw4POKnv9fTgCkLw5nrjUL2RHkFeib5ZfONE/D0lyjRI1oN
 ToBJJG3Q2/jL9C1BWllZNZal7cRVLq9n8/RuW9bYsb5XsM40cGJfWg1UGILh7R34aGsb
 DVKjPknQRLCjBTqDpssDcyKgKyEY1ljcnuy+klRdXLSVqjW1l8yvl8g2XeBntQNcfmLK
 G7hQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782037740; x=1782642540; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0zn/J0V143cnogOdtwosIK0ZZYbeqU1kJ6FDNCKqJkU=;
 b=k+G5Vhsr+J54RaG7H4CitFhOEnu1IZC6QWTGpUnnNdZ+2vJA6W/lkQG/i+YJnK2d90
 +fRWrpxwVD5BfQT6u0gAUsQiIdY/AdQKsQ28Tju/wJpy+G5qydxVd/yJ1dFcShotvUm4
 f+pd9Kh32ViGZ5dp+OPfppDkJcoALlq56GXIan9Qz0nseU0C9jpKR+zcf9yZ0yXcGObP
 5TzaNzcP50ePqJyWz786m7sXBBw6dZz3X4tJbOhfXveSQFOG/PBQF0CHkjUUmnFJHNKe
 uEyHwC+9X5vKzG07Q9f9IcSLO3kIr3SIkBE8pLrH3gA2N3UMoSkBLAgF/QlKuHYeJzMv
 VBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782037740; x=1782642540;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0zn/J0V143cnogOdtwosIK0ZZYbeqU1kJ6FDNCKqJkU=;
 b=NIbXzYbMldRABrry24q7wEgZTVA/C8ZVNx09Jk+zf7O70eqDk/ymO/F69AU/yCEFjd
 UygRyRW4rpXznn0YQ1w+uMhDLTa4wf4SUa7PCxGY2D7wRYK7vTjZZoEbGkOm/iod6E2W
 o97JnORuq6SG0KmnDXyPI6ieY078L2tUYs1raOiZkfmI3Yl08OKtecJR8RKfqTje7EbO
 pj9fUpkA0QZE+gLn8YuuILQo7knVeBm7tHwHQ4XE2b95G0ePHm7zfPxbCVW3VMTqJYbQ
 TaXujJ0vhvK8ypSRXdwepxxzivYLxaLe1FW1EeXK8UuDXGb0cBfAtP63/K0LEFe+t5au
 EX0A==
X-Gm-Message-State: AOJu0YxGj+gzYZ7auNpEN1l5Cl7dPXBazCeRGhDBtP/BezT3g1tNsLX0
 e8EFfvmT+QULbbwlQ6e0VAg/lDfxgjCp2KT4hK1a85LGuMGfi4HGvA7ywo9MBScK1v0kbMZC8qn
 4Cc9DcXHHCkYnWe0zIu+bbjH2K/Sq2L2yyk36
X-Gm-Gg: AfdE7cm9BtX9Qb2GS+BCCfnsJMy+y6zEO6jtJwpTqboPP8tmMtXfSJYXRos1ntxUAMv
 fOThe+4TAdToMXsRgXKc+zqctWhiQKnY6P27kPmHONSJkCsp8cMG/AgyfN5aiJTrGuD7/STXijN
 A8bzaWwWtu+CDQCTAP2RRbcLtV960kPHbbRIa+Irk7G16EtJXp/kHh5q0AlbiozfIE4EvAJwjQ/
 AXd+y3yi41zl5tRR5rcTd+AfyF98wbmNoRXHRxOlxY/EnIB6TRJeypVAPU28TRNQT16N9stTjQg
 l5MKQDViYjWGmUoTWE6ZEcIELkm+9lrP5W6ioidD0Q==
X-Received: by 2002:a17:906:518f:10b0:c0a:5acd:ecc4 with SMTP id
 a640c23a62f3a-c0a5ace09e2mr328484366b.36.1782037739977; Sun, 21 Jun 2026
 03:28:59 -0700 (PDT)
MIME-Version: 1.0
From: Deenadayalan K <dayalancse@gmail.com>
Date: Sun, 21 Jun 2026 15:58:47 +0530
X-Gm-Features: AVVi8Cd7hwwNImmBVYuJ0Eb7jRxkm7zuIsBUYPZhrHfYH26jUPebJC5qXOewMj4
Message-ID: <CALENcY8ruCKbtyphfmpwPmcCfwjo8_72Nh9J6Qq74WoUxfVPrw@mail.gmail.com>
Subject: [PATCH] UFS error handling for reject upiu.
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com, 
 trini@konsulko.com, marek.vasut+renesas@mailbox.org, padmarao.begari@amd.com, 
 michal.simek@amd.com, macpaul.lin@mediatek.com, 
 Deenadayalan K <dayalancse@gmail.com>, jstephan@baylibre.com
X-Mailman-Approved-At: Sun, 21 Jun 2026 17:24:44 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From 8ce84d4e1e9c34d7b36d40e5e5678da52070af02 Mon Sep 17 00:00:00 2001
From: Deenadayalan K <dayalancse@gmail.com>
Date: Sun, 21 Jun 2026 15:15:16 +0530
Subject: [PATCH] UFS error handling for reject upiu.

ufshcd_handle_reject_upiu - Handle and display REJECT UPIU fields

Per UFS spec, the device sends a REJECT UPIU when it
receives a UPIU with an invalid Transaction Type. This function extracts
and displays the REJECT UPIU header fields for diagnostics.

task tag appears default 0 for UPIUs, it is a unique id for each UPIU
If UFS host controller gets a reject upiu for the request UPIU then
it does make sense to reattempt to issue the same request UPIU again
a possible scenario where UFS device is not supporting though it is a valid
transaction type.

Signed-off-by: Deenadayalan K <dayalancse@gmail.com>
---
 drivers/ufs/ufs-uclass.c | 60 ++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6a51f337e47..fcafebd5203 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1020,6 +1020,56 @@ static int ufshcd_copy_query_response(struct ufs_hba
*hba)
  return 0;
 }

+/**
+ * ufshcd_handle_reject_upiu - Handle and display REJECT UPIU fields
+ *
+ * Per UFS spec, the device sends a REJECT UPIU when it
+ * receives a UPIU with an invalid Transaction Type. This function extracts
+ * and displays the REJECT UPIU header fields for diagnostics.
+ */
+static int ufshcd_handle_reject_upiu(struct ufs_hba *hba)
+{
+ u32 dword_0 = be32_to_cpu(hba->ucd_rsp_ptr->header.dword_0);
+ u32 dword_1 = be32_to_cpu(hba->ucd_rsp_ptr->header.dword_1);
+ u8 *rsp = (u8 *)&hba->ucd_rsp_ptr->header;
+ u8 trans_type = (dword_0 >> 24) & 0xFF;
+ u8 hd = (trans_type >> 7) & 0x1;
+ u8 dd = (trans_type >> 6) & 0x1;
+ u8 flags = (dword_0 >> 16) & 0xFF;
+ u8 lun = (dword_0 >> 8) & 0xFF;
+ u8 task_tag = dword_0 & 0xFF;
+ u8 iid = (dword_1 >> 24) & 0x0F;
+ u8 ext_iid = (dword_1 >> 20) & 0x0F;
+ u8 response = (dword_1 >> 8) & 0xFF;
+ u8 basic_hdr_status = rsp[12];
+ u8 e2e_status = rsp[14];
+
+ dev_err(hba->dev, "%s: Reject UPIU: LUN=0x%02x Task Tag=0x%02x IID=0x%x
EXT_IID=0x%x Response=0x%02x Basic Header Status=0x%02x E2E Status=0x%02x",
+ __func__, lun, task_tag, iid, ext_iid, response, basic_hdr_status,
e2e_status);
+
+ if (response != 0x01)
+ dev_warn(hba->dev, "Reject UPIU: Unexpected Response=0x%02x (expected
0x01 Target Failure)\n",
+ response);
+
+ if (hd && (e2e_status & BIT(0)))
+ dev_err(hba->dev, "Reject UPIU: Header E2ECRC error detected (HD=1, E2E
Status bit0=1)\n");
+
+ if (dd && (e2e_status & BIT(1)))
+ dev_err(hba->dev, "Reject UPIU: Data E2ECRC error detected (DD=1, E2E
Status bit1=1)\n");
+
+ if (!hd && !dd && (e2e_status & (BIT(0) | BIT(1))))
+ dev_warn(hba->dev, "Reject UPIU: Unexpected E2E Status=0x%02x when CRC is
disabled (HD=0, DD=0)\n",
+ e2e_status);
+
+  /* task tag appears default 0 for UPIUs, it is a unique id for each UPIU
+   * If UFS host controller gets a reject upiu for the request UPIU then
+   * it does make sense to reattempt to issue the same request UPIU again
+   * a possible scenario where UFS device is not supporting though it is a
valid
+   * transaction type.
+   */
+ return -EPERM;
+}
+
 /**
  * ufshcd_exec_dev_cmd - API for sending device management requests
  */
@@ -1053,10 +1103,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
enum dev_cmd_type cmd_type,
  err = ufshcd_copy_query_response(hba);
  break;
  case UPIU_TRANSACTION_REJECT_UPIU:
- /* TODO: handle Reject UPIU Response */
- err = -EPERM;
- dev_err(hba->dev, "%s: Reject UPIU not fully implemented\n",
- __func__);
+ err = ufshcd_handle_reject_upiu(hba);
  break;
  default:
  err = -EINVAL;
@@ -1687,10 +1734,7 @@ static int ufs_scsi_exec(struct udevice *scsi_dev,
struct scsi_cmd *pccb)

  break;
  case UPIU_TRANSACTION_REJECT_UPIU:
- /* TODO: handle Reject UPIU Response */
- dev_err(hba->dev,
- "Reject UPIU not fully implemented\n");
- return -EINVAL;
+ return ufshcd_handle_reject_upiu(hba);
  default:
  dev_err(hba->dev,
  "Unexpected request response code = %x\n",
