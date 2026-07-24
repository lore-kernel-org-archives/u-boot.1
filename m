Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCD8C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 09:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DC9140AF6;
	Fri, 24 Jul 2026 09:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KZSq1fNMzcRH; Fri, 24 Jul 2026 09:29:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BFC0409D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784885340;
	bh=tpaDxercM4hgmRKuW6ncUbsjguJVoO4bm581oXBaVX0=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=tI7+JQMUHfNGEXRg/RJh+M0RMm5TEgIxJb/yBEZ50rXnojfVF7smgUJHJHgjhigM5
	 20g/pUzzwQ0k6zP+qWOC/Umv5/usrhM7qE9fZv4uOcXQEf2v6ocqh6xf3I/+F2IJjV
	 v7GYFjSVlcnYJ278fl9rPrWGJnDy2gkMn50A3nHUmOMI88UIYRzLJTXOFCoRUmnywb
	 8bKSw6OrO5nPtTmEeg5TBE7V0Wdva7FomP2KtH/Jy7vS5+qe3lD8sKu7ZZNPB2JfMV
	 BuLJUwH4s+V6K5s3THOhQhs9cEsazQPSVpjJdQT38Drj++vvt7s+My988K+6xFEJUb
	 qb3SxYsYQnbdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BFC0409D4;
	Fri, 24 Jul 2026 09:29:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54E9B347
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42CCE81152
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:28:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3D2BqrnI93ob for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 09:28:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5E90C81096
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E90C81096
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E90C81096
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:28:57 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4tXn81899697
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:28:57 GMT
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm1em8xn0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:28:57 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-847a00bcbd0so249332b3a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 02:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784885336; x=1785490136;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tpaDxercM4hgmRKuW6ncUbsjguJVoO4bm581oXBaVX0=;
 b=XeVkfv1MQfPEoR1pVrB8UkSQN+YeKniuyy1TyybCXqgDUzOaWcbTUShCLIVpftWPeM
 TsjFxAzif6qDNDGHP1jhKfjpk4XAyfFGbxgxz4skml7yVwhm6ThPfOh1zATCCkxaVmuu
 SyDHPN4R+ZTC8Oknoc28HWQPP9CtDJ37QYX/okUXim0YBToxDtdvHJkMQMYSWpSk0dQd
 Yfn2FOQaup4UZB7Hm98I82pGUf2gZJpUz75QRvVP50e2Iw9wl4jmNylD+AGhzyvKtEq+
 D1Jp1kzNfKBal5ikBiHPvUfXvs1Hwy+g8W615IrmuTnpvg2KzGnq6enckBzBYa39w001
 whhw==
X-Gm-Message-State: AOJu0Yyeih4mwn5oTxtM6qq8ojKJ0EIlZuQYUh5tUgCuuAXtyVi7b4hm
 ajNbZRXLgJoSxoOTnWdzl9YN14gJH+9rd8N6GHJpAIHJgPWDWQisRcNOyPjJHN6lYpD+r6ilSXK
 UBdqfAfxQ0MuXa8tPV0nhrd2pBjxW5kZS0bXk0AaK9WeVDm0rV7xou4MBVfRNMxtH12oW/0o=
X-Gm-Gg: AR+sD113/bSijhowCXB+Vtk8umK5uDKlrrCRxMYwSGCPkIs2Dllbyhj6hEaLYJYs+jR
 SWwALD5PYiKZEO/onwbgMFDe64IPh1YOU7uEz9BlQjJa8yAAccIVuhi48GAKja+DgJPN0houpAE
 mKgC+brSYA0Mpn/SRovE30WNxCVo1Z6TtrO+nwBNwb2MEQyUt4g0VHQj30j6Mm2GDTD9Y9Hwrij
 N8c2cFnI5LF5ByjiIFKM5M4RA8+PufMbGgsWz5czvPZySOZ+494PO2CfwzVtnjOSHCFtH6PIezb
 3LpH5hoKrnXcwP9XIL6DMACLTGcLaKyQdEyzDqYyPxNHQesFQU8YivzuJ9Nkpk85EmHc9yXpEbx
 kq3IfDDgO5TQwKtMzWcOwkgIxTo12OkBZf5tKO33CRV9MjO7PWd6gk6w/AAvH0LzSH2A5lYdHlP
 i9zjMqMgSMXij/n5VmrQkecOWK4lH5
X-Received: by 2002:a05:6a20:1d98:b0:3c3:a490:9674 with SMTP id
 adf61e73a8af0-3c44b250f8dmr7525863637.64.1784885336598; 
 Fri, 24 Jul 2026 02:28:56 -0700 (PDT)
X-Received: by 2002:a05:6a20:1d98:b0:3c3:a490:9674 with SMTP id
 adf61e73a8af0-3c44b250f8dmr7525834637.64.1784885336218; 
 Fri, 24 Jul 2026 02:28:56 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df097e0sm29126398eec.17.2026.07.24.02.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 02:28:55 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:58:50 +0530
Subject: [PATCH] Revert "drivers: usb: dwc3: Add delay after core soft reset"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-kodiak_delay-v1-1-57b687e6d67c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFEwY2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMT3ez8lMzE7PiU1JzESt1E0zTDVIskM3PT5BQloJaCotS0zAqwcdG
 xtbUAc91FPl4AAAA=
X-Change-ID: 20260724-kodiak_delay-a5f1e8b675cd
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784885333; l=1269;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=hatSYDgwbQyoIRbLEGqN8VYDgrpFyC5bnUEgtGN03/0=;
 b=EuNXZLRj5Mnl/yH/lpXFLjKppSCAFVogZBYVuIjoX6X/2QKjHMK4wYELDLB6FJ8TgpSOHZfEY
 BEr+VYUGWyDCdrgmOzIAzpNgqa5ztL4EBn5sMnuPbaGP5D1Ibli8uds
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4NiBTYWx0ZWRfX0CPRKXXveA8G
 Q3mR+teVPLtx5baHOlm/a3lUBWTp+xlZoa2RXkaa8y3WFAE597KYxoNnNy/xT7t6BfF4ngOteBF
 h5d+c9Z9N5xmSj9udErKo5cDXiJXAWQ=
X-Authority-Analysis: v=2.4 cv=BIODalQG c=1 sm=1 tr=0 ts=6a633059 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3nITKk5sMycNDn4VveQA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 82I3Btx1t7VA3hbzo6j2iHf6TatooWma
X-Proofpoint-GUID: 82I3Btx1t7VA3hbzo6j2iHf6TatooWma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4NiBTYWx0ZWRfX5Vf1P456BoUx
 hr3pkpOUQDGGmaynBsNBO1GFTVn6mTT+dJL1mycSqBxHYrsMqA87ux9Yjvnynkf6rZxLtMxkRVF
 QhOsRyZEZkasaihGakj3R21rWu1YRMXb/pEmw6PnJbOoKvLCqf1ZjqIKyk4alR6l7zS9KBKh3Ya
 TbjW+GPqP+nA/ngWFTDXvFAJPPPrIxQ7y51jkDUx+xSlDFrHOwg4aHNbagVQBOWVtUFCx6Uj/Tj
 ccO3fiKuLgvazKXRiq38YQW9Cs/EaanGQQSstptXhTnXHfv5HmQqWcTUjfhernC/lggIAf98NYE
 UVtPRQC5vAyDH0eNRUdEspk0dW+PcuVVQPYEosUy7nOj13ZZRu0G9go2yLC/mUUG/zjRKnps0C/
 0g5qwtz91T+P8KAJIMxIDMXLwIfIuVAqYuBfWMMxQGNwOPAxSnXivQP4+lii3BboaWg8BfbHgIj
 XiOGeeZAmCmWwrxKi5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240086
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=tpaDxercM4hgmRKuW6ncUb
 sjguJVoO4bm581oXBaVX0=; b=Iazh7hUyjW7eL2FBkOcwqF38ctcBuCvIE/xm9h
 9TGa8JxaEj1zZqowbcv/vJsxJekUKzwupDsFs6PQaNwWNlEKfQP7ylNLO/zPtpQb
 9Mo6TKXRz8k9FnULUzJ0swbanpZaKQdBGblhwpUCMvtkVo1JdGTfZvzZRC1BBe4k
 hlYUf2Eib5r+jXhokHVXPt6XI58Lm66S8Ff7mwDdwCjC53H1eNam+z3PWlA7TDMC
 rgwJOlwyUuUaNjgnijW7Ir2vRFuAVmZo1NVVprfmc5a6HiEXRVu0XPeiqofGNBKE
 aY1OS27VDQwmFl6GEwhqX6fD/7YRDp1woyMhJu/sDPMWCYLQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784885336; x=1785490136;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tpaDxercM4hgmRKuW6ncUbsjguJVoO4bm581oXBaVX0=;
 b=FHNNGCDJVyPizoGcOXULRtu7/Xft471lPikrnysMrw547yjtn7tMPyo7FofyGzpG9C
 /Q36XpKHqIdrO0+dNbmD1qU8JhkhGdb7lQCAdtfb0pCUzkbYX5g9QmYTciU5hVM1VZUj
 tXkFRqiw/hoVBp+qI4tnKip7biPna36sdl59YRGeL4Azs6a9DVE1pWF5Rdww1A/SAEr3
 ivEqUdjmZsNHMl2La30TAVJ9Yyzth9I+XF6aMZi6i3QHye0Y3dfIJrbyZ0HSrrV2L5kj
 34n2TFosXM+7i/yo+1x2QxeGQdw45oCTXrWm1W6kSaq+s64TBfY0kuKXcgnjElcYL/Fd
 HFnw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Iazh7hUy; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FHNNGCDJ
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This reverts commit 6de333b5caf035c38d7af9fa7596aeffcc49db42.

The delay is unnecessary. Upstream Linux does not add this delay after
the core soft reset and the USB works fine without it.

Tested in QCS6490 RB3Gen2 Qualcomm board.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
- This is part of ongoing initiative to reduce boot time across all
  Qualcomm boards. So we can remove this unnecessary delay.
- Actually, this delay was removed in the Kodiak v4 series:
  https://lore.kernel.org/u-boot/20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com/
  but v3 series got picked up: https://lore.kernel.org/u-boot/177745255938.126665.16625119085748603933.b4-ty@b4/
---
 drivers/usb/dwc3/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index be198041f08..ae22e1c792d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -106,8 +106,6 @@ done:
 	if (DWC3_VER_IS_WITHIN(DWC31, ANY, 180A))
 		mdelay(50);
 
-	mdelay(100);
-
 	return 0;
 }
 

---
base-commit: d7ef23c07b8e34f65b3e15e3b4e7f58d074923c8
change-id: 20260724-kodiak_delay-a5f1e8b675cd

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

