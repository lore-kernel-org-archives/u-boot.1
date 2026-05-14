Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819A4CD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 17:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA9A8466F;
	Thu, 14 May 2026 19:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bBmMFGZG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PmfZVSha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A0CF84686; Thu, 14 May 2026 19:17:09 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 846F4844BF
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 19:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeWFR2554571
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 17:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=pdEFuyxSaXfeclYfoHHXpmnfZpEFuWqCl+x
 XiqouAK8=; b=bBmMFGZGHKtgvl7EXReEfjdd25A2nxHdPbqu59yC/Rsfqx2+5br
 E7vn2nev03JlVAfEZO1xdtAmjSj42DqCPvgCFl+1J1eiB9DzjUm4qldnAAkUI5Hs
 xa6opBbOPDXfcwWJ/Oyy3qBddlDFETSVmdDVfmC/3rvtk9E4VhICZ5tPzCNcbNYG
 DJAdRIL775+O9RYw22huGtr9zQtPdrR5n4cUOFIvTexhY2oI9ZuTNJ7EotjOJqUV
 VbsmG9sIj/sUWqko97bXxDPAMY2nJZIcOQitXG21HBaZGOTxJojq7WrYUfxQuV5v
 NLT80g0+5CMdY5CW0pev09vTmYWam644QAg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5b0bswy2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 17:17:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2babc42244aso151884135ad.3
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778779024; x=1779383824; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pdEFuyxSaXfeclYfoHHXpmnfZpEFuWqCl+xXiqouAK8=;
 b=PmfZVShacyvE3eoy8/PkBVi84/SlrgdtF9PqjPSbZi8AXTRvC5NfO6AF6VmDRW2QIg
 8UFXxH92jbe5Biic1nH8ZxlGbkZjyWlX/yJKhyyqqFFdxdGHiuEXyCy0jL1wfLQKI5tL
 pB1E/FjWaOjmvdkm0M24vdR9FWpMA63xiEMQdeWpMZWzPTCgF19T6opzP6NyVBE3Wzq/
 2cVLGq1AGSCDFUOmtmTH7erUzrbce0MYeZlyH4zIkHsIPKWp2SEj2DXLSDxKw1Ddeyuh
 MqsbRArrvvZOGGfdCIh36cb77cWj9p8iBcbTz79EIN4dxUiZhMI0sS0H8vlxNuzBgEoZ
 uDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779024; x=1779383824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pdEFuyxSaXfeclYfoHHXpmnfZpEFuWqCl+xXiqouAK8=;
 b=Vp99mlzxlbuOUHpF1IwnFLUgdiOu+WG0ZRzrhbzLfVuvj4OAfWT+95RRx+gH8pOQPs
 uWo0L7MOm1DVXSbnudFb/4/ioWbN02ryg6qHzfNZtBxGcYJgXIgVD1d7eZD6U2l+Z0+D
 OuPsxux3k/dhDA7usgsoC6vLHagOS6JI3ulfNqiXDTJHcF9S4qKDgPC1GyJkylHytDFy
 F+9ygL3XJgihzkgwzv4iclQT47Rksdj5772vYaEv/5RHx9KVCi4PKAqDNBoY08007ykM
 GVA9xohcupMooz+s5iomKZ1p1oZ7KB4yl5qttdMvu4PJOutWF7w7U3E0Rgd8499YiaTa
 KyhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HMuACO30MjJby544WplKuP0xJC/ns4KeipRCMH/l4rIP4OrT8ySpHt4woFNQxJBHCyGMASt8=@lists.denx.de
X-Gm-Message-State: AOJu0YxkYAc2j0T5qUKUehZe6lEBAKFp0+aQfM1n9DEf1hyBuYic/xGm
 RQiTeAgT3bLsabOt2UlTT+IFN1TJVSTuykTcsybE5cT4BpbQOJZrER/7AN7j5z4TGDZ93kbLaK3
 u7z6vBdyl9/ejELGbKVue5cKO9xVbYPh858ZFEYe61FzZRZgqtkNcKthF
X-Gm-Gg: Acq92OHlUAw1i5rcXjNJhWoCzNhYWlbz891STqgawcv+lwChJ6QXPK/kP4L/niwfpAv
 EBY2tLFh1bpC057IBpi3xLf5zm0KsPdI9ZlC18EHlgjPhw2NZMZnGtyE6uovJ5wjQMWZXr/oH9v
 qT+QPLgdcyoq1HK7ILbXg0H7Md4FeI0mhZOLQgAEh+1ZVvD1DXI55wlR6SPeRWgYbMjVeeLP70w
 1S+EauTZNXtCWUlepFRJy3j/lRiDkbHPqYEIxYW928dNsFKHGziPo/aRr8upQ++NlJujxx+N2i+
 Pi+EPQuLdsf3FxzrCLZ+WiuEpOeebTos6JKD9pJ7EGhat4m5dLQ7AC8uTgcHqNTV+gEcjgqvJwn
 zU6VIDb+bSn+chWZOFgDKFTndIzX7LGeD/ZIhliLRWWTpm44ZOQareJRLcPH+2fP8yOXvRJzc3e
 jE03nEx9J8ls3Z4esX8pAaXB166A2O3ohf5TkAX9ZY
X-Received: by 2002:a17:902:a701:b0:2bd:5b20:a5b5 with SMTP id
 d9443c01a7336-2bd7e951360mr3238435ad.37.1778779023904; 
 Thu, 14 May 2026 10:17:03 -0700 (PDT)
X-Received: by 2002:a17:902:a701:b0:2bd:5b20:a5b5 with SMTP id
 d9443c01a7336-2bd7e951360mr3238015ad.37.1778779023223; 
 Thu, 14 May 2026 10:17:03 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d235c18sm29139975ad.81.2026.05.14.10.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:17:02 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, u-boot@lists.denx.de
Subject: [PATCH v3] tools: efivar: strip auth descriptor for authenticated
 variables
Date: Thu, 14 May 2026 22:46:49 +0530
Message-Id: <20260514171649.3708107-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3MyBTYWx0ZWRfX94OijpUlVdes
 6KEFZi0MuBP9JYF2zEmpkZM3y+lWEU/btqFdqcdui6Jc/mi1aLiwVo5AEBXw00FfHXNEUs0K9E0
 onZI2QMb3/iBIBIO9KtVn+gN/+FNoZmiWb3OzMtyt2KwgdJ98j/PrNr4WuI1uctBjMxRFzhrIGq
 sGVGS/lGL2hJtx+AAW+RTbSgmH3+lMc4z7Q/HagjrJziLZfSY+Gel1kYfFV9d/xbHhQrmaUJtBT
 L9iUImSr9hgFw+53fbyyU+EScKK/3dgzIMNbydpHpWoLDgnR7wjTJ/U94Ndkh9SvhdMZh/8WI8P
 JKvitDILHMxSdcjAZgJXwh3N52qSt0GAGHS/631z+9yeIvTBl1d60qtQgMfEhPNMpyWUagt+H2K
 NxGqSS5U1m+2b+T18Wi70ucP2TR5DYKdY3GZMLXJmsuXyyLw+XoIoWdbBKlS83TTI0X5ZfzMVOp
 kglLL2ubodHBpPqi6/Q==
X-Authority-Analysis: v=2.4 cv=b+2CJNGx c=1 sm=1 tr=0 ts=6a060390 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=rf8p9UtI3xT0bhGoYccA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: UJa3WNZ7rUDqSelfCXIj9z3_AaMgvtdT
X-Proofpoint-ORIG-GUID: UJa3WNZ7rUDqSelfCXIj9z3_AaMgvtdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140173
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

efivar.py currently stores authenticated variables including the
EFI_VARIABLE_AUTHENTICATION_2 descriptor (timestamp + WIN_CERTIFICATE)
along with the payload.

When variables are set via U-Boot, SetVariable() validates and strips
this authentication descriptor before persisting the variable data,
resulting in only the payload being stored and returned by GetVariable().

This mismatch causes efivar.py-generated stores to differ from U-Boot
runtime behavior and leads to incorrect GetVariable() results.

Update efivar.py to strip the authentication descriptor and store only
the payload for authenticated variables, ensuring consistency with
U-Boot behavior and compliance with UEFI expectations.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v3:
- Previously stripped the authentication descriptor at GetVariable(),
  now moved to strip it in efivar.py during variable pre-seeding/set.
Link to v2: https://lore.kernel.org/u-boot/20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
- Enhanced commit message with explicit UEFI spec reference
Link to v1: https://lore.kernel.org/u-boot/20250725123653.513252-1-aswin.murugan@oss.qualcomm.com/
---
 tools/efivar.py | 50 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/efivar.py b/tools/efivar.py
index 67729fa8505..d248cd868ba 100755
--- a/tools/efivar.py
+++ b/tools/efivar.py
@@ -79,6 +79,50 @@ class EfiVariable:
 def calc_crc32(buf):
     return zlib.crc32(buf) & 0xffffffff
 
+def strip_auth_descriptor(data, attrs):
+    """
+    Strip the EFI auth descriptor from authenticated variable data.
+
+    This is used during efivar.py-based pre-seeding of ubootefi.var to
+    match U-Boot SetVariable() behavior, where the authentication header
+    is consumed during validation and only the payload is stored.
+
+    For variables with EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS:
+    - Input format: [EFI_VARIABLE_AUTHENTICATION_2 | payload]
+    - Stored format: [payload only]
+
+    Auth header size calculation (aligned with U-Boot efi_variable_authenticate()):
+        auth_size = sizeof(EFI_TIME) + WIN_CERTIFICATE.dwLength
+
+    Only the payload portion is retained after stripping the header.
+    """
+    if not (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS):
+        return data
+    if not data:
+        return data
+
+    efi = EfiStruct()
+    if len(data) < efi.var_time_size:
+        return data
+
+    offset = efi.var_time_size
+    if len(data) < offset + efi.var_win_cert_size:
+        return data
+
+    try:
+        cert_hdr = struct.unpack_from(efi.var_win_cert_fmt, data, offset)
+        dwLength = cert_hdr[0]
+    except struct.error:
+        return data
+
+    auth_size = efi.var_time_size + dwLength
+    if auth_size <= 0 or auth_size > len(data):
+        return data
+
+    if len(data) <= auth_size:
+        return b''
+    return data[auth_size:]
+
 class EfiVariableStore:
     def __init__(self, infile):
         self.infile = infile
@@ -172,8 +216,12 @@ class EfiVariableStore:
                 break
             offs = loffs
 
+        if data and (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS):
+            data = strip_auth_descriptor(data, attrs)
+            size = len(data) if data else 0
+
         tsec = int(time.time()) if attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS else 0
-        nd = name.encode('utf_16_le') + b"\x00\x00" + data
+        nd = name.encode('utf_16_le') + b"\x00\x00" + (data if data else b'')
         # U-Boot variable format requires the name + data blob to be 8-byte aligned
         pad = ((len(nd) + 7) & ~7) - len(nd)
         nd += bytes([0] * pad)
-- 
2.34.1

