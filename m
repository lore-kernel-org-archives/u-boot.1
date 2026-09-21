Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCA2C982F0
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 13:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D7FD60747;
	Mon, 21 Sep 2026 13:12:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MUKF00uHdV5Q; Mon, 21 Sep 2026 13:12:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3B07260740
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789996366;
	b=pxSrIb59y623QM58hrBZvZe0Oxewzw/VCuilQLVp/nFKsPyMfBLYjRjtMxGHv59u7vZW
	 Yqu60s8ISjdtsIM61q6oT25ATSlDpSRyqP1AQNnhwj25p6Nkb82ar7q3dPJ2H1sw2XmvD
	 5jUTLO5HAtSsHSEcAAHDIdkKlCssPFyuvg6Kmx4ZYm6rrHTMJNDmncdR+XTPld3VlQ0pV
	 IiUTw6/DOTB2FURKB1hUwpTkcMje+zfKldhCIasyMmUInEwE0brn86CJ+OtvC11JTbS3A
	 X1lNWc+3E5JyVeUZmHFDQiYyxCH4Arl7KkEG+2iOJPSItY1zL1fY7e1w4x4501IjW8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789996366;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9x9X0zFVf6J38uQtG6Pungizx1wWLYHMJ0RyPZwC0W4=;
	b=Uwd+7yVQinEYs/AS7QGRNkN4LvHrlMVl1Y2EkHOhKrS2hkg6+966xf+3f2jprQZzQIQE
	 dsqBbKCQITso4g2JGwL4SJzxkCDCx8igK0CTbEXbxfn6+w8J/6vFJmPbkKaA0Z8mRBk70
	 Sz1WtFWyzU3gTHFvPVpESSuI4jozCNlZtFNvGtDlaFyXjpLceR+KRauODZ+3hkJ/yU864
	 sQAmdYZX77/EmCHsHuxGej9rZdmUUjaGr5RALDZVrKvn42alO2CIjPQoKg/mtUpHjNclV
	 Fnn0uE57rL2kFTDnLaxaOJduTo9pqqIqOTdq9NYUBcoPfFKxjtqDYGDp+EIzKLWW49Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789996366;
	bh=9x9X0zFVf6J38uQtG6Pungizx1wWLYHMJ0RyPZwC0W4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0cDAidTDtvQwsziWBV87Ojn6mbyTOV/Pzg9H4WPlGMDeDXNXTIivF54Oj4PImu2sP
	 UmsjNcef+EiWOayDarwwGKC7EpBWF6qI4Pbk96f1y7428LSt2irjvYSkKBMLOehuJa
	 xrJ1lICKDBia6Jdvp2J8IAo8O/vUqjeKxYOQpKcRQVH3Aqn2Wm3wKuFZ64zud6R4eI
	 lwSomm0xcVJtCProIuMWxC+koEFZjk2EYI6F66uF1y9kIKJ3sck3qbrkNYhg39/NTR
	 U/vCQ//nIIy6xQ7i/DhIYSFaaLmNMkRzoLttewn7cDeIuqT5OzDOpyproCoH+S4xMZ
	 wrDH8jdcLJ8vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B07260740;
	Mon, 21 Sep 2026 13:12:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A0864237
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 752DA40143
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VtaP-1Ui1FGv for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 13:12:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A34D540129
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789996356;
 b=coL8pH+DcrsAvS3THWLq3OTNnl0PsbMCiWqsGjXMvMDlvhosMboNKPx3a8CSwx/s7g5C
 VqGvnIytd61kJuBzA4zW7e/mUvc/TAk12po/YZ+C+pI/jfJPQ/4L29rYJqs7jTRMVIemx
 ipvsFYHUz1qU5yhfTWrgsy8uWIX3czWJzECddHrl+AHA3DT8T8Um7jhxTi/4zrTnuiwoM
 mQ9FbuQVlvp2Cwq3d0B9wVGKRhsEob5toKTA8ptcHOAg0TT001OTjOZN2LseMTu7SYDWS
 BG+IT+efgq1c5aTZN7TIqRAYy6fHPxvDUT10LUlT+aGJaB3JcimNqRiodbbVq56QrpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789996356;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=9x9X0zFVf6J38uQtG6Pungizx1wWLYHMJ0RyPZwC0W4=;
 b=pkt0d24r55AinGKEoo9IaeZM5giNJD49XNkvlSvrrDaVrqtRZYm0W+t5zAZOTn0Blwp9
 yt3obkJZeOYkvdyUmS2+Gl7wESOIKRcFiWTJdnGY8dslfmGTPXBMJ3pTfTHFYzY9jvICR
 NJpvX1GVqVnNiUUtbK05sF49y5/HrOtoKOO3i9xw8sRWFncP9o4jo65/FT1ORKgV5/8bI
 Weyrb/GYvFngk8rn1j/Yh2AcR6+41qB1m9VsSRjmJx5RDbnq9dBXzBsy+mljzLxo1ispn
 BMdqffgb3YYEd5D15E/zC/cloP6eTAt7tsG7iSsQI3hg6GP17f/G8fEsP8rX2cTH0tQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=VQj8KQJ8; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=VQj8KQJ8
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id A34D540129
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3CD81D70;
 Mon, 21 Sep 2026 06:12:31 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.125.10])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0113C3F86F;
 Mon, 21 Sep 2026 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789996355; bh=ylZ7WXXrjkNmk/gpZ5AyCMVgd+87ar9X+LWSh3CUasM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=VQj8KQJ8Ab7mCIeAGyeK2cFXs6flrECVQo4K4AB0uOwiM74ZGPLqJcF0fkJ0ZDfbs
 qhDh2rdgvnwF/wlsju1N/ATxAvVdQoR8vz7Xj89xXcaKSsgjyLtqwX4QS3u/xOPTJK
 OGXGl+nsG6MmURaFw2nXWvy5LIBDRgrGb/MFDuM4=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Mon, 21 Sep 2026 15:12:19 +0200
Subject: [PATCH v2 3/5] lib: uuid: add EBBR 2.2-2.4 conformance profile GUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260921-conform-v2-3-daeb00359af9@arm.com>
References: <20260921-conform-v2-0-daeb00359af9@arm.com>
In-Reply-To: <20260921-conform-v2-0-daeb00359af9@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=vincent.stehle@arm.com; 
 h=from:subject:message-id;
 bh=ylZ7WXXrjkNmk/gpZ5AyCMVgd+87ar9X+LWSh3CUasM=; 
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqsS08GaVPufH7nqnrpuReUwWrE0QfbnugscJQf
 uLL4j0cxCaJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCarEtPAAKCRDLSfhWdqMG
 lHgRB/9dGrnCaklRc8OimAVHeuMIHCN6PHLLGxD4TFgS1gATbhyTJISs2Xeu+YAhYfHG4NxCaAP
 h3UM0/tc9HQP5dJsm8EeB+Svp65pX04VKqIx7qf9Gc1XuP7R9LiqVICo9cAL5Bc3RbAkcr4rXIJ
 sqcxOv1Ma7RYYWZUBnbeG6axmLWomxFBwFoKFTGAnfsdwirIMGLfZRNSwslKXEMYnyRfPrwenif
 fMw0lOEnbY19esENjDj60iUgqEX2J+0ybRFjMnDdlOkPi4xrcOhQnjAgesXq8i89tPIfwkeMuSO
 opwFBj7/p+2KMsncgubovqIDg8xcVQ2jYbKWUdENw+wrgteV
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

Add support for printing the EFI_CONFORMANCE_PROFILE_EBBR_2_[234]_GUIDs
as human readable text.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/uuid.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 16ca8f37751..18fe2a8a8f3 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -261,6 +261,18 @@ static const struct {
 		NULL, "EFI EBBR 2.1 Conformance Profile",
 		EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
 	},
+	{
+		NULL, "EFI EBBR 2.2 Conformance Profile",
+		EFI_CONFORMANCE_PROFILE_EBBR_2_2_GUID,
+	},
+	{
+		NULL, "EFI EBBR 2.3 Conformance Profile",
+		EFI_CONFORMANCE_PROFILE_EBBR_2_3_GUID,
+	},
+	{
+		NULL, "EFI EBBR 2.4 Conformance Profile",
+		EFI_CONFORMANCE_PROFILE_EBBR_2_4_GUID,
+	},
 #endif
 #ifdef CONFIG_EFI_RISCV_BOOT_PROTOCOL
 	{

-- 
2.53.0

