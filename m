Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AC7C28B30
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 01:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D1B181B4B;
	Fri, 21 Mar 2025 02:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IAE3KRXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A378198A; Fri, 21 Mar 2025 02:31:32 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0310280756
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 02:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7c08fc20194so289823885a.2
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 18:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742520688; x=1743125488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bRv8rCFlxLUjkTOYJiOLSqXid3BcStUHIjgArN6Svw=;
 b=IAE3KRXcMkRya4wXeVXAHm0Nhl5C3XAw0uFe+kiKAcJDTPsbt3lhABXuaDon1rkVn7
 atJqWE9RBgWbXoUoaThhYMGGaMFjhJPQeKEZ1Ko8wOA4GSxKkNCV05mix1ssz9FD7dR3
 oLBb4NdcWCK0L3YJFlqZsxqPkeGSvSqdTm9+80agXjBoJZ3ADCD5mbadRd9w/cBkeJVs
 E+8xQdfim1SH2LsmaEU2VvE1kL9LstQNoMyCUx5bJHKgDjmLy4gfVZi/VoZytM8wNuS3
 +pyReXy4w8agMlmLOQSKzMnVyAfMlCuLPaZOIXlf/sDTz10fY1Jjk4hcuTmrd2rtbUOx
 MmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742520688; x=1743125488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3bRv8rCFlxLUjkTOYJiOLSqXid3BcStUHIjgArN6Svw=;
 b=QIpy5raA6MX5BPj79GJdGu9ILBXeKLOBk6LaHgf4cYWgdUFbssc4NyojKRium/mV0i
 ZQ4FERE3VPwbWkeFtbhsWVP0dStMdWb8eZlVFByhO0r5fe2HnAMAOxEZEMsEZrtR1ek+
 H5WFPFN4gGu61kxhLuYNp50LjQJzD7BBJMU9nEBMXSZ9+WFCJVHs4XJV9FRyVTWviddg
 4m7Xdvw0IjcF1tV2/ZMx0dDtgoUzfYNjBgM3FP5sc07wCVEr5vb4XwUiktm+Yn/LcDo3
 jGXeP0moWVCrqcxBxWV2R7Z4xvcAOji/Qs7ZB8CWpG0njpkL18WtZpSUsp/Odm9H21Ms
 AZqA==
X-Gm-Message-State: AOJu0YwtGpoVqep82A0TDQ+S/iBO0hPeXknArT8Q0eZP4x3sf3VfjI8Q
 5XR8CwDEs7wLOB6YsptbEM8i1V78+cPiM5erVHHjH6NYYxMouD2t8G4ARw==
X-Gm-Gg: ASbGncueU4c5OyJXtpF+0jSPbvyAWLK4XQuRjjojCB/NN9PWh5FkPwf7HYSFmHtkBC0
 BdiHd5kq2B6zxPkGxodylqoU8mMi1Xc6UAAfulaLEdzTo2aN3ARBTudzd0XRsp7HP4E+AZcRPY0
 mOcsuChwBVVKXQwlKIl5nJqhu+k6vGvlBX0OKxjLTYwodu8fXAFOPiPA2qY0O1tOE7odbhKnT8l
 Jz0ky3IAW2dXSA1u9Huzs6OAPDLVFGCDCaO6CKu/AX+cuNOCndMzlQ0LknvHAYgTDNo71tuib0K
 i+DD+GJTYHXZdAiufbO32yE6sK0bYzqe7ZYxLUPNKsNtnr9f7alye9A7HOxKRsFhNWYD3FsvOhe
 pSykYYfUxjVwn/OiIYf8=
X-Google-Smtp-Source: AGHT+IHHRTcMheWIArIJMdNxUL0p3dgqxe+SWvy133oAbI4Q9ZNkLQMkehsIrykicjitfF2y51qyLQ==
X-Received: by 2002:a05:620a:3711:b0:7c5:3e89:c6df with SMTP id
 af79cd13be357-7c5ba139d80mr185052785a.12.1742520688338; 
 Thu, 20 Mar 2025 18:31:28 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92d0137sm60501185a.31.2025.03.20.18.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 18:31:27 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, marek.vasut@mailbox.org, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V2 3/5] arm64: imx: imx8mm-beacon: Enable CPU_IMX
Date: Thu, 20 Mar 2025 20:31:03 -0500
Message-ID: <20250321013109.709431-3-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321013109.709431-1-aford173@gmail.com>
References: <20250321013109.709431-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enable CPU_IMX to register the ARM core and identify the
speed and temperature information using the driver model.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 configs/imx8mm_beacon_defconfig | 2 ++
 1 file changed, 2 insertions(+)
V2:  No Change

diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index 56e18893b77..bcb60a63795 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -84,6 +84,8 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_CPU=y
+CONFIG_CPU_IMX=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x42800000
 CONFIG_FASTBOOT_BUF_SIZE=0x20000000
-- 
2.45.2

