Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618C4C4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA91B846A4;
	Mon, 20 Jul 2026 10:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ejbdRbKp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BOXorqXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36B5180517; Mon, 20 Jul 2026 10:52:14 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06853838D7
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K7rfDq2979946
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jkF9uSAOcyt
 Lt1jA/KsEpt9LUGnORizVB05IqRs+GUc=; b=ejbdRbKpE/IfOhTHx8pY/FnRaub
 YYxQKDcWxCL3+0gNHXXDy4jgqBLNTzGfu8s8Dgq3p9cLiMjHQIHl5LNV4Lc+39l7
 HBNeja1ARHNvz6RlfVMoyip/NM0HpPm3Bsc7b8lgHxWyGzImrsq7YQ8KLg1FlvoR
 wofWcOd/mfewBm3AdOTORFiIPhz1pc6NGNcuAGh5toL7ljozpbDkPLXZnXQPotgW
 hGb19HeCcO3vP4kJDXdVhIwPk6H4k79+7+0BpYFzBYJIXjFgRqrjG4fwxd26bjai
 mtPho3x+5IDvIC7bv6WGO/DYO/r96R0T7oPJM0xWWcoZ1HVvMXOzT0PsAeA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg07fb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c075c1e25so138401241cf.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537529; x=1785142329; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jkF9uSAOcytLt1jA/KsEpt9LUGnORizVB05IqRs+GUc=;
 b=BOXorqXLCecSwHpdCIkXd0VgqRxzCnh2Aj2ZpGTuNjz+pbnCUpTc4PKZHEK0iYS4G8
 eL7ziQtqIoXBWXt3vkLzUx+Px3YzoYwcMUshbYVg5PSSJr0wdrMYCGjly3l3SqpOSXP2
 hgppyCxvKqNICDeHIy4hgHwBkehpyprASSbj+1Mud9tfMO5BOWO71QQvlOimtqiRlFv8
 S7O++7rHiD+mrhJV/b/iRTWkr9cblfCZplB3doKPTNhBSrG1A3258fZyjH1QHBx056m9
 G4vLrnFRrevFqR4Wbny9mLIG/BOdFqMhvHb/IucZu3fxiRPDyu2PEXsleAdGYymmriKW
 yLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537529; x=1785142329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jkF9uSAOcytLt1jA/KsEpt9LUGnORizVB05IqRs+GUc=;
 b=GXuaH4PTd/CpI+LjaEDZTpePQJiGHFYfvgUzpGqScIFuGlvgmlT6qXIJHvpV1cOTNf
 wfj2wdGWJcxLIRKZri7OC4CY+mK50sC/+NFp3Erk5qG+eGk/VbKoexBKG6M87rdp1Bi+
 GTBQj3Xqf166NaBTssCXa8TZF3Lp+vxmFL1+kiFSvqSOi/gB/BoQ9LlBsBE07HJSPkCg
 pgYh9EU2wum5WFi7Br2Ab1gTAx2kbltuX/1wkVGpbGpvaefLzin8M3EE2kfQIzT01r7m
 tCCELTpWix0eYkiRXN0IkM6PIrRZWvMk+jqzHLP9OBzWbBDWwqwxj1aZV4tIwEZjrmQU
 pi6A==
X-Gm-Message-State: AOJu0YwB+S9qDIUwJKkOZk9Sz0xMq2k6IEmv+YfehKxR9U8GheKJsua6
 8W1MZ+CxdzKGY4Vzas7zDVcVJ52yz/cw11p0FZmZZAa0r4bV+5Jdvdo75h+Xa703mu1QC/DHBA7
 tnVtiwow5/6yPG0w5TVYx+cyb3Oaj1v0lKeENQIFgr7JVHNMkMCIZt+/T
X-Gm-Gg: AfdE7clk9gd+5QGmI0ED70KDpwQWP1i3sUv6ifw8JAWv47B82xhl9dRzc8FK3sibz3w
 /nGcesmRE6s4S+/OCqH3XqyQ8hXW92hDaV0baiyI2X8MfSOhUlQek71SMdFRADpdM4rjBNjLqEV
 4uufAiOAgrl/bmxJHpyFiPjfgIN+iNomc2qG++5mmMd72XdWH56ZwH4/rmKZOpFHJt4y+xuZGcG
 7keIY8rcTTrUYNv9op/Pc389sjZqqF5bU2ZKOSJ1cEY5ZEMuO8Cnpu+pSuQxWn+MGXFq4/m7/lt
 KMqi/44quvKjVnPVQo2p5z/a1f/b93gMj96syk8CZZ/sHhqVg5Eo9Ed+hJMSahh3/3ZG4PAggw+
 1I1mMsr7cy00FzyJz/G3TgBz7T1ZF2vYB7AuAogzegtBryY9AQE8=
X-Received: by 2002:a05:622a:551a:b0:51c:22de:c7d3 with SMTP id
 d75a77b69052e-5213c9dfbbamr120247521cf.25.1784537529079; 
 Mon, 20 Jul 2026 01:52:09 -0700 (PDT)
X-Received: by 2002:a05:622a:551a:b0:51c:22de:c7d3 with SMTP id
 d75a77b69052e-5213c9dfbbamr120247411cf.25.1784537528704; 
 Mon, 20 Jul 2026 01:52:08 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm26450052f8f.4.2026.07.20.01.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:52:08 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org
Subject: [PATCH v1 1/7] ufs: decode string descriptors as UTF-16 big-endian
Date: Mon, 20 Jul 2026 10:51:41 +0200
Message-ID: <20260720085202.537019-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfX9HjccbCsI8LR
 uZ/PJfKGllcQEo0M8IT8IjYZJgSUSNPhyya4+oa0Z/2IlcOuYZpsiix5u+R6nu5U31gC7HdnlRu
 oYzX/N3EKxM5Mcl+rGIOFZGNcnr7aj0=
X-Proofpoint-GUID: ijpIsl1zuk1P3tYila7nBMcn8OmEvlSH
X-Proofpoint-ORIG-GUID: ijpIsl1zuk1P3tYila7nBMcn8OmEvlSH
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5de1ba cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=JJ5SyZhPYCvuiZDi1AAA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfX1r4Ws+3UvdON
 MloPg1m9snO12aQMKggfspctmIDHALIyggJ42BAfjIpKrF7AOZW1/UvzH62c6ZO4fi8LbsUuGgN
 5QD7YBBgKuruHShahYCOCOXwBT+GtsJEsj0sv1BoOWSDSUYPoTQ8jnP2DLdrXlTh8LfY0mSLja0
 WJPwn9VLTCRnx3Dc5O510Vx6NI0CkpNHwD2gEy1v4gSukb31jIS5HJgWnYbmq3rkb6lR7LUYd64
 8vWjSK5mjpPskPk8cuFyOu5gVPTlm3nDJg8SzBsEZBqSE+Oz8sMMBjXgjl2Aey2RjNCcyY8YBdG
 H/qJpo8Br+iEoFSSbyjZW/y3mgFnpRP69jaLLOjJIX32WvZEMQZRaghMrBa2rmox66RyB0FhA1A
 mm2Z1JpxFR48123NJ9WuKENj3S+jsvisJaxSJwNe74G9YaW8j1ggCgR/Kl+3wicBiBvhRfxrQ2y
 YupEJ7HDGsCkMBfFZkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200098
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

UFS string descriptors are UTF-16 big-endian (JESD220), but
ufshcd_read_string_desc() fed the raw bytes to utf16_to_utf8(), which reads
host-endian code units, leaving dev_desc->model blank. Byte-swap to host
order before decoding, matching the kernel.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/ufs-uclass.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6a51f337e47..4d10e0b11fe 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1765,6 +1765,14 @@ static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
 			goto out;
 		}
 
+		{
+			u16 *ustr = (u16 *)&buf[QUERY_DESC_HDR_SIZE];
+			int num_chars = (desc_len - QUERY_DESC_HDR_SIZE) / 2;
+
+			for (i = 0; i < num_chars; i++)
+				ustr[i] = be16_to_cpu(ustr[i]);
+		}
+
 		/*
 		 * the descriptor contains string in UTF16 format
 		 * we need to convert to utf-8 so it can be displayed
-- 
2.54.0

