Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1FDC982CC
	for <u-boot@archiver.kernel.org>; Sat, 19 Sep 2026 11:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34C6A606AE;
	Sat, 19 Sep 2026 11:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZOs1Ago7j59; Sat, 19 Sep 2026 11:13:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 417A46068A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789816404;
	b=VGU3D/csYwH/cRAjDt8cdkJKU5769YOG3dF2IrKCRcfwqupMNsRsODaOxUmU+ix7/g5z
	 w+dmXmHhdV77gOZjEMpysdNPCuFew/YfsISGYUoPThL1s7y3jcnD3UEhi829skiYjLLr9
	 hZOY3n8B/4lztG13u0B7S2Cw3DVmuwjL8L6CgSQw7nHtETkbMlBTFadXe/kinzLl2vYBG
	 r190CE6OPqOiNxWJb1nRKE8LuyMoTLAf6BIYIMgFum2av76Wl1InvNOxxtKq7WET/glJS
	 vGBX3vLWwNUwRtfNpyFeD2GijFFe71wUpIJKZ4TOSIOreiknQ6KkoOHtfVAX6WtS4dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789816404;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U378zTHZRoEGWuVLeu9ymsj8YlRQ72zyndOz6VAjpoo=;
	b=D9GdMyzyaPiRI73ibhuK9vtDSR28hwFx4z3m+QiAXjJFr7orSgR67w643kyXcCH0GqdO
	 lViM/iJDHO+o/NbwFGJ3u5idXNKE56fMtECXDx+23LhdHoCALmp4PL3kIhyEc2W9u+trU
	 bvxyPmNGUatE72j7519lwW7f5h5/t9hEM4xsQ4+/GaVj8xhSidSEQdjD+aoS9bvbaK/NI
	 PkToGibeExasKN8CTLjDWvaV91VTYXfV7k117a2RNCyMtrPVAEKU//sbA1XZg7oxheZsl
	 gkSdH96hwxrdFCHFX62xFabrxOgxiD8EIKAjXsHJuposm00/gw6vEuDFD80UiK4/1xg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N0+hfgo5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789816404;
	bh=U378zTHZRoEGWuVLeu9ymsj8YlRQ72zyndOz6VAjpoo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oz60I3d6SDOSZJXi35SQJRrRxV1IaX7dW/sUo1YiHFAO6aneDy5vS94QgpB6TRLBF
	 9yNuacq9WUQVP/rLffrP81S1ptQ1BVH/U0rohZIOzF9PbGZkmAOKRHg+wPkREn6Fqs
	 28Herwbe/5ZAgSE7Y7mRH/V38zxaiXV26QjCFAXl865No5P/qRFU6iC404EHiuDR0Z
	 UXViqk7tsnigllUnTInxEfI51u55Uo3dq/neH3Gi1Ctv2SIN5YHgroUwu7wJigj5Hs
	 wGtH1IwhYCP0JknqAjsv+PfhoF7TunACvVAGs6WxcQE7aOQvKlZVJuirU898gj7Vjp
	 xcQ5ZhzSF7XTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 417A46068A;
	Sat, 19 Sep 2026 11:13:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90EC5793
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 11:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 821096068A
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 11:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BBDWLSPW4GLE for <u-boot@lists.u-boot-project.org>;
 Sat, 19 Sep 2026 11:13:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A38566067A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::23"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789816401;
 b=cBXl9zc6SvmzmaIQthCSZK5AKs3LVNJ8Mty9+j/aslkTCfz2z2vtT5VtaIXhbyRnjiZI
 Cf1f2uHW2n58Tf+6prhWfqIJVdfr13y0I+H0XRFt/ZdMg2gqRGpWXvYu4d8uzts4E9JKO
 tFKa6OSsuJmPG65JZq0a9eAC23sNQ+d2pu9V4tNHRUZaamWW+O77GOCVccYtXmjY6oMl3
 SnEQOFDhYSpm6LYrL6OB0E2S3CMQimJns4Q/9T7Pf1Dbf3ddm28bbsOHLWWTdlNBtSXhr
 Qt0tUX8oGT3a9S16NU5bj84ZdOLj5yD4ZIGSrkUsfZwmAPo384cqXVYZdTyyygg3p2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789816401;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=U378zTHZRoEGWuVLeu9ymsj8YlRQ72zyndOz6VAjpoo=;
 b=f2CdJVhraIkmzxOnXbGfPUH/QH/xlgWSMCIXY1fT20cTajjgsMw1TCsQBTaKjBR4BxxG
 7QtZBDBzUKq/K+W8w23iiBDJio70d6d6uqRnUVMIysQuCIpM0achBwXjWDFvXHkZTJF4T
 AUBJl4MvzvuAjyNnU0QgVZXcfuZNLtSLHk066j/yibVOmsIXE4aUZqtq2m6+5Puw2bo7l
 AioP67T556kv8nimyijOgQ8n9Tz9aTBjS3kWIgnPQF3LnfzJlcfWrIiQgMtrpikZNx6px
 P83k5B/iaJ+/NPTfSLoeGBIA7wqfpLFPPD7rBwG865mz5kzNObs9yr+VHafjasHrKWA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=N0+hfgo5; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::23"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::23; helo=mail-pj2-x23.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=N0+hfgo5
Received: from mail-pj2-x23.google.com (mail-pj2-x23.google.com
 [IPv6:2607:f8b0:4864:39::23])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A38566067A
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 11:13:21 +0000 (UTC)
Received: by mail-pj2-x23.google.com with SMTP id
 d9443c01a7336-2dd53691be5so14662595ad.1
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 04:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789816400; x=1790421200;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U378zTHZRoEGWuVLeu9ymsj8YlRQ72zyndOz6VAjpoo=;
 b=N0+hfgo5jdEniGM9mk9Ya0kwE2TMN9TTeqY8PoaI0ts4XDTCuaq6aYzx4lbz+JlKsn
 2pZQa+q2JRKzJ/Urh/jQ2BdUKpCWGWAhgBHo/8GoXh43140tVHSkPQBp2x7RBPZXlpPb
 1fPWhOOVvxg6H8hr0eDTqw6waHaAXOg2wwGObGNwvtQcCjj7rSi+dd5+cvxDirAQxMrP
 oGBgT2XMZKVCU7skrdGdp8TwTqkhlhO0HwZ+uil/GDUH3mzChVX0HHMasRnqmJ5W8q4A
 RfzyrqsD8SeJbJ4s+gM1/TIQmOku7RU8mps9vFG5itttxghbn/j+cPOooVY907/EZ7wA
 9txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789816400; x=1790421200;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=U378zTHZRoEGWuVLeu9ymsj8YlRQ72zyndOz6VAjpoo=;
 b=0YVqhiHZ1KHsHj1ut7wpy/d1c2dRVYyG6wt1Nwr61f7W1AsCI25UkYS+Wmt4WatPSc
 IRO9cXukCFOyaYgcaZs0WPXW4pAu1yjk3rWLjZEmv1jDE4wXCbFaJupVX20bIpd4bzR+
 QAA6G4JTYTcE7Ea86uYd7JZ2qaPAo5FDT2mEbwdy5u7mDlr5wcg2umTzgNTJsnJ6iUTn
 V5V0Ocg8ixCyGK/46WgcdFKG2VbIYrg2egH7M7XolptXBeAEFOp9LWzx8m3hAbdMpiTJ
 yMG+/0yv484M43EDkEMPoQ6SGMFL9//Zf2ndgWODZFZJMFNZBBl/9azXGv0kUmvuEDOU
 gVCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZ0tpr+YNlnv2uv1CR+snn6uV1x9z2nkt7g90fcnNpd4/tmQePlHhgF1eQ4NC+xl7DAxXcCFo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nzIJ0Gds/3vzNolQqs36uVxOYSAGpq3BxwYFsvwb6z8mD7+P3E
 ZYmws6be1kl752Q92aaHcR+G3FT8jEUTNQ0OkTdjc0iUEdBjyPD9MyVj
X-Gm-Gg: AYBFou3EPglQpJbkI/vKUKOlkmX1mzcCv0i27aM3J2yE6c3IeQE9Ih+H0TKeUx7IrB+
 I9vRHrXzG7d0YE38fUn8EVykomNGRrWsX3e10MenTNFyGSGUtlo55bYPHbzqNb6rYRl87RjJ6Lb
 A/zeItZa6o74NGYbi1AG7Am0cxcw+zUBNLMs1wLIcLMHuJpuPZeIiJHctZh+uVRtWQMfB7c9oPU
 CdiD5l7/qUa87RQL61VxaGgrj+f9mhnvEtVqlJRWrRGFAdykPeS1GB2kA4oeBD9CCbRIO8qAXZC
 flmvW2P4P27CdstuP+uIiBQ45wHgJMPNDCQB1jMfBn8t5IfM2eVSmDibgD3pHv+XjmZgz1NQY6u
 Q27ykpYRud/Cy4hGq5rKvcj07nyhGr7fT2oup4v39Gm1qgGQ3LRfcVAqYaUZfQGr3q50GOr/B/V
 V51rvQfu2n5dAxz9/qjVa1mryeVg4mBmlmHzULBkWO1lWhL0aB5X/K+X5tVIObIoGPHmuA/fifa
 w==
X-Received: by 2002:a17:902:d54a:b0:2ca:e19c:97b with SMTP id
 d9443c01a7336-2ddb1aca4d5mr105749075ad.5.1789816400427; 
 Sat, 19 Sep 2026 04:13:20 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7025:d9d5:b15d:b2d4:30ae:b124])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddc1788da5sm9046495ad.24.2026.09.19.04.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 04:13:19 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Sat, 19 Sep 2026 18:13:09 +0700
Subject: [PATCH] usb: host: ehci-msm: treat VBUS as valid for extcon
 controllers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-b4-msm-usb-extcon-fix-v1-1-25211bd65b4a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0Q5EMBCF4VeRuTaJWumqVxEXWsOOREkHkYh33
 +LyO8n5TxAKTAJVckKgnYVnH6HSBNyv9QMhd9GQZ7nOjPqiLXCSCTexSMfqZo89H9jqwihbfnT
 fGYjfJVCcn27dvJbNjuTWOwbX9QfgmOK9eQAAAA==
X-Change-ID: 20260917-b4-msm-usb-extcon-fix-a6491b836fd9
To: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2
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

On Linux, controller nodes with an extcon property delegate VBUS
detection to an extcon device instead of the PHY. This is typically
done on boards where VBUS is wired to external circuitry (e.g. a
charging IC) that the PHY cannot itself observe, so the PHY's VBUS
comparator can't be trusted for these nodes.

For such nodes, treat VBUS as always valid after controller reset,
matching Linux's own reset handling [1]. This is detected by checking
for the presence of the "extcon" property on the controller's
devicetree node.

Link: https://github.com/torvalds/linux/blob/9b87fdc9af2fbfcdb5c24a64139685ef80f6573f/drivers/usb/chipidea/ci_hdrc_msm.c#L117-L122
Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
 drivers/usb/host/ehci-msm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index a58eff7cb..5205dd49e 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -25,6 +25,7 @@ struct msm_ehci_priv {
 	struct ehci_ctrl ctrl; /* Needed by EHCI */
 	struct usb_ehci *ehci; /* Start of IP core*/
 	struct phy phy;
+	bool ext_vbus_sess_vld;
 };
 
 struct qcom_ci_hdrc_priv {
@@ -69,6 +70,9 @@ static int ehci_usb_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
+	if (dev_read_prop(dev, "extcon", NULL))
+		p->ext_vbus_sess_vld = true;
+
 	return ehci_register(dev, hccr, hcor, &msm_ehci_ops, 0,
 			     plat->init_type);
 }
@@ -106,6 +110,10 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
 }
 
 #if defined(CONFIG_CI_UDC)
+
+#define GEN2_SESS_VLD_CTRL_EN		BIT(7)
+#define SESS_VLD_CTRL			BIT(25)
+
 /* Little quirk that MSM needs with Chipidea controller
  * Must reinit phy after reset
  */
@@ -114,6 +122,14 @@ void ci_init_after_reset(struct ehci_ctrl *ctrl)
 	struct msm_ehci_priv *p = ctrl->priv;
 
 	generic_phy_reset(&p->phy);
+
+	if (p->ext_vbus_sess_vld) {
+		/* Enable sess_vld */
+		setbits_le32(&p->ehci->genconfig2, GEN2_SESS_VLD_CTRL_EN);
+
+		/* Enable external vbus configuration in the LINK */
+		setbits_le32(&p->ehci->usbcmd, SESS_VLD_CTRL);
+	}
 }
 #endif
 

---
base-commit: 951132236b9adc592c2e49faadd103c6a355cac3
change-id: 20260917-b4-msm-usb-extcon-fix-a6491b836fd9

Best regards,
--  
Reza Kurniawan <imkyufie@gmail.com>

