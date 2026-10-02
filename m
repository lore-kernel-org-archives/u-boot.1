Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FCDCA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39F7A40D9D;
	Fri,  2 Oct 2026 12:26:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4_1osnQ9qZeu; Fri,  2 Oct 2026 12:26:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C9E6040D77
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790943984;
	b=Rurqi9RC1phu+s8J5Q6yeUBoU8wgG4cf0ijPiATMpLlkKWx8f0CK+QvRPpEZD4rhQAOT
	 fOEHpwixV8TQmPcj/DfVBELE7Hs2RZdyfemJ/3cfKoc4XirC9ba5M2K80DjF5gyNK8p9h
	 3nTcj5xYUJLl9QpgyLGvYK7eiiU4nOdLFyocnl2iqamwlHvbLrbP0CRlG6dO5vWPo+VUU
	 2MwulGdbst9cHoWCmMANTtBcAwmThCID6UaAJZCGbuVf2s/1/52JQKD08jSmMjemSCRA4
	 1/vT/a+hvdBPrpNplubiaS00oit39/9eQlXdn+CfQzDcvPfoBPntCyl/4n9voEVnBzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790943984;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xKdjynkKLuziA+w9rYIyViDEKl3bb0qnDZBsY8d7rUc=;
	b=lvUjyUcM2HFOJY/KWbdQFCWcaA6opxl/pLFtUD7yArPUindKs2F7+78U53hq4G8lE0g1
	 kqAPUHiFv9Uz694sJ+EtLcTj+1l2GYt74e3bo7+ZFuwJMHZl1sgm2uwnmOYrKeb4tUrNk
	 3HoK/obJWwjynz1Nt6xvBgrZfYnXEWPFbv4ISBFpKF6X/jwHqRycwuulg6ycCmaW7Lmis
	 vZuAtZncJcuxp+d07w7AklXy6Pb4Fl7/CLCA9vhKIHI7Tj5CyZYVrcB3vp48fUheBvKw0
	 dQ1m4d8VNSb3ObAZ1wW1eygh1MUBVpGw/Ay25VMbViJpcBUfnX4ziX5hAfIObqmPZNg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790943984;
	bh=xKdjynkKLuziA+w9rYIyViDEKl3bb0qnDZBsY8d7rUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UW2pBTHdY72Jn4us1CfjPXow00MltXD44a++UikV4H16GgBTUeH/zvsRmAGmXeZst
	 nKbNIqeJ07nxuULy87ewdC2Dk5Iw/lKMeZA9RZH+FDVzOTQWPZBag6UCuq6ZjBk/N1
	 8lqwnwmyl55hTlDpk4hw6zf5A4FB+66xURokF+2Tp7xkJQ9HRonG4AvbxMa2OmoDhF
	 /t910P0xDDQZpPlwO2WyhbmKyKkwiepi0flL7qELYbaSvHf2O7XN8jhTpBqE3CJucg
	 /cFzl7ZRZtLs58eQ8+617VExwdNcbp2pNLhd/OJl/uyAZ47CKo7l1UgT+4/UCy3/+q
	 XqNlrpxyMsKsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9E6040D77;
	Fri,  2 Oct 2026 12:26:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B18981A6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 04:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 974C481165
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 04:46:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uuZqIEAw9BST for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 04:46:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E8F76810D9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790916376;
 b=n2726ellRV3LYb+hRBSVl6WuD9PJcjwQosoaWiXdbEFvHf03B8hWtI3+HbUFp1zgg1lD
 ARUcsPMIGzdC0ywcwhnCvlq31A/BoHG8tjemtZRx5Vq0JD1HEhBmiZmrPpPWU1NyYENWm
 oTJYZSIHTS1vNApDR7rsvWZ/pKCm5sigOTpeiEGEUfG0G/VnRXVMe2hhEg+7Srqiw1MYl
 /MxrRPeGge1EYtLyfa+ptvXUyXbv5szu13jnpN0cTBs6xdCXJB23e2KRwM6mnwA89Ov9n
 kjhB2TRqkvbUIUvbPAAsYV1wiYV+3EzKCfGZo2Jl4r76kK47LKR/Cb87W65UMLcFMUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790916376;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:X-Mailer:X-Developer-Signature:X-Developer-Key:
 Content-Transfer-Encoding;
 bh=xKdjynkKLuziA+w9rYIyViDEKl3bb0qnDZBsY8d7rUc=;
 b=eUWtxKcHVeT+4OV2NP/BWO7CDVmean1JFYKL5zrrtyJ25rKY0tUMZpEvf6qERf4w/R1/
 921m2rdaUF6vMmkMRUMBStuk2NZdIDso4PQZkgufJYyneA7fvfHYPHp917lRDE3eRDZCe
 218wAz6JKv5osgSB1W5WfUXBToZ4pFhNcYp0YoQwUt73FrTwCBdCFyORCVTCoExMsGPUh
 WRGTBqekk/14R8m6Lr37dIkhIDCWUsakPGb6qg/LCQhpQ7eM19UB12vz/Xy2mygtupOZo
 cTb8UWzVPQEGfanp9rKOsT5+YvkVHM+6AkQTniy7qfNYb/ILaEJpKzoTnM/141V4htA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CBoMEnmi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::2b; helo=mail-pz2-x2b.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CBoMEnmi
Received: from mail-pz2-x2b.google.com (mail-pz2-x2b.google.com
 [IPv6:2607:f8b0:4864:3b::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8F76810D9
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 04:46:15 +0000 (UTC)
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc794a06e5fso4222053a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 21:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790916375; x=1791521175;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xKdjynkKLuziA+w9rYIyViDEKl3bb0qnDZBsY8d7rUc=;
 b=CBoMEnmiAGDFRbApsTT3Us0Pqunke1fPasqKlLvwDjtGwwdRZB2sbXqdEXhF0Hry2o
 JXTiA6BD/oC+mJg7xb3LD/oViE2PHmXxnmJxf0nRhCUmeS1EQ55E7fR4RX/rQ9XpxKS2
 04YsB2KLTI+ruJg4yZlt66uN99h4zd9Tr86jVE8kcIzaUgnwZ+IxZSYq67fNiKolW9G8
 y7M2ANjb5HnqiAanBXMmUdLNtqhFrnnrZUeHy1GPIpX8AEW3LR+joWO1V19nAvshuo3O
 BX1fxmfKihHLWV9pjfYS5Vkw1wgyVCmDHwwG22VUJU8uRDHcXU/O7SUvrQQ5qcfdn4fl
 H4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790916375; x=1791521175;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xKdjynkKLuziA+w9rYIyViDEKl3bb0qnDZBsY8d7rUc=;
 b=rO/m1HYdOUt8QomLIiHpm8utNPA7b+VHHGrCTTgNY26QCwSp4eS8S8sJHUBA0QCn1S
 qjD4dk/14NmrtK2ms6euum+DHZX5Hs4urRxIBB4z1o2iE0/U2Cs7GhtJRJCXuoAQcmdo
 K/wXizpl5h4LOg2FMDMWYwpjtLBYWTYcznM4qDpFKV8ZhTvEolWameFxwcalGfx+FX0w
 uIY4AScsOFtXX/wrxY++T0cg/dcRMdRmcD4ZCuF+VZhtNpvQSoocfeyCw61sRAktkwF2
 nnyWKjhUlrfLvA7Eg5ss7poRsZWD+G76KThUmkClA/BPxogx74bDlApQ9QjL9+0gaSMM
 mfKQ==
X-Gm-Message-State: AFuF++k1dJlvnTUbKyM7b3043Kut3mJfvw82igst2BCOArH8/R5doPAD
 iLGFjcnMmRT5CoyZyun8lcgGRybADFoShpLQYSd0io2Zv3NEAHeYoF7yC+qj6T1iLbE=
X-Gm-Gg: AYBFou0BM0Om80KOLkxM8gqJfNpGJ7/sQOh6c4ibtDLkdLOjqxqzylO2OVEKnuuhCvI
 o0z1hYuHIgeOsf2373fRAjISoWThwqyARsmDozQ3yxfkj/RctNtCw06valpSTTSoIA7vXQrQd2H
 upAqRZjCQPE+sBZeySrvs7FQbr3ennvT+UeJ4hc7whw445tyA9eBF7JVB6qylL+pxn6h/hOKt/7
 rx6+MnzZJUy2O3EH5K/A6i+DinCPtfJNTQUidPoc4VMFdgoTu+1BgyTJJsJsuOpEBuBM2bytiYF
 lSXAbvnKbM+qsw1/DMBWeDAR0koWx9rc/H5mwZgB4X7LIGXsrNfzYBVyw5z/+8CHjjbLvXSM+ty
 xfWVQvJtJX2WurxEaCn9+LxjMlSpI9bp2c++vHQxCWtVH7DXKAY1xbHuVG1Cm0VXeLZVfrwWZof
 0NFv4hno91qWPIAVdWeVQ5eRdSA1ghaUxZAKM1k4j/K7MHQ/C3TbONO+tgphtUT42g7SWB75EFN
 hqSGhAX7A==
X-Received: by 2002:a05:6a21:670b:b0:3de:5c27:40ef with SMTP id
 adf61e73a8af0-3e0bc9fa69fmr1599805637.8.1790916374874; 
 Thu, 01 Oct 2026 21:46:14 -0700 (PDT)
Received: from morise ([45.202.248.109]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc9f739271dsm439791a12.24.2026.10.01.21.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 21:46:14 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
To: u-boot@lists.u-boot-project.org,
	u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@kernel.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH 2/3] configs: k1: enable Ethernet support
Date: Fri,  2 Oct 2026 12:46:03 +0800
Message-ID: <20261002-b4-k1-emac-v1-2-d9be2ff07c9f@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261002-b4-k1-emac-v1-0-e1b6806b018a@gmail.com>
References: <20261002-b4-k1-emac-v1-0-e1b6806b018a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790915939; l=906;
 i=sycamoremoon376@gmail.com; s=20260926; h=from:subject:message-id;
 bh=qDIi6Mh42F//ab90ulUN8lLybWkD4pb/jAd59gxenfk=;
 b=jOqi0Qf8KTAlmhtYWCWMiMpBGMlZRL7hTFua3j8bvWn4jzjMzYNrDiSrnZxr1gkGglNpzq1ph
 FNe44dayvt0CNFlQ6fhBFQD0REUXZk8hP8mLKh4tnHRmTUkBtGPl1uw
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=xO+BwE3DuX3uCUVEo06fonjJtjMp0vUdCPuPP450qO4=
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
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

Enable the K1 Ethernet MAC, Realtek PHY driver, and network commands.=0D
=0D
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>=0D
---=0D
 configs/spacemit_k1_defconfig | 6 ++++++=0D
 1 file changed, 6 insertions(+)=0D
=0D
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig=
=0D
index 9c15d96eae2..cb04eb694b5 100644=0D
--- a/configs/spacemit_k1_defconfig=0D
+++ b/configs/spacemit_k1_defconfig=0D
@@ -44,6 +44,7 @@ CONFIG_SPL_I2C=3Dy=0D
 CONFIG_SPL_DM_RESET=3Dy=0D
 CONFIG_SPL_POWER=3Dy=0D
 CONFIG_HUSH_PARSER=3Dy=0D
+CONFIG_ID_EEPROM=3Dy=0D
 CONFIG_CMD_TLV_EEPROM=3Dy=0D
 CONFIG_SPL_CMD_TLV_EEPROM=3Dy=0D
 CONFIG_OF_UPSTREAM=3Dy=0D
@@ -115,6 +116,11 @@ CONFIG_PHY=3Dy=0D
 CONFIG_PHY_SPACEMIT_K1_PCIE=3Dy=0D
 CONFIG_CMD_FAT=3Dy=0D
 CONFIG_CMD_EXT4=3Dy=0D
+CONFIG_CMD_DHCP=3Dy=0D
+CONFIG_CMD_MII=3Dy=0D
+CONFIG_CMD_PING=3Dy=0D
+CONFIG_SPACEMIT_K1_EMAC=3Dy=0D
+CONFIG_PHY_REALTEK=3Dy=0D
 CONFIG_SPL_SPI=3Dy=0D
 CONFIG_SPL_DM_SPI=3Dy=0D
 CONFIG_SPL_DM_SPI_FLASH=3Dy=0D
=0D
-- =0D
2.56.0=0D
=0D
